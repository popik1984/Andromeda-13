/*
Это как обычная прямая труба, но её можно включать и выключать.
*/
#define MANUAL_VALVE "m"
#define DIGITAL_VALVE "d"

/obj/machinery/atmospherics/components/binary/valve
	icon_state = "mvalve_map-3"
	name = "manual valve"
	desc = "Труба с вентилем, который можно использовать для перекрытия потока газа."
	can_unwrench = TRUE
	shift_underlay_only = FALSE
	interaction_flags_machine = INTERACT_MACHINE_OFFLINE | INTERACT_MACHINE_OPEN //Намеренно нет флага allow_silicon
	pipe_flags = PIPING_CARDINAL_AUTONORMALIZE | PIPING_BRIDGE
	construction_type = /obj/item/pipe/binary
	pipe_state = "mvalve"
	custom_reconcilation = TRUE
	use_power = NO_POWER_USE
	///Тип вентиля (ручной или цифровой), используется для установки иконки компонента в update_icon_nopipes()
	var/valve_type = MANUAL_VALVE
	///Переменная для блокировки взаимодействий во время анимации открытия/закрытия
	var/switching = FALSE

/obj/machinery/atmospherics/components/binary/valve/get_ru_names()
	return list(
		NOMINATIVE = "ручной вентиль",
		GENITIVE = "ручного вентиля",
		DATIVE = "ручному вентилю",
		ACCUSATIVE = "ручной вентиль",
		INSTRUMENTAL = "ручным вентилем",
		PREPOSITIONAL = "ручном вентиле",
	)

/obj/machinery/atmospherics/components/binary/valve/update_icon_nopipes(animation = FALSE)
	normalize_cardinal_directions()
	if(animation)
		flick("[valve_type]valve_[on][!on]-[set_overlay_offset(piping_layer)]", src)
		playsound(src, 'sound/effects/valve_opening.ogg', 50)
	icon_state = "[valve_type]valve_[on ? "on" : "off"]-[set_overlay_offset(piping_layer)]"

/**
 * Вызывается finish_interact(), переключает между открытым и закрытым состоянием, согласовывает воздух между двумя трубопроводами
 */
/obj/machinery/atmospherics/components/binary/valve/proc/set_open(to_open)
	if(on == to_open)
		return
	SEND_SIGNAL(src, COMSIG_VALVE_SET_OPEN, to_open)
	. = on
	set_on(to_open)
	if(on)
		playsound(src, 'sound/effects/gas_hissing.ogg', 50)
		update_parents()
		var/datum/pipeline/parent1 = parents[1]
		parent1.reconcile_air()
		investigate_log("was opened by [usr ? key_name(usr) : "a remote signal"]", INVESTIGATE_ATMOS)
		balloon_alert_to_viewers("[declent_ru(NOMINATIVE)] открыт", "[declent_ru(NOMINATIVE)] открыт")
		vent_movement |= VENTCRAWL_ALLOWED
	else
		investigate_log("was closed by [usr ? key_name(usr) : "a remote signal"]", INVESTIGATE_ATMOS)
		balloon_alert_to_viewers("[declent_ru(NOMINATIVE)] закрыт", "[declent_ru(NOMINATIVE)] закрыт")
		vent_movement &= ~VENTCRAWL_ALLOWED

// Это обрабатывает фактическую функциональность объединения двух сетей труб, когда вентиль открыт
// По сути, при обновлении сети труб обе стороны будут считаться одинаковыми для целей обновления газа
/obj/machinery/atmospherics/components/binary/valve/return_pipenets_for_reconcilation(datum/pipeline/requester)
	. = ..()
	if(!on)
		return
	. |= parents[1]
	. |= parents[2]

/obj/machinery/atmospherics/components/binary/valve/interact(mob/user)
	add_fingerprint(usr)
	if(switching)
		return
	update_icon_nopipes(TRUE)
	switching = TRUE
	addtimer(CALLBACK(src, PROC_REF(finish_interact)), 1 SECONDS)

/**
 * Вызывается iteract() после таймера в 1 секунду, вызывает toggle(), позволяет следующее взаимодействие с компонентом.
 */
/obj/machinery/atmospherics/components/binary/valve/proc/finish_interact()
	set_open(!on)
	switching = FALSE

/obj/machinery/atmospherics/components/binary/valve/digital // может управляться ИИ
	icon_state = "dvalve_map-3"

	name = "digital valve"
	desc = "Цифровым образом управляемый вентиль."
	valve_type = DIGITAL_VALVE
	pipe_state = "dvalve"

	interaction_flags_machine = INTERACT_MACHINE_ALLOW_SILICON | INTERACT_MACHINE_OFFLINE | INTERACT_MACHINE_OPEN | INTERACT_MACHINE_OPEN_SILICON

/obj/machinery/atmospherics/components/binary/valve/digital/get_ru_names()
	return list(
		NOMINATIVE = "цифровой вентиль",
		GENITIVE = "цифрового вентиля",
		DATIVE = "цифровому вентилю",
		ACCUSATIVE = "цифровой вентиль",
		INSTRUMENTAL = "цифровым вентилем",
		PREPOSITIONAL = "цифровом вентиле",
	)

/obj/machinery/atmospherics/components/binary/valve/digital/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/usb_port, typecacheof(list(/obj/item/circuit_component/digital_valve), only_root_path = TRUE))

/obj/item/circuit_component/digital_valve
	display_name = "Digital Valve"
	desc = "Интерфейс для связи с цифровым вентилем."

	var/obj/machinery/atmospherics/components/binary/valve/digital/attached_valve

	/// Открывает цифровой вентиль
	var/datum/port/input/open
	/// Закрывает цифровой вентиль
	var/datum/port/input/close

	/// Открыт ли вентиль в данный момент
	var/datum/port/output/is_open
	/// Отправляется при открытии вентиля
	var/datum/port/output/opened
	/// Отправляется при закрытии вентиля
	var/datum/port/output/closed

/obj/item/circuit_component/digital_valve/populate_ports()
	open = add_input_port("Open", PORT_TYPE_SIGNAL)
	close = add_input_port("Close", PORT_TYPE_SIGNAL)

	is_open = add_output_port("Is Open", PORT_TYPE_NUMBER)
	opened = add_output_port("Opened", PORT_TYPE_SIGNAL)
	closed = add_output_port("Closed", PORT_TYPE_SIGNAL)

/obj/item/circuit_component/digital_valve/register_usb_parent(atom/movable/shell)
	. = ..()
	if(istype(shell, /obj/machinery/atmospherics/components/binary/valve/digital))
		attached_valve = shell
		RegisterSignal(attached_valve, COMSIG_VALVE_SET_OPEN, PROC_REF(handle_valve_toggled))

/obj/item/circuit_component/digital_valve/unregister_usb_parent(atom/movable/shell)
	UnregisterSignal(attached_valve, COMSIG_VALVE_SET_OPEN)
	attached_valve = null
	return ..()

/obj/item/circuit_component/digital_valve/proc/handle_valve_toggled(datum/source, on)
	SIGNAL_HANDLER
	is_open.set_output(on)
	if(on)
		opened.set_output(COMPONENT_SIGNAL)
	else
		closed.set_output(COMPONENT_SIGNAL)

/obj/item/circuit_component/digital_valve/input_received(datum/port/input/port)

	if(!attached_valve)
		return

	if(COMPONENT_TRIGGERED_BY(open, port) && !attached_valve.on)
		attached_valve.set_open(TRUE)
	if(COMPONENT_TRIGGERED_BY(close, port) && attached_valve.on)
		attached_valve.set_open(FALSE)

/obj/machinery/atmospherics/components/binary/valve/digital/update_icon_nopipes(animation)
	if(!is_operational)
		normalize_cardinal_directions()
		icon_state = "dvalve_nopower-[set_overlay_offset(piping_layer)]"
		return
	return..()

/obj/machinery/atmospherics/components/binary/valve/layer2
	piping_layer = 2
	icon_state = "mvalve_map-2"

/obj/machinery/atmospherics/components/binary/valve/layer4
	piping_layer = 4
	icon_state = "mvalve_map-4"

/obj/machinery/atmospherics/components/binary/valve/on
	on = TRUE

/obj/machinery/atmospherics/components/binary/valve/on/layer2
	piping_layer = 2
	icon_state = "mvalve_map-2"

/obj/machinery/atmospherics/components/binary/valve/on/layer4
	piping_layer = 4
	icon_state = "mvalve_map-4"

/obj/machinery/atmospherics/components/binary/valve/digital/layer2
	piping_layer = 2
	icon_state = "dvalve_map-2"

/obj/machinery/atmospherics/components/binary/valve/digital/layer4
	piping_layer = 4
	icon_state = "dvalve_map-4"

/obj/machinery/atmospherics/components/binary/valve/digital/on
	on = TRUE

/obj/machinery/atmospherics/components/binary/valve/digital/on/layer2
	piping_layer = 2
	icon_state = "dvalve_map-2"

/obj/machinery/atmospherics/components/binary/valve/digital/on/layer4
	piping_layer = 4
	icon_state = "dvalve_map-4"

#undef MANUAL_VALVE
#undef DIGITAL_VALVE
