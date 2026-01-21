/// Индикатор для входного порта
#define INLET 1
/// Индикатор для выходного порта
#define OUTLET 2

/// Датчик воздуха газового бака.
/// Эти датчики всегда подключаются к мониторам, будьте осторожны с ними
/obj/machinery/air_sensor
	name = "gas sensor"
	icon = 'icons/obj/wallmounts.dmi'
	icon_state = "gsensor1"
	resistance_flags = FIRE_PROOF
	power_channel = AREA_USAGE_ENVIRON
	active_power_usage = BASE_MACHINE_IDLE_CONSUMPTION * 1.5

	/// Уникальная строка, представляющая, с какой атмосферной камерой ассоциировать.
	var/chamber_id
	/// Впускной порт [инжектор], управляемый этим датчиком
	var/inlet_id
	/// Выпускной порт [вентиляционный насос], управляемый этим датчиком
	var/outlet_id
	/// Контроллер атмосферы, подключённый к этому датчику
	var/obj/machinery/airalarm/connected_airalarm
	/// Включён ли этот датчик
	var/on = TRUE

/obj/machinery/air_sensor/Initialize(mapload)
	id_tag = assign_random_name()

	var/static/list/multitool_tips = list(
		TOOL_MULTITOOL = list(
			SCREENTIP_CONTEXT_LMB = "Связать с зарегистрированными инжекторами/вентилями",
			SCREENTIP_CONTEXT_RMB = "Сбросить все порты ввода-вывода",
		)
	)
	AddElement(/datum/element/contextual_screentip_tools, multitool_tips)

	return ..()

/obj/machinery/air_sensor/post_machine_initialize()
	. = ..()

	// Автоматическое подключение ко всем устройствам впуска и выпуска в радиусе 4 клеток от этого датчика
	for(var/obj/machinery/atmospherics/components/unary/device in oview(4, src))
		if(inlet_id && outlet_id)
			break
		configure(device)

/**
 * Подключает инжектор или вентиляционный насос к этому датчику воздуха. Должен находиться на том же Z-уровне, что и датчик.
 * Возвращает тип настроенного порта или NONE, если операция не выполнена.
 *
 * Аргументы:
 * * obj/machinery/atmospherics/components/unary/port - устройство, которое мы пытаемся подключить к этому датчику.
 * * reconfigure - если TRUE, перезапишет существующие порты, если они уже зарегистрированы.
*/
/obj/machinery/air_sensor/proc/configure(obj/machinery/atmospherics/components/unary/port, reconfigure = FALSE)
	PRIVATE_PROC(TRUE)
	if(!istype(port) || port.z != z)
		return NONE

	if(istype(port, /obj/machinery/atmospherics/components/unary/outlet_injector))
		if(!reconfigure && inlet_id)
			return INLET
		var/obj/machinery/atmospherics/components/unary/outlet_injector/input = port
		// Настраиваем только не загруженные при маппинге инжекторы, так как у них уже есть предустановленная конфигурация.
		if(input.type == /obj/machinery/atmospherics/components/unary/outlet_injector)
			input.volume_rate = MAX_TRANSFER_RATE
		inlet_id = input.id_tag
		return INLET

	else if(istype(port, /obj/machinery/atmospherics/components/unary/vent_pump))
		if(!reconfigure && outlet_id)
			return OUTLET
		var/obj/machinery/atmospherics/components/unary/vent_pump/output = port
		// Настраиваем только не загруженные при маппинге вентиляционные насосы, так как у них уже есть предустановленная конфигурация.
		if(output.type == /obj/machinery/atmospherics/components/unary/vent_pump)
			// Чтобы он больше не управлялся контроллером атмосферы.
			output.disconnect_from_area()
			// Конфигурация скопирована с /obj/machinery/atmospherics/components/unary/vent_pump/siphon, но с максимальным давлением.
			output.pump_direction = ATMOS_DIRECTION_SIPHONING
			output.pressure_checks = ATMOS_INTERNAL_BOUND
			output.internal_pressure_bound = MAX_OUTPUT_PRESSURE
			output.external_pressure_bound = 0
		// Наконец, назначаем его этому датчику.
		outlet_id = output.id_tag
		return OUTLET
	return NONE

/obj/machinery/air_sensor/Destroy()
	reset()
	return ..()

/obj/machinery/air_sensor/return_air()
	if(!on)
		return
	. = ..()
	use_energy(active_power_usage) // Используем энергию для анализа газов.

/obj/machinery/air_sensor/process()
	// Обновляем внешний вид в соответствии с состоянием питания.
	if(machine_stat & NOPOWER)
		if(on)
			on = FALSE
			update_appearance()
	else if(!on)
		on = TRUE
		update_appearance()

/obj/machinery/air_sensor/examine(mob/user)
	. = ..()
	. += span_notice("Используйте мультитул, чтобы связать его с инжектором, вентилем или контроллером атмосферы, либо сбросить его порты.")
	. += span_notice("Нажмите рукой, чтобы выключить.")

/obj/machinery/air_sensor/attack_hand(mob/living/user, list/modifiers)
	. = ..()

	// Выключенная версия этого датчика, но всё ещё прикреплённая к земле.
	var/obj/item/air_sensor/sensor = new(drop_location())
	sensor.set_anchored(TRUE)
	sensor.balloon_alert(user, "датчик выключен")

	// Удаляем себя.
	qdel(src)

/obj/machinery/air_sensor/update_icon_state()
	icon_state = "gsensor[on]"
	return ..()

/obj/machinery/air_sensor/proc/reset()
	inlet_id = null
	outlet_id = null
	if(connected_airalarm)
		connected_airalarm.disconnect_sensor()
		// if air alarm and sensor were linked at roundstart we allow them to link to new devices
		connected_airalarm.allow_link_change = TRUE
		connected_airalarm = null


/// Правый клик мультитулом, чтобы отключить всё.
/obj/machinery/air_sensor/multitool_act_secondary(mob/living/user, obj/item/tool)
	reset()
	balloon_alert(user, "порты сброшены")
	return TRUE

/obj/machinery/air_sensor/multitool_act(mob/living/user, obj/item/multitool/multi_tool)
	. = ..()

	var/type = configure(multi_tool.buffer, TRUE)
	switch(type)
		if(INLET, OUTLET)
			var/port = "[type == INLET ? "входной" : "выходной"] порт"
			user.balloon_alert(user, "[port] настроен")
			to_chat(user, span_notice("[RU_SRC_NOM] подключил[GEND_A_O_I(src)] [multi_tool.buffer] к своему [port]у."))
	to_chat(user, span_notice("[RU_SRC_NOM] добавлен в буфер мультитула."))
	multi_tool.set_buffer(src)

	return ITEM_INTERACT_SUCCESS

/**
 * Портативная версия /obj/machinery/air_sensor.
 * Затягивание гаечным ключом и включение превратит её обратно в /obj/machinery/air_sensor.
 * Разборка сварочным аппаратом /obj/machinery/air_sensor превратит её обратно в /obj/item/air_sensor.
 * Логика такая же, как у измерительных приборов.
 */
/obj/item/air_sensor
	name = "Air Sensor"
	desc = "Устройство, предназначенное для обнаружения газов и их концентрации в области."
	icon = 'icons/obj/wallmounts.dmi'
	icon_state = "gsensor0"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT + SMALL_MATERIAL_AMOUNT * 0.3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.2)

/obj/item/air_sensor/Initialize(mapload, inlet, outlet)
	. = ..()
	register_context()

/obj/item/air_sensor/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	if(isnull(held_item))
		return NONE

	if(held_item.tool_behaviour == TOOL_WRENCH)
		context[SCREENTIP_CONTEXT_LMB] = anchored ? "Открутить" : "Прикрутить"
		return CONTEXTUAL_SCREENTIP_SET

	if(held_item.tool_behaviour == TOOL_WELDER && !anchored)
		context[SCREENTIP_CONTEXT_LMB] = "Разобрать"
		return CONTEXTUAL_SCREENTIP_SET

	return NONE

/obj/item/air_sensor/examine(mob/user)
	. = ..()
	if(anchored)
		. += span_notice("[EXAMINE_HINT("Прикручен")] на месте.")
	else
		. += span_notice("Его следует [EXAMINE_HINT("прикрутить")] на место, чтобы включить.")
	. +=  span_notice("Его можно [EXAMINE_HINT("разобрать")] сваркой.")
	. +=  span_notice("Нажмите рукой, чтобы включить.")

/obj/item/air_sensor/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(!anchored)
		return

	// Список датчиков по названию.
	var/list/available_sensors = list()
	for(var/chamber_id in GLOB.station_gas_chambers)
		// Не позволяем конфликтовать с существующими датчиками распределительной и отходной систем.
		if(chamber_id == ATMOS_GAS_MONITOR_DISTRO)
			continue
		if(chamber_id == ATMOS_GAS_MONITOR_WASTE)
			continue
		available_sensors += GLOB.station_gas_chambers[chamber_id]

	// Предлагаем выбор.
	var/chamber_name = tgui_input_list(user, "Выберите назначение датчика", "Выбор ID датчика", available_sensors)
	if(isnull(chamber_name))
		return

	// Сопоставляем название камеры с её ID.
	var/target_chamber
	for(var/chamber_id in GLOB.station_gas_chambers)
		if(GLOB.station_gas_chambers[chamber_id] != chamber_name)
			continue
		target_chamber = chamber_id
		break

	// Создаём датчик из доступных подтипов датчиков.
	var/static/list/chamber_subtypes = null
	if(isnull(chamber_subtypes))
		chamber_subtypes = subtypesof(/obj/machinery/air_sensor)
	for(var/obj/machinery/air_sensor/sensor as anything in chamber_subtypes)
		if(initial(sensor.chamber_id) != target_chamber)
			continue

		// Создаём настоящий датчик на его месте.
		var/obj/machinery/air_sensor/new_sensor = new sensor(get_turf(src))
		new_sensor.balloon_alert(user, "датчик включён")
		qdel(src)

		break

/obj/item/air_sensor/wrench_act(mob/living/user, obj/item/tool)
	if(default_unfasten_wrench(user, tool) == SUCCESSFUL_UNFASTEN)
		return ITEM_INTERACT_SUCCESS

/obj/item/air_sensor/welder_act(mob/living/user, obj/item/tool)
	if(!tool.tool_start_check(user, amount = 1))
		return ITEM_INTERACT_BLOCKING

	loc.balloon_alert(user, "разбираю датчик")
	if(!tool.use_tool(src, user, 2 SECONDS, volume = 30, amount = 1))
		return ITEM_INTERACT_BLOCKING
	loc.balloon_alert(user, "датчик разобран")

	deconstruct(TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/item/air_sensor/atom_deconstruct(disassembled)
	new /obj/item/analyzer(loc)
	new /obj/item/stack/sheet/iron(loc)

// Добавляем русские названия для объектов, которые могут отображаться в тексте.

/obj/machinery/air_sensor/get_ru_names()
	return alist(
		NOMINATIVE = "газовый датчик",
		GENITIVE = "газового датчика",
		DATIVE = "газовому датчику",
		ACCUSATIVE = "газовый датчик",
		INSTRUMENTAL = "газовым датчиком",
		PREPOSITIONAL = "газовом датчике",
	)

/obj/item/air_sensor/get_ru_names()
	return alist(
		NOMINATIVE = "датчик воздуха",
		GENITIVE = "датчика воздуха",
		DATIVE = "датчику воздуха",
		ACCUSATIVE = "датчик воздуха",
		INSTRUMENTAL = "датчиком воздуха",
		PREPOSITIONAL = "датчике воздуха",
	)

#undef INLET
#undef OUTLET
