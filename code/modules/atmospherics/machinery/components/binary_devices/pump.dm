// Каждый цикл насос использует воздух из air_in, пытаясь создать идеальное давление в air_out.
//
// node1, air1, network1 соответствуют входу
// node2, air2, network2 соответствуют выходу
//
// Таким образом, две переменные, влияющие на работу насоса, устанавливаются в New():
//   air1.volume
//     Это объем газа, доступный насосу, который может быть передан на выход
//   air2.volume
//     Более высокие значения этого параметра приводят к большему количеству идеально перекачанного воздуха,
//     но общий объем сети также увеличивается при увеличении этого значения...

/obj/machinery/atmospherics/components/binary/pump
	icon_state = "pump_map-3"
	name = "gas pump"
	desc = "Насос, перемещающий газ за счёт давления."
	can_unwrench = TRUE
	shift_underlay_only = FALSE
	construction_type = /obj/item/pipe/directional
	pipe_state = "pump"
	vent_movement = NONE
	///Pressure that the pump will reach when on
	var/target_pressure = ONE_ATMOSPHERE

/obj/machinery/atmospherics/components/binary/pump/get_ru_names()
	return list(
		NOMINATIVE = "газовая помпа",
		GENITIVE = "газовой помпы",
		DATIVE = "газовой помпе",
		ACCUSATIVE = "газовую помпу",
		INSTRUMENTAL = "газовой помпой",
		PREPOSITIONAL = "газовой помпе",
	)

/obj/machinery/atmospherics/components/binary/pump/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/usb_port, typecacheof(list(/obj/item/circuit_component/atmos_pump), only_root_path = TRUE))
	register_context()

/obj/machinery/atmospherics/components/binary/pump/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	context[SCREENTIP_CONTEXT_CTRL_LMB] = "[on ? "Выключить" : "Включить"]"
	context[SCREENTIP_CONTEXT_ALT_LMB] = "Максимизировать целевое давление"
	return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/atmospherics/components/binary/pump/click_ctrl(mob/user)
	if(is_operational)
		set_on(!on)
		balloon_alert(user, "[on ? "включено" : "выключено"]")
		investigate_log("was turned [on ? "on" : "off"] by [key_name(user)]", INVESTIGATE_ATMOS)
		return CLICK_ACTION_SUCCESS
	return CLICK_ACTION_BLOCKING

/obj/machinery/atmospherics/components/binary/pump/click_alt(mob/user)
	if(target_pressure == MAX_OUTPUT_PRESSURE)
		return CLICK_ACTION_BLOCKING

	target_pressure = MAX_OUTPUT_PRESSURE
	investigate_log("was set to [target_pressure] kPa by [key_name(user)]", INVESTIGATE_ATMOS)
	balloon_alert(user, "давление установлено на [target_pressure] кПа")
	update_appearance(UPDATE_ICON)
	return CLICK_ACTION_SUCCESS

/obj/machinery/atmospherics/components/binary/pump/update_icon_nopipes()
	icon_state = (on && is_operational) ? "pump_on-[set_overlay_offset(piping_layer)]" : "pump_off-[set_overlay_offset(piping_layer)]"

/obj/machinery/atmospherics/components/binary/pump/process_atmos()
	if(!on || !is_operational)
		return

	var/datum/gas_mixture/input_air = airs[1]
	var/datum/gas_mixture/output_air = airs[2]
	var/datum/gas_mixture/output_pipenet_air = parents[2].air

	if(input_air.pump_gas_to(output_air, target_pressure, output_pipenet_air = output_pipenet_air))
		update_parents()

/obj/machinery/atmospherics/components/binary/pump/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AtmosPump", name)
		ui.open()

/obj/machinery/atmospherics/components/binary/pump/ui_data()
	var/data = list()
	data["on"] = on
	data["pressure"] = round(target_pressure)
	data["max_pressure"] = round(MAX_OUTPUT_PRESSURE)
	return data

/obj/machinery/atmospherics/components/binary/pump/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("power")
			set_on(!on)
			investigate_log("was turned [on ? "on" : "off"] by [key_name(usr)]", INVESTIGATE_ATMOS)
			. = TRUE
		if("pressure")
			var/pressure = params["pressure"]
			if(pressure == "max")
				pressure = MAX_OUTPUT_PRESSURE
				. = TRUE
			else if(text2num(pressure) != null)
				pressure = text2num(pressure)
				. = TRUE
			if(.)
				target_pressure = clamp(pressure, 0, MAX_OUTPUT_PRESSURE)
				investigate_log("was set to [target_pressure] kPa by [key_name(usr)]", INVESTIGATE_ATMOS)
	update_appearance(UPDATE_ICON)

/obj/machinery/atmospherics/components/binary/pump/can_unwrench(mob/user)
	. = ..()
	if(. && on && is_operational)
		to_chat(user, span_warning("Нельзя откручивать [declent_ru(ACCUSATIVE)], сначала выключите её!"))
		return FALSE

/obj/machinery/atmospherics/components/binary/pump/layer2
	piping_layer = 2
	icon_state= "pump_map-2"

/obj/machinery/atmospherics/components/binary/pump/layer4
	piping_layer = 4
	icon_state= "pump_map-4"

/obj/machinery/atmospherics/components/binary/pump/on
	on = TRUE
	icon_state = "pump_on_map-3"

/obj/machinery/atmospherics/components/binary/pump/on/layer2
	piping_layer = 2
	icon_state= "pump_on_map-2"

/obj/machinery/atmospherics/components/binary/pump/on/layer4
	piping_layer = 4
	icon_state= "pump_on_map-4"

/obj/machinery/atmospherics/components/binary/pump/on/layer5
	piping_layer = 5
	icon_state = "pump_on_map-5"

/obj/item/circuit_component/atmos_pump
	display_name = "Атмосферная бинарная помпа"
	desc = "Интерфейс для взаимодействия с помпой."

	///Set the target pressure of the pump
	var/datum/port/input/pressure_value
	///Activate the pump
	var/datum/port/input/on
	///Deactivate the pump
	var/datum/port/input/off
	///Signals the circuit to retrieve the pump's current pressure and temperature
	var/datum/port/input/request_data

	///Pressure of the input port
	var/datum/port/output/input_pressure
	///Pressure of the output port
	var/datum/port/output/output_pressure
	///Temperature of the input port
	var/datum/port/output/input_temperature
	///Temperature of the output port
	var/datum/port/output/output_temperature

	///Whether the pump is currently active
	var/datum/port/output/is_active
	///Send a signal when the pump is turned on
	var/datum/port/output/turned_on
	///Send a signal when the pump is turned off
	var/datum/port/output/turned_off

	///The component parent object
	var/obj/machinery/atmospherics/components/binary/pump/connected_pump

/obj/item/circuit_component/atmos_pump/populate_ports()
	pressure_value = add_input_port("Новое Давление", PORT_TYPE_NUMBER, trigger = PROC_REF(set_pump_pressure))
	on = add_input_port("Включить", PORT_TYPE_SIGNAL, trigger = PROC_REF(set_pump_on))
	off = add_input_port("Выключить", PORT_TYPE_SIGNAL, trigger = PROC_REF(set_pump_off))
	request_data = add_input_port("Запросить Данные Порта", PORT_TYPE_SIGNAL, trigger = PROC_REF(request_pump_data))

	input_pressure = add_output_port("Входное Давление", PORT_TYPE_NUMBER)
	output_pressure = add_output_port("Выходное Давление", PORT_TYPE_NUMBER)
	input_temperature = add_output_port("Входная Температура", PORT_TYPE_NUMBER)
	output_temperature = add_output_port("Выходная Температура", PORT_TYPE_NUMBER)

	is_active = add_output_port("Активна", PORT_TYPE_NUMBER)
	turned_on = add_output_port("Включена", PORT_TYPE_SIGNAL)
	turned_off = add_output_port("Выключена", PORT_TYPE_SIGNAL)

/obj/item/circuit_component/atmos_pump/register_usb_parent(atom/movable/shell)
	. = ..()
	if(istype(shell, /obj/machinery/atmospherics/components/binary/pump))
		connected_pump = shell
		RegisterSignal(connected_pump, COMSIG_ATMOS_MACHINE_SET_ON, PROC_REF(handle_pump_activation))

/obj/item/circuit_component/atmos_pump/unregister_usb_parent(atom/movable/shell)
	UnregisterSignal(connected_pump, COMSIG_ATMOS_MACHINE_SET_ON)
	connected_pump = null
	return ..()

/obj/item/circuit_component/atmos_pump/pre_input_received(datum/port/input/port)
	pressure_value.set_value(clamp(pressure_value.value, 0, MAX_OUTPUT_PRESSURE))

/obj/item/circuit_component/atmos_pump/proc/handle_pump_activation(datum/source, active)
	SIGNAL_HANDLER
	is_active.set_output(active)
	if(active)
		turned_on.set_output(COMPONENT_SIGNAL)
	else
		turned_off.set_output(COMPONENT_SIGNAL)

/obj/item/circuit_component/atmos_pump/proc/set_pump_pressure()
	CIRCUIT_TRIGGER
	if(!connected_pump)
		return
	connected_pump.target_pressure = pressure_value.value

/obj/item/circuit_component/atmos_pump/proc/set_pump_on()
	CIRCUIT_TRIGGER
	if(!connected_pump)
		return
	connected_pump.set_on(TRUE)

/obj/item/circuit_component/atmos_pump/proc/set_pump_off()
	CIRCUIT_TRIGGER
	if(!connected_pump)
		return
	connected_pump.set_on(FALSE)
	connected_pump.update_appearance(UPDATE_ICON)

/obj/item/circuit_component/atmos_pump/proc/request_pump_data()
	CIRCUIT_TRIGGER
	if(!connected_pump)
		return
	var/datum/gas_mixture/air_input = connected_pump.airs[1]
	var/datum/gas_mixture/air_output = connected_pump.airs[2]
	input_pressure.set_output(air_input.return_pressure())
	output_pressure.set_output(air_output.return_pressure())
	input_temperature.set_output(air_input.return_temperature())
	output_temperature.set_output(air_output.return_temperature())
