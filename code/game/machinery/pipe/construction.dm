/*СОДЕРЖИМОЕ
Собираемые трубы
Собираемые измерители
*/

// Определения для строительства находятся в __defines/pipe_construction.dm
// Обновляйте эти определения ЛЮБОЙ РАЗ, когда меняется атмосферный путь...
// ...иначе строительство перестанет работать

/obj/item/pipe
	name = "pipe"
	desc = "Труба."
	var/pipe_type
	var/pipename
	force = 7
	throwforce = 7
	icon = 'icons/obj/pipes_n_cables/pipe_item.dmi'
	icon_state = "simple"
	icon_state_preview = "manifold4w"
	inhand_icon_state = "buildpipe"
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT)
	/// Слой трубопровода, на котором мы будем находиться
	var/piping_layer = PIPING_LAYER_DEFAULT
	/// Тип создаваемого трубообъекта, выбранный из РПД
	var/RPD_type
	/// Можно ли покрасить
	var/paintable = FALSE
	/// Цвет трубы, который будет создан из этого трубообъекта
	var/pipe_color
	/// Начальное направление созданной трубы (либо созданной из РПД, либо после откручивания трубы)
	var/p_init_dir = SOUTH

/obj/item/pipe/on_craft_completion(list/components, datum/crafting_recipe/current_recipe, atom/crafter)
	. = ..()
	if(!istype(current_cipe, /datum/crafting_recipe/spec_pipe))
		return
	var/datum/crafting_recipe/spec_pipe/pipe_recipe = current_recipe
	pipe_type = pipe_recipe.pipe_type
	pipe_color = ATMOS_COLOR_OMNI
	setDir(crafter.dir)
	update()

/obj/item/pipe/directional
	RPD_type = PIPE_UNARY

/obj/item/pipe/directional/he_junction
	icon_state_preview = "junction"
	pipe_type = /obj/machinery/atmospherics/pipe/heat_exchanging/junction
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/pipe/directional/vent
	name = "air vent fitting"
	icon_state_preview = "uvent"
	pipe_type = /obj/machinery/atmospherics/components/unary/vent_pump
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6 + SMALL_MATERIAL_AMOUNT / 2, /datum/material/glass = SMALL_MATERIAL_AMOUNT / 2)

/obj/item/pipe/directional/scrubber
	name = "air scrubber fitting"
	icon_state_preview = "scrubber"
	pipe_type = /obj/machinery/atmospherics/components/unary/vent_scrubber
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6 + SMALL_MATERIAL_AMOUNT / 2, /datum/material/glass = SMALL_MATERIAL_AMOUNT / 2)

/obj/item/pipe/directional/connector
	icon_state_preview = "connector"
	pipe_type = /obj/machinery/atmospherics/components/unary/portables_connector
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/pipe/directional/passive_vent
	icon_state_preview = "pvent"
	pipe_type = /obj/machinery/atmospherics/components/unary/passive_vent
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/pipe/directional/injector
	icon_state_preview = "injector"
	pipe_type = /obj/machinery/atmospherics/components/unary/outlet_injector
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2, /datum/material/glass = SMALL_MATERIAL_AMOUNT / 2)

/obj/item/pipe/directional/he_exchanger
	icon_state_preview = "heunary"
	pipe_type = /obj/machinery/atmospherics/components/unary/heat_exchanger
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT, /datum/material/alloy/plasteel = SHEET_MATERIAL_AMOUNT)

/obj/item/pipe/directional/airlock_pump
	icon_state_preview = "airlock_pump"
	pipe_type = /obj/machinery/atmospherics/components/unary/airlock_pump
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.7)

/obj/item/pipe/binary
	RPD_type = PIPE_STRAIGHT

/obj/item/pipe/binary/layer_adapter
	icon_state_preview = "manifoldlayer"
	pipe_type = /obj/machinery/atmospherics/pipe/layer_manifold
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/pipe/binary/color_adapter
	icon_state_preview = "adapter_center"
	pipe_type = /obj/machinery/atmospherics/pipe/color_adapter
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/pipe/binary/pressure_pump
	icon_state_preview = "pump"
	pipe_type = /obj/machinery/atmospherics/components/binary/pump
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6, /datum/material/glass = SMALL_MATERIAL_AMOUNT / 2)

/obj/item/pipe/binary/manual_valve
	icon_state_preview = "mvalve"
	pipe_type = /obj/machinery/atmospherics/components/binary/valve
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/pipe/binary/bendable
	RPD_type = PIPE_BENDABLE

/obj/item/pipe/trinary
	RPD_type = PIPE_TRINARY

/obj/item/pipe/trinary/flippable
	RPD_type = PIPE_TRIN_M
	var/flipped = FALSE

/obj/item/pipe/trinary/flippable/filter
	name = "gas filter fitting"
	icon_state_preview = "filter"
	pipe_type = /obj/machinery/atmospherics/components/trinary/filter
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6, /datum/material/glass = SMALL_MATERIAL_AMOUNT / 2)

/obj/item/pipe/trinary/flippable/mixer
	icon_state_preview = "mixer"
	pipe_type = /obj/machinery/atmospherics/components/trinary/mixer
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6, /datum/material/glass = SMALL_MATERIAL_AMOUNT / 2)

/obj/item/pipe/quaternary
	RPD_type = PIPE_ONEDIR

/obj/item/pipe/quaternary/pipe
	icon_state_preview = "manifold4w"
	pipe_type = /obj/machinery/atmospherics/pipe/smart

/obj/item/pipe/quaternary/pipe/crafted

/obj/item/pipe/quaternary/pipe/crafted/Initialize(mapload, _pipe_type, _dir, obj/machinery/atmospherics/make_from, device_color, device_init_dir = SOUTH)
	. = ..()
	pipe_type = /obj/machinery/atmospherics/pipe/smart
	pipe_color = ATMOS_COLOR_OMNI
	p_init_dir = ALL_CARDINALS
	setDir(SOUTH)
	update()

/obj/item/pipe/quaternary/he_pipe
	icon_state_preview = "he_manifold4w"
	pipe_type = /obj/machinery/atmospherics/pipe/heat_exchanging/manifold4w
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/pipe/Initialize(mapload, _pipe_type, _dir, obj/machinery/atmospherics/make_from, device_color, device_init_dir = SOUTH)
	if(make_from)
		make_from_existing(make_from)
	else
		p_init_dir = device_init_dir
		pipe_type = _pipe_type
		pipe_color = device_color
		setDir(_dir)

	update()
	pixel_x += rand(-5, 5)
	pixel_y += rand(-5, 5)

	// Переворот обрабатывается вручную из-за специальной обработки тройных труб.
	AddComponent(/datum/component/simple_rotation, ROTATION_NO_FLIPPING)

	// Только 'обычные' трубы
	if(type != /obj/item/pipe/quaternary)
		return ..()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/ghettojetpack, /datum/crafting_recipe/pipegun, /datum/crafting_recipe/smoothbore_disabler, /datum/crafting_recipe/improvised_pneumatic_cannon)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

	return ..()

/obj/item/pipe/proc/make_from_existing(obj/machinery/atmospherics/make_from)
	p_init_dir = make_from.get_init_directions()
	setDir(make_from.dir)
	pipename = make_from.name
	add_atom_colour(make_from.color, FIXED_COLOUR_PRIORITY)
	pipe_type = make_from.type
	paintable = make_from.paintable
	pipe_color = make_from.pipe_color

/obj/item/pipe/trinary/flippable/make_from_existing(obj/machinery/atmospherics/components/trinary/make_from)
	..()
	if(make_from.flipped)
		do_a_flip()

/obj/item/pipe/dropped()
	if(loc)
		set_piping_layer(piping_layer)
	return ..()

/obj/item/pipe/proc/set_piping_layer(new_layer = PIPING_LAYER_DEFAULT)
	var/obj/machinery/atmospherics/fakeA = pipe_type

	if(initial(fakeA.pipe_flags) & PIPING_ALL_LAYER)
		new_layer = PIPING_LAYER_DEFAULT
	piping_layer = new_layer

	PIPING_LAYER_SHIFT(src, piping_layer)
	layer = initial(layer) + ((piping_layer - PIPING_LAYER_DEFAULT) * PIPING_LAYER_LCHANGE)

/obj/item/pipe/proc/update()
	var/obj/machinery/atmospherics/fakeA = pipe_type
	name = "[initial(fakeA.name)] fitting"
	desc = initial(fakeA.desc)
	icon_state = initial(fakeA.pipe_state)
	if(ispath(pipe_type,/obj/machinery/atmospherics/pipe/heat_exchanging))
		resistance_flags |= FIRE_PROOF | LAVA_PROOF

/obj/item/pipe/verb/flip()
	set category = "Object"
	set name = "Invert Pipe"
	set src in view(1)

	if ( usr.incapacitated )
		return

	do_a_flip()

/obj/item/pipe/proc/do_a_flip()
	setDir(REVERSE_DIR(dir))

/obj/item/pipe/trinary/flippable/do_a_flip()
	setDir(turn(dir, flipped ? 45 : -45))
	flipped = !flipped

/obj/item/pipe/Move()
	var/old_dir = dir
	..()
	setDir(old_dir) // Изменение направления трубы при перемещении просто раздражает и вызывает ошибки.

// Преобразование направления фитинга в направление создаваемого компонента
/obj/item/pipe/proc/fixed_dir()
	return dir

/obj/item/pipe/binary/fixed_dir()
	. = dir
	if(dir == SOUTH)
		. = NORTH
	else if(dir == WEST)
		. = EAST

/obj/item/pipe/trinary/flippable/fixed_dir()
	. = dir
	if(ISDIAGONALDIR(dir))
		. = turn(dir, 45)

/obj/item/pipe/attack_self(mob/user)
	setDir(turn(dir,-90))

/// Проверяет, перпендикулярны ли труба на тайле и наша двоичная труба, которую нужно разместить.
/obj/item/pipe/proc/check_ninety_degree_dir(obj/machinery/atmospherics/machine)
	if(ISDIAGONALDIR(machine.dir))
		return FALSE
	if(EWCOMPONENT(machine.dir) && EWCOMPONENT(dir))
		return FALSE
	if(NSCOMPONENT(machine.dir) && NSCOMPONENT(dir))
		return FALSE
	return TRUE

/obj/item/pipe/wrench_act(mob/living/user, obj/item/wrench/wrench)
	. = ..()
	if(!isturf(loc))
		return TRUE

	add_fingerprint(user)

	var/obj/machinery/atmospherics/fakeA = pipe_type
	var/flags = initial(fakeA.pipe_flags)
	var/list/potentially_conflicting_machines = list()
	// Определяем, с какими машинами мы потенциально можем конфликтовать.
	for(var/obj/machinery/atmospherics/machine in loc)
		// Только один плотный/требующий плотности объект на тайл, например, коннекторы/крио/нагреватели/охладители.
		if(machine.pipe_flags & flags & PIPING_ONE_PER_TURF)
			to_chat(user, span_warning("Что-то занимает этот тайл!"))
			return TRUE
		// Пропускаем проверки, если слои не пересекаются, либо из-за нахождения на одном слое, либо из-за того, что что-то находится на всех слоях.
		if(machine.piping_layer != piping_layer && !((machine.pipe_flags | flags) & PIPING_ALL_LAYER))
			continue
		potentially_conflicting_machines += machine

	// Проверяем, не конфликтуем ли мы с какими-либо потенциально взаимодействующими машинами.
	for(var/obj/machinery/atmospherics/machine as anything in potentially_conflicting_machines)
		// Если у труб есть общие направления, мы не можем разместить её таким образом.
		var/our_init_dirs = SSair.get_init_dirs(pipe_type, fixed_dir(), p_init_dir)
		if(machine.get_init_directions() & our_init_dirs)
			// У нас конфликт!
			if (length(potentially_conflicting_machines) != 1 || !try_smart_reconfiguration(machine, our_init_dirs, user))
				// Решения не найдены.
				to_chat(user, span_warning("Здесь уже есть труба!"))
				return TRUE
	// Конфликтов не найдено.

	var/obj/machinery/atmospherics/built_machine = new pipe_type(loc, null, fixed_dir(), p_init_dir)
	build_pipe(built_machine)
	built_machine.on_construction(user, pipe_color, piping_layer)
	transfer_fingerprints_to(built_machine)

	wrench.play_tool_sound(src)
	user.visible_message( \
		span_notice("[user] закрепляет [declent_ru(ACCUSATIVE)]."), \
		span_notice("Вы закрепляете [declent_ru(ACCUSATIVE)]."), \
		span_hear("Слышен звук трещотки."))

	qdel(src)

/obj/item/pipe/welder_act(mob/living/user, obj/item/welder)
	. = ..()
	if(istype(pipe_type, /obj/machinery/atmospherics/components))
		return TRUE
	if(!welder.tool_start_check(user, amount=2))
		return TRUE
	add_fingerprint(user)

	if(welder.use_tool(src, user, 2 SECONDS, volume=2))
		new /obj/item/sliced_pipe(drop_location())
		user.visible_message( \
			"[user] разрезает [declent_ru(ACCUSATIVE)] пополам сваркой.", \
			span_notice("Вы разрезаете [declent_ru(ACCUSATIVE)] пополам сваркой."), \
			span_hear("Слышен звук сварки."))

		qdel(src)

/**
 * Пытается автоматически разрешить конфликт труб путём перенастройки любых задействованных умных труб.
 *
 * Ограничения:
 *  - Текущие соединения умной трубы не могут быть перенастроены.
 *  - Умная труба не может иметь менее двух направлений, в которых она будет соединяться.
 *  - Умная труба, существующая или новая, не будет автоматически перенастраиваться для разрешения направлений, которые она ранее не разрешала.
 */
/obj/item/pipe/proc/try_smart_reconfiguration(obj/machinery/atmospherics/machine, our_init_dirs, mob/living/user)
	// Если мы умная труба, мы могли бы решить это, разместив более ограниченную версию себя.
	var/obj/machinery/atmospherics/pipe/smart/other_smart_pipe = machine
	if(ispath(pipe_type, /obj/machinery/atmospherics/pipe/smart/))
		// Если мы конфликтуем с другой умной трубой, посмотрим, можем ли мы договориться.
		if(istype(other_smart_pipe))
			// Две умные трубы. Это будет сложно.
			// Проверяем, изогнута ли уже размещённая труба или нет.
			if (ISDIAGONALDIR(other_smart_pipe.dir))
				// Другая труба изогнута, с как минимум двумя текущими соединениями. Посмотрим, можем ли мы отскочить от неё как изогнутая труба в другом направлении.
				var/opposing_dir = our_init_dirs & ~other_smart_pipe.connections
				if (ISNOTSTUB(opposing_dir))
					// Мы попадаем сюда только если обе умные трубы имеют два направления.
					p_init_dir = opposing_dir
					other_smart_pipe.set_init_directions(other_smart_pipe.connections)
					other_smart_pipe.update_pipe_icon()
					return TRUE
				// У нас остаётся одно или ни одного доступного направления, если мы посмотрим на дополнение к активным соединениям другой умной трубы.
				// Больше мы ничего не можем сделать.
				return FALSE
			else
				// Другая труба прямая. Посмотрим, можем ли мы пройти над ней в перпендикулярном направлении.
				// Заметим, что другая труба не может быть несоединённой, так как у нас конфликт.
				if(EWCOMPONENT(other_smart_pipe.dir))
					if ((NORTH|SOUTH) & ~p_init_dir)
						// Не разрешено соединяться таким образом.
						return FALSE
					if (~other_smart_pipe.get_init_directions() & (EAST|WEST))
						// Не разрешено перенастраивать другую трубу таким образом.
						return FALSE
					p_init_dir = NORTH|SOUTH
					other_smart_pipe.set_init_directions(EAST|WEST)
					other_smart_pipe.update_pipe_icon()
					return TRUE
				if (NSCOMPONENT(other_smart_pipe.dir))
					if ((EAST|WEST) & ~p_init_dir)
						// Не разрешено соединяться таким образом.
						return FALSE
					if (~other_smart_pipe.get_init_directions() & (NORTH|SOUTH))
						// Не разрешено перенастраивать другую трубу таким образом.
						return FALSE
					p_init_dir = EAST|WEST
					other_smart_pipe.set_init_directions(NORTH|SOUTH)
					other_smart_pipe.update_pipe_icon()
					return TRUE
			return FALSE
		// Мы не имеем дело с другой умной трубой. Посмотрим, можем ли мы стать дополнением к конфликтующей машине.
		var/opposing_dir = our_init_dirs & ~machine.get_init_directions()
		if (ISNOTSTUB(opposing_dir))
			// У нас есть как минимум два разрешённых направления в дополнении. Используем их.
			p_init_dir = opposing_dir
			return TRUE
		return FALSE

	else if(istype(other_smart_pipe))
		// Мы сами не умная труба, но мы конфликтуем с умной трубой. Мы могли бы решить это, ограничив умную трубу.
		if (our_init_dirs & other_smart_pipe.connections)
			// Нам нужно было пойти туда, где у умной трубы уже были соединения, больше мы ничего не можем сделать.
			return FALSE
		var/opposing_dir = other_smart_pipe.get_init_directions() & ~our_init_dirs
		if (ISNOTSTUB(opposing_dir))
			// Для той умной трубы осталось как минимум два направления, перенастраиваем её.
			other_smart_pipe.set_init_directions(opposing_dir)
			other_smart_pipe.update_pipe_icon()
			return TRUE
		return FALSE
	// Умные трубы не задействованы, конфликт не может быть решен таким образом.
	return FALSE

/obj/item/pipe/proc/build_pipe(obj/machinery/atmospherics/A)
	if(pipename)
		A.name = pipename
	if(A.on)
		// Некоторые предустановленные подтипы включены по умолчанию, мы хотим сохранить
		// все другие аспекты этих подтипов (имя, предустановленные фильтры и т.д.)
		// но они не должны включаться автоматически при закручивании.
		A.on = FALSE

/obj/item/pipe/trinary/flippable/build_pipe(obj/machinery/atmospherics/components/trinary/T)
	..()
	T.flipped = flipped

/obj/item/pipe/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] засовывает [declent_ru(ACCUSATIVE)] в рот и включает! Похоже, [user] пытается покончить с собой!"))
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		for(var/i in 1 to 20)
			C.vomit(vomit_flags = (MOB_VOMIT_BLOOD | MOB_VOMIT_HARM), lost_nutrition = 0, distance = 4)
			if(prob(20))
				C.spew_organ()
			sleep(0.5 SECONDS)
		C.set_blood_volume(0)
	return(OXYLOSS|BRUTELOSS)

/obj/item/pipe/examine(mob/user)
	. = ..()
	. += span_notice("Слой трубы установлен на [piping_layer].")
	. += span_notice("Вы можете изменить слой трубы, нажав Правой Кнопкой Мыши на устройстве.")

/obj/item/pipe/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	var/layer_to_set = (piping_layer >= PIPING_LAYER_MAX) ? PIPING_LAYER_MIN : (piping_layer + 1)
	set_piping_layer(layer_to_set)
	balloon_alert(user, "слой трубы [piping_layer]")
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN


/obj/item/pipe/trinary/flippable/examine(mob/user)
	. = ..()
	. += span_notice("Вы можете перевернуть устройство, нажав Правой Кнопкой Мыши на нём.")

/obj/item/pipe/trinary/flippable/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	do_a_flip()
	balloon_alert(user, "труба перевёрнута")
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/pipe_meter
	name = "meter"
	desc = "Измеритель, который можно прикрутить к трубам гаечным ключом или прикрепить к полу отвёрткой."
	icon = 'icons/obj/pipes_n_cables/pipe_item.dmi'
	icon_state = "meter"
	inhand_icon_state = "buildpipe"
	w_class = WEIGHT_CLASS_BULKY
	var/piping_layer = PIPING_LAYER_DEFAULT

/obj/item/pipe_meter/wrench_act(mob/living/user, obj/item/wrench/W)
	. = ..()
	var/obj/machinery/atmospherics/pipe/pipe
	for(var/obj/machinery/atmospherics/pipe/P in loc)
		if(P.piping_layer == piping_layer)
			pipe = P
			break
	if(!pipe)
		to_chat(user, span_warning("Нужно прикрепить его к трубе!"))
		return TRUE
	new /obj/machinery/meter(loc, piping_layer)
	W.play_tool_sound(src)
	to_chat(user, span_notice("Вы прикрепляете измеритель к трубе."))
	qdel(src)

/obj/item/pipe_meter/screwdriver_act(mob/living/user, obj/item/S)
	. = ..()
	if(.)
		return TRUE

	if(!isturf(loc))
		to_chat(user, span_warning("Нужно прикрепить его к полу!"))
		return TRUE

	new /obj/machinery/meter/turf(loc, piping_layer)
	S.play_tool_sound(src)
	to_chat(user, span_notice("Вы прикрепляете измеритель к [declent_ru(PREPOSITIONAL, loc)]."))
	qdel(src)

/obj/item/pipe_meter/dropped()
	. = ..()
	if(loc)
		setAttachLayer(piping_layer)

/obj/item/pipe_meter/proc/setAttachLayer(new_layer = PIPING_LAYER_DEFAULT)
	piping_layer = new_layer
	PIPING_LAYER_DOUBLE_SHIFT(src, piping_layer)

// Добавляем русские названия для объектов.

/obj/item/pipe/get_ru_names()
	return list(
		NOMINATIVE = "трубный фитинг",
		GENITIVE = "трубного фитинга",
		DATIVE = "трубному фитингу",
		ACCUSATIVE = "трубный фитинг",
		INSTRUMENTAL = "трубным фитингом",
		PREPOSITIONAL = "трубном фитинге",
	)

/obj/item/pipe_meter/get_ru_names()
	return list(
		NOMINATIVE = "измеритель",
		GENITIVE = "измерителя",
		DATIVE = "измерителю",
		ACCUSATIVE = "измеритель",
		INSTRUMENTAL = "измерителем",
		PREPOSITIONAL = "измерителе",
	)
