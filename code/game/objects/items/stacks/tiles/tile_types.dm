/**
 * TILE STACKS
 *
 * Allows us to place a turf on a plating.
 */
/obj/item/stack/tile
	name = "broken tile"
	singular_name = "broken tile"
	desc = "Сломанная плитка. Этого не должно существовать."
	gender = FEMALE
	lefthand_file = 'icons/mob/inhands/items/tiles_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/tiles_righthand.dmi'
	icon = 'icons/obj/tiles.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	force = 1
	throwforce = 1
	throw_speed = 3
	throw_range = 7
	max_amount = 60
	novariants = TRUE
	material_flags = MATERIAL_EFFECTS
	/// What type of turf does this tile produce.
	var/turf_type = null
	/// What dir will the turf have?
	var/turf_dir = SOUTH
	/// Cached associative lazy list to hold the radial options for tile reskinning. See tile_reskinning.dm for more information. Pattern: list[type] -> image
	var/list/tile_reskin_types
	/// Cached associative lazy list to hold the radial options for tile dirs. See tile_reskinning.dm for more information.
	var/list/tile_rotate_dirs
	/// tile_rotate_dirs but before it gets converted to text
	var/list/tile_rotate_dirs_number

/obj/item/stack/tile/get_ru_names()
	return alist(
		NOMINATIVE = "сломанная плитка",
		GENITIVE = "сломанной плитки",
		DATIVE = "сломанной плитке",
		ACCUSATIVE = "сломанную плитку",
		INSTRUMENTAL = "сломанной плиткой",
		PREPOSITIONAL = "сломанной плитке",
	)


/obj/item/stack/tile/Initialize(mapload, new_amount, merge = TRUE, list/mat_override=null, mat_amt=1)
	. = ..()
	pixel_x = rand(-3, 3)
	pixel_y = rand(-3, 3) //randomize a little
	AddElement(/datum/element/openspace_item_click_handler)
	if(tile_reskin_types)
		tile_reskin_types = tile_reskin_list(tile_reskin_types)
	if(tile_rotate_dirs)
		tile_rotate_dirs_number = tile_rotate_dirs.Copy()
		var/list/values = list()
		for(var/set_dir in tile_rotate_dirs)
			values += dir2text(set_dir)
		tile_rotate_dirs = tile_dir_list(values, turf_type)


/obj/item/stack/tile/examine(mob/user)
	. = ..()
	if(tile_reskin_types || tile_rotate_dirs)
		. += span_notice("Используйте в руке, чтобы изменить тип [RU_SRC_GEN].")
	if(throwforce && !is_cyborg) //do not want to divide by zero or show the message to borgs who can't throw
		var/damage_value
		switch(CEILING(MAX_LIVING_HEALTH / throwforce, 1)) //throws to crit a human
			if(1 to 3)
				damage_value = "превосходным"
			if(4 to 6)
				damage_value = "отличным"
			if(7 to 9)
				damage_value = "хорошим"
			if(10 to 12)
				damage_value = "неплохим"
			if(13 to 15)
				damage_value = "посредственным"
		if(!damage_value)
			return
		. += span_notice("Может послужить [damage_value] метательным оружием.")

/**
 * Place our tile on a plating, or replace it.
 *
 * Arguments:
 * * target_plating - Instance of the plating we want to place on. Replaced during successful executions.
 * * user - The mob doing the placing.
 */
/obj/item/stack/tile/proc/place_tile(turf/open/floor/plating/target_plating, mob/user)
	var/turf/placed_turf_path = turf_type
	if(!ispath(placed_turf_path))
		return
	if(!istype(target_plating))
		return

	if(!use(1))
		return
	target_plating = target_plating.place_on_top(placed_turf_path, flags = CHANGETURF_INHERIT_AIR)
	target_plating.setDir(turf_dir)
	playsound(target_plating, 'sound/items/weapons/genhit.ogg', 50, TRUE)
	return target_plating

/obj/item/stack/tile/handle_openspace_click(turf/target, mob/user, list/modifiers)
	target.attackby(src, user, list2params(modifiers))

//Grass
/obj/item/stack/tile/grass
	name = "grass tile"
	singular_name = "grass floor tile"
	desc = "Кусочек газона, как на полях для космического гольфа."
	icon_state = "tile_grass"
	inhand_icon_state = "tile-grass"
	turf_type = /turf/open/floor/grass
	resistance_flags = FLAMMABLE
	merge_type = /obj/item/stack/tile/grass

/obj/item/stack/tile/grass/get_ru_names()
	return alist(
		NOMINATIVE = "дерновая плитка",
		GENITIVE = "дерновой плитки",
		DATIVE = "дерновой плитке",
		ACCUSATIVE = "дерновую плитку",
		INSTRUMENTAL = "дерновой плиткой",
		PREPOSITIONAL = "дерновой плитке",
	)

//Hay
/obj/item/stack/tile/hay
	name = "hay tile"
	singular_name = "hay floor tile"
	desc = "Блин, я так голоден, что мог бы съесть сл..."
	icon_state = "tile_hay"
	inhand_icon_state = "tile-hay"
	turf_type = /turf/open/floor/hay
	resistance_flags = FLAMMABLE
	merge_type = /obj/item/stack/tile/hay

/obj/item/stack/tile/hay/get_ru_names()
	return alist(
		NOMINATIVE = "сноп сена",
		GENITIVE = "снопа сена",
		DATIVE = "снопу сена",
		ACCUSATIVE = "сноп сена",
		INSTRUMENTAL = "снопом сена",
		PREPOSITIONAL = "снопе сена",
	)

//Fairygrass
/obj/item/stack/tile/fairygrass
	name = "fairygrass tile"
	singular_name = "fairygrass floor tile"
	desc = "Кусочек странной светящейся синей травы."
	icon_state = "tile_fairygrass"
	turf_type = /turf/open/floor/grass/fairy
	resistance_flags = FLAMMABLE
	merge_type = /obj/item/stack/tile/fairygrass

/obj/item/stack/tile/fairygrass/get_ru_names()
	return alist(
		NOMINATIVE = "волшебная дерновая плитка",
		GENITIVE = "волшебной дерновой плитки",
		DATIVE = "волшебной дерновой плитке",
		ACCUSATIVE = "волшебную дерновую плитку",
		INSTRUMENTAL = "волшебной дерновой плиткой",
		PREPOSITIONAL = "волшебной дерновой плитке",
	)

//Wood
/obj/item/stack/tile/wood
	name = "wood floor tile"
	singular_name = "wood floor tile"
	desc = "Легко укладываемая деревянная плитка. Используйте в руке, чтобы выбрать узор."
	icon_state = "tile-wood"
	inhand_icon_state = "tile-wood"
	turf_type = /turf/open/floor/wood
	resistance_flags = FLAMMABLE
	merge_type = /obj/item/stack/tile/wood
	tile_reskin_types = list(
		/obj/item/stack/tile/wood,
		/obj/item/stack/tile/wood/large,
		/obj/item/stack/tile/wood/tile,
		/obj/item/stack/tile/wood/parquet,
	)
	mats_per_unit = list(/datum/material/wood = HALF_SHEET_MATERIAL_AMOUNT / 2)

/obj/item/stack/tile/wood/get_ru_names()
	return alist(
		NOMINATIVE = "деревянная плитка",
		GENITIVE = "деревянной плитки",
		DATIVE = "деревянной плитке",
		ACCUSATIVE = "деревянную плитку",
		INSTRUMENTAL = "деревянной плиткой",
		PREPOSITIONAL = "деревянной плитке",
	)

/obj/item/stack/tile/wood/parquet
	name = "parquet wood floor tile"
	singular_name = "parquet wood floor tile"
	icon_state = "tile-wood_parquet"
	turf_type = /turf/open/floor/wood/parquet
	merge_type = /obj/item/stack/tile/wood/parquet

/obj/item/stack/tile/wood/parquet/get_ru_names()
	return alist(
		NOMINATIVE = "паркетная плитка",
		GENITIVE = "паркетной плитки",
		DATIVE = "паркетной плитке",
		ACCUSATIVE = "паркетную плитку",
		INSTRUMENTAL = "паркетной плиткой",
		PREPOSITIONAL = "паркетной плитке",
	)

/obj/item/stack/tile/wood/large
	name = "large wood floor tile"
	singular_name = "large wood floor tile"
	icon_state = "tile-wood_large"
	turf_type = /turf/open/floor/wood/large
	merge_type = /obj/item/stack/tile/wood/large

/obj/item/stack/tile/wood/large/get_ru_names()
	return alist(
		NOMINATIVE = "большая деревянная плитка",
		GENITIVE = "большой деревянной плитки",
		DATIVE = "большой деревянной плитке",
		ACCUSATIVE = "большую деревянную плитку",
		INSTRUMENTAL = "большой деревянной плиткой",
		PREPOSITIONAL = "большой деревянной плитке",
	)

/obj/item/stack/tile/wood/tile
	name = "tiled wood floor tile"
	singular_name = "tiled wood floor tile"
	icon_state = "tile-wood_tile"
	turf_type = /turf/open/floor/wood/tile
	merge_type = /obj/item/stack/tile/wood/tile

/obj/item/stack/tile/wood/tile/get_ru_names()
	return alist(
		NOMINATIVE = "узорчатая деревянная плитка",
		GENITIVE = "узорчатой деревянной плитки",
		DATIVE = "узорчатой деревянной плитке",
		ACCUSATIVE = "узорчатую деревянную плитку",
		INSTRUMENTAL = "узорчатой деревянной плиткой",
		PREPOSITIONAL = "узорчатой деревянной плитке",
	)

//Bamboo
/obj/item/stack/tile/bamboo
	name = "bamboo mat pieces"
	singular_name = "bamboo mat piece"
	desc = "Часть бамбукового мата с декоративной отделкой."
	icon_state = "tile_bamboo"
	inhand_icon_state = "tile-bamboo"
	turf_type = /turf/open/floor/bamboo
	merge_type = /obj/item/stack/tile/bamboo
	resistance_flags = FLAMMABLE
	tile_reskin_types = list(
		/obj/item/stack/tile/bamboo,
		/obj/item/stack/tile/bamboo/tatami,
		/obj/item/stack/tile/bamboo/tatami/purple,
		/obj/item/stack/tile/bamboo/tatami/black,
	)
	mats_per_unit = list(/datum/material/bamboo = HALF_SHEET_MATERIAL_AMOUNT / 2)

/obj/item/stack/tile/bamboo/get_ru_names()
	return alist(
		NOMINATIVE = "часть бамбукового мата",
		GENITIVE = "части бамбукового мата",
		DATIVE = "части бамбукового мата",
		ACCUSATIVE = "часть бамбукового мата",
		INSTRUMENTAL = "частью бамбукового мата",
		PREPOSITIONAL = "части бамбукового мата",
	)

/obj/item/stack/tile/bamboo/tatami
	name = "Tatami with green rim"
	singular_name = "green tatami floor tile"
	icon_state = "tile_tatami_green"
	turf_type = /turf/open/floor/bamboo/tatami
	merge_type = /obj/item/stack/tile/bamboo/tatami
	tile_rotate_dirs = list(NORTH, EAST, SOUTH, WEST)

/obj/item/stack/tile/bamboo/tatami/get_ru_names()
	return alist(
		NOMINATIVE = "плитка татами (зелёная)",
		GENITIVE = "плитки татами (зелёной)",
		DATIVE = "плитке татами (зелёной)",
		ACCUSATIVE = "плитку татами (зелёную)",
		INSTRUMENTAL = "плиткой татами (зелёной)",
		PREPOSITIONAL = "плитке татами (зелёной)",
	)

/obj/item/stack/tile/bamboo/tatami/purple
	name = "Tatami with purple rim"
	singular_name = "purple tatami floor tile"
	icon_state = "tile_tatami_purple"
	turf_type = /turf/open/floor/bamboo/tatami/purple
	merge_type = /obj/item/stack/tile/bamboo/tatami/purple

/obj/item/stack/tile/bamboo/tatami/purple/get_ru_names()
	return alist(
		NOMINATIVE = "плитка татами (фиолетовая)",
		GENITIVE = "плитки татами (фиолетовой)",
		DATIVE = "плитке татами (фиолетовой)",
		ACCUSATIVE = "плитку татами (фиолетовую)",
		INSTRUMENTAL = "плиткой татами (фиолетовой)",
		PREPOSITIONAL = "плитке татами (фиолетовой)",
	)

/obj/item/stack/tile/bamboo/tatami/black
	name = "Tatami with black rim"
	singular_name = "black tatami floor tile"
	icon_state = "tile_tatami_black"
	turf_type = /turf/open/floor/bamboo/tatami/black
	merge_type = /obj/item/stack/tile/bamboo/tatami/black

/obj/item/stack/tile/bamboo/tatami/black/get_ru_names()
	return alist(
		NOMINATIVE = "плитка татами (чёрная)",
		GENITIVE = "плитки татами (чёрной)",
		DATIVE = "плитке татами (чёрной)",
		ACCUSATIVE = "плитку татами (чёрную)",
		INSTRUMENTAL = "плиткой татами (чёрной)",
		PREPOSITIONAL = "плитке татами (чёрной)",
	)

//Basalt
/obj/item/stack/tile/basalt
	name = "basalt tile"
	singular_name = "basalt floor tile"
	desc = "Искусственно созданная пепельная почва, имитирующая враждебную среду."
	icon_state = "tile_basalt"
	inhand_icon_state = "tile-basalt"
	turf_type = /turf/open/floor/fakebasalt
	merge_type = /obj/item/stack/tile/basalt
	mats_per_unit = list(/datum/material/sand = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/stack/tile/basalt/get_ru_names()
	return alist(
		NOMINATIVE = "базальтовая плитка",
		GENITIVE = "базальтовой плитки",
		DATIVE = "базальтовой плитке",
		ACCUSATIVE = "базальтовую плитку",
		INSTRUMENTAL = "базальтовой плиткой",
		PREPOSITIONAL = "базальтовой плитке",
	)

//Carpets
/obj/item/stack/tile/carpet
	name = "carpet"
	singular_name = "carpet tile"
	desc = "Кусок ковролина. По размеру совпадает с напольной плиткой."
	icon_state = "tile-carpet"
	inhand_icon_state = "tile-carpet"
	turf_type = /turf/open/floor/carpet
	resistance_flags = FLAMMABLE
	table_type = /obj/structure/table/wood/fancy
	merge_type = /obj/item/stack/tile/carpet
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet,
		/obj/item/stack/tile/carpet/symbol,
		/obj/item/stack/tile/carpet/star,
	)

/obj/item/stack/tile/carpet/get_ru_names()
	return alist(
		NOMINATIVE = "ковровая плитка",
		GENITIVE = "ковровой плитки",
		DATIVE = "ковровой плитке",
		ACCUSATIVE = "ковровую плитку",
		INSTRUMENTAL = "ковровой плиткой",
		PREPOSITIONAL = "ковровой плитке",
	)

/obj/item/stack/tile/carpet/symbol
	name = "symbol carpet"
	singular_name = "symbol carpet tile"
	icon_state = "tile-carpet-symbol"
	desc = "Кусок ковролина. На этом изображён символ."
	turf_type = /turf/open/floor/carpet/lone
	merge_type = /obj/item/stack/tile/carpet/symbol
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST, SOUTHEAST)

/obj/item/stack/tile/carpet/symbol/get_ru_names()
	return alist(
		NOMINATIVE = "ковровая плитка с символом",
		GENITIVE = "ковровой плитки с символом",
		DATIVE = "ковровой плитке с символом",
		ACCUSATIVE = "ковровую плитку с символом",
		INSTRUMENTAL = "ковровой плиткой с символом",
		PREPOSITIONAL = "ковровой плитке с символом",
	)

/obj/item/stack/tile/carpet/star
	name = "star carpet"
	singular_name = "star carpet tile"
	icon_state = "tile-carpet-star"
	desc = "Кусок ковролина. На этом изображена звезда."
	turf_type = /turf/open/floor/carpet/lone/star
	merge_type = /obj/item/stack/tile/carpet/star

/obj/item/stack/tile/carpet/star/get_ru_names()
	return alist(
		NOMINATIVE = "ковровая плитка со звездой",
		GENITIVE = "ковровой плитки со звездой",
		DATIVE = "ковровой плитке со звездой",
		ACCUSATIVE = "ковровую плитку со звездой",
		INSTRUMENTAL = "ковровой плиткой со звездой",
		PREPOSITIONAL = "ковровой плитке со звездой",
	)

/obj/item/stack/tile/carpet/black
	name = "black carpet"
	icon_state = "tile-carpet-black"
	inhand_icon_state = "tile-carpet-black"
	turf_type = /turf/open/floor/carpet/black
	table_type = /obj/structure/table/wood/fancy/black
	merge_type = /obj/item/stack/tile/carpet/black
	tile_reskin_types = null

/obj/item/stack/tile/carpet/black/get_ru_names()
	return alist(
		NOMINATIVE = "черная ковровая плитка",
		GENITIVE = "черной ковровой плитки",
		DATIVE = "черной ковровой плитке",
		ACCUSATIVE = "черную ковровую плитку",
		INSTRUMENTAL = "черной ковровой плиткой",
		PREPOSITIONAL = "черной ковровой плитке",
	)

/obj/item/stack/tile/carpet/blue
	name = "blue carpet"
	icon_state = "tile-carpet-blue"
	inhand_icon_state = "tile-carpet-blue"
	turf_type = /turf/open/floor/carpet/blue
	table_type = /obj/structure/table/wood/fancy/blue
	merge_type = /obj/item/stack/tile/carpet/blue
	tile_reskin_types = null


/obj/item/stack/tile/carpet/cyan
	name = "cyan carpet"
	icon_state = "tile-carpet-cyan"
	inhand_icon_state = "tile-carpet-cyan"
	turf_type = /turf/open/floor/carpet/cyan
	table_type = /obj/structure/table/wood/fancy/cyan
	merge_type = /obj/item/stack/tile/carpet/cyan
	tile_reskin_types = null


/obj/item/stack/tile/carpet/cyan/get_ru_names()
	return alist(
		NOMINATIVE = "голубая ковровая плитка",
		GENITIVE = "голубой ковровой плитки",
		DATIVE = "голубой ковровой плитке",
		ACCUSATIVE = "голубую ковровую плитку",
		INSTRUMENTAL = "голубой ковровой плиткой",
		PREPOSITIONAL = "голубой ковровой плитке",
	)


/obj/item/stack/tile/carpet/green
	name = "green carpet"
	icon_state = "tile-carpet-green"
	inhand_icon_state = "tile-carpet-green"
	turf_type = /turf/open/floor/carpet/green
	table_type = /obj/structure/table/wood/fancy/green
	merge_type = /obj/item/stack/tile/carpet/green
	tile_reskin_types = null

/obj/item/stack/tile/carpet/green/get_ru_names()
	return alist(
		NOMINATIVE = "зеленая ковровая плитка",
		GENITIVE = "зеленой ковровой плитки",
		DATIVE = "зеленой ковровой плитке",
		ACCUSATIVE = "зеленую ковровую плитку",
		INSTRUMENTAL = "зеленой ковровой плиткой",
		PREPOSITIONAL = "зеленой ковровой плитке",
	)


/obj/item/stack/tile/carpet/orange
	name = "orange carpet"
	icon_state = "tile-carpet-orange"
	inhand_icon_state = "tile-carpet-orange"
	turf_type = /turf/open/floor/carpet/orange
	table_type = /obj/structure/table/wood/fancy/orange
	merge_type = /obj/item/stack/tile/carpet/orange
	tile_reskin_types = null

/obj/item/stack/tile/carpet/purple
	name = "purple carpet"
	icon_state = "tile-carpet-purple"
	inhand_icon_state = "tile-carpet-purple"
	turf_type = /turf/open/floor/carpet/purple
	table_type = /obj/structure/table/wood/fancy/purple
	merge_type = /obj/item/stack/tile/carpet/purple
	tile_reskin_types = null

/obj/item/stack/tile/carpet/purple/get_ru_names()
	return alist(
		NOMINATIVE = "фиолетовая ковровая плитка",
		GENITIVE = "фиолетовой ковровой плитки",
		DATIVE = "фиолетовой ковровой плитке",
		ACCUSATIVE = "фиолетовую ковровую плитку",
		INSTRUMENTAL = "фиолетовой ковровой плиткой",
		PREPOSITIONAL = "фиолетовой ковровой плитке",
	)


/obj/item/stack/tile/carpet/red
	name = "red carpet"
	icon_state = "tile-carpet-red"
	inhand_icon_state = "tile-carpet-red"
	turf_type = /turf/open/floor/carpet/red
	table_type = /obj/structure/table/wood/fancy/red
	merge_type = /obj/item/stack/tile/carpet/red
	tile_reskin_types = null

/obj/item/stack/tile/carpet/red/get_ru_names()
	return alist(
		NOMINATIVE = "красная ковровая плитка",
		GENITIVE = "красной ковровой плитки",
		DATIVE = "красной ковровой плитке",
		ACCUSATIVE = "красную ковровую плитку",
		INSTRUMENTAL = "красной ковровой плиткой",
		PREPOSITIONAL = "красной ковровой плитке",
	)


/obj/item/stack/tile/carpet/royalblack
	name = "royal black carpet"
	icon_state = "tile-carpet-royalblack"
	inhand_icon_state = "tile-carpet-royalblack"
	turf_type = /turf/open/floor/carpet/royalblack
	table_type = /obj/structure/table/wood/fancy/royalblack
	merge_type = /obj/item/stack/tile/carpet/royalblack
	tile_reskin_types = null

/obj/item/stack/tile/carpet/royalblack/get_ru_names()
	return alist(
		NOMINATIVE = "королевски черная ковровая плитка",
		GENITIVE = "королевски черной ковровой плитки",
		DATIVE = "королевски черной ковровой плитке",
		ACCUSATIVE = "королевски черную ковровую плитку",
		INSTRUMENTAL = "королевски черной ковровой плиткой",
		PREPOSITIONAL = "королевски черной ковровой плитке",
	)

/obj/item/stack/tile/carpet/royalblue
	name = "royal blue carpet"
	icon_state = "tile-carpet-royalblue"
	inhand_icon_state = "tile-carpet-royalblue"
	turf_type = /turf/open/floor/carpet/royalblue
	table_type = /obj/structure/table/wood/fancy/royalblue
	merge_type = /obj/item/stack/tile/carpet/royalblue
	tile_reskin_types = null

/obj/item/stack/tile/carpet/blue/get_ru_names()
	return alist(
		NOMINATIVE = "королевски синяя ковровая плитка",
		GENITIVE = "королевски синей ковровой плитки",
		DATIVE = "королевски синей ковровой плитке",
		ACCUSATIVE = "королевски синюю ковровую плитку",
		INSTRUMENTAL = "королевски синей ковровой плиткой",
		PREPOSITIONAL = "королевски синей ковровой плитке",
	)

/obj/item/stack/tile/carpet/executive
	name = "executive carpet"
	icon_state = "tile_carpet_executive"
	inhand_icon_state = "tile-carpet-royalblue"
	turf_type = /turf/open/floor/carpet/executive
	merge_type = /obj/item/stack/tile/carpet/executive
	tile_reskin_types = null

/obj/item/stack/tile/carpet/executive/get_ru_names()
	return alist(
		NOMINATIVE = "исполнительная ковровая плитка",
		GENITIVE = "исполнительной ковровой плитки",
		DATIVE = "исполнительной ковровой плитке",
		ACCUSATIVE = "исполнительную ковровую плитку",
		INSTRUMENTAL = "исполнительной ковровой плиткой",
		PREPOSITIONAL = "исполнительной ковровой плитке",
	)

/obj/item/stack/tile/carpet/stellar
	name = "stellar carpet"
	icon_state = "tile_carpet_stellar"
	inhand_icon_state = "tile-carpet-royalblue"
	turf_type = /turf/open/floor/carpet/stellar
	merge_type = /obj/item/stack/tile/carpet/stellar
	tile_reskin_types = null

/turf/open/floor/carpet/stellar/get_ru_names()
	return alist(
		NOMINATIVE = "звёздная ковровая плитка",
		GENITIVE = "звёздной ковровой плитке",
		DATIVE = "звёздной ковровой плитке",
		ACCUSATIVE = "звёздную ковровую плитку",
		INSTRUMENTAL = "звёздной ковровой плиткой",
		PREPOSITIONAL = "звёздной ковровой плитке",
	)

/obj/item/stack/tile/carpet/donk
	name = "Donk Co. promotional carpet"
	icon_state = "tile_carpet_donk"
	inhand_icon_state = "tile-carpet-orange"
	turf_type = /turf/open/floor/carpet/donk
	merge_type = /obj/item/stack/tile/carpet/donk
	tile_reskin_types = null

/obj/item/stack/tile/carpet/donk/get_ru_names()
	return alist(
		NOMINATIVE = "рекламная ковровая плитка Donk Co.",
		GENITIVE = "рекламной ковровой плитки Donk Co.",
		DATIVE = "рекламной ковровой плитке Donk Co.",
		ACCUSATIVE = "рекламную ковровую плитку Donk Co.",
		INSTRUMENTAL = "рекламной ковровой плиткой Donk Co.",
		PREPOSITIONAL = "рекламной ковровой плитке Donk Co.",
	)

/obj/item/stack/tile/carpet/fifty
	amount = 50

/obj/item/stack/tile/iron/fifty
	amount = 50

/obj/item/stack/tile/carpet/black/fifty
	amount = 50

/obj/item/stack/tile/carpet/blue/fifty
	amount = 50

/obj/item/stack/tile/carpet/cyan/fifty
	amount = 50

/obj/item/stack/tile/carpet/green/fifty
	amount = 50

/obj/item/stack/tile/carpet/orange/fifty
	amount = 50

/obj/item/stack/tile/carpet/purple/fifty
	amount = 50

/obj/item/stack/tile/carpet/red/fifty
	amount = 50

/obj/item/stack/tile/carpet/royalblack/fifty
	amount = 50

/obj/item/stack/tile/carpet/royalblue/fifty
	amount = 50

/obj/item/stack/tile/carpet/executive/thirty
	amount = 30

/obj/item/stack/tile/carpet/stellar/thirty
	amount = 30

/obj/item/stack/tile/carpet/donk/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon
	name = "neon carpet"
	singular_name = "neon carpet tile"
	desc = "Кусок резинового покрытия со вставками фосфоресцирующего узора."
	inhand_icon_state = "tile-neon"
	turf_type = /turf/open/floor/carpet/neon
	merge_type = /obj/item/stack/tile/carpet/neon
	tile_reskin_types = null


	// Neon overlay
	/// The icon used for the neon overlay and emissive overlay.
	var/neon_icon
	/// The icon state used for the neon overlay and emissive overlay.
	var/neon_icon_state
	/// The icon state used for the neon overlay inhands.
	var/neon_inhand_icon_state
	/// The color used for the neon overlay.
	var/neon_color
	/// The alpha used for the emissive overlay.
	var/emissive_alpha = 150

/obj/item/stack/tile/carpet/neon/get_ru_names()
	return alist(
		NOMINATIVE = "неоновая ковровая плитка",
		GENITIVE = "неоновой ковровой плитки",
		DATIVE = "неоновой ковровой плитке",
		ACCUSATIVE = "неоновую ковровую плитку",
		INSTRUMENTAL = "неоновой ковровой плиткой",
		PREPOSITIONAL = "неоновой ковровой плитке",
	)


/obj/item/stack/tile/carpet/neon/update_overlays()
	. = ..()
	var/mutable_appearance/neon_overlay = mutable_appearance(neon_icon || icon, neon_icon_state || icon_state, alpha = alpha)
	neon_overlay.color = neon_color
	. += neon_overlay
	. += emissive_appearance(neon_icon || icon, neon_icon_state || icon_state, src, alpha = emissive_alpha)

/obj/item/stack/tile/carpet/neon/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands || !neon_inhand_icon_state)
		return

	var/mutable_appearance/neon_overlay = mutable_appearance(icon_file, neon_inhand_icon_state)
	neon_overlay.color = neon_color
	. += neon_overlay
	. += emissive_appearance(icon_file, neon_inhand_icon_state, src, alpha = emissive_alpha)

/obj/item/stack/tile/carpet/neon/simple
	name = "simple neon carpet"
	singular_name = "simple neon carpet tile"
	icon_state = "tile_carpet_neon_simple"
	neon_icon_state = "tile_carpet_neon_simple_light"
	neon_inhand_icon_state = "tile-neon-glow"
	turf_type = /turf/open/floor/carpet/neon/simple
	merge_type = /obj/item/stack/tile/carpet/neon/simple
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple,
		/obj/item/stack/tile/carpet/neon/simple/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/get_ru_names()
	return alist(
		NOMINATIVE = "простая неоновая ковровая плитка",
		GENITIVE = "простой неоновой ковровой плитки",
		DATIVE = "простой неоновой ковровой плитке",
		ACCUSATIVE = "простую неоновую ковровую плитку",
		INSTRUMENTAL = "простой неоновой ковровой плиткой",
		PREPOSITIONAL = "простой неоновой ковровой плитке",
	)


/obj/item/stack/tile/carpet/neon/simple/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_light_nodots"
	neon_inhand_icon_state = "tile-neon-glow-nodots"
	turf_type = /turf/open/floor/carpet/neon/simple
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple,
		/obj/item/stack/tile/carpet/neon/simple/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/white
	name = "simple white neon carpet"
	singular_name = "simple white neon carpet tile"
	turf_type = /turf/open/floor/carpet/neon/simple/white
	merge_type = /obj/item/stack/tile/carpet/neon/simple/white
	neon_color = COLOR_WHITE
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/white,
		/obj/item/stack/tile/carpet/neon/simple/white/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/white/get_ru_names()
	return alist(
		NOMINATIVE = "белая неоновая ковровая плитка",
		GENITIVE = "белой неоновой ковровой плитки",
		DATIVE = "белой неоновой ковровой плитке",
		ACCUSATIVE = "белую неоновую ковровую плитку",
		INSTRUMENTAL = "белой неоновой ковровой плиткой",
		PREPOSITIONAL = "белой неоновой ковровой плитке",
	)

/obj/item/stack/tile/carpet/neon/simple/white/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_light_nodots"
	turf_type = /turf/open/floor/carpet/neon/simple/white/nodots
	merge_type = /obj/item/stack/tile/carpet/neon/simple/white/nodots
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/white,
		/obj/item/stack/tile/carpet/neon/simple/white/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/black
	name = "simple black neon carpet"
	singular_name = "simple black neon carpet tile"
	neon_icon_state = "tile_carpet_neon_simple_glow"
	turf_type = /turf/open/floor/carpet/neon/simple/black
	merge_type = /obj/item/stack/tile/carpet/neon/simple/black
	neon_color = COLOR_BLACK
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/black,
		/obj/item/stack/tile/carpet/neon/simple/black/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/black/get_ru_names()
	return alist(
		NOMINATIVE = "чёрная неоновая ковровая плитка",
		GENITIVE = "чёрной неоновой ковровой плитки",
		DATIVE = "чёрной неоновой ковровой плитке",
		ACCUSATIVE = "чёрную неоновую ковровую плитку",
		INSTRUMENTAL = "чёрной неоновой ковровой плиткой",
		PREPOSITIONAL = "чёрной неоновой ковровой плитке",
	)

/obj/item/stack/tile/carpet/neon/simple/black/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_glow_nodots"
	turf_type = /turf/open/floor/carpet/neon/simple/black/nodots
	merge_type = /obj/item/stack/tile/carpet/neon/simple/black/nodots
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/black,
		/obj/item/stack/tile/carpet/neon/simple/black/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/red
	name = "simple red neon carpet"
	singular_name = "simple red neon carpet tile"
	turf_type = /turf/open/floor/carpet/neon/simple/red
	merge_type = /obj/item/stack/tile/carpet/neon/simple/red
	neon_color = COLOR_RED
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/red,
		/obj/item/stack/tile/carpet/neon/simple/red/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/red/get_ru_names()
	return alist(
		NOMINATIVE = "красная неоновая ковровая плитка",
		GENITIVE = "красной неоновой ковровой плитки",
		DATIVE = "красной неоновой ковровой плитке",
		ACCUSATIVE = "красную неоновую ковровую плитку",
		INSTRUMENTAL = "красной неоновой ковровой плиткой",
		PREPOSITIONAL = "красной неоновой ковровой плитке",
	)

/obj/item/stack/tile/carpet/neon/simple/red/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_light_nodots"
	turf_type = /turf/open/floor/carpet/neon/simple/red/nodots
	merge_type = /obj/item/stack/tile/carpet/neon/simple/red/nodots
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/red,
		/obj/item/stack/tile/carpet/neon/simple/red/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/orange
	name = "simple orange neon carpet"
	singular_name = "simple orange neon carpet tile"
	turf_type = /turf/open/floor/carpet/neon/simple/orange
	merge_type = /obj/item/stack/tile/carpet/neon/simple/orange
	neon_color = COLOR_ORANGE
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/orange,
		/obj/item/stack/tile/carpet/neon/simple/orange/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/orange/get_ru_names()
	return alist(
		NOMINATIVE = "оранжевая неоновая ковровая плитка",
		GENITIVE = "оранжевой неоновой ковровой плитки",
		DATIVE = "оранжевой неоновой ковровой плитке",
		ACCUSATIVE = "оранжевую неоновую ковровую плитку",
		INSTRUMENTAL = "оранжевой неоновой ковровой плиткой",
		PREPOSITIONAL = "оранжевой неоновой ковровой плитке",
	)


/obj/item/stack/tile/carpet/neon/simple/orange/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_light_nodots"
	turf_type = /turf/open/floor/carpet/neon/simple/orange/nodots
	merge_type = /obj/item/stack/tile/carpet/neon/simple/orange/nodots
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/orange,
		/obj/item/stack/tile/carpet/neon/simple/orange/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/yellow
	name = "simple yellow neon carpet"
	singular_name = "simple yellow neon carpet tile"
	turf_type = /turf/open/floor/carpet/neon/simple/yellow
	merge_type = /obj/item/stack/tile/carpet/neon/simple/yellow
	neon_color = COLOR_YELLOW
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/yellow,
		/obj/item/stack/tile/carpet/neon/simple/yellow/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/yellow/get_ru_names()
	return alist(
		NOMINATIVE = "жёлтая неоновая ковровая плитка",
		GENITIVE = "жёлтой неоновой ковровой плитки",
		DATIVE = "жёлтой неоновой ковровой плитке",
		ACCUSATIVE = "жёлтую неоновую ковровую плитку",
		INSTRUMENTAL = "жёлтой неоновой ковровой плиткой",
		PREPOSITIONAL = "жёлтой неоновой ковровой плитке",
	)

/obj/item/stack/tile/carpet/neon/simple/yellow/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_light_nodots"
	turf_type = /turf/open/floor/carpet/neon/simple/yellow/nodots
	merge_type = /obj/item/stack/tile/carpet/neon/simple/yellow/nodots
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/yellow,
		/obj/item/stack/tile/carpet/neon/simple/yellow/nodots,
	)
/obj/item/stack/tile/carpet/neon/simple/lime
	name = "simple lime neon carpet"
	singular_name = "simple lime neon carpet tile"
	turf_type = /turf/open/floor/carpet/neon/simple/lime
	merge_type = /obj/item/stack/tile/carpet/neon/simple/lime
	neon_color = COLOR_LIME
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/lime,
		/obj/item/stack/tile/carpet/neon/simple/lime/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/lime/get_ru_names()
	return alist(
		NOMINATIVE = "лаймовая неоновая ковровая плитка",
		GENITIVE = "лаймовой неоновой ковровой плитки",
		DATIVE = "лаймовой неоновой ковровой плитке",
		ACCUSATIVE = "лаймовую неоновую ковровую плитку",
		INSTRUMENTAL = "лаймовой неоновой ковровой плиткой",
		PREPOSITIONAL = "лаймовой неоновой ковровой плитке",
	)

/obj/item/stack/tile/carpet/neon/simple/lime/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_light_nodots"
	turf_type = /turf/open/floor/carpet/neon/simple/lime/nodots
	merge_type = /obj/item/stack/tile/carpet/neon/simple/lime/nodots
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/lime,
		/obj/item/stack/tile/carpet/neon/simple/lime/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/green
	name = "simple green neon carpet"
	singular_name = "simple green neon carpet tile"
	turf_type = /turf/open/floor/carpet/neon/simple/green
	merge_type = /obj/item/stack/tile/carpet/neon/simple/green
	neon_color = COLOR_GREEN
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/green,
		/obj/item/stack/tile/carpet/neon/simple/green/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/green/get_ru_names()
	return alist(
		NOMINATIVE = "зелёная неоновая ковровая плитка",
		GENITIVE = "зелёной неоновой ковровой плитки",
		DATIVE = "зелёной неоновой ковровой плитке",
		ACCUSATIVE = "зелёную неоновую ковровую плитку",
		INSTRUMENTAL = "зелёной неоновой ковровой плиткой",
		PREPOSITIONAL = "зелёной неоновой ковровой плитке",
	)

/obj/item/stack/tile/carpet/neon/simple/green/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_light_nodots"
	turf_type = /turf/open/floor/carpet/neon/simple/green/nodots
	merge_type = /obj/item/stack/tile/carpet/neon/simple/green/nodots
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/green,
		/obj/item/stack/tile/carpet/neon/simple/green/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/teal
	name = "simple teal neon carpet"
	singular_name = "simple teal neon carpet tile"
	turf_type = /turf/open/floor/carpet/neon/simple/teal
	merge_type = /obj/item/stack/tile/carpet/neon/simple/teal
	neon_color = COLOR_TEAL
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/teal,
		/obj/item/stack/tile/carpet/neon/simple/teal/nodots,
	)


/obj/item/stack/tile/carpet/neon/simple/teal/get_ru_names()
	return alist(
		NOMINATIVE = "бирюзовая неоновая ковровая плитка",
		GENITIVE = "бирюзовой неоновой ковровой плитки",
		DATIVE = "бирюзовой неоновой ковровой плитке",
		ACCUSATIVE = "бирюзовую неоновую ковровую плитку",
		INSTRUMENTAL = "бирюзовой неоновой ковровой плиткой",
		PREPOSITIONAL = "бирюзовой неоновой ковровой плитке",
	)

/obj/item/stack/tile/carpet/neon/simple/teal/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_light_nodots"
	turf_type = /turf/open/floor/carpet/neon/simple/teal/nodots
	merge_type = /obj/item/stack/tile/carpet/neon/simple/teal/nodots
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/teal,
		/obj/item/stack/tile/carpet/neon/simple/teal/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/cyan
	name = "simple cyan neon carpet"
	singular_name = "simple cyan neon carpet tile"
	turf_type = /turf/open/floor/carpet/neon/simple/cyan
	merge_type = /obj/item/stack/tile/carpet/neon/simple/cyan
	neon_color = COLOR_CYAN
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/cyan,
		/obj/item/stack/tile/carpet/neon/simple/cyan/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/cyan/get_ru_names()
	return alist(
		NOMINATIVE = "голубая неоновая ковровая плитка",
		GENITIVE = "голубой неоновой ковровой плитки",
		DATIVE = "голубой неоновой ковровой плитке",
		ACCUSATIVE = "голубую неоновую ковровую плитку",
		INSTRUMENTAL = "голубой неоновой ковровой плиткой",
		PREPOSITIONAL = "голубой неоновой ковровой плитке",
	)

/obj/item/stack/tile/carpet/neon/simple/cyan/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_light_nodots"
	turf_type = /turf/open/floor/carpet/neon/simple/cyan/nodots
	merge_type = /obj/item/stack/tile/carpet/neon/simple/cyan/nodots
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/cyan,
		/obj/item/stack/tile/carpet/neon/simple/cyan/nodots,
	)


/obj/item/stack/tile/carpet/neon/simple/blue
	name = "simple blue neon carpet"
	singular_name = "simple blue neon carpet tile"
	turf_type = /turf/open/floor/carpet/neon/simple/blue
	merge_type = /obj/item/stack/tile/carpet/neon/simple/blue
	neon_color = COLOR_BLUE
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/blue,
		/obj/item/stack/tile/carpet/neon/simple/blue/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/blue/get_ru_names()
	return alist(
		NOMINATIVE = "синяя неоновая ковровая плитка",
		GENITIVE = "синей неоновой ковровой плитки",
		DATIVE = "синей неоновой ковровой плитке",
		ACCUSATIVE = "синюю неоновую ковровую плитку",
		INSTRUMENTAL = "синей неоновой ковровой плиткой",
		PREPOSITIONAL = "синей неоновой ковровой плитке",
	)

/obj/item/stack/tile/carpet/neon/simple/blue/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_light_nodots"
	turf_type = /turf/open/floor/carpet/neon/simple/blue/nodots
	merge_type = /obj/item/stack/tile/carpet/neon/simple/blue/nodots
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/blue,
		/obj/item/stack/tile/carpet/neon/simple/blue/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/purple
	name = "simple purple neon carpet"
	singular_name = "simple purple neon carpet tile"
	turf_type = /turf/open/floor/carpet/neon/simple/purple
	merge_type = /obj/item/stack/tile/carpet/neon/simple/purple
	neon_color = COLOR_PURPLE
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/purple,
		/obj/item/stack/tile/carpet/neon/simple/purple/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/purple/get_ru_names()
	return alist(
		NOMINATIVE = "пурпурная неоновая ковровая плитка",
		GENITIVE = "пурпурной неоновой ковровой плитки",
		DATIVE = "пурпурной неоновой ковровой плитке",
		ACCUSATIVE = "пурпурную неоновую ковровую плитку",
		INSTRUMENTAL = "пурпурной неоновой ковровой плиткой",
		PREPOSITIONAL = "пурпурной неоновой ковровой плитке",
	)

/obj/item/stack/tile/carpet/neon/simple/purple/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_light_nodots"
	turf_type = /turf/open/floor/carpet/neon/simple/purple/nodots
	merge_type = /obj/item/stack/tile/carpet/neon/simple/purple/nodots
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/purple,
		/obj/item/stack/tile/carpet/neon/simple/purple/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/violet
	name = "simple violet neon carpet"
	singular_name = "simple violet neon carpet tile"
	turf_type = /turf/open/floor/carpet/neon/simple/violet
	merge_type = /obj/item/stack/tile/carpet/neon/simple/violet
	neon_color = COLOR_VIOLET
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/violet,
		/obj/item/stack/tile/carpet/neon/simple/violet/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/violet/get_ru_names()
	return alist(
		NOMINATIVE = "фиолетовая неоновая ковровая плитка",
		GENITIVE = "фиолетовой неоновой ковровой плитки",
		DATIVE = "фиолетовой неоновой ковровой плитке",
		ACCUSATIVE = "фиолетовую неоновую ковровую плитку",
		INSTRUMENTAL = "фиолетовой неоновой ковровой плиткой",
		PREPOSITIONAL = "фиолетовой неоновой ковровой плитке",
	)

/obj/item/stack/tile/carpet/neon/simple/violet/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_light_nodots"
	turf_type = /turf/open/floor/carpet/neon/simple/violet/nodots
	merge_type = /obj/item/stack/tile/carpet/neon/simple/violet/nodots
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/violet,
		/obj/item/stack/tile/carpet/neon/simple/violet/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/pink
	name = "simple pink neon carpet"
	singular_name = "simple pink neon carpet tile"
	turf_type = /turf/open/floor/carpet/neon/simple/pink
	merge_type = /obj/item/stack/tile/carpet/neon/simple/pink
	neon_color = COLOR_LIGHT_PINK
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/pink,
		/obj/item/stack/tile/carpet/neon/simple/pink/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/pink/get_ru_names()
	return alist(
		NOMINATIVE = "розовая неоновая ковровая плитка",
		GENITIVE = "розовой неоновой ковровой плитки",
		DATIVE = "розовой неоновой ковровой плитке",
		ACCUSATIVE = "розовую неоновую ковровую плитку",
		INSTRUMENTAL = "розовой неоновой ковровой плиткой",
		PREPOSITIONAL = "розовой неоновой ковровой плитке",
	)


/obj/item/stack/tile/carpet/neon/simple/pink/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_light_nodots"
	turf_type = /turf/open/floor/carpet/neon/simple/pink/nodots
	merge_type = /obj/item/stack/tile/carpet/neon/simple/pink/nodots
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/pink,
		/obj/item/stack/tile/carpet/neon/simple/pink/nodots,
	)

/obj/item/stack/tile/carpet/neon/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/white/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/white/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/white/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/black/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/black/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/black/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/red/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/red/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/red/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/orange/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/orange/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/orange/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/yellow/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/yellow/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/yellow/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/lime/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/lime/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/lime/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/green/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/green/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/green/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/teal/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/teal/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/teal/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/cyan/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/cyan/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/cyan/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/blue/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/blue/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/blue/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/purple/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/purple/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/purple/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/violet/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/violet/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/violet/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/pink/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/pink/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/pink/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/nodots/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/white/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/white/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/white/nodots/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/black/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/black/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/black/nodots/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/red/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/red/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/red/nodots/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/orange/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/orange/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/orange/nodots/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/yellow/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/yellow/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/yellow/nodots/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/lime/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/lime/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/lime/nodots/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/green/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/green/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/green/nodots/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/teal/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/teal/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/teal/nodots/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/cyan/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/cyan/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/cyan/nodots/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/blue/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/blue/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/blue/nodots/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/purple/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/purple/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/purple/nodots/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/violet/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/violet/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/violet/nodots/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/pink/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/pink/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/pink/nodots/sixty
	amount = 60

/obj/item/stack/tile/fakespace
	name = "astral carpet"
	singular_name = "astral carpet tile"
	desc = "Кусок ковролина с убедительным звёздным узором."
	icon_state = "tile_space"
	inhand_icon_state = "tile-space"
	turf_type = /turf/open/floor/fakespace
	resistance_flags = FLAMMABLE
	merge_type = /obj/item/stack/tile/fakespace

/obj/item/stack/tile/fakespace/get_ru_names()
	return alist(
		NOMINATIVE = "звёздная ковровая плитка",
		GENITIVE = "звёздной ковровой плитки",
		DATIVE = "звёздной ковровой плитке",
		ACCUSATIVE = "звёздную ковровую плитку",
		INSTRUMENTAL = "звёздной ковровой плиткой",
		PREPOSITIONAL = "звёздной ковровой плитке",
	)


/obj/item/stack/tile/fakespace/loaded
	amount = 30

/obj/item/stack/tile/fakepit
	name = "fake pits"
	singular_name = "fake pit"
	desc = "Кусок ковролина с иллюзией принудительной перспективы. Вряд ли это кого-то обманет!"
	icon_state = "tile_pit"
	inhand_icon_state = "tile-basalt"
	turf_type = /turf/open/floor/fakepit
	resistance_flags = FLAMMABLE
	merge_type = /obj/item/stack/tile/fakepit

/obj/item/stack/tile/fakepit/get_ru_names()
	return alist(
		NOMINATIVE = "ковровая плитка с иллюзией ямы",
		GENITIVE = "ковровой плитки с иллюзией ямы",
		DATIVE = "ковровой плитке с иллюзией ямы",
		ACCUSATIVE = "ковровую плитку с иллюзией ямы",
		INSTRUMENTAL = "ковровой плиткой с иллюзией ямы",
		PREPOSITIONAL = "ковровой плитке с иллюзией ямы",
	)

/obj/item/stack/tile/fakepit/loaded
	amount = 30

/obj/item/stack/tile/fakeice
	name = "fake ice"
	singular_name = "fake ice tile"
	desc = "Кусок плитки с убедительным ледяным узором."
	icon_state = "tile_ice"
	inhand_icon_state = "tile-diamond"
	turf_type = /turf/open/floor/fakeice
	resistance_flags = FLAMMABLE
	merge_type = /obj/item/stack/tile/fakeice

/obj/item/stack/tile/fakeice/get_ru_names()
	return alist(
		NOMINATIVE = "плитка с имитацией льда",
		GENITIVE = "плитки с имитацией льда",
		DATIVE = "плитке с имитацией льда",
		ACCUSATIVE = "плитку с имитацией льда",
		INSTRUMENTAL = "плиткой с имитацией льда",
		PREPOSITIONAL = "плитке с имитацией льда",
	)

/obj/item/stack/tile/fakeice/loaded
	amount = 30

//High-traction
/obj/item/stack/tile/noslip
	name = "high-traction floor tile"
	singular_name = "high-traction floor tile"
	desc = "Напольная плитка с высоким сцеплением. На ощупь напоминает резину."
	icon_state = "tile_noslip"
	inhand_icon_state = "tile-noslip"
	turf_type = /turf/open/floor/noslip
	merge_type = /obj/item/stack/tile/noslip

/obj/item/stack/tile/noslip/get_ru_names()
	return alist(
		NOMINATIVE = "нескользящая плитка",
		GENITIVE = "нескользящей плитки",
		DATIVE = "нескользящей плитке",
		ACCUSATIVE = "нескользящую плитку",
		INSTRUMENTAL = "нескользящей плиткой",
		PREPOSITIONAL = "нескользящей плитке",
	)

/obj/item/stack/tile/noslip/thirty
	amount = 30

/obj/item/stack/tile/noslip/tram
	name = "high-traction platform tile"
	singular_name = "high-traction platform tile"
	desc = "Титано-алюминиевая индукционная пластина, питающая трамвай."
	icon_state = "tile_noslip"
	inhand_icon_state = "tile-noslip"
	turf_type = /turf/open/floor/noslip/tram
	merge_type = /obj/item/stack/tile/noslip/tram

/obj/item/stack/tile/tram
	name = "tram platform tiles"
	singular_name = "tram platform"
	desc = "Плитка, используемая для трамвайных платформ."
	icon_state = "darkiron_catwalk"
	inhand_icon_state = "tile-neon"
	turf_type = /turf/open/floor/tram
	merge_type = /obj/item/stack/tile/tram

/obj/item/stack/tile/tram/get_ru_names()
	return alist(
		NOMINATIVE = "плитка трамвайной платформы",
		GENITIVE = "плитки трамвайной платформы",
		DATIVE = "плитке трамвайной платформы",
		ACCUSATIVE = "плитку трамвайной платформы",
		INSTRUMENTAL = "плиткой трамвайной платформы",
		PREPOSITIONAL = "плитке трамвайной платформы",
	)

/obj/item/stack/tile/tram/plate
	name = "linear induction tram tiles"
	singular_name = "linear induction tram tile"
	desc = "Плитка с алюминиевой пластиной для движения трамвая."
	icon_state = "darkiron_plate"
	inhand_icon_state = "tile-neon"
	turf_type = /turf/open/floor/tram/plate
	merge_type = /obj/item/stack/tile/tram/plate

//Circuit
/obj/item/stack/tile/circuit
	name = "blue circuit tile"
	singular_name = "blue circuit tile"
	desc = "Синяя плитка в виде схемы."
	icon_state = "tile_bcircuit"
	inhand_icon_state = "tile-bcircuit"
	turf_type = /turf/open/floor/circuit
	merge_type = /obj/item/stack/tile/circuit
	tile_reskin_types = list(
		/obj/item/stack/tile/circuit,
		/obj/item/stack/tile/circuit/green,
		/obj/item/stack/tile/circuit/red,
	)
	mats_per_unit = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.05, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.05)

/obj/item/stack/tile/circuit/get_ru_names()
	return alist(
		NOMINATIVE = "плитка-микросхема",
		GENITIVE = "плитки-микросхемы",
		DATIVE = "плитке-микросхеме",
		ACCUSATIVE = "плитку-микросхему",
		INSTRUMENTAL = "плиткой-микросхемой",
		PREPOSITIONAL = "плитке-микросхеме",
	)

/obj/item/stack/tile/circuit/green
	name = "green circuit tile"
	singular_name = "green circuit tile"
	desc = "Зеленая плитка в виде схемы.."
	icon_state = "tile_gcircuit"
	inhand_icon_state = "tile-gcircuit"
	turf_type = /turf/open/floor/circuit/green
	merge_type = /obj/item/stack/tile/circuit/green

/obj/item/stack/tile/circuit/green/get_ru_names()
	return alist(
		NOMINATIVE = "зеленая плитка-микросхема",
		GENITIVE = "зеленой плитки-микросхемы",
		DATIVE = "зеленой плитке-микросхеме",
		ACCUSATIVE = "зеленую плитку-микросхему",
		INSTRUMENTAL = "зеленой плиткой-микросхемой",
		PREPOSITIONAL = "зеленой плитке-микросхеме",
	)

/obj/item/stack/tile/circuit/green/anim
	turf_type = /turf/open/floor/circuit/green/anim
	merge_type = /obj/item/stack/tile/circuit/green/anim

/obj/item/stack/tile/circuit/red
	name = "red circuit tile"
	singular_name = "red circuit tile"
	desc = "Красная плитка в виде схемы."
	icon_state = "tile_rcircuit"
	inhand_icon_state = "tile-rcircuit"
	turf_type = /turf/open/floor/circuit/red
	merge_type = /obj/item/stack/tile/circuit/red

/obj/item/stack/tile/circuit/red/get_ru_names()
	return alist(
		NOMINATIVE = "красная плитка-микросхема",
		GENITIVE = "красной плитки-микросхемы",
		DATIVE = "красной плитке-микросхеме",
		ACCUSATIVE = "красную плитку-микросхему",
		INSTRUMENTAL = "красной плиткой-микросхемой",
		PREPOSITIONAL = "красной плитке-микросхеме",
	)

/obj/item/stack/tile/circuit/red/anim
	turf_type = /turf/open/floor/circuit/red/anim
	merge_type = /obj/item/stack/tile/circuit/red/anim

//Pod floor
/obj/item/stack/tile/pod
	name = "pod floor tile"
	singular_name = "pod floor tile"
	desc = "Рифлёная напольная плитка."
	icon_state = "tile_pod"
	inhand_icon_state = "tile-pod"
	turf_type = /turf/open/floor/pod
	merge_type = /obj/item/stack/tile/pod
	tile_reskin_types = list(
		/obj/item/stack/tile/pod,
		/obj/item/stack/tile/pod/light,
		/obj/item/stack/tile/pod/dark,
		)

/obj/item/stack/tile/pod/get_ru_names()
	return alist(
		NOMINATIVE = "рифлёная плитка",
		GENITIVE = "рифлёной плитки",
		DATIVE = "рифлёной плитке",
		ACCUSATIVE = "рифлёную плитку",
		INSTRUMENTAL = "рифлёной плиткой",
		PREPOSITIONAL = "рифлёной плитке",
	)

/obj/item/stack/tile/pod/light
	name = "light pod floor tile"
	singular_name = "light pod floor tile"
	desc = "Светло окрашенная рифлёная напольная плитка."
	icon_state = "tile_podlight"
	turf_type = /turf/open/floor/pod/light
	merge_type = /obj/item/stack/tile/pod/light

/obj/item/stack/tile/pod/light/get_ru_names()
	return alist(
		NOMINATIVE = "светлая рифлёная плитка",
		GENITIVE = "светлой рифлёной плитки",
		DATIVE = "светлой рифлёной плитке",
		ACCUSATIVE = "светлую рифлёную плитку",
		INSTRUMENTAL = "светлой рифлёной плиткой",
		PREPOSITIONAL = "светлой рифлёной плитке",
	)

/obj/item/stack/tile/pod/dark
	name = "dark pod floor tile"
	singular_name = "dark pod floor tile"
	desc = "Тёмно окрашенная рифлёная напольная плитка."
	icon_state = "tile_poddark"
	turf_type = /turf/open/floor/pod/dark
	merge_type = /obj/item/stack/tile/pod/dark

/obj/item/stack/tile/pod/dark/get_ru_names()
	return alist(
		NOMINATIVE = "темная рифлёная плитка",
		GENITIVE = "темной рифлёной плитки",
		DATIVE = "темной рифлёной плитке",
		ACCUSATIVE = "темную рифлёную плитку",
		INSTRUMENTAL = "темной рифлёной плиткой",
		PREPOSITIONAL = "темной рифлёной плитке",
	)


/obj/item/stack/tile/plastic
	name = "plastic tile"
	singular_name = "plastic floor tile"
	desc = "Плитка дешёвого, хлипкого пластикового покрытия."
	icon_state = "tile_plastic"
	mats_per_unit = list(/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT / 2)
	turf_type = /turf/open/floor/plastic
	merge_type = /obj/item/stack/tile/plastic

/obj/item/stack/tile/plastic/get_ru_names()
	return alist(
		NOMINATIVE = "пластиковая плитка",
		GENITIVE = "пластиковой плитки",
		DATIVE = "пластиковой плитке",
		ACCUSATIVE = "пластиковую плитку",
		INSTRUMENTAL = "пластиковой плиткой",
		PREPOSITIONAL = "пластиковой плитке",
	)

/obj/item/stack/tile/material
	name = "floor tile"
	singular_name = "floor tile"
	desc = "Земля, по которой вы ходите."
	throwforce = 10
	icon_state = "material_tile"
	inhand_icon_state = "tile"
	turf_type = /turf/open/floor/material
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	merge_type = /obj/item/stack/tile/material

/obj/item/stack/tile/material/get_ru_names()
	return alist(
		NOMINATIVE = "напольная плитка",
		GENITIVE = "напольной плитки",
		DATIVE = "напольной плитке",
		ACCUSATIVE = "напольную плитку",
		INSTRUMENTAL = "напольной плиткой",
		PREPOSITIONAL = "напольной плитке",
	)

/obj/item/stack/tile/material/place_tile(turf/open/target_plating, mob/user)
	. = ..()
	var/turf/open/floor/material/floor = .
	floor?.set_custom_materials(mats_per_unit)

/obj/item/stack/tile/eighties
	name = "retro tile"
	singular_name = "retro floor tile"
	desc = "Стопка плитки, напоминающая об эпохе фанка. Используйте в руке, чтобы выбрать чёрный или красный узор."
	icon_state = "tile_eighties"
	turf_type = /turf/open/floor/eighties
	merge_type = /obj/item/stack/tile/eighties
	tile_reskin_types = list(
		/obj/item/stack/tile/eighties,
		/obj/item/stack/tile/eighties/red,
	)

/obj/item/stack/tile/eighties/get_ru_names()
	return alist(
		NOMINATIVE = "ретро-плитка",
		GENITIVE = "ретро-плитки",
		DATIVE = "ретро-плитке",
		ACCUSATIVE = "ретро-плитку",
		INSTRUMENTAL = "ретро-плиткой",
		PREPOSITIONAL = "ретро-плитке",
	)

/obj/item/stack/tile/eighties/loaded
	amount = 15

/obj/item/stack/tile/eighties/red
	name = "red retro tile"
	singular_name = "red retro floor tile"
	desc = "Стопка РАДИКАЛЬНО красной плитки! Используйте в руке, чтобы выбрать чёрный или красный узор!" //i am so sorry
	icon_state = "tile_eightiesred"
	turf_type = /turf/open/floor/eighties/red
	merge_type = /obj/item/stack/tile/eighties/red

/obj/item/stack/tile/bronze
	name = "bronze tile"
	singular_name = "bronze floor tile"
	desc = "Звонкая плитка из высококачественной бронзы. Технологии заводной сборки позволяют минимизировать звон."
	icon_state = "tile_brass"
	turf_type = /turf/open/floor/bronze
	mats_per_unit = list(/datum/material/bronze = HALF_SHEET_MATERIAL_AMOUNT / 2)
	merge_type = /obj/item/stack/tile/bronze
	tile_reskin_types = list(
		/obj/item/stack/tile/bronze,
		/obj/item/stack/tile/bronze/flat,
		/obj/item/stack/tile/bronze/filled,
	)

/obj/item/stack/tile/bronze/get_ru_names()
	return alist(
		NOMINATIVE = "бронзовая плитка",
		GENITIVE = "бронзовой плитки",
		DATIVE = "бронзовой плитке",
		ACCUSATIVE = "бронзовую плитку",
		INSTRUMENTAL = "бронзовой плиткой",
		PREPOSITIONAL = "бронзовой плитке",
	)

/obj/item/stack/tile/bronze/flat
	name = "flat bronze tile"
	singular_name = "flat bronze floor tile"
	icon_state = "tile_reebe"
	turf_type = /turf/open/floor/bronze/flat
	merge_type = /obj/item/stack/tile/bronze/flat

/obj/item/stack/tile/bronze/filled
	name = "filled bronze tile"
	singular_name = "filled bronze floor tile"
	icon_state = "tile_brass_filled"
	turf_type = /turf/open/floor/bronze/filled
	merge_type = /obj/item/stack/tile/bronze/filled

/obj/item/stack/tile/cult
	name = "engraved tile"
	singular_name = "engraved floor tile"
	desc = "Странная плитка из рунного металла. Кажется, паранормальными силами не обладает."
	icon_state = "tile_cult"
	turf_type = /turf/open/floor/cult
	mats_per_unit = list(/datum/material/runedmetal=SMALL_MATERIAL_AMOUNT*5)
	merge_type = /obj/item/stack/tile/cult

/obj/item/stack/tile/cult/get_ru_names()
	return alist(
		NOMINATIVE = "гравированная плитка",
		GENITIVE = "гравированной плитки",
		DATIVE = "гравированной плитке",
		ACCUSATIVE = "гравированную плитку",
		INSTRUMENTAL = "гравированной плиткой",
		PREPOSITIONAL = "гравированной плитке",
	)

/// Floor tiles used to test emissive turfs.
/obj/item/stack/tile/emissive_test
	name = "emissive test tile"
	singular_name = "emissive test floor tile"
	desc = "Светящаяся в темноте плитка для проверки излучающих тайлов."
	turf_type = /turf/open/floor/emissive_test
	merge_type = /obj/item/stack/tile/emissive_test

/obj/item/stack/tile/emissive_test/update_overlays()
	. = ..()
	. += emissive_appearance(icon, icon_state, src, alpha = alpha)

/obj/item/stack/tile/emissive_test/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	. += emissive_appearance(standing.icon, standing.icon_state, src, alpha = standing.alpha)

/obj/item/stack/tile/emissive_test/sixty
	amount = 60

/obj/item/stack/tile/emissive_test/white
	name = "white emissive test tile"
	singular_name = "white emissive test floor tile"
	turf_type = /turf/open/floor/emissive_test/white
	merge_type = /obj/item/stack/tile/emissive_test/white

/obj/item/stack/tile/emissive_test/white/sixty
	amount = 60

//Catwalk Tiles
/obj/item/stack/tile/catwalk_tile //This is our base type, sprited to look maintenance-styled
	name = "catwalk plating"
	singular_name = "catwalk plating tile"
	desc = "Покрытие, открывающее вид на коммуникации. Инженеры его обожают!"
	icon_state = "maint_catwalk"
	inhand_icon_state = "tile-catwalk"
	mats_per_unit = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 1.2)
	turf_type = /turf/open/floor/catwalk_floor
	merge_type = /obj/item/stack/tile/catwalk_tile //Just to be cleaner, these all stack with each other
	tile_reskin_types = list(
		/obj/item/stack/tile/catwalk_tile,
		/obj/item/stack/tile/catwalk_tile/iron,
		/obj/item/stack/tile/catwalk_tile/iron_white,
		/obj/item/stack/tile/catwalk_tile/iron_dark,
		/obj/item/stack/tile/catwalk_tile/titanium,
		/obj/item/stack/tile/catwalk_tile/iron_smooth //this is the original greenish one
	)

/obj/item/stack/tile/catwalk_tile/get_ru_names()
	return alist(
		NOMINATIVE = "плитка для мостика",
		GENITIVE = "плитки для мостика",
		DATIVE = "плитке для мостика",
		ACCUSATIVE = "плитку для мостика",
		INSTRUMENTAL = "плиткой для мостика",
		PREPOSITIONAL = "плитке для мостика",
	)
/obj/item/stack/tile/catwalk_tile/sixty
	amount = 60

/obj/item/stack/tile/catwalk_tile/iron
	name = "iron catwalk floor"
	singular_name = "iron catwalk floor tile"
	icon_state = "iron_catwalk"
	turf_type = /turf/open/floor/catwalk_floor/iron

/obj/item/stack/tile/catwalk_tile/iron_white
	name = "white catwalk floor"
	singular_name = "white catwalk floor tile"
	icon_state = "whiteiron_catwalk"
	turf_type = /turf/open/floor/catwalk_floor/iron_white

/obj/item/stack/tile/catwalk_tile/iron_dark
	name = "dark catwalk floor"
	singular_name = "dark catwalk floor tile"
	icon_state = "darkiron_catwalk"
	turf_type = /turf/open/floor/catwalk_floor/iron_dark

/obj/item/stack/tile/catwalk_tile/titanium
	name = "titanium catwalk floor"
	singular_name = "titanium catwalk floor tile"
	icon_state = "titanium_catwalk"
	turf_type = /turf/open/floor/catwalk_floor/titanium

/obj/item/stack/tile/catwalk_tile/iron_smooth //this is the greenish one
	name = "smooth iron catwalk floor"
	singular_name = "smooth iron catwalk floor tile"
	icon_state = "smoothiron_catwalk"
	turf_type = /turf/open/floor/catwalk_floor/iron_smooth

// Glass floors
/obj/item/stack/tile/glass
	name = "glass floor"
	singular_name = "glass floor tile"
	desc = "Стеклянный пол, позволяющий видеть... Что бы там внизу ни было."
	icon_state = "tile_glass"
	turf_type = /turf/open/floor/glass
	inhand_icon_state = "tile-glass"
	merge_type = /obj/item/stack/tile/glass
	mats_per_unit = list(/datum/material/glass=SHEET_MATERIAL_AMOUNT * 0.25) // 4 tiles per sheet

/obj/item/stack/tile/glass/get_ru_names()
	return alist(
		NOMINATIVE = "стеклянная плитка",
		GENITIVE = "стеклянной плитки",
		DATIVE = "стеклянной плитке",
		ACCUSATIVE = "стеклянную плитку",
		INSTRUMENTAL = "стеклянной плиткой",
		PREPOSITIONAL = "стеклянной плитке",
	)
/obj/item/stack/tile/glass/sixty
	amount = 60

/obj/item/stack/tile/rglass
	name = "reinforced glass floor"
	singular_name = "reinforced glass floor tile"
	desc = "Укреплённый стеклянный пол. Эти красавцы на 50% прочнее своих предшественников!"
	icon_state = "tile_rglass"
	inhand_icon_state = "tile-rglass"
	turf_type = /turf/open/floor/glass/reinforced
	merge_type = /obj/item/stack/tile/rglass
	mats_per_unit = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.125, /datum/material/glass=SHEET_MATERIAL_AMOUNT * 0.25) // 4 tiles per sheet

/obj/item/stack/tile/rglass/get_ru_names()
	return alist(
		NOMINATIVE = "укреплённая стеклянная плитка",
		GENITIVE = "укреплённой стеклянной плитки",
		DATIVE = "укреплённой стеклянной плитке",
		ACCUSATIVE = "укреплённую стеклянную плитку",
		INSTRUMENTAL = "укреплённой стеклянной плиткой",
		PREPOSITIONAL = "укреплённой стеклянной плитке",
	)

/obj/item/stack/tile/rglass/sixty
	amount = 60

/obj/item/stack/tile/glass/plasma
	name = "plasma glass floor"
	singular_name = "plasma glass floor tile"
	desc = "Плазменная стеклянная плитка для случаев, когда... то, что внизу, слишком страшно для обычного стекла."
	icon_state = "tile_pglass"
	turf_type = /turf/open/floor/glass/plasma
	merge_type = /obj/item/stack/tile/glass/plasma
	mats_per_unit = list(/datum/material/alloy/plasmaglass = SHEET_MATERIAL_AMOUNT * 0.25)

/obj/item/stack/tile/glass/plasma/get_ru_names()
	return alist(
		NOMINATIVE = "плазменная стеклянная плитка",
		GENITIVE = "плазменной стеклянной плитки",
		DATIVE = "плазменной стеклянной плитке",
		ACCUSATIVE = "плазменную стеклянную плитку",
		INSTRUMENTAL = "плазменной стеклянной плиткой",
		PREPOSITIONAL = "плазменной стеклянной плитке",
	)

/obj/item/stack/tile/rglass/plasma
	name = "reinforced plasma glass floor"
	singular_name = "reinforced plasma glass floor tile"
	desc = "Укреплённая плазменная стеклянная плитка. Потому что тому, что внизу, лучше оставаться внизу."
	icon_state = "tile_rpglass"
	turf_type = /turf/open/floor/glass/reinforced/plasma
	merge_type = /obj/item/stack/tile/rglass/plasma
	mats_per_unit = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.125, /datum/material/alloy/plasmaglass = SHEET_MATERIAL_AMOUNT * 0.25)

/obj/item/stack/tile/rglass/plasma/get_ru_names()
	return alist(
		NOMINATIVE = "укреплённая плазменная плитка",
		GENITIVE = "укреплённой плазменной плитки",
		DATIVE = "укреплённой плазменной плитке",
		ACCUSATIVE = "укреплённую плазменную плитку",
		INSTRUMENTAL = "укреплённой плазменной плиткой",
		PREPOSITIONAL = "укреплённой плазменной плитке",
	)
