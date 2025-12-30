/**
 * ## Категория окрашиваемых декалей
 *
 * Хранит набор информации, которую использует покрасчик декалей, чтобы определить,
 * что он может красить, что нет, и как это делать.
 */
/datum/paintable_decal_category
	/// Читаемое имя категории
	var/category = "Общие"
	/// Тип окрашиваемой декали, которую содержит эта категория - должен быть подтипом /datum/paintable_decal
	var/paintable_decal_type
	/// Варианты цветов для этой категории - в формате читаемая метка - значение цвета
	var/list/possible_colors
	/// Варианты направлений для этой категории - в формате читаемая метка - значение dir для возврата
	var/list/dir_list = list(
		"Север" = NORTH,
		"Юг" = SOUTH,
		"Восток" = EAST,
		"Запад" = WEST,
	)
	/// Альфа-канал для декалей, окрашенных из этой категории (при условии, что не используется пользовательский цвет)
	var/default_alpha = 255

	/// Иконка, используемая для предварительного просмотра
	var/preview_floor_icon = 'icons/turf/floors.dmi'
	/// Состояние иконки, используемое для предварительного просмотра
	var/preview_floor_state = "floor"

	/// Кэширует данные интерфейса, чтобы избежать их регенерации каждый раз. Они всё равно не меняются
	VAR_PRIVATE/list/cached_category_data

/// Возвращает ключ для иконки спрайтшита, используется для избежания дубликатов
/datum/paintable_decal_category/proc/spritesheet_key(dir, state, color)
	SHOULD_NOT_OVERRIDE(TRUE)
	PRIVATE_PROC(TRUE)

	return "[state]_[dir]_[replacetext(color, "#", "")]"

/// Возвращает список иконок предварительного просмотра для каждой разновидности каждой декали в этой категории для использования в спрайтшите
/datum/paintable_decal_category/proc/generate_all_spritesheet_icons()
	SHOULD_NOT_OVERRIDE(TRUE)

	. = list()
	for(var/datum/paintable_decal/decal_type as anything in subtypesof(paintable_decal_type))
		var/state = decal_type::icon_state
		if(!state)
			continue
		if(decal_type::directional)
			for(var/dirname in dir_list)
				. += generate_independent_decal_spritesheet_icons(dir_list[dirname], state)
		else
			. += generate_independent_decal_spritesheet_icons(SOUTH, state)

/// Возвращает список иконок предварительного просмотра для конкретного состояния и направления декали
/datum/paintable_decal_category/proc/generate_independent_decal_spritesheet_icons(dir, state)
	SHOULD_NOT_OVERRIDE(TRUE)
	PRIVATE_PROC(TRUE)

	. = list()
	for(var/colorname in possible_colors)
		.[spritesheet_key(dir, state, possible_colors[colorname])] = generate_colored_decal_spritesheet_icon(state, dir, possible_colors[colorname])

/// Фактически генерирует иконку предварительного просмотра для конкретного состояния, направления и цвета декали
/datum/paintable_decal_category/proc/generate_colored_decal_spritesheet_icon(state, dir, color)
	PROTECTED_PROC(TRUE)

	var/list/decal_data = get_decal_info(state, color, dir)
	var/datum/universal_icon/colored_decal = uni_icon('icons/turf/decals.dmi', decal_data[DECAL_INFO_ICON_STATE], dir = decal_data[DECAL_INFO_DIR])
	colored_decal.change_opacity(decal_data[DECAL_INFO_ALPHA] / 255)
	if(color == "custom")
		// Делаем весёлую радужную раскраску, чтобы выделиться, оставаясь статичным.
		colored_decal.blend_icon(uni_icon('icons/effects/random_spawners.dmi', "rainbow"), ICON_MULTIPLY)
	else if(decal_data[DECAL_INFO_COLOR])
		colored_decal.blend_color(decal_data[DECAL_INFO_COLOR], ICON_MULTIPLY)

	var/datum/universal_icon/floor = uni_icon(preview_floor_icon, preview_floor_state)
	floor.blend_icon(colored_decal, ICON_OVERLAY)
	return floor

/// Создаёт и возвращает данные интерфейса этой категории
/datum/paintable_decal_category/proc/get_ui_data() as /list
	SHOULD_NOT_OVERRIDE(TRUE)

	if(cached_category_data)
		return cached_category_data.Copy()

	cached_category_data = list()

	cached_category_data["decal_list"] = list()
	cached_category_data["color_list"] = list()
	cached_category_data["dir_list"] = list()

	for(var/datum/paintable_decal/decal_type as anything in subtypesof(paintable_decal_type))
		var/name = decal_type::name
		var/state = decal_type::icon_state
		if(!name || !state)
			continue

		cached_category_data["decal_list"] += list(list(
			"name" = name,
			"icon_state" = state,
			"directional" = decal_type::directional,
		))

	for(var/color in possible_colors)
		cached_category_data["color_list"] += list(list(
			"name" = color,
			"color" = possible_colors[color],
		))

	for(var/dirname in dir_list)
		cached_category_data["dir_list"] += list(list(
			"name" = dirname,
			"dir" = dir_list[dirname],
		))

	return cached_category_data.Copy()

/// Проверяет, является ли переданное состояние иконки одной из декалей этой категории
/datum/paintable_decal_category/proc/is_state_valid(state)
	SHOULD_NOT_OVERRIDE(TRUE)
	// В данных UI есть все состояния иконок, так что просто используем их
	for(var/list/decal_data as anything in get_ui_data()["decal_list"])
		if(decal_data["icon_state"] == state)
			return TRUE
	return FALSE

/// Проверяет, является ли переданное направление одним из направлений этой категории
/datum/paintable_decal_category/proc/is_dir_valid(dir)
	SHOULD_NOT_OVERRIDE(TRUE)
	for(var/dirname in dir_list)
		if(dir_list[dirname] == dir)
			return TRUE
	return FALSE

/// Проверяет, является ли переданный цвет одним из цветов этой категории
/datum/paintable_decal_category/proc/is_color_valid(color)
	SHOULD_NOT_OVERRIDE(TRUE)
	for(var/colorname in possible_colors)
		if(possible_colors[colorname] == color)
			return TRUE
	return FALSE

/**
 * Используется покрасчиком декалей для изменения состояния декали в зависимости от... состояния.
 */
/datum/paintable_decal_category/proc/get_decal_info(state, color, dir)
	// Особый случай для спрайтов с 8 направлениями. Вместо того чтобы добавлять поддержку и 4, и 8 направлений,
	// 8-направленные помечаются "__8" в конце имени состояния иконки. Затем мы обрабатываем это здесь.
	if(copytext(state, -3) == "__8")
		state = splicetext(state, -3, 0, "")
		dir = turn(dir, 45)

	var/static/regex/rgba_regex = new(@"(#[0-9a-fA-F]{6})([0-9a-fA-F]{2})")
	var/alpha = default_alpha
	// Особый случай для цветов RGBA
	if(rgba_regex.Find(color))
		color = rgba_regex.group[1]
		alpha = text2num(rgba_regex.group[2], 16)

	return list(
		"[DECAL_INFO_ICON_STATE]" = state,
		"[DECAL_INFO_DIR]" = dir,
		"[DECAL_INFO_COLOR]" = color,
		"[DECAL_INFO_ALPHA]" = alpha,
	)

// Базовые декали плитки
/datum/paintable_decal_category/tile
	paintable_decal_type = /datum/paintable_decal/tile
	category = "Плитка"
	default_alpha = /obj/effect/turf_decal/tile::alpha
	possible_colors = list(
		"Нейтральный" = "#d4d4d432", // очень ленивый способ сделать прозрачную декаль, в будущем нужно переделать
		"Белый" = "#FFFFFF",
		"Тёмный" = /obj/effect/turf_decal/tile/dark::color,
		"Барный бордовый" = /obj/effect/turf_decal/tile/bar::color,
		"Карго коричневый" = /obj/effect/turf_decal/tile/brown::color,
		"Тёмно-синий" = /obj/effect/turf_decal/tile/dark_blue::color,
		"Тёмно-зелёный" = /obj/effect/turf_decal/tile/dark_green::color,
		"Тёмно-красный" = /obj/effect/turf_decal/tile/dark_red::color,
		"Инженерный жёлтый" = /obj/effect/turf_decal/tile/yellow::color,
		"Медицинский синий" = /obj/effect/turf_decal/tile/blue::color,
		"РнД фиолетовый" = /obj/effect/turf_decal/tile/purple::color,
		"СБ красный" = /obj/effect/turf_decal/tile/red::color,
		"Сервисный зелёный" = /obj/effect/turf_decal/tile/green::color,
		"Свой" = "custom",
	)

// Тримлайны плитки
/datum/paintable_decal_category/tile/trimline
	category = "Тримлайны"
	paintable_decal_type = /datum/paintable_decal/trimline

// Общие предупреждающие полосы
/datum/paintable_decal_category/warning
	paintable_decal_type = /datum/paintable_decal/warning
	category = "Предупреждающие полосы"
	possible_colors = list(
		"Жёлтый" = "yellow",
		"Красный" = "red",
		"Белый" = "white",
	)

/datum/paintable_decal_category/warning/generate_colored_decal_spritesheet_icon(state, dir, color)
	var/list/decal_data = get_decal_info(state, color, dir)
	var/datum/universal_icon/floor = uni_icon(preview_floor_icon, preview_floor_state)
	var/datum/universal_icon/decal = uni_icon('icons/turf/decals.dmi', decal_data[DECAL_INFO_ICON_STATE], dir = decal_data[DECAL_INFO_DIR])
	floor.blend_icon(decal, ICON_OVERLAY)
	return floor

/datum/paintable_decal_category/warning/get_decal_info(state, color, dir)
	// Особый случай. По умолчанию предупреждающие полосы желтые, поэтому ничего не добавляем, если передан желтый
	if(color == "yellow")
		color = ""

	return list(
		"[DECAL_INFO_ICON_STATE]" = "[state][color ? "_" : ""][color]",
		"[DECAL_INFO_DIR]" = dir,
		"[DECAL_INFO_COLOR]" = color,
		"[DECAL_INFO_ALPHA]" = default_alpha,
	)

// Простой цветной плинтус
/datum/paintable_decal_category/siding
	paintable_decal_type = /datum/paintable_decal/colored_siding
	category = "Цветной плинтус"
	possible_colors = list(
		"Тускло-белый" = /obj/effect/turf_decal/siding/white::color,
		"Белый" = "#FFFFFF",
		"Чёрный" = /obj/effect/turf_decal/siding/dark::color,
		"Карго коричневый" = /obj/effect/turf_decal/siding/brown::color,
		"Тёмно-синий" = /obj/effect/turf_decal/siding/dark_blue::color,
		"Тёмно-зелёный" = /obj/effect/turf_decal/siding/dark_green::color,
		"Тёмно-красный" = /obj/effect/turf_decal/siding/dark_red::color,
		"Инженерный жёлтый" = /obj/effect/turf_decal/siding/yellow::color,
		"Медицинский синий" = /obj/effect/turf_decal/siding/blue::color,
		"РнД фиолетовый" = /obj/effect/turf_decal/siding/purple::color,
		"СБ красный" = /obj/effect/turf_decal/siding/red::color,
		"Сервисный зелёный" = /obj/effect/turf_decal/siding/green::color,
		"Свой" = "custom",
	)

// Плинтусы, которые не окрашены / имеют определенный узор, текстуру и т.д.
/datum/paintable_decal_category/normal_siding
	paintable_decal_type = /datum/paintable_decal/siding
	category = "Обычный плинтус"
	possible_colors = list(
		"Стандартный" = /obj/effect/turf_decal/siding/wood::color,
	)

// Плинтусы покрытия и все цветовые вариации
/datum/paintable_decal_category/plating
	paintable_decal_type = /datum/paintable_decal/plating
	category = "Плинтус покрытия"
	possible_colors = list(
		"Стандартный" = "#949494",
		"Белый" = "#FFFFFF",
		"Терракотовый" = "#b84221",
		"Тёмный" = "#36373a",
		"Светлый" = "#e2e2e2",
	)

/// Глобальный список всех синглтонов категорий окрашиваемых декалей
GLOBAL_LIST_INIT(paintable_decals, init_subtypes(/datum/paintable_decal_category))

// Спрайтшит, используемый покрасчиком декалей
/datum/asset/spritesheet_batched/decals
	name = "paintable_decals"
	ignore_dir_errors = TRUE

/datum/asset/spritesheet_batched/decals/create_spritesheets()
	for(var/datum/paintable_decal_category/category as anything in GLOB.paintable_decals)
		var/list/generated_icons = category.generate_all_spritesheet_icons()
		for(var/sprite_key in generated_icons)
			insert_icon(sprite_key, generated_icons[sprite_key])

/**
 * ## Окрашиваемая декаль
 *
 * В основном просто хранит кучу информации, относящейся к каждой декали, для использования покрасчиком декалей.
 */
/datum/paintable_decal
	/// Читаемое имя декали
	var/name
	/// Состояние иконки декали в decals.dmi
	var/icon_state
	/// Если TRUE, спрайт декали меняется в зависимости от его направления (dir)
	var/directional = TRUE

// Базовые декали плитки
/datum/paintable_decal/tile

/datum/paintable_decal/tile/four_corners
	name = "4 угла"
	icon_state = "tile_fourcorners"
	directional = FALSE

/datum/paintable_decal/tile/full
	name = "Полная плитка"
	icon_state = "tile_full"
	directional = FALSE

/datum/paintable_decal/tile/corner
	name = "Угол"
	icon_state = "tile_corner"

/datum/paintable_decal/tile/half
	name = "Половина"
	icon_state = "tile_half_contrasted"

/datum/paintable_decal/tile/half_full
	name = "Полная половина"
	icon_state = "tile_half"

/datum/paintable_decal/tile/opposing_corners
	name = "Противоположные углы"
	icon_state = "tile_opposing_corners"

/datum/paintable_decal/tile/anticorner
	name = "3 угла"
	icon_state = "tile_anticorner_contrasted"

/datum/paintable_decal/tile/tram
	name = "Трамвай"
	icon_state = "tile_tram"

/datum/paintable_decal/tile/diagonal_centre
	name = "Диагональ (центр)"
	icon_state = "diagonal_centre"
	directional = FALSE

/datum/paintable_decal/tile/diagonal_edge
	name = "Диагональ (край)"
	icon_state = "diagonal_edge"
	directional = FALSE

// Тримлайны плитки
/datum/paintable_decal/trimline

/datum/paintable_decal/trimline/filled_box
	name = "Тримлайн (сплошной квадрат)"
	icon_state = "trimline_box_fill"
	directional = FALSE

/datum/paintable_decal/trimline/filled_corner
	name = "Тримлайн (сплошной угол)"
	icon_state = "trimline_corner_fill"

/datum/paintable_decal/trimline/filled
	name = "Тримлайн (сплошной)"
	icon_state = "trimline_fill"

/datum/paintable_decal/trimline/filled_l
	name = "Тримлайн (сплошной L)"
	icon_state = "trimline_fill__8" // спрайт с 8 направлениями

/datum/paintable_decal/trimline/filled_end
	name = "Тримлайн (сплошной конец)"
	icon_state = "trimline_end_fill"

/datum/paintable_decal/trimline/box
	name = "Тримлайн (квадрат)"
	icon_state = "trimline_box"
	directional = FALSE

/datum/paintable_decal/trimline/corner
	name = "Тримлайн (угол)"
	icon_state = "trimline_corner"

/datum/paintable_decal/trimline/circle
	name = "Тримлайн (круг)"
	icon_state = "trimline"

/datum/paintable_decal/trimline/l
	name = "Тримлайн (L)"
	icon_state = "trimline__8" // спрайт с 8 направлениями

/datum/paintable_decal/trimline/end
	name = "Тримлайн (конец)"
	icon_state = "trimline_end"

/datum/paintable_decal/trimline/connector_l
	name = "Тримлайн (соединитель Л)"
	icon_state = "trimline_shrink_cw"

/datum/paintable_decal/trimline/connector_r
	name = "Тримлайн (соединитель П)"
	icon_state = "trimline_shrink_ccw"

/datum/paintable_decal/trimline/arrow_l_filled
	name = "Тримлайн стрелка Л (сплошная)"
	icon_state = "trimline_arrow_cw_fill"

/datum/paintable_decal/trimline/arrow_r_filled
	name = "Тримлайн стрелка П (сплошная)"
	icon_state = "trimline_arrow_ccw_fill"

/datum/paintable_decal/trimline/warn_filled
	name = "Тримлайн внимание (сплошной)"
	icon_state = "trimline_warn_fill"

/datum/paintable_decal/trimline/warn_filled_l
	name = "Тримлайн внимание L (сплошной)"
	icon_state = "trimline_warn_fill__8" // спрайт с 8 направлениями

/datum/paintable_decal/trimline/warn_filled_corner
	name = "Тримлайн внимание угол (сплошной)"
	icon_state = "trimline_corner_warn_fill"

/datum/paintable_decal/trimline/warn
	name = "Тримлайн внимание"
	icon_state = "trimline_warn"

/datum/paintable_decal/trimline/warn_l
	name = "Тримлайн внимание L"
	icon_state = "trimline_warn__8" // спрайт с 8 направлениями

/datum/paintable_decal/trimline/arrow_l
	name = "Тримлайн стрелка Л"
	icon_state = "trimline_arrow_cw"

/datum/paintable_decal/trimline/arrow_r
	name = "Тримлайн стрелка П"
	icon_state = "trimline_arrow_ccw"

/datum/paintable_decal/trimline/mid_joiner
	name = "Тримлайн (средний соединитель)"
	icon_state = "trimline_mid"

/datum/paintable_decal/trimline/mid_joiner_filled
	name = "Тримлайн (средний соединитель сплошной)"
	icon_state = "trimline_mid_fill"

/datum/paintable_decal/trimline/tram
	name = "Тримлайн (трамвай)"
	icon_state = "trimline_tram"

// Общие предупреждающие декали каждого цвета
/datum/paintable_decal/warning

/datum/paintable_decal/warning/line
	name = "Предупреждающая линия"
	icon_state = "warningline"

/datum/paintable_decal/warning/line_corner
	name = "Предупреждающая линия (угол)"
	icon_state = "warninglinecorner"

/datum/paintable_decal/warning/caution
	name = "Надпись Caution"
	icon_state = "caution"

/datum/paintable_decal/warning/arrows
	name = "Направляющие стрелки"
	icon_state = "arrows"

/datum/paintable_decal/warning/stand_clear
	name = "Надпись Stand Clear"
	icon_state = "stand_clear"

/datum/paintable_decal/warning/bot
	name = "Бот"
	icon_state = "bot"
	directional = FALSE

/datum/paintable_decal/warning/loading
	name = "Зона погрузки"
	icon_state = "loadingarea"

/datum/paintable_decal/warning/box
	name = "Квадрат"
	icon_state = "box"
	directional = FALSE

/datum/paintable_decal/warning/box_corners
	name = "Угол квадрата"
	icon_state = "box_corners"

/datum/paintable_decal/warning/delivery
	name = "Маркер доставки"
	icon_state = "delivery"
	directional = FALSE

/datum/paintable_decal/warning/warn_full
	name = "Предупреждающий квадрат"
	icon_state = "warn_full"
	directional = FALSE

// Простой цветной плинтус
/datum/paintable_decal/colored_siding

/datum/paintable_decal/colored_siding/line
	name = "Плинтус"
	icon_state = "siding_plain"

/datum/paintable_decal/colored_siding/line_corner
	name = "Плинтус (угол)"
	icon_state = "siding_plain_corner"

/datum/paintable_decal/colored_siding/line_end
	name = "Плинтус (конец)"
	icon_state = "siding_plain_end"

/datum/paintable_decal/colored_siding/line_inner_corner
	name = "Плинтус (внутренний угол)"
	icon_state = "siding_plain_corner_inner"

// Плинтусы, которые не окрашены / имеют определенный узор, текстуру и т.д.
/datum/paintable_decal/siding

/datum/paintable_decal/siding/wood

/datum/paintable_decal/siding/wood/line
	name = "Деревянный плинтус"
	icon_state = "siding_wood"

/datum/paintable_decal/siding/wood/line_corner
	name = "Деревянный плинтус (угол)"
	icon_state = "siding_wood_corner"

/datum/paintable_decal/siding/wood/line_end
	name = "Деревянный плинтус (конец)"
	icon_state = "siding_wood_end"

/datum/paintable_decal/siding/wood/line_inner_corner
	name = "Деревянный плинтус (внутренний угол)"
	icon_state = "siding_wood__8" // спрайт с 8 направлениями

// Тонкие плинтусы покрытия и все цветовые вариации
/datum/paintable_decal/plating/thinplating

/datum/paintable_decal/plating/thinplating/line
	name = "Тонкий плинтус покрытия"
	icon_state = "siding_thinplating"

/datum/paintable_decal/plating/thinplating/line_corner
	name = "Тонкий плинтус покрытия (угол)"
	icon_state = "siding_thinplating_corner"

/datum/paintable_decal/plating/thinplating/line_end
	name = "Тонкий плинтус покрытия (конец)"
	icon_state = "siding_thinplating_end"

/datum/paintable_decal/plating/thinplating/line_inner_corner
	name = "Тонкий плинтус покрытия (внутренний угол)"
	icon_state = "siding_thinplating__8" // спрайт с 8 направлениями

// Альтернативные / новые тонкие плинтусы покрытия и все цветовые вариации
/datum/paintable_decal/plating/thinplatingalt

/datum/paintable_decal/plating/thinplatingalt/line
	name = "Тонкий плинтус покрытия (альт)"
	icon_state = "siding_thinplating_new"

/datum/paintable_decal/plating/thinplatingalt/line_corner
	name = "Тонкий плинтус покрытия угол (альт)"
	icon_state = "siding_thinplating_new_corner"

/datum/paintable_decal/plating/thinplatingalt/line_end
	name = "Тонкий плинтус покрытия конец (альт)"
	icon_state = "siding_thinplating_new_end"

/datum/paintable_decal/plating/thinplatingalt/line_inner_corner
	name = "Тонкий плинтус покрытия внутренний угол (альт)"
	icon_state = "siding_thinplating_new__8" // спрайт с 8 направлениями

// Широкие плинтусы покрытия и все цветовые вариации
/datum/paintable_decal/plating/wideplating

/datum/paintable_decal/plating/wideplating/line
	name = "Широкий плинтус покрытия"
	icon_state = "siding_wideplating"

/datum/paintable_decal/plating/wideplating/line_corner
	name = "Широкий плинтус покрытия (угол)"
	icon_state = "siding_wideplating_corner"

/datum/paintable_decal/plating/wideplating/line_end
	name = "Широкий плинтус покрытия (конец)"
	icon_state = "siding_wideplating_end"

/datum/paintable_decal/plating/wideplating/line_inner_corner
	name = "Широкий плинтус покрытия (внутренний угол)"
	icon_state = "siding_wideplating__8"  // спрайт с 8 направлениями

// Альтернативные / новые широкие плинтусы покрытия и все цветовые вариации
/datum/paintable_decal/plating/wideplatingalt

/datum/paintable_decal/plating/wideplatingalt/line
	name = "Широкий плинтус покрытия (альт)"
	icon_state = "siding_wideplating_new"

/datum/paintable_decal/plating/wideplatingalt/line_corner
	name = "Широкий плинтус покрытия угол (альт)"
	icon_state = "siding_wideplating_new_corner"

/datum/paintable_decal/plating/wideplatingalt/line_end
	name = "Широкий плинтус покрытия конец (альт)"
	icon_state = "siding_wideplating_new_end"

/datum/paintable_decal/plating/wideplatingalt/line_inner_corner
	name = "Широкий плинтус покрытия внутренний угол (альт)"
	icon_state = "siding_wideplating_new__8" // спрайт с 8 направлениями
