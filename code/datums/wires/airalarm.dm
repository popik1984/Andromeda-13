/datum/wires/airalarm
	holder_type = /obj/machinery/airalarm
	proper_name = "Контроллер атмосферы"

/datum/wires/airalarm/New(atom/holder)
	wires = list(
		WIRE_POWER,
		WIRE_IDSCAN, WIRE_AI,
		WIRE_PANIC, WIRE_ALARM,
		WIRE_SPEAKER
	)
	add_duds(3)
	..()

/datum/wires/airalarm/interactable(mob/user)
	if(!..())
		return FALSE
	var/obj/machinery/airalarm/A = holder
	if(A.panel_open && A.buildstage == 2)
		return TRUE

/datum/wires/airalarm/get_status()
	var/obj/machinery/airalarm/A = holder
	var/list/status = list()
	status += "Индикатор интерфейса [A.locked ? "красный" : "зелёный"]."
	status += "Индикатор короткого замыкания [A.shorted ? "горит" : "не горит"]."
	status += "Индикатор подключения ИИ [!A.aidisabled ? "горит" : "не горит"]."
	return status

/datum/wires/airalarm/on_pulse(wire)
	var/obj/machinery/airalarm/A = holder
	switch(wire)
		if(WIRE_POWER) // Короткое замыкание на долгое время.
			if(!A.shorted)
				A.shorted = TRUE
				A.update_appearance()
			addtimer(CALLBACK(A, TYPE_PROC_REF(/obj/machinery/airalarm, reset), wire), 2 MINUTES)
		if(WIRE_IDSCAN) // Переключить блокировку.
			A.locked = !A.locked
		if(WIRE_AI) // Отключить управление ИИ на некоторое время.
			if(!A.aidisabled)
				A.aidisabled = TRUE
			addtimer(CALLBACK(A, TYPE_PROC_REF(/obj/machinery/airalarm, reset), wire), 10 SECONDS)
		if(WIRE_PANIC) // Переключить аварийный сифон.
			if(!A.shorted)
				if(istype(A.selected_mode, /datum/air_alarm_mode/filtering))
					A.select_mode(usr, /datum/air_alarm_mode/panic_siphon)
				else
					A.select_mode(usr, /datum/air_alarm_mode/filtering)
		if(WIRE_ALARM) // Сбросить тревоги.
			if(A.alarm_manager.clear_alarm(ALARM_ATMOS))
				A.danger_level = AIR_ALARM_ALERT_NONE
			A.update_appearance()

/datum/wires/airalarm/on_cut(wire, mend, source)
	var/obj/machinery/airalarm/A = holder
	switch(wire)
		if(WIRE_POWER) // Короткое замыкание навсегда.
			A.shock(usr, 50)
			A.shorted = !mend
			A.update_appearance()
		if(WIRE_IDSCAN)
			if(!mend)
				A.locked = TRUE
		if(WIRE_AI)
			A.aidisabled = mend // Включить/отключить управление ИИ.
		if(WIRE_PANIC) // Принудительно включить аварийный сифон.
			if(!mend && !A.shorted)
				A.select_mode(usr, /datum/air_alarm_mode/panic_siphon)
		if(WIRE_ALARM) // Активировать тревогу.
			if(A.alarm_manager.send_alarm(ALARM_ATMOS))
				A.danger_level = AIR_ALARM_ALERT_HAZARD
			A.update_appearance()
		if(WIRE_SPEAKER)
			A.speaker_enabled = mend

/datum/wires/airalarm/can_reveal_wires(mob/user)
	if(HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES))
		return TRUE

	return ..()
