/obj/item/storage/belt
	name = "not actually a toolbelt"
	desc = "Может хранить разные вещи. Это базовый тип /belt, вы уверены, что он у вас должен быть?"
	icon = 'icons/obj/clothing/belts.dmi'
	icon_state = "utility"
	inhand_icon_state = "utility"
	worn_icon_state = "utility"
	lefthand_file = 'icons/mob/inhands/equipment/belt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/belt_righthand.dmi'
	abstract_type = /obj/item/storage/belt
	slot_flags = ITEM_SLOT_BELT
	attack_verb_continuous = list("хлещет", "сечёт", "дисциплинирует")
	attack_verb_simple = list("хлестнуть", "высечь", "дисциплинировать")
	max_integrity = 300
	equip_sound = 'sound/items/equip/toolbelt_equip.ogg'
	w_class = WEIGHT_CLASS_BULKY
	var/content_overlays = FALSE //If this is true, the belt will gain overlays based on what it's holding

/obj/item/storage/belt/get_ru_names()
	return alist(
		NOMINATIVE = "не совсем пояс для инструментов",
		GENITIVE = "не совсем пояса для инструментов",
		DATIVE = "не совсем поясу для инструментов",
		ACCUSATIVE = "не совсем пояс для инструментов",
		INSTRUMENTAL = "не совсем поясом для инструментов",
		PREPOSITIONAL = "не совсем поясе для инструментов",
	)

/obj/item/storage/belt/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("[user] начинает пороть себя [RU_SRC_INS]! Похоже, [user.p_theyre()] пытается совершить суицид!"))
	return BRUTELOSS

/obj/item/storage/belt/update_overlays()
	. = ..()
	if(!content_overlays)
		return
	for(var/obj/item/I in contents)
		. += I.get_belt_overlay()

/obj/item/storage/belt/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/attack_equip)
	update_appearance()

/obj/item/storage/belt/utility
	name = "toolbelt" //Carn: utility belt is nicer, but it bamboozles the text parsing.
	desc = "Хранит инструменты."
	icon_state = "utility"
	inhand_icon_state = "utility"
	worn_icon_state = "utility"
	content_overlays = TRUE
	custom_premium_price = PAYCHECK_CREW * 2
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbelt_pickup.ogg'
	storage_type = /datum/storage/utility_belt

/obj/item/storage/belt/utility/get_ru_names()
	return alist(
		NOMINATIVE = "пояс для инструментов",
		GENITIVE = "пояса для инструментов",
		DATIVE = "поясу для инструментов",
		ACCUSATIVE = "пояс для инструментов",
		INSTRUMENTAL = "поясом для инструментов",
		PREPOSITIONAL = "поясе для инструментов",
	)

/obj/item/storage/belt/utility/chief
	name = "chief engineer's toolbelt"
	desc = "Хранит инструменты, выглядит стильно."
	icon_state = "utility_ce"
	inhand_icon_state = "utility_ce"
	worn_icon_state = "utility_ce"

/obj/item/storage/belt/utility/chief/get_ru_names()
	return alist(
		NOMINATIVE = "пояс главного инженера",
		GENITIVE = "пояса главного инженера",
		DATIVE = "поясу главного инженера",
		ACCUSATIVE = "пояс главного инженера",
		INSTRUMENTAL = "поясом главного инженера",
		PREPOSITIONAL = "поясе главного инженера",
	)

/obj/item/storage/belt/utility/chief/full
	preload = TRUE

/obj/item/storage/belt/utility/chief/full/PopulateContents()
	SSwardrobe.provide_type(/obj/item/screwdriver, src)
	SSwardrobe.provide_type(/obj/item/wrench, src)
	SSwardrobe.provide_type(/obj/item/weldingtool/hugetank, src)
	SSwardrobe.provide_type(/obj/item/crowbar, src)
	SSwardrobe.provide_type(/obj/item/wirecutters, src)
	SSwardrobe.provide_type(/obj/item/multitool, src)
	SSwardrobe.provide_type(/obj/item/stack/cable_coil, src)

/obj/item/storage/belt/utility/chief/full/get_types_to_preload()
	var/list/to_preload = list() //Yes this is a pain. Yes this is the point
	to_preload += /obj/item/screwdriver
	to_preload += /obj/item/wrench
	to_preload += /obj/item/weldingtool/hugetank
	to_preload += /obj/item/crowbar
	to_preload += /obj/item/wirecutters
	to_preload += /obj/item/multitool
	to_preload += /obj/item/stack/cable_coil
	return to_preload

/obj/item/storage/belt/utility/full/PopulateContents()
	SSwardrobe.provide_type(/obj/item/screwdriver, src)
	SSwardrobe.provide_type(/obj/item/wrench, src)
	SSwardrobe.provide_type(/obj/item/weldingtool, src)
	SSwardrobe.provide_type(/obj/item/crowbar, src)
	SSwardrobe.provide_type(/obj/item/wirecutters, src)
	SSwardrobe.provide_type(/obj/item/multitool, src)
	SSwardrobe.provide_type(/obj/item/stack/cable_coil, src)

/obj/item/storage/belt/utility/full/get_types_to_preload()
	var/list/to_preload = list() //Yes this is a pain. Yes this is the point
	to_preload += /obj/item/screwdriver
	to_preload += /obj/item/wrench
	to_preload += /obj/item/weldingtool
	to_preload += /obj/item/crowbar
	to_preload += /obj/item/wirecutters
	to_preload += /obj/item/multitool
	to_preload += /obj/item/stack/cable_coil
	return to_preload

/obj/item/storage/belt/utility/full/powertools
	preload = FALSE

/obj/item/storage/belt/utility/full/powertools/PopulateContents()
	new /obj/item/screwdriver/power(src)
	new /obj/item/crowbar/power(src)
	new /obj/item/weldingtool/experimental(src)
	new /obj/item/multitool(src)
	new /obj/item/holosign_creator/atmos(src)
	new /obj/item/extinguisher/mini(src)
	new /obj/item/stack/cable_coil(src)

/obj/item/storage/belt/utility/full/powertools/rcd/PopulateContents()
	new /obj/item/screwdriver/power(src)
	new /obj/item/crowbar/power(src)
	new /obj/item/weldingtool/experimental(src)
	new /obj/item/multitool(src)
	new /obj/item/construction/rcd/loaded/upgraded(src)
	new /obj/item/extinguisher/mini(src)
	new /obj/item/stack/cable_coil(src)

/obj/item/storage/belt/utility/full/engi/PopulateContents()
	SSwardrobe.provide_type(/obj/item/screwdriver, src)
	SSwardrobe.provide_type(/obj/item/wrench, src)
	SSwardrobe.provide_type(/obj/item/weldingtool/largetank, src)
	SSwardrobe.provide_type(/obj/item/crowbar, src)
	SSwardrobe.provide_type(/obj/item/wirecutters, src)
	SSwardrobe.provide_type(/obj/item/multitool, src)
	SSwardrobe.provide_type(/obj/item/stack/cable_coil, src)

/obj/item/storage/belt/utility/full/engi/get_types_to_preload()
	var/list/to_preload = list() //Yes this is a pain. Yes this is the point
	to_preload += /obj/item/screwdriver
	to_preload += /obj/item/wrench
	to_preload += /obj/item/weldingtool/largetank
	to_preload += /obj/item/crowbar
	to_preload += /obj/item/wirecutters
	to_preload += /obj/item/multitool
	to_preload += /obj/item/stack/cable_coil
	return to_preload

/obj/item/storage/belt/utility/atmostech/PopulateContents()
	SSwardrobe.provide_type(/obj/item/screwdriver, src)
	SSwardrobe.provide_type(/obj/item/wrench, src)
	SSwardrobe.provide_type(/obj/item/weldingtool, src)
	SSwardrobe.provide_type(/obj/item/crowbar, src)
	SSwardrobe.provide_type(/obj/item/wirecutters, src)
	SSwardrobe.provide_type(/obj/item/t_scanner, src)
	SSwardrobe.provide_type(/obj/item/extinguisher/mini, src)

/obj/item/storage/belt/utility/atmostech/get_types_to_preload()
	var/list/to_preload = list() //Yes this is a pain. Yes this is the point
	to_preload += /obj/item/screwdriver
	to_preload += /obj/item/wrench
	to_preload += /obj/item/weldingtool
	to_preload += /obj/item/crowbar
	to_preload += /obj/item/wirecutters
	to_preload += /obj/item/t_scanner
	to_preload += /obj/item/extinguisher/mini
	return to_preload

/obj/item/storage/belt/utility/full/inducer/PopulateContents()
	SSwardrobe.provide_type(/obj/item/screwdriver, src)
	SSwardrobe.provide_type(/obj/item/wrench, src)
	SSwardrobe.provide_type(/obj/item/weldingtool, src)
	SSwardrobe.provide_type(/obj/item/crowbar/red, src)
	SSwardrobe.provide_type(/obj/item/wirecutters, src)
	SSwardrobe.provide_type(/obj/item/multitool, src)
	SSwardrobe.provide_type(/obj/item/inducer, src)

/obj/item/storage/belt/utility/full/inducer/get_types_to_preload()
	var/list/to_preload = list() //Yes this is a pain. Yes this is the point
	to_preload += /obj/item/screwdriver
	to_preload += /obj/item/wrench
	to_preload += /obj/item/weldingtool
	to_preload += /obj/item/crowbar
	to_preload += /obj/item/wirecutters
	to_preload += /obj/item/multitool
	to_preload += /obj/item/inducer
	return to_preload

/obj/item/storage/belt/utility/syndicate
	preload = FALSE

/obj/item/storage/belt/utility/syndicate/PopulateContents()
	new /obj/item/screwdriver/nuke(src)
	new /obj/item/wrench/combat(src)
	new /obj/item/weldingtool/largetank(src)
	new /obj/item/crowbar(src)
	new /obj/item/wirecutters(src)
	new /obj/item/multitool(src)
	new /obj/item/inducer/syndicate(src)

/obj/item/storage/belt/medical
	name = "medical belt"
	desc = "Может хранить различное медицинское оборудование."
	icon_state = "medical"
	inhand_icon_state = "medical"
	worn_icon_state = "medical"
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbelt_pickup.ogg'
	storage_type = /datum/storage/medical_belt

/obj/item/storage/belt/medical/get_ru_names()
	return alist(
		NOMINATIVE = "медицинский пояс",
		GENITIVE = "медицинского пояса",
		DATIVE = "медицинскому поясу",
		ACCUSATIVE = "медицинский пояс",
		INSTRUMENTAL = "медицинским поясом",
		PREPOSITIONAL = "медицинском поясе",
	)

/obj/item/storage/belt/medical/paramedic
	name = "EMT belt"
	icon_state = "emt"
	inhand_icon_state = "security"
	worn_icon_state = "emt"
	preload = TRUE

/obj/item/storage/belt/medical/paramedic/get_ru_names()
	return alist(
		NOMINATIVE = "пояс парамедика",
		GENITIVE = "пояса парамедика",
		DATIVE = "поясу парамедика",
		ACCUSATIVE = "пояс парамедика",
		INSTRUMENTAL = "поясом парамедика",
		PREPOSITIONAL = "поясе парамедика",
	)

/obj/item/storage/belt/medical/paramedic/PopulateContents()
	SSwardrobe.provide_type(/obj/item/sensor_device, src)
	SSwardrobe.provide_type(/obj/item/stack/medical/gauze/twelve, src)
	SSwardrobe.provide_type(/obj/item/stack/medical/bone_gel, src)
	SSwardrobe.provide_type(/obj/item/stack/sticky_tape/surgical, src)
	SSwardrobe.provide_type(/obj/item/reagent_containers/syringe, src)
	SSwardrobe.provide_type(/obj/item/reagent_containers/cup/bottle/ammoniated_mercury, src)
	SSwardrobe.provide_type(/obj/item/reagent_containers/cup/bottle/formaldehyde, src)
	update_appearance()

/obj/item/storage/belt/medical/paramedic/get_types_to_preload()
	var/list/to_preload = list() //Yes this is a pain. Yes this is the point
	to_preload += /obj/item/sensor_device
	to_preload += /obj/item/stack/medical/gauze/twelve
	to_preload += /obj/item/stack/medical/bone_gel
	to_preload += /obj/item/stack/sticky_tape/surgical
	to_preload += /obj/item/reagent_containers/syringe
	to_preload += /obj/item/reagent_containers/cup/bottle/ammoniated_mercury
	to_preload += /obj/item/reagent_containers/cup/bottle/formaldehyde
	return to_preload

/obj/item/storage/belt/medical/ert
	icon_state = "emt"
	inhand_icon_state = "security"
	worn_icon_state = "emt"
	preload = TRUE

/obj/item/storage/belt/medical/ert/PopulateContents()
	SSwardrobe.provide_type(/obj/item/sensor_device, src)
	SSwardrobe.provide_type(/obj/item/pinpointer/crew, src)
	SSwardrobe.provide_type(/obj/item/scalpel/advanced, src)
	SSwardrobe.provide_type(/obj/item/retractor/advanced, src)
	SSwardrobe.provide_type(/obj/item/stack/medical/bone_gel, src)
	SSwardrobe.provide_type(/obj/item/cautery/advanced, src)
	SSwardrobe.provide_type(/obj/item/surgical_drapes, src)
	update_appearance()

/obj/item/storage/belt/medical/ert/get_types_to_preload()
	var/list/to_preload = list()
	to_preload += /obj/item/sensor_device
	to_preload += /obj/item/pinpointer/crew
	to_preload += /obj/item/scalpel/advanced
	to_preload += /obj/item/retractor/advanced
	to_preload += /obj/item/stack/medical/bone_gel
	to_preload += /obj/item/cautery/advanced
	to_preload += /obj/item/surgical_drapes
	return to_preload

/obj/item/storage/belt/security
	name = "security belt"
	desc = "Может хранить снаряжение охраны, такое как наручники и вспышки."
	icon_state = "security"
	inhand_icon_state = "security"//Could likely use a better one.
	worn_icon_state = "security"
	content_overlays = TRUE
	storage_type = /datum/storage/security_belt

/obj/item/storage/belt/security/get_ru_names()
	return alist(
		NOMINATIVE = "пояс офицера",
		GENITIVE = "пояса офицера",
		DATIVE = "поясу офицера",
		ACCUSATIVE = "пояс офицера",
		INSTRUMENTAL = "поясом офицера",
		PREPOSITIONAL = "поясе офицера",
	)

/obj/item/storage/belt/security/full/PopulateContents()
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/melee/baton/security/loaded(src)
	update_appearance()

/obj/item/storage/belt/security/webbing
	name = "security webbing"
	desc = "Уникальная и универсальная нагрудная разгрузка, может хранить снаряжение охраны."
	icon_state = "securitywebbing"
	inhand_icon_state = "securitywebbing"
	worn_icon_state = "securitywebbing"
	content_overlays = FALSE
	custom_premium_price = PAYCHECK_COMMAND * 3
	storage_type = /datum/storage/security_belt/webbing

/obj/item/storage/belt/security/webbing/get_ru_names()
	return alist(
		NOMINATIVE = "разгрузка офицера",
		GENITIVE = "разгрузки офицера",
		DATIVE = "разгрузке офицера",
		ACCUSATIVE = "разгрузку офицера",
		INSTRUMENTAL = "разгрузкой офицера",
		PREPOSITIONAL = "разгрузке офицера",
	)

/obj/item/storage/belt/mining
	name = "explorer's webbing"
	desc = "Универсальная нагрудная разгрузка, ценимая как шахтёрами, так и охотниками."
	icon_state = "explorer1"
	inhand_icon_state = "explorer1"
	worn_icon_state = "explorer1"
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/mining_belt

/obj/item/storage/belt/mining/get_ru_names()
	return alist(
		NOMINATIVE = "разгрузка исследователя",
		GENITIVE = "разгрузки исследователя",
		DATIVE = "разгрузке исследователя",
		ACCUSATIVE = "разгрузку исследователя",
		INSTRUMENTAL = "разгрузкой исследователя",
		PREPOSITIONAL = "разгрузке исследователя",
	)

/obj/item/storage/belt/mining/vendor/PopulateContents()
	new /obj/item/survivalcapsule(src)

/obj/item/storage/belt/mining/alt
	icon_state = "explorer2"
	inhand_icon_state = "explorer2"
	worn_icon_state = "explorer2"

/obj/item/storage/belt/mining/healing/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/reagent_containers/hypospray/medipen/survival/luxury(src)
	for(var/i in 1 to 2)
		new /obj/item/reagent_containers/hypospray/medipen/survival(src)
	for(var/i in 1 to 2)
		var/obj/item/organ/monster_core/core = new /obj/item/organ/monster_core/regenerative_core/legion(src)
		core.preserve()

/obj/item/storage/belt/mining/primitive
	name = "hunter's belt"
	desc = "Универсальный пояс, сплетенный из жил."
	icon_state = "ebelt"
	inhand_icon_state = "ebelt"
	worn_icon_state = "ebelt"
	storage_type = /datum/storage/mining_belt/primitive

/obj/item/storage/belt/mining/primitive/get_ru_names()
	return alist(
		NOMINATIVE = "пояс охотника",
		GENITIVE = "пояса охотника",
		DATIVE = "поясу охотника",
		ACCUSATIVE = "пояс охотника",
		INSTRUMENTAL = "поясом охотника",
		PREPOSITIONAL = "поясе охотника",
	)

/obj/item/storage/belt/soulstone
	name = "soul stone belt"
	desc = "Разработан для легкого доступа к осколкам во время боя, чтобы ни один вражеский дух не ускользнул."
	icon_state = "soulstonebelt"
	inhand_icon_state = "soulstonebelt"
	worn_icon_state = "soulstonebelt"
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbelt_pickup.ogg'
	storage_type = /datum/storage/soulstone_belt

/obj/item/storage/belt/soulstone/get_ru_names()
	return alist(
		NOMINATIVE = "пояс камней душ",
		GENITIVE = "пояса камней душ",
		DATIVE = "поясу камней душ",
		ACCUSATIVE = "пояс камней душ",
		INSTRUMENTAL = "поясом камней душ",
		PREPOSITIONAL = "поясе камней душ",
	)

/obj/item/storage/belt/soulstone/full/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/soulstone/mystic(src)

/obj/item/storage/belt/soulstone/full/chappy/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/soulstone/anybody/chaplain(src)

/obj/item/storage/belt/champion
	name = "championship belt"
	desc = "Доказывает всему миру, что вы сильнейший!"
	icon_state = "championbelt"
	inhand_icon_state = "championbelt"
	worn_icon_state = "championbelt"
	custom_materials = list(/datum/material/gold=SMALL_MATERIAL_AMOUNT *4)
	storage_type = /datum/storage/champion_belt

/obj/item/storage/belt/champion/get_ru_names()
	return alist(
		NOMINATIVE = "чемпионский пояс",
		GENITIVE = "чемпионского пояса",
		DATIVE = "чемпионскому поясу",
		ACCUSATIVE = "чемпионский пояс",
		INSTRUMENTAL = "чемпионским поясом",
		PREPOSITIONAL = "чемпионском поясе",
	)

/obj/item/storage/belt/champion/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/adjust_fishing_difficulty, -2)

/obj/item/storage/belt/military
	name = "chest rig"
	desc = "Набор тактических ремней, которые носят абордажные группы Синдиката."
	icon_state = "militarywebbing"
	inhand_icon_state = "militarywebbing"
	worn_icon_state = "militarywebbing"
	resistance_flags = FIRE_PROOF
	storage_type = /datum/storage/military_belt

/obj/item/storage/belt/military/get_ru_names()
	return alist(
		NOMINATIVE = "разгрузка",
		GENITIVE = "разгрузки",
		DATIVE = "разгрузке",
		ACCUSATIVE = "разгрузку",
		INSTRUMENTAL = "разгрузкой",
		PREPOSITIONAL = "разгрузке",
	)

/obj/item/storage/belt/military/snack
	name = "tactical snack rig"
	storage_type = /datum/storage/military_belt/snack

/obj/item/storage/belt/military/snack/get_ru_names()
	return alist(
		NOMINATIVE = "тактическая закусочная разгрузка",
		GENITIVE = "тактической закусочной разгрузки",
		DATIVE = "тактической закусочной разгрузке",
		ACCUSATIVE = "тактическую закусочную разгрузку",
		INSTRUMENTAL = "тактической закусочной разгрузкой",
		PREPOSITIONAL = "тактической закусочной разгрузке",
	)

/obj/item/storage/belt/military/snack/Initialize(mapload)
	. = ..()
	var/sponsor = pick("Donk Co.", "Waffle Corp.", "Roffle Co.", "Gorlex Marauders", "Tiger Cooperative")
	desc = "Комплект снек-тической разгрузки, которую носят атлеты подразделения VR-спорта [sponsor]."

/obj/item/storage/belt/military/snack/full/Initialize(mapload)
	. = ..()
	var/amount = 5
	var/rig_snacks
	while(contents.len <= amount)
		rig_snacks = pick(list(
			/obj/item/food/candy,
			/obj/item/food/cheesiehonkers,
			/obj/item/food/cheesynachos,
			/obj/item/food/chips,
			/obj/item/food/cubannachos,
			/obj/item/food/donkpocket,
			/obj/item/food/nachos,
			/obj/item/food/nugget,
			/obj/item/food/rofflewaffles,
			/obj/item/food/sosjerky,
			/obj/item/food/spacetwinkie,
			/obj/item/food/spaghetti/pastatomato,
			/obj/item/food/syndicake,
			/obj/item/reagent_containers/cup/glass/drinkingglass/filled/nuka_cola,
			/obj/item/reagent_containers/cup/glass/dry_ramen,
			/obj/item/reagent_containers/cup/soda_cans/cola,
			/obj/item/reagent_containers/cup/soda_cans/dr_gibb,
			/obj/item/reagent_containers/cup/soda_cans/lemon_lime,
			/obj/item/reagent_containers/cup/soda_cans/pwr_game,
			/obj/item/reagent_containers/cup/soda_cans/space_mountain_wind,
			/obj/item/reagent_containers/cup/soda_cans/space_up,
			/obj/item/reagent_containers/cup/soda_cans/starkist,
		))
		new rig_snacks(src)

/obj/item/storage/belt/military/abductor
	name = "agent belt"
	desc = "Пояс, используемый агентами абдукторов."
	icon = 'icons/obj/antags/abductor.dmi'
	icon_state = "belt"
	inhand_icon_state = "security"
	worn_icon_state = "security"
	content_overlays = TRUE

/obj/item/storage/belt/military/abductor/get_ru_names()
	return alist(
		NOMINATIVE = "пояс агента",
		GENITIVE = "пояса агента",
		DATIVE = "поясу агента",
		ACCUSATIVE = "пояс агента",
		INSTRUMENTAL = "поясом агента",
		PREPOSITIONAL = "поясе агента",
	)

/obj/item/storage/belt/military/abductor/full/PopulateContents()
	new /obj/item/screwdriver/abductor(src)
	new /obj/item/wrench/abductor(src)
	new /obj/item/weldingtool/abductor(src)
	new /obj/item/crowbar/abductor(src)
	new /obj/item/wirecutters/abductor(src)
	new /obj/item/multitool/abductor(src)
	new /obj/item/stack/cable_coil(src)

/obj/item/storage/belt/military/army
	name = "army belt"
	desc = "Пояс, используемый вооруженными силами."
	icon_state = "military"
	inhand_icon_state = "security"
	worn_icon_state = "military"

/obj/item/storage/belt/military/army/get_ru_names()
	return alist(
		NOMINATIVE = "армейский пояс",
		GENITIVE = "армейского пояса",
		DATIVE = "армейскому поясу",
		ACCUSATIVE = "армейский пояс",
		INSTRUMENTAL = "армейским поясом",
		PREPOSITIONAL = "армейском поясе",
	)

/obj/item/storage/belt/military/assault
	name = "assault belt"
	desc = "Тактический штурмовой пояс."
	icon_state = "assault"
	inhand_icon_state = "security"
	worn_icon_state = "assault"
	storage_type = /datum/storage/military_belt/assault

/obj/item/storage/belt/military/assault/get_ru_names()
	return alist(
		NOMINATIVE = "штурмовой пояс",
		GENITIVE = "штурмового пояса",
		DATIVE = "штурмовому поясу",
		ACCUSATIVE = "штурмовой пояс",
		INSTRUMENTAL = "штурмовым поясом",
		PREPOSITIONAL = "штурмовом поясе",
	)

/obj/item/storage/belt/military/assault/full/PopulateContents()
	generate_items_inside(list(
		/obj/item/ammo_box/magazine/wt550m9 = 4,
		/obj/item/ammo_box/magazine/wt550m9/wtap = 2,
	), src)

/obj/item/storage/belt/grenade
	name = "grenadier belt"
	desc = "Пояс для хранения гранат."
	icon_state = "grenadebeltnew"
	inhand_icon_state = "security"
	worn_icon_state = "grenadebeltnew"
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbelt_pickup.ogg'
	storage_type = /datum/storage/grenade_belt

/obj/item/storage/belt/grenade/get_ru_names()
	return alist(
		NOMINATIVE = "пояс гренадёра",
		GENITIVE = "пояса гренадёра",
		DATIVE = "поясу гренадёра",
		ACCUSATIVE = "пояс гренадёра",
		INSTRUMENTAL = "поясом гренадёра",
		PREPOSITIONAL = "поясе гренадёра",
	)

/obj/item/storage/belt/grenade/full/PopulateContents()
	generate_items_inside(list(
		/obj/item/grenade/chem_grenade/incendiary = 2,
		/obj/item/grenade/empgrenade = 2,
		/obj/item/grenade/frag = 10,
		/obj/item/grenade/flashbang = 2,
		/obj/item/grenade/gluon = 4,
		/obj/item/grenade/smokebomb = 4,
		/obj/item/grenade/syndieminibomb = 2,
		/obj/item/multitool = 1,
		/obj/item/screwdriver = 1,
	),src)


/obj/item/storage/belt/wands
	name = "wand belt"
	desc = "Пояс, предназначенный для хранения различных жезлов силы. Настоящая поясная сумка экзотической магии."
	icon_state = "soulstonebelt"
	inhand_icon_state = "soulstonebelt"
	worn_icon_state = "soulstonebelt"
	storage_type = /datum/storage/wands_belt

/obj/item/storage/belt/wands/get_ru_names()
	return alist(
		NOMINATIVE = "пояс жезлов",
		GENITIVE = "пояса жезлов",
		DATIVE = "поясу жезлов",
		ACCUSATIVE = "пояс жезлов",
		INSTRUMENTAL = "поясом жезлов",
		PREPOSITIONAL = "поясе жезлов",
	)

/obj/item/storage/belt/wands/full/PopulateContents()
	new /obj/item/gun/magic/wand/death(src)
	new /obj/item/gun/magic/wand/resurrection(src)
	new /obj/item/gun/magic/wand/polymorph(src)
	new /obj/item/gun/magic/wand/teleport(src)
	new /obj/item/gun/magic/wand/door(src)
	new /obj/item/gun/magic/wand/fireball(src)
	new /obj/item/gun/magic/wand/shrink(src)

	for(var/obj/item/gun/magic/wand/W in contents) //All wands in this pack come in the best possible condition
		W.max_charges = initial(W.max_charges)
		W.charges = W.max_charges

/obj/item/storage/belt/janitor
	name = "janibelt"
	desc = "Пояс, используемый для хранения большинства принадлежностей уборщика."
	icon_state = "janibelt"
	inhand_icon_state = "janibelt"
	worn_icon_state = "janibelt"
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbelt_pickup.ogg'
	storage_type = /datum/storage/janitor_belt

/obj/item/storage/belt/janitor/get_ru_names()
	return alist(
		NOMINATIVE = "пояс уборщика",
		GENITIVE = "пояса уборщика",
		DATIVE = "поясу уборщика",
		ACCUSATIVE = "пояс уборщика",
		INSTRUMENTAL = "поясом уборщика",
		PREPOSITIONAL = "поясе уборщика",
	)

/obj/item/storage/belt/janitor/full/PopulateContents()
	new /obj/item/lightreplacer(src)
	new /obj/item/reagent_containers/spray/cleaner(src)
	new /obj/item/soap/nanotrasen(src)
	new /obj/item/holosign_creator(src)
	new /obj/item/melee/flyswatter(src)

/obj/item/storage/belt/bandolier
	name = "bandolier"
	desc = "Бандольер для хранения патронов для винтовок, дробовиков и крупнокалиберных револьверов."
	icon_state = "bandolier"
	inhand_icon_state = "bandolier"
	worn_icon_state = "bandolier"
	storage_type = /datum/storage/bandolier_belt

/obj/item/storage/belt/bandolier/get_ru_names()
	return alist(
		NOMINATIVE = "бандольер",
		GENITIVE = "бандольера",
		DATIVE = "бандольеру",
		ACCUSATIVE = "бандольер",
		INSTRUMENTAL = "бандольером",
		PREPOSITIONAL = "бандольере",
	)

/obj/item/storage/belt/fannypack
	name = "fannypack"
	desc = "Дурацкая поясная сумка для хранения мелких предметов. Достаточно скрытная или достаточно уродливая, чтобы отводить взгляды, так что другие не увидят, что вы в неё кладете или достаете."
	icon_state = "fannypack_leather"
	inhand_icon_state = null
	worn_icon_state = "fannypack_leather"
	dying_key = DYE_REGISTRY_FANNYPACK
	custom_price = PAYCHECK_CREW * 2
	storage_type = /datum/storage/fanny_pack

/obj/item/storage/belt/fannypack/get_ru_names()
	return alist(
		NOMINATIVE = "поясная сумка",
		GENITIVE = "поясной сумки",
		DATIVE = "поясной сумке",
		ACCUSATIVE = "поясную сумку",
		INSTRUMENTAL = "поясной сумкой",
		PREPOSITIONAL = "поясной сумке",
	)

/obj/item/storage/belt/fannypack/black
	name = "black fannypack"
	icon_state = "fannypack_black"
	worn_icon_state = "fannypack_black"

/obj/item/storage/belt/fannypack/black/get_ru_names()
	return alist(
		NOMINATIVE = "чёрная поясная сумка",
		GENITIVE = "чёрной поясной сумки",
		DATIVE = "чёрной поясной сумке",
		ACCUSATIVE = "чёрную поясную сумку",
		INSTRUMENTAL = "чёрной поясной сумкой",
		PREPOSITIONAL = "чёрной поясной сумке",
	)

/obj/item/storage/belt/fannypack/red
	name = "red fannypack"
	icon_state = "fannypack_red"
	worn_icon_state = "fannypack_red"

/obj/item/storage/belt/fannypack/red/get_ru_names()
	return alist(
		NOMINATIVE = "красная поясная сумка",
		GENITIVE = "красной поясной сумки",
		DATIVE = "красной поясной сумке",
		ACCUSATIVE = "красную поясную сумку",
		INSTRUMENTAL = "красной поясной сумкой",
		PREPOSITIONAL = "красной поясной сумке",
	)

/obj/item/storage/belt/fannypack/purple
	name = "purple fannypack"
	icon_state = "fannypack_purple"
	worn_icon_state = "fannypack_purple"

/obj/item/storage/belt/fannypack/purple/get_ru_names()
	return alist(
		NOMINATIVE = "фиолетовая поясная сумка",
		GENITIVE = "фиолетовой поясной сумки",
		DATIVE = "фиолетовой поясной сумке",
		ACCUSATIVE = "фиолетовую поясную сумку",
		INSTRUMENTAL = "фиолетовой поясной сумкой",
		PREPOSITIONAL = "фиолетовой поясной сумке",
	)

/obj/item/storage/belt/fannypack/blue
	name = "blue fannypack"
	icon_state = "fannypack_blue"
	worn_icon_state = "fannypack_blue"

/obj/item/storage/belt/fannypack/blue/get_ru_names()
	return alist(
		NOMINATIVE = "синяя поясная сумка",
		GENITIVE = "синей поясной сумки",
		DATIVE = "синей поясной сумке",
		ACCUSATIVE = "синюю поясную сумку",
		INSTRUMENTAL = "синей поясной сумкой",
		PREPOSITIONAL = "синей поясной сумке",
	)

/obj/item/storage/belt/fannypack/orange
	name = "orange fannypack"
	icon_state = "fannypack_orange"
	worn_icon_state = "fannypack_orange"

/obj/item/storage/belt/fannypack/orange/get_ru_names()
	return alist(
		NOMINATIVE = "оранжевая поясная сумка",
		GENITIVE = "оранжевой поясной сумки",
		DATIVE = "оранжевой поясной сумке",
		ACCUSATIVE = "оранжевую поясную сумку",
		INSTRUMENTAL = "оранжевой поясной сумкой",
		PREPOSITIONAL = "оранжевой поясной сумке",
	)

/obj/item/storage/belt/fannypack/white
	name = "white fannypack"
	icon_state = "fannypack_white"
	worn_icon_state = "fannypack_white"

/obj/item/storage/belt/fannypack/white/get_ru_names()
	return alist(
		NOMINATIVE = "белая поясная сумка",
		GENITIVE = "белой поясной сумки",
		DATIVE = "белой поясной сумке",
		ACCUSATIVE = "белую поясную сумку",
		INSTRUMENTAL = "белой поясной сумкой",
		PREPOSITIONAL = "белой поясной сумке",
	)

/obj/item/storage/belt/fannypack/green
	name = "green fannypack"
	icon_state = "fannypack_green"
	worn_icon_state = "fannypack_green"

/obj/item/storage/belt/fannypack/green/get_ru_names()
	return alist(
		NOMINATIVE = "зелёная поясная сумка",
		GENITIVE = "зелёной поясной сумки",
		DATIVE = "зелёной поясной сумке",
		ACCUSATIVE = "зелёную поясную сумку",
		INSTRUMENTAL = "зелёной поясной сумкой",
		PREPOSITIONAL = "зелёной поясной сумке",
	)

/obj/item/storage/belt/fannypack/pink
	name = "pink fannypack"
	icon_state = "fannypack_pink"
	worn_icon_state = "fannypack_pink"

/obj/item/storage/belt/fannypack/pink/get_ru_names()
	return alist(
		NOMINATIVE = "розовая поясная сумка",
		GENITIVE = "розовой поясной сумки",
		DATIVE = "розовой поясной сумке",
		ACCUSATIVE = "розовую поясную сумку",
		INSTRUMENTAL = "розовой поясной сумкой",
		PREPOSITIONAL = "розовой поясной сумке",
	)

/obj/item/storage/belt/fannypack/cyan
	name = "cyan fannypack"
	icon_state = "fannypack_cyan"
	worn_icon_state = "fannypack_cyan"

/obj/item/storage/belt/fannypack/cyan/get_ru_names()
	return alist(
		NOMINATIVE = "голубая поясная сумка",
		GENITIVE = "голубой поясной сумки",
		DATIVE = "голубой поясной сумке",
		ACCUSATIVE = "голубую поясную сумку",
		INSTRUMENTAL = "голубой поясной сумкой",
		PREPOSITIONAL = "голубой поясной сумке",
	)

/obj/item/storage/belt/fannypack/yellow
	name = "yellow fannypack"
	icon_state = "fannypack_yellow"
	worn_icon_state = "fannypack_yellow"

/obj/item/storage/belt/fannypack/yellow/get_ru_names()
	return alist(
		NOMINATIVE = "жёлтая поясная сумка",
		GENITIVE = "жёлтой поясной сумки",
		DATIVE = "жёлтой поясной сумке",
		ACCUSATIVE = "жёлтую поясную сумку",
		INSTRUMENTAL = "жёлтой поясной сумкой",
		PREPOSITIONAL = "жёлтой поясной сумке",
	)

/obj/item/storage/belt/fannypack/cummerbund
	name = "cummerbund"
	desc = "Плиссированный пояс, который хорошо сочетается с пиджаком."
	icon_state = "cummerbund"
	inhand_icon_state = null
	worn_icon_state = "cummerbund"

/obj/item/storage/belt/fannypack/cummerbund/get_ru_names()
	return alist(
		NOMINATIVE = "кушак",
		GENITIVE = "кушака",
		DATIVE = "кушаку",
		ACCUSATIVE = "кушак",
		INSTRUMENTAL = "кушаком",
		PREPOSITIONAL = "кушаке",
	)

/obj/item/storage/belt/fannypack/yellow/bee_terrorist/PopulateContents()
	new /obj/item/grenade/c4 (src)
	new /obj/item/reagent_containers/applicator/pill/cyanide(src)
	new /obj/item/grenade/chem_grenade/facid(src)

/obj/item/storage/belt/fannypack/black/rogue
	name = "fannypack of ULTIMATE DESPAIR"

/obj/item/storage/belt/fannypack/black/rogue/get_ru_names()
	return alist(
		NOMINATIVE = "поясная сумка АБСОЛЮТНОГО ОТЧАЯНИЯ",
		GENITIVE = "поясной сумки АБСОЛЮТНОГО ОТЧАЯНИЯ",
		DATIVE = "поясной сумке АБСОЛЮТНОГО ОТЧАЯНИЯ",
		ACCUSATIVE = "поясную сумку АБСОЛЮТНОГО ОТЧАЯНИЯ",
		INSTRUMENTAL = "поясной сумкой АБСОЛЮТНОГО ОТЧАЯНИЯ",
		PREPOSITIONAL = "поясной сумке АБСОЛЮТНОГО ОТЧАЯНИЯ",
	)

/obj/item/storage/belt/fannypack/black/rogue/PopulateContents()
	new /obj/item/food/drug/saturnx(src)
	new /obj/item/reagent_containers/cup/blastoff_ampoule(src)
	new /obj/item/reagent_containers/hypospray/medipen/methamphetamine(src)

/obj/item/storage/belt/sheath
	desc = "содержит типа клинки и всё такое. Вы не должны это видеть."
	w_class = WEIGHT_CLASS_BULKY
	interaction_flags_click = parent_type::interaction_flags_click | NEED_DEXTERITY | NEED_HANDS
	var/stored_blade

/obj/item/storage/belt/sheath/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/storage/belt/sheath/examine(mob/user)
	. = ..()
	if(length(contents))
		. += span_notice("[EXAMINE_HINT("Альт-клик")] по [RU_SRC_DAT], чтобы быстро выхватить клинок.")

/obj/item/storage/belt/sheath/click_alt(mob/user)
	if(!length(contents))
		balloon_alert(user, "пусто!")
		return CLICK_ACTION_BLOCKING
	var/obj/item/stored_item = contents[1]
	user.visible_message(span_notice("[RU_USER_NOM] достаёт [RU_ACC(stored_item)] из [RU_SRC_GEN]."), span_notice("Вы достаёте [RU_ACC(stored_item)] из [RU_SRC_GEN]."))
	user.put_in_hands(stored_item)
	update_appearance()
	return CLICK_ACTION_SUCCESS

/obj/item/storage/belt/sheath/update_icon_state()
	icon_state = initial(inhand_icon_state)
	inhand_icon_state = initial(inhand_icon_state)
	worn_icon_state = initial(worn_icon_state)
	if(contents.len)
		icon_state += "-full"
		inhand_icon_state += "-full"
		worn_icon_state += "-full"
	return ..()

/obj/item/storage/belt/sheath/PopulateContents()
	if(stored_blade)
		new stored_blade(src)
		update_appearance()

/obj/item/storage/belt/sheath/sabre
	name = "sabre sheath"
	desc = "Богато украшенные ножны, предназначенные для клинка офицера."
	icon_state = "sheath"
	inhand_icon_state = "sheath"
	worn_icon_state = "sheath"
	storage_type = /datum/storage/sabre_belt
	stored_blade = /obj/item/melee/sabre

/obj/item/storage/belt/sheath/sabre/get_ru_names()
	return alist(
		NOMINATIVE = "ножны сабли",
		GENITIVE = "ножен сабли",
		DATIVE = "ножнам сабли",
		ACCUSATIVE = "ножны сабли",
		INSTRUMENTAL = "ножнами сабли",
		PREPOSITIONAL = "ножнах сабли",
	)

/obj/item/storage/belt/sheath/grass_sabre
	name = "sabre sheath"
	desc = "Простые травяные ножны, предназначенные для сабли... какого-то рода. Настоящая металлическая может быть слишком острой, впрочем..."
	icon_state = "grass_sheath"
	inhand_icon_state = "grass_sheath"
	worn_icon_state = "grass_sheath"
	storage_type = /datum/storage/green_sabre_belt

/obj/item/storage/belt/sheath/grass_sabre/get_ru_names()
	return alist(
		NOMINATIVE = "ножны сабли",
		GENITIVE = "ножен сабли",
		DATIVE = "ножнам сабли",
		ACCUSATIVE = "ножны сабли",
		INSTRUMENTAL = "ножнами сабли",
		PREPOSITIONAL = "ножнах сабли",
	)

/obj/item/storage/belt/sheath/gladius
	name = "gladius scabbard"
	desc = "Ножны забавного размера для меча забавного размера."
	icon_state = "gladius_sheath"
	inhand_icon_state = "gladius_sheath"
	worn_icon_state = "gladius_sheath"
	storage_type = /datum/storage/gladius_belt
	stored_blade = /obj/item/claymore/gladius

/obj/item/storage/belt/sheath/gladius/get_ru_names()
	return alist(
		NOMINATIVE = "ножны гладиуса",
		GENITIVE = "ножен гладиуса",
		DATIVE = "ножнам гладиуса",
		ACCUSATIVE = "ножны гладиуса",
		INSTRUMENTAL = "ножнами гладиуса",
		PREPOSITIONAL = "ножнах гладиуса",
	)

/obj/item/storage/belt/plant
	name = "botanical belt"
	desc = "Прочный кожаный пояс, используемый для хранения большинства принадлежностей гидропоники."
	icon_state = "plantbelt"
	inhand_icon_state = "utility"
	worn_icon_state = "plantbelt"
	content_overlays = TRUE
	storage_type = /datum/storage/plant_belt

/obj/item/storage/belt/plant/get_ru_names()
	return alist(
		NOMINATIVE = "ботанический пояс",
		GENITIVE = "ботанического пояса",
		DATIVE = "ботаническому поясу",
		ACCUSATIVE = "ботанический пояс",
		INSTRUMENTAL = "ботаническим поясом",
		PREPOSITIONAL = "ботаническом поясе",
	)
