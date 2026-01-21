/obj/structure/closet/secure_closet/captains
	name = "captain's locker"
	gender = MALE
	icon_state = "cap"
	req_access = list(ACCESS_CAPTAIN)

/obj/structure/closet/secure_closet/captains/get_ru_names()
	return alist(
		NOMINATIVE = "шкаф капитана",
		GENITIVE = "шкафа капитана",
		DATIVE = "шкафу капитана",
		ACCUSATIVE = "шкаф капитана",
		INSTRUMENTAL = "шкафом капитана",
		PREPOSITIONAL = "шкафе капитана",
	)

/obj/structure/closet/secure_closet/captains/PopulateContents()
	..()
	new /obj/item/clothing/neck/petcollar(src)
	new /obj/item/pet_carrier(src)
	new /obj/item/storage/bag/garment/captain(src)
	new /obj/item/computer_disk/command/captain(src)
	new /obj/item/radio/headset/heads/captain/alt(src)
	new /obj/item/radio/headset/heads/captain(src)
	new /obj/item/door_remote/captain(src)
	new /obj/item/storage/photo_album/captain(src)
	new /obj/item/megaphone/command(src)

/obj/structure/closet/secure_closet/captains/populate_contents_immediate()
	new /obj/item/gun/energy/e_gun(src)
	new /obj/item/storage/belt/sheath/sabre(src)

/obj/structure/closet/secure_closet/hop
	name = "head of personnel's locker"
	gender = MALE
	icon_state = "hop"
	req_access = list(ACCESS_HOP)

/obj/structure/closet/secure_closet/hop/get_ru_names()
	return alist(
		NOMINATIVE = "шкаф главы персонала",
		GENITIVE = "шкафа главы персонала",
		DATIVE = "шкафу главы персонала",
		ACCUSATIVE = "шкаф главы персонала",
		INSTRUMENTAL = "шкафом главы персонала",
		PREPOSITIONAL = "шкафе главы персонала",
	)

/obj/structure/closet/secure_closet/hop/PopulateContents()
	..()
	new /obj/item/dog_bone(src)
	new /obj/item/storage/bag/garment/hop(src)
	new /obj/item/storage/lockbox/medal/service(src)
	new /obj/item/computer_disk/command/hop(src)
	new /obj/item/radio/headset/heads/hop(src)
	new /obj/item/storage/box/ids(src)
	new /obj/item/storage/box/silver_ids(src)
	new /obj/item/megaphone/command(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/clothing/neck/petcollar(src)
	new /obj/item/pet_carrier(src)
	new /obj/item/door_remote/head_of_personnel(src)
	new /obj/item/circuitboard/machine/techfab/department/service(src)
	new /obj/item/storage/photo_album/hop(src)
	new /obj/item/storage/lockbox/medal/hop(src)

/obj/structure/closet/secure_closet/hop/populate_contents_immediate()
	new /obj/item/gun/energy/e_gun(src)

/obj/structure/closet/secure_closet/hos
	name = "head of security's locker"
	gender = MALE
	icon_state = "hos"
	req_access = list(ACCESS_HOS)

/obj/structure/closet/secure_closet/hos/get_ru_names()
	return alist(
		NOMINATIVE = "шкаф главы службы безопасности",
		GENITIVE = "шкафа главы службы безопасности",
		DATIVE = "шкафу главы службы безопасности",
		ACCUSATIVE = "шкаф главы службы безопасности",
		INSTRUMENTAL = "шкафом главы службы безопасности",
		PREPOSITIONAL = "шкафе главы службы безопасности",
	)

/obj/structure/closet/secure_closet/hos/PopulateContents()
	..()

	new /obj/item/computer_disk/command/hos(src)
	new /obj/item/radio/headset/heads/hos(src)
	new /obj/item/radio/headset/heads/hos/alt(src)
	new /obj/item/storage/bag/garment/hos(src)
	new /obj/item/storage/lockbox/medal/sec(src)
	new /obj/item/megaphone/sec(src)
	new /obj/item/holosign_creator/security(src)
	new /obj/item/storage/lockbox/loyalty(src)
	new /obj/item/storage/box/flashbangs(src)
	new /obj/item/shield/riot/tele(src)
	new /obj/item/storage/belt/security/full(src)
	new /obj/item/circuitboard/machine/techfab/department/security(src)
	new /obj/item/storage/photo_album/hos(src)

/obj/structure/closet/secure_closet/hos/populate_contents_immediate()
	. = ..()

	// Traitor steal objectives
	new /obj/item/gun/energy/e_gun/hos(src)
	new /obj/item/pinpointer/nuke(src)

/obj/structure/closet/secure_closet/warden
	name = "warden's locker"
	gender = MALE
	icon_state = "warden"
	req_access = list(ACCESS_ARMORY)

/obj/structure/closet/secure_closet/warden/get_ru_names()
	return alist(
		NOMINATIVE = "шкаф смотрителя",
		GENITIVE = "шкафа смотрителя",
		DATIVE = "шкафу смотрителя",
		ACCUSATIVE = "шкаф смотрителя",
		INSTRUMENTAL = "шкафом смотрителя",
		PREPOSITIONAL = "шкафе смотрителя",
	)

/obj/structure/closet/secure_closet/warden/PopulateContents()
	..()
	new /obj/item/dog_bone(src)
	new /obj/item/radio/headset/headset_sec(src)
	new /obj/item/holosign_creator/security(src)
	new /obj/item/storage/bag/garment/warden(src)
	new /obj/item/storage/box/zipties(src)
	new /obj/item/storage/box/flashbangs(src)
	new /obj/item/storage/belt/security/full(src)
	new /obj/item/flashlight/seclite(src)
	new /obj/item/door_remote/head_of_security(src)
	new /obj/item/storage/belt/bandolier(src)


/obj/structure/closet/secure_closet/warden/populate_contents_immediate()
	. = ..()

	// Traitor steal objective
	new /obj/item/gun/ballistic/shotgun/automatic/combat/compact(src)

/obj/structure/closet/secure_closet/security
	name = "security officer's locker"
	gender = MALE
	icon_state = "sec"
	req_access = list(ACCESS_BRIG)

/obj/structure/closet/secure_closet/security/get_ru_names()
	return alist(
		NOMINATIVE = "шкаф офицера СБ",
		GENITIVE = "шкафа офицера СБ",
		DATIVE = "шкафу офицера СБ",
		ACCUSATIVE = "шкаф офицера СБ",
		INSTRUMENTAL = "шкафом офицера СБ",
		PREPOSITIONAL = "шкафе офицера СБ",
	)

/obj/structure/closet/secure_closet/security/PopulateContents()
	..()
	new /obj/item/clothing/suit/armor/vest/alt/sec(src)
	new /obj/item/clothing/head/helmet/sec(src)
	new /obj/item/radio/headset/headset_sec(src)
	new /obj/item/radio/headset/headset_sec/alt(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses(src)
	new /obj/item/flashlight/seclite(src)
	new /obj/item/clothing/gloves/tackler(src)

/obj/structure/closet/secure_closet/security/sec

/obj/structure/closet/secure_closet/security/sec/PopulateContents()
	..()
	new /obj/item/storage/belt/security/full(src)

/obj/structure/closet/secure_closet/security/cargo

/obj/structure/closet/secure_closet/security/cargo/PopulateContents()
	..()
	new /obj/item/clothing/accessory/armband/cargo(src)
	new /obj/item/encryptionkey/headset_cargo(src)

/obj/structure/closet/secure_closet/security/engine

/obj/structure/closet/secure_closet/security/engine/PopulateContents()
	..()
	new /obj/item/clothing/accessory/armband/engine(src)
	new /obj/item/encryptionkey/headset_eng(src)

/obj/structure/closet/secure_closet/security/science

/obj/structure/closet/secure_closet/security/science/PopulateContents()
	..()
	new /obj/item/clothing/accessory/armband/science(src)
	new /obj/item/encryptionkey/headset_sci(src)

/obj/structure/closet/secure_closet/security/med

/obj/structure/closet/secure_closet/security/med/PopulateContents()
	..()
	new /obj/item/clothing/accessory/armband/medblue(src)
	new /obj/item/encryptionkey/headset_med(src)

/obj/structure/closet/secure_closet/detective
	name = "\improper detective's cabinet"
	gender = MALE
	icon_state = "cabinet"
	resistance_flags = FLAMMABLE
	max_integrity = 70
	door_anim_time = 0 // no animation
	open_sound = 'sound/machines/closet/wooden_closet_open.ogg'
	close_sound = 'sound/machines/closet/wooden_closet_close.ogg'
	req_access = list(ACCESS_DETECTIVE)

/obj/structure/closet/secure_closet/detective/get_ru_names()
	return alist(
		NOMINATIVE = "шкаф детектива",
		GENITIVE = "шкафа детектива",
		DATIVE = "шкафу детектива",
		ACCUSATIVE = "шкаф детектива",
		INSTRUMENTAL = "шкафом детектива",
		PREPOSITIONAL = "шкафе детектива",
	)

/obj/structure/closet/secure_closet/detective/PopulateContents()
	..()
	new /obj/item/storage/box/evidence(src)
	new /obj/item/radio/headset/headset_sec(src)
	new /obj/item/detective_scanner(src)
	new /obj/item/flashlight/seclite(src)
	new /obj/item/holosign_creator/security(src)
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/clothing/suit/armor/vest/det_suit(src)
	new /obj/item/storage/belt/holster/detective/full(src)
	new /obj/item/pinpointer/crew(src)
	new /obj/item/binoculars(src)
	new /obj/item/storage/box/rxglasses/spyglasskit(src)
	new /obj/item/clothing/head/fedora/inspector_hat(src)

/obj/structure/closet/secure_closet/injection
	name = "lethal injections locker"
	gender = MALE
	req_access = list(ACCESS_ARMORY)

/obj/structure/closet/secure_closet/injection/get_ru_names()
	return alist(
		NOMINATIVE = "шкаф со смертельными инъекциями",
		GENITIVE = "шкафа со смертельными инъекциями",
		DATIVE = "шкафу со смертельными инъекциями",
		ACCUSATIVE = "шкаф со смертельными инъекциями",
		INSTRUMENTAL = "шкафом со смертельными инъекциями",
		PREPOSITIONAL = "шкафе со смертельными инъекциями",
	)

/obj/structure/closet/secure_closet/injection/PopulateContents()
	..()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/syringe/lethal/execution(src)

/obj/structure/closet/secure_closet/brig
	name = "brig locker"
	gender = MALE
	anchored = TRUE
	req_one_access = list(ACCESS_BRIG)
	var/id = null

/obj/structure/closet/secure_closet/brig/get_ru_names()
	return alist(
		NOMINATIVE = "шкаф брига",
		GENITIVE = "шкафа брига",
		DATIVE = "шкафу брига",
		ACCUSATIVE = "шкаф брига",
		INSTRUMENTAL = "шкафом брига",
		PREPOSITIONAL = "шкафе брига",
	)

/obj/structure/closet/secure_closet/brig/genpop
	name = "genpop storage locker"
	desc = "Используется для хранения личных вещей туристов, посещающих местных жителей."
	access_choices = FALSE
	paint_jobs = null

/obj/structure/closet/secure_closet/brig/genpop/get_ru_names()
	return alist(
		NOMINATIVE = "шкаф общего режима",
		GENITIVE = "шкафа общего режима",
		DATIVE = "шкафу общего режима",
		ACCUSATIVE = "шкаф общего режима",
		INSTRUMENTAL = "шкафом общего режима",
		PREPOSITIONAL = "шкафе общего режима",
	)

/obj/structure/closet/secure_closet/brig/genpop/examine(mob/user)
	. = ..()
	. += span_notice("<b>Нажмите ПКМ</b> с ID картой уровня СБ, чтобы сбросить зарегистрированный ID на [RU_SRC_PRE].")

/obj/structure/closet/secure_closet/brig/genpop/attackby(obj/item/card/id/advanced/prisoner/user_id, mob/user, list/modifiers, list/attack_modifiers)
	if(!secure || !istype(user_id))
		return ..()

	if(isnull(id_card))
		say("ID заключённого привязан к шкафу.")
		id_card = WEAKREF(user_id)
		name = "шкаф общего режима - [user_id.registered_name]"

/obj/structure/closet/secure_closet/brig/genpop/proc/clear_access()
	say("Обнаружен авторизованный ID. Разблокировка шкафа и сброс ID.")
	locked = FALSE
	id_card = null
	name = initial(name)
	update_appearance()

/obj/structure/closet/secure_closet/brig/genpop/attackby_secondary(obj/item/card/id/advanced/used_id, mob/user, list/modifiers, list/attack_modifiers)
	if(!secure || !istype(used_id))
		return ..()

	var/list/id_access = used_id.GetAccess()
	if(!isnull(id_card) && (ACCESS_BRIG in id_access))
		clear_access()

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/structure/closet/secure_closet/evidence
	anchored = TRUE
	name = "secure evidence closet"
	gender = MALE
	req_one_access = list(ACCESS_ARMORY, ACCESS_DETECTIVE)

/obj/structure/closet/secure_closet/evidence/get_ru_names()
	return alist(
		NOMINATIVE = "защищённый шкаф для улик",
		GENITIVE = "защищённого шкафа для улик",
		DATIVE = "защищённому шкафу для улик",
		ACCUSATIVE = "защищённый шкаф для улик",
		INSTRUMENTAL = "защищённым шкафом для улик",
		PREPOSITIONAL = "защищённом шкафе для улик",
	)

/obj/structure/closet/secure_closet/brig/PopulateContents()
	..()

	new /obj/item/clothing/under/rank/prisoner( src )
	new /obj/item/clothing/under/rank/prisoner/skirt( src )
	new /obj/item/clothing/shoes/sneakers/orange( src )

/obj/structure/closet/secure_closet/courtroom
	name = "courtroom locker"
	gender = MALE
	req_access = list(ACCESS_COURT)

/obj/structure/closet/secure_closet/courtroom/get_ru_names()
	return alist(
		NOMINATIVE = "шкаф зала суда",
		GENITIVE = "шкафа зала суда",
		DATIVE = "шкафу зала суда",
		ACCUSATIVE = "шкаф зала суда",
		INSTRUMENTAL = "шкафом зала суда",
		PREPOSITIONAL = "шкафе зала суда",
	)

/obj/structure/closet/secure_closet/courtroom/PopulateContents()
	..()
	new /obj/item/clothing/shoes/laceup(src)
	for(var/i in 1 to 3)
		new /obj/item/paper/fluff/jobs/security/court_judgement (src)
	new /obj/item/pen (src)
	new /obj/item/clothing/suit/costume/judgerobe (src)
	new /obj/item/clothing/head/costume/powdered_wig (src)
	new /obj/item/storage/briefcase(src)
	new /obj/item/clothing/under/suit/black_really(src)
	new /obj/item/clothing/neck/tie/red(src)

/obj/structure/closet/secure_closet/contraband/armory
	anchored = TRUE
	name = "contraband locker"
	gender = MALE
	req_access = list(ACCESS_ARMORY)

/obj/structure/closet/secure_closet/contraband/armory/get_ru_names()
	return alist(
		NOMINATIVE = "шкаф для контрабанды",
		GENITIVE = "шкафа для контрабанды",
		DATIVE = "шкафу для контрабанды",
		ACCUSATIVE = "шкаф для контрабанды",
		INSTRUMENTAL = "шкафом для контрабанды",
		PREPOSITIONAL = "шкафе для контрабанды",
	)

/obj/structure/closet/secure_closet/contraband/heads
	name = "contraband locker"
	req_access = list(ACCESS_COMMAND)
	anchored = TRUE

/obj/structure/closet/secure_closet/contraband/heads/get_ru_names()
	return alist(
		NOMINATIVE = "шкаф для контрабанды",
		GENITIVE = "шкафа для контрабанды",
		DATIVE = "шкафу для контрабанды",
		ACCUSATIVE = "шкаф для контрабанды",
		INSTRUMENTAL = "шкафом для контрабанды",
		PREPOSITIONAL = "шкафе для контрабанды",
	)

/obj/structure/closet/secure_closet/armory1
	name = "armory armor locker"
	gender = MALE
	icon_state = "armory"
	req_access = list(ACCESS_ARMORY)

/obj/structure/closet/secure_closet/armory1/get_ru_names()
	return alist(
		NOMINATIVE = "шкаф с бронёй",
		GENITIVE = "шкафа с бронёй",
		DATIVE = "шкафу с бронёй",
		ACCUSATIVE = "шкаф с бронёй",
		INSTRUMENTAL = "шкафом с бронёй",
		PREPOSITIONAL = "шкафе с бронёй",
	)

/obj/structure/closet/secure_closet/armory1/PopulateContents()
	..()
	for(var/i in 1 to 3)
		new /obj/item/clothing/suit/armor/riot(src)
	for(var/i in 1 to 3)
		new /obj/item/clothing/head/helmet/toggleable/riot(src)
	for(var/i in 1 to 3)
		new /obj/item/shield/riot(src)

/obj/structure/closet/secure_closet/armory1/populate_contents_immediate()
	. = ..()

	// Traitor steal objective
	new /obj/item/clothing/suit/hooded/ablative(src)

/obj/structure/closet/secure_closet/armory2
	name = "armory ballistics locker"
	gender = MALE
	icon_state = "tac"
	icon_door = "armory_shotgun"
	req_access = list(ACCESS_ARMORY)

/obj/structure/closet/secure_closet/armory2/get_ru_names()
	return alist(
		NOMINATIVE = "шкаф с баллистическим оружием",
		GENITIVE = "шкафа с баллистическим оружием",
		DATIVE = "шкафу с баллистическим оружием",
		ACCUSATIVE = "шкаф с баллистическим оружием",
		INSTRUMENTAL = "шкафом с баллистическим оружием",
		PREPOSITIONAL = "шкафе с баллистическим оружием",
	)

/obj/structure/closet/secure_closet/armory2/PopulateContents()
	..()
	new /obj/item/storage/box/firingpins(src)
	for(var/i in 1 to 3)
		new /obj/item/storage/box/rubbershot(src)

/obj/structure/closet/secure_closet/armory2/populate_contents_immediate()
	for(var/i in 1 to 3)
		new /obj/item/gun/ballistic/shotgun/riot(src)

/obj/structure/closet/secure_closet/armory3
	name = "armory energy gun locker"
	gender = MALE
	icon_state = "tac"
	icon_door = "armory_energy"
	req_access = list(ACCESS_ARMORY)

/obj/structure/closet/secure_closet/armory3/get_ru_names()
	return alist(
		NOMINATIVE = "шкаф с энергетическим оружием",
		GENITIVE = "шкафа с энергетическим оружием",
		DATIVE = "шкафу с энергетическим оружием",
		ACCUSATIVE = "шкаф с энергетическим оружием",
		INSTRUMENTAL = "шкафом с энергетическим оружием",
		PREPOSITIONAL = "шкафе с энергетическим оружием",
	)

/obj/structure/closet/secure_closet/armory3/PopulateContents()
	..()
	new /obj/item/storage/box/firingpins(src)
	new /obj/item/gun/energy/ionrifle(src)
	for(var/i in 1 to 3)
		new /obj/item/gun/energy/laser/pistol(src)

/obj/structure/closet/secure_closet/armory3/populate_contents_immediate()
	for(var/i in 1 to 3)
		new /obj/item/gun/energy/e_gun(src)
	for(var/i in 1 to 3)
		new /obj/item/gun/energy/laser(src)

/obj/structure/closet/secure_closet/tac
	name = "armory tac locker"
	gender = MALE
	icon_state = "tac"
	req_access = list(ACCESS_ARMORY)

/obj/structure/closet/secure_closet/tac/get_ru_names()
	return alist(
		NOMINATIVE = "тактический шкаф оружейной",
		GENITIVE = "тактического шкафа оружейной",
		DATIVE = "тактическому шкафу оружейной",
		ACCUSATIVE = "тактический шкаф оружейной",
		INSTRUMENTAL = "тактическим шкафом оружейной",
		PREPOSITIONAL = "тактическом шкафе оружейной",
	)

/obj/structure/closet/secure_closet/tac/PopulateContents()
	..()
	new /obj/item/gun/ballistic/automatic/wt550(src)
	new /obj/item/clothing/head/helmet/alt(src)
	new /obj/item/clothing/mask/gas/sechailer(src)
	new /obj/item/clothing/suit/armor/bulletproof(src)

/obj/structure/closet/secure_closet/labor_camp_security
	name = "labor camp security locker"
	gender = MALE
	icon_state = "sec"
	req_access = list(ACCESS_SECURITY)

/obj/structure/closet/secure_closet/labor_camp_security/get_ru_names()
	return alist(
		NOMINATIVE = "шкаф охраны трудового лагеря",
		GENITIVE = "шкафа охраны трудового лагеря",
		DATIVE = "шкафу охраны трудового лагеря",
		ACCUSATIVE = "шкаф охраны трудового лагеря",
		INSTRUMENTAL = "шкафом охраны трудового лагеря",
		PREPOSITIONAL = "шкафе охраны трудового лагеря",
	)

/obj/structure/closet/secure_closet/labor_camp_security/PopulateContents()
	..()
	new /obj/item/clothing/suit/armor/vest(src)
	new /obj/item/clothing/head/helmet/sec(src)
	new /obj/item/clothing/under/rank/security/officer(src)
	new /obj/item/clothing/under/rank/security/officer/skirt(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses(src)
	new /obj/item/flashlight/seclite(src)
