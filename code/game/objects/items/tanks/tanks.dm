/// Сколько времени (в секундах) считается прошедшим при поглощении воздуха. Используется для масштабирования урона от избыточного давления/температуры при поглощении воздуха.
#define ASSUME_AIR_DT_FACTOR 1
/// Умножает давление бомб из сборки перед тем, как оно пройдет через ЛОГАРИФМ
#define ASSEMBLY_BOMB_COEFFICIENT 0.5
/// Основание логарифмической функции, используемой для расчета размера взрыва бомбы из сборки
#define ASSEMBLY_BOMB_BASE 2.7

/**
 * # Газовый бак
 *
 * Ручные газовые канистры
 * Могут разорваться со взрывом при избыточном давлении
 */
/obj/item/tank
	name = "tank"
	icon = 'icons/obj/canisters.dmi'
	icon_state = "generic"
	inhand_icon_state = "generic_tank"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/equipment/tanks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tanks_righthand.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BACK
	worn_icon = 'icons/mob/clothing/back.dmi' //так как их также можно положить в слоты хранения костюма. если что-то идет на пояс, установите это в null.
	hitsound = 'sound/items/weapons/smash.ogg'
	pickup_sound = 'sound/items/handling/gas_tank/gas_tank_pick_up.ogg'
	drop_sound = 'sound/items/handling/gas_tank/gas_tank_drop.ogg'
	sound_vary = TRUE
	pressure_resistance = ONE_ATMOSPHERE * 5
	force = 5
	throwforce = 10
	throw_speed = 1
	throw_range = 4
	demolition_mod = 1.25
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*5)
	actions_types = list(/datum/action/item_action/set_internals)
	action_slots = ALL
	armor_type = /datum/armor/item_tank
	integrity_failure = 0.5
	/// Если мы находимся в процессе взрыва, останавливает множественные взрывы
	var/igniting = FALSE
	/// Газы, содержащиеся в этом баке. Не изменяйте это напрямую, используйте return_air() для получения
	var/datum/gas_mixture/air_contents = null
	/// Объем этого бака. Среди прочего, взрывы газовых баков (включая бомбы) зависят от этого. Учтите это, если будете менять, иначе вы сломаете ~~токсины~~ ординанс.
	var/volume = TANK_STANDARD_VOLUME
	/// Протекает ли бак в данный момент.
	var/leaking = FALSE
	/// Давление газов, которое этот бак подает в дыхательную маску.
	var/distribute_pressure = ONE_ATMOSPHERE
	/// Состояние иконки, когда находится в держателе бака или на хирургическом столе. Null делает его несовместимым с держателем бака.
	var/tank_holder_icon_state = "holder_generic"
	///Используется process() для отслеживания, есть ли причина для обработки в каждом тике
	var/excited = TRUE
	/// Как именно взрывается наш конкретный бак.
	var/list/explosion_info
	/// Список, содержащий реакции, происходящие внутри нашего бака.
	var/list/reaction_info
	/// Моб, который в данный момент дышит из бака.
	var/mob/living/carbon/breathing_mob = null
	///Прогресс-бар, показывающий, сколько объема осталось в баке, когда он экипирован.
	var/datum/progressbar/volume_bar
	/// Прикрепленная сборка, может либо взорвать бак, либо выпустить его содержимое при получении сигнала
	var/obj/item/assembly_holder/tank_assembly
	/// Попытается ли он взорваться при получении сигнала
	var/bomb_status = FALSE

/// Закрывает бак, если его уронили в открытом состоянии.
/datum/armor/item_tank
	bomb = 10
	fire = 80
	acid = 30

/obj/item/tank/get_ru_names()
	return alist(
		NOMINATIVE = "бак",
		GENITIVE = "бака",
		DATIVE = "баку",
		ACCUSATIVE = "бак",
		INSTRUMENTAL = "баком",
		PREPOSITIONAL = "баке",
	)

/obj/item/tank/dropped(mob/living/user, silent)
	. = ..()
	// Закрыть открытый бак, если его текущий пользователь отправился в мир иной.
	if (QDELETED(breathing_mob))
		breathing_mob = null
		return
	// Закрыть открытый бак, если его текущий пользователь уронил его.
	if (loc != breathing_mob)
		breathing_mob.cutoff_internals()

/// Закрывает бак, если он передан другому мобу в открытом состоянии.
/obj/item/tank/equipped(mob/living/user, slot, initial)
	. = ..()
	// Закрыть открытый бак, если он был экипирован мобом, отличным от текущего пользователя.
	if (breathing_mob && (user != breathing_mob))
		breathing_mob.cutoff_internals()

/// Вызывается карбоновыми мобами после подключения бака к дыхательному аппарату.
/obj/item/tank/proc/after_internals_opened(mob/living/carbon/carbon_target)
	breathing_mob = carbon_target
	playsound(loc, 'sound/items/internals/internals_on.ogg', 15, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	var/pressure_on_open = air_contents.return_pressure() //мы начинаем "полными" при переключении и отсчитываем оттуда.
	volume_bar = new(carbon_target, pressure_on_open, src, pressure_on_open)

/// Вызывается карбоновыми мобами после отключения бака от дыхательного аппарата.
/obj/item/tank/proc/after_internals_closed(mob/living/carbon/carbon_target)
	breathing_mob = null
	playsound(loc, 'sound/items/internals/internals_off.ogg', 15, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	QDEL_NULL(volume_bar)

/// Пытается переключить подачу воздуха из бака для моба. Возвращает TRUE в случае успеха.
/obj/item/tank/proc/toggle_internals(mob/living/carbon/mob_target)
	return mob_target.toggle_internals(src)

/obj/item/tank/ui_action_click(mob/user)
	toggle_internals(user)

/obj/item/tank/Initialize(mapload)
	. = ..()

	if(tank_holder_icon_state)
		AddComponent(/datum/component/container_item/tank_holder, tank_holder_icon_state)

	air_contents = new(volume) //литры
	air_contents.temperature = T20C

	populate_gas()

	reaction_info = list()
	explosion_info = list()

	AddComponent(/datum/component/atmos_reaction_recorder, reset_criteria = list(COMSIG_GASMIX_MERGING = air_contents, COMSIG_GASMIX_REMOVING = air_contents), target_list = reaction_info)

	// Это отделено от регистратора реакций.
	// В данном случае мы слушаем только для того, чтобы определить, переполнен ли бак давлением, но не уничтожен.
	RegisterSignal(air_contents, COMSIG_GASMIX_MERGED, PROC_REF(merging_information))

	START_PROCESSING(SSobj, src)

/obj/item/tank/proc/populate_gas()
	return

/obj/item/tank/Destroy()
	STOP_PROCESSING(SSobj, src)
	air_contents = null
	QDEL_NULL(tank_assembly)
	QDEL_NULL(volume_bar)
	return ..()

/obj/item/tank/update_overlays()
	. = ..()
	if(tank_assembly)
		. += tank_assembly.icon_state
		. += tank_assembly.overlays
		. += "bomb_assembly"

/obj/item/tank/examine(mob/user)
	var/obj/icon = src
	. = ..()
	if(istype(loc, /obj/item/assembly))
		icon = loc
	if(!in_range(src, user) && !isobserver(user))
		if(icon == src)
			. += span_notice("Если вам нужна дополнительная информация, вам нужно подойти поближе.")
		return

	. += span_notice("Манометр показывает [round(air_contents.return_pressure(),0.01)] кПа.")

	var/celsius_temperature = air_contents.temperature-T0C
	var/descriptive

	if (celsius_temperature < 20)
		descriptive = "холодным"
	else if (celsius_temperature < 40)
		descriptive = "комнатной температуры"
	else if (celsius_temperature < 80)
		descriptive = "тёпловатым"
	else if (celsius_temperature < 100)
		descriptive = "тёплым"
	else if (celsius_temperature < 300)
		descriptive = "горячим"
	else
		descriptive = "невыносимо жарким"

	. += span_notice("Ощущается [descriptive].")

	if(tank_assembly)
		. += span_warning("К [RU_SRC_DAT] прикреплено какое-то устройство!")

/obj/item/tank/atom_deconstruct(disassembled = TRUE)
	var/atom/location = loc
	if(location)
		location.assume_air(air_contents)
		playsound(location, 'sound/effects/spray.ogg', 10, TRUE, -3)
	return ..()

/obj/item/tank/suicide_act(mob/living/user)
	var/mob/living/carbon/human/human_user = user
	user.visible_message(span_suicide("[user] прикладывает клапан [RU_SRC_GEN] к своим губам! Похоже, [user] пытается совершить суицид!"))
	playsound(loc, 'sound/effects/spray.ogg', 10, TRUE, -3)
	if(!QDELETED(human_user) && air_contents && air_contents.return_pressure() >= 1000)
		ADD_TRAIT(human_user, TRAIT_DISFIGURED, TRAIT_GENERIC)
		human_user.inflate_gib()
		return MANUAL_SUICIDE
	to_chat(user, span_warning("В [RU_SRC_PRE] недостаточно давления для суицида..."))
	return SHAME

/obj/item/tank/attackby(obj/item/attacking_item, mob/user, list/modifiers, list/attack_modifiers)
	add_fingerprint(user)
	if(istype(attacking_item, /obj/item/assembly_holder))
		if(tank_assembly)
			balloon_alert(user, "что-то уже прикреплено!")
			return ITEM_INTERACT_BLOCKING
		bomb_assemble(attacking_item, user)
		return ITEM_INTERACT_SUCCESS
	return ..()

/obj/item/tank/wrench_act(mob/living/user, obj/item/tool)
	if(tank_assembly)
		tool.play_tool_sound(src)
		bomb_disassemble(user)
		return ITEM_INTERACT_SUCCESS
	return ..()

/obj/item/tank/welder_act(mob/living/user, obj/item/tool)
	if(bomb_status)
		balloon_alert(user, "уже заварено!")
		return ITEM_INTERACT_BLOCKING
	if(tool.use_tool(src, user, 0, volume=40))
		bomb_status = TRUE
		balloon_alert(user, "бомба взведена")
		log_bomber(user, "welded a single tank bomb,", src, "| Temp: [air_contents.temperature] Pressure: [air_contents.return_pressure()]")
		add_fingerprint(user)
		return ITEM_INTERACT_SUCCESS
	return ..()

/obj/item/tank/ui_state(mob/user)
	return GLOB.hands_state

/obj/item/tank/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Tank", name)
		ui.open()

/obj/item/tank/ui_static_data(mob/user)
	. = list (
		"defaultReleasePressure" = round(TANK_DEFAULT_RELEASE_PRESSURE),
		"minReleasePressure" = round(TANK_MIN_RELEASE_PRESSURE),
		"maxReleasePressure" = round(TANK_MAX_RELEASE_PRESSURE),
		"leakPressure" = round(TANK_LEAK_PRESSURE),
		"fragmentPressure" = round(TANK_FRAGMENT_PRESSURE)
	)

/obj/item/tank/ui_data(mob/user)
	. = list(
		"tankPressure" = round(air_contents.return_pressure()),
		"releasePressure" = round(distribute_pressure)
	)

	var/mob/living/carbon/carbon_user = user
	if(!istype(carbon_user))
		carbon_user = loc
	if(istype(carbon_user) && (carbon_user.external == src || carbon_user.internal == src))
		.["connected"] = TRUE

/obj/item/tank/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("pressure")
			var/pressure = params["pressure"]
			if(pressure == "reset")
				pressure = initial(distribute_pressure)
				. = TRUE
			else if(pressure == "min")
				pressure = TANK_MIN_RELEASE_PRESSURE
				. = TRUE
			else if(pressure == "max")
				pressure = TANK_MAX_RELEASE_PRESSURE
				. = TRUE
			else if(text2num(pressure) != null)
				pressure = text2num(pressure)
				. = TRUE
			if(.)
				distribute_pressure = clamp(round(pressure), TANK_MIN_RELEASE_PRESSURE, TANK_MAX_RELEASE_PRESSURE)

/obj/item/tank/remove_air(amount)
	START_PROCESSING(SSobj, src)
	return air_contents.remove(amount)

/obj/item/tank/return_air()
	START_PROCESSING(SSobj, src)
	return air_contents

/obj/item/tank/return_analyzable_air()
	return air_contents

/obj/item/tank/assume_air(datum/gas_mixture/giver)
	START_PROCESSING(SSobj, src)
	air_contents.merge(giver)
	handle_tolerances(ASSUME_AIR_DT_FACTOR)
	return TRUE

/**
 * Удаляет некоторый объем газов из бака с давлением распределения бака.
 *
 * Аргументы:
 * - volume_to_return: Количество объема, которое нужно удалить из бака.
 */
/obj/item/tank/proc/remove_air_volume(volume_to_return)
	if(!air_contents)
		return null

	var/tank_pressure = air_contents.return_pressure()
	var/actual_distribute_pressure = clamp(tank_pressure, 0, distribute_pressure)

	// Давайте займемся алгеброй, чтобы понять, почему это работает, ага?
	// R_IDEAL_GAS_EQUATION это (кПа * Л) / (К * моль) кстати, так что единицы в этом уравнении выглядят примерно так
	// кПа * Л / (R_IDEAL_GAS_EQUATION * К)
	// Или перефразируя (кПа * Л / К) * 1/R_IDEAL_GAS_EQUATION
	// (кПа * Л * К * моль) / (кПа * Л * К)
	// Если мы все сократим, то получим моли, что и является ожидаемой единицей
	// Такие вещи часто встречаются в atmos, имейте в виду этот инструмент для других частей кода
	var/moles_needed = actual_distribute_pressure*volume_to_return/(R_IDEAL_GAS_EQUATION*air_contents.temperature)

	return remove_air(moles_needed)

/obj/item/tank/process(seconds_per_tick)
	if(!air_contents)
		return
	if(!QDELETED(volume_bar))
		volume_bar.update(air_contents.return_pressure())

	//Разрешить реакции
	excited = (excited | air_contents.react(src))
	excited = (excited | handle_tolerances(seconds_per_tick))
	excited = (excited | leaking)

	if(!excited)
		STOP_PROCESSING(SSobj, src)
	excited = FALSE

	if(QDELETED(src) || !leaking || !air_contents)
		return
	var/atom/location = loc
	if(!location)
		return
	var/datum/gas_mixture/leaked_gas = air_contents.remove_ratio(0.25)
	location.assume_air(leaked_gas)

/**
 * Обрабатывает допуски минимального и максимального давления в баке.
 *
 * Возвращает true, если произошло что-то значительное, false в противном случае
 * Аргументы:
 * - seconds_per_tick: Сколько времени прошло между тиками.
 */
/obj/item/tank/proc/handle_tolerances(seconds_per_tick)
	if(!air_contents)
		return FALSE

	var/pressure = air_contents.return_pressure()
	var/temperature = air_contents.return_temperature()
	if(temperature >= TANK_MELT_TEMPERATURE)
		var/temperature_damage_ratio = (temperature - TANK_MELT_TEMPERATURE) / temperature
		take_damage(max_integrity * temperature_damage_ratio * seconds_per_tick, BURN, FIRE, FALSE, NONE)
		if(QDELETED(src))
			return TRUE

	if(pressure >= TANK_LEAK_PRESSURE)
		var/pressure_damage_ratio = (pressure - TANK_LEAK_PRESSURE) / (TANK_RUPTURE_PRESSURE - TANK_LEAK_PRESSURE)
		take_damage(max_integrity * pressure_damage_ratio * seconds_per_tick, BRUTE, BOMB, FALSE, NONE)
		return TRUE
	return FALSE

/// Обрабатывает возникновение утечки в баке.
/obj/item/tank/atom_break(damage_flag)
	. = ..()
	if(leaking)
		return

	leaking = TRUE
	START_PROCESSING(SSobj, src)

	if(atom_integrity < 0) // Чтобы мы не проигрывали оповещения, пока взрываемся или разрываемся.
		return
	visible_message(span_warning("[RU_SRC_NOM] дает течь!"))
	playsound(src, 'sound/effects/spray.ogg', 10, TRUE, -3)

/// Обрабатывает разрыв и фрагментацию
/obj/item/tank/atom_destruction(damage_flag)
	if(!air_contents)
		return ..()

	/// Обработка фрагментации
	var/pressure = air_contents.return_pressure()
	if(pressure > TANK_FRAGMENT_PRESSURE)
		if(!istype(loc, /obj/item/transfer_valve))
			log_bomber(get_mob_by_key(fingerprintslast), "was last key to touch", src, "which ruptured explosively")
		//Дать газу шанс создать больше давления через реакцию
		air_contents.react(src)
		pressure = air_contents.return_pressure()

		// На момент написания это откалибровано на макскап при 140Л и 160атм.
		var/power = (air_contents.volume * (pressure - TANK_FRAGMENT_PRESSURE)) / TANK_FRAGMENT_SCALE
		log_atmos("[type] exploded with a power of [power] and a mix of ", air_contents)
		dyn_explosion(src, power, flash_range = 1.5, ignorecap = FALSE)
	return ..()

/obj/item/tank/proc/merging_information()
	SIGNAL_HANDLER
	if(air_contents.return_pressure() > TANK_FRAGMENT_PRESSURE)
		explosion_info += TANK_MERGE_OVERPRESSURE

/obj/item/tank/proc/explosion_information()
	return list(TANK_RESULTS_REACTION = reaction_info, TANK_RESULTS_MISC = explosion_info)

/obj/item/tank/on_found(mob/finder) //для мышеловок
	. = ..()
	if(tank_assembly)
		tank_assembly.on_found(finder)

/obj/item/tank/attack_hand() //также для мышеловок
	if(..())
		return
	if(tank_assembly)
		tank_assembly.attack_hand()

/obj/item/tank/attack_self(mob/user, modifiers)
	if (tank_assembly)
		tank_assembly.attack_self(user)
		return TRUE
	return ..()

/obj/item/tank/attack_self_secondary(mob/user, modifiers)
	. = ..()
	ui_interact(user)

/obj/item/tank/Move()
	. = ..()
	if(tank_assembly)
		tank_assembly.setDir(dir)

/obj/item/tank/dropped()
	. = ..()
	if(tank_assembly)
		tank_assembly.dropped()

/obj/item/tank/IsSpecialAssembly()
	return TRUE

/obj/item/tank/receive_signal() //Это вызывается в основном датчиком через sense() держателю, и от держателя сюда.
	audible_message(span_warning("[icon2html(src, hearers(src))] *бип* *бип* *бип*"))
	playsound(src, 'sound/machines/beep/triple_beep.ogg', ASSEMBLY_BEEP_VOLUME, TRUE)
	addtimer(CALLBACK(src, PROC_REF(ignite)), 1 SECONDS)

/// Прикрепляет держатель сборки к баку для создания бомбы.
/obj/item/tank/proc/bomb_assemble(obj/item/assembly_holder/assembly, mob/living/user)
	//Проверяем, есть ли в любой части сборки воспламенитель, но если обе части - воспламенители, то к черту это
	var/igniter_count = 0
	for(var/obj/item/assembly/igniter/attached_assembly in assembly.assemblies)
		igniter_count++

	if(LAZYLEN(assembly.assemblies) == igniter_count)
		return

	if(isitem(loc)) // мы внутри предмета для хранения
		balloon_alert(user, "не достать!")
		return

	if((src in user.get_equipped_items(INCLUDE_POCKETS | INCLUDE_ACCESSORIES)) && !user.canUnEquip(src))
		balloon_alert(user, "застряло!")
		return

	if(!user.canUnEquip(assembly))
		balloon_alert(user, "застряло!")
		return

	if(!user.transferItemToLoc(assembly, src))
		balloon_alert(user, "застряло!")
		return

	tank_assembly = assembly //Сообщаем баку о его части сборки
	assembly.master = src //Сообщаем сборке о ее новом владельце
	assembly.on_attach()
	update_weight_class(WEIGHT_CLASS_BULKY)

	balloon_alert(user, "бомба собрана")
	update_appearance(UPDATE_OVERLAYS)

/// Отсоединяет держатель сборки от бака, обезвреживая бомбу
/obj/item/tank/proc/bomb_disassemble(mob/user)
	bomb_status = FALSE
	balloon_alert(user, "бомба обезврежена")
	if(!tank_assembly)
		CRASH("bomb_disassemble() called on a tank with no assembly!")
	user.put_in_hands(tank_assembly)
	tank_assembly.master = null
	tank_assembly = null
	update_weight_class(initial(w_class))
	update_appearance(UPDATE_OVERLAYS)

/// Воспламеняет содержимое бака. Вызывается при получении сигнала, если бак заварен и к нему прикреплен воспламенитель.
/obj/item/tank/proc/ignite()
	if(!bomb_status) // если не заварен, вместо этого выпустить газы
		release()
		return

	// убедитесь, что он еще не взрывается, прежде чем взрывать его
	if(igniting)
		CRASH("ignite() called multiple times on [type]")
	igniting = TRUE

	var/datum/gas_mixture/our_mix = return_air()
	our_mix.assert_gases(/datum/gas/plasma, /datum/gas/oxygen)
	var/fuel_moles = our_mix.gases[/datum/gas/plasma][MOLES] + our_mix.gases[/datum/gas/oxygen][MOLES]/6
	our_mix.garbage_collect()
	var/datum/gas_mixture/bomb_mixture = our_mix.copy()
	var/strength = 1

	var/turf/ground_zero = get_turf(loc)

	/// Используется для определения температуры горячей точки, когда она не может взорваться
	var/igniter_temperature = 0
	for(var/obj/item/assembly/igniter/firestarter in tank_assembly.assemblies)
		igniter_temperature = max(igniter_temperature, firestarter.heat)

	if(!igniter_temperature)
		CRASH("[type] called ignite() without any igniters attached")

	if(bomb_mixture.temperature > (T0C + 400))
		strength = (fuel_moles/15)

		if(strength >= 2)
			explosion(ground_zero, devastation_range = round(strength,1), heavy_impact_range = round(strength*2,1), light_impact_range = round(strength*3,1), flash_range = round(strength*4,1), explosion_cause = src)
		else if(strength >= 1)
			explosion(ground_zero, devastation_range = round(strength,1), heavy_impact_range = round(strength*2,1), light_impact_range = round(strength*2,1), flash_range = round(strength*3,1), explosion_cause = src)
		else if(strength >= 0.5)
			explosion(ground_zero, heavy_impact_range = 1, light_impact_range = 2, flash_range = 4, explosion_cause = src)
		else if(strength >= 0.2)
			explosion(ground_zero, devastation_range = -1, light_impact_range = 1, flash_range = 2, explosion_cause = src)
		else
			ground_zero.assume_air(bomb_mixture)
			ground_zero.hotspot_expose(igniter_temperature, 125)

	else if(bomb_mixture.temperature > (T0C + 250))
		strength = (fuel_moles/20)

		if(strength >= 1)
			explosion(ground_zero, heavy_impact_range = round(strength,1), light_impact_range = round(strength*2,1), flash_range = round(strength*3,1), explosion_cause = src)
		else if(strength >= 0.5)
			explosion(ground_zero, devastation_range = -1, light_impact_range = 1, flash_range = 2, explosion_cause = src)
		else
			ground_zero.assume_air(bomb_mixture)
			ground_zero.hotspot_expose(igniter_temperature, 125)

	else if(bomb_mixture.temperature > (T0C + 100))
		strength = (fuel_moles/25)

		if(strength >= 1)
			explosion(ground_zero, devastation_range = -1, light_impact_range = round(strength,1), flash_range = round(strength*3,1), explosion_cause = src)
		else
			ground_zero.assume_air(bomb_mixture)
			ground_zero.hotspot_expose(igniter_temperature, 125)

	else
		ground_zero.assume_air(bomb_mixture)
		ground_zero.hotspot_expose(igniter_temperature, 125)

	qdel(src)

/// Выпускает воздух, хранящийся в баке. Вызывается при подаче сигнала без заварки или при воспламенении без достаточного давления для взрыва.
/obj/item/tank/proc/release()
	var/datum/gas_mixture/our_mix = return_air()
	var/datum/gas_mixture/removed = remove_air(our_mix.total_moles())
	var/turf/T = get_turf(src)
	if(!T)
		return
	log_atmos("[type] released its contents of ", removed)
	T.assume_air(removed)

#undef ASSEMBLY_BOMB_BASE
#undef ASSEMBLY_BOMB_COEFFICIENT
#undef ASSUME_AIR_DT_FACTOR
