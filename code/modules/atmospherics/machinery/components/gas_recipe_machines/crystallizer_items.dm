/obj/item/hypernoblium_crystal
	name = "Hypernoblium Crystal"
	desc = "Бутыль с кристаллизованным гиперноблием. Защищает одежду от давления или останавливает реакции в переносных устройствах."
	icon = 'icons/obj/pipes_n_cables/atmos.dmi'
	icon_state = "hypernoblium_crystal"
	var/uses = 1

/obj/item/hypernoblium_crystal/get_ru_names()
	return alist(
		NOMINATIVE = "кристалл гиперноблия",
		GENITIVE = "кристалла гиперноблия",
		DATIVE = "кристаллу гиперноблия",
		ACCUSATIVE = "кристалл гиперноблия",
		INSTRUMENTAL = "кристаллом гиперноблия",
		PREPOSITIONAL = "кристалле гиперноблия",
	)

/obj/item/hypernoblium_crystal/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/obj/machinery/portable_atmospherics/atmos_device = interacting_with
	var/obj/item/clothing/worn_item = interacting_with
	if(!istype(worn_item) && !istype(atmos_device))
		to_chat(user, span_warning("Кристалл можно использовать только на одежде или переносных атмосферных устройствах!"))
		return ITEM_INTERACT_BLOCKING

	if(istype(atmos_device))
		if(atmos_device.nob_crystal_inserted)
			to_chat(user, span_warning("[atmos_device] уже содержит кристалл гиперноблия!"))
			return ITEM_INTERACT_BLOCKING
		atmos_device.insert_nob_crystal()
		to_chat(user, span_notice("Вы вставляете [RU_SRC_ACC] в [RU_ACC(atmos_device)]."))

	if(istype(worn_item))
		if(istype(worn_item, /obj/item/clothing/suit/space))
			to_chat(user, span_warning("[worn_item] уже защищает от давления!"))
			return ITEM_INTERACT_BLOCKING
		if(worn_item.min_cold_protection_temperature == SPACE_SUIT_MIN_TEMP_PROTECT && worn_item.clothing_flags & STOPSPRESSUREDAMAGE)
			to_chat(user, span_warning("[worn_item] уже защищает от давления!"))
			return ITEM_INTERACT_BLOCKING
		to_chat(user, span_notice("Вы видите, как [worn_item] меняет цвет, становясь устойчивым к давлению."))
		worn_item.name = "pressure-resistant [worn_item.name]"
		worn_item.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
		worn_item.add_atom_colour(color_transition_filter("#00fff7", SATURATION_OVERRIDE), FIXED_COLOUR_PRIORITY)
		worn_item.min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
		worn_item.cold_protection = worn_item.body_parts_covered
		worn_item.clothing_flags |= STOPSPRESSUREDAMAGE

	uses--
	if(uses <= 0)
		qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/nitrium_crystal
	desc = "Странный коричневый кристалл. Дымится при разрушении."
	name = "nitrium crystal"
	icon = 'icons/obj/pipes_n_cables/atmos.dmi'
	icon_state = "nitrium_crystal"
	var/cloud_size = 1

/obj/item/nitrium_crystal/get_ru_names()
	return alist(
		NOMINATIVE = "кристалл нитриума",
		GENITIVE = "кристалла нитриума",
		DATIVE = "кристаллу нитриума",
		ACCUSATIVE = "кристалл нитриума",
		INSTRUMENTAL = "кристаллом нитриума",
		PREPOSITIONAL = "кристалле нитриума",
	)

/obj/item/nitrium_crystal/attack_self(mob/user)
	. = ..()
	var/datum/effect_system/fluid_spread/smoke/chem/smoke = new
	var/turf/location = get_turf(src)
	create_reagents(5)
	reagents.add_reagent(/datum/reagent/nitrium_low_metabolization, 3)
	reagents.add_reagent(/datum/reagent/nitrium_high_metabolization, 2)
	smoke.attach(location)
	smoke.set_up(cloud_size, holder = src, location = location, carry = reagents, silent = TRUE)
	smoke.start()
	qdel(src)
