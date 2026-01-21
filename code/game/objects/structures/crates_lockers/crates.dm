/obj/structure/closet/crate
	name = "crate"
	desc = "Прямоугольный стальной ящик."
	gender = MALE
	icon = 'icons/obj/storage/crates.dmi'
	icon_state = "crate"
	base_icon_state = "crate"
	req_access = null
	horizontal = TRUE
	allow_objects = TRUE
	allow_dense = TRUE
	dense_when_open = TRUE
	delivery_icon = "deliverycrate"
	open_sound = 'sound/machines/crate/crate_open.ogg'
	close_sound = 'sound/machines/crate/crate_close.ogg'
	open_sound_volume = 35
	close_sound_volume = 50
	drag_slowdown = 0
	door_anim_time = 0 // no animation
	pass_flags_self = PASSSTRUCTURE | LETPASSTHROW
	x_shake_pixel_shift = 1
	y_shake_pixel_shift = 2
	/// Mobs standing on it are nudged up by this amount.
	var/elevation = 14
	/// The same, but when the crate is open
	var/elevation_open = 14
	/// The time spent to climb this crate.
	var/crate_climb_time = 2 SECONDS
	/// The reference of the manifest paper attached to the cargo crate.
	var/datum/weakref/manifest
	/// Where the Icons for lids are located.
	var/lid_icon = 'icons/obj/storage/crates.dmi'
	/// Icon state to use for lid to display when opened. Leave undefined if there isn't one.
	var/lid_icon_state
	/// Controls the X value of the lid, allowing left and right pixel movement.
	var/lid_w = 0
	/// Controls the Y value of the lid, allowing up and down pixel movement.
	var/lid_z = 0
	var/weld_w = 0
	var/weld_z = 0

/obj/structure/closet/crate/get_ru_names()
	return alist(
		NOMINATIVE = "ящик",
		GENITIVE = "ящика",
		DATIVE = "ящику",
		ACCUSATIVE = "ящик",
		INSTRUMENTAL = "ящиком",
		PREPOSITIONAL = "ящике",
	)

/obj/structure/closet/crate/Initialize(mapload)
	AddElement(/datum/element/climbable, climb_time = crate_climb_time, climb_stun = 0) //add element in closed state before parent init opens it(if it does)
	if(elevation)
		AddElement(/datum/element/climb_walkable)
		AddElement(/datum/element/elevation, pixel_shift = elevation)
	. = ..()

	var/static/list/crate_paint_jobs
	if(isnull(crate_paint_jobs))
		crate_paint_jobs = list(
			"Internals" = list("icon_state" = "o2crate"),
			"Medical" = list("icon_state" = "medical"),
			"Medical Plus" = list("icon_state" = "medicalcrate"),
			"Radiation" = list("icon_state" = "radiation"),
			"Hydrophonics" = list("icon_state" = "hydrocrate"),
			"Science" = list("icon_state" = "scicrate"),
			"Robotics" = list("icon_state" = "robo"),
			"Solar" = list("icon_state" = "engi_e_crate"),
			"Engineering" = list("icon_state" = "engi_crate"),
			"Atmospherics" = list("icon_state" = "atmos"),
			"Cargo" = list("icon_state" = "cargo"),
			"Mining" = list("icon_state" = "mining"),
			"Command" = list("icon_state" = "centcom"),
		)
	if(paint_jobs)
		paint_jobs = crate_paint_jobs
	AddComponent(/datum/component/soapbox)

/obj/structure/closet/crate/Destroy()
	manifest = null
	return ..()

/obj/structure/closet/crate/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(!istype(mover, /obj/structure/closet))
		var/obj/structure/closet/crate/locatedcrate = locate(/obj/structure/closet/crate) in get_turf(mover)
		if(locatedcrate) //you can walk on it like tables, if you're not in an open crate trying to move to a closed crate
			if(opened) //if we're open, allow entering regardless of located crate openness
				return TRUE
			if(!locatedcrate.opened) //otherwise, if the located crate is closed, allow entering
				return TRUE

/obj/structure/closet/crate/update_icon_state()
	icon_state = "[isnull(base_icon_state) ? initial(icon_state) : base_icon_state][opened ? "open" : ""]"
	return ..()

/obj/structure/closet/crate/closet_update_overlays(list/new_overlays)
	. = new_overlays
	if(manifest)
		. += "manifest"

	if(!opened)
		if(broken)
			. += "securecrateemag"
		else if(locked)
			. += "securecrater"
		else if(secure)
			. += "securecrateg"

	if(welded)
		var/mutable_appearance/weld_overlay = mutable_appearance(icon, "welded")
		weld_overlay.pixel_w = weld_w
		weld_overlay.pixel_z = weld_z
		. += weld_overlay

	if(opened && lid_icon_state)
		var/mutable_appearance/lid = mutable_appearance(icon = lid_icon, icon_state = lid_icon_state)
		lid.pixel_w = lid_w
		lid.pixel_z = lid_z
		lid.layer = layer
		. += lid

/obj/structure/closet/crate/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	tear_manifest(user)

/obj/structure/closet/crate/after_open(mob/living/user, force)
	. = ..()
	RemoveElement(/datum/element/climbable, climb_time = crate_climb_time, climb_stun = 0)
	AddElement(/datum/element/climbable, climb_time = crate_climb_time * 0.5, climb_stun = 0)
	if(elevation != elevation_open)
		if(elevation)
			RemoveElement(/datum/element/elevation, pixel_shift = elevation)
		if(elevation_open)
			AddElement(/datum/element/elevation, pixel_shift = elevation_open)

	tear_manifest()

/obj/structure/closet/crate/after_close(mob/living/user)
	. = ..()
	RemoveElement(/datum/element/climbable, climb_time = crate_climb_time * 0.5, climb_stun = 0)
	AddElement(/datum/element/climbable, climb_time = crate_climb_time, climb_stun = 0)
	if(elevation != elevation_open)
		if(elevation_open)
			RemoveElement(/datum/element/elevation, pixel_shift = elevation_open)
		if(elevation)
			AddElement(/datum/element/elevation, pixel_shift = elevation)

///Spawns two to six maintenance spawners inside the closet
/obj/structure/closet/proc/populate_with_random_maint_loot()
	SIGNAL_HANDLER

	for (var/i in 1 to rand(2,6))
		new /obj/effect/spawner/random/maintenance(src)

	UnregisterSignal(src, COMSIG_CLOSET_CONTENTS_INITIALIZED)

///Removes the supply manifest from the closet
/obj/structure/closet/crate/proc/tear_manifest(mob/user)
	var/obj/item/paper/fluff/jobs/cargo/manifest/our_manifest = manifest?.resolve()
	if(QDELETED(our_manifest))
		manifest = null
		return
	if(user)
		to_chat(user, span_notice("Вы срываете манифест с [RU_SRC_GEN]."))
	playsound(src, 'sound/items/poster/poster_ripped.ogg', 75, TRUE)

	our_manifest.forceMove(drop_location(src))
	if(ishuman(user))
		user.put_in_hands(our_manifest)
	manifest = null
	update_appearance()

/obj/structure/closet/crate/preopen
	opened = TRUE
	icon_state = "crateopen"

/obj/structure/closet/crate/coffin
	name = "coffin"
	desc = "Погребальный сосуд для усопших."
	gender = MALE
	icon_state = "coffin"
	base_icon_state = "coffin"
	resistance_flags = FLAMMABLE
	max_integrity = 70
	material_drop = /obj/item/stack/sheet/mineral/wood
	material_drop_amount = 5
	open_sound = 'sound/machines/closet/wooden_closet_open.ogg'
	close_sound = 'sound/machines/closet/wooden_closet_close.ogg'
	open_sound_volume = 25
	close_sound_volume = 50
	can_install_electronics = FALSE
	paint_jobs = null
	elevation_open = 0
	can_weld_shut = FALSE
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 5)

/obj/structure/closet/crate/coffin/get_ru_names()
	return alist(
		NOMINATIVE = "гроб",
		GENITIVE = "гроба",
		DATIVE = "гробу",
		ACCUSATIVE = "гроб",
		INSTRUMENTAL = "гробом",
		PREPOSITIONAL = "гробе",
	)

/obj/structure/closet/crate/trashcart //please make this a generic cart path later after things calm down a little
	desc = "Тяжёлая металлическая мусорная тележка на колёсах."
	name = "trash cart"
	gender = FEMALE
	icon_state = "trashcart"
	base_icon_state = "trashcart"
	can_install_electronics = FALSE
	paint_jobs = null
	weld_z = 5

/obj/structure/closet/crate/trashcart/get_ru_names()
	return alist(
		NOMINATIVE = "мусорная тележка",
		GENITIVE = "мусорной тележки",
		DATIVE = "мусорной тележке",
		ACCUSATIVE = "мусорную тележку",
		INSTRUMENTAL = "мусорной тележкой",
		PREPOSITIONAL = "мусорной тележке",
	)

/obj/structure/closet/crate/trashcart/laundry
	name = "laundry cart"
	desc = "Большая тележка для перевозки большого количества белья."
	gender = FEMALE
	icon_state = "laundry"
	base_icon_state = "laundry"
	elevation = 14
	elevation_open = 14
	can_weld_shut = FALSE

/obj/structure/closet/crate/trashcart/laundry/get_ru_names()
	return alist(
		NOMINATIVE = "тележка для белья",
		GENITIVE = "тележки для белья",
		DATIVE = "тележке для белья",
		ACCUSATIVE = "тележку для белья",
		INSTRUMENTAL = "тележкой для белья",
		PREPOSITIONAL = "тележке для белья",
	)

/obj/structure/closet/crate/trashcart/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_SLUDGE, CELL_VIRUS_TABLE_GENERIC, rand(2,3), 15)
	AddElement(/datum/element/noisy_movement)

/obj/structure/closet/crate/trashcart/filled

/obj/structure/closet/crate/trashcart/filled/Initialize(mapload)
	. = ..()
	if(mapload)
		new /obj/effect/spawner/random/trash/grime(loc) //needs to be done before the trashcart is opened because it spawns things in a range outside of the trashcart

/obj/structure/closet/crate/trashcart/filled/PopulateContents()
	. = ..()
	for(var/i in 1 to rand(7,15))
		new /obj/effect/spawner/random/trash/garbage(src)
		if(prob(12))
			new /obj/item/storage/bag/trash/filled(src)

/obj/structure/closet/crate/internals
	desc = "Ящик с дыхательным снаряжением."
	name = "internals crate"
	gender = MALE
	icon_state = "o2crate"
	base_icon_state = "o2crate"

/obj/structure/closet/crate/internals/get_ru_names()
	return alist(
		NOMINATIVE = "ящик с дыхательным снаряжением",
		GENITIVE = "ящика с дыхательным снаряжением",
		DATIVE = "ящику с дыхательным снаряжением",
		ACCUSATIVE = "ящик с дыхательным снаряжением",
		INSTRUMENTAL = "ящиком с дыхательным снаряжением",
		PREPOSITIONAL = "ящике с дыхательным снаряжением",
	)

/obj/structure/closet/crate/medical
	desc = "Медицинский ящик."
	name = "medical crate"
	gender = MALE
	icon_state = "medicalcrate"
	base_icon_state = "medicalcrate"

/obj/structure/closet/crate/medical/get_ru_names()
	return alist(
		NOMINATIVE = "медицинский ящик",
		GENITIVE = "медицинского ящика",
		DATIVE = "медицинскому ящику",
		ACCUSATIVE = "медицинский ящик",
		INSTRUMENTAL = "медицинским ящиком",
		PREPOSITIONAL = "медицинском ящике",
	)

/obj/structure/closet/crate/deforest
	name = "deforest medical crate"
	desc = "Ящик медицинских принадлежностей марки DeForest."
	gender = MALE
	icon_state = "deforest"
	base_icon_state = "deforest"

/obj/structure/closet/crate/deforest/get_ru_names()
	return alist(
		NOMINATIVE = "медицинский ящик DeForest",
		GENITIVE = "медицинского ящика DeForest",
		DATIVE = "медицинскому ящику DeForest",
		ACCUSATIVE = "медицинский ящик DeForest",
		INSTRUMENTAL = "медицинским ящиком DeForest",
		PREPOSITIONAL = "медицинском ящике DeForest",
	)

/obj/structure/closet/crate/medical/department
	icon_state = "medical"
	base_icon_state = "medical"

/obj/structure/closet/crate/freezer
	desc = "Морозильник."
	name = "freezer"
	gender = MALE
	icon_state = "freezer"
	base_icon_state = "freezer"
	paint_jobs = null
	sealed = TRUE
	/// The rate at which the internal air mixture cools
	var/cooling_rate_per_second = 4
	/// Minimum temperature of the internal air mixture
	var/minimum_temperature = T0C - 60

/obj/structure/closet/crate/freezer/get_ru_names()
	return alist(
		NOMINATIVE = "морозильник",
		GENITIVE = "морозильника",
		DATIVE = "морозильнику",
		ACCUSATIVE = "морозильник",
		INSTRUMENTAL = "морозильником",
		PREPOSITIONAL = "морозильнике",
	)

/obj/structure/closet/crate/freezer/process_internal_air(seconds_per_tick)
	if(opened)
		var/datum/gas_mixture/current_exposed_air = loc.return_air()
		if(!current_exposed_air)
			return
		// The internal air won't cool down the external air when the freezer is opened.
		internal_air.temperature = max(current_exposed_air.temperature, internal_air.temperature)
		return ..()
	else
		if(internal_air.temperature <= minimum_temperature)
			return
		var/temperature_decrease_this_tick = min(cooling_rate_per_second * seconds_per_tick, internal_air.temperature - minimum_temperature)
		internal_air.temperature -= temperature_decrease_this_tick

/obj/structure/closet/crate/freezer/blood
	name = "blood freezer"
	desc = "Морозильник с пакетами крови."
	gender = MALE

/obj/structure/closet/crate/freezer/blood/get_ru_names()
	return alist(
		NOMINATIVE = "морозильник для крови",
		GENITIVE = "морозильника для крови",
		DATIVE = "морозильнику для крови",
		ACCUSATIVE = "морозильник для крови",
		INSTRUMENTAL = "морозильником для крови",
		PREPOSITIONAL = "морозильнике для крови",
	)

/obj/structure/closet/crate/freezer/blood/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/blood(src)
	new /obj/item/reagent_containers/blood(src)
	new /obj/item/reagent_containers/blood/a_minus(src)
	new /obj/item/reagent_containers/blood/b_minus(src)
	new /obj/item/reagent_containers/blood/b_plus(src)
	new /obj/item/reagent_containers/blood/o_minus(src)
	new /obj/item/reagent_containers/blood/o_plus(src)
	new /obj/item/reagent_containers/blood/lizard(src)
	new /obj/item/reagent_containers/blood/ethereal(src)
	for(var/i in 1 to 3)
		new /obj/item/reagent_containers/blood/random(src)
	new /obj/item/paper/fluff/jobs/medical/blood_types(src)

/obj/structure/closet/crate/freezer/surplus_limbs
	name = "surplus prosthetic limbs"
	desc = "Ящик с ассортиментом дешёвых протезов конечностей."
	gender = MALE

/obj/structure/closet/crate/freezer/surplus_limbs/get_ru_names()
	return alist(
		NOMINATIVE = "ящик с протезами",
		GENITIVE = "ящика с протезами",
		DATIVE = "ящику с протезами",
		ACCUSATIVE = "ящик с протезами",
		INSTRUMENTAL = "ящиком с протезами",
		PREPOSITIONAL = "ящике с протезами",
	)

/obj/structure/closet/crate/freezer/surplus_limbs/PopulateContents()
	. = ..()
	new /obj/item/bodypart/arm/left/robot/surplus(src)
	new /obj/item/bodypart/arm/left/robot/surplus(src)
	new /obj/item/bodypart/arm/right/robot/surplus(src)
	new /obj/item/bodypart/arm/right/robot/surplus(src)
	new /obj/item/bodypart/leg/left/robot/surplus(src)
	new /obj/item/bodypart/leg/left/robot/surplus(src)
	new /obj/item/bodypart/leg/right/robot/surplus(src)
	new /obj/item/bodypart/leg/right/robot/surplus(src)

/obj/structure/closet/crate/freezer/organ
	name = "organ freezer"
	desc = "Морозильник с набором органических органов."
	gender = MALE

/obj/structure/closet/crate/freezer/organ/get_ru_names()
	return alist(
		NOMINATIVE = "морозильник для органов",
		GENITIVE = "морозильника для органов",
		DATIVE = "морозильнику для органов",
		ACCUSATIVE = "морозильник для органов",
		INSTRUMENTAL = "морозильником для органов",
		PREPOSITIONAL = "морозильнике для органов",
	)

/obj/structure/closet/crate/freezer/organ/PopulateContents()
	. = ..()
	new /obj/item/organ/heart(src)
	new /obj/item/organ/lungs(src)
	new /obj/item/organ/eyes(src)
	new /obj/item/organ/ears(src)
	new /obj/item/organ/tongue(src)
	new /obj/item/organ/liver(src)
	new /obj/item/organ/stomach(src)
	new /obj/item/organ/appendix(src)

/obj/structure/closet/crate/freezer/food
	name = "food icebox"
	gender = MALE
	icon_state = "food"
	base_icon_state = "food"

/obj/structure/closet/crate/freezer/food/get_ru_names()
	return alist(
		NOMINATIVE = "ящик для еды",
		GENITIVE = "ящика для еды",
		DATIVE = "ящику для еды",
		ACCUSATIVE = "ящик для еды",
		INSTRUMENTAL = "ящиком для еды",
		PREPOSITIONAL = "ящике для еды",
	)

/obj/structure/closet/crate/freezer/donk
	name = "\improper Donk Co. fridge"
	desc = "Холодильник марки Donk Co. — сохраняет ваши донк-покеты и пенные боеприпасы свежими!"
	gender = MALE
	icon_state = "donkcocrate"
	base_icon_state = "donkcocrate"

/obj/structure/closet/crate/freezer/donk/get_ru_names()
	return alist(
		NOMINATIVE = "холодильник Donk Co.",
		GENITIVE = "холодильника Donk Co.",
		DATIVE = "холодильнику Donk Co.",
		ACCUSATIVE = "холодильник Donk Co.",
		INSTRUMENTAL = "холодильником Donk Co.",
		PREPOSITIONAL = "холодильнике Donk Co.",
	)

/obj/structure/closet/crate/self
	name = "\improper S.E.L.F. crate"
	desc = "Прочно выглядящий ящик с, казалось бы, декоративным голографическим дисплеем. Лицевая часть ящика гордо заявляет о своей принадлежности к печально известной террористической группировке 'S.E.L.F'."
	gender = MALE
	icon_state = "selfcrate"
	base_icon_state = "selfcrate"

/obj/structure/closet/crate/self/get_ru_names()
	return alist(
		NOMINATIVE = "ящик S.E.L.F.",
		GENITIVE = "ящика S.E.L.F.",
		DATIVE = "ящику S.E.L.F.",
		ACCUSATIVE = "ящик S.E.L.F.",
		INSTRUMENTAL = "ящиком S.E.L.F.",
		PREPOSITIONAL = "ящике S.E.L.F.",
	)

/obj/structure/closet/crate/radiation
	desc = "Ящик с символом радиации на нём."
	name = "radiation crate"
	gender = MALE
	icon_state = "radiation"
	base_icon_state = "radiation"

/obj/structure/closet/crate/radiation/get_ru_names()
	return alist(
		NOMINATIVE = "ящик радиационной защиты",
		GENITIVE = "ящика радиационной защиты",
		DATIVE = "ящику радиационной защиты",
		ACCUSATIVE = "ящик радиационной защиты",
		INSTRUMENTAL = "ящиком радиационной защиты",
		PREPOSITIONAL = "ящике радиационной защиты",
	)

/obj/structure/closet/crate/hydroponics
	name = "hydroponics crate"
	desc = "Всё необходимое для уничтожения этих надоедливых сорняков и вредителей."
	gender = MALE
	icon_state = "hydrocrate"
	base_icon_state = "hydrocrate"

/obj/structure/closet/crate/hydroponics/get_ru_names()
	return alist(
		NOMINATIVE = "ящик гидропоники",
		GENITIVE = "ящика гидропоники",
		DATIVE = "ящику гидропоники",
		ACCUSATIVE = "ящик гидропоники",
		INSTRUMENTAL = "ящиком гидропоники",
		PREPOSITIONAL = "ящике гидропоники",
	)

/obj/structure/closet/crate/centcom
	name = "centcom crate"
	gender = MALE
	icon_state = "centcom"
	base_icon_state = "centcom"

/obj/structure/closet/crate/centcom/get_ru_names()
	return alist(
		NOMINATIVE = "ящик Центкома",
		GENITIVE = "ящика Центкома",
		DATIVE = "ящику Центкома",
		ACCUSATIVE = "ящик Центкома",
		INSTRUMENTAL = "ящиком Центкома",
		PREPOSITIONAL = "ящике Центкома",
	)

/obj/structure/closet/crate/cargo
	name = "cargo crate"
	gender = MALE
	icon_state = "cargo"
	base_icon_state = "cargo"

/obj/structure/closet/crate/cargo/get_ru_names()
	return alist(
		NOMINATIVE = "грузовой ящик",
		GENITIVE = "грузового ящика",
		DATIVE = "грузовому ящику",
		ACCUSATIVE = "грузовой ящик",
		INSTRUMENTAL = "грузовым ящиком",
		PREPOSITIONAL = "грузовом ящике",
	)

/obj/structure/closet/crate/robust
	name = "robust industries crate"
	desc = "Ящик Robust Industries LLC. Вызывает странную ностальгию."
	gender = MALE
	icon_state = "robust"
	base_icon_state = "robust"

/obj/structure/closet/crate/robust/get_ru_names()
	return alist(
		NOMINATIVE = "ящик Robust Industries",
		GENITIVE = "ящика Robust Industries",
		DATIVE = "ящику Robust Industries",
		ACCUSATIVE = "ящик Robust Industries",
		INSTRUMENTAL = "ящиком Robust Industries",
		PREPOSITIONAL = "ящике Robust Industries",
	)

/obj/structure/closet/crate/cargo/mining
	name = "mining crate"
	gender = MALE
	icon_state = "mining"
	base_icon_state = "mining"

/obj/structure/closet/crate/cargo/mining/get_ru_names()
	return alist(
		NOMINATIVE = "шахтёрский ящик",
		GENITIVE = "шахтёрского ящика",
		DATIVE = "шахтёрскому ящику",
		ACCUSATIVE = "шахтёрский ящик",
		INSTRUMENTAL = "шахтёрским ящиком",
		PREPOSITIONAL = "шахтёрском ящике",
	)

/obj/structure/closet/crate/engineering
	name = "engineering crate"
	gender = MALE
	icon_state = "engi_crate"
	base_icon_state = "engi_crate"

/obj/structure/closet/crate/engineering/get_ru_names()
	return alist(
		NOMINATIVE = "инженерный ящик",
		GENITIVE = "инженерного ящика",
		DATIVE = "инженерному ящику",
		ACCUSATIVE = "инженерный ящик",
		INSTRUMENTAL = "инженерным ящиком",
		PREPOSITIONAL = "инженерном ящике",
	)

/obj/structure/closet/crate/nakamura
	name = "nakamura engineering crate"
	desc = "Ящик от Nakamura Engineering, скорее всего, содержит инженерные припасы или MOD-ядра."
	gender = MALE
	icon_state = "nakamura"
	base_icon_state = "nakamura"

/obj/structure/closet/crate/nakamura/get_ru_names()
	return alist(
		NOMINATIVE = "инженерный ящик Nakamura",
		GENITIVE = "инженерного ящика Nakamura",
		DATIVE = "инженерному ящику Nakamura",
		ACCUSATIVE = "инженерный ящик Nakamura",
		INSTRUMENTAL = "инженерным ящиком Nakamura",
		PREPOSITIONAL = "инженерном ящике Nakamura",
	)

/obj/structure/closet/crate/engineering/electrical
	icon_state = "engi_e_crate"
	base_icon_state = "engi_e_crate"

/obj/structure/closet/crate/engineering/atmos
	name = "atmospherics crate"
	gender = MALE
	icon_state = "atmos"
	base_icon_state = "atmos"

/obj/structure/closet/crate/engineering/atmos/get_ru_names()
	return alist(
		NOMINATIVE = "атмосферный ящик",
		GENITIVE = "атмосферного ящика",
		DATIVE = "атмосферному ящику",
		ACCUSATIVE = "атмосферный ящик",
		INSTRUMENTAL = "атмосферным ящиком",
		PREPOSITIONAL = "атмосферном ящике",
	)

/obj/structure/closet/crate/rcd
	desc = "Ящик для хранения РСУ."
	name = "\improper RCD crate"
	gender = MALE
	icon_state = "engi_crate"
	base_icon_state = "engi_crate"

/obj/structure/closet/crate/rcd/get_ru_names()
	return alist(
		NOMINATIVE = "ящик для РСУ",
		GENITIVE = "ящика для РСУ",
		DATIVE = "ящику для РСУ",
		ACCUSATIVE = "ящик для РСУ",
		INSTRUMENTAL = "ящиком для РСУ",
		PREPOSITIONAL = "ящике для РСУ",
	)

/obj/structure/closet/crate/rcd/PopulateContents()
	..()
	for(var/i in 1 to 4)
		new /obj/item/rcd_ammo(src)
	new /obj/item/construction/rcd(src)

/obj/structure/closet/crate/science
	name = "science crate"
	desc = "Научный ящик."
	gender = MALE
	icon_state = "scicrate"
	base_icon_state = "scicrate"

/obj/structure/closet/crate/science/get_ru_names()
	return alist(
		NOMINATIVE = "научный ящик",
		GENITIVE = "научного ящика",
		DATIVE = "научному ящику",
		ACCUSATIVE = "научный ящик",
		INSTRUMENTAL = "научным ящиком",
		PREPOSITIONAL = "научном ящике",
	)

/obj/structure/closet/crate/science/robo
	name = "robotics crate"
	gender = MALE
	icon_state = "robo"
	base_icon_state = "robo"

/obj/structure/closet/crate/science/robo/get_ru_names()
	return alist(
		NOMINATIVE = "ящик робототехники",
		GENITIVE = "ящика робототехники",
		DATIVE = "ящику робототехники",
		ACCUSATIVE = "ящик робототехники",
		INSTRUMENTAL = "ящиком робототехники",
		PREPOSITIONAL = "ящике робототехники",
	)

/obj/structure/closet/crate/mod
	name = "MOD crate"
	gender = MALE
	icon_state = "robo"
	base_icon_state = "robo"

/obj/structure/closet/crate/mod/get_ru_names()
	return alist(
		NOMINATIVE = "ящик MOD",
		GENITIVE = "ящика MOD",
		DATIVE = "ящику MOD",
		ACCUSATIVE = "ящик MOD",
		INSTRUMENTAL = "ящиком MOD",
		PREPOSITIONAL = "ящике MOD",
	)

/obj/structure/closet/crate/mod/PopulateContents()
	..()
	for(var/i in 1 to 3)
		new /obj/item/mod/core/standard(src)
	for(var/i in 1 to 2)
		new /obj/item/clothing/neck/link_scryer/loaded(src)

/obj/structure/closet/crate/solarpanel_small
	name = "budget solar panel crate"
	gender = MALE
	icon_state = "engi_e_crate"
	base_icon_state = "engi_e_crate"

/obj/structure/closet/crate/solarpanel_small/get_ru_names()
	return alist(
		NOMINATIVE = "бюджетный ящик солнечных панелей",
		GENITIVE = "бюджетного ящика солнечных панелей",
		DATIVE = "бюджетному ящику солнечных панелей",
		ACCUSATIVE = "бюджетный ящик солнечных панелей",
		INSTRUMENTAL = "бюджетным ящиком солнечных панелей",
		PREPOSITIONAL = "бюджетном ящике солнечных панелей",
	)

/obj/structure/closet/crate/solarpanel_small/PopulateContents()
	..()
	for(var/i in 1 to 13)
		new /obj/item/solar_assembly(src)
	new /obj/item/circuitboard/computer/solar_control(src)
	new /obj/item/paper/guides/jobs/engi/solars(src)
	new /obj/item/electronics/tracker(src)

/obj/structure/closet/crate/goldcrate
	name = "gold crate"
	desc = "Прямоугольный стальной ящик. Похоже, он покрашен под золото."
	gender = MALE
	icon_state = "gold"
	base_icon_state = "gold"

/obj/structure/closet/crate/goldcrate/get_ru_names()
	return alist(
		NOMINATIVE = "золотой ящик",
		GENITIVE = "золотого ящика",
		DATIVE = "золотому ящику",
		ACCUSATIVE = "золотой ящик",
		INSTRUMENTAL = "золотым ящиком",
		PREPOSITIONAL = "золотом ящике",
	)

/obj/structure/closet/crate/goldcrate/PopulateContents()
	..()
	new /obj/item/storage/belt/champion(src)

/obj/structure/closet/crate/goldcrate/populate_contents_immediate()
	. = ..()

	for(var/i in 1 to 3)
		new /obj/item/stack/sheet/mineral/gold(src, 1, FALSE)

/obj/structure/closet/crate/silvercrate
	name = "silver crate"
	desc = "Прямоугольный стальной ящик. Похоже, он покрашен под серебро."
	gender = MALE
	icon_state = "silver"
	base_icon_state = "silver"

/obj/structure/closet/crate/silvercrate/get_ru_names()
	return alist(
		NOMINATIVE = "серебряный ящик",
		GENITIVE = "серебряного ящика",
		DATIVE = "серебряному ящику",
		ACCUSATIVE = "серебряный ящик",
		INSTRUMENTAL = "серебряным ящиком",
		PREPOSITIONAL = "серебряном ящике",
	)

/obj/structure/closet/crate/silvercrate/PopulateContents()
	..()
	for(var/i in 1 to 5)
		new /obj/item/coin/silver(src)

/obj/structure/closet/crate/decorations
	icon_state = "engi_crate"
	base_icon_state = "engi_crate"

/obj/structure/closet/crate/decorations/PopulateContents()
	. = ..()
	for(var/i in 1 to 4)
		new /obj/effect/spawner/random/decoration/generic(src)

/obj/structure/closet/crate/add_to_roundstart_list()
	return

/obj/structure/closet/crate/glitter
	name = "pink crate"
	desc = "Блестящий розовый ящик."
	gender = MALE
	icon_state = "pink"
	base_icon_state = "pink"
	var/glitter_prob = 25
	var/glitter_color = "#ff8080"

/obj/structure/closet/crate/glitter/get_ru_names()
	return alist(
		NOMINATIVE = "розовый ящик",
		GENITIVE = "розового ящика",
		DATIVE = "розовому ящику",
		ACCUSATIVE = "розовый ящик",
		INSTRUMENTAL = "розовым ящиком",
		PREPOSITIONAL = "розовом ящике",
	)

/obj/structure/closet/crate/glitter/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	. = ..()

	var/turf/old_turf = get_turf(old_loc)
	if(!old_turf)
		return
	if(prob(glitter_prob))
		old_turf.spawn_glitter(list("[glitter_color]" = 100))

/obj/structure/closet/crate/glitter/lavender
	name = "lavender crate"
	desc = "Блестящий фиолетовый... нет, лавандовый ящик."
	gender = MALE
	icon_state = "lavender"
	base_icon_state = "lavender"
	glitter_color = "#db80ff"

/obj/structure/closet/crate/glitter/lavender/get_ru_names()
	return alist(
		NOMINATIVE = "лавандовый ящик",
		GENITIVE = "лавандового ящика",
		DATIVE = "лавандовому ящику",
		ACCUSATIVE = "лавандовый ящик",
		INSTRUMENTAL = "лавандовым ящиком",
		PREPOSITIONAL = "лавандовом ящике",
	)
