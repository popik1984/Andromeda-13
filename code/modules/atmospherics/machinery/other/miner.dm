
#define GASMINER_POWER_NONE 0
#define GASMINER_POWER_STATIC 1
#define GASMINER_POWER_MOLES 2 //Scaled from here on down.
#define GASMINER_POWER_KPA 3
#define GASMINER_POWER_FULLSCALE 4

/obj/machinery/atmospherics/miner
	name = "gas miner"
	desc = "Газы, добытые из газового гиганта, выходят через эту массивную вентиляцию."
	icon = 'icons/obj/machines/atmospherics/miners.dmi'
	icon_state = "miner"
	density = FALSE
	resistance_flags = INDESTRUCTIBLE|ACID_PROOF|FIRE_PROOF
	idle_power_usage = BASE_MACHINE_IDLE_CONSUMPTION * 1.5
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 1.25
	initialize_directions = NONE
	var/spawn_id = null
	var/spawn_temp = T20C
	/// Moles of gas to spawn per second
	var/spawn_mol = MOLES_CELLSTANDARD * 5
	var/max_ext_mol = INFINITY
	var/max_ext_kpa = 6500
	var/overlay_color = COLOR_WHITE
	var/active = TRUE
	var/power_draw = 0
	var/power_draw_static = 2000
	var/power_draw_dynamic_mol_coeff = 5 //DO NOT USE DYNAMIC SETTINGS UNTIL SOMEONE MAKES A USER INTERFACE/CONTROLLER FOR THIS!
	var/power_draw_dynamic_kpa_coeff = 0.5
	var/broken = FALSE
	var/broken_message = "ОШИБКА"

/obj/machinery/atmospherics/miner/get_ru_names()
	return alist(
		NOMINATIVE = "добытчик газа",
		GENITIVE = "добытчика газа",
		DATIVE = "добытчику газа",
		ACCUSATIVE = "добытчик газа",
		INSTRUMENTAL = "добытчиком газа",
		PREPOSITIONAL = "добытчике газа",
	)

/obj/machinery/atmospherics/miner/Initialize(mapload)
	. = ..()
	set_active(active) //Force overlay update.

/obj/machinery/atmospherics/miner/examine(mob/user)
	. = ..()
	if(broken)
		. += "Вывод отладочной информации: \"[broken_message]\"."

/obj/machinery/atmospherics/miner/proc/check_operation()
	if(!active)
		return FALSE
	var/turf/T = get_turf(src)
	if(!isopenturf(T))
		broken_message = span_boldnotice("ВЕНТИЛЯЦИЯ ЗАБЛОКИРОВАНА")
		set_broken(TRUE)
		return FALSE
	var/turf/open/OT = T
	if(OT.planetary_atmos)
		broken_message = span_boldwarning("УСТРОЙСТВО НЕ В ГЕРМЕТИЧНОМ ОКРУЖЕНИИ")
		set_broken(TRUE)
		return FALSE
	if(isspaceturf(T))
		broken_message = span_boldnotice("ВЫБРОС ВОЗДУХА В КОСМОС")
		set_broken(TRUE)
		return FALSE
	var/datum/gas_mixture/G = OT.return_air()
	if(G.return_pressure() > (max_ext_kpa - ((spawn_mol*spawn_temp*R_IDEAL_GAS_EQUATION)/(CELL_VOLUME))))
		broken_message = span_boldwarning("ВНЕШНЕЕ ДАВЛЕНИЕ ВЫШЕ ПОРОГА")
		set_broken(TRUE)
		return FALSE
	if(G.total_moles() > max_ext_mol)
		broken_message = span_boldwarning("КОНЦЕНТРАЦИЯ ВНЕШНЕГО ВОЗДУХА ВЫШЕ ПОРОГА")
		set_broken(TRUE)
		return FALSE
	if(broken)
		set_broken(FALSE)
		broken_message = ""
	return TRUE

/obj/machinery/atmospherics/miner/proc/set_active(setting)
	if(active != setting)
		active = setting
		update_appearance()

/obj/machinery/atmospherics/miner/proc/set_broken(setting)
	if(broken != setting)
		broken = setting
		update_appearance()

/obj/machinery/atmospherics/miner/proc/update_power()
	if(!active)
		active_power_usage = idle_power_usage
	var/turf/T = get_turf(src)
	var/datum/gas_mixture/G = T.return_air()
	var/P = G.return_pressure()
	switch(power_draw)
		if(GASMINER_POWER_NONE)
			update_use_power(ACTIVE_POWER_USE, 0)
		if(GASMINER_POWER_STATIC)
			update_use_power(ACTIVE_POWER_USE, power_draw_static)
		if(GASMINER_POWER_MOLES)
			update_use_power(ACTIVE_POWER_USE, spawn_mol * power_draw_dynamic_mol_coeff)
		if(GASMINER_POWER_KPA)
			update_use_power(ACTIVE_POWER_USE, P * power_draw_dynamic_kpa_coeff)
		if(GASMINER_POWER_FULLSCALE)
			update_use_power(ACTIVE_POWER_USE, (spawn_mol * power_draw_dynamic_mol_coeff) + (P * power_draw_dynamic_kpa_coeff))

/obj/machinery/atmospherics/miner/proc/do_use_energy(amount)
	var/turf/T = get_turf(src)
	if(T && istype(T))
		var/obj/structure/cable/C = T.get_cable_node() //check if we have a node cable on the machine turf, the first found is picked
		if(C && C.powernet && (C.powernet.avail > amount))
			C.powernet.load += amount
			return TRUE
	if(powered())
		use_energy(amount)
		return TRUE
	return FALSE

/obj/machinery/atmospherics/miner/update_overlays()
	. = ..()
	if(broken)
		. += "broken"
		return

	if(active)
		var/mutable_appearance/on_overlay = mutable_appearance(icon, "on")
		on_overlay.color = overlay_color
		. += on_overlay

/obj/machinery/atmospherics/miner/process(seconds_per_tick)
	update_power()
	check_operation()
	if(active && !broken)
		if(isnull(spawn_id))
			return FALSE
		if(do_use_energy(active_power_usage))
			mine_gas(seconds_per_tick)

/obj/machinery/atmospherics/miner/proc/mine_gas(seconds_per_tick = 2)
	var/turf/open/O = get_turf(src)
	if(!isopenturf(O))
		return FALSE
	var/datum/gas_mixture/merger = new
	merger.assert_gas(spawn_id)
	merger.gases[spawn_id][MOLES] = spawn_mol * seconds_per_tick
	merger.temperature = spawn_temp
	O.assume_air(merger)

/obj/machinery/atmospherics/miner/attack_ai(mob/living/silicon/user)
	if(broken)
		to_chat(user, "[RU_SRC_NOM] кажется сломанным. Его отладочный интерфейс выводит: [broken_message]")
	..()

/obj/machinery/atmospherics/miner/n2o
	name = "\improper N2O Gas Miner"
	overlay_color = "#FFCCCC"
	spawn_id = /datum/gas/nitrous_oxide

/obj/machinery/atmospherics/miner/n2o/get_ru_names()
	return alist(
		NOMINATIVE = "добытчик оксида азота",
		GENITIVE = "добытчика оксида азота",
		DATIVE = "добытчику оксида азота",
		ACCUSATIVE = "добытчик оксида азота",
		INSTRUMENTAL = "добытчиком оксида азота",
		PREPOSITIONAL = "добытчике оксида азота",
	)

/obj/machinery/atmospherics/miner/nitrogen
	name = "\improper N2 Gas Miner"
	overlay_color = "#CCFFCC"
	spawn_id = /datum/gas/nitrogen

/obj/machinery/atmospherics/miner/nitrogen/get_ru_names()
	return alist(
		NOMINATIVE = "добытчик азота",
		GENITIVE = "добытчика азота",
		DATIVE = "добытчику азота",
		ACCUSATIVE = "добытчик азота",
		INSTRUMENTAL = "добытчиком азота",
		PREPOSITIONAL = "добытчике азота",
	)

/obj/machinery/atmospherics/miner/oxygen
	name = "\improper O2 Gas Miner"
	overlay_color = "#007FFF"
	spawn_id = /datum/gas/oxygen

/obj/machinery/atmospherics/miner/oxygen/get_ru_names()
	return alist(
		NOMINATIVE = "добытчик кислорода",
		GENITIVE = "добытчика кислорода",
		DATIVE = "добытчику кислорода",
		ACCUSATIVE = "добытчик кислорода",
		INSTRUMENTAL = "добытчиком кислорода",
		PREPOSITIONAL = "добытчике кислорода",
	)

/obj/machinery/atmospherics/miner/plasma
	name = "\improper Plasma Gas Miner"
	overlay_color = COLOR_RED
	spawn_id = /datum/gas/plasma

/obj/machinery/atmospherics/miner/plasma/get_ru_names()
	return alist(
		NOMINATIVE = "добытчик плазмы",
		GENITIVE = "добытчика плазмы",
		DATIVE = "добытчику плазмы",
		ACCUSATIVE = "добытчик плазмы",
		INSTRUMENTAL = "добытчиком плазмы",
		PREPOSITIONAL = "добытчике плазмы",
	)

/obj/machinery/atmospherics/miner/carbon_dioxide
	name = "\improper CO2 Gas Miner"
	overlay_color = "#CDCDCD"
	spawn_id = /datum/gas/carbon_dioxide

/obj/machinery/atmospherics/miner/carbon_dioxide/get_ru_names()
	return alist(
		NOMINATIVE = "добытчик диоксида углерода",
		GENITIVE = "добытчика диоксида углерода",
		DATIVE = "добытчику диоксида углерода",
		ACCUSATIVE = "добытчик диоксида углерода",
		INSTRUMENTAL = "добытчиком диоксида углерода",
		PREPOSITIONAL = "добытчике диоксида углерода",
	)

/obj/machinery/atmospherics/miner/bz
	name = "\improper BZ Gas Miner"
	overlay_color = "#FAFF00"
	spawn_id = /datum/gas/bz

/obj/machinery/atmospherics/miner/bz/get_ru_names()
	return alist(
		NOMINATIVE = "добытчик BZ",
		GENITIVE = "добытчика BZ",
		DATIVE = "добытчику BZ",
		ACCUSATIVE = "добытчик BZ",
		INSTRUMENTAL = "добытчиком BZ",
		PREPOSITIONAL = "добытчике BZ",
	)

/obj/machinery/atmospherics/miner/water_vapor
	name = "\improper Water Vapor Gas Miner"
	overlay_color = "#99928E"
	spawn_id = /datum/gas/water_vapor

/obj/machinery/atmospherics/miner/water_vapor/get_ru_names()
	return alist(
		NOMINATIVE = "добытчик водяного пара",
		GENITIVE = "добытчика водяного пара",
		DATIVE = "добытчику водяного пара",
		ACCUSATIVE = "добытчик водяного пара",
		INSTRUMENTAL = "добытчиком водяного пара",
		PREPOSITIONAL = "добытчике водяного пара",
	)

/obj/machinery/atmospherics/miner/freon
	name = "\improper Freon Gas Miner"
	overlay_color = "#61edff"
	spawn_id = /datum/gas/freon

/obj/machinery/atmospherics/miner/freon/get_ru_names()
	return alist(
		NOMINATIVE = "добытчик фреона",
		GENITIVE = "добытчика фреона",
		DATIVE = "добытчику фреона",
		ACCUSATIVE = "добытчик фреона",
		INSTRUMENTAL = "добытчиком фреона",
		PREPOSITIONAL = "добытчике фреона",
	)

/obj/machinery/atmospherics/miner/halon
	name = "\improper Halon Gas Miner"
	overlay_color = "#5f0085"
	spawn_id = /datum/gas/halon

/obj/machinery/atmospherics/miner/halon/get_ru_names()
	return alist(
		NOMINATIVE = "добытчик галона",
		GENITIVE = "добытчика галона",
		DATIVE = "добытчику галона",
		ACCUSATIVE = "добытчик галона",
		INSTRUMENTAL = "добытчиком галона",
		PREPOSITIONAL = "добытчике галона",
	)

/obj/machinery/atmospherics/miner/healium
	name = "\improper Healium Gas Miner"
	overlay_color = "#da4646"
	spawn_id = /datum/gas/healium

/obj/machinery/atmospherics/miner/healium/get_ru_names()
	return alist(
		NOMINATIVE = "добытчик хилиума",
		GENITIVE = "добытчика хилиума",
		DATIVE = "добытчику хилиума",
		ACCUSATIVE = "добытчик хилиума",
		INSTRUMENTAL = "добытчиком хилиума",
		PREPOSITIONAL = "добытчике хилиума",
	)

/obj/machinery/atmospherics/miner/hydrogen
	name = "\improper Hydrogen Gas Miner"
	overlay_color = "#ffffff"
	spawn_id = /datum/gas/hydrogen

/obj/machinery/atmospherics/miner/hydrogen/get_ru_names()
	return alist(
		NOMINATIVE = "добытчик водорода",
		GENITIVE = "добытчика водорода",
		DATIVE = "добытчику водорода",
		ACCUSATIVE = "добытчик водорода",
		INSTRUMENTAL = "добытчиком водорода",
		PREPOSITIONAL = "добытчике водорода",
	)

/obj/machinery/atmospherics/miner/hypernoblium
	name = "\improper Hypernoblium Gas Miner"
	overlay_color = "#00f7ff"
	spawn_id = /datum/gas/hypernoblium

/obj/machinery/atmospherics/miner/hypernoblium/get_ru_names()
	return alist(
		NOMINATIVE = "добытчик гиперноблия",
		GENITIVE = "добытчика гиперноблия",
		DATIVE = "добытчику гиперноблия",
		ACCUSATIVE = "добытчик гиперноблия",
		INSTRUMENTAL = "добытчиком гиперноблия",
		PREPOSITIONAL = "добытчике гиперноблия",
	)

/obj/machinery/atmospherics/miner/miasma
	name = "\improper Miasma Gas Miner"
	overlay_color = "#395806"
	spawn_id = /datum/gas/miasma

/obj/machinery/atmospherics/miner/miasma/get_ru_names()
	return alist(
		NOMINATIVE = "добытчик миазмов",
		GENITIVE = "добытчика миазмов",
		DATIVE = "добытчику миазмов",
		ACCUSATIVE = "добытчик миазмов",
		INSTRUMENTAL = "добытчиком миазмов",
		PREPOSITIONAL = "добытчике миазмов",
	)

/obj/machinery/atmospherics/miner/nitrium
	name = "\improper Nitrium Gas Miner"
	overlay_color = "#752b00"
	spawn_id = /datum/gas/nitrium

/obj/machinery/atmospherics/miner/nitrium/get_ru_names()
	return alist(
		NOMINATIVE = "добытчик нитриума",
		GENITIVE = "добытчика нитриума",
		DATIVE = "добытчику нитриума",
		ACCUSATIVE = "добытчик нитриума",
		INSTRUMENTAL = "добытчиком нитриума",
		PREPOSITIONAL = "добытчике нитриума",
	)

/obj/machinery/atmospherics/miner/pluoxium
	name = "\improper Pluoxium Gas Miner"
	overlay_color = "#4b54a3"
	spawn_id = /datum/gas/pluoxium

/obj/machinery/atmospherics/miner/pluoxium/get_ru_names()
	return alist(
		NOMINATIVE = "добытчик плюоксиума",
		GENITIVE = "добытчика плюоксиума",
		DATIVE = "добытчику плюоксиума",
		ACCUSATIVE = "добытчик плюоксиума",
		INSTRUMENTAL = "добытчиком плюоксиума",
		PREPOSITIONAL = "добытчике плюоксиума",
	)

/obj/machinery/atmospherics/miner/proto_nitrate
	name = "\improper Proto-Nitrate Gas Miner"
	overlay_color = "#00571d"
	spawn_id = /datum/gas/proto_nitrate

/obj/machinery/atmospherics/miner/proto_nitrate/get_ru_names()
	return alist(
		NOMINATIVE = "добытчик протонитрата",
		GENITIVE = "добытчика протонитрата",
		DATIVE = "добытчику протонитрата",
		ACCUSATIVE = "добытчик протонитрата",
		INSTRUMENTAL = "добытчиком протонитрата",
		PREPOSITIONAL = "добытчике протонитрата",
	)

/obj/machinery/atmospherics/miner/tritium
	name = "\improper Tritium Gas Miner"
	overlay_color = "#15ff00"
	spawn_id = /datum/gas/tritium

/obj/machinery/atmospherics/miner/tritium/get_ru_names()
	return alist(
		NOMINATIVE = "добытчик трития",
		GENITIVE = "добытчика трития",
		DATIVE = "добытчику трития",
		ACCUSATIVE = "добытчик трития",
		INSTRUMENTAL = "добытчиком трития",
		PREPOSITIONAL = "добытчике трития",
	)

/obj/machinery/atmospherics/miner/zauker
	name = "\improper Zauker Gas Miner"
	overlay_color = "#022e00"
	spawn_id = /datum/gas/zauker

/obj/machinery/atmospherics/miner/zauker/get_ru_names()
	return alist(
		NOMINATIVE = "добытчик заукера",
		GENITIVE = "добытчика заукера",
		DATIVE = "добытчику заукера",
		ACCUSATIVE = "добытчик заукера",
		INSTRUMENTAL = "добытчиком заукера",
		PREPOSITIONAL = "добытчике заукера",
	)

/obj/machinery/atmospherics/miner/helium
	name = "\improper Helium Gas Miner"
	overlay_color = "#022e00"
	spawn_id = /datum/gas/helium

/obj/machinery/atmospherics/miner/helium/get_ru_names()
	return alist(
		NOMINATIVE = "добытчик гелия",
		GENITIVE = "добытчика гелия",
		DATIVE = "добытчику гелия",
		ACCUSATIVE = "добытчик гелия",
		INSTRUMENTAL = "добытчиком гелия",
		PREPOSITIONAL = "добытчике гелия",
	)

/obj/machinery/atmospherics/miner/antinoblium
	name = "\improper Antinoblium Gas Miner"
	overlay_color = "#022e00"
	spawn_id = /datum/gas/antinoblium

/obj/machinery/atmospherics/miner/antinoblium/get_ru_names()
	return alist(
		NOMINATIVE = "добытчик антиноблия",
		GENITIVE = "добытчика антиноблия",
		DATIVE = "добытчику антиноблия",
		ACCUSATIVE = "добытчик антиноблия",
		INSTRUMENTAL = "добытчиком антиноблия",
		PREPOSITIONAL = "добытчике антиноблия",
	)

#undef GASMINER_POWER_NONE
#undef GASMINER_POWER_STATIC
#undef GASMINER_POWER_MOLES
#undef GASMINER_POWER_KPA
#undef GASMINER_POWER_FULLSCALE
