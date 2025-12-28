GLOBAL_LIST_INIT(electrolyzer_reactions, electrolyzer_reactions_list())

/*
 * Global proc to build the electrolyzer reactions list
 */
/proc/electrolyzer_reactions_list()
	var/list/built_reaction_list = list()
	for(var/reaction_path in subtypesof(/datum/electrolyzer_reaction))
		var/datum/electrolyzer_reaction/reaction = new reaction_path()

		built_reaction_list[reaction.id] = reaction

	return built_reaction_list

/datum/electrolyzer_reaction
	var/list/requirements
	var/name = "реакция"
	var/id = "r"
	var/desc = ""
	var/list/factor

/**
 * Реакция электролизёра.
 * Аргументы:
 * * air_mixture: Газовая смесь, подвергающаяся электролизу.
 * * working_power: Сколько энергии вложить в электролиз, в единицах электролизёра. Значение 1 соответствует электролизёру 1-го тира.
 * * electrolyzer_args: Дополнительные аргументы для альтернативных методов электролиза.
 */
/datum/electrolyzer_reaction/proc/react(datum/gas_mixture/air_mixture, working_power, list/electrolyzer_args = list())
	return

/**
 * Проверяет, выполнены ли требования для реакции.
 * Аргументы:
 * * air_mixture: Газовая смесь для проверки требований.
 * * electrolyzer_args: Дополнительные аргументы для альтернативных методов электролиза.
 */
/datum/electrolyzer_reaction/proc/reaction_check(datum/gas_mixture/air_mixture, list/electrolyzer_args = list())
	var/temp = air_mixture.temperature
	var/list/cached_gases = air_mixture.gases
	if((requirements["MIN_TEMP"] && temp < requirements["MIN_TEMP"]) || (requirements["MAX_TEMP"] && temp > requirements["MAX_TEMP"]))
		return FALSE
	for(var/id in requirements)
		if (id == "MIN_TEMP" || id == "MAX_TEMP")
			continue
		if(!cached_gases[id] || cached_gases[id][MOLES] < requirements[id])
			return FALSE
	return TRUE

/datum/electrolyzer_reaction/h2o_conversion
	name = "Преобразование H2O"
	id = "h2o_conversion"
	desc = "Преобразование H2O в O2 и H2"
	requirements = list(
		/datum/gas/water_vapor = MINIMUM_MOLE_COUNT
	)
	factor = list(
		/datum/gas/water_vapor = "Потребляется 2 моля H2O",
		/datum/gas/oxygen = "Производится 1 моль O2",
		/datum/gas/hydrogen = "Производится 2 моля H2",
		"Location" = "Может происходить только на тайлах с активным электролизёром.",
	)

/datum/electrolyzer_reaction/h2o_conversion/react(datum/gas_mixture/air_mixture, working_power, list/electrolyzer_args = list())

	var/old_heat_capacity = air_mixture.heat_capacity()
	air_mixture.assert_gases(/datum/gas/water_vapor, /datum/gas/oxygen, /datum/gas/hydrogen)
	var/proportion = min(air_mixture.gases[/datum/gas/water_vapor][MOLES] * INVERSE(2), (2.5 * (working_power ** 2)))
	air_mixture.gases[/datum/gas/water_vapor][MOLES] -= proportion * 2
	air_mixture.gases[/datum/gas/oxygen][MOLES] += proportion
	air_mixture.gases[/datum/gas/hydrogen][MOLES] += proportion * 2
	var/new_heat_capacity = air_mixture.heat_capacity()
	if(new_heat_capacity > MINIMUM_HEAT_CAPACITY)
		air_mixture.temperature = max(air_mixture.temperature * old_heat_capacity / new_heat_capacity, TCMB)

/datum/electrolyzer_reaction/nob_conversion
	name = "Преобразование гиперноблия"
	id = "nob_conversion"
	desc = "Преобразование гиперноблия в антиноблий"
	requirements = list(
		/datum/gas/hypernoblium = MINIMUM_MOLE_COUNT,
	)
	factor = list(
		/datum/gas/hypernoblium = "Потребляется 1 моль гиперноблия",
		/datum/gas/antinoblium = "Производится 1 моль антиноблия",
		"Location" = "Может происходить только на тайлах, поражаемых разрядами суперматерии с уровнем мощности выше 5 ГэВ.",
	)

/datum/electrolyzer_reaction/nob_conversion/reaction_check(datum/gas_mixture/air_mixture, list/electrolyzer_args = list())
	if(!electrolyzer_args[ELECTROLYSIS_ARGUMENT_SUPERMATTER_POWER] || electrolyzer_args[ELECTROLYSIS_ARGUMENT_SUPERMATTER_POWER] <= POWER_PENALTY_THRESHOLD)
		return FALSE
	. = ..()

/datum/electrolyzer_reaction/nob_conversion/react(datum/gas_mixture/air_mixture, working_power, list/electrolyzer_args = list())
	/// Уровень мощности разряда суперматерии.
	var/supermatter_power = electrolyzer_args[ELECTROLYSIS_ARGUMENT_SUPERMATTER_POWER]
	var/list/cached_gases = air_mixture.gases
	var/old_heat_capacity = air_mixture.heat_capacity()
	air_mixture.assert_gases(/datum/gas/hypernoblium, /datum/gas/antinoblium)
	var/list/hypernoblium = cached_gases[/datum/gas/hypernoblium]
	var/list/antinoblium = cached_gases[/datum/gas/antinoblium]
	var/electrolysed = hypernoblium[MOLES] * clamp(supermatter_power - POWER_PENALTY_THRESHOLD, 0, CRITICAL_POWER_PENALTY_THRESHOLD - POWER_PENALTY_THRESHOLD) / (CRITICAL_POWER_PENALTY_THRESHOLD - POWER_PENALTY_THRESHOLD)
	hypernoblium[MOLES] -= electrolysed
	antinoblium[MOLES] += electrolysed
	var/new_heat_capacity = old_heat_capacity + electrolysed * (antinoblium[GAS_META][META_GAS_SPECIFIC_HEAT] - hypernoblium[GAS_META][META_GAS_SPECIFIC_HEAT])
	if(new_heat_capacity > MINIMUM_HEAT_CAPACITY)
		air_mixture.temperature = max(air_mixture.temperature * old_heat_capacity / new_heat_capacity, TCMB)

/datum/electrolyzer_reaction/halon_generation
	name = "Генерация галона"
	id = "halon_generation"
	desc = "Производство галона путём электролиза BZ."
	requirements = list(
		/datum/gas/bz = MINIMUM_MOLE_COUNT,
	)
	factor = list(
		/datum/gas/bz = "Потребляется в процессе реакции.",
		/datum/gas/oxygen = "Производится 0.2 моля кислорода на каждый моль потреблённого BZ.",
		/datum/gas/halon = "Производится 2 моля галона на каждый моль потреблённого BZ.",
		"Energy" = "Выделяется 91.2321 кДж тепловой энергии на каждый моль потреблённого BZ.",
		"Temperature" = "Эффективность реакции пропорциональна температуре.",
		"Location" = "Может происходить только на тайлах с активным электролизёром.",
	)

/datum/electrolyzer_reaction/halon_generation/react(datum/gas_mixture/air_mixture, working_power, list/electrolyzer_args = list())
	var/old_heat_capacity = air_mixture.heat_capacity()
	air_mixture.assert_gases(/datum/gas/bz, /datum/gas/oxygen, /datum/gas/halon)
	var/reaction_efficency = min(air_mixture.gases[/datum/gas/bz][MOLES] * (1 - NUM_E ** (-0.5 * air_mixture.temperature * working_power / FIRE_MINIMUM_TEMPERATURE_TO_EXIST)), air_mixture.gases[/datum/gas/bz][MOLES])
	air_mixture.gases[/datum/gas/bz][MOLES] -= reaction_efficency
	air_mixture.gases[/datum/gas/oxygen][MOLES] += reaction_efficency * 0.2
	air_mixture.gases[/datum/gas/halon][MOLES] += reaction_efficency * 2
	var/energy_used = reaction_efficency * HALON_FORMATION_ENERGY
	var/new_heat_capacity = air_mixture.heat_capacity()
	if(new_heat_capacity > MINIMUM_HEAT_CAPACITY)
		air_mixture.temperature = max(((air_mixture.temperature * old_heat_capacity + energy_used) / new_heat_capacity), TCMB)
