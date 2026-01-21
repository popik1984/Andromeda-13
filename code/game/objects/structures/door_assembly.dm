/obj/structure/door_assembly
	name = "airlock assembly"
	desc = "Сборка шлюза."
	gender = FEMALE
	icon = 'icons/obj/doors/airlocks/station/public.dmi'
	icon_state = "construction"
	var/overlays_file = 'icons/obj/doors/airlocks/station/overlays.dmi'
	anchored = FALSE
	density = TRUE
	max_integrity = 200
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4)
	/// Airlock's current construction state
	var/state = AIRLOCK_ASSEMBLY_NEEDS_WIRES
	var/base_name = "шлюз"
	/// Genitive case of base_name for assembly naming (e.g. "шлюза" for "сборка шлюза")
	var/base_name_gen = "шлюза"
	var/created_name = null
	var/mineral = null
	var/obj/item/electronics/airlock/electronics = null
	/// Do we perform the extra checks required for multi-tile (large) airlocks
	var/multi_tile = FALSE
	/// The type path of the airlock once completed (solid version)
	var/airlock_type = /obj/machinery/door/airlock
	/// The type path of the airlock once completed (glass version)
	var/glass_type = /obj/machinery/door/airlock/glass
	/// FALSE = glass can be installed. TRUE = glass is already installed.
	var/glass = FALSE
	/// Whether to heat-proof the finished airlock
	var/heat_proof_finished = FALSE
	/// If you're changing the airlock material, what is the previous type
	var/previous_assembly = /obj/structure/door_assembly
	/// Airlocks with no glass version, also cannot be modified with sheets
	var/noglass = FALSE
	/// Airlock with glass version, but cannot be modified with sheets
	var/nomineral = FALSE
	/// What type of material the airlock drops when deconstructed
	var/material_type = /obj/item/stack/sheet/iron
	/// Amount of material the airlock drops when deconstructed
	var/material_amt = 4

/obj/structure/door_assembly/get_ru_names()
	return alist(
		NOMINATIVE = "сборка шлюза",
		GENITIVE = "сборки шлюза",
		DATIVE = "сборке шлюза",
		ACCUSATIVE = "сборку шлюза",
		INSTRUMENTAL = "сборкой шлюза",
		PREPOSITIONAL = "сборке шлюза",
	)

/obj/structure/door_assembly/multi_tile
	name = "large airlock assembly"
	icon = 'icons/obj/doors/airlocks/multi_tile/public/glass.dmi'
	overlays_file = 'icons/obj/doors/airlocks/multi_tile/public/overlays.dmi'
	base_name = "большой шлюз"
	base_name_gen = "большого шлюза"
	glass_type = /obj/machinery/door/airlock/multi_tile/public/glass
	airlock_type = /obj/machinery/door/airlock/multi_tile/public/glass
	dir = EAST
	multi_tile = TRUE
	glass = TRUE
	nomineral = TRUE
	material_amt = 8

/obj/structure/door_assembly/multi_tile/get_ru_names()
	return alist(
		NOMINATIVE = "сборка большого шлюза",
		GENITIVE = "сборки большого шлюза",
		DATIVE = "сборке большого шлюза",
		ACCUSATIVE = "сборку большого шлюза",
		INSTRUMENTAL = "сборкой большого шлюза",
		PREPOSITIONAL = "сборке большого шлюза",
	)

/obj/structure/door_assembly/Initialize(mapload)
	. = ..()
	obj_flags |= UNIQUE_RENAME | RENAME_NO_DESC
	update_appearance()
	update_name()

/obj/structure/door_assembly/multi_tile/Initialize(mapload)
	. = ..()
	set_bounds()
	update_overlays()

/obj/structure/door_assembly/multi_tile/Move()
	. = ..()
	set_bounds()

/obj/structure/door_assembly/examine(mob/user)
	. = ..()
	switch(state)
		if(AIRLOCK_ASSEMBLY_NEEDS_WIRES)
			if(anchored)
				. += span_notice("Анкерные болты <b>закручены</b>, но в технической панели нет <i>проводов</i>.")
			else
				. += span_notice("Сборка <b>сварена</b>, но анкерные болты <i>откручены</i>.")
		if(AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS)
			. += span_notice("Техническая панель <b>подключена проводами</b>, но слот для микросхем <i>пуст</i>.")
		if(AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER)
			. += span_notice("Микросхема <b>свободно подключена</b> к разъёму, но техническая панель <i>откручена и открыта</i>.")
	if(!mineral && !nomineral && !glass && !noglass)
		. += span_notice("Есть <i>пустые</i> слоты для стеклянных окон и покрытия из материалов.")
	else if(!mineral && !nomineral && glass && !noglass)
		. += span_notice("Есть <i>пустые</i> слоты для покрытия из материалов.")
	else if(!glass && !noglass)
		. += span_notice("Есть <i>пустые</i> слоты для стеклянных окон.")
	if(created_name)
		. += span_notice("На сборке есть маленькая <i>бумажная</i> табличка, на ней написано '[created_name]'.")

/obj/structure/door_assembly/attackby(obj/item/tool, mob/living/user, list/modifiers, list/attack_modifiers)
	if((tool.tool_behaviour == TOOL_WELDER) && (mineral || glass || !anchored ))
		if(!tool.tool_start_check(user, amount=1))
			return

		if(mineral)
			var/obj/item/stack/sheet/mineral/mineral_path = text2path("/obj/item/stack/sheet/mineral/[mineral]")
			user.visible_message(span_notice("[user] срезает покрытие из [mineral] со сборки шлюза."), span_notice("Вы начинаете срезать покрытие из [mineral] со сборки шлюза..."))
			if(tool.use_tool(src, user, 40, volume=50))
				to_chat(user, span_notice("Вы срезаете покрытие из [mineral]."))
				new mineral_path(loc, 2)
				var/obj/structure/door_assembly/PA = new previous_assembly(loc)
				transfer_assembly_vars(src, PA)

		else if(glass)
			user.visible_message(span_notice("[user] вырезает стеклянную панель из сборки шлюза."), span_notice("Вы начинаете вырезать стеклянную панель из сборки шлюза..."))
			if(tool.use_tool(src, user, 40, volume=50))
				to_chat(user, span_notice("Вы вырезаете стеклянную панель."))
				if(heat_proof_finished)
					new /obj/item/stack/sheet/rglass(get_turf(src))
					heat_proof_finished = FALSE
				else
					new /obj/item/stack/sheet/glass(get_turf(src))
				glass = 0
		else if(!anchored)
			user.visible_message(span_warning("[user] разбирает сборку шлюза."), \
								span_notice("Вы начинаете разбирать сборку шлюза..."))
			if(tool.use_tool(src, user, 40, volume=50))
				to_chat(user, span_notice("Вы разбираете сборку шлюза."))
				deconstruct(TRUE)

	else if(tool.tool_behaviour == TOOL_WRENCH)
		if(!anchored )
			var/door_check = 1
			for(var/obj/machinery/door/D in loc)
				if(!D.sub_door)
					door_check = 0
					break

			if(door_check)
				user.visible_message(span_notice("[user] прикручивает сборку шлюза к полу."), \
					span_notice("Вы начинаете прикручивать сборку шлюза к полу..."), \
					span_hear("Слышен звук гаечного ключа."))

				if(tool.use_tool(src, user, 40, volume=100))
					if(anchored)
						return
					to_chat(user, span_notice("Вы прикручиваете сборку шлюза."))
					name = "secured airlock assembly" // This gets updated by update_name() immediately anyway
					set_anchored(TRUE)
			else
				to_chat(user, "Здесь есть другая дверь!")

		else
			user.visible_message(span_notice("[user] откручивает сборку шлюза от пола."), \
				span_notice("Вы начинаете откручивать сборку шлюза от пола..."), \
				span_hear("Слышен звук гаечного ключа."))
			if(tool.use_tool(src, user, 40, volume=100))
				if(!anchored)
					return
				to_chat(user, span_notice("Вы откручиваете сборку шлюза."))
				name = "airlock assembly"
				set_anchored(FALSE)

	else if(istype(tool, /obj/item/stack/cable_coil) && state == AIRLOCK_ASSEMBLY_NEEDS_WIRES && anchored )
		if(!tool.tool_start_check(user, amount=1))
			return

		user.visible_message(span_notice("[user] проводит проводку в сборку шлюза."), \
							span_notice("Вы начинаете проводить проводку в сборку шлюза..."))
		if(tool.use_tool(src, user, 40, amount=1))
			if(state != AIRLOCK_ASSEMBLY_NEEDS_WIRES)
				return
			state = AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS
			to_chat(user, span_notice("Вы проводите проводку в сборку шлюза."))
			name = "wired airlock assembly"

	else if((tool.tool_behaviour == TOOL_WIRECUTTER) && state == AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS )
		user.visible_message(span_notice("[user] обрезает провода в сборке шлюза."), \
							span_notice("Вы начинаете обрезать провода в сборке шлюза..."))

		if(tool.use_tool(src, user, 40, volume=100))
			if(state != AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS)
				return
			to_chat(user, span_notice("Вы обрезаете провода в сборке шлюза."))
			new/obj/item/stack/cable_coil(get_turf(user), 1)
			state = AIRLOCK_ASSEMBLY_NEEDS_WIRES
			name = "secured airlock assembly"

	else if(istype(tool, /obj/item/electronics/airlock) && state == AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS )
		tool.play_tool_sound(src, 100)
		user.visible_message(span_notice("[user] устанавливает электронику в сборку шлюза."), \
							span_notice("Вы начинаете устанавливать электронику в сборку шлюза..."))
		if(do_after(user, 4 SECONDS, target = src))
			if( state != AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS )
				return
			if(!user.transferItemToLoc(tool, src))
				return

			to_chat(user, span_notice("Вы устанавливаете электронику шлюза."))
			state = AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER
			name = "near finished airlock assembly"
			electronics = tool


	else if((tool.tool_behaviour == TOOL_CROWBAR) && state == AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER )
		user.visible_message(span_notice("[user] вынимает электронику из сборки шлюза."), \
								span_notice("Вы начинаете вынимать электронику из сборки шлюза..."))

		if(tool.use_tool(src, user, 40, volume=100))
			if(state != AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER)
				return
			to_chat(user, span_notice("Вы вынимаете электронику шлюза."))
			state = AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS
			name = "wired airlock assembly"
			var/obj/item/electronics/airlock/ae
			if (!electronics)
				ae = new/obj/item/electronics/airlock( loc )
			else
				ae = electronics
				electronics = null
				ae.forceMove(src.loc)

	else if(istype(tool, /obj/item/stack/sheet))
		var/obj/item/stack/sheet/sheet = tool
		if(!glass && (istype(sheet, /obj/item/stack/sheet/rglass) || istype(sheet, /obj/item/stack/sheet/glass)))
			if(noglass)
				to_chat(user, span_warning("Вы не можете добавить [sheet] к [RU_SRC_DAT]!"))
				return
			playsound(src, 'sound/items/tools/crowbar.ogg', 100, TRUE)
			user.visible_message(span_notice("[user] добавляет [sheet.name] в сборку шлюза."), \
								span_notice("Вы начинаете устанавливать [sheet.name] в сборку шлюза..."))
			if(do_after(user, 4 SECONDS, target = src))
				if(sheet.get_amount() < 1 || glass)
					return
				if(sheet.type == /obj/item/stack/sheet/rglass)
					to_chat(user, span_notice("Вы устанавливаете окна из [sheet.name] в сборку шлюза."))
					heat_proof_finished = 1 //reinforced glass makes the airlock heat-proof
					name = "near finished heat-proofed window airlock assembly"
				else
					to_chat(user, span_notice("Вы устанавливаете окна из обычного стекла в сборку шлюза."))
					name = "near finished window airlock assembly"
				sheet.use(1)
				glass = TRUE
			return

		if(istype(sheet, /obj/item/stack/sheet/mineral) && sheet.construction_path_type)
			if(nomineral || mineral)
				to_chat(user, span_warning("Вы не можете добавить [sheet] к [RU_SRC_DAT]!"))
				return

			var/M = sheet.construction_path_type
			var/mineralassembly = text2path("/obj/structure/door_assembly/door_assembly_[M]")
			if(!ispath(mineralassembly))
				to_chat(user, span_warning("Вы не можете добавить [sheet] к [RU_SRC_DAT]!"))
				return
			if(sheet.get_amount() < 2)
				to_chat(user, span_warning("Вам нужно как минимум два листа, чтобы добавить покрытие из материала!"))
				return

			playsound(src, 'sound/items/tools/crowbar.ogg', 100, TRUE)
			user.visible_message(span_notice("[user] добавляет [sheet.name] в сборку шлюза."), \
				span_notice("Вы начинаете устанавливать [sheet.name] в сборку шлюза..."))
			if(!do_after(user, 4 SECONDS, target = src) || sheet.get_amount() < 2 || mineral)
				return
			to_chat(user, span_notice("Вы устанавливаете покрытие из [M] в сборку шлюза."))
			sheet.use(2)
			var/obj/structure/door_assembly/MA = new mineralassembly(loc)

			if(MA.noglass && glass) //in case the new door doesn't support glass. prevents the new one from reverting to a normal airlock after being constructed.
				var/obj/item/stack/sheet/dropped_glass
				if(heat_proof_finished)
					dropped_glass = new /obj/item/stack/sheet/rglass(drop_location())
					heat_proof_finished = FALSE
				else
					dropped_glass = new /obj/item/stack/sheet/glass(drop_location())
				glass = FALSE
				to_chat(user, span_notice("Когда вы заканчиваете, [dropped_glass.singular_name] выпадает из рамы [MA]."))

			transfer_assembly_vars(src, MA, TRUE)

	else if((tool.tool_behaviour == TOOL_SCREWDRIVER) && state == AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER )
		user.visible_message(span_notice("[user] заканчивает шлюз."), \
			span_notice("Вы начинаете заканчивать шлюз..."))

		if(tool.use_tool(src, user, 40, volume=100))
			if(loc && state == AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER)
				to_chat(user, span_notice("Вы заканчиваете шлюз."))
				finish_door()
	else
		return ..()
	update_name()
	update_appearance()

/obj/structure/door_assembly/proc/finish_door()
	var/obj/machinery/door/airlock/door
	if(glass)
		door = new glass_type( loc )
	else
		door = new airlock_type( loc )
	door.setDir(dir)
	door.unres_sides = electronics.unres_sides
	door.electronics = electronics
	door.heat_proof = heat_proof_finished
	door.security_level = 0
	if(electronics.shell)
		door.AddComponent( \
			/datum/component/shell, \
			unremovable_circuit_components = list(new /obj/item/circuit_component/airlock, new /obj/item/circuit_component/airlock_access_event, new /obj/item/circuit_component/remotecam/airlock), \
			capacity = SHELL_CAPACITY_LARGE, \
			shell_flags = SHELL_FLAG_ALLOW_FAILURE_ACTION|SHELL_FLAG_REQUIRE_ANCHOR \
		)
	if(electronics.one_access)
		door.req_one_access = electronics.accesses
	else
		door.req_access = electronics.accesses
	if(created_name)
		door.name = created_name
	else if(electronics.passed_name)
		door.name = sanitize(electronics.passed_name)
	else
		door.name = capitalize(base_name)
	if(electronics.passed_cycle_id)
		door.closeOtherId = electronics.passed_cycle_id
		door.update_other_id()
	if(door.unres_sides)
		door.unres_latch = TRUE
	door.previous_airlock = previous_assembly
	electronics.forceMove(door)
	door.autoclose = TRUE
	door.close()
	door.update_appearance()

	qdel(src)
	return door

/obj/structure/door_assembly/update_overlays()
	. = ..()
	if(!glass)
		. += get_airlock_overlay("fill_construction", icon, src, TRUE)
	else
		. += get_airlock_overlay("glass_construction", overlays_file, src, TRUE)
	. += get_airlock_overlay("panel_c[state+1]", overlays_file, src, TRUE)

/obj/structure/door_assembly/update_name()
	name = ""
	switch(state)
		if(AIRLOCK_ASSEMBLY_NEEDS_WIRES)
			if(anchored)
				name = "закреплённая "
		if(AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS)
			name = "подключённая "
		if(AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER)
			name = "почти готовая "
	name += "[heat_proof_finished ? "термостойкая " : ""][glass ? "остеклённая " : ""]сборка [base_name_gen]"
	return ..()

/obj/structure/door_assembly/proc/transfer_assembly_vars(obj/structure/door_assembly/source, obj/structure/door_assembly/target, previous = FALSE)
	target.glass = source.glass
	target.heat_proof_finished = source.heat_proof_finished
	target.created_name = source.created_name
	target.state = source.state
	target.set_anchored(source.anchored)
	if(previous)
		target.previous_assembly = source.type
	if(electronics)
		target.electronics = source.electronics
		source.electronics.forceMove(target)
	target.update_appearance()
	target.update_name()
	qdel(source)

/obj/structure/door_assembly/atom_deconstruct(disassembled = TRUE)
	var/turf/target_turf = get_turf(src)
	if(!disassembled)
		material_amt = rand(2,4)
	new material_type(target_turf, material_amt)
	if(glass)
		if(disassembled)
			if(heat_proof_finished)
				new /obj/item/stack/sheet/rglass(target_turf)
			else
				new /obj/item/stack/sheet/glass(target_turf)
		else
			new /obj/item/shard(target_turf)
	if(mineral)
		var/obj/item/stack/sheet/mineral/mineral_path = text2path("/obj/item/stack/sheet/mineral/[mineral]")
		new mineral_path(target_turf, 2)

/obj/structure/door_assembly/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	if(the_rcd.mode == RCD_DECONSTRUCT)
		return list("delay" = 5 SECONDS, "cost" = 16)
	return FALSE

/obj/structure/door_assembly/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, list/rcd_data)
	if(rcd_data[RCD_DESIGN_MODE] == RCD_DECONSTRUCT)
		qdel(src)
		return TRUE
	return FALSE

/obj/structure/door_assembly/nameformat(input, mob/living/user)
	created_name = input
	return input

/obj/structure/door_assembly/rename_reset()
	created_name = null
