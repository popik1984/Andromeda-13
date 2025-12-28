/*
 * Gets the surgery speed modifier for a given mob, based off what sort of table/bed/whatever is on their turf.
 */
/proc/get_location_modifier(mob/located_mob)
	// Technically this IS a typecache, just not the usual kind :3
	var/static/list/modifiers = zebra_typecacheof(list(
		/obj/structure/table/optable/abductor = 1.5,
		/obj/structure/table/optable = 1,
		/obj/machinery/stasis = 0.9,
		/obj/structure/table = 0.8,
		/obj/structure/bed = 0.7,
	))
	. = 0.5

	var/turf/mob_turf = get_turf(located_mob)

	// Проверяем все объекты на клетке
	for(var/obj/thingy in mob_turf)
		// Особая проверка для операционного стола с компьютером
		if(istype(thingy, /obj/structure/table/optable))
			var/obj/structure/table/optable/op_table = thingy
			if(op_table.computer?.is_operational)
				// Компьютер даёт максимальный бонус
				. = max(., OPERATING_COMPUTER_MODIFIER)
				continue  // Переходим к следующему объекту

		// Стандартная проверка для остальных объектов
		. = max(., modifiers[thingy.type])

	return .

/proc/get_location_accessible(mob/located_mob, location)
	var/covered_locations = 0 //based on body_parts_covered
	var/face_covered = 0 //based on flags_inv
	var/eyesmouth_covered = 0 //based on flags_cover
	if(iscarbon(located_mob))
		var/mob/living/carbon/clothed_carbon = located_mob
		for(var/obj/item/clothing/clothes in list(clothed_carbon.back, clothed_carbon.wear_mask, clothed_carbon.head))
			covered_locations |= clothes.body_parts_covered
			face_covered |= clothes.flags_inv
			eyesmouth_covered |= clothes.flags_cover
		if(ishuman(clothed_carbon))
			var/mob/living/carbon/human/clothed_human = clothed_carbon
			for(var/obj/item/clothes in list(clothed_human.wear_suit, clothed_human.w_uniform, clothed_human.shoes, clothed_human.belt, clothed_human.gloves, clothed_human.glasses, clothed_human.ears))
				covered_locations |= clothes.body_parts_covered
				face_covered |= clothes.flags_inv
				eyesmouth_covered |= clothes.flags_cover

	switch(location)
		if(BODY_ZONE_HEAD)
			if(covered_locations & HEAD)
				return FALSE
		if(BODY_ZONE_PRECISE_EYES)
			if((face_covered & HIDEEYES) || (eyesmouth_covered & (MASKCOVERSEYES|HEADCOVERSEYES|GLASSESCOVERSEYES)))
				return FALSE
		if(BODY_ZONE_PRECISE_MOUTH)
			if((face_covered & HIDEFACE) || (eyesmouth_covered & (MASKCOVERSMOUTH|HEADCOVERSMOUTH)))
				return FALSE
		if(BODY_ZONE_CHEST)
			if(covered_locations & CHEST)
				return FALSE
		if(BODY_ZONE_PRECISE_GROIN)
			if(covered_locations & GROIN)
				return FALSE
		if(BODY_ZONE_L_ARM)
			if(covered_locations & ARM_LEFT)
				return FALSE
		if(BODY_ZONE_R_ARM)
			if(covered_locations & ARM_RIGHT)
				return FALSE
		if(BODY_ZONE_L_LEG)
			if(covered_locations & LEG_LEFT)
				return FALSE
		if(BODY_ZONE_R_LEG)
			if(covered_locations & LEG_RIGHT)
				return FALSE
		if(BODY_ZONE_PRECISE_L_HAND)
			if(covered_locations & HAND_LEFT)
				return FALSE
		if(BODY_ZONE_PRECISE_R_HAND)
			if(covered_locations & HAND_RIGHT)
				return FALSE
		if(BODY_ZONE_PRECISE_L_FOOT)
			if(covered_locations & FOOT_LEFT)
				return FALSE
		if(BODY_ZONE_PRECISE_R_FOOT)
			if(covered_locations & FOOT_RIGHT)
				return FALSE

	return TRUE

/**
 * Проверяет наличие загрязнений на полу в радиусе 3x3 клеток от пациента
 * Возвращает TRUE если есть грязь/жидкости, FALSE если чисто
 * И да, стены что в крови тоже проверяет, т.к. кровь на стене то же ...decal/cleanable
 */
/proc/check_area_cleanliness(turf/center_turf)
	if(!center_turf)
		return FALSE
	// Определяем область 3x3
	var/list/checked_turfs = block(
		locate(
			max(center_turf.x - 1, 1),
			max(center_turf.y - 1, 1),
			center_turf.z
		),
		locate(
			min(center_turf.x + 1, world.maxx),
			min(center_turf.y + 1, world.maxy),
			center_turf.z
		)
	)
	// Проверяем каждый турф на наличие загрязнений
	for(var/turf/check_turf as anything in checked_turfs)
		// Ищем любые объекты с родителем /obj/effect/decal/cleanable
		for(var/obj/effect/decal/cleanable/contamination in check_turf)
			// Если нашли хотя бы одно загрязнение - возвращаем TRUE
			return TRUE
	// Если ничего не нашли - пол чистый
	return FALSE

// TODO
// Rewokin: Если механ с санитарией пройдёт бета тест, то обязательно добавить проверку на наличие медицинской маски
// И шапочки хирурга (Если хирург лысый, то скип проверки шапочеки)

/**
 * Проверяет, есть ли на предмете видимые следы крови
 * Возвращает TRUE если предмет в крови
 */
/proc/is_item_bloody(obj/item/item)
	if(!item)
		return FALSE
	// Используем макрос проверки видимой крови
	return (GET_ATOM_BLOOD_DECAL_LENGTH(item) > 0)

/**
 * Проверяет, есть ли кровь на любой одежде хирурга
 * Возвращает TRUE если найдена хоть одна вещь в крови
 */
/proc/is_surgeon_clothing_bloody(mob/living/carbon/human/surgeon)
	if(!surgeon || !istype(surgeon))
		return FALSE
	// Все слоты одежды
	var/list/clothing_to_check = list(
		surgeon.back,
		surgeon.wear_mask,
		surgeon.wear_neck,
		surgeon.head,
		surgeon.gloves,
		surgeon.shoes,
		surgeon.glasses,
		surgeon.ears,
		surgeon.w_uniform,
		surgeon.wear_suit,
		surgeon.belt,
	)
	// Быстрая проверка
	for(var/obj/item/clothing/item in clothing_to_check)
		if(item && is_item_bloody(item))
			return TRUE
	return FALSE

/**
 * Проверяет, есть ли перчатки у хирурга, если есть, то какие
 */
/proc/has_proper_surgical_gloves(mob/living/carbon/human/surgeon)
	if(!surgeon || !istype(surgeon))
		return FALSE
	// Нет перчаток вообще
	if(!surgeon.gloves)
		return FALSE
	var/obj/item/clothing/gloves/gloves = surgeon.gloves
	// Любые перчатки с флагом "хирургические"
	if(gloves.item_flags & SURGICAL_GLOVES)
		return TRUE

/**
 * Проверяет, есть ли кровь на рука.
 */
/proc/are_bare_hands_bloody(mob/living/carbon/human/surgeon)
	if(!surgeon || !istype(surgeon) || surgeon.gloves)  // ← если surgeon.gloves = TRUE → то не проверяет руки на наличие крови
		return FALSE
	if(surgeon.forensics)
		var/list/visible_blood = surgeon.forensics.get_visible_blood()
		if(length(visible_blood) > 0)
			return TRUE
	return FALSE

/**
 * Текст, что отписывается в чат при нарушении санитарии
 */
/proc/get_risk_level_text(risk_percent)
	switch(risk_percent)
		if(0 to 20)
			return "Малый"
		if(21 to 40)
			return "Умеренный"
		if(41 to 60)
			return "Средний"
		if(61 to 80)
			return "Высокий"
		if(81 to 100)
			return "Критический"
		if(101 to INFINITY)
			return "Запредельный"
		else
			return "неопределённый"
