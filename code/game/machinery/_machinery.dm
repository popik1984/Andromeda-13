/**
 * Машины в мире, такие как компьютеры, трубы и шлюзы.
 *
 *Обзор:
 *  Используется для создания объектов, которым требуется вызов процедуры на каждом шаге. Стандартное определение 'Initialize()'
 *  сохраняет ссылку на машину src в глобальном списке 'machines list'. Стандартное определение
 *  'Destroy' удаляет ссылку на машину src из глобального списка 'machines list'.
 *
 *Переменные класса:
 *  use_power (num)
 *     текущее состояние автоматического использования энергии.
 *     Возможные значения:
 *        NO_POWER_USE -- нет автоматического использования энергии
 *        IDLE_POWER_USE -- машина использует энергию на уровне холостого хода
 *        ACTIVE_POWER_USE -- машина использует энергию на активном уровне
 *
 *  active_power_usage (num)
 *     Значение количества энергии, используемой в активном режиме
 *
 *  idle_power_usage (num)
 *     Значение количества энергии, используемой в режиме холостого хода
 *
 *  power_channel (num)
 *     Из какого канала брать энергию при потреблении
 *     Возможные значения:
 *        AREA_USAGE_EQUIP:1 -- Канал оборудования
 *        AREA_USAGE_LIGHT:2 -- Канал освещения
 *        AREA_USAGE_ENVIRON:3 -- Канал окружения
 *
 *  component_parts (list)
 *     Список составных частей машины, используется машинами на основе каркаса.
 *
 *  stat (bitflag)
 *     Битовые флаги статуса машины.
 *     Возможные битовые флаги:
 *        BROKEN -- Машина сломана
 *        NOPOWER -- К машине не поступает питание.
 *        MAINT -- машина в данный момент находится на техобслуживании.
 *        EMPED -- временно сломана импульсом ЭМИ
 *
 *Процедуры класса:
 *  Initialize()
 *
 *  Destroy()
 *
 *	update_mode_power_usage()
 *		обновляет переменную static_power_usage этой машины и делает её статическое потребление энергии от зоны точным.
 *		вызывается после изменения потребления энергии в простое или активном режиме.
 *
 *	update_power_channel()
 *		обновляет переменную static_power_usage этой машины и делает её статическое потребление энергии от зоны точным.
 *		вызывается после изменения переменной power_channel или вызова для изменения самой переменной.
 *
 *	unset_static_power()
 *		полностью удаляет текущее статическое потребление энергии этой машины из её зоны.
 *		используется в других процедурах обновления питания для последующего добавления правильного потребления.
 *
 *
 *     Стандартное определение использует 'use_power', 'power_channel', 'active_power_usage',
 *     'idle_power_usage', 'powered()' и 'use_energy()' для реализации поведения.
 *
 *  powered(chan = -1)         'modules/power/power.dm'
 *     Проверяет, имеет ли зона, содержащая объект, доступную энергию для канала питания, заданного в 'chan'. -1 по умолчанию означает power_channel
 *
 *  use_energy(amount, chan=-1)   'modules/power/power.dm'
 *     Вычитает 'amount' из канала питания 'chan' зоны, содержащей объект.
 *
 *  power_change()               'modules/power/power.dm'
 *     Вызывается зоной, содержащей объект, каждый раз, когда эта зона подвергается
 *     изменению состояния питания (в зоне заканчивается энергия или канал зоны отключается).
 *
 *  RefreshParts()               'game/machinery/machine.dm'
 *     Вызывается для обновления переменных в машине, которые зависят от частей,
 *     содержащихся в списке component_parts. (пример: количество стекла и материалов для
 *     автолата)
 *
 *     Стандартное определение ничего не делает.
 *
 *  process()                  'game/machinery/machine.dm'
 *     Вызывается 'подсистемой машин' один раз за тик машин для каждой машины, которая находится в её списке 'machines'.
 *
 *  process_atmos()
 *     Вызывается 'подсистемой воздуха' один раз за атмосферный тик для каждой машины, которая находится в её списке 'atmos_machines'.
 * Compiled by Aygar
 */
/obj/machinery
	name = "machinery"
	icon = 'icons/obj/machines/fax.dmi'
	desc = "Какой-то механизм."
	abstract_type = /obj/machinery
	verb_say = "пищит"
	verb_yell = "ревет"
	pressure_resistance = 15
	pass_flags_self = PASSMACHINE | LETPASSCLICKS
	max_integrity = 200
	layer = BELOW_OBJ_LAYER //чтобы всякое дерьмо, вылетающее из машины, не оказывалось под ней.
	flags_ricochet = RICOCHET_HARD
	receive_ricochet_chance_mod = 0.3
	anchored = TRUE
	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND | INTERACT_ATOM_UI_INTERACT
	blocks_emissive = EMISSIVE_BLOCK_GENERIC
	initial_language_holder = /datum/language_holder/speaking_machine
	armor_type = /datum/armor/obj_machinery

	///см. code/__DEFINES/stat.dm
	var/machine_stat = NONE
	///см. code/__DEFINES/machines.dm
	var/use_power = IDLE_POWER_USE
	///количество статической нагрузки, которое эта машина добавляет в список power_usage своей зоны, когда use_power = IDLE_POWER_USE
	var/idle_power_usage = BASE_MACHINE_IDLE_CONSUMPTION
	///количество статической нагрузки, которое эта машина добавляет в список power_usage своей зоны, когда use_power = ACTIVE_POWER_USE
	var/active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION
	///текущее количество статического потребления энергии, которое эта машина забирает у своей зоны
	var/static_power_usage = 0
	//AREA_USAGE_EQUIP,AREA_USAGE_ENVIRON или AREA_USAGE_LIGHT
	var/power_channel = AREA_USAGE_EQUIP
	///Комбинация факторов, таких как наличие питания, исправность и так далее. Булево значение.
	var/is_operational = TRUE
	///список всех частей, использованных для сборки, если сделано из определённых типов каркасов.
	var/list/component_parts = null
	///Открыта ли панель технического обслуживания машины.
	var/panel_open = FALSE
	///Открыта машина или закрыта
	var/state_open = FALSE
	///Является ли эта машина критически важной для работы станции и должна ли зона быть освобождена от сбоев питания.
	var/critical_machine = FALSE
	///если задано, преобразуется в typecache при инициализации, иначе по умолчанию typecache mob/living
	var/list/occupant_typecache
	///Моб, запечатанный внутри машины
	var/atom/movable/occupant = null
	///Допустимые флаги здесь: START_PROCESSING_ON_INIT или START_PROCESSING_MANUALLY. См. code\__DEFINES\machines.dm для дополнительной информации об этих флагах.
	var/processing_flags = START_PROCESSING_ON_INIT
	///Какую подсистему будет использовать эта машина, обычно SSmachines или SSfastprocess. По умолчанию все машины используют SSmachines. Это вызывает process() машины примерно каждые 2 секунды.
	var/subsystem_type = /datum/controller/subsystem/machines
	///Схема, которая будет создана и вставлена при создании оборудования
	var/obj/item/circuitboard/circuit
	///См. code/DEFINES/interaction_flags.dm
	var/interaction_flags_machine = INTERACT_MACHINE_WIRES_IF_OPEN | INTERACT_MACHINE_ALLOW_SILICON | INTERACT_MACHINE_OPEN_SILICON
	///Отдел, которому мы платим за использование этой машины
	var/payment_department = ACCOUNT_ENG
	///Используется при нарушении НАП, оплата штрафа
	var/fair_market_price = 5
	///Находится ли эта машина в очереди атмосферного оборудования?
	var/atmos_processing = FALSE
	///world.time последнего использования [/mob/living]
	var/last_used_time = 0
	///Тип моба последнего пользователя. Приведение типа к [/mob/living] для использования initial()
	var/mob/living/last_user_mobtype
	///Хотим ли мы перехватывать on_enter_area и on_exit_area?
	///Отключает некоторые оптимизации
	var/always_area_sensitive = FALSE
	///Каково было наше состояние питания в последний раз, когда мы обновляли внешний вид?
	///TRUE для включено, FALSE для выключено, -1 для "никогда не проверялось"
	var/appearance_power_state = -1

/datum/armor/obj_machinery
	melee = 25
	bullet = 10
	laser = 10
	fire = 50
	acid = 70

/obj/machinery/get_ru_names()
	return alist(
		NOMINATIVE = "оборудование",
		GENITIVE = "оборудования",
		DATIVE = "оборудованию",
		ACCUSATIVE = "оборудование",
		INSTRUMENTAL = "оборудованием",
		PREPOSITIONAL = "оборудовании",
	)

///Нужно для машинного каркаса и flatpacker, т.е. именованный аргумент board
/obj/machinery/New(location, obj/item/circuitboard/board, ...)
	if(istype(board))
		circuit = board
		//мы не хотим, чтобы машины, переопределяющие Initialize(), получали плату как параметр, например, atmos
		return ..(location)

	return ..()

/obj/machinery/Initialize(mapload)
	. = ..()
	SSmachines.register_machine(src)

	if(ispath(circuit, /obj/item/circuitboard))
		circuit = new circuit(src)
	if(istype(circuit))
		circuit.apply_default_parts(src)

	if(processing_flags & START_PROCESSING_ON_INIT)
		begin_processing()

	if(occupant_typecache)
		occupant_typecache = typecacheof(occupant_typecache)

	if((resistance_flags & INDESTRUCTIBLE) && component_parts){ // Это необходимо для предотвращения взрыва неразрушимого оборудования. Если взрыв происходит на том же тайле, что и неразрушимое оборудование без флага PREVENT_CONTENTS_EXPLOSION_1, /datum/controller/subsystem/explosions/proc/propagate_blastwave вызовет ex_act для всех подвижных атомов внутри машины, включая плату и компоненты. Однако, если эти части удалятся, вся машина удалится, что позволит уничтожать INDESTRUCTIBLE машины. (См. #62164 для доп. информации)
		flags_1 |= PREVENT_CONTENTS_EXPLOSION_1
	}

	if(HAS_TRAIT(SSstation, STATION_TRAIT_MACHINES_GLITCHED) && mapload)
		randomize_language_if_on_station()
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_NEW_MACHINE, src)

	return INITIALIZE_HINT_LATELOAD

/obj/machinery/LateInitialize()
	SHOULD_NOT_OVERRIDE(TRUE)
	post_machine_initialize()

/**
 * Вызывается в LateInitialize и предназначено для замены его в машинах
 * Это настраивает питание для машины и требует вызова родителя,
 * обеспечивая работу питания на всех машинах, если они не исключены с помощью NO_POWER_USE.
 * Это процедура для переопределения, если вы хотите сделать что-то в LateInitialize.
 */
/obj/machinery/proc/post_machine_initialize()
	PROTECTED_PROC(TRUE)
	SHOULD_CALL_PARENT(TRUE)

	find_and_mount_on_atom(late_init = TRUE)

	power_change()
	if(use_power == NO_POWER_USE)
		return
	update_current_power_usage()
	setup_area_power_relationship()


/obj/machinery/Destroy(force)
	SSmachines.unregister_machine(src)
	end_processing()

	clear_components()
	unset_static_power()

	return ..()

/**
 * процедура для вызова, когда машине начинает требоваться питание после периода отсутствия потребности в нём
 * настраивает связи питания с её зоной, если она существует, и становится чувствительной к зоне
 * не влияет на само потребление энергии
 *
 * Возвращает TRUE, если это вызвало полную регистрацию, иначе FALSE
 * Мы делаем это, чтобы оборудование, которое хочет обойти оптимизацию чувствительности к зоне, могло это сделать
 */
/obj/machinery/proc/setup_area_power_relationship()
	var/area/our_area = get_area(src)
	if(our_area)
		RegisterSignal(our_area, COMSIG_AREA_POWER_CHANGE, PROC_REF(power_change))

	if(HAS_TRAIT_FROM(src, TRAIT_AREA_SENSITIVE, INNATE_TRAIT)) // Если мы по какой-то причине не потеряли чувствительность к зоне, нет смысла настраивать её снова
		return FALSE

	become_area_sensitive(INNATE_TRAIT)
	RegisterSignal(src, COMSIG_ENTER_AREA, PROC_REF(on_enter_area))
	RegisterSignal(src, COMSIG_EXIT_AREA, PROC_REF(on_exit_area))
	return TRUE

/**
 * процедура для вызова, когда машине перестает требоваться питание после периода потребности в нём
 * экономит память, удаляя связь питания с её зоной, если она существует, и теряет чувствительность к зоне
 * не влияет на само потребление энергии
 */
/obj/machinery/proc/remove_area_power_relationship()
	var/area/our_area = get_area(src)
	if(our_area)
		UnregisterSignal(our_area, COMSIG_AREA_POWER_CHANGE)

	if(always_area_sensitive)
		return

	lose_area_sensitivity(INNATE_TRAIT)
	UnregisterSignal(src, COMSIG_ENTER_AREA)
	UnregisterSignal(src, COMSIG_EXIT_AREA)

/obj/machinery/proc/on_enter_area(datum/source, area/area_to_register)
	SIGNAL_HANDLER
	// Если мы всегда чувствительны к зоне, и это вызывается, пока у нас нет потребления энергии, ничего не делаем и возвращаем
	if(always_area_sensitive && use_power == NO_POWER_USE)
		return
	update_current_power_usage()
	power_change()
	RegisterSignal(area_to_register, COMSIG_AREA_POWER_CHANGE, PROC_REF(power_change))

/obj/machinery/proc/on_exit_area(datum/source, area/area_to_unregister)
	SIGNAL_HANDLER
	// Если мы всегда чувствительны к зоне, и это вызывается, пока у нас нет потребления энергии, ничего не делаем и возвращаем
	if(always_area_sensitive && use_power == NO_POWER_USE)
		return
	unset_static_power()
	UnregisterSignal(area_to_unregister, COMSIG_AREA_POWER_CHANGE)

/obj/machinery/proc/set_occupant(atom/movable/new_occupant)
	SHOULD_CALL_PARENT(TRUE)

	SEND_SIGNAL(src, COMSIG_MACHINERY_SET_OCCUPANT, new_occupant)
	occupant = new_occupant

/// Вспомогательная процедура для команды машине начать обработку
/obj/machinery/proc/begin_processing()
	var/datum/controller/subsystem/processing/subsystem = locate(subsystem_type) in Master.subsystems
	START_PROCESSING(subsystem, src)

/// Вспомогательная процедура для команды машине остановить обработку
/obj/machinery/proc/end_processing()
	var/datum/controller/subsystem/processing/subsystem = locate(subsystem_type) in Master.subsystems
	STOP_PROCESSING(subsystem, src)

///Ранняя обработка для машин, добавленных в SSmachines.processing_early для приоритизации потребления энергии
/obj/machinery/proc/process_early()
	set waitfor = FALSE
	return PROCESS_KILL

/obj/machinery/process()//Если вы не используете process или питание, почему вы здесь?
	return PROCESS_KILL

///Поздняя обработка для машин, добавленных в SSmachines.processing_late для сбора точных записей
/obj/machinery/proc/process_late()
	set waitfor = FALSE
	return PROCESS_KILL

/**
 * Process, но для машин, взаимодействующих с атмосферой.
 * Как и process, всё, чувствительное к изменениям времени ожидания между тиками обработки, должно учитывать seconds_per_tick.
**/
/obj/machinery/proc/process_atmos(seconds_per_tick)//Если вы не трогаете атмосферу, почему вы здесь?
	set waitfor = FALSE
	return PROCESS_KILL

///Вызывается, когда мы хотим изменить значение переменной machine_stat. Содержит битовые флаги.
/obj/machinery/proc/set_machine_stat(new_value)
	SHOULD_NOT_OVERRIDE(TRUE)

	if(new_value == machine_stat)
		return
	. = machine_stat
	machine_stat = new_value
	on_set_machine_stat(.)


///Вызывается, когда значение `machine_stat` изменяется, чтобы мы могли отреагировать на это.
/obj/machinery/proc/on_set_machine_stat(old_value)
	PROTECTED_PROC(TRUE)

	//От выкл к вкл.
	if((old_value & (NOPOWER|BROKEN|MAINT)) && !(machine_stat & (NOPOWER|BROKEN|MAINT)))
		set_is_operational(TRUE)
		return
	//От вкл к выкл.
	if(machine_stat & (NOPOWER|BROKEN|MAINT))
		set_is_operational(FALSE)


/obj/machinery/emp_act(severity)
	. = ..()
	if(!use_power || machine_stat || (. & EMP_PROTECT_SELF))
		return
	use_energy(7.5 KILO JOULES / severity)
	new /obj/effect/temp_visual/emp(loc)

	if(!prob(70/severity))
		return
	if (!length(GLOB.uncommon_roundstart_languages))
		return
	remove_all_languages(source = LANGUAGE_EMP)
	grant_random_uncommon_language(source = LANGUAGE_EMP)

/**
 * Открывает машину.
 *
 * Обновит иконку машины и все открытые в данный момент пользовательские интерфейсы.
 * Аргументы:
 * * drop - Булево. Выбрасывать ли любые хранящиеся предметы в машине. Не включает компоненты.
 * * density - Булево. Делать ли объект плотным, когда он открыт.
 */
/obj/machinery/proc/open_machine(drop = TRUE, density_to_set = FALSE)
	state_open = TRUE
	set_density(density_to_set)
	if(drop)
		dump_inventory_contents()
	update_appearance()

/**
 * Выбрасывает каждый подвижный атом из списка содержимого машины, включая любые компоненты и плату.
 */
/obj/machinery/dump_contents()
	// Начинаем с вызова процедуры dump_inventory_contents. Позволит машинам с особым содержимым
	// обработать его сброс.
	dump_inventory_contents()

	// Затем мы можем очистить и выбросить всё остальное.
	var/turf/this_turf = get_turf(src)
	for(var/atom/movable/movable_atom in contents)
		movable_atom.forceMove(this_turf)

	// Мы выбросили обитателя, плату и компоненты как часть этого.
	set_occupant(null)
	circuit = null
	LAZYCLEARLIST(component_parts)

/**
 * Выбрасывает каждый подвижный атом из списка содержимого машины, который не является component_part.
 *
 * Процедура не выбрасывает компоненты и пропускает всё, что находится в списке component_parts.
 * Вызовите dump_contents(), чтобы выбросить всё содержимое, включая компоненты.
 * Аргументы:
 * * subset - Если не null, только атомы, которые также содержатся в списке subset, будут выброшены.
 */
/obj/machinery/proc/dump_inventory_contents(list/subset = null)
	var/turf/this_turf = get_turf(src)
	for(var/atom/movable/movable_atom in contents)
		//чтобы машины вроде микроволновок не выкидывали сигнализаторы после готовки
		if(wires && (movable_atom in assoc_to_values(wires.assemblies)))
			continue

		if(subset && !(movable_atom in subset))
			continue

		if(movable_atom in component_parts)
			continue

		movable_atom.forceMove(this_turf)

		if(occupant == movable_atom)
			set_occupant(null)

/**
 * Кладёт переданный объект в руку пользователя
 *
 * Кладёт переданный объект в руку пользователя, если они находятся рядом.
 * Если пользователь не рядом, помещает объект наверх машины.
 *
 * Переменные:
 * * object (obj) Объект, который нужно поместить в руку пользователя.
 * * user (mob/living) Пользователь для получения объекта
 */
/obj/machinery/proc/try_put_in_hand(obj/item/object, mob/living/user)
	if(!issilicon(user) && in_range(src, user))
		object.do_pickup_animation(user, src)
		user.put_in_hands(object)
	else
		object.forceMove(drop_location())

/obj/machinery/proc/can_be_occupant(atom/movable/occupant_atom)
	return occupant_typecache ? is_type_in_typecache(occupant_atom, occupant_typecache) : isliving(occupant_atom)

/obj/machinery/proc/close_machine(atom/movable/target, density_to_set = TRUE)
	state_open = FALSE
	set_density(density_to_set)
	if (!density)
		update_appearance()
		return

	if(!target)
		for(var/atom in loc)
			if (!(can_be_occupant(atom)))
				continue
			var/atom/movable/current_atom = atom
			if(current_atom.has_buckled_mobs())
				continue
			if(isliving(current_atom))
				var/mob/living/current_mob = atom
				if(current_mob.buckled || current_mob.mob_size >= MOB_SIZE_LARGE)
					continue
			target = atom

	var/mob/living/mobtarget = target
	if(target && !target.has_buckled_mobs() && (!isliving(target) || !mobtarget.buckled))
		set_occupant(target)
		target.forceMove(src)
	update_appearance()

///обновляет переменную use_power для этой машины и обновляет её статическое потребление энергии от зоны, чтобы отразить новое значение
/obj/machinery/proc/update_use_power(new_use_power)
	SHOULD_CALL_PARENT(TRUE)
	if(new_use_power == use_power)
		return FALSE

	unset_static_power()

	var/new_usage = 0
	switch(new_use_power)
		if(IDLE_POWER_USE)
			new_usage = idle_power_usage
		if(ACTIVE_POWER_USE)
			new_usage = active_power_usage

	if(use_power == NO_POWER_USE)
		setup_area_power_relationship()
	else if(new_use_power == NO_POWER_USE)
		remove_area_power_relationship()

	static_power_usage = new_usage

	if(new_usage)
		var/area/our_area = get_area(src)
		our_area?.addStaticPower(new_usage, DYNAMIC_TO_STATIC_CHANNEL(power_channel))

	use_power = new_use_power

	return TRUE

///обновляет канал питания, который использует эта машина. удаляет статическое потребление энергии из старого канала и добавляет его в новый канал
/obj/machinery/proc/update_power_channel(new_power_channel)
	SHOULD_CALL_PARENT(TRUE)
	if(new_power_channel == power_channel)
		return FALSE

	var/usage = unset_static_power()

	var/area/our_area = get_area(src)

	if(our_area && usage)
		our_area.addStaticPower(usage, DYNAMIC_TO_STATIC_CHANNEL(new_power_channel))

	power_channel = new_power_channel

	return TRUE

///внутренняя процедура, которая удаляет всё статическое потребление энергии из текущей зоны
/obj/machinery/proc/unset_static_power()
	SHOULD_NOT_OVERRIDE(TRUE)

	var/old_usage = static_power_usage

	var/area/our_area = get_area(src)

	if(our_area && old_usage)
		our_area.removeStaticPower(old_usage, DYNAMIC_TO_STATIC_CHANNEL(power_channel))
		static_power_usage = 0

	return old_usage

/**
 * устанавливает power_usage, связанный с указанным use_power_mode, в new_usage
 * например, update_mode_power_usage(ACTIVE_POWER_USE, 10) устанавливает active_power_use = 10 и обновляет потребление энергии от зоны машины, если use_power == ACTIVE_POWER_USE
 *
 * Аргументы:
 * * use_power_mode - режим питания use_power для изменения. если IDLE_POWER_USE, меняет idle_power_usage, ACTIVE_POWER_USE меняет active_power_usage
 * * new_usage - новое значение для установки переменной указанного режима питания
 */
/obj/machinery/proc/update_mode_power_usage(use_power_mode, new_usage)
	SHOULD_CALL_PARENT(TRUE)
	if(use_power_mode == NO_POWER_USE)
		stack_trace("trying to set the power usage associated with NO_POWER_USE in update_mode_power_usage()!")
		return FALSE

	unset_static_power() //полностью удалить наше static_power_usage из зоны, затем добавить new_usage

	switch(use_power_mode)
		if(IDLE_POWER_USE)
			idle_power_usage = new_usage
		if(ACTIVE_POWER_USE)
			active_power_usage = new_usage

	if(use_power_mode == use_power)
		static_power_usage = new_usage

	var/area/our_area = get_area(src)

	if(our_area)
		our_area.addStaticPower(static_power_usage, DYNAMIC_TO_STATIC_CHANNEL(power_channel))

	return TRUE

///Получить действительную запитанную зону для ссылки на использование энергии, в основном для настенного оборудования, которое не всегда мапится непосредственно в запитанном месте.
/obj/machinery/proc/get_room_area()
	var/area/machine_area = get_area(src)
	if(isnull(machine_area))
		return null // ??

	// сначала проверьте наш собственный лок, чтобы увидеть, является ли он запитанной зоной
	if(!machine_area.always_unpowered)
		return machine_area

	// зона локации не подошла, проверяем смежную стену на предмет хорошей зоны для использования
	var/turf/mounted_wall = get_step(src, dir)
	if(isclosedturf(mounted_wall))
		var/area/wall_area = get_area(mounted_wall)
		if(!wall_area.always_unpowered)
			return wall_area

	// не смогли найти подходящую запитанную зону на локации или смежной стене, возвращаемся к локации и виним мапперов
	return machine_area

///заставляет эту машину потреблять энергию из своей зоны в соответствии с тем, в какой режим use_power она установлена
/obj/machinery/proc/update_current_power_usage()
	if(static_power_usage)
		unset_static_power()

	var/area/our_area = get_area(src)
	if(!our_area)
		return FALSE

	switch(use_power)
		if(IDLE_POWER_USE)
			static_power_usage = idle_power_usage
		if(ACTIVE_POWER_USE)
			static_power_usage = active_power_usage
		if(NO_POWER_USE)
			return

	if(static_power_usage)
		our_area.addStaticPower(static_power_usage, DYNAMIC_TO_STATIC_CHANNEL(power_channel))

	return TRUE

///Вызывается, когда мы хотим изменить значение переменной `is_operational`. Булево.
/obj/machinery/proc/set_is_operational(new_value)
	SHOULD_NOT_OVERRIDE(TRUE)

	if(new_value == is_operational)
		return
	. = is_operational
	is_operational = new_value
	on_set_is_operational(.)


///Вызывается, когда значение `is_operational` изменяется, чтобы мы могли отреагировать на это.
/obj/machinery/proc/on_set_is_operational(old_value)
	PROTECTED_PROC(TRUE)

	return

///Вызывается, когда мы хотим изменить значение переменной `panel_open`. Булево.
/obj/machinery/proc/set_panel_open(new_value)
	SHOULD_NOT_OVERRIDE(TRUE)

	if(panel_open == new_value)
		return
	var/old_value = panel_open
	panel_open = new_value
	on_set_panel_open(old_value)

///Вызывается, когда значение `panel_open` изменяется, чтобы мы могли отреагировать на это.
/obj/machinery/proc/on_set_panel_open(old_value)
	PROTECTED_PROC(TRUE)

	return

/// Переключает переменную panel_open. Определено для удобства
/obj/machinery/proc/toggle_panel_open()
	SHOULD_NOT_OVERRIDE(TRUE)

	set_panel_open(!panel_open)

/obj/machinery/can_interact(mob/user)
	if(QDELETED(user))
		return FALSE

	if((machine_stat & (NOPOWER|BROKEN)) && !(interaction_flags_machine & INTERACT_MACHINE_OFFLINE)) // Проверяем, сломана ли машина, и можем ли мы с ней взаимодействовать, если да
		return FALSE

	var/try_use_signal = SEND_SIGNAL(user, COMSIG_TRY_USE_MACHINE, src) | SEND_SIGNAL(src, COMSIG_TRY_USE_MACHINE, user)
	if(try_use_signal & COMPONENT_CANT_USE_MACHINE_INTERACT)
		return FALSE

	if(isAdminGhostAI(user))
		return TRUE //Боги обладают неограниченной властью и не заботятся о таких вещах, как дальность или слепота

	if(!isliving(user))
		return FALSE //призракам нельзя, извините

	if(!HAS_SILICON_ACCESS(user) && !user.can_hold_items())
		return FALSE //пауки, брысь

	if(HAS_SILICON_ACCESS(user)) // Если мы силикон, убедимся, что машина позволяет силиконам взаимодействовать с ней
		if(!(interaction_flags_machine & INTERACT_MACHINE_ALLOW_SILICON))
			return FALSE

		if(panel_open && !(interaction_flags_machine & INTERACT_MACHINE_OPEN) && !(interaction_flags_machine & INTERACT_MACHINE_OPEN_SILICON))
			return FALSE

		return user.can_interact_with(src) //ИИ не заботятся о мелких смертных заботах вроде необходимости быть рядом с машиной, чтобы использовать её, но киборги немного заботятся

	. = ..()
	if(!.)
		return FALSE

	if((interaction_flags_machine & INTERACT_MACHINE_REQUIRES_SIGHT) && user.is_blind())
		to_chat(user, span_warning("Необходимо зрение, чтобы использовать это."))
		return FALSE

	// машины имеют свои светящиеся экраны дисплеев и LED кнопки, поэтому нам не нужно проверять свет
	if((interaction_flags_machine & INTERACT_MACHINE_REQUIRES_LITERACY) && !user.can_read(src, READING_CHECK_LITERACY))
		return FALSE

	if(panel_open && !(interaction_flags_machine & INTERACT_MACHINE_OPEN))
		return FALSE

	if(interaction_flags_machine & INTERACT_MACHINE_REQUIRES_SILICON) //если пользователь был силиконом, мы бы вышли раньше, значит, пользователь не должен быть силиконом
		return FALSE

	if(interaction_flags_machine & INTERACT_MACHINE_REQUIRES_STANDING)
		var/mob/living/living_user = user
		if(!(living_user.mobility_flags & MOBILITY_MOVE))
			return FALSE

	return TRUE // Если мы прошли все эти проверки, ура! Мы можем взаимодействовать с этой машиной.

/**
 * Проверяет нарушение НАП (принцип ненападения), анархо-капиталистического события, запускаемого админами,
 * где использование машин стоит денег
 */
/obj/machinery/proc/check_nap_violations()
	PROTECTED_PROC(TRUE)
	SHOULD_NOT_OVERRIDE(TRUE)

	if(!SSeconomy.full_ancap)
		return TRUE
	if(!occupant || state_open)
		return TRUE
	var/mob/living/occupant_mob = occupant
	var/obj/item/card/id/occupant_id = occupant_mob.get_idcard(TRUE)
	if(!occupant_id)
		say("Нарушение НАП Клиентом: ID карта не найдена.")
		nap_violation(occupant_mob)
		return FALSE
	var/datum/bank_account/insurance = occupant_id.registered_account
	if(!insurance)
		say("Нарушение НАП Клиентом: Банковский счет не найден.")
		nap_violation(occupant_mob)
		return FALSE
	if(!insurance.adjust_money(-fair_market_price))
		say("Нарушение НАП Клиентом: Невозможно оплатить.")
		nap_violation(occupant_mob)
		return FALSE
	var/datum/bank_account/department_account = SSeconomy.get_dep_account(payment_department)
	if(department_account)
		department_account.adjust_money(fair_market_price)
	return TRUE

/**
 * Действия, предпринимаемые в случае нарушения НАП
 * Аргументы
 *
 * * mob/violator - моб, нарушивший соглашение НАП
 */
/obj/machinery/proc/nap_violation(mob/violator)
	PROTECTED_PROC(TRUE)

	return

////////////////////////////////////////////////////////////////////////////////////////////

//Верните значение, отличное от FALSE, чтобы прервать распространение attack_hand к подтипам.
/obj/machinery/interact(mob/user)
	update_last_used(user)
	return ..()

/obj/machinery/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	var/mob/user = ui.user
	add_fingerprint(user)
	update_last_used(user)
	if(isAI(user) && !SScameras.is_visible_by_cameras(get_turf(src))) //Мы проверяем конкретно ИИ здесь, так что киборги/админские призраки/человеческие палочки всё ещё могут получить доступ к вещам вне камер.
		to_chat(user, span_warning("Вы больше не можете подключиться к этому устройству!"))
		return FALSE
	return ..()

/obj/machinery/Topic(href, href_list)
	..()
	if(!can_interact(usr))
		return TRUE
	if(!usr.can_perform_action(src, ALLOW_SILICON_REACH))
		return TRUE
	add_fingerprint(usr)
	update_last_used(usr)
	return FALSE

////////////////////////////////////////////////////////////////////////////////////////////

/obj/machinery/attack_paw(mob/living/user, list/modifiers)
	if(!user.combat_mode)
		return attack_hand(user)

	user.changeNext_move(CLICK_CD_MELEE)
	user.do_attack_animation(src, ATTACK_EFFECT_PUNCH)
	var/damage = take_damage(damage_amount = 4, damage_type = BRUTE, damage_flag = MELEE, sound_effect = TRUE, attack_dir = get_dir(user, src))

	var/hit_with_what_noun = "лапами"
	var/obj/item/bodypart/arm/arm = user.get_active_hand()
	if(!isnull(arm))
		hit_with_what_noun = arm.appendage_noun // hit with "their hand"
		//if(user.usable_hands > 1)
		//	hit_with_what_noun += plural_s(hit_with_what_noun) // hit with "their hands"

	user.visible_message(
		span_danger("[user] бьёт [RU_SRC_ACC] [user.p_their()] [hit_with_what_noun][damage ? "." : ", [no_damage_feedback]!"]"),
		span_danger("Вы бьёте [RU_SRC_ACC] своими [hit_with_what_noun][damage ? "." : ", [no_damage_feedback]!"]"),
		span_hear("Вы слышите [damage ? "удар" : "глухой стук"]."),
		COMBAT_MESSAGE_RANGE,
	)
	return TRUE

/obj/machinery/attack_hulk(mob/living/carbon/user)
	. = ..()
	var/obj/item/bodypart/arm = user.get_active_hand()
	if(!arm || arm.bodypart_disabled)
		return
	user.apply_damage(damage_deflection * 0.1, BRUTE, arm, wound_bonus = CANT_WOUND)

/obj/machinery/attack_robot(mob/user)
	if(!(interaction_flags_machine & INTERACT_MACHINE_ALLOW_SILICON) && !isAdminGhostAI(user))
		return FALSE

	if(!Adjacent(user) || !can_buckle || !has_buckled_mobs()) //чтобы киборги (но не ИИ, к сожалению (возможно, в будущем PR?)) могли отстёгивать людей от машин
		return _try_interact(user)

	if(length(buckled_mobs) <= 1)
		if(user_unbuckle_mob(buckled_mobs[1],user))
			return TRUE

	var/unbuckled = tgui_input_list(user, "Кого вы хотите отстегнуть?", "Отстегнуть", sort_names(buckled_mobs))
	if(isnull(unbuckled))
		return FALSE
	if(user_unbuckle_mob(unbuckled,user))
		return TRUE

	return _try_interact(user)

/obj/machinery/attack_ai(mob/user)
	if(!(interaction_flags_machine & INTERACT_MACHINE_ALLOW_SILICON) && !isAdminGhostAI(user))
		return FALSE
	if(!(ROLE_SYNDICATE in user.faction))
		if((ACCESS_SYNDICATE in req_access) || (ACCESS_SYNDICATE_LEADER in req_access) || (ACCESS_SYNDICATE in req_one_access) || (ACCESS_SYNDICATE_LEADER in req_one_access))
			return FALSE
		if((onSyndieBase() && loc != user))
			return FALSE
	if(iscyborg(user))// По какой-то причине attack_robot не работает
		return attack_robot(user)
	return _try_interact(user)

/obj/machinery/attackby(obj/item/weapon, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(.)
		return
	update_last_used(user)

/obj/machinery/attackby_secondary(obj/item/weapon, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(.)
		return
	update_last_used(user)

/obj/machinery/base_item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(SEND_SIGNAL(user, COMSIG_TRY_USE_MACHINE, src) & COMPONENT_CANT_USE_MACHINE_TOOLS)
		return ITEM_INTERACT_BLOCKING

	//имеет приоритет на случай, если контейнер материалов или другие атомы, которые перехватывают сигналы взаимодействия с предметами, не дадут этому шанса
	if(istype(tool, /obj/item/storage/part_replacer))
		update_last_used(user)
		return tool.interact_with_atom(src, user, modifiers)

	. = ..()
	if(.)
		update_last_used(user)

/obj/machinery/_try_interact(mob/user)
	if((interaction_flags_machine & INTERACT_MACHINE_WIRES_IF_OPEN) && panel_open && (attempt_wire_interaction(user) == WIRE_INTERACTION_BLOCK))
		return TRUE
	if(SEND_SIGNAL(user, COMSIG_TRY_USE_MACHINE, src) & COMPONENT_CANT_USE_MACHINE_INTERACT)
		return TRUE
	return ..()

/obj/machinery/on_craft_completion(list/components, datum/crafting_recipe/current_recipe, atom/crafter)
	. = ..()
	RefreshParts()

/obj/machinery/proc/RefreshParts()
	SHOULD_CALL_PARENT(TRUE)
	//сброс к исходному
	idle_power_usage = initial(idle_power_usage)
	active_power_usage = initial(active_power_usage)
	if(!component_parts || !component_parts.len)
		return
	var/parts_energy_rating = 0

	for(var/datum/stock_part/part in component_parts)
		parts_energy_rating += part.energy_rating()

	for(var/obj/item/stock_parts/part in component_parts)
		parts_energy_rating += part.energy_rating

	idle_power_usage = initial(idle_power_usage) * (1 + parts_energy_rating)
	active_power_usage = initial(active_power_usage) * (1 + parts_energy_rating)
	update_current_power_usage()
	SEND_SIGNAL(src, COMSIG_MACHINERY_REFRESH_PARTS)

/obj/machinery/proc/default_pry_open(obj/item/crowbar, close_after_pry = FALSE, open_density = FALSE, closed_density = TRUE)
	PROTECTED_PROC(TRUE)

	. = !(state_open || panel_open || is_operational) && crowbar.tool_behaviour == TOOL_CROWBAR
	if(!.)
		return
	crowbar.play_tool_sound(src, 50)
	visible_message(span_notice("[usr] поддевает и открывает [src]."), span_notice("Вы поддеваете и открываете [src]."))
	open_machine(density_to_set = open_density)
	if (close_after_pry) //Должно ли оно немедленно закрываться после поддевания? (Если нет, оно должно быть закрыто в другом месте)
		close_machine(density_to_set = closed_density)

/obj/machinery/proc/default_deconstruction_crowbar(obj/item/crowbar, ignore_panel = 0, custom_deconstruct = FALSE)
	PROTECTED_PROC(TRUE)

	. = (panel_open || ignore_panel) && crowbar.tool_behaviour == TOOL_CROWBAR
	if(!. || custom_deconstruct)
		return
	crowbar.play_tool_sound(src, 50)
	deconstruct(TRUE)

/obj/machinery/handle_deconstruct(disassembled = TRUE)
	SHOULD_NOT_OVERRIDE(TRUE)

	if(obj_flags & NO_DEBRIS_AFTER_DECONSTRUCTION)
		dump_inventory_contents() //выбросить вещи, которые мы считаем важными
		return //Просто удалите нас, не нужно вызывать что-либо ещё.

	on_deconstruction(disassembled)

	if(circuit)
		spawn_frame(disassembled)

	if(!LAZYLEN(component_parts))
		dump_contents() //выбросить всё внутри нас
		return //у нас нет никаких частей.

	for(var/part in component_parts)
		if(istype(part, /datum/stock_part))
			var/datum/stock_part/datum_part = part
			new datum_part.physical_object_type(loc)
		else
			var/obj/item/obj_part = part
			component_parts -= part
			obj_part.forceMove(loc)
			if(istype(obj_part, /obj/item/circuitboard/machine))
				var/obj/item/circuitboard/machine/board = obj_part
				for(var/component in board.req_components) //цикл по всем компонентам стека и их создание
					if(!ispath(component, /obj/item/stack))
						continue
					var/obj/item/stack/stack_path = component
					new stack_path(loc, board.req_components[component])
	LAZYCLEARLIST(component_parts)

	//выбросить всё внутри нас. мы делаем это в последнюю очередь, чтобы дать машинам шанс
	//обработать их содержимое перед тем, как мы его выбросим
	dump_contents()

/**
 * Создаёт каркас там, где находится эта машина. Если машина не была разобрана,
 * каркас создаётся повреждённым. Если каркас не может существовать на этом тайле, он разбивается
 * в металлические листы.
 *
 * Аргументы:
 * * disassembled - Если FALSE, машина была уничтожена, а не разобрана, и каркас создаётся с уменьшенной прочностью.
 */
/obj/machinery/proc/spawn_frame(disassembled)
	var/obj/structure/frame/machine/new_frame = new /obj/structure/frame/machine(loc)

	new_frame.state = FRAME_STATE_WIRED

	// Если новый каркас не должен умещаться здесь из-за заблокированного тайла, создаём каркас разобранным.
	if(isturf(loc))
		var/turf/machine_turf = loc
		// Мы создаём каркас до того, как эта машина будет qdeleted, поэтому мы хотим игнорировать её. Мы также только что создали новый каркас, поэтому игнорируем и его.
		if(machine_turf.is_blocked_turf(TRUE, source_atom = new_frame, ignore_atoms = list(src)))
			new_frame.deconstruct(disassembled)
			return

	new_frame.update_appearance(UPDATE_ICON_STATE)
	. = new_frame
	new_frame.set_anchored(anchored)
	if(!disassembled)
		new_frame.update_integrity(new_frame.max_integrity * 0.5) //каркас уже наполовину сломан
	transfer_fingerprints_to(new_frame)


/obj/machinery/atom_break(damage_flag)
	. = ..()
	if(!(machine_stat & BROKEN))
		set_machine_stat(machine_stat | BROKEN)
		SEND_SIGNAL(src, COMSIG_MACHINERY_BROKEN, damage_flag)
		update_appearance()
		return TRUE

/obj/machinery/contents_explosion(severity, target)
	if(!occupant)
		return

	switch(severity)
		if(EXPLODE_DEVASTATE)
			SSexplosions.high_mov_atom += occupant
		if(EXPLODE_HEAVY)
			SSexplosions.med_mov_atom += occupant
		if(EXPLODE_LIGHT)
			SSexplosions.low_mov_atom += occupant

/obj/machinery/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == occupant)
		set_occupant(null)
		update_appearance()

	// Плата также должна быть в component parts, так что не выходим раньше времени.
	if(gone == circuit)
		circuit = null
	if((gone in component_parts) && !QDELETED(src))
		component_parts -= gone
		// Было бы необычно, если бы component_part был qdel'нут обычным образом.
		deconstruct(FALSE)

/**
 * Это должно быть вызвано перед массовым qdeling компонентов, чтобы освободить место для замены.
 * Если этого не сделать, всё пойдет наперекосяк, так как Exited() уничтожает машину, когда обнаруживает
 * выход даже одного компонента из атома.
 */
/obj/machinery/proc/clear_components()
	if(!component_parts)
		return
	var/list/old_components = component_parts
	circuit = null
	component_parts = null
	for(var/atom/atom_part in old_components)
		qdel(atom_part)

/obj/machinery/proc/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	if(screwdriver.tool_behaviour != TOOL_SCREWDRIVER)
		return FALSE

	screwdriver.play_tool_sound(src, 50)
	toggle_panel_open()
	if(panel_open)
		icon_state = icon_state_open
		to_chat(user, span_notice("Вы открываете техническую панель [RU_SRC_GEN]."))
	else
		icon_state = icon_state_closed
		to_chat(user, span_notice("Вы закрываете техническую панель [RU_SRC_GEN]."))
	return TRUE

/obj/machinery/proc/default_change_direction_wrench(mob/user, obj/item/wrench)
	if(!panel_open || wrench.tool_behaviour != TOOL_WRENCH)
		return FALSE

	wrench.play_tool_sound(src, 50)
	setDir(turn(dir,-90))
	to_chat(user, span_notice("Вы поворачиваете [RU_SRC_ACC]."))
	SEND_SIGNAL(src, COMSIG_MACHINERY_DEFAULT_ROTATE_WRENCH, user, wrench)
	return TRUE

/obj/machinery/proc/exchange_parts(mob/user, obj/item/storage/part_replacer/replacer_tool)
	if(!istype(replacer_tool) || !component_parts)
		return FALSE

	var/works_from_distance = istype(replacer_tool, /obj/item/storage/part_replacer/bluespace)
	if(!panel_open && !works_from_distance)
		to_chat(user, display_parts(user))
		return FALSE

	var/obj/item/circuitboard/machine/machine_board = locate(/obj/item/circuitboard/machine) in component_parts
	if(works_from_distance)
		to_chat(user, display_parts(user))
	if(!machine_board)
		return FALSE
	/**
	 * сортировка очень важна, особенно потому что мы выходим, когда требуемая часть найдена во внутреннем цикле for
	 * если rped сначала подобрал деталь 3-го тира, А ЗАТЕМ деталь 4-го тира
	 * тир 3 будет установлен, цикл прервется и проверит следующий требуемый компонент, таким образом
	 * полностью игнорируя компонент 4-го тира внутри
	 * мы также игнорируем компоненты стека внутри RPED, потому что мы их не обмениваем
	 */
	var/shouldplaysound = FALSE
	var/list/part_list = replacer_tool.get_sorted_parts(ignore_stacks = TRUE)
	if(!part_list.len)
		return FALSE
	for(var/primary_part_base in component_parts)
		//мы обменяли всё, что могли, пора сворачиваться
		if(!part_list.len)
			break

		var/current_rating
		var/required_type

		//мы не меняем платы, потому что это тупо
		if(istype(primary_part_base, /obj/item/circuitboard))
			continue
		else if(istype(primary_part_base, /datum/stock_part))
			var/datum/stock_part/primary_stock_part = primary_part_base
			current_rating = primary_stock_part.tier
			required_type = primary_stock_part.physical_object_base_type
		else
			var/obj/item/primary_stock_part_item = primary_part_base
			current_rating = primary_stock_part_item.get_part_rating()
			for(var/design_type in machine_board.req_components)
				if(ispath(primary_stock_part_item.type, design_type))
					required_type = design_type
					break

		for(var/obj/item/secondary_part in part_list)
			if(!istype(secondary_part, required_type))
				continue
			// Если это повреждённая или подстроенная ячейка, попытка отправить её через Блюспейс может иметь непредвиденные последствия.
			if(istype(secondary_part, /obj/item/stock_parts/power_store/cell) && works_from_distance)
				var/obj/item/stock_parts/power_store/cell/checked_cell = secondary_part
				// Если она подстроена или повреждена, максимизируем заряд. Затем взрываем её.
				if(checked_cell.rigged || checked_cell.corrupted)
					checked_cell.charge = checked_cell.maxcharge
					checked_cell.explode()
					break
			if(secondary_part.get_part_rating() > current_rating)
				//сохранить имя части на случай, если мы удалим её ниже
				var/secondary_part_name = secondary_part.name
				if(replacer_tool.atom_storage.attempt_remove(secondary_part, src))
					if (istype(primary_part_base, /datum/stock_part))
						var/stock_part_datum = GLOB.stock_part_datums_per_object[secondary_part.type]
						if (isnull(stock_part_datum))
							CRASH("[secondary_part] ([secondary_part.type]) did not have a stock part datum (was trying to find [primary_part_base])")
						component_parts += stock_part_datum
						part_list -= secondary_part //нужно вручную удалить, так как мы больше не ссылаемся на replacer_tool.contents
						qdel(secondary_part)
					else
						component_parts += secondary_part
						secondary_part.forceMove(src)
						part_list -= secondary_part //нужно вручную удалить, так как мы больше не ссылаемся на replacer_tool.contents

				component_parts -= primary_part_base

				var/obj/physical_part
				if (istype(primary_part_base, /datum/stock_part))
					var/datum/stock_part/stock_part_datum = primary_part_base
					var/physical_object_type = stock_part_datum.physical_object_type
					physical_part = new physical_object_type
				else
					physical_part = primary_part_base

				replacer_tool.atom_storage.attempt_insert(physical_part, user, TRUE, force = STORAGE_SOFT_LOCKED)
				to_chat(user, span_notice("[capitalize(physical_part.name)] заменён на [secondary_part_name]."))
				shouldplaysound = TRUE //Воспроизводить звук только при фактической замене деталей!
				break

	RefreshParts()

	if(shouldplaysound)
		replacer_tool.play_rped_effect()
	return TRUE

/obj/machinery/proc/display_parts(mob/user)
	var/list/part_count = list()

	for(var/component_part in component_parts)
		var/obj/item/component_ref

		if (istype(component_part, /datum/stock_part))
			var/datum/stock_part/stock_part = component_part
			component_ref = stock_part.physical_object_reference
		else
			component_ref = component_part
			for(var/obj/item/counted_part in part_count)
				//например, 2 мензурки, хотя они имеют один и тот же тип, всё равно являются 2 разными объектами, поэтому component_ref не будет сохранять их уникальность, так что мы ищем этот тип сами и увеличиваем его
				if(istype(counted_part, component_ref.type))
					part_count[counted_part]++
					component_ref = null
					break
			//похоже, мы уже посчитали тип этой ссылки на объект, пора выходить
			if(!component_ref)
				continue

		if(part_count[component_ref])
			part_count[component_ref]++
			continue
		part_count[component_ref] = 1

		// мы делаем вывод о требуемых стеках внутри машины из запрошенных компонентов платы
		if(istype(component_ref, /obj/item/circuitboard/machine))
			var/obj/item/circuitboard/machine/board = component_ref
			for(var/component in board.req_components)
				if(!ispath(component, /obj/item/stack))
					continue
				part_count[component] = board.req_components[component]


	var/text = span_notice("Содержит следующие детали:")
	for(var/component_part in part_count)
		var/part_name
		var/icon/html_icon
		var/icon_state
		//вывести имя и иконку части. стеки — это просто пути типов, поэтому нам нужно получить их начальные значения
		if(ispath(component_part, /obj/item/stack))
			var/obj/item/stack/stack_ref = component_part
			part_name = initial(stack_ref.singular_name)
			html_icon = initial(stack_ref.icon)
			icon_state = initial(stack_ref.icon_state)
		else
			var/obj/item/part = component_part
			part_name = part.name
			html_icon = part.icon
			icon_state = part.icon_state
		//объединить иконку и имя в текст
		text += span_notice("[icon2html(html_icon, user, icon_state)] [part_count[component_part]] [part_name].")

	return text

/obj/machinery/examine(mob/user)
	. = ..()
	if(machine_stat & BROKEN)
		. += span_notice("Выглядит сломанным и нефункциональным.")
	if(!(resistance_flags & INDESTRUCTIBLE))
		var/healthpercent = (atom_integrity/max_integrity) * 100
		switch(healthpercent)
			if(50 to 99)
				. += "Выглядит слегка повреждённым."
			if(25 to 50)
				. += "Выглядит сильно повреждённым."
			if(0 to 25)
				. += span_warning("Разваливается на части!")

/obj/machinery/examine_descriptor(mob/user)
	return "механизм"

/obj/machinery/examine_more(mob/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_RESEARCH_SCANNER) && component_parts)
		. += display_parts(user)

//вызывается при строительстве техники (т.е. из каркаса в технику), но не при инициализации
/obj/machinery/proc/on_construction(mob/user)
	return

/**
 * вызывается при разборке перед окончательным удалением
 * Аргументы
 *
 * * disassembled - если TRUE, значит мы использовали инструменты для разборки, FALSE означает, что оно было уничтожено другими способами
 */
/obj/machinery/proc/on_deconstruction(disassembled)
	PROTECTED_PROC(TRUE)
	return

/obj/machinery/zap_act(power, zap_flags)
	if(prob(85) && (zap_flags & ZAP_MACHINE_EXPLOSIVE) && !(resistance_flags & INDESTRUCTIBLE))
		explosion(src, devastation_range = 1, heavy_impact_range = 2, light_impact_range = 4, flame_range = 2, adminlog = TRUE, smoke = FALSE)
	else if(zap_flags & ZAP_OBJ_DAMAGE)
		take_damage(power * 2.5e-4, BURN, ENERGY)
		if(prob(40))
			emp_act(EMP_LIGHT)
		power -= power * 5e-4
	return ..()

/obj/machinery/proc/adjust_item_drop_location(atom/movable/dropped_atom) // Отрегулировать место сброса предмета по сетке 3x3 внутри тайла, возвращает id слота от 0 до 8
	var/md5 = md5(dropped_atom.name) // О, и это тоже детерминировано. Конкретный предмет всегда будет падать из одного и того же слота.
	for (var/i in 1 to 32)
		. += hex2num(md5[i])
	. = . % 9
	dropped_atom.pixel_x = -8 + ((.%3)*8)
	dropped_atom.pixel_y = -8 + (round( . / 3)*8)

/obj/machinery/rust_heretic_act(rust_strength)
	var/damage = 500 + rust_strength * 200
	take_damage(damage, BRUTE, BOMB, 1)

/obj/machinery/vv_edit_var(vname, vval)
	if(vname == NAMEOF(src, occupant))
		set_occupant(vval)
		datum_flags |= DF_VAR_EDITED
		return TRUE
	if(vname == NAMEOF(src, machine_stat))
		set_machine_stat(vval)
		datum_flags |= DF_VAR_EDITED
		return TRUE

	return ..()

/**
 * Оповещает ИИ о том, что происходит взлом.
 *
 * Отправляет всем ИИ сообщение о том, что происходит взлом. Специально используется для вмешательства космического ниндзя, так как эта процедура изначально была в файлах ниндзя.
 * Однако, процедура может использоваться и в других местах.
 */
/obj/machinery/proc/AI_notify_hack()
	var/alertstr = span_userdanger("Сетевая тревога: Обнаружена попытка взлома[get_area(src)?" в [get_area_name(src, TRUE)]":". Невозможно определить местоположение"].")
	for(var/mob/living/silicon/ai/AI in GLOB.player_list)
		to_chat(AI, alertstr)

/obj/machinery/proc/update_last_used(mob/user)
	if(isliving(user))
		last_used_time = world.time
		last_user_mobtype = user.type

/// Вызывается, если эта машина должна быть целью саботажа.
/obj/machinery/proc/add_as_sabotage_target()
	return
