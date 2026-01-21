/**
 * MARK: Шкуры (база)
 * Это базовая шкура, которая является шаблоном для остальных.
 * Базовая? Типо стандарт для шл..
 */

/obj/item/stack/sheet/animalhide
	name = "hide"
	desc = "Что-то пошло не так."
	icon_state = "sheet-hide"
	inhand_icon_state = null
	novariants = TRUE
	merge_type = /obj/item/stack/sheet/animalhide
	pickup_sound = 'sound/items/handling/materials/skin_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/skin_drop.ogg'

/obj/item/stack/sheet/animalhide/get_ru_names()
	return alist(
		NOMINATIVE = "шкура",
		GENITIVE = "шкуры",
		DATIVE = "шкуре",
		ACCUSATIVE = "шкуру",
		INSTRUMENTAL = "шкурой",
		PREPOSITIONAL = "шкуре"
	)

/**
 * MARK: Человеческая кожа
 */
/obj/item/stack/sheet/animalhide/human
	name = "human skin"
	desc = "Побочный продукт человеческого фермерства."
	singular_name = "human skin piece"
	novariants = FALSE
	merge_type = /obj/item/stack/sheet/animalhide/human

/obj/item/stack/sheet/animalhide/human/get_ru_names()
	return alist(
		NOMINATIVE = "человеческая кожа",
		GENITIVE = "человеческой кожи",
		DATIVE = "человеческой коже",
		ACCUSATIVE = "человеческую кожу",
		INSTRUMENTAL = "человеческой кожей",
		PREPOSITIONAL = "человеческой коже"
	)

GLOBAL_LIST_INIT(human_recipes, list( \
	new/datum/stack_recipe("костюм из человеческой кожи", /obj/item/clothing/suit/hooded/bloated_human, 5, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("шляпа из человеческой кожи", /obj/item/clothing/head/fedora/human_leather, 1, crafting_flags = NONE, category = CAT_CLOTHING), \
	))

/obj/item/stack/sheet/animalhide/human/get_main_recipes()
	. = ..()
	. += GLOB.human_recipes

/obj/item/stack/sheet/animalhide/human/five
	amount = 5

/**
 * MARK: Кожа (необработ.)
 */
/obj/item/stack/sheet/animalhide/generic
	name = "skin"
	desc = "Кусок кожи."
	singular_name = "skin piece"
	novariants = FALSE
	merge_type = /obj/item/stack/sheet/animalhide/generic

/obj/item/stack/sheet/animalhide/generic/get_ru_names()
	return alist(
		NOMINATIVE = "кожа",
		GENITIVE = "кожи",
		DATIVE = "коже",
		ACCUSATIVE = "кожу",
		INSTRUMENTAL = "кожей",
		PREPOSITIONAL = "коже"
	)

/**
 * MARK: Шкура корги
 */
/obj/item/stack/sheet/animalhide/corgi
	name = "corgi hide"
	desc = "Побочный продукт фермерства корги."
	singular_name = "corgi hide piece"
	icon_state = "sheet-corgi"
	inhand_icon_state = null
	merge_type = /obj/item/stack/sheet/animalhide/corgi

/obj/item/stack/sheet/animalhide/corgicorgi/get_ru_names()
	return alist(
		NOMINATIVE = "шкура корги",
		GENITIVE = "шкуры корги",
		DATIVE = "шкуре корги",
		ACCUSATIVE = "шкуру корги",
		INSTRUMENTAL = "шкурой корги",
		PREPOSITIONAL = "шкуре корги"
	)

GLOBAL_LIST_INIT(corgi_recipes, list ( \
	new/datum/stack_recipe("костюм корги", /obj/item/clothing/suit/hooded/ian_costume, 3, crafting_flags = NONE, category = CAT_CLOTHING), \
	))

/obj/item/stack/sheet/animalhide/corgi/get_main_recipes()
	. = ..()
	. += GLOB.corgi_recipes

/obj/item/stack/sheet/animalhide/corgi/five
	amount = 5

/**
 * MARK: Шкура моли
 */
/obj/item/stack/sheet/animalhide/mothroach
	name = "mothroach hide"
	desc = "Тонкий слой шкуры моттарожа."
	singular_name = "mothroach hide piece"
	icon_state = "sheet-mothroach"
	inhand_icon_state = null
	merge_type = /obj/item/stack/sheet/animalhide/mothroach

/obj/item/stack/sheet/animalhide/mothroach/get_ru_names()
	return alist(
		NOMINATIVE = "шкура мотылька",
		GENITIVE = "шкуры мотылька",
		DATIVE = "шкуре мотылька",
		ACCUSATIVE = "шкуру мотылька",
		INSTRUMENTAL = "шкурой мотылька",
		PREPOSITIONAL = "шкуре мотылька"
	)

/obj/item/stack/sheet/animalhide/mothroach/five
	amount = 5

/**
 * MARK: Шкура гондолы
 */
/obj/item/stack/sheet/animalhide/gondola
	name = "gondola hide"
	desc = "Чрезвычайно ценный продукт охоты на гондолу."
	singular_name = "gondola hide piece"
	icon_state = "sheet-gondola"
	inhand_icon_state = null
	merge_type = /obj/item/stack/sheet/animalhide/gondola

/obj/item/stack/sheet/animalhide/gondola/get_ru_names()
	return alist(
		NOMINATIVE = "шкура гондолы",
		GENITIVE = "шкуры гондолы",
		DATIVE = "шкуре гондолы",
		ACCUSATIVE = "шкуру гондолы",
		INSTRUMENTAL = "шкурой гондолы",
		PREPOSITIONAL = "шкуре гондолы"
	)

GLOBAL_LIST_INIT(gondola_recipes, list ( \
	new/datum/stack_recipe("маска гондолы", /obj/item/clothing/mask/gondola, 1, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("костюм гондолы", /obj/item/clothing/under/costume/gondola, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("одеяло гондолы", /obj/item/bedsheet/gondola, 1, crafting_flags = NONE, category = CAT_FURNITURE), \
	))

/obj/item/stack/sheet/animalhide/gondola/get_main_recipes()
	. = ..()
	. += GLOB.gondola_recipes

/**
 * MARK: Шкура кошки
 */
/obj/item/stack/sheet/animalhide/cat
	name = "cat hide"
	desc = "Побочный продукт кошачьего фермерства."
	singular_name = "cat hide piece"
	icon_state = "sheet-cat"
	inhand_icon_state = null
	merge_type = /obj/item/stack/sheet/animalhide/cat

/obj/item/stack/sheet/animalhide/cat/get_ru_names()
	return alist(
		NOMINATIVE = "шкура кота",
		GENITIVE = "шкуры кота",
		DATIVE = "шкуре кота",
		ACCUSATIVE = "шкуру кота",
		INSTRUMENTAL = "шкурой кота",
		PREPOSITIONAL = "шкуре кота"
	)

/obj/item/stack/sheet/animalhide/cat/five
	amount = 5

/**
 * MARK: Шкура обезьяны
 */
/obj/item/stack/sheet/animalhide/monkey
	name = "monkey hide"
	desc = "Побочный продукт обезьяньего фермерства."
	singular_name = "monkey hide piece"
	icon_state = "sheet-monkey"
	inhand_icon_state = null
	merge_type = /obj/item/stack/sheet/animalhide/monkey

/obj/item/stack/sheet/animalhide/monkey/get_ru_names()
	return alist(
		NOMINATIVE = "шкура обезьяны",
		GENITIVE = "шкуры обезьяны",
		DATIVE = "шкуре обезьяны",
		ACCUSATIVE = "шкуру обезьяны",
		INSTRUMENTAL = "шкурой обезьяны",
		PREPOSITIONAL = "шкуре обезьяны"
	)

GLOBAL_LIST_INIT(monkey_recipes, list ( \
	new/datum/stack_recipe("маска обезьяны", /obj/item/clothing/mask/gas/monkeymask, 1, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("костюм обезьяны", /obj/item/clothing/suit/costume/monkeysuit, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
	))

/obj/item/stack/sheet/animalhide/monkey/get_main_recipes()
	. = ..()
	. += GLOB.monkey_recipes

/obj/item/stack/sheet/animalhide/monkey/five
	amount = 5

/**
 * MARK: Шкура ящера
 */
/obj/item/stack/sheet/animalhide/lizard
	name = "lizard skin"
	desc = "Ссссссс..."
	singular_name = "lizard skin piece"
	icon_state = "sheet-lizard"
	inhand_icon_state = null
	merge_type = /obj/item/stack/sheet/animalhide/lizard

/obj/item/stack/sheet/animalhide/lizard/get_ru_names()
	return alist(
		NOMINATIVE = "кожа ящерицы",
		GENITIVE = "кожи ящерицы",
		DATIVE = "коже ящерицы",
		ACCUSATIVE = "кожу ящерицы",
		INSTRUMENTAL = "кожей ящерицы",
		PREPOSITIONAL = "коже ящерицы"
	)

/obj/item/stack/sheet/animalhide/lizard/five
	amount = 5

/**
 * MARK: Шкура ксеноса
 */
/obj/item/stack/sheet/animalhide/xeno
	name = "alien hide"
	desc = "Кожа ужасного существа."
	singular_name = "alien hide piece"
	icon_state = "sheet-xeno"
	inhand_icon_state = null
	merge_type = /obj/item/stack/sheet/animalhide/xeno

/obj/item/stack/sheet/animalhide/xeno/get_ru_names()
	return alist(
		NOMINATIVE = "шкура пришельца",
		GENITIVE = "шкуры пришельца",
		DATIVE = "шкуре пришельца",
		ACCUSATIVE = "шкуру пришельца",
		INSTRUMENTAL = "шкурой пришельца",
		PREPOSITIONAL = "шкуре пришельца"
	)

GLOBAL_LIST_INIT(xeno_recipes, list ( \
	new/datum/stack_recipe("шлем пришельца", /obj/item/clothing/head/costume/xenos, 1, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("костюм пришельца", /obj/item/clothing/suit/costume/xenos, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
	))

/obj/item/stack/sheet/animalhide/xeno/get_main_recipes()
	. = ..()
	. += GLOB.xeno_recipes

/obj/item/stack/sheet/animalhide/xeno/five
	amount = 5

//don't see anywhere else to put these, maybe together they could be used to make the xenos suit?
/obj/item/stack/sheet/xenochitin
	name = "alien chitin"
	desc = "Часть покрова ужасного существа."
	singular_name = "alien hide piece"
	icon = 'icons/mob/nonhuman-player/alien.dmi'
	icon_state = "chitin"
	novariants = TRUE
	merge_type = /obj/item/stack/sheet/xenochitin

/obj/item/stack/sheet/xenochitin/get_ru_names()
	return alist(
		NOMINATIVE = "хитин пришельца",
		GENITIVE = "хитина пришельца",
		DATIVE = "хитину пришельца",
		ACCUSATIVE = "хитин пришельца",
		INSTRUMENTAL = "хитином пришельца",
		PREPOSITIONAL = "хитине пришельца"
	)

/obj/item/xenos_claw
	name = "alien claw"
	desc = "Коготь ужасного существа."
	icon = 'icons/mob/nonhuman-player/alien.dmi'
	icon_state = "claw"

/obj/item/xenos_claw/get_ru_names()
	return alist(
		NOMINATIVE = "коготь пришельца",
		GENITIVE = "когтя пришельца",
		DATIVE = "когтю пришельца",
		ACCUSATIVE = "коготь пришельца",
		INSTRUMENTAL = "когтем пришельца",
		PREPOSITIONAL = "когте пришельца"
	)

/**
 * MARK: Чешуя карпа
 */
/obj/item/stack/sheet/animalhide/carp
	name = "carp scales"
	desc = "Чешуйчатая кожа космического карпа. Выглядит довольно красиво, будучи отделённой от отвратительного существа, которое её носило."
	singular_name = "carp scale"
	icon_state = "sheet-carp"
	inhand_icon_state = null
	merge_type = /obj/item/stack/sheet/animalhide/carp

/obj/item/stack/sheet/animalhide/carp/get_ru_names()
	return alist(
		NOMINATIVE = "чешуя карпа",
		GENITIVE = "чешуи карпа",
		DATIVE = "чешуе карпа",
		ACCUSATIVE = "чешую карпа",
		INSTRUMENTAL = "чешуёй карпа",
		PREPOSITIONAL = "чешуе карпа"
	)

GLOBAL_LIST_INIT(carp_recipes, list ( \
	new/datum/stack_recipe("костюм карпа", /obj/item/clothing/suit/hooded/carp_costume, 4, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("маска карпа", /obj/item/clothing/mask/gas/carp, 1, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("кресло из кожи карпа", /obj/structure/chair/comfy/carp, 2, crafting_flags = NONE, category = CAT_FURNITURE), \
	new/datum/stack_recipe("костюм из кожи карпа", /obj/item/clothing/under/suit/carpskin, 3, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("фетровая шляпа из кожи карпа", /obj/item/clothing/head/fedora/carpskin, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("рыбацкая сумка из кожи карпа", /obj/item/storage/bag/fishing/carpskin, 3, crafting_flags = NONE, category = CAT_CONTAINERS), \
	))

/obj/item/stack/sheet/animalhide/carp/get_main_recipes()
	. = ..()
	. += GLOB.carp_recipes

/obj/item/stack/sheet/animalhide/carp/five
	amount = 5

/**
 * MARK: Кожа
 */
/obj/item/stack/sheet/leather
	name = "leather"
	desc = "Побочный продукт переработки животных."
	singular_name = "leather piece"
	icon_state = "sheet-leather"
	inhand_icon_state = null
	merge_type = /obj/item/stack/sheet/leather
	pickup_sound = 'sound/items/handling/materials/skin_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/skin_drop.ogg'

/obj/item/stack/sheet/leather/get_ru_names()
	return alist(
		NOMINATIVE = "кожа",
		GENITIVE = "кожи",
		DATIVE = "коже",
		ACCUSATIVE = "кожу",
		INSTRUMENTAL = "кожей",
		PREPOSITIONAL = "коже"
	)

GLOBAL_LIST_INIT(leather_recipes, list ( \
	new /datum/stack_recipe("кошелёк", /obj/item/storage/wallet, 1, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new /datum/stack_recipe("намордник", /obj/item/clothing/mask/muzzle, 2, crafting_flags = NONE, category = CAT_ENTERTAINMENT), \
	new /datum/stack_recipe("баскетбольный мяч", /obj/item/toy/basketball, 20, crafting_flags = NONE, category = CAT_ENTERTAINMENT), \
	new /datum/stack_recipe("бейсбольный мяч", /obj/item/toy/beach_ball/baseball, 3, crafting_flags = NONE, category = CAT_ENTERTAINMENT), \
	new /datum/stack_recipe("седло", /obj/item/goliath_saddle, 5, crafting_flags = NONE, category = CAT_EQUIPMENT), \
	new /datum/stack_recipe("кожаные туфли", /obj/item/clothing/shoes/laceup, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
	new /datum/stack_recipe("ковбойские сапоги", /obj/item/clothing/shoes/cowboy, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
	new /datum/stack_recipe("ботанические перчатки", /obj/item/clothing/gloves/botanic_leather, 3, crafting_flags = NONE, category = CAT_CLOTHING), \
	new /datum/stack_recipe("кожаная сумка", /obj/item/storage/backpack/satchel/leather, 5, crafting_flags = NONE, category = CAT_CLOTHING), \
	new /datum/stack_recipe("жилет шерифа", /obj/item/clothing/accessory/vest_sheriff, 4, crafting_flags = NONE, category = CAT_CLOTHING), \
	new /datum/stack_recipe("кожаная куртка", /obj/item/clothing/suit/jacket/leather, 7, crafting_flags = NONE, category = CAT_CLOTHING), \
	new /datum/stack_recipe("косуха байкера", /obj/item/clothing/suit/jacket/leather/biker, 7, crafting_flags = NONE, category = CAT_CLOTHING), \
	new /datum/stack_recipe_list("Пояса", list( \
		new /datum/stack_recipe("пояс для инструментов", /obj/item/storage/belt/utility, 4, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("ботанический пояс", /obj/item/storage/belt/plant, 2, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("пояс уборщика", /obj/item/storage/belt/janitor, 2, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("медицинский пояс", /obj/item/storage/belt/medical, 2, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("пояс службы безопасности", /obj/item/storage/belt/security, 2, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("плечевая кобура", /obj/item/storage/belt/holster, 3, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("бандельер", /obj/item/storage/belt/bandolier, 5, crafting_flags = NONE, category = CAT_CONTAINERS), \
	)),
	new /datum/stack_recipe_list("Шляпы", list( \
		new /datum/stack_recipe("шляпа шерифа", /obj/item/clothing/head/cowboy/brown, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
		new /datum/stack_recipe("шляпа десперадо", /obj/item/clothing/head/cowboy/black, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
		new /datum/stack_recipe("десятигаллонная шляпа", /obj/item/clothing/head/cowboy/white, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
		new /datum/stack_recipe("шляпа помощника", /obj/item/clothing/head/cowboy/red, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
		new /datum/stack_recipe("шляпа странника", /obj/item/clothing/head/cowboy/grey, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
	)),
))

/obj/item/stack/sheet/leather/get_main_recipes()
	. = ..()
	. += GLOB.leather_recipes

/obj/item/stack/sheet/leather/five
	amount = 5

/**
 * MARK: Сухожилия
 */
/obj/item/stack/sheet/sinew
	name = "watcher sinew"
	icon = 'icons/obj/mining.dmi'
	desc = "Длинные волокнистые нити, предположительно взятые с крыльев наблюдателя."
	singular_name = "watcher sinew"
	icon_state = "sinew"
	novariants = TRUE
	merge_type = /obj/item/stack/sheet/sinew
	drop_sound = 'sound/effects/meatslap.ogg'
	pickup_sound = 'sound/effects/meatslap.ogg'
	resistance_flags = FIRE_PROOF | LAVA_PROOF

/obj/item/stack/sheet/sinew/get_ru_names()
	return alist(
		NOMINATIVE = "сухожилие наблюдателя",
		GENITIVE = "сухожилия наблюдателя",
		DATIVE = "сухожилию наблюдателя",
		ACCUSATIVE = "сухожилие наблюдателя",
		INSTRUMENTAL = "сухожилием наблюдателя",
		PREPOSITIONAL = "сухожилии наблюдателя"
	)

/obj/item/stack/sheet/sinew/Initialize(mapload, new_amount, merge, list/mat_override, mat_amt)
	. = ..()

	// As bone and sinew have just a little too many recipes for this, we'll just split them up.
	// Sinew slapcrafting will mostly-sinew recipes, and bones will have mostly-bones recipes.
	var/static/list/slapcraft_recipe_list = list(\
		/datum/crafting_recipe/goliathcloak, /datum/crafting_recipe/skilt, /datum/crafting_recipe/drakecloak,\
		)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/stack/sheet/sinew/wolf
	name = "wolf sinew"
	desc = "Длинные волокнистые нити, взятые изнутри волка."
	singular_name = "wolf sinew"
	merge_type = /obj/item/stack/sheet/sinew/wolf

/obj/item/stack/sheet/sinew/wolf/get_ru_names()
	return alist(
		NOMINATIVE = "волчье сухожилие",
		GENITIVE = "волчьего сухожилия",
		DATIVE = "волчьему сухожилию",
		ACCUSATIVE = "волчье сухожилие",
		INSTRUMENTAL = "волчьим сухожилием",
		PREPOSITIONAL = "волчьем сухожилии"
	)

GLOBAL_LIST_INIT(sinew_recipes, list ( \
	new/datum/stack_recipe("сухожильные стяжки", /obj/item/restraints/handcuffs/cable/sinew, 1, crafting_flags = NONE, category = CAT_EQUIPMENT), \
))

/obj/item/stack/sheet/sinew/get_main_recipes()
	. = ..()
	. += GLOB.sinew_recipes


/**
 * MARK: Шкура голиафа
 */
/obj/item/stack/sheet/animalhide/goliath_hide
	name = "goliath hide plates"
	desc = "Куски каменной шкуры голиафа, которые могут сделать ваш костюм немного более устойчивым к атакам местной фауны."
	icon = 'icons/obj/stack_objects.dmi'
	icon_state = "goliath_hide"
	singular_name = "hide plate"
	max_amount = 6
	novariants = FALSE
	item_flags = NOBLUDGEON
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	w_class = WEIGHT_CLASS_NORMAL
	layer = MOB_LAYER
	merge_type = /obj/item/stack/sheet/animalhide/goliath_hide

/obj/item/stack/sheet/animalhide/goliath_hide/get_ru_names()
	return alist(
		NOMINATIVE = "пластины шкуры голиафа",
		GENITIVE = "пластин шкуры голиафа",
		DATIVE = "пластинам шкуры голиафа",
		ACCUSATIVE = "пластины шкуры голиафа",
		INSTRUMENTAL = "пластинами шкуры голиафа",
		PREPOSITIONAL = "пластинах шкуры голиафа"
	)

/**
 * MARK: Шкура медведя
 */

/obj/item/stack/sheet/animalhide/bear
	name = "bear hide"
	desc = "Пушистые шкуры медведя. Представьте, как тепло вам было бы, укутавшись в пальто из этого материала."
	icon_state = "bear_hide" //change
	singular_name = "bear pelt"
	merge_type = /obj/item/stack/sheet/animalhide/bear
	novariants = FALSE

/obj/item/stack/sheet/animalhide/bear/get_ru_names()
	return alist(
		NOMINATIVE = "медвежья шкура",
		GENITIVE = "медвежьей шкуры",
		DATIVE = "медвежьей шкуре",
		ACCUSATIVE = "медвежью шкуру",
		INSTRUMENTAL = "медвежьей шкурой",
		PREPOSITIONAL = "медвежьей шкуре"
	)

GLOBAL_LIST_INIT(bear_pelt_recipes, list ( \
	new/datum/stack_recipe("костюм медьведя", /obj/item/clothing/suit/costume/bear_suit, 5, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("медвежья шапка", /obj/item/clothing/head/costume/bearpelt, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
))

/**
 * MARK: Белого медведя
 */
/obj/item/stack/sheet/animalhide/goliath_hide/polar_bear_hide
	name = "polar bear hides"
	desc = "Куски меха белого медведя, которые могут сделать ваш костюм немного более устойчивым к атакам местной фауны."
	icon_state = "polar_bear_hide"
	singular_name = "polar bear hide"
	merge_type = /obj/item/stack/sheet/animalhide/goliath_hide/polar_bear_hide

/obj/item/stack/sheet/animalhide/goliath_hide/polar_bear_hide/get_ru_names()
	return alist(
		NOMINATIVE = "шкуры белого медведя",
		GENITIVE = "шкур белого медведя",
		DATIVE = "шкурам белого медведя",
		ACCUSATIVE = "шкуры белого медведя",
		INSTRUMENTAL = "шкурами белого медведя",
		PREPOSITIONAL = "шкурах белого медведя"
	)

/**
 * MARK: Шкура дракона
 */
/obj/item/stack/sheet/animalhide/ashdrake
	name = "ash drake hide"
	desc = "Прочная, покрытая чешуёй шкура пепельного дракона."
	icon = 'icons/obj/stack_objects.dmi'
	icon_state = "dragon_hide"
	singular_name = "drake plate"
	max_amount = 10
	novariants = FALSE
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_NORMAL
	layer = MOB_LAYER
	merge_type = /obj/item/stack/sheet/animalhide/ashdrake

/obj/item/stack/sheet/animalhide/ashdrake/get_ru_names()
	return alist(
		NOMINATIVE = "шкура пепельного дракона",
		GENITIVE = "шкуры пепельного дракона",
		DATIVE = "шкуре пепельного дракона",
		ACCUSATIVE = "шкуру пепельного дракона",
		INSTRUMENTAL = "шкурой пепельного дракона",
		PREPOSITIONAL = "шкуре пепельного дракона"
	)

/obj/item/stack/sheet/animalhide/ashdrake/Initialize(mapload, new_amount, merge, list/mat_override, mat_amt)
	. = ..()

	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/drakecloak)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/stack/sheet/animalhide/bear/get_main_recipes()
	. = ..()
	. += GLOB.bear_pelt_recipes


/**
 * MARK: Обработка
 */
/// Шаг первый - удаление волосяного покрова.
/obj/item/stack/sheet/animalhide/attackby(obj/item/W, mob/user, list/modifiers, list/attack_modifiers)
	if(W.get_sharpness())
		playsound(loc, 'sound/items/weapons/slice.ogg', 50, TRUE, -1)
		user.visible_message(span_notice("[user] начинает срезать шерсть с [RU_SRC_GEN]."), span_notice("Вы начинаете срезать шерсть с [RU_SRC_GEN]..."), span_hear("Вы слышите звук ножа, трущегося о плоть."))
		if(do_after(user, 5 SECONDS, target = src))
			to_chat(user, span_notice("Вы срезали шерсть с [RU_SRC_GEN]."))
			new /obj/item/stack/sheet/hairlesshide(user.drop_location(), amount)
			use(amount)
	else
		return ..()

/obj/item/stack/sheet/animalhide/examine(mob/user)
	. = ..()
	. += span_notice("Шерсть можно удалить любым острым предметом.")

/// Шаг второй стирка..... на самом деле это указано в коде стиральной машины.
/obj/item/stack/sheet/hairlesshide
	name = "hairless hide"
	desc = "С этой шкуры удалили шерсть, но её ещё нужно вымыть и выдубить."
	singular_name = "hairless hide piece"
	icon_state = "sheet-hairlesshide"
	inhand_icon_state = null
	merge_type = /obj/item/stack/sheet/hairlesshide
	pickup_sound = 'sound/items/handling/materials/skin_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/skin_drop.ogg'

/obj/item/stack/sheet/hairlesshide/get_ru_names()
	return alist(
		NOMINATIVE = "безволосая шкура",
		GENITIVE = "безволосой шкуры",
		DATIVE = "безволосой шкуре",
		ACCUSATIVE = "безволосую шкуру",
		INSTRUMENTAL = "безволосой шкурой",
		PREPOSITIONAL = "безволосой шкуре"
	)

/obj/item/stack/sheet/hairlesshide/examine(mob/user)
	. = ..()
	. += span_notice("Её можно очистить, вымыв в воде.")

/// Шаг третий - сушка
/obj/item/stack/sheet/wethide
	name = "wet hide"
	desc = "Эта шкура была очищена, но её ещё нужно высушить."
	singular_name = "wet hide piece"
	icon_state = "sheet-wetleather"
	inhand_icon_state = null
	merge_type = /obj/item/stack/sheet/wethide
	pickup_sound = 'sound/items/handling/materials/skin_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/skin_drop.ogg'
	/// Reduced when exposed to high temperatures
	var/wetness = 30
	/// Kelvin to start drying
	var/drying_threshold_temperature = 500

/obj/item/stack/sheet/wethide/get_ru_names()
	return alist(
		NOMINATIVE = "мокрая шкура",
		GENITIVE = "мокрой шкуры",
		DATIVE = "мокрой шкуре",
		ACCUSATIVE = "мокрую шкуру",
		INSTRUMENTAL = "мокрой шкурой",
		PREPOSITIONAL = "мокрой шкуре"
	)

/obj/item/stack/sheet/wethide/examine(mob/user)
	. = ..()
	. += span_notice("Её можно высушить, чтобы получить кожу.")

/obj/item/stack/sheet/wethide/Initialize(mapload, new_amount, merge = TRUE, list/mat_override=null, mat_amt=1)
	. = ..()
	AddElement(/datum/element/atmos_sensitive, mapload)
	AddElement(/datum/element/dryable, /obj/item/stack/sheet/leather)
	AddElement(/datum/element/microwavable, /obj/item/stack/sheet/leather)
	AddComponent(/datum/component/grillable, /obj/item/stack/sheet/leather, rand(1 SECONDS, 3 SECONDS), TRUE)
	AddComponent(/datum/component/bakeable, /obj/item/stack/sheet/leather, rand(15 SECONDS, 20 SECONDS), TRUE, TRUE)

/obj/item/stack/sheet/wethide/burn()
	visible_message(span_notice("[capitalize(declent_ru(NOMINATIVE))] высыхает!"))
	new /obj/item/stack/sheet/leather(loc, amount) // all the sheets to incentivize not losing your whole stack by accident
	qdel(src)

/obj/item/stack/sheet/wethide/should_atmos_process(datum/gas_mixture/air, exposed_temperature)
	return (exposed_temperature > drying_threshold_temperature)

/obj/item/stack/sheet/wethide/atmos_expose(datum/gas_mixture/air, exposed_temperature)
	wetness--
	if(wetness == 0)
		new /obj/item/stack/sheet/leather(drop_location(), amount)
		wetness = initial(wetness)
		use(1)
