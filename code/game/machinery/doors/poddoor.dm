/obj/machinery/door/poddoor
	name = "blast door"
	desc = "Тяжёлый гермозатвор, открывающийся механически."
	gender = MALE
	icon = 'icons/obj/doors/blastdoor.dmi'
	icon_state = "closed"
	layer = BLASTDOOR_LAYER
	closingLayer = CLOSED_BLASTDOOR_LAYER
	sub_door = TRUE
	explosion_block = 3
	heat_proof = TRUE
	safe = FALSE
	max_integrity = 600
	armor_type = /datum/armor/door_poddoor
	resistance_flags = FIRE_PROOF
	damage_deflection = 70
	can_open_with_hands = FALSE
	custom_materials = list(/datum/material/alloy/plasteel = SHEET_MATERIAL_AMOUNT * 15, /datum/material/iron = SMALL_MATERIAL_AMOUNT * 2, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)
	/// The recipe for this door
	var/datum/crafting_recipe/recipe_type = /datum/crafting_recipe/blast_doors
	/// The current deconstruction step
	var/deconstruction = BLASTDOOR_FINISHED
	/// The door's ID (used for buttons, etc to control the door)
	var/id = null
	/// The sound that plays when the door opens/closes
	var/animation_sound = 'sound/machines/blastdoor.ogg'
	var/show_nav_computer_icon = TRUE
	///The mob who crafted this blastdoor
	var/datum/weakref/owner

/obj/machinery/door/poddoor/get_ru_names()
	return alist(
		NOMINATIVE = "гермозатвор",
		GENITIVE = "гермозатвора",
		DATIVE = "гермозатвору",
		ACCUSATIVE = "гермозатвор",
		INSTRUMENTAL = "гермозатвором",
		PREPOSITIONAL = "гермозатворе",
	)

/obj/machinery/door/poddoor/Initialize(mapload)
	. = ..()
	if(show_nav_computer_icon)
		AddElement(/datum/element/nav_computer_icon, 'icons/effects/nav_computer_indicators.dmi', "airlock", TRUE)

/obj/machinery/door/poddoor/Destroy()
	owner = null
	return ..()

/datum/armor/door_poddoor
	melee = 50
	bullet = 100
	laser = 100
	energy = 100
	bomb = 50
	fire = 100
	acid = 70

/obj/machinery/door/poddoor/get_save_vars()
	return ..() + NAMEOF(src, id)

/obj/machinery/door/poddoor/examine(mob/user)
	. = ..()
	if(panel_open)
		if(deconstruction == BLASTDOOR_FINISHED)
			. += span_notice("Техническая панель открыта, электронику можно <b>вынуть</b>.")
			. += span_notice("[RU_SRC_NOM] может быть откалиброван под ID контроллера гермозатворов с помощью <b>контроллера гермозатворов</b>.")
		else if(deconstruction == BLASTDOOR_NEEDS_ELECTRONICS)
			. += span_notice("<i>Электроника</i> отсутствует, и торчат <b>провода</b>.")
		else if(deconstruction == BLASTDOOR_NEEDS_WIRES)
			. += span_notice("<i>Провода</i> удалены, и он готов к <b>разрезанию</b>.")

/obj/machinery/door/poddoor/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(isnull(held_item))
		return NONE
	if(deconstruction == BLASTDOOR_NEEDS_WIRES && istype(held_item, /obj/item/stack/cable_coil))
		context[SCREENTIP_CONTEXT_LMB] = "Проложить провода"
		return CONTEXTUAL_SCREENTIP_SET
	if(deconstruction == BLASTDOOR_NEEDS_ELECTRONICS && istype(held_item, /obj/item/electronics/airlock))
		context[SCREENTIP_CONTEXT_LMB] = "Добавить электронику"
		return CONTEXTUAL_SCREENTIP_SET
	if(deconstruction == BLASTDOOR_FINISHED && istype(held_item, /obj/item/assembly/control))
		context[SCREENTIP_CONTEXT_LMB] = "Калибровать ID"
		return CONTEXTUAL_SCREENTIP_SET
	//we do not check for special effects like if they can actually perform the action because they will be told they can't do it when they try,
	//with feedback on what they have to do in order to do so.
	switch(held_item.tool_behaviour)
		if(TOOL_SCREWDRIVER)
			context[SCREENTIP_CONTEXT_LMB] = "Открыть панель"
			return CONTEXTUAL_SCREENTIP_SET
		if(TOOL_CROWBAR)
			context[SCREENTIP_CONTEXT_LMB] = "Вынуть электронику"
			return CONTEXTUAL_SCREENTIP_SET
		if(TOOL_WIRECUTTER)
			context[SCREENTIP_CONTEXT_LMB] = "Удалить провода"
			return CONTEXTUAL_SCREENTIP_SET
		if(TOOL_WELDER)
			context[SCREENTIP_CONTEXT_LMB] = "Разобрать"
			return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/door/poddoor/on_craft_completion(list/components, datum/crafting_recipe/current_recipe, atom/crafter)
	. = ..()
	owner = WEAKREF(crafter)

/obj/machinery/door/poddoor/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(deconstruction == BLASTDOOR_NEEDS_WIRES && istype(tool, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/coil = tool
		var/datum/crafting_recipe/recipe = locate(recipe_type) in GLOB.crafting_recipes
		var/amount_needed = recipe.reqs[/obj/item/stack/cable_coil]
		if(coil.get_amount() < amount_needed)
			balloon_alert(user, "недостаточно кабеля!")
			return ITEM_INTERACT_SUCCESS
		balloon_alert(user, "добавление кабелей...")
		if(!do_after(user, 5 SECONDS, src))
			return ITEM_INTERACT_SUCCESS
		coil.use(amount_needed)
		deconstruction = BLASTDOOR_NEEDS_ELECTRONICS
		balloon_alert(user, "кабели добавлены")
		return ITEM_INTERACT_SUCCESS

	if(deconstruction == BLASTDOOR_NEEDS_ELECTRONICS && istype(tool, /obj/item/electronics/airlock))
		balloon_alert(user, "добавление электроники...")
		if(!do_after(user, 10 SECONDS, src))
			return ITEM_INTERACT_SUCCESS
		qdel(tool)
		balloon_alert(user, "электроника добавлена")
		deconstruction = BLASTDOOR_FINISHED
		return ITEM_INTERACT_SUCCESS

	if(deconstruction == BLASTDOOR_FINISHED && istype(tool, /obj/item/assembly/control))
		if(density)
			balloon_alert(user, "сначала откройте дверь!")
			return ITEM_INTERACT_BLOCKING
		if(!panel_open)
			balloon_alert(user, "сначала откройте панель!")
			return ITEM_INTERACT_BLOCKING
		var/obj/item/assembly/control/controller_item = tool
		if(controller_item.id == -1)
			//collect existing ids
			var/list/door_ids = list()
			for(var/obj/machinery/door/poddoor/M as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/door/poddoor))
				if(!M.id || (M.id in door_ids))
					continue
				door_ids += "[M.id]"

			//create new id
			var/new_id = 0
			while("[new_id]" in door_ids)
				new_id += 1
			controller_item.id = "[new_id]"
		id = controller_item.id
		owner = WEAKREF(user)
		balloon_alert(user, "id изменён на [id]")
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/machinery/door/poddoor/screwdriver_act(mob/living/user, obj/item/tool)
	. = ..()
	if (density)
		balloon_alert(user, "сначала откройте дверь!")
		return ITEM_INTERACT_SUCCESS
	else if (default_deconstruction_screwdriver(user, icon_state, icon_state, tool))
		return ITEM_INTERACT_SUCCESS

/obj/machinery/door/poddoor/crowbar_act(mob/living/user, obj/item/tool)
	. = ..()
	if(machine_stat & NOPOWER)
		open(TRUE)
		return ITEM_INTERACT_SUCCESS
	if (density)
		balloon_alert(user, "сначала откройте дверь!")
		return ITEM_INTERACT_SUCCESS
	if (!panel_open)
		balloon_alert(user, "сначала откройте панель!")
		return ITEM_INTERACT_SUCCESS
	if (deconstruction != BLASTDOOR_FINISHED)
		return
	balloon_alert(user, "извлечение электроники шлюза...")
	if(tool.use_tool(src, user, 10 SECONDS, volume = 50))
		new /obj/item/electronics/airlock(loc)
		id = null
		owner = null
		deconstruction = BLASTDOOR_NEEDS_ELECTRONICS
		balloon_alert(user, "электроника шлюза извлечена")
	return ITEM_INTERACT_SUCCESS

/obj/machinery/door/poddoor/wirecutter_act(mob/living/user, obj/item/tool)
	. = ..()
	if (density)
		balloon_alert(user, "сначала откройте дверь!")
		return ITEM_INTERACT_SUCCESS
	if (!panel_open)
		balloon_alert(user, "сначала откройте панель!")
		return ITEM_INTERACT_SUCCESS
	if (deconstruction != BLASTDOOR_NEEDS_ELECTRONICS)
		return
	balloon_alert(user, "удаление внутренней проводки...")
	if(tool.use_tool(src, user, 10 SECONDS, volume = 50))
		var/datum/crafting_recipe/recipe = locate(recipe_type) in GLOB.crafting_recipes
		var/amount = recipe.reqs[/obj/item/stack/cable_coil]
		new /obj/item/stack/cable_coil(loc, amount)
		deconstruction = BLASTDOOR_NEEDS_WIRES
		balloon_alert(user, "внутренняя проводка удалена")
	return ITEM_INTERACT_SUCCESS

/obj/machinery/door/poddoor/welder_act(mob/living/user, obj/item/tool)
	. = ..()
	if (density)
		balloon_alert(user, "сначала откройте дверь!")
		return ITEM_INTERACT_SUCCESS
	if (!panel_open)
		balloon_alert(user, "сначала откройте панель!")
		return ITEM_INTERACT_SUCCESS
	if (deconstruction != BLASTDOOR_NEEDS_WIRES)
		return
	balloon_alert(user, "разрезание...") //You're tearing me apart, Lisa!
	if(tool.use_tool(src, user, 15 SECONDS, volume = 50))
		var/datum/crafting_recipe/recipe = locate(recipe_type) in GLOB.crafting_recipes
		var/amount = recipe.reqs[/obj/item/stack/sheet/plasteel]
		new /obj/item/stack/sheet/plasteel(loc, amount)
		user.balloon_alert(user, "разрезан на части")
		qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/door/poddoor/connect_to_shuttle(mapload, obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	id = "[port.shuttle_id]_[id]"

//"BLAST" doors are obviously stronger than regular doors when it comes to BLASTS.
/obj/machinery/door/poddoor/ex_act(severity, target)
	if(severity <= EXPLODE_LIGHT)
		return FALSE
	return ..()

/obj/machinery/door/poddoor/update_icon_state()
	. = ..()
	switch(animation)
		if(DOOR_OPENING_ANIMATION)
			icon_state = "opening"
		if(DOOR_CLOSING_ANIMATION)
			icon_state = "closing"
		if(DOOR_DENY_ANIMATION)
			icon_state = "deny"
		else
			icon_state = density ? "closed" : "open"

/obj/machinery/door/poddoor/animation_length(animation)
	switch(animation)
		if(DOOR_OPENING_ANIMATION)
			return 1.1 SECONDS
		if(DOOR_CLOSING_ANIMATION)
			return 1.1 SECONDS

/obj/machinery/door/poddoor/animation_segment_delay(animation)
	switch(animation)
		if(DOOR_OPENING_PASSABLE)
			return 0.5 SECONDS
		if(DOOR_OPENING_FINISHED)
			return 1.1 SECONDS
		if(DOOR_CLOSING_UNPASSABLE)
			return 0.2 SECONDS
		if(DOOR_CLOSING_FINISHED)
			return 1.1 SECONDS

/obj/machinery/door/poddoor/animation_effects(animation)
	switch(animation)
		if(DOOR_OPENING_ANIMATION)
			playsound(src, animation_sound, 50, TRUE)
		if(DOOR_CLOSING_ANIMATION)
			playsound(src, animation_sound, 50, TRUE)

/obj/machinery/door/poddoor/attack_alien(mob/living/carbon/alien/adult/user, list/modifiers)
	if(density & !(resistance_flags & INDESTRUCTIBLE))
		add_fingerprint(user)
		user.visible_message(span_warning("[user] начинает вскрывать [RU_SRC_NOM]."),\
					span_noticealien("Вы начинаете вгрызаться когтями в [RU_SRC_NOM] изо всех сил!"),\
					span_warning("Слышен скрежет металла..."))
		playsound(src, 'sound/machines/airlock/airlock_alien_prying.ogg', 100, TRUE)

		var/time_to_open = 5 SECONDS
		if(hasPower())
			time_to_open = 15 SECONDS

		if(do_after(user, time_to_open, src))
			if(density && !open(TRUE)) //The airlock is still closed, but something prevented it opening. (Another player noticed and bolted/welded the airlock in time!)
				to_chat(user, span_warning("Несмотря на ваши усилия, [RU_SRC_NOM] смог устоять перед попытками открыть его!"))

	else
		return ..()

/obj/machinery/door/poddoor/preopen
	icon_state = "open"
	density = FALSE
	opacity = FALSE

/obj/machinery/door/poddoor/ert
	name = "hardened blast door"
	desc = "Сверхтяжёлый гермозатвор, который открывается только в крайних случаях."
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/machinery/door/poddoor/ert/get_ru_names()
	return alist(
		NOMINATIVE = "укреплённый гермозатвор",
		GENITIVE = "укреплённого гермозатвора",
		DATIVE = "укреплённому гермозатвору",
		ACCUSATIVE = "укреплённый гермозатвор",
		INSTRUMENTAL = "укреплённым гермозатвором",
		PREPOSITIONAL = "укреплённом гермозатворе",
	)

//special poddoors that open when emergency shuttle docks at centcom
/obj/machinery/door/poddoor/shuttledock
	var/checkdir = 4 //door won't open if turf in this dir is `turftype`
	var/turftype = /turf/open/space

/obj/machinery/door/poddoor/shuttledock/proc/check()
	var/turf/turf = get_step(src, checkdir)
	if(!istype(turf, turftype))
		INVOKE_ASYNC(src, PROC_REF(open))
	else
		INVOKE_ASYNC(src, PROC_REF(close))

/obj/machinery/door/poddoor/incinerator_ordmix
	name = "combustion chamber vent"
	gender = FEMALE
	id = INCINERATOR_ORDMIX_VENT

/obj/machinery/door/poddoor/incinerator_ordmix/get_ru_names()
	return alist(
		NOMINATIVE = "заслонка камеры сгорания",
		GENITIVE = "заслонки камеры сгорания",
		DATIVE = "заслонке камеры сгорания",
		ACCUSATIVE = "заслонку камеры сгорания",
		INSTRUMENTAL = "заслонкой камеры сгорания",
		PREPOSITIONAL = "заслонке камеры сгорания",
	)

/obj/machinery/door/poddoor/incinerator_atmos_main
	name = "turbine vent"
	gender = FEMALE
	id = INCINERATOR_ATMOS_MAINVENT

/obj/machinery/door/poddoor/incinerator_atmos_main/get_ru_names()
	return alist(
		NOMINATIVE = "заслонка турбины",
		GENITIVE = "заслонки турбины",
		DATIVE = "заслонке турбины",
		ACCUSATIVE = "заслонку турбины",
		INSTRUMENTAL = "заслонкой турбины",
		PREPOSITIONAL = "заслонке турбины",
	)

/obj/machinery/door/poddoor/incinerator_atmos_aux
	name = "combustion chamber vent"
	gender = FEMALE
	id = INCINERATOR_ATMOS_AUXVENT

/obj/machinery/door/poddoor/incinerator_atmos_aux/get_ru_names()
	return alist(
		NOMINATIVE = "заслонка камеры сгорания",
		GENITIVE = "заслонки камеры сгорания",
		DATIVE = "заслонке камеры сгорания",
		ACCUSATIVE = "заслонку камеры сгорания",
		INSTRUMENTAL = "заслонкой камеры сгорания",
		PREPOSITIONAL = "заслонке камеры сгорания",
	)

/obj/machinery/door/poddoor/atmos_test_room_mainvent_1
	name = "test chamber 1 vent"
	gender = FEMALE
	id = TEST_ROOM_ATMOS_MAINVENT_1

/obj/machinery/door/poddoor/atmos_test_room_mainvent_1/get_ru_names()
	return alist(
		NOMINATIVE = "заслонка тестовой камеры 1",
		GENITIVE = "заслонки тестовой камеры 1",
		DATIVE = "заслонке тестовой камеры 1",
		ACCUSATIVE = "заслонку тестовой камеры 1",
		INSTRUMENTAL = "заслонкой тестовой камеры 1",
		PREPOSITIONAL = "заслонке тестовой камеры 1",
	)

/obj/machinery/door/poddoor/atmos_test_room_mainvent_2
	name = "test chamber 2 vent"
	gender = FEMALE
	id = TEST_ROOM_ATMOS_MAINVENT_2

/obj/machinery/door/poddoor/atmos_test_room_mainvent_2/get_ru_names()
	return alist(
		NOMINATIVE = "заслонка тестовой камеры 2",
		GENITIVE = "заслонки тестовой камеры 2",
		DATIVE = "заслонке тестовой камеры 2",
		ACCUSATIVE = "заслонку тестовой камеры 2",
		INSTRUMENTAL = "заслонкой тестовой камеры 2",
		PREPOSITIONAL = "заслонке тестовой камеры 2",
	)

/obj/machinery/door/poddoor/incinerator_syndicatelava_main
	name = "turbine vent"
	gender = FEMALE
	id = INCINERATOR_SYNDICATELAVA_MAINVENT

/obj/machinery/door/poddoor/incinerator_syndicatelava_main/get_ru_names()
	return alist(
		NOMINATIVE = "заслонка турбины",
		GENITIVE = "заслонки турбины",
		DATIVE = "заслонке турбины",
		ACCUSATIVE = "заслонку турбины",
		INSTRUMENTAL = "заслонкой турбины",
		PREPOSITIONAL = "заслонке турбины",
	)

/obj/machinery/door/poddoor/incinerator_syndicatelava_aux
	name = "combustion chamber vent"
	gender = FEMALE
	id = INCINERATOR_SYNDICATELAVA_AUXVENT

/obj/machinery/door/poddoor/incinerator_syndicatelava_aux/get_ru_names()
	return alist(
		NOMINATIVE = "заслонка камеры сгорания",
		GENITIVE = "заслонки камеры сгорания",
		DATIVE = "заслонке камеры сгорания",
		ACCUSATIVE = "заслонку камеры сгорания",
		INSTRUMENTAL = "заслонкой камеры сгорания",
		PREPOSITIONAL = "заслонке камеры сгорания",
	)

/obj/machinery/door/poddoor/massdriver_ordnance
	name = "Ordnance Launcher Bay Door"
	gender = FEMALE
	id = MASSDRIVER_ORDNANCE

/obj/machinery/door/poddoor/massdriver_ordnance/get_ru_names()
	return alist(
		NOMINATIVE = "дверь пусковой шахты РНД",
		GENITIVE = "двери пусковой шахты РНД",
		DATIVE = "двери пусковой шахты РНД",
		ACCUSATIVE = "дверь пусковой шахты РНД",
		INSTRUMENTAL = "дверью пусковой шахты РНД",
		PREPOSITIONAL = "двери пусковой шахты РНД",
	)

/obj/machinery/door/poddoor/massdriver_chapel
	name = "Chapel Launcher Bay Door"
	gender = FEMALE
	id = MASSDRIVER_CHAPEL

/obj/machinery/door/poddoor/massdriver_chapel/get_ru_names()
	return alist(
		NOMINATIVE = "дверь пусковой шахты Церкви",
		GENITIVE = "двери пусковой шахты Церкви",
		DATIVE = "двери пусковой шахты Церкви",
		ACCUSATIVE = "дверь пусковой шахты Церкви",
		INSTRUMENTAL = "дверью пусковой шахты Церкви",
		PREPOSITIONAL = "двери пусковой шахты Церкви",
	)

/obj/machinery/door/poddoor/massdriver_trash
	name = "Disposals Launcher Bay Door"
	gender = FEMALE
	id = MASSDRIVER_DISPOSALS

/obj/machinery/door/poddoor/massdriver_trash/get_ru_names()
	return alist(
		NOMINATIVE = "дверь пусковой шахты мусоросброса",
		GENITIVE = "двери пусковой шахты мусоросброса",
		DATIVE = "двери пусковой шахты мусоросброса",
		ACCUSATIVE = "дверь пусковой шахты мусоросброса",
		INSTRUMENTAL = "дверью пусковой шахты мусоросброса",
		PREPOSITIONAL = "двери пусковой шахты мусоросброса",
	)
