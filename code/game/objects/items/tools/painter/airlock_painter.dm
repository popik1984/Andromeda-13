/obj/item/airlock_painter
	name = "airlock painter"
	desc = "Продвинутый автопокрасчик, в который запрограммировано несколько расцветок для шлюзов. Используйте его на шлюзе во время или после строительства, чтобы изменить расцветку."
	desc_controls = "Альт-клик, чтобы извлечь картридж с краской."
	icon = 'icons/obj/devices/tool.dmi'
	icon_state = "paint_sprayer"
	inhand_icon_state = "paint_sprayer"
	worn_icon_state = "painter"
	w_class = WEIGHT_CLASS_SMALL

	custom_materials = list(/datum/material/iron= SMALL_MATERIAL_AMOUNT * 0.5, /datum/material/glass= SMALL_MATERIAL_AMOUNT * 0.5)

	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = NOBLUDGEON
	slot_flags = ITEM_SLOT_BELT
	usesound = 'sound/effects/spray2.ogg'

	/// The ink cartridge to pull charges from.
	var/obj/item/toner/ink = null
	/// The type path to instantiate for the ink cartridge the device initially comes with, eg. /obj/item/toner
	var/initial_ink_type = /obj/item/toner
	/// Associate list of all paint jobs the airlock painter can apply. The key is the name of the airlock the user will see. The value is the type path of the airlock
	var/list/available_paint_jobs = list(
		"Общий" = /obj/machinery/door/airlock/public,
		"Инженерный" = /obj/machinery/door/airlock/engineering,
		"Атмосферный" = /obj/machinery/door/airlock/atmos,
		"Охрана" = /obj/machinery/door/airlock/security,
		"Командный" = /obj/machinery/door/airlock/command,
		"Медицинский" = /obj/machinery/door/airlock/medical,
		"Вирусология" = /obj/machinery/door/airlock/virology,
		"Исследовательский" = /obj/machinery/door/airlock/research,
		"Гидропоника" = /obj/machinery/door/airlock/hydroponics,
		"Холодильник" = /obj/machinery/door/airlock/freezer,
		"Научный" = /obj/machinery/door/airlock/science,
		"Шахтёрский" = /obj/machinery/door/airlock/mining,
		"Технический" = /obj/machinery/door/airlock/maintenance,
		"Внешний" = /obj/machinery/door/airlock/external,
		"Внешний технический"= /obj/machinery/door/airlock/maintenance/external,
		"Стандартный" = /obj/machinery/door/airlock
	)

/obj/item/airlock_painter/get_ru_names()
	return alist(
		NOMINATIVE = "покрасчик шлюзов",
		GENITIVE = "покрасчика шлюзов",
		DATIVE = "покрасчику шлюзов",
		ACCUSATIVE = "покрасчик шлюзов",
		INSTRUMENTAL = "покрасчиком шлюзов",
		PREPOSITIONAL = "покрасчике шлюзов",
	)

/obj/item/airlock_painter/Initialize(mapload)
	. = ..()
	ink = new initial_ink_type(src)

/obj/item/airlock_painter/Destroy(force)
	QDEL_NULL(ink)
	return ..()

//This proc doesn't just check if the painter can be used, but also uses it.
//Only call this if you are certain that the painter will be used right after this check!
/obj/item/airlock_painter/proc/use_paint(mob/user)
	if(can_use(user))
		ink.charges--
		playsound(src.loc, 'sound/effects/spray2.ogg', 50, TRUE)
		return TRUE
	else
		return FALSE

//This proc only checks if the painter can be used.
//Call this if you don't want the painter to be used right after this check, for example
//because you're expecting user input.
/obj/item/airlock_painter/proc/can_use(mob/user)
	if(!ink)
		balloon_alert(user, "нет картриджа!")
		return FALSE
	else if(ink.charges < 1)
		balloon_alert(user, "нет краски!")
		return FALSE
	else
		return TRUE

/obj/item/airlock_painter/suicide_act(mob/living/user)
	var/obj/item/organ/lungs/L = user.get_organ_slot(ORGAN_SLOT_LUNGS)

	if(can_use(user) && L)
		user.visible_message(span_suicide("[RU_USER_NOM] вдыхает тонер из [RU_SRC_GEN]! Похоже, [GEND_HE_SHE(user)] пытается совершить суицид!"))
		use(user)

		// Once you've inhaled the toner, you throw up your lungs
		// and then die.

		// Find out if there is an open turf in front of us,
		// and if not, pick the turf we are standing on.
		var/turf/T = get_step(get_turf(src), user.dir)
		if(!isopenturf(T))
			T = get_turf(src)

		// they managed to lose their lungs between then and
		// now. Good job.
		if(!L)
			return OXYLOSS

		L.Remove(user)

		// make some colorful reagent, and apply it to the lungs
		L.create_reagents(10)
		L.reagents.add_reagent(/datum/reagent/colorful_reagent, 10)
		L.reagents.expose(L, TOUCH, 1)

		// TODO maybe add some colorful vomit?

		user.visible_message(span_suicide("[RU_USER_NOM] выплёвывает [RU_ACC(L)]!"))
		playsound(user.loc, 'sound/effects/splat.ogg', 50, TRUE)

		L.forceMove(T)

		return (TOXLOSS|OXYLOSS)
	else if(can_use(user) && !L)
		user.visible_message(span_suicide("[RU_USER_NOM] распыляет на себя тонер из [RU_SRC_GEN]! Похоже, [GEND_HE_SHE(user)] пытается совершить суицид."))
		user.reagents.add_reagent(/datum/reagent/colorful_reagent, 1)
		user.reagents.expose(user, TOUCH, 1)
		return TOXLOSS

	else
		user.visible_message(span_suicide("[RU_USER_NOM] пытается вдохнуть тонер из [RU_SRC_GEN]! Это могло бы быть попыткой суицида, если бы в [RU_SRC_PRE] был тонер."))
		return SHAME


/obj/item/airlock_painter/examine(mob/user)
	. = ..()
	if(!ink)
		. += span_notice("В нём не установлен картридж с тонером.")
		return
	var/ink_level = "высоким"
	if(ink.charges < 1)
		ink_level = "нулевым"
	else if((ink.charges/ink.max_charges) <= 0.25) //25%
		ink_level = "низким"
	else if((ink.charges/ink.max_charges) > 1) //Over 100% (admin var edit)
		ink_level = "опасно высоким"
	. += span_notice("Уровень чернил выглядит [ink_level].")

/obj/item/airlock_painter/attackby(obj/item/W, mob/user, list/modifiers, list/attack_modifiers)
	if(istype(W, /obj/item/toner))
		if(ink)
			to_chat(user, span_warning("[RU_SRC_NOM] уже содержит [RU_ACC(ink)]!"))
			return
		if(!user.transferItemToLoc(W, src))
			return
		to_chat(user, span_notice("Вы устанавливаете [RU_ACC(W)] в [RU_SRC_ACC]."))
		ink = W
		playsound(src.loc, 'sound/machines/click.ogg', 50, TRUE)
	else
		return ..()

/obj/item/airlock_painter/click_alt(mob/user)
	if(!ink)
		return CLICK_ACTION_BLOCKING

	playsound(src.loc, 'sound/machines/click.ogg', 50, TRUE)
	ink.forceMove(user.drop_location())
	user.put_in_hands(ink)
	to_chat(user, span_notice("Вы извлекаете [RU_ACC(ink)] из [RU_SRC_GEN]."))
	ink = null
	return CLICK_ACTION_SUCCESS
