/*
 * MARK: Щипцы
 */

/obj/item/retractor
	name = "retractor"
	desc = "Медицинский инструмент, который обеспечивает лучший доступ к тканям, костям и органам пациента."
	icon = 'icons/obj/medical/surgery_tools.dmi'
	icon_state = "retractor"
	inhand_icon_state = "retractor"
	icon_angle = 45
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*3, /datum/material/glass =SHEET_MATERIAL_AMOUNT * 1.5)
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = SURGICAL_TOOL
	w_class = WEIGHT_CLASS_TINY
	tool_behaviour = TOOL_RETRACTOR
	toolspeed = 1
	/// How this looks when placed in a surgical tray
	var/surgical_tray_overlay = "retractor_normal"

/obj/item/retractor/get_ru_names()
	return alist(
		NOMINATIVE = "щипцы",
		GENITIVE = "щипцов",
		DATIVE = "щипцам",
		ACCUSATIVE = "щипцы",
		INSTRUMENTAL = "щипцами",
		PREPOSITIONAL = "щипцах",
	)

/obj/item/retractor/get_surgery_tool_overlay(tray_extended)
	return surgical_tray_overlay

/*
 * MARK: Гемостат
 */

/obj/item/hemostat
	name = "hemostat"
	desc = "Медицинский инструмент, который используют для временного удержания тканей или сосудов во время хирургических процедур."
	icon = 'icons/obj/medical/surgery_tools.dmi'
	icon_state = "hemostat"
	inhand_icon_state = "hemostat"
	icon_angle = 135
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	custom_materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT*1.25)
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = SURGICAL_TOOL
	w_class = WEIGHT_CLASS_TINY
	attack_verb_continuous = list("attacks", "pinches")
	attack_verb_simple = list("attack", "pinch")
	tool_behaviour = TOOL_HEMOSTAT
	toolspeed = 1
	/// How this looks when placed in a surgical tray
	var/surgical_tray_overlay = "hemostat_normal"

/obj/item/hemostat/get_ru_names()
	return alist(
		NOMINATIVE = "гемостат",
		GENITIVE = "гемостата",
		DATIVE = "гемостату",
		ACCUSATIVE = "гемостат",
		INSTRUMENTAL = "гемостатом",
		PREPOSITIONAL = "гемостате",
	)

/obj/item/hemostat/get_surgery_tool_overlay(tray_extended)
	return surgical_tray_overlay

/*
 * MARK: Коагулятор
 */

/obj/item/cautery
	name = "cautery"
	desc = "Медицинское оборудование, которое используют во время операций для уменьшения или полного прекращения кровотечения из рассечённых тканей."
	icon = 'icons/obj/medical/surgery_tools.dmi'
	icon_state = "cautery"
	inhand_icon_state = "cautery"
	icon_angle = 135
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*1.25, /datum/material/glass = SMALL_MATERIAL_AMOUNT*7.5)
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = SURGICAL_TOOL
	w_class = WEIGHT_CLASS_TINY
	attack_verb_continuous = list("burns")
	attack_verb_simple = list("burn")
	tool_behaviour = TOOL_CAUTERY
	toolspeed = 1
	heat = 500
	/// How this looks when placed in a surgical tray
	var/surgical_tray_overlay = "cautery_normal"

/obj/item/cautery/get_ru_names()
	return alist(
		NOMINATIVE = "коагулятор",
		GENITIVE = "коагулятора",
		DATIVE = "коагулятору",
		ACCUSATIVE = "коагулятор",
		INSTRUMENTAL = "коагулятором",
		PREPOSITIONAL = "коагуляторе",
	)

/obj/item/cautery/get_surgery_tool_overlay(tray_extended)
	return surgical_tray_overlay

/obj/item/cautery/ignition_effect(atom/ignitable_atom, mob/user)
	return span_rose("[user] подносит конец [RU_SRC_GEN] [ignitable_atom], поджигая его высокой температурой.")

/*
 * MARK: Дрель
 */

/obj/item/surgicaldrill
	name = "surgical drill"
	desc = "Медицинский инструмент, используемый в медицинских операциях для создания отверстий в костной ткани или других твёрдых структурах."
	icon = 'icons/obj/medical/surgery_tools.dmi'
	icon_state = "drill"
	inhand_icon_state = "drill"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	hitsound = 'sound/items/weapons/circsawhit.ogg'
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*5, /datum/material/glass = SHEET_MATERIAL_AMOUNT*3)
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = SURGICAL_TOOL
	force = 15
	demolition_mod = 0.5
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("drills")
	attack_verb_simple = list("drill")
	tool_behaviour = TOOL_DRILL
	toolspeed = 1
	sharpness = SHARP_POINTY
	wound_bonus = 10
	exposed_wound_bonus = 10
	/// How this looks when placed in a surgical tray
	var/surgical_tray_overlay = "drill_normal"

/obj/item/surgicaldrill/get_ru_names()
	return alist(
		NOMINATIVE = "хирургическая дрель",
		GENITIVE = "хирургической дрели",
		DATIVE = "хирургической дрели",
		ACCUSATIVE = "хирургическую дрель",
		INSTRUMENTAL = "хирургической дрелью",
		PREPOSITIONAL = "хирургической дрели",
	)

/obj/item/surgicaldrill/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/eyestab)

/obj/item/surgicaldrill/get_surgery_tool_overlay(tray_extended)
	return surgical_tray_overlay

/*
 * MARK: Скальпель
 */

/obj/item/scalpel
	name = "scalpel"
	desc = "Медицинский инструмент, используемый для рассечения мягких тканей. Это небольшой нож длиной от нескольких миллиметров до 15 сантиметров."
	icon = 'icons/obj/medical/surgery_tools.dmi'
	icon_state = "scalpel"
	inhand_icon_state = "scalpel"
	icon_angle = 180
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = SURGICAL_TOOL
	force = 10
	demolition_mod = 0.25
	w_class = WEIGHT_CLASS_TINY
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*2, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT)
	attack_verb_continuous = list("attacks", "slashes", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "slice", "tear", "lacerate", "rip", "dice", "cut")
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED
	tool_behaviour = TOOL_SCALPEL
	toolspeed = 1
	wound_bonus = 10
	exposed_wound_bonus = 15
	/// How this looks when placed in a surgical tray
	var/surgical_tray_overlay = "scalpel_normal"
	var/list/alt_continuous = list("stabs", "pierces", "impales")
	var/list/alt_simple = list("stab", "pierce", "impale")

/obj/item/scalpel/get_ru_names()
	return alist(
		NOMINATIVE = "скальпель",
		GENITIVE = "скальпеля",
		DATIVE = "скальпелю",
		ACCUSATIVE = "скальпель",
		INSTRUMENTAL = "скальпелем",
		PREPOSITIONAL = "скальпеле",
	)

/obj/item/scalpel/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering, \
	speed = 8 SECONDS * toolspeed, \
	effectiveness = 100, \
	bonus_modifier = 0, \
	)
	AddElement(/datum/element/eyestab)
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple)

/obj/item/scalpel/get_surgery_tool_overlay(tray_extended)
	return surgical_tray_overlay

/*
 * MARK: Пила
 */

/obj/item/circular_saw
	name = "circular saw"
	desc = "Медицинский инструмент, используемый для распиливания костей при ампутации, в костной пластике."
	icon = 'icons/obj/medical/surgery_tools.dmi'
	icon_state = "saw"
	inhand_icon_state = "saw"
	icon_angle = 180
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	hitsound = 'sound/items/weapons/circsawhit.ogg'
	mob_throw_hit_sound = 'sound/items/weapons/pierce.ogg'
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = SURGICAL_TOOL
	force = 15
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 9
	throw_speed = 2
	throw_range = 5
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*5, /datum/material/glass = SHEET_MATERIAL_AMOUNT*3)
	attack_verb_continuous = list("attacks", "slashes", "saws", "cuts")
	attack_verb_simple = list("attack", "slash", "saw", "cut")
	sharpness = SHARP_EDGED
	tool_behaviour = TOOL_SAW
	toolspeed = 1
	wound_bonus = 15
	exposed_wound_bonus = 10
	/// How this looks when placed in a surgical tray
	var/surgical_tray_overlay = "saw_normal"

/obj/item/circular_saw/get_ru_names()
	return alist(
		NOMINATIVE = "хирургическая пила",
		GENITIVE = "хирургической пилы",
		DATIVE = "хирургической пиле",
		ACCUSATIVE = "хирургическую пилу",
		INSTRUMENTAL = "хирургической пилой",
		PREPOSITIONAL = "хирургической пиле",
	)

/obj/item/circular_saw/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering, \
	speed = 4 SECONDS * toolspeed, \
	effectiveness = 100, \
	bonus_modifier = 5, \
	butcher_sound = 'sound/items/weapons/circsawhit.ogg', \
	)
	//saws are very accurate and fast at butchering
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/chainsaw)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/circular_saw/get_surgery_tool_overlay(tray_extended)
	return surgical_tray_overlay

/*
 * MARK: Простыня
 */

/obj/item/surgical_drapes
	name = "surgical drapes"
	desc = "Медицинские изделия, предназначенные для обеспечения чистоты и стерильности области хирургического разреза или послеоперационного шва."
	icon = 'icons/obj/medical/surgery_tools.dmi'
	icon_state = "surgical_drapes"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	inhand_icon_state = "drapes"
	w_class = WEIGHT_CLASS_TINY
	attack_verb_continuous = list("slaps")
	attack_verb_simple = list("slap")
	drop_sound = SFX_CLOTH_DROP
	pickup_sound = SFX_CLOTH_PICKUP
	gender = PLURAL

/obj/item/surgical_drapes/get_ru_names()
	return alist(
		NOMINATIVE = "хирургическая простыня",
		GENITIVE = "хирургической простыни",
		DATIVE = "хирургической простыне",
		ACCUSATIVE = "хирургическую простыню",
		INSTRUMENTAL = "хирургической простынёй",
		PREPOSITIONAL = "хирургической простыне",
	)

/obj/item/surgical_drapes/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/surgery_aid, name)

/*
 * MARK: Костоправ
 */

/obj/item/bonesetter
	name = "bonesetter"
	desc = "Универсальный медицинский инструмент для устранения вывихов и фиксации костей."
	icon = 'icons/obj/medical/surgery_tools.dmi'
	icon_state = "bonesetter"
	icon_angle = 135
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	custom_materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5,  /datum/material/glass = SHEET_MATERIAL_AMOUNT*1.25, /datum/material/silver = SHEET_MATERIAL_AMOUNT*1.25)
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = SURGICAL_TOOL
	w_class = WEIGHT_CLASS_SMALL
	attack_verb_continuous = list("corrects", "properly sets")
	attack_verb_simple = list("correct", "properly set")
	tool_behaviour = TOOL_BONESET
	toolspeed = 1
	var/surgical_tray_overlay = "bonesetter"

/obj/item/bonesetter/get_ru_names()
	return alist(
		NOMINATIVE = "костоправ",
		GENITIVE = "костоправа",
		DATIVE = "костоправу",
		ACCUSATIVE = "костоправа",
		INSTRUMENTAL = "костоправом",
		PREPOSITIONAL = "костоправе",
	)

/obj/item/bonesetter/get_surgery_tool_overlay(tray_extended)
	return surgical_tray_overlay + (tray_extended ? "" : "_out")

/*
 * MARK: Фильтр крови
 */

/obj/item/blood_filter
	name = "blood filter"
	desc = "For filtering the blood."
	icon = 'icons/obj/medical/surgery_tools.dmi'
	icon_state = "bloodfilter"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT, /datum/material/glass=HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/silver=SMALL_MATERIAL_AMOUNT*5)
	item_flags = SURGICAL_TOOL
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("pumps", "siphons")
	attack_verb_simple = list("pump", "siphon")
	tool_behaviour = TOOL_BLOODFILTER
	toolspeed = 1
	sound_vary = TRUE
	pickup_sound = SFX_GENERIC_DEVICE_PICKUP
	drop_sound = SFX_GENERIC_DEVICE_DROP
	/// Assoc list of chem ids to names, used for deciding which chems to filter when used for surgery
	var/list/whitelist = list()
	var/surgical_tray_overlay = "filter"

/obj/item/blood_filter/get_ru_names()
	return alist(
		NOMINATIVE = "фильтр крови",
		GENITIVE = "фильтра крови",
		DATIVE = "фильтру крови",
		ACCUSATIVE = "фильтр крови",
		INSTRUMENTAL = "фильтром крови",
		PREPOSITIONAL = "фильтре крови",
	)

/obj/item/blood_filter/get_surgery_tool_overlay(tray_extended)
	return surgical_tray_overlay

/// Тгуи фильтра крови
/obj/item/blood_filter/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "BloodFilter", name)
		ui.open()

/obj/item/blood_filter/ui_data(mob/user)
	. = list()

	.["whitelist"] = list()
	for(var/key in whitelist)
		.["whitelist"] += whitelist[key]

/obj/item/blood_filter/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	. = TRUE
	switch(action)
		if("add")
			var/selected_reagent = tgui_input_list(usr, "Выбрать реагент для фильтрации", "Реагент в белый список", GLOB.name2reagent)
			if(!selected_reagent)
				return FALSE

			var/datum/reagent/chem_id = GLOB.name2reagent[selected_reagent]
			if(!chem_id)
				return FALSE

			if(!(chem_id in whitelist))
				whitelist[chem_id] = selected_reagent

		if("remove")
			var/chem_name = params["reagent"]
			var/chem_id = get_chem_id(chem_name)
			whitelist -= chem_id

/*
 * MARK: Процессор
 */

/obj/item/surgical_processor //allows medical cyborgs to scan and initiate advanced surgeries
	name = "surgical processor"
	desc = "Устройство для сканирования и инициирования операций с диска или операционного компьютера."
	icon = 'icons/obj/devices/scanner.dmi'
	icon_state = "surgical_processor"
	item_flags = NOBLUDGEON
	// List of surgeries downloaded into the device.
	var/list/loaded_surgeries = list()
	// If a surgery has been downloaded in. Will cause the display to have a noticeable effect - helps to realize you forgot to load anything in.
	var/downloaded = TRUE

/obj/item/surgical_processor/get_ru_names()
	return alist(
		NOMINATIVE = "хирургический процессор",
		GENITIVE = "хирургического процессора",
		DATIVE = "хирургическому процессору",
		ACCUSATIVE = "хирургический процессор",
		INSTRUMENTAL = "хирургическим процессором",
		PREPOSITIONAL = "хирургическом процессоре",
	)

/obj/item/surgical_processor/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/surgery_aid, /obj/item/surgical_drapes::name) // i guess it's a drape dispenser

/obj/item/surgical_processor/examine(mob/user)
	. = ..()
	. += span_notice("Установите процессор в один из ваших активных модулей для доступа к загруженным продвинутым операциям.")
	. += span_boldnotice("Доступные продвинутые операции:")
	//list of downloaded surgeries' names
	var/list/surgeries_names = list()
	for(var/datum/surgery_operation/downloaded_surgery as anything in GLOB.operations.get_instances_from(loaded_surgeries))
		surgeries_names += "[capitalize(downloaded_surgery.name)]"
	. += span_notice("[english_list(surgeries_names)]")

/obj/item/surgical_processor/equipped(mob/user, slot, initial)
	. = ..()
	if(!(slot & ITEM_SLOT_HANDS))
		UnregisterSignal(user, COMSIG_LIVING_OPERATING_ON)
		return
	RegisterSignal(user, COMSIG_LIVING_OPERATING_ON, PROC_REF(check_surgery), override = TRUE)

/obj/item/surgical_processor/dropped(mob/user, silent)
	. = ..()
	UnregisterSignal(user, COMSIG_LIVING_OPERATING_ON)

/obj/item/surgical_processor/interact_with_atom(atom/design_holder, mob/living/user, list/modifiers)
	if(!istype(design_holder, /obj/item/disk/surgery) && !istype(design_holder, /obj/machinery/computer/operating))
		return NONE
	balloon_alert(user, "копирование чертежей...")
	playsound(src, 'sound/machines/terminal/terminal_processing.ogg', 25, TRUE)
	if(do_after(user, 1 SECONDS, target = design_holder))
		if(istype(design_holder, /obj/item/disk/surgery))
			var/obj/item/disk/surgery/surgery_disk = design_holder
			loaded_surgeries |= surgery_disk.surgeries
		else
			var/obj/machinery/computer/operating/surgery_computer = design_holder
			loaded_surgeries |= surgery_computer.advanced_surgeries
		playsound(src, 'sound/machines/terminal/terminal_success.ogg', 25, TRUE)
		downloaded = TRUE
		update_appearance(UPDATE_OVERLAYS)
		return ITEM_INTERACT_SUCCESS
	return ITEM_INTERACT_BLOCKING

/obj/item/surgical_processor/update_overlays()
	. = ..()
	if(downloaded)
		. += mutable_appearance(src.icon, "+downloaded")

/obj/item/surgical_processor/proc/check_surgery(datum/source, atom/movable/operating_on, list/operations)
	SIGNAL_HANDLER

	operations |= loaded_surgeries

/*
 * MARK: Продвинутые инст.
 */

/obj/item/cautery/advanced
	name = "searing tool"
	desc = "Медицинский лазерный коагулятор, точность и качество."
	icon = 'icons/obj/medical/surgery_tools.dmi'
	icon_state = "e_cautery"
	inhand_icon_state = "e_cautery"
	surgical_tray_overlay = "cautery_advanced"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*2, /datum/material/glass =SHEET_MATERIAL_AMOUNT, /datum/material/plasma =SHEET_MATERIAL_AMOUNT, /datum/material/uranium = SHEET_MATERIAL_AMOUNT*1.5, /datum/material/titanium = SHEET_MATERIAL_AMOUNT*1.5)
	hitsound = 'sound/items/tools/welder.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	toolspeed = 0.7
	light_system = OVERLAY_LIGHT
	light_range = 1.5
	light_power = 0.4
	light_color = COLOR_SOFT_RED

/obj/item/cautery/advanced/get_ru_names()
	return alist(
		NOMINATIVE = "лазерный коагулятор",
		GENITIVE = "лазерного коагулятора",
		DATIVE = "лазерному коагулятору",
		ACCUSATIVE = "лазерный коагулятор",
		INSTRUMENTAL = "лазерным коагулятором",
		PREPOSITIONAL = "лазерном коагуляторе",
	)

/obj/item/cautery/advanced/get_all_tool_behaviours()
	return list(TOOL_CAUTERY, TOOL_DRILL)

/obj/item/cautery/advanced/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/transforming, \
		force_on = force, \
		throwforce_on = throwforce, \
		hitsound_on = hitsound, \
		w_class_on = w_class, \
		clumsy_check = FALSE, \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

/*
 * Signal proc for [COMSIG_TRANSFORMING_ON_TRANSFORM].
 *
 * Toggles between drill and cautery and gives feedback to the user.
 */
/obj/item/cautery/advanced/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	if(active)
		tool_behaviour = TOOL_DRILL
		set_light_color(LIGHT_COLOR_BLUE)
	else
		tool_behaviour = TOOL_CAUTERY
		set_light_color(LIGHT_COLOR_ORANGE)

	balloon_alert(user, "режим [active ? "прожигания" : "прижигания"]")
	playsound(user ? user : src, 'sound/items/weapons/tap.ogg', 50, TRUE)
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/cautery/advanced/examine()
	. = ..()
	. += span_notice("Установлен в режиме [tool_behaviour == TOOL_CAUTERY ? "прижигания" : "прожигания"].")


/obj/item/scalpel/advanced
	name = "laser scalpel"
	desc = "Усовершенствованный медицинский скальпель, который режет с помощью лазерной технологии."
	icon_state = "e_scalpel"
	inhand_icon_state = "e_scalpel"
	surgical_tray_overlay = "scalpel_advanced"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*3, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/silver =SHEET_MATERIAL_AMOUNT, /datum/material/gold =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/diamond =SMALL_MATERIAL_AMOUNT * 2, /datum/material/titanium = SHEET_MATERIAL_AMOUNT*2)
	hitsound = 'sound/items/weapons/blade1.ogg'
	force = 16
	w_class = WEIGHT_CLASS_NORMAL
	toolspeed = 0.7
	light_system = OVERLAY_LIGHT
	light_range = 1.5
	light_power = 0.4
	light_color = LIGHT_COLOR_BLUE
	sharpness = SHARP_EDGED
	item_flags = parent_type::item_flags | NO_BLOOD_ON_ITEM

/obj/item/scalpel/advanced/get_ru_names()
	return alist(
		NOMINATIVE = "лазерный скальпель",
		GENITIVE = "лазерного скальпеля",
		DATIVE = "лазерному скальпелю",
		ACCUSATIVE = "лазерный скальпель",
		INSTRUMENTAL = "лазерным скальпелем",
		PREPOSITIONAL = "лазерном скальпеле",
	)

/obj/item/scalpel/advanced/get_all_tool_behaviours()
	return list(TOOL_SAW, TOOL_SCALPEL)

/obj/item/scalpel/advanced/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/transforming, \
		force_on = force + 1, \
		throwforce_on = throwforce, \
		throw_speed_on = throw_speed, \
		sharpness_on = sharpness, \
		hitsound_on = hitsound, \
		w_class_on = w_class, \
		clumsy_check = FALSE, \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

/*
 * Signal proc for [COMSIG_TRANSFORMING_ON_TRANSFORM].
 *
 * Toggles between saw and scalpel and updates the light / gives feedback to the user.
 */
/obj/item/scalpel/advanced/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	if(active)
		tool_behaviour = TOOL_SAW
		set_light_color(LIGHT_COLOR_ORANGE)
	else
		tool_behaviour = TOOL_SCALPEL
		set_light_color(LIGHT_COLOR_BLUE)

	balloon_alert(user, "режим резки [active ? "мягких" : "твёрдых"] тканей")
	playsound(user ? user : src, 'sound/machines/click.ogg', 50, TRUE)
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/scalpel/advanced/examine()
	. = ..()
	. += span_notice("Установлен в режиме [tool_behaviour == TOOL_SCALPEL ? "скальпеля" : "пилы"].")


/obj/item/retractor/advanced
	name = "mechanical pinches"
	desc = "Скопление стержней, пружин и шестеренок, что меняют конструкцию инструмента под ситуацию"
	icon = 'icons/obj/medical/surgery_tools.dmi'
	icon_state = "adv_retractor"
	inhand_icon_state = "adv_retractor"
	surgical_tray_overlay = "retractor_advanced"
	icon_angle = 0
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*6, /datum/material/glass = SHEET_MATERIAL_AMOUNT*2, /datum/material/silver = SHEET_MATERIAL_AMOUNT*2, /datum/material/titanium =SHEET_MATERIAL_AMOUNT * 2.5)
	w_class = WEIGHT_CLASS_NORMAL
	toolspeed = 0.7

/obj/item/retractor/advanced/get_ru_names()
	return alist(
		NOMINATIVE = "механические щипцы",
		GENITIVE = "механических щипцов",
		DATIVE = "механическим щипцам",
		ACCUSATIVE = "механические щипцы",
		INSTRUMENTAL = "механическими щипцами",
		PREPOSITIONAL = "механических щипцах",
	)

/obj/item/retractor/advanced/get_all_tool_behaviours()
	return list(TOOL_HEMOSTAT, TOOL_RETRACTOR)

/obj/item/retractor/advanced/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/transforming, \
		force_on = force, \
		throwforce_on = throwforce, \
		hitsound_on = hitsound, \
		w_class_on = w_class, \
		clumsy_check = FALSE, \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

/*
 * Signal proc for [COMSIG_TRANSFORMING_ON_TRANSFORM].
 *
 * Toggles between retractor and hemostat and gives feedback to the user.
 */
/obj/item/retractor/advanced/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	tool_behaviour = (active ? TOOL_HEMOSTAT : TOOL_RETRACTOR)
	balloon_alert(user, "режим [active ? "зажима" : "ретракции"]")
	playsound(user ? user : src, 'sound/items/tools/change_drill.ogg', 50, TRUE)
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/retractor/advanced/examine()
	. = ..()
	. += span_notice("Установлен в режиме [tool_behaviour == TOOL_RETRACTOR ? "ретрактора" : "зажима"].")

/*
 * MARK: Киборг инст.
 */

/obj/item/retractor/cyborg
	icon = 'icons/mob/silicon/robot_items.dmi'
	icon_state = "toolkit_medborg_retractor"
	icon_angle = 45

/obj/item/hemostat/cyborg
	icon = 'icons/mob/silicon/robot_items.dmi'
	icon_state = "toolkit_medborg_hemostat"
	icon_angle = 45

/obj/item/bonesetter/cyborg
	icon = 'icons/mob/silicon/robot_items.dmi'
	icon_state = "toolkit_medborg_bonesetter"
	icon_angle = 45

/obj/item/surgical_drapes/cyborg
	icon = 'icons/mob/silicon/robot_items.dmi'
	icon_state = "toolkit_medborg_surgicaldrapes"

/obj/item/circular_saw/cyborg
	icon = 'icons/mob/silicon/robot_items.dmi'
	icon_state = "toolkit_medborg_saw"
	icon_angle = 0

/obj/item/cautery/cyborg
	icon = 'icons/mob/silicon/robot_items.dmi'
	icon_state = "toolkit_medborg_cautery"
	icon_angle = 45

/obj/item/surgicaldrill/cyborg
	icon = 'icons/mob/silicon/robot_items.dmi'
	icon_state = "toolkit_medborg_drill"

/obj/item/scalpel/cyborg
	icon = 'icons/mob/silicon/robot_items.dmi'
	icon_state = "toolkit_medborg_scalpel"
	icon_angle = 0

/*
 * MARK: Патологоанат
 */

/obj/item/retractor/cruel
	icon_state = "cruelretractor"
	surgical_tray_overlay = "retractor_cruel"
	item_flags = SURGICAL_TOOL | CRUEL_IMPLEMENT

/obj/item/hemostat/cruel
	icon_state = "cruelhemostat"
	surgical_tray_overlay = "hemostat_cruel"
	item_flags = SURGICAL_TOOL | CRUEL_IMPLEMENT

/obj/item/cautery/cruel
	icon_state = "cruelcautery"
	surgical_tray_overlay = "cautery_cruel"
	item_flags = SURGICAL_TOOL | CRUEL_IMPLEMENT

/obj/item/scalpel/cruel
	icon_state = "cruelscalpel"
	surgical_tray_overlay = "scalpel_cruel"
	item_flags = SURGICAL_TOOL | CRUEL_IMPLEMENT

/obj/item/surgicaldrill/cruel
	icon_state = "crueldrill"
	inhand_icon_state = "crueldrill"
	surgical_tray_overlay = "drill_cruel"
	item_flags = SURGICAL_TOOL | CRUEL_IMPLEMENT

/obj/item/circular_saw/cruel
	icon_state = "cruelsaw"
	inhand_icon_state = "cruelsaw"
	icon_angle = 0
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	surgical_tray_overlay = "saw_cruel"
	item_flags = SURGICAL_TOOL | CRUEL_IMPLEMENT

/obj/item/bonesetter/cruel
	icon_state = "cruelbonesetter"
	inhand_icon_state = "cruelbonesetter"
	surgical_tray_overlay = "bonesetter_cruel"
	item_flags = SURGICAL_TOOL | CRUEL_IMPLEMENT

/obj/item/blood_filter/cruel
	icon_state = "cruelbloodfilter"
	inhand_icon_state = "cruelbloodfilter"
	surgical_tray_overlay = "filter_cruel"
	item_flags = SURGICAL_TOOL | CRUEL_IMPLEMENT

/obj/item/scalpel/cruel/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/bane, mob_biotypes = MOB_UNDEAD, damage_multiplier = 1) //Just in case one of the tennants get uppity

/*
 * MARK: Импланты
 */

/// Обычный инструмент хирурга
/obj/item/circular_saw/augment
	w_class = WEIGHT_CLASS_SMALL
	toolspeed = 0.5

/obj/item/scalpel/augment
	toolspeed = 0.5

/obj/item/surgicaldrill/augment
	hitsound = 'sound/items/weapons/circsawhit.ogg'
	w_class = WEIGHT_CLASS_SMALL
	toolspeed = 0.5

/obj/item/cautery/augment
	toolspeed = 0.5

/obj/item/hemostat/augment
	toolspeed = 0.5

/obj/item/retractor/augment
	toolspeed = 0.5

/// Инструмент патологоаната
/obj/item/retractor/cruel/augment
	toolspeed = 0.5

/obj/item/hemostat/cruel/augment
	toolspeed = 0.5

/obj/item/cautery/cruel/augment
	toolspeed = 0.5

/obj/item/scalpel/cruel/augment
	toolspeed = 0.5

/obj/item/surgicaldrill/cruel/augment
	hitsound = 'sound/items/weapons/circsawhit.ogg'
	w_class = WEIGHT_CLASS_SMALL
	toolspeed = 0.5

/obj/item/circular_saw/cruel/augment
	w_class = WEIGHT_CLASS_SMALL
	toolspeed = 0.5
