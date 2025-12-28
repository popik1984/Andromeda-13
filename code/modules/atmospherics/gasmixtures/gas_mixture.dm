/*
Для чего нужны архивированные переменные?
Расчёты выполняются с использованием архивированных переменных, а результаты объединяются в обычные переменные.
Это предотвращает состояние гонки, возникающее из-за порядка обработки тайлов.
*/

GLOBAL_LIST_INIT(meta_gas_info, meta_gas_list()) //см. ATMOSPHERICS/gas_types.dm
GLOBAL_LIST_INIT(gaslist_cache, init_gaslist_cache())

/proc/init_gaslist_cache()
	var/list/gases = list()
	for(var/id in GLOB.meta_gas_info)
		var/list/cached_gas = new(3)

		gases[id] = cached_gas

		cached_gas[MOLES] = 0
		cached_gas[ARCHIVE] = 0
		cached_gas[GAS_META] = GLOB.meta_gas_info[id]
	return gases

/datum/gas_mixture
	var/list/gases
	/// Температура газовой смеси в кельвинах. Никогда не должна быть ниже TCMB
	var/temperature = TCMB
	/// Используется, как и все архивированные переменные, для обеспечения согласованности обмена тайлов внутри тика,
	/// независимо от порядка операций
	var/tmp/temperature_archived = TCMB
	/// Объём в литрах (да-да)
	var/volume = CELL_VOLUME
	/// Последний тик, на котором эта газовая смесь делилась. Счётчик, который тайлы используют для управления активностью
	var/last_share = 0
	/// Показывает нам, какие реакции произошли в нашей газовой смеси. Ассоциативный список реакция - количество прореагировавших молей.
	var/list/reaction_results
	/// Нужно ли вызывать garbage_collect() на делителе во время обмена, используется для неизменяемых смесей
	var/gc_share = FALSE
	/// Когда эта газовая смесь последний раз была обработана конвейером
	/// Мне жаль
	var/pipeline_cycle = -1

/datum/gas_mixture/New(volume)
	gases = new
	if(!isnull(volume))
		src.volume = volume
	if(src.volume <= 0)
		stack_trace("Создана газовая смесь с нулевым объёмом!")
	reaction_results = new

//listmos procs
//используйте макросы в производительных областях. для их определений см. code/__DEFINES/atmospherics.dm

///assert_gas(gas_id) - используется для гарантии, что список газов для этого id существует в gas_mixture.gases.
///Должен использоваться перед добавлением газа. Может использоваться перед чтением газа.
/datum/gas_mixture/proc/assert_gas(gas_id)
	ASSERT_GAS(gas_id, src)

///assert_gases(args) - сокращение для вызова ASSERT_GAS() один раз для каждого типа газа.
/datum/gas_mixture/proc/assert_gases(...)
	for(var/id in args)
		ASSERT_GAS(id, src)

///add_gas(gas_id) - аналогично assert_gas(), но не проверяет существующий список газов для этого id. Это может перезаписать существующие газы.
///Используется вместо assert_gas(), когда известно, что газа не существует. Быстрее, чем assert_gas().
/datum/gas_mixture/proc/add_gas(gas_id)
	ADD_GAS(gas_id, gases)

///add_gases(args) - сокращение для вызова add_gas() один раз для каждого gas_type.
/datum/gas_mixture/proc/add_gases(...)
	var/cached_gases = gases
	for(var/id in args)
		ADD_GAS(id, cached_gases)

///garbage_collect() - удаляет любой список газов, который пуст.
///Если вызывается со списком в качестве аргумента, удаляет только списки газов с ID из этого списка.
///Должен использоваться после вычитания из газа. Должен использоваться после assert_gas()
///если assert_gas() вызывался только для чтения газа.
///Удаляя пустые газы, увеличивается скорость обработки.
/datum/gas_mixture/proc/garbage_collect(list/tocheck)
	var/list/cached_gases = gases
	for(var/id in (tocheck || cached_gases))
		if(QUANTIZE(cached_gases[id][MOLES]) <= 0)
			cached_gases -= id

//PV = nRT

///джоулей на кельвин
/datum/gas_mixture/proc/heat_capacity(data = MOLES)
	var/list/cached_gases = gases
	. = 0
	for(var/_id, gas_data in cached_gases)
		. += gas_data[data] * gas_data[GAS_META][META_GAS_SPECIFIC_HEAT]

/// То же самое, что и выше, но вакуумы возвращают HEAT_CAPACITY_VACUUM
/datum/gas_mixture/turf/heat_capacity(data = MOLES)
	var/list/cached_gases = gases
	. = 0
	for(var/_id, gas_data in cached_gases)
		. += gas_data[data] * gas_data[GAS_META][META_GAS_SPECIFIC_HEAT]
	if(!.)
		. += HEAT_CAPACITY_VACUUM //мы хотим, чтобы вакуумы в тайлах имели такую же теплоёмкость, как космос

/// Рассчитать количество молей
/datum/gas_mixture/proc/total_moles()
	var/cached_gases = gases
	TOTAL_MOLES(cached_gases, .)

/// Проверяет, существует ли количество газа в смеси.
/// НЕ используйте это в коде, где важна производительность!
/// Лучше группировать вызовы garbage_collect(), особенно в местах, где проверяется много типов газов
/datum/gas_mixture/proc/has_gas(gas_id, amount=0)
	ASSERT_GAS(gas_id, src)
	var/is_there_gas = amount < gases[gas_id][MOLES]
	garbage_collect()
	return is_there_gas

/// Рассчитать давление в килопаскалях
/datum/gas_mixture/proc/return_pressure()
	if(volume) // чтобы предотвратить деление на ноль
		var/cached_gases = gases
		TOTAL_MOLES(cached_gases, .)
		return . * R_IDEAL_GAS_EQUATION * temperature / volume
	return 0

/// Рассчитать температуру в кельвинах
/datum/gas_mixture/proc/return_temperature()
	return temperature

/// Рассчитать объём в литрах
/datum/gas_mixture/proc/return_volume()
	return max(0, volume)

/// Получает газовые визуализации для всего в этой смеси
/datum/gas_mixture/proc/return_visuals(turf/z_context)
	var/list/output
	GAS_OVERLAYS(gases, output, z_context)
	return output

/// Рассчитать тепловую энергию в джоулях
/datum/gas_mixture/proc/thermal_energy()
	return THERMAL_ENERGY(src) //см. code/__DEFINES/atmospherics.dm; используйте дефайн в критичных по производительности областях

///Обновить архивированные версии переменных. Возвращает: 1 во всех случаях
/datum/gas_mixture/proc/archive()
	var/list/cached_gases = gases

	temperature_archived = temperature
	for(var/id in cached_gases)
		cached_gases[id][ARCHIVE] = cached_gases[id][MOLES]

	return TRUE

///Объединяет весь воздух из giver в self. Удаляет giver. Возвращает: 1 если мы изменяемы, 0 в противном случае
/datum/gas_mixture/proc/merge(datum/gas_mixture/giver)
	if(!giver)
		return FALSE

	//теплопередача
	if(abs(temperature - giver.temperature) > MINIMUM_TEMPERATURE_DELTA_TO_CONSIDER)
		var/self_heat_capacity = heat_capacity()
		var/giver_heat_capacity = giver.heat_capacity()
		var/combined_heat_capacity = giver_heat_capacity + self_heat_capacity
		if(combined_heat_capacity)
			temperature = (giver.temperature * giver_heat_capacity + temperature * self_heat_capacity) / combined_heat_capacity

	var/list/cached_gases = gases //обращение к переменным датума медленнее, чем к переменным процедуры
	var/list/giver_gases = giver.gases
	//передача газа
	for(var/giver_id in giver_gases)
		ASSERT_GAS_IN_LIST(giver_id, cached_gases)
		cached_gases[giver_id][MOLES] += giver_gases[giver_id][MOLES]

	SEND_SIGNAL(src, COMSIG_GASMIX_MERGED)
	return TRUE

///Пропорционально удаляет количество газа из gas_mixture.
///Возвращает: gas_mixture с удалёнными газами
/datum/gas_mixture/proc/remove(amount)
	var/sum
	var/list/cached_gases = gases
	TOTAL_MOLES(cached_gases, sum)
	amount = min(amount, sum) //Нельзя взять больше воздуха, чем есть в тайле!
	if(amount <= 0)
		return null
	var/ratio = amount / sum
	var/datum/gas_mixture/removed = new type(volume)
	var/list/removed_gases = removed.gases //обращение к переменным датума медленнее, чем к переменным процедуры

	removed.temperature = temperature
	for(var/id in cached_gases)
		ADD_GAS(id, removed.gases)
		removed_gases[id][MOLES] = QUANTIZE(cached_gases[id][MOLES] * ratio)
		cached_gases[id][MOLES] -= removed_gases[id][MOLES]
	garbage_collect()

	SEND_SIGNAL(src, COMSIG_GASMIX_REMOVED)
	return removed

///Пропорционально удаляет количество газа из gas_mixture.
///Возвращает: gas_mixture с удалёнными газами
/datum/gas_mixture/proc/remove_ratio(ratio)
	if(ratio <= 0)
		var/datum/gas_mixture/removed = new(volume)
		return removed
	ratio = min(ratio, 1)

	var/list/cached_gases = gases
	var/datum/gas_mixture/removed = new type(volume)
	var/list/removed_gases = removed.gases //обращение к переменным датума медленнее, чем к переменным процедуры

	removed.temperature = temperature
	for(var/id in cached_gases)
		ADD_GAS(id, removed.gases)
		removed_gases[id][MOLES] = QUANTIZE(cached_gases[id][MOLES] * ratio)
		cached_gases[id][MOLES] -= removed_gases[id][MOLES]

	garbage_collect()

	SEND_SIGNAL(src, COMSIG_GASMIX_REMOVED)
	return removed

///Удаляет количество конкретного газа из gas_mixture.
///Возвращает: gas_mixture с удалённым газом
/datum/gas_mixture/proc/remove_specific(gas_id, amount)
	var/list/cached_gases = gases
	amount = min(amount, cached_gases[gas_id][MOLES])
	if(amount <= 0)
		return null
	var/datum/gas_mixture/removed = new type
	var/list/removed_gases = removed.gases
	removed.temperature = temperature
	ADD_GAS(gas_id, removed.gases)
	removed_gases[gas_id][MOLES] = amount
	cached_gases[gas_id][MOLES] -= amount

	garbage_collect(list(gas_id))
	return removed

/datum/gas_mixture/proc/remove_specific_ratio(gas_id, ratio)
	if(ratio <= 0)
		return null
	ratio = min(ratio, 1)

	var/list/cached_gases = gases
	var/datum/gas_mixture/removed = new type
	var/list/removed_gases = removed.gases //обращение к переменным датума медленнее, чем к переменным процедуры

	removed.temperature = temperature
	ADD_GAS(gas_id, removed.gases)
	removed_gases[gas_id][MOLES] = QUANTIZE(cached_gases[gas_id][MOLES] * ratio)
	cached_gases[gas_id][MOLES] -= removed_gases[gas_id][MOLES]

	garbage_collect(list(gas_id))

	return removed

///Равномерно распределяет содержимое двух смесей между собой
//Возвращает: булево значение, указывающее, перемещались ли газы между двумя смесями
/datum/gas_mixture/proc/equalize(datum/gas_mixture/other)
	. = FALSE
	if(abs(return_temperature() - other.return_temperature()) > MINIMUM_TEMPERATURE_DELTA_TO_SUSPEND)
		. = TRUE
		var/self_heat_cap = heat_capacity()
		var/other_heat_cap = other.heat_capacity()
		var/new_temp = (temperature * self_heat_cap + other.temperature * other_heat_cap) / (self_heat_cap + other_heat_cap)
		temperature = new_temp
		other.temperature = new_temp

	var/min_p_delta = 0.1
	var/total_volume = volume + other.volume
	var/list/gas_list = gases | other.gases
	for(var/gas_id in gas_list)
		assert_gas(gas_id)
		other.assert_gas(gas_id)
		//математика предполагает, что температуры равны
		if(abs(gases[gas_id][MOLES] / volume - other.gases[gas_id][MOLES] / other.volume) > min_p_delta / (R_IDEAL_GAS_EQUATION * temperature))
			. = TRUE
			var/total_moles = gases[gas_id][MOLES] + other.gases[gas_id][MOLES]
			gases[gas_id][MOLES] = total_moles * (volume/total_volume)
			other.gases[gas_id][MOLES] = total_moles * (other.volume/total_volume)
	garbage_collect()
	other.garbage_collect()

///Создаёт новую, идентичную газовую смесь
///Возвращает: дубликат газовой смеси
/datum/gas_mixture/proc/copy()
	// Тип как /list/list, чтобы spacemandmm был доволен встроенным доступом, который мы делаем ниже
	var/list/list/cached_gases = gases
	var/datum/gas_mixture/copy = new type
	var/list/copy_gases = copy.gases

	copy.temperature = temperature
	for(var/id in cached_gases)
		// Что-то вроде бокового способа сделать ADD_GAS()
		// Но быстрее, нужно экономить эти циклы процессора
		copy_gases[id] = cached_gases[id].Copy()
		copy_gases[id][ARCHIVE] = 0

	return copy


///Копирует переменные из образца
///Возвращает: TRUE если мы изменяемы, FALSE в противном случае
/datum/gas_mixture/proc/copy_from(datum/gas_mixture/sample)
	var/list/cached_gases = gases //обращение к переменным датума медленнее, чем к переменным процедуры
	// Тип как /list/list, чтобы spacemandmm был доволен встроенным доступом, который мы делаем ниже
	var/list/list/sample_gases = sample.gases

	//удалить все газы
	cached_gases.Cut()

	temperature = sample.temperature
	for(var/id in sample_gases)
		cached_gases[id] = sample_gases[id].Copy()
		cached_gases[id][ARCHIVE] = 0

	return TRUE

///Копирует переменные из образца, моли умножены на partial
///Возвращает: TRUE если мы изменяемы, FALSE в противном случае
/datum/gas_mixture/proc/copy_from_ratio(datum/gas_mixture/sample, partial = 1)
	var/list/cached_gases = gases //обращение к переменным датума медленнее, чем к переменным процедуры
	var/list/sample_gases = sample.gases

	//удалить все газы, не входящие в образец
	cached_gases &= sample_gases

	temperature = sample.temperature
	for(var/id in sample_gases)
		ASSERT_GAS_IN_LIST(id, cached_gases)
		cached_gases[id][MOLES] = sample_gases[id][MOLES] * partial

	return TRUE

/// Выполняет расчёты обмена воздухом между двумя газовыми смесями
/// share() является коммутативной, что означает, что A.share(B) должно быть таким же, как B.share(A)
/// Если мы не сохраним это, мы получим отрицательные моли. Не делайте этого
/// Возвращает: количество обменённого газа (+ если делитель получил)
/datum/gas_mixture/proc/share(datum/gas_mixture/sharer, our_coeff, sharer_coeff)
	var/list/cached_gases = gases
	var/list/sharer_gases = sharer.gases

	var/list/only_in_sharer = sharer_gases - cached_gases
	var/list/only_in_cached = cached_gases - sharer_gases

	var/temperature_delta = temperature_archived - sharer.temperature_archived
	var/abs_temperature_delta = abs(temperature_delta)

	var/old_self_heat_capacity = 0
	var/old_sharer_heat_capacity = 0
	if(abs_temperature_delta > MINIMUM_TEMPERATURE_DELTA_TO_CONSIDER)
		old_self_heat_capacity = heat_capacity()
		old_sharer_heat_capacity = sharer.heat_capacity()

	var/heat_capacity_self_to_sharer = 0 //теплоёмкость молей, переданных от нас делителю
	var/heat_capacity_sharer_to_self = 0 //теплоёмкость молей, переданных от делителя нам

	var/moved_moles = 0
	var/abs_moved_moles = 0

	//ПЕРЕДАЧА ГАЗА

	//Подготовка
	for(var/id in only_in_sharer) //создаём газы, отсутствующие в нашем кэше
		ADD_GAS(id, cached_gases)
	for(var/id in only_in_cached) //создаём газы, отсутствующие в делимой смеси
		ADD_GAS(id, sharer_gases)

	for(var/id in cached_gases) //передаём газы
		var/gas = cached_gases[id]
		var/sharergas = sharer_gases[id]
		var/delta = QUANTIZE(gas[ARCHIVE] - sharergas[ARCHIVE]) //количество газа, которое перемещается между смесями

		if(!delta)
			continue

		// Если у нас больше газа, чем у них, газ перемещается от нас к ним
		// Это означает, что мы хотим масштабировать его нашим коэффициентом. И наоборот для их случая
		if(delta > 0)
			delta = delta * our_coeff
		else
			delta = delta * sharer_coeff

		if(abs_temperature_delta > MINIMUM_TEMPERATURE_DELTA_TO_CONSIDER)
			var/gas_heat_capacity = delta * gas[GAS_META][META_GAS_SPECIFIC_HEAT]
			if(delta > 0)
				heat_capacity_self_to_sharer += gas_heat_capacity
			else
				heat_capacity_sharer_to_self -= gas_heat_capacity //вычитаем здесь вместо добавления абсолютного значения, потому что мы знаем, что delta отрицательна.

		gas[MOLES] -= delta
		sharergas[MOLES] += delta
		moved_moles += delta
		abs_moved_moles += abs(delta)

	last_share = abs_moved_moles

	//ПЕРЕДАЧА ТЕПЛОВОЙ ЭНЕРГИИ
	if(abs_temperature_delta > MINIMUM_TEMPERATURE_DELTA_TO_CONSIDER)
		var/new_self_heat_capacity = old_self_heat_capacity + heat_capacity_sharer_to_self - heat_capacity_self_to_sharer
		var/new_sharer_heat_capacity = old_sharer_heat_capacity + heat_capacity_self_to_sharer - heat_capacity_sharer_to_self

		//передача тепловой энергии (через изменённую теплоёмкость) между self и sharer
		if(new_self_heat_capacity > MINIMUM_HEAT_CAPACITY)
			temperature = (old_self_heat_capacity*temperature - heat_capacity_self_to_sharer*temperature_archived + heat_capacity_sharer_to_self*sharer.temperature_archived)/new_self_heat_capacity

		if(new_sharer_heat_capacity > MINIMUM_HEAT_CAPACITY)
			sharer.temperature = (old_sharer_heat_capacity*sharer.temperature-heat_capacity_sharer_to_self*sharer.temperature_archived + heat_capacity_self_to_sharer*temperature_archived)/new_sharer_heat_capacity
		//тепловая энергия системы (self и sharer) не изменилась

			if(abs(old_sharer_heat_capacity) > MINIMUM_HEAT_CAPACITY)
				if(abs(new_sharer_heat_capacity/old_sharer_heat_capacity - 1) < 0.1) // <10% изменение теплоёмкости делителя
					temperature_share(sharer, OPEN_HEAT_TRANSFER_COEFFICIENT)

	if(length(only_in_sharer + only_in_cached)) //если все газы присутствовали в обеих смесях, мы знаем, что газы не равны 0
		garbage_collect(only_in_cached) //любые газы, которые были у делителя, гарантированно есть у нас. газов, которых у него не было, у нас нет.
		sharer.garbage_collect(only_in_sharer) //обратное также верно
	else if (initial(sharer.gc_share))
		sharer.garbage_collect()

	if(temperature_delta > MINIMUM_TEMPERATURE_TO_MOVE || abs(moved_moles) > MINIMUM_MOLES_DELTA_TO_MOVE)
		var/our_moles
		TOTAL_MOLES(cached_gases,our_moles)
		var/their_moles
		TOTAL_MOLES(sharer_gases,their_moles)
		return (temperature_archived*(our_moles + moved_moles) - sharer.temperature_archived*(their_moles - moved_moles)) * R_IDEAL_GAS_EQUATION / volume

///Выполняет расчёты обмена температурой (через теплопроводность) между двумя газовыми смесями, предполагая только 1 граничную длину
///Возвращает: новая температура делителя
/datum/gas_mixture/proc/temperature_share(datum/gas_mixture/sharer, conduction_coefficient, sharer_temperature, sharer_heat_capacity)
	//передача тепловой энергии (через теплопроводность) между self и sharer
	if(sharer)
		sharer_temperature = sharer.temperature_archived
	var/temperature_delta = temperature_archived - sharer_temperature
	if(abs(temperature_delta) > MINIMUM_TEMPERATURE_DELTA_TO_CONSIDER)
		var/self_heat_capacity = heat_capacity(ARCHIVE)
		sharer_heat_capacity = sharer_heat_capacity || sharer.heat_capacity(ARCHIVE)

		if((sharer_heat_capacity > MINIMUM_HEAT_CAPACITY) && (self_heat_capacity > MINIMUM_HEAT_CAPACITY))
			// коэффициент применяется первым, потому что у некоторых тайлов очень большие теплоёмкости.
			var/heat = CALCULATE_CONDUCTION_ENERGY(conduction_coefficient * temperature_delta, sharer_heat_capacity, self_heat_capacity)

			temperature = max(temperature - heat/self_heat_capacity, TCMB)
			sharer_temperature = max(sharer_temperature + heat/sharer_heat_capacity, TCMB)
			if(sharer)
				sharer.temperature = sharer_temperature
				if (initial(sharer.gc_share))
					sharer.garbage_collect()
	return sharer_temperature
	//тепловая энергия системы (self и sharer) не изменилась

///Сравнивает образец с собой, чтобы увидеть, находятся ли они в допустимых диапазонах, при которых может быть включена групповая обработка
///Принимает индекс газа для чтения в качестве второго аргумента (либо MOLES, либо ARCHIVE)
///Возвращает: строка, указывающая, какая проверка не пройдена, или "" если проверка пройдена
/datum/gas_mixture/proc/compare(datum/gas_mixture/sample, index)
	var/list/sample_gases = sample.gases //обращение к переменным датума медленнее, чем к переменным процедуры
	var/list/cached_gases = gases
	var/moles_sum = 0

	for(var/id in cached_gases | sample_gases) // сравниваем газы из любой смеси
		// Да, это на самом деле быстро. Я тоже ненавижу здесь находиться
		var/gas_moles = cached_gases[id]?[index] || 0
		var/sample_moles = sample_gases[id]?[index] || 0
		// Краткое объяснение. Мы гораздо более вероятно не пройдём первую проверку, чем пройдём первую и провалим вторую
		// Из-за этого двойной расчёт дельты БЫСТРЕЕ, чем вставка её в переменную
		if(abs(gas_moles - sample_moles) > MINIMUM_MOLES_DELTA_TO_MOVE)
			if(abs(gas_moles - sample_moles) > gas_moles * MINIMUM_AIR_RATIO_TO_MOVE)
				return id
		// аналогично, мы редко будем отсекаться, поэтому это дешевле, чем делать это позже
		moles_sum += gas_moles

	if(moles_sum > MINIMUM_MOLES_DELTA_TO_MOVE) //Не рассматриваем температуру, если недостаточно молей
		if(index == ARCHIVE)
			if(abs(temperature_archived - sample.temperature_archived) > MINIMUM_TEMPERATURE_DELTA_TO_SUSPEND)
				return "temp"
		else
			if(abs(temperature - sample.temperature) > MINIMUM_TEMPERATURE_DELTA_TO_SUSPEND)
				return "temp"

	return ""

///Выполняет различные реакции, такие как горение и создание
///Возвращает: 1 если произошла какая-либо реакция; 0 в противном случае
/datum/gas_mixture/proc/react(datum/holder)
	. = NO_REACTION
	var/list/cached_gases = gases
	if(!length(cached_gases))
		return

	var/list/pre_formation = list()
	var/list/mid_formation = list()
	var/list/post_formation = list()
	var/list/fires = list()
	var/list/gas_reactions = SSair.gas_reactions
	for(var/gas_id in cached_gases)
		var/list/reaction_set = gas_reactions[gas_id]
		if(!reaction_set)
			continue
		pre_formation += reaction_set[1]
		mid_formation += reaction_set[2]
		post_formation += reaction_set[3]
		fires += reaction_set[4]

	var/list/reactions = pre_formation + mid_formation + post_formation + fires

	if(!length(reactions))
		return

	//Иди нахуй
	if(cached_gases[/datum/gas/hypernoblium] && cached_gases[/datum/gas/hypernoblium][MOLES] >= REACTION_OPPRESSION_THRESHOLD && temperature > REACTION_OPPRESSION_MIN_TEMP)
		return STOP_REACTIONS

	reaction_results = new
	//Возможно, стоит рассмотреть обновление этих значений после каждой реакции, но это заставляет нас больше заботиться о порядке операций, так что будьте осторожны
	var/temp = temperature
	reaction_loop:
		for(var/datum/gas_reaction/reaction as anything in reactions)

			var/list/reqs = reaction.requirements
			if((reqs["MIN_TEMP"] && temp < reqs["MIN_TEMP"]) || (reqs["MAX_TEMP"] && temp > reqs["MAX_TEMP"]))
				continue

			for(var/id in reqs)
				if (id == "MIN_TEMP" || id == "MAX_TEMP")
					continue
				if(!cached_gases[id] || cached_gases[id][MOLES] < reqs[id])
					continue reaction_loop

			//на этом этапе все требования для реакции удовлетворены. мы можем теперь react()
			. |= reaction.react(src, holder)


	if(.) //Если мы изменили смесь в любой степени
		garbage_collect()
		SEND_SIGNAL(src, COMSIG_GASMIX_REACTED)


/**
 * Возвращает парциальное давление газа в дыхании на основе BREATH_VOLUME
 * например:
 * Plas_PP = get_breath_partial_pressure(gas_mixture.gases[/datum/gas/plasma][MOLES])
 * O2_PP = get_breath_partial_pressure(gas_mixture.gases[/datum/gas/oxygen][MOLES])
 * get_breath_partial_pressure(gas_mole_count) --> PV = nRT, P = nRT/V
 *
 * 10/20*5 = 2.5
 * 10 = 2.5/5*20
 */

/datum/gas_mixture/proc/get_breath_partial_pressure(gas_mole_count)
	return (gas_mole_count * R_IDEAL_GAS_EQUATION * temperature) / BREATH_VOLUME

/**
 * Подсчитывает, какое давление будет, если мы передадим MOLAR_ACCURACY количество нашего газа в выходную газовую смесь.
 * Мы делаем всё это без фактической передачи, так что не беспокойтесь об изменении газовой смеси.
 * Возвращает: Результирующее давление (число).
 * Аргументы:
 * - output_air (газовая смесь).
 */
/datum/gas_mixture/proc/gas_pressure_minimum_transfer(datum/gas_mixture/output_air)
	var/resulting_energy = output_air.thermal_energy() + (MOLAR_ACCURACY / total_moles() * thermal_energy())
	var/resulting_capacity = output_air.heat_capacity() + (MOLAR_ACCURACY / total_moles() * heat_capacity())
	return (output_air.total_moles() + MOLAR_ACCURACY) * R_IDEAL_GAS_EQUATION * (resulting_energy / resulting_capacity) / output_air.volume


/** Возвращает количество газа для перекачки в конкретный контейнер.
 * Аргументы:
 * - output_air. Газовая смесь, в которую мы хотим качать.
 * - target_pressure. Целевое давление, которое мы хотим.
 * - ignore_temperature. Возвращает более дешёвую форму расчёта газа, полезную, если разница температур между двумя газовыми смесями мала или отсутствует.
 */
/datum/gas_mixture/proc/gas_pressure_calculate(datum/gas_mixture/output_air, target_pressure, ignore_temperature = FALSE)
	// Чтобы нам не нужно было итерировать список газов несколько раз.
	var/our_moles = total_moles()
	var/output_moles = output_air.total_moles()
	var/output_pressure = output_air.return_pressure()

	if(our_moles <= 0 || temperature <= 0)
		return FALSE

	var/pressure_delta = 0
	if(output_air.temperature <= 0 || output_moles <= 0)
		ignore_temperature = TRUE
		pressure_delta = target_pressure
	else
		pressure_delta = target_pressure - output_pressure

	if(pressure_delta < 0.01 || gas_pressure_minimum_transfer(output_air) > target_pressure)
		return FALSE

	if(ignore_temperature)
		return (pressure_delta*output_air.volume)/(temperature * R_IDEAL_GAS_EQUATION)

	// Нижняя и верхняя граница для молей, которые мы должны передать для достижения давления. Ответ где-то здесь.
	var/pv = target_pressure * output_air.volume
	/// Часть PV/R в уравнении, которое мы будем использовать позже. Подсчитано заранее, потому что pv/(r*t) может не равняться pv/r/t, что испортит наши нижний и верхний пределы.
	var/pvr = pv / R_IDEAL_GAS_EQUATION
	// Это работает, предполагая, что наш газ имеет чрезвычайно высокую теплоёмкость
	// и результирующая газовая смесь достигнет либо самой высокой, либо самой низкой возможной температуры.

	/// Это истинный нижний предел, но числа всё ещё могут быть ниже из-за чисел с плавающей запятой.
	var/lower_limit = max((pvr / max(temperature, output_air.temperature)) - output_moles, 0)
	var/upper_limit = (pvr / min(temperature, output_air.temperature)) - output_moles // Теоретически это никогда не должно опускаться ниже нуля, проверка pressure_delta выше должна учитывать это.

	lower_limit = max(lower_limit - ATMOS_PRESSURE_ERROR_TOLERANCE, 0)
	upper_limit += ATMOS_PRESSURE_ERROR_TOLERANCE

	/*
	 * У нас есть PV=nRT как хорошая формула, мы можем переставить её в nT = PV/R
	 * Но теперь и n, и T могут изменяться, поскольку любые входящие моли также изменяют нашу температуру.
	 * Поэтому нам нужно как-то объединить и n, и T.
	 *
	 * Мы можем переписать T как (наша старая тепловая энергия + входящая тепловая энергия), делённая на (наша старая теплоёмкость + входящая теплоёмкость)
	 * T = (W1 + n/N2 * W2) / (C1 + n/N2 * C2). C - теплоёмкость, W - работа, N - общее количество молей.
	 *
	 * В итоге наше уравнение теперь: (N1 + n) * (W1 + n/N2 * W2) / (C1 + n/N2 * C2) = PV/R
	 * Теперь вы можете переставить это и обнаружить, что это квадратное уравнение, и его можно решить с помощью формулы. Будет немного громоздко.
	 *
	 * W2/N2n^2 +
	 * (N1*W2/N2)n + W1n - ((PV/R)*C2/N2)n +
	 * (-(PV/R)*C1) + N1W1 = 0
	 *
	 * Мы представим каждый из этих членов как A, B и C. A для части n^2, B для части n^1, и C для части n^0.
	 * Затем мы подставляем это в знаменитую формулу (-b +/- sqrt(b^2-4ac)) / 2a.
	 *
	 * И ещё одна вещь. Под "нашими" мы подразумеваем газовую смесь в аргументе. Мы - входящие. Мы номер 2, цель - номер 1.
	 * Если весь этот подсчёт испортится, мы сначала вернёмся к аппроксимации Ньютона, затем к старой простой формуле.
	 */

	// Наша тепловая энергия и моли
	var/w2 = thermal_energy()
	var/n2 = our_moles
	var/c2 = heat_capacity()

	// Тепловая энергия и моли цели
	var/w1 = output_air.thermal_energy()
	var/n1 = output_moles
	var/c1 = output_air.heat_capacity()

	/// x^2 в квадратном уравнении
	var/a_value = w2/n2
	/// x^1 в квадратном уравнении
	var/b_value = ((n1*w2)/n2) + w1 - (pvr*c2/n2)
	/// x^0 в квадратном уравнении
	var/c_value = (-1*pvr*c1) + n1 * w1

	. = gas_pressure_quadratic(a_value, b_value, c_value, lower_limit, upper_limit)
	if(.)
		return
	. = gas_pressure_approximate(a_value, b_value, c_value, lower_limit, upper_limit)
	if(.)
		return
	// Неточный и, вероятно, взорвётся, но неважно.
	return (pressure_delta*output_air.volume)/(temperature * R_IDEAL_GAS_EQUATION)

/// Фактически пытается решить квадратное уравнение.
/// Имейте в виду, что числа могут стать очень большими и достичь предела плавающей запятой BYOND.
/datum/gas_mixture/proc/gas_pressure_quadratic(a, b, c, lower_limit, upper_limit)
	var/solution
	if(IS_FINITE(a) && IS_FINITE(b) && IS_FINITE(c))
		solution = max(SolveQuadratic(a, b, c))
		if(solution > lower_limit && solution < upper_limit) //SolveQuadratic может возвращать пустые списки, так что будьте осторожны здесь
			return solution
	stack_trace("Не удалось решить квадратное уравнение давления. A: [a]. B: [b]. C:[c]. Текущее значение = [solution]. Ожидаемый нижний предел: [lower_limit]. Ожидаемый верхний предел: [upper_limit].")
	return FALSE

/// Аппроксимация квадратного уравнения с использованием метода Ньютона-Рафсона.
/// Мы используем наклон приближённого значения, чтобы приблизиться к корню данного уравнения.
/datum/gas_mixture/proc/gas_pressure_approximate(a, b, c, lower_limit, upper_limit)
	var/solution
	if(IS_FINITE(a) && IS_FINITE(b) && IS_FINITE(c))
		// Мы начинаем с экстремума уравнения, добавленного с числом.
		// Таким образом, мы, надеюсь, всегда сойдёмся к положительному корню, начиная с разумного числа.
		solution = (-b / (2 * a)) + 200
		for (var/iteration in 1 to ATMOS_PRESSURE_APPROXIMATION_ITERATIONS)
			var/diff = (a*solution**2 + b*solution + c) / (2*a*solution + b) // f(sol) / f'(sol)
			solution -= diff // xn+1 = xn - f(sol) / f'(sol)
			if(abs(diff) < MOLAR_ACCURACY && (solution > lower_limit) && (solution < upper_limit))
				return solution
	stack_trace("Аппроксимация Ньютона для давления провалилась после [ATMOS_PRESSURE_APPROXIMATION_ITERATIONS] итераций. A: [a]. B: [b]. C:[c]. Текущее значение: [solution]. Ожидаемый нижний предел: [lower_limit]. Ожидаемый верхний предел: [upper_limit].")
	return FALSE

/// Качает газ из src в output_air. Количество зависит от target_pressure
/datum/gas_mixture/proc/pump_gas_to(datum/gas_mixture/output_air, target_pressure, specific_gas = null, datum/gas_mixture/output_pipenet_air = null)
	var/datum/gas_mixture/input_air = specific_gas ? remove_specific_ratio(specific_gas, 1) : src
	var/temperature_delta = abs(input_air.temperature - output_air.temperature)
	var/datum/gas_mixture/removed

	var/transfer_moles_output = input_air.gas_pressure_calculate(output_air, target_pressure, temperature_delta <= 5)
	var/transfer_moles_pipenet = output_pipenet_air?.volume ? input_air.gas_pressure_calculate(output_pipenet_air, target_pressure, temperature_delta <= 5) : 0
	var/transfer_moles = max(transfer_moles_output, transfer_moles_pipenet)

	if(specific_gas)
		removed = input_air.remove_specific(specific_gas, transfer_moles)
		merge(input_air) // Объединить оставшийся газ обратно во входной узел
	else
		removed = input_air.remove(transfer_moles)

	if(!removed)
		return FALSE

	output_air.merge(removed)
	return removed

/// Выпускает газ из src в выходной воздух. Это означает, что он не может передавать воздух в газовую смесь с более высоким давлением.
/datum/gas_mixture/proc/release_gas_to(datum/gas_mixture/output_air, target_pressure, rate=1, datum/gas_mixture/output_pipenet_air = null)
	var/output_starting_pressure = output_air.return_pressure()
	var/input_starting_pressure = return_pressure()

	//Нужна как минимум разница в 10 КПа, чтобы преодолеть трение в механизме
	if(output_starting_pressure >= min(target_pressure, input_starting_pressure-10))
		return FALSE
	//Не может быть разницы давлений, которая приведёт к output_pressure > input_pressure
	target_pressure = output_starting_pressure + min(target_pressure - output_starting_pressure, (input_starting_pressure - output_starting_pressure)/2)
	var/temperature_delta = abs(temperature - output_air.temperature)

	var/transfer_moles_output = gas_pressure_calculate(output_air, target_pressure, temperature_delta <= 5)
	var/transfer_moles_pipenet = output_pipenet_air?.volume ? gas_pressure_calculate(output_pipenet_air, target_pressure, temperature_delta <= 5) : 0
	var/transfer_moles = max(transfer_moles_output, transfer_moles_pipenet)

	//Фактически передаём газ
	var/datum/gas_mixture/removed = remove(transfer_moles * rate)

	if(!removed)
		return FALSE

	output_air.merge(removed)
	return TRUE

/**
 * Вызывает реакции electrolyzer_reaction на газовой смеси.
 * Аргументы:
 * * working_power - working_power для использования в реакциях electrolyzer_reaction.
 * * electrolyzer_args - аргументы электролиза для использования в реакциях electrolyzer_reaction.
 */
/datum/gas_mixture/proc/electrolyze(working_power = 0, electrolyzer_args = list())
	for(var/reaction in GLOB.electrolyzer_reactions)
		var/datum/electrolyzer_reaction/current_reaction = GLOB.electrolyzer_reactions[reaction]

		if(!current_reaction.reaction_check(air_mixture = src, electrolyzer_args = electrolyzer_args))
			continue

		current_reaction.react(air_mixture = src, working_power = working_power, electrolyzer_args = electrolyzer_args)

	garbage_collect()

/// Преобразует газовую смесь в строку (т.е. "o2=22;n2=82;TEMP=180")
/// Округляет все температуры и газы до 0.01 и пропускает любые газы меньше этого количества
/datum/gas_mixture/proc/to_string()
	var/list/cached_gases = gases
	var/rounded_temp = round(temperature, 0.01)

	var/list/atmos_contents = list()
	var/temperature_str = "TEMP=[num2text(rounded_temp)]"

	if(!length(cached_gases) || total_moles() < 0.01)
		return temperature_str

	for(var/gas_path in cached_gases)
		var/gas_moles = cached_gases[gas_path][MOLES]
		var/gas_id = cached_gases[gas_path][GAS_META][META_GAS_ID]

		gas_moles = round(gas_moles, 0.01)
		if(gas_moles >= 0.01)
			atmos_contents += "[gas_id]=[num2text(gas_moles)]"

	atmos_contents += temperature_str
	return atmos_contents.Join(";")
