#define ELECTROLYZER_MODE_STANDBY "standby"
#define ELECTROLYZER_MODE_WORKING "working"

/obj/machinery/electrolyzer
	anchored = FALSE
	density = TRUE
	interaction_flags_machine = INTERACT_MACHINE_ALLOW_SILICON | INTERACT_MACHINE_OPEN
	icon = 'icons/obj/pipes_n_cables/atmos.dmi'
	icon_state = "electrolyzer-off"
	name = "space electrolyzer"
	desc = "Благодаря быстрой и динамичной реакции наших электролизёров производство водорода на месте гарантировано. Гарантия аннулируется при использовании клоунами."
	max_integrity = 250
	armor_type = /datum/armor/machinery_electrolyzer
	circuit = /obj/item/circuitboard/machine/electrolyzer
	/// We don't use area power, we always use the cell
	use_power = NO_POWER_USE
	///used to check if there is a cell in the machine
	var/obj/item/stock_parts/power_store/cell
	///check if the machine is on or off
	var/on = FALSE
	///check what mode the machine should be (WORKING, STANDBY)
	var/mode = ELECTROLYZER_MODE_STANDBY
	///Increase the amount of moles worked on, changed by upgrading the manipulator tier
	var/working_power = 1
	///Decrease the amount of power usage, changed by upgrading the capacitor tier
	var/efficiency = 0.5

/datum/armor/machinery_electrolyzer
	fire = 80
	acid = 10

/obj/machinery/electrolyzer/get_ru_names()
	return list(
		NOMINATIVE = "космический электролизёр",
		GENITIVE = "космического электролизёра",
		DATIVE = "космическому электролизёру",
		ACCUSATIVE = "космический электролизёр",
		INSTRUMENTAL = "космическим электролизёром",
		PREPOSITIONAL = "космическом электролизере",
	)

/obj/machinery/electrolyzer/get_cell()
	return cell

/obj/machinery/electrolyzer/Initialize(mapload)
	. = ..()
	if(ispath(cell))
		cell = new cell(src)
	SSair.start_processing_machine(src)
	update_appearance(UPDATE_ICON)
	register_context()

/obj/machinery/electrolyzer/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	context[SCREENTIP_CONTEXT_ALT_LMB] = "[on ? "Выключить" : "Включить"]"
	if(!held_item)
		return CONTEXTUAL_SCREENTIP_SET
	switch(held_item.tool_behaviour)
		if(TOOL_SCREWDRIVER)
			context[SCREENTIP_CONTEXT_LMB] = "[panel_open ? "Закрыть" : "Открыть"] панель"
		if(TOOL_WRENCH)
			context[SCREENTIP_CONTEXT_LMB] = "[anchored ? "Открутить" : "Прикрутить"]"
	return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/electrolyzer/Destroy()
	if(cell)
		QDEL_NULL(cell)
	return ..()

/obj/machinery/electrolyzer/on_deconstruction(disassembled)
	if(cell)
		LAZYADD(component_parts, cell)
		cell = null
	return ..()

/obj/machinery/electrolyzer/examine(mob/user)
	. = ..()
	. += "[declent_ru(NOMINATIVE)] [on ? "включён" : "выключен"], а панель [panel_open ? "открыта" : "закрыта"]."

	if(cell)
		. += "Индикатор заряда показывает [cell ? round(cell.percent(), 1) : 0]%."
	else
		. += "Энергоячейка отсутствует."
	if(in_range(user, src) || isobserver(user))
		. += span_notice("<b>Альт-клик</b>, чтобы [on ? "выключить" : "включить"].")
		. += span_notice("<b>Прикрутите</b>, чтобы питать от ЛКП вместо ячейки.")
	. += span_notice("Он будет потреблять энергию от [anchored ? "ЛКП отсека" : "внутренней энергоячейки"].")


/obj/machinery/electrolyzer/update_icon_state()
	icon_state = "electrolyzer-[on ? "[mode]" : "off"]"
	return ..()

/obj/machinery/electrolyzer/update_overlays()
	. = ..()
	if(panel_open)
		. += "electrolyzer-open"

/obj/machinery/electrolyzer/process_atmos()

	if(!is_operational && on)
		on = FALSE
	if(!on)
		return PROCESS_KILL

	if((!cell || cell.charge <= 0) && !anchored)
		on = FALSE
		update_appearance(UPDATE_ICON)
		return PROCESS_KILL

	var/turf/our_turf = loc
	if(!istype(our_turf))
		if(mode != ELECTROLYZER_MODE_STANDBY)
			mode = ELECTROLYZER_MODE_STANDBY
			update_appearance(UPDATE_ICON)
		return

	var/new_mode = on ? ELECTROLYZER_MODE_WORKING : ELECTROLYZER_MODE_STANDBY //change the mode to working if the machine is on

	if(mode != new_mode) //check if the mode is set correctly
		mode = new_mode
		update_appearance(UPDATE_ICON)

	if(mode == ELECTROLYZER_MODE_STANDBY)
		return

	var/datum/gas_mixture/env = our_turf.return_air() //get air from the turf

	if(!env)
		return

	call_reactions(env)

	air_update_turf(FALSE, FALSE)

	var/power_to_use = (5 * (3 * working_power) * working_power) / (efficiency + working_power)
	if(anchored)
		use_energy(power_to_use)
	else
		cell.use(power_to_use)

/obj/machinery/electrolyzer/proc/call_reactions(datum/gas_mixture/env)
	env.electrolyze(working_power = working_power)

/obj/machinery/electrolyzer/RefreshParts()
	. = ..()
	var/power = 0
	var/cap = 0
	for(var/datum/stock_part/servo/servo in component_parts)
		power += servo.tier
	for(var/datum/stock_part/capacitor/capacitor in component_parts)
		cap += capacitor.tier

	working_power = power //used in the amount of moles processed

	efficiency = (cap + 1) * 0.5 //used in the amount of charge in power cell uses

/obj/machinery/electrolyzer/screwdriver_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src, 50)
	toggle_panel_open()
	balloon_alert(user, "панель [panel_open ? "открыта" : "закрыта"]")
	update_appearance(UPDATE_ICON)
	return TRUE

/obj/machinery/electrolyzer/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	default_unfasten_wrench(user, tool)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/electrolyzer/crowbar_act(mob/living/user, obj/item/tool)
	return default_deconstruction_crowbar(tool)

/obj/machinery/electrolyzer/attackby(obj/item/I, mob/user, list/modifiers, list/attack_modifiers)
	add_fingerprint(user)
	if(istype(I, /obj/item/stock_parts/power_store/cell))
		if(!panel_open)
			balloon_alert(user, "откройте панель!")
			return
		if(cell)
			balloon_alert(user, "ячейка уже внутри!")
			return
		if(!user.transferItemToLoc(I, src))
			return
		cell = I
		I.add_fingerprint(usr)
		balloon_alert(user, "ячейка вставлена")
		SStgui.update_uis(src)

		return
	return ..()

/obj/machinery/electrolyzer/click_alt(mob/user)
	if(panel_open)
		balloon_alert(user, "закройте панель!")
		return CLICK_ACTION_BLOCKING
	toggle_power(user)
	return CLICK_ACTION_SUCCESS

/obj/machinery/electrolyzer/proc/toggle_power(mob/user)
	if(!anchored && !cell)
		balloon_alert(user, "вставьте ячейку или прикрутите!")
		return
	on = !on
	mode = ELECTROLYZER_MODE_STANDBY
	update_appearance(UPDATE_ICON)
	balloon_alert(user, "[on ? "включено" : "выключено"]")
	if(on)
		SSair.start_processing_machine(src)

/obj/machinery/electrolyzer/ui_state(mob/user)
	return GLOB.physical_state

/obj/machinery/electrolyzer/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Electrolyzer", name)
		ui.open()

/obj/machinery/electrolyzer/ui_data()
	var/list/data = list()
	data["open"] = panel_open
	data["on"] = on
	data["hasPowercell"] = !isnull(cell)
	data["anchored"] = anchored
	if(cell)
		data["powerLevel"] = round(cell.percent(), 1)
	return data

/obj/machinery/electrolyzer/ui_act(action, params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("power")
			toggle_power(ui.user)
			. = TRUE
		if("eject")
			if(panel_open && cell)
				cell.forceMove(drop_location())
				cell = null
				. = TRUE

#undef ELECTROLYZER_MODE_STANDBY
#undef ELECTROLYZER_MODE_WORKING
