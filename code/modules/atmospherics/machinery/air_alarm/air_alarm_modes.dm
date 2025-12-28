/// Ключи - пути [/datum/air_alarm_mode]
/// Значения - их соответствующие экземпляры.
GLOBAL_LIST_INIT(air_alarm_modes, init_air_alarm_modes())

/proc/init_air_alarm_modes()
	var/list/ret = list()
	for(var/mode_path in subtypesof(/datum/air_alarm_mode))
		ret[mode_path] = new mode_path
	return ret

/// Различные режимы, которые может принимать [/obj/machinery/airalarm].
/datum/air_alarm_mode
	/// Название режима.
	var/name
	/// Подробное описание режима.
	var/desc
	/// TRUE, если этот режим может быть опасным при выборе.
	var/danger
	/// TRUE, если воздушная тревога должна быть взломана эмагом для выбора этого режима.
	var/emag = FALSE

/** Процедура, которая выполняется при выборе этого режима воздушной тревоги.
 *
 * Аргументы:
 * * applied - зона, к которой будет применён этот режим.
 */
/datum/air_alarm_mode/proc/apply(area/applied)
	return

/datum/air_alarm_mode/proc/replace(area/applied, pressure)
	return

/// Режим по умолчанию.
/datum/air_alarm_mode/filtering
	name = "Filtering"
	desc = "Очищает от загрязнений"
	danger = FALSE

/datum/air_alarm_mode/filtering/apply(area/applied)
	for (var/obj/machinery/atmospherics/components/unary/vent_pump/vent as anything in applied.air_vents)
		vent.on = TRUE
		vent.pressure_checks = ATMOS_EXTERNAL_BOUND
		vent.external_pressure_bound = ONE_ATMOSPHERE
		vent.pump_direction = ATMOS_DIRECTION_RELEASING
		vent.update_appearance(UPDATE_ICON)

	for (var/obj/machinery/atmospherics/components/unary/vent_scrubber/scrubber as anything in applied.air_scrubbers)
		scrubber.on = TRUE
		scrubber.filter_types = list(/datum/gas/carbon_dioxide)
		scrubber.set_scrubbing(ATMOS_DIRECTION_SCRUBBING)
		scrubber.set_widenet(FALSE)

/datum/air_alarm_mode/contaminated
	name = "Contaminated"
	desc = "Быстро очищает от ВСЕХ загрязнений"
	danger = FALSE

/datum/air_alarm_mode/contaminated/apply(area/applied)
	for (var/obj/machinery/atmospherics/components/unary/vent_pump/vent as anything in applied.air_vents)
		vent.on = TRUE
		vent.pressure_checks = ATMOS_EXTERNAL_BOUND
		vent.external_pressure_bound = ONE_ATMOSPHERE
		vent.pump_direction = ATMOS_DIRECTION_RELEASING
		vent.update_appearance(UPDATE_ICON)

	var/list/filtered = subtypesof(/datum/gas)
	filtered -= list(/datum/gas/oxygen, /datum/gas/nitrogen, /datum/gas/pluoxium)
	for (var/obj/machinery/atmospherics/components/unary/vent_scrubber/scrubber as anything in applied.air_scrubbers)
		scrubber.on = TRUE
		scrubber.filter_types = filtered.Copy()
		scrubber.set_scrubbing(ATMOS_DIRECTION_SCRUBBING)
		scrubber.set_widenet(TRUE)

/datum/air_alarm_mode/draught
	name = "Draught"
	desc = "Откачивает воздух с одновременной заменой"
	danger = FALSE

/datum/air_alarm_mode/draught/apply(area/applied)
	for (var/obj/machinery/atmospherics/components/unary/vent_pump/vent as anything in applied.air_vents)
		vent.on = TRUE
		vent.pressure_checks = ATMOS_EXTERNAL_BOUND
		vent.external_pressure_bound = ONE_ATMOSPHERE * 2
		vent.pump_direction = ATMOS_DIRECTION_RELEASING
		vent.update_appearance(UPDATE_ICON)

	for (var/obj/machinery/atmospherics/components/unary/vent_scrubber/scrubber as anything in applied.air_scrubbers)
		scrubber.on = TRUE
		scrubber.set_widenet(FALSE)
		scrubber.set_scrubbing(ATMOS_DIRECTION_SIPHONING)

/datum/air_alarm_mode/refill
	name = "Refill"
	desc = "Утроенная производительность вентилей"
	danger = TRUE

/datum/air_alarm_mode/refill/apply(area/applied)
	for (var/obj/machinery/atmospherics/components/unary/vent_pump/vent as anything in applied.air_vents)
		vent.on = TRUE
		vent.pressure_checks = ATMOS_EXTERNAL_BOUND
		vent.external_pressure_bound = ONE_ATMOSPHERE * 3
		vent.pump_direction = ATMOS_DIRECTION_RELEASING
		vent.update_appearance(UPDATE_ICON)

	for (var/obj/machinery/atmospherics/components/unary/vent_scrubber/scrubber as anything in applied.air_scrubbers)
		scrubber.on = TRUE

		scrubber.filter_types = list(/datum/gas/carbon_dioxide)
		scrubber.set_widenet(FALSE)
		scrubber.set_scrubbing(ATMOS_DIRECTION_SCRUBBING)

/datum/air_alarm_mode/cycle
	name = "Cycle"
	desc = "Откачивает воздух перед заменой"
	danger = TRUE

/// То же самое, что и [/datum/air_alarm_mode/siphon/apply]
/datum/air_alarm_mode/cycle/apply(area/applied)
	for (var/obj/machinery/atmospherics/components/unary/vent_pump/vent as anything in applied.air_vents)
		vent.on = FALSE
		vent.update_appearance(UPDATE_ICON)

	for (var/obj/machinery/atmospherics/components/unary/vent_scrubber/scrubber as anything in applied.air_scrubbers)
		scrubber.on = TRUE
		scrubber.set_widenet(TRUE)
		scrubber.set_scrubbing(ATMOS_DIRECTION_SIPHONING)

/// Особый случай для циклического режима. Цикл должен снова наполнить воздухом после очистки, поэтому вызывается эта процедура.
/// То же самое, что и [/datum/air_alarm_mode/filtering/apply]
/datum/air_alarm_mode/cycle/replace(area/applied, pressure)
	if(pressure >= ONE_ATMOSPHERE * 0.05)
		return

	for (var/obj/machinery/atmospherics/components/unary/vent_pump/vent as anything in applied.air_vents)
		vent.on = TRUE
		vent.pressure_checks = ATMOS_EXTERNAL_BOUND
		vent.external_pressure_bound = ONE_ATMOSPHERE
		vent.pump_direction = ATMOS_DIRECTION_RELEASING
		vent.update_appearance(UPDATE_ICON)

	for (var/obj/machinery/atmospherics/components/unary/vent_scrubber/scrubber as anything in applied.air_scrubbers)
		scrubber.on = TRUE
		scrubber.filter_types = list(/datum/gas/carbon_dioxide)
		scrubber.set_scrubbing(ATMOS_DIRECTION_SCRUBBING)
		scrubber.set_widenet(FALSE)

/datum/air_alarm_mode/siphon
	name = "Siphon"
	desc = "Откачивает воздух из помещения"
	danger = TRUE

/datum/air_alarm_mode/siphon/apply(area/applied)
	for (var/obj/machinery/atmospherics/components/unary/vent_pump/vent as anything in applied.air_vents)
		vent.on = FALSE
		vent.update_appearance(UPDATE_ICON)

	for (var/obj/machinery/atmospherics/components/unary/vent_scrubber/scrubber as anything in applied.air_scrubbers)
		scrubber.on = TRUE
		scrubber.set_widenet(FALSE)
		scrubber.set_scrubbing(ATMOS_DIRECTION_SIPHONING)

/datum/air_alarm_mode/panic_siphon
	name = "Panic Siphon"
	desc = "Быстро откачивает воздух из помещения"
	danger = TRUE

/datum/air_alarm_mode/panic_siphon/apply(area/applied)
	for (var/obj/machinery/atmospherics/components/unary/vent_pump/vent as anything in applied.air_vents)
		vent.on = FALSE
		vent.update_appearance(UPDATE_ICON)

	for (var/obj/machinery/atmospherics/components/unary/vent_scrubber/scrubber as anything in applied.air_scrubbers)
		scrubber.on = TRUE
		scrubber.set_widenet(TRUE)
		scrubber.set_scrubbing(ATMOS_DIRECTION_SIPHONING)

/datum/air_alarm_mode/off
	name = "Off"
	desc = "Отключает вентили и скрубберы"
	danger = FALSE

/datum/air_alarm_mode/off/apply(area/applied)
	for (var/obj/machinery/atmospherics/components/unary/vent_pump/vent as anything in applied.air_vents)
		vent.on = FALSE
		vent.update_appearance(UPDATE_ICON)

	for (var/obj/machinery/atmospherics/components/unary/vent_scrubber/scrubber as anything in applied.air_scrubbers)
		scrubber.on = FALSE
		scrubber.update_appearance(UPDATE_ICON)

/datum/air_alarm_mode/flood
	name = "Flood"
	desc = "Отключает скрубберы и открывает вентили"
	danger = TRUE
	emag = TRUE

/datum/air_alarm_mode/flood/apply(area/applied)
	for (var/obj/machinery/atmospherics/components/unary/vent_pump/vent as anything in applied.air_vents)
		vent.on = TRUE
		vent.pressure_checks = ATMOS_INTERNAL_BOUND
		vent.internal_pressure_bound = 0
		vent.pump_direction = ATMOS_DIRECTION_RELEASING
		vent.update_appearance(UPDATE_ICON)

	for (var/obj/machinery/atmospherics/components/unary/vent_scrubber/scrubber as anything in applied.air_scrubbers)
		scrubber.on = FALSE
		scrubber.update_appearance(UPDATE_ICON)

/datum/air_alarm_mode/vent_siphon
	name = "Vent siphon"
	desc = "Отключает скрубберы и переводит вентили в режим откачки"
	danger = TRUE
	emag = TRUE // откачка через вентили может серьёзно нарушить работу распределительной сети, даже несмотря на высокую скорость

/datum/air_alarm_mode/vent_siphon/apply(area/applied)
	for (var/obj/machinery/atmospherics/components/unary/vent_pump/vent as anything in applied.air_vents)
		vent.on = TRUE
		vent.pressure_checks = NONE
		vent.internal_pressure_bound = 0
		vent.external_pressure_bound = 0
		vent.pump_direction = ATMOS_DIRECTION_SIPHONING
		vent.update_appearance(UPDATE_ICON)

	for (var/obj/machinery/atmospherics/components/unary/vent_scrubber/scrubber as anything in applied.air_scrubbers)
		scrubber.on = FALSE
		scrubber.update_appearance(UPDATE_ICON)
