
// Makarov (9mm) //

/obj/item/ammo_box/magazine/m9mm
	name = "pistol magazine (9mm)"
	icon_state = "9x19p"
	base_icon_state = "9x19p"
	desc = "Магазин 9мм, подходит для пистолета Макарова."
	ammo_band_icon = "+9x19ab"
	ammo_band_color = null
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 12
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	multiple_sprite_use_base = TRUE

/obj/item/ammo_box/magazine/m9mm/get_ru_names()
	return alist(
		NOMINATIVE = "магазин 9мм",
		GENITIVE = "магазина 9мм",
		DATIVE = "магазину 9мм",
		ACCUSATIVE = "магазина 9 мм",
		INSTRUMENTAL = "магазином 9 мм",
		PREPOSITIONAL = "магазине 9мм",
	)

/obj/item/ammo_box/magazine/m9mm/fire
	MAGAZINE_TYPE_INCENDIARY
	ammo_type = /obj/item/ammo_casing/c9mm/fire

/obj/item/ammo_box/magazine/m9mm/hp
	MAGAZINE_TYPE_HOLLOWPOINT
	ammo_type = /obj/item/ammo_casing/c9mm/hp

/obj/item/ammo_box/magazine/m9mm/ap
	MAGAZINE_TYPE_ARMORPIERCE
	ammo_type = /obj/item/ammo_casing/c9mm/ap

// Stechkin APS (9mm) //

/obj/item/ammo_box/magazine/m9mm_aps
	name = "stechkin pistol magazine (9mm)"
	desc = "Магазин 9 мм, подходит для Автоматического Пистолета Стечкина."
	icon_state = "9mmaps-15"
	base_icon_state = "9mmaps"
	ammo_band_icon = "+9mmapsab"
	ammo_band_color = null
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 15

/obj/item/ammo_box/magazine/m9mm_aps/get_ru_names()
	return alist(
		NOMINATIVE = "магазин 9мм",
		GENITIVE = "магазина 9мм",
		DATIVE = "магазину 9мм",
		ACCUSATIVE = "магазина 9 мм",
		INSTRUMENTAL = "магазином 9 мм",
		PREPOSITIONAL = "магазине 9мм",
	)

/obj/item/ammo_box/magazine/m9mm_aps/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(), 5)]"

/obj/item/ammo_box/magazine/m9mm_aps/fire
	MAGAZINE_TYPE_INCENDIARY
	ammo_type = /obj/item/ammo_casing/c9mm/fire

/obj/item/ammo_box/magazine/m9mm_aps/hp
	MAGAZINE_TYPE_HOLLOWPOINT
	ammo_type = /obj/item/ammo_casing/c9mm/hp

/obj/item/ammo_box/magazine/m9mm_aps/ap
	MAGAZINE_TYPE_ARMORPIERCE
	ammo_type = /obj/item/ammo_casing/c9mm/ap

// Ansem (10mm) //

/obj/item/ammo_box/magazine/m10mm
	name = "pistol magazine (10mm)"
	desc = "Магазин 10 мм, подходит для пистолета Ансем."
	icon_state = "9x19p"
	base_icon_state = "9x19p"
	ammo_band_icon = "+9x19ab"
	ammo_band_color = null
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = CALIBER_10MM
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	multiple_sprite_use_base = TRUE

/obj/item/ammo_box/magazine/m10mm/get_ru_names()
	return alist(
		NOMINATIVE = "магазин 10мм",
		GENITIVE = "магазина 10мм",
		DATIVE = "магазину 10мм",
		ACCUSATIVE = "магазина 10мм",
		INSTRUMENTAL = "магазином 10мм",
		PREPOSITIONAL = "магазине 10мм",
	)

/obj/item/ammo_box/magazine/m10mm/fire
	MAGAZINE_TYPE_INCENDIARY
	ammo_type = /obj/item/ammo_casing/c10mm/fire

/obj/item/ammo_box/magazine/m10mm/hp
	MAGAZINE_TYPE_HOLLOWPOINT
	ammo_type = /obj/item/ammo_casing/c10mm/hp

/obj/item/ammo_box/magazine/m10mm/ap
	MAGAZINE_TYPE_ARMORPIERCE
	ammo_type = /obj/item/ammo_casing/c10mm/ap

// Regal Condor (10mm) //

/obj/item/ammo_box/magazine/r10mm
	name = "regal condor magazine (10mm Reaper)"
	desc = "Магазин 10мм, подходит для Регала Кондор."
	icon_state = "r10mm-8"
	base_icon_state = "r10mm"
	ammo_type = /obj/item/ammo_casing/c10mm/reaper
	caliber = CALIBER_10MM
	max_ammo = 8
	multiple_sprites = AMMO_BOX_PER_BULLET
	multiple_sprite_use_base = TRUE
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 10,
	)

/obj/item/ammo_box/magazine/r10mm/get_ru_names()
	return alist(
		NOMINATIVE = "магазин 10мм",
		GENITIVE = "магазина 10мм",
		DATIVE = "магазину 10мм",
		ACCUSATIVE = "магазина 10мм",
		INSTRUMENTAL = "магазином 10мм",
		PREPOSITIONAL = "магазине 10мм",
	)

// M1911 (.45) //

/obj/item/ammo_box/magazine/m45
	name = "handgun magazine (.45)"
	desc = "Магазин .45, подходит для М1911."
	icon_state = "45-8"
	base_icon_state = "45"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = CALIBER_45
	max_ammo = 8
	multiple_sprites = AMMO_BOX_PER_BULLET
	multiple_sprite_use_base = TRUE

/obj/item/ammo_box/magazine/m45/get_ru_names()
	return alist(
		NOMINATIVE = "магазин .45",
		GENITIVE = "магазина .45",
		DATIVE = "магазину .45",
		ACCUSATIVE = "магазина .45",
		INSTRUMENTAL = "магазином .45",
		PREPOSITIONAL = "магазине .45",
	)

// Desert Eagle (.50 AE) //

/obj/item/ammo_box/magazine/m50
	name = "handgun magazine (.50 AE)"
	desc = "Магазин .50, подходит для Desert Eagle."
	icon_state = "50ae"
	ammo_type = /obj/item/ammo_casing/a50ae
	caliber = CALIBER_50AE
	max_ammo = 7
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_box/magazine/m50/get_ru_names()
	return alist(
		NOMINATIVE = "магазин .50",
		GENITIVE = "магазина .50",
		DATIVE = "магазину .50",
		ACCUSATIVE = "магазина .50",
		INSTRUMENTAL = "магазином .50",
		PREPOSITIONAL = "магазине .50",
	)
