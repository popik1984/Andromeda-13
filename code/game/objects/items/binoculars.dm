/obj/item/binoculars
	name = "binoculars"
	desc = "Используется для наблюдения на дальнем расстоянии."
	gender = MALE
	inhand_icon_state = "binoculars"
	icon = 'icons/obj/devices/tool.dmi'
	icon_state = "binoculars"
	worn_icon_state = "binoculars"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	slot_flags = ITEM_SLOT_NECK | ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/binoculars/get_ru_names()
	return alist(
		NOMINATIVE = "бинокль",
		GENITIVE = "бинокля",
		DATIVE = "биноклю",
		ACCUSATIVE = "бинокль",
		INSTRUMENTAL = "биноклем",
		PREPOSITIONAL = "бинокле",
	)

/obj/item/binoculars/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=8, force_wielded=12, wield_callback = CALLBACK(src, PROC_REF(on_wield)), unwield_callback = CALLBACK(src, PROC_REF(on_unwield)))
	AddComponent(/datum/component/scope, range_modifier = 4, zoom_method = ZOOM_METHOD_WIELD)

/obj/item/binoculars/proc/on_wield(obj/item/source, mob/user)
	user.visible_message(span_notice("[user] подносит [RU_SRC_ACC] к глазам."), span_notice("Вы подносите [RU_SRC_ACC] к глазам."))
	inhand_icon_state = "binoculars_wielded"
	user.regenerate_icons()
	//Have you ever tried running with binocs on? It takes some willpower not to stop as things appear way too close than they're.
	user.add_movespeed_modifier(/datum/movespeed_modifier/binocs_wielded)

/obj/item/binoculars/proc/on_unwield(obj/item/source, mob/user)
	user.visible_message(span_notice("[user] опускает [RU_SRC_ACC]."), span_notice("Вы опускаете [RU_SRC_ACC]."))
	inhand_icon_state = "binoculars"
	user.regenerate_icons()
	user.remove_movespeed_modifier(/datum/movespeed_modifier/binocs_wielded)
