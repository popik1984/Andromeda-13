// Большая часть atmospherics.dm использовалась исключительно компонентами, поэтому разделение делает всё намного чище.
// Кроме того, теперь люди могут добавлять специфичные для компонентов процедуры/переменные, если захотят!

/obj/machinery/atmospherics/components
	hide = FALSE
	layer = GAS_PUMP_LAYER
	///Заварен ли компонент?
	var/welded = FALSE
	///Текущее состояние доступности под полом, определяет, должен ли компонент показывать трубу под ним и на каком плане он рендерится.
	var/underfloor_state = UNDERFLOOR_INTERACTABLE
	///Нужно ли сдвигать всё, когда компонент находится на нестандартном слое? Или только трубу подложки.
	var/shift_underlay_only = TRUE
	///Хранит родительский трубопровод, используется в компонентах
	var/list/datum/pipeline/parents
	///Если объект в очереди на перестройку, эта переменная указывает, нужно ли обновлять родителей после завершения
	var/update_parents_after_rebuild = FALSE
	///Хранит газовую смесь для каждого узла, используется в компонентах
	var/list/datum/gas_mixture/airs
	///Определяет, должна ли использоваться кастомная обработка согласования (reconcilation)
	var/custom_reconcilation = FALSE

/obj/machinery/atmospherics/components/get_save_vars()
	. = ..()
	if(!override_naming)
		// Предотвращает сохранение динамического имени с \proper, так как оно превращается в "???"
		. -= NAMEOF(src, name)
	. += NAMEOF(src, welded)
	return .

/obj/machinery/atmospherics/components/Initialize(mapload)
	parents = new(device_type)
	airs = new(device_type)

	. = ..()

	for(var/i in 1 to device_type)
		if(airs[i])
			continue
		var/datum/gas_mixture/component_mixture = new
		component_mixture.volume = 200
		airs[i] = component_mixture

	update_appearance()

// Работа с иконками

/**
 * Вызывается в update_icon(), используется индивидуально каждым компонентом для определения состояния иконки без учета труб
 */
/obj/machinery/atmospherics/components/proc/update_icon_nopipes()
	return

/obj/machinery/atmospherics/components/on_hide(datum/source, underfloor_accessibility)
	hide_pipe(underfloor_accessibility)
	return ..()

/**
 * Вызывается в on_hide(), устанавливает переменную underfloor_state в true или false в зависимости от ситуации, вызывает update_icon()
 */
/obj/machinery/atmospherics/components/proc/hide_pipe(underfloor_accessibility)
	underfloor_state = underfloor_accessibility
	if(underfloor_state)
		REMOVE_TRAIT(src, TRAIT_UNDERFLOOR, REF(src))
	else
		ADD_TRAIT(src, TRAIT_UNDERFLOOR, REF(src))
	update_appearance(UPDATE_ICON)

/obj/machinery/atmospherics/components/update_icon()
	update_icon_nopipes()

	underlays.Cut()

	color = null
	var/uncovered_turf = loc && HAS_TRAIT(loc, TRAIT_UNCOVERED_TURF)
	SET_PLANE_IMPLICIT(src, (underfloor_state == UNDERFLOOR_INTERACTABLE && !uncovered_turf) ? GAME_PLANE : FLOOR_PLANE)

	// Слой обрабатывается в update_layer()
	if(!underfloor_state)
		return ..()

	if(pipe_flags & PIPING_DISTRO_AND_WASTE_LAYERS)
		return ..()

	var/connected = 0 //Битовая маска направлений
	var/underlay_pipe_layer = shift_underlay_only ? piping_layer : 3

	for(var/i in 1 to device_type) //добавляет целые части
		if(!nodes[i])
			continue
		var/obj/machinery/atmospherics/node = nodes[i]
		var/node_dir = get_dir(src, node)
		var/mutable_appearance/pipe_appearance = mutable_appearance('icons/obj/pipes_n_cables/pipe_underlays.dmi', "intact_[node_dir]_[underlay_pipe_layer]", appearance_flags = RESET_COLOR|KEEP_APART)
		pipe_appearance.color = (node.pipe_color == ATMOS_COLOR_OMNI || istype(node, /obj/machinery/atmospherics/pipe/color_adapter)) ? pipe_color : node.pipe_color
		if (underfloor_state == UNDERFLOOR_VISIBLE || uncovered_turf)
			pipe_appearance.layer = BELOW_CATWALK_LAYER + get_pipe_layer_offset()
			SET_PLANE_EXPLICIT(pipe_appearance, FLOOR_PLANE, src)
		underlays += pipe_appearance
		connected |= node_dir

	for(var/direction in GLOB.cardinals)
		if((initialize_directions & direction) && !(connected & direction))
			var/mutable_appearance/pipe_appearance = mutable_appearance('icons/obj/pipes_n_cables/pipe_underlays.dmi', "exposed_[direction]_[underlay_pipe_layer]", appearance_flags = RESET_COLOR|KEEP_APART)
			pipe_appearance.color = pipe_color
			if (underfloor_state == UNDERFLOOR_VISIBLE || uncovered_turf)
				pipe_appearance.layer = BELOW_CATWALK_LAYER + get_pipe_layer_offset()
				SET_PLANE_EXPLICIT(pipe_appearance, FLOOR_PLANE, src)
			underlays += pipe_appearance

	if(!shift_underlay_only)
		PIPING_LAYER_SHIFT(src, piping_layer)
	return ..()

/obj/machinery/atmospherics/components/get_pipe_image(iconfile, iconstate, direction, color, piping_layer, trinary)
	var/mutable_appearance/pipe_appearance = ..()
	if (underfloor_state == UNDERFLOOR_VISIBLE || (loc && HAS_TRAIT(loc, TRAIT_UNCOVERED_TURF)))
		pipe_appearance.layer = BELOW_CATWALK_LAYER + get_pipe_layer_offset()
		SET_PLANE_EXPLICIT(pipe_appearance, FLOOR_PLANE, src)
	return pipe_appearance

// Работа с трубопроводом; обслуживание

/obj/machinery/atmospherics/components/nullify_node(i)
	if(parents[i])
		nullify_pipenet(parents[i])
	airs[i] = null
	return ..()

/obj/machinery/atmospherics/components/on_construction(mob/user)
	. = ..()
	update_parents()

/obj/machinery/atmospherics/components/on_deconstruction(disassembled)
	relocate_airs()
	return ..()

/obj/machinery/atmospherics/components/rebuild_pipes()
	. = ..()
	if(update_parents_after_rebuild)
		update_parents()

/obj/machinery/atmospherics/components/get_rebuild_targets()
	var/list/to_return = list()
	for(var/i in 1 to device_type)
		if(parents[i])
			continue
		parents[i] = new /datum/pipeline()
		to_return += parents[i]
	return to_return

/**
 * Вызывается через nullify_node(), используется для удаления трубопровода, к которому присоединен компонент
 * Аргументы:
 * * -reference: трубопровод, к которому присоединен компонент
 */
/obj/machinery/atmospherics/components/proc/nullify_pipenet(datum/pipeline/reference)
	if(!reference)
		CRASH("nullify_pipenet(null) called by [type] on [COORD(src)]")

	for (var/i in 1 to parents.len)
		if (parents[i] == reference)
			reference.other_airs -= airs[i] // Отсоединяет со стороны трубопровода
			parents[i] = null // Отсоединяет со стороны оборудования.

	reference.other_atmos_machines -= src
	if(custom_reconcilation)
		reference.require_custom_reconcilation -= src

	/**
	 *  Мы явно удаляем (qdel) трубопровод, когда предполагается,
	 *  что в этом конкретном трубопроводе не останется участников, что вызовет проблемы с GC.
	 *  Мы должны делать это, потому что компоненты не удаляют трубопроводы,
	 *  в то время как трубы обязаны это делать и будут с радостью ломать и перестраивать всё
	 *  заново каждый раз, когда они удаляются.
	 */

	if(!length(reference.other_atmos_machines) && !length(reference.members))
		if(QDESTROYING(reference))
			CRASH("nullify_pipenet() called on qdeleting [reference]")
		qdel(reference)

/obj/machinery/atmospherics/components/return_pipenet_airs(datum/pipeline/reference)
	var/list/returned_air = list()

	for (var/i in 1 to parents.len)
		if (parents[i] == reference)
			returned_air += airs[i]
	return returned_air

/obj/machinery/atmospherics/components/pipeline_expansion(datum/pipeline/reference)
	if(reference)
		return list(nodes[parents.Find(reference)])
	return ..()

/obj/machinery/atmospherics/components/set_pipenet(datum/pipeline/reference, obj/machinery/atmospherics/target_component)
	parents[nodes.Find(target_component)] = reference

/obj/machinery/atmospherics/components/return_pipenet(obj/machinery/atmospherics/target_component = nodes[1]) //возвращает parents[1], если вызвано без аргументов
	return parents[nodes.Find(target_component)]

/obj/machinery/atmospherics/components/replace_pipenet(datum/pipeline/Old, datum/pipeline/New)
	parents[parents.Find(Old)] = New

// Помощники

/**
 * Вызывается в большинстве атмосферных процессов и ситуаций обработки газа, обновляет родительские трубопроводы устройств, подключенных к компоненту-источнику
 * Таким образом, газы не застрянут
 */
/obj/machinery/atmospherics/components/proc/update_parents()
	if(!SSair.initialized)
		return
	if(rebuilding)
		update_parents_after_rebuild = TRUE
		return
	for(var/i in 1 to device_type)
		var/datum/pipeline/parent = parents[i]
		if(!parent)
			WARNING("Component is missing a pipenet! Rebuilding...")
			SSair.add_to_rebuild_queue(src)
		else
			parent.update = TRUE

/obj/machinery/atmospherics/components/return_pipenets()
	. = list()
	for(var/i in 1 to device_type)
		. += return_pipenet(nodes[i])

/// Когда эта машина находится в сети труб, которая согласовывает воздух, эта процедура может добавлять трубопроводы в расчет.
/// Может быть либо списком сетей труб, либо одной сетью труб.
/obj/machinery/atmospherics/components/proc/return_pipenets_for_reconcilation(datum/pipeline/requester)
	return list()

/// Когда эта машина находится в сети труб, которая согласовывает воздух, эта процедура может добавлять воздух в расчет.
/// Может быть либо списком воздушных смесей, либо одной воздушной смесью.
/obj/machinery/atmospherics/components/proc/return_airs_for_reconcilation(datum/pipeline/requester)
	return list()

// Интерфейс

/obj/machinery/atmospherics/components/ui_status(mob/user, datum/ui_state/state)
	if(allowed(user))
		return ..()
	to_chat(user, span_danger("Доступ запрещён."))
	return UI_CLOSE

// Действия с инструментами

/obj/machinery/atmospherics/components/return_analyzable_air()
	return airs

/**
 * Обрабатывает разборку оборудования и опасный сброс давления
 */
/obj/machinery/atmospherics/components/proc/crowbar_deconstruction_act(mob/living/user, obj/item/tool, internal_pressure = 0)
	if(!panel_open)
		balloon_alert(user, "откройте панель!")
		return ITEM_INTERACT_SUCCESS

	var/unsafe_wrenching = FALSE
	var/filled_pipe = FALSE
	var/datum/gas_mixture/environment_air = loc.return_air()

	for(var/i in 1 to device_type)
		var/datum/gas_mixture/inside_air = airs[i]
		if(inside_air.total_moles() > 0 || internal_pressure)
			filled_pipe = TRUE
		if(!nodes[i] || (istype(nodes[i], /obj/machinery/atmospherics/components/unary/portables_connector) && !portable_device_connected(i)))
			internal_pressure = internal_pressure > airs[i].return_pressure() ? internal_pressure : airs[i].return_pressure()

	if(!filled_pipe)
		default_deconstruction_crowbar(tool)
		return ITEM_INTERACT_SUCCESS

	to_chat(user, span_notice("Вы начинаете откручивать [RU_SRC_ACC]..."))

	internal_pressure -= environment_air.return_pressure()

	if(internal_pressure > 2 * ONE_ATMOSPHERE)
		to_chat(user, span_warning("Как только вы начинаете разбирать [RU_SRC_ACC], поток воздуха дует вам в лицо... может, стоит передумать?"))
		unsafe_wrenching = TRUE

	if(!do_after(user, 2 SECONDS, src))
		return
	if(unsafe_wrenching)
		unsafe_pressure_release(user, internal_pressure)
	tool.play_tool_sound(src, 50)
	deconstruct(TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/atmospherics/components/default_change_direction_wrench(mob/user, obj/item/I)
	. = ..()
	if(!.)
		return FALSE
	set_init_directions()
	reconnect_nodes()
	return TRUE

/obj/machinery/atmospherics/components/proc/reconnect_nodes()
	for(var/i in 1 to device_type)
		var/obj/machinery/atmospherics/node = nodes[i]
		if(node)
			if(src in node.nodes)
				node.disconnect(src)
			nodes[i] = null
		if(parents[i])
			nullify_pipenet(parents[i])
	for(var/i in 1 to device_type)
		var/obj/machinery/atmospherics/node = nodes[i]
		atmos_init()
		node = nodes[i]
		if(node)
			node.atmos_init()
			node.add_member(src)
			update_parents()
		SSair.add_to_rebuild_queue(src)

/**
 * Отсоединяет все узлы от нас, удаляет нас из списка узлов соседа.
 * Обнуляет наш родительский трубопровод
 */
/obj/machinery/atmospherics/components/proc/disconnect_nodes()
	for(var/i in 1 to device_type)
		var/obj/machinery/atmospherics/node = nodes[i]
		if(node)
			if(src in node.nodes) //Только если он действительно подключен. Версия на трубе односторонняя.
				node.disconnect(src)
			nodes[i] = null
		if(parents[i])
			nullify_pipenet(parents[i])

/**
 * Подключает все узлы к нам, добавляет нас в список узлов соседа.
 * Вызывает atmos_init() у узла и у нас.
 */
/obj/machinery/atmospherics/components/proc/connect_nodes()
	atmos_init()
	for(var/i in 1 to device_type)
		var/obj/machinery/atmospherics/node = nodes[i]
		if(node)
			node.atmos_init()
			node.add_member(src)
	SSair.add_to_rebuild_queue(src)

/**
 * Простой способ переключения соединения и отсоединения узлов.
 *
 * Аргументы:
 * * disconnect - если TRUE, отсоединяет все узлы. Если FALSE, соединяет все узлы.
 */
/obj/machinery/atmospherics/components/proc/change_nodes_connection(disconnect)
	if(disconnect)
		disconnect_nodes()
		return
	connect_nodes()

/obj/machinery/atmospherics/components/update_layer()
	if (!underfloor_state)
		layer = BELOW_CATWALK_LAYER
	else if (PLANE_TO_TRUE(plane) == FLOOR_PLANE)
		layer = ABOVE_OPEN_TURF_LAYER
	else
		layer = initial(layer)
	layer += get_pipe_layer_offset()

/obj/machinery/atmospherics/components/proc/get_pipe_layer_offset()
	return (piping_layer - PIPING_LAYER_DEFAULT) * PIPING_LAYER_LCHANGE + (GLOB.pipe_colors_ordered[pipe_color] * 0.001)

/**
 * Обрабатывает перемещение воздуха в трубопровод/окружающую среду
 */
/obj/machinery/atmospherics/components/proc/relocate_airs(datum/gas_mixture/to_release)
	var/turf/local_turf = get_turf(src)
	for(var/i in 1 to device_type)
		var/datum/gas_mixture/air = airs[i]
		if(!nodes[i] || (istype(nodes[i], /obj/machinery/atmospherics/components/unary/portables_connector) && !portable_device_connected(i)))
			if(!to_release)
				to_release = air
				continue
			to_release.merge(air)
			continue
		var/datum/gas_mixture/parents_air = parents[i].air
		parents_air.merge(air)
	if(to_release)
		local_turf.assume_air(to_release)
