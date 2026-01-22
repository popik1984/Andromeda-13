/**
 * Базовый тип почти для всех физических объектов в SS13

 * 	REWOKIN: НЕ ТРОГАТЬ ЭТОТ КОД ИЛИ Я СЛОМАЮ ВАМ РУКИ! ЭТО БЛЯТЬ РОДИТЕЛЬ ВСЕГО НАХУЙ!

 * Здесь находится огромное количество функционала, хотя в целом мы стремимся перенести
 * как можно больше в систему компонентов/элементов
 */
/atom
	abstract_type = /atom
	layer = ABOVE_NORMAL_TURF_LAYER
	plane = GAME_PLANE
	appearance_flags = TILE_BOUND|LONG_GLIDE

	/// pass_flags, которыми мы обладаем. Если любой из них совпадает с pass_flag движущегося объекта, по умолчанию мы пропускаем его.
	var/pass_flags_self = NONE

	///Первый флаговый var для атома
	var/flags_1 = NONE
	///Флаги взаимодействия для атома
	var/interaction_flags_atom = NONE

	var/flags_ricochet = NONE

	///Когда снаряд пытается рикошетить от этого атома, шанс рикошета снаряда умножается на это значение
	var/receive_ricochet_chance_mod = 1
	///Когда снаряд рикошетирует от этого атома, он наносит нормальный урон * этот модификатор данному атому
	var/receive_ricochet_damage_coeff = 0.33

	///Хранилище реагентов
	var/datum/reagents/reagents = null

	///Все HUD-изображения (мед/сек и т.д.) этого атома. Ассоциативный список вида: list(категория HUD = изображение HUD или список изображений для этой категории).
	///В большинстве случаев категория HUD связана с одним изображением, иногда — со списком изображений.
	///Не каждый HUD в этом списке фактически используется. Для доступных другим смотрите active_hud_list.
	var/list/image/hud_list = null
	///Все HUD-изображения этого атома, которые действительно могут видеть игроки с этим HUD
	var/list/image/active_hud_list = null
	///HUD-изображения, которые может предоставлять этот атом.
	var/list/hud_possible

	///Насколько этот атом устойчив к взрывам, в итоге
	var/explosive_resistance = 0

	///Визуальные оверлеи, управляемые SSvis_overlays для автоматического их обновления, как и другие оверлеи.
	var/list/managed_vis_overlays

	///Ленивый список всех изображений (или атомов, простите) (надеюсь, прикрепленных к нам) для обновления при смене Z-уровня
	///Вам нужно будет самостоятельно управлять добавлением/удалением из этого списка, но я сделаю обновление за вас
	var/list/image/update_on_z

	///Ленивый список всех оверлеев, прикрепленных к нам, для обновления при смене Z-уровня
	///Вам нужно будет самостоятельно управлять добавлением/удалением из этого списка, но я сделаю обновление за вас
	///И обратите внимание: если важен порядок добавления, это МОЖЕТ сломать его. Так что будьте осторожны
	var/list/image/update_overlays_on_z

	///Тик кулдауна для сообщений о пристегивании
	var/buckle_message_cooldown = 0
	///Последние отпечатки пальцев, коснувшиеся этого атома
	var/fingerprintslast

	///Типы изоляции от радиации
	var/rad_insulation = RAD_NO_INSULATION

	///Состояние иконки, предназначенное для кислотного компонента. Используется для переопределения стандартного состояния иконки кислотного оверлея.
	var/custom_acid_overlay = null

	var/datum/wires/wires = null

	///Системы освещения, обе не должны быть активны одновременно.
	var/light_system = COMPLEX_LIGHT
	///Дальность света в тайлах. Ноль означает отсутствие света.
	var/light_range = 0
	///Интенсивность света. Чем она выше, тем меньше теней вы увидите на освещенной области.
	var/light_power = 1
	///Шестнадцатеричная RGB строка, представляющая цвет света. По умолчанию белый.
	var/light_color = COLOR_WHITE
	///Угол света для отображения в light_dir
	///360 — это круг, 90 — конус и т.д.
	var/light_angle = 360
	///В каком угле проецировать свет
	var/light_dir = NORTH
	///Булева переменная для переключаемых источников света. Не имеет эффекта без правильных значений light_system, light_range и light_power.
	var/light_on = TRUE
	/// На сколько тайлов "вверх" находится этот свет. 1 — обычно, меняйте это только если это напольный светильник
	var/light_height = LIGHTING_HEIGHT
	///Битовые флаги для определения свойств атома, связанных с освещением.
	var/light_flags = NONE
	///Наш источник света. Не трогайте это напрямую, если у вас нет веской причины!
	var/tmp/datum/light_source/light
	///Любые источники света, которые находятся "внутри" нас, например, если src — это моб, несущий фонарик, источник света этого фонарика будет частью этого списка.
	var/tmp/list/light_sources

	/// Последнее имя, использованное для вычисления цвета оверлеев сообщений в чате
	var/chat_color_name
	/// Последний вычисленный цвет для оверлеев сообщений в чате
	var/chat_color
	/// Затемненное значение последнего вычисленного цвета для оверлеев сообщений в чате, сдвинутое по яркости
	var/chat_color_darkened

	// Используйте SET_BASE_PIXEL(x, y) для установки этих значений в определениях типов, это обработает pixel_x и y за вас
	///Стандартный сдвиг по X для иконки атома.
	var/base_pixel_x = 0
	///Стандартный сдвиг по Y для иконки атома.
	var/base_pixel_y = 0
	// Используйте SET_BASE_VISUAL_PIXEL(x, y) для установки этих значений в определениях типов, это обработает pixel_w и z за вас
	///Стандартный сдвиг по W для иконки атома.
	var/base_pixel_w = 0
	///Стандартный сдвиг по Z для иконки атома.
	var/base_pixel_z = 0
	///Используется для смены состояний иконки для разных базовых спрайтов.
	var/base_icon_state

	///Поведение сглаживания иконок.
	var/smoothing_flags = NONE
	///В каких направлениях сейчас происходит сглаживание. ВАЖНО: Здесь используются флаги направлений сглаживания, определенные в icon_smoothing.dm, а не флаги BYOND.
	var/smoothing_junction = null
	///К каким группам сглаживания принадлежит этот атом, для соответствия canSmoothWith. Если null, никто не может сглаживаться с ним. Должен быть отсортирован.
	var/list/smoothing_groups = null
	///Список групп сглаживания, с которыми может сглаживаться этот атом. Если это null и атом сглаживается, он сглаживается только сам с собой. Должен быть отсортирован.
	var/list/canSmoothWith = null

	///AI контроллер, управляющий этим атомом. Тип при инициализации, затем превращается в экземпляр во время выполнения
	var/datum/ai_controller/ai_controller

	///Датум криминалистики, содержит отпечатки пальцев, волокна, blood_dna и скрытые отпечатки на этом атоме
	var/datum/forensics/forensics = null
	///Кэшированный цвет для всей крови на нас, чтобы избежать постоянных вычислений
	var/cached_blood_color = null
	///Кэшированная эмиссивная альфа для всей крови на нас, чтобы избежать постоянных вычислений
	var/cached_blood_emissive = null

	/// Как этот атом должен реагировать на проверку блокировки astar
	var/can_astar_pass = CANASTARPASS_DENSITY
	///могут ли призраки видеть скрин-подсказки на нем
	var/ghost_screentips = FALSE

	/// Флаги для проверки в can_perform_action. Используются в проверках alt-click и ctrl-click
	var/interaction_flags_click = NONE
	/// Флаги для проверки в can_perform_action для проверок перетаскивания мышью. Чтобы обойти проверки, смотрите флаги mouse drop в interaction_flags_atom
	var/interaction_flags_mouse_drop = NONE

	/// Обычно для нишевых объектов, атомы в черном списке могут спауниться, если разрешено спаунером.
	var/spawn_blacklisted = FALSE

/**
 * Верхний уровень цепочки уничтожения для большинства атомов
 *
 * Очищает следующее:
 * * Удаляет альтернативные внешние виды из HUD'ов, которые их видят
 * * Удаляет держатель реагентов из атомов, если он существует
 * * Очищает список орбитеров
 * * Очищает оверлеи и приоритетные оверлеи
 * * Очищает объект света
 */
/atom/Destroy(force)
	if(alternate_appearances)
		for(var/current_alternate_appearance in alternate_appearances)
			var/datum/atom_hud/alternate_appearance/selected_alternate_appearance = alternate_appearances[current_alternate_appearance]
			selected_alternate_appearance.remove_atom_from_hud(src)

	if(reagents)
		QDEL_NULL(reagents)

	if(forensics)
		QDEL_NULL(forensics)

	if(atom_storage)
		QDEL_NULL(atom_storage)

	if(wires)
		QDEL_NULL(wires)

	orbiters = null // Компонент обычно прикреплен к нам и будет удален в другом месте

	// Проверка length(overlays) перед обрезкой дает значительный прирост производительности
	if (length(overlays))
		overlays.Cut()

	LAZYNULL(managed_overlays)
	if(ai_controller)
		QDEL_NULL(ai_controller)
	if(light)
		QDEL_NULL(light)
	if (length(light_sources))
		light_sources.Cut()

	if(smoothing_flags & SMOOTH_QUEUED)
		SSicon_smooth.remove_from_queues(src)

#ifndef DISABLE_DREAMLUAU
	// Эти списки перестают существовать, когда src исчезает, поэтому нам нужно очистить любые ссылки lua на них, которые существуют.
	if(!(datum_flags & DF_STATIC_OBJECT))
		DREAMLUAU_CLEAR_REF_USERDATA(contents)
		DREAMLUAU_CLEAR_REF_USERDATA(filters)
		DREAMLUAU_CLEAR_REF_USERDATA(overlays)
		DREAMLUAU_CLEAR_REF_USERDATA(underlays)
#endif

	return ..()

/atom/proc/handle_ricochet(obj/projectile/ricocheting_projectile)
	var/turf/p_turf = get_turf(ricocheting_projectile)
	var/face_direction = get_dir(src, p_turf) || get_dir(src, ricocheting_projectile)
	var/face_angle = dir2angle(face_direction)
	var/incidence_s = GET_ANGLE_OF_INCIDENCE(face_angle, (ricocheting_projectile.angle + 180))
	var/a_incidence_s = abs(incidence_s)
	if(a_incidence_s > 90 && a_incidence_s < 270)
		return FALSE
	if((ricocheting_projectile.armor_flag in list(BULLET, BOMB)) && ricocheting_projectile.ricochet_incidence_leeway)
		if((a_incidence_s < 90 && a_incidence_s < 90 - ricocheting_projectile.ricochet_incidence_leeway) || (a_incidence_s > 270 && a_incidence_s -270 > ricocheting_projectile.ricochet_incidence_leeway))
			return FALSE
	var/new_angle_s = SIMPLIFY_DEGREES(face_angle + incidence_s)
	ricocheting_projectile.set_angle(new_angle_s)
	return TRUE

/// Может ли движущийся объект избежать блокировки этим атомом, перемещаясь из (или в) направлении border_dir.
/atom/proc/CanPass(atom/movable/mover, border_dir)
	SHOULD_CALL_PARENT(TRUE)
	SHOULD_BE_PURE(TRUE)
	if(SEND_SIGNAL(src, COMSIG_ATOM_TRIED_PASS, mover, border_dir) & COMSIG_COMPONENT_PERMIT_PASSAGE)
		return TRUE
	if(mover.movement_type & PHASING)
		return TRUE
	. = CanAllowThrough(mover, border_dir)
	// Это дешевле, чем вызывать процедуру каждый раз, так как большинство объектов не переопределяют CanPassThrough
	if(!mover.generic_canpass)
		return mover.CanPassThrough(src, REVERSE_DIR(border_dir), .)

/// Возвращает true или false, чтобы позволить движущемуся объекту пройти через src
/atom/proc/CanAllowThrough(atom/movable/mover, border_dir)
	SHOULD_CALL_PARENT(TRUE)
	//SHOULD_BE_PURE(TRUE)
	if(mover.pass_flags & pass_flags_self)
		return TRUE
	if(mover.throwing && (pass_flags_self & LETPASSTHROW))
		return TRUE
	return !density

/**
 * Находится ли этот атом в данный момент на Ценкоме (или улетает в закат на шаттле)
 *
 * Конкретно, находится ли он на Z-уровне и в пределах зон Ценкома.
 * Вы также можете быть в шаттле во время транзита в конце игры.
 *
 * Используется в игровом режиме для идентификации мобов, которые сбежали, и для некоторых других частей кода,
 * которые не хотят, чтобы атомы находились там, где им не положено.
 *
 * Возвращает TRUE, если этот атом находится на Ценкоме или шаттле побега, или FALSE, если нет.
 */
/atom/proc/onCentCom()
	var/turf/current_turf = get_turf(src)
	if(!current_turf)
		return FALSE

	// Это не обязательно проверяет, что мы на центральном командовании,
	// но проверяет, находятся ли какие-либо шаттлы, которые завершили полет, все еще в гиперпространстве
	// (т.е., такие вещи, как whiteship, которые улетают в закат и "сбегают")
	if(is_reserved_level(current_turf.z))
		return on_escaped_shuttle(ENDGAME_TRANSIT)

	// С этого момента мы заботимся только о людях, фактически находящихся на Z Ценкома
	if(!is_centcom_level(current_turf.z))
		return FALSE

	if(istype(current_turf.loc, /area/centcom))
		return TRUE

	// Наконец, проверяем, находимся ли мы на сбежавшем шаттле
	return on_escaped_shuttle()

/**
 * Находится ли атом в любой из синдикатских зон
 *
 * Либо на базе синдиката, либо на любом из их шаттлов
 *
 * Также используется в коде игрового режима для условий победы
 *
 * Возвращает TRUE, если этот атом находится на разведывательной базе синдиката, любом из его шаттлов или шаттле побега, или FALSE, если нет.
 */
/atom/proc/onSyndieBase()
	var/turf/current_turf = get_turf(src)
	if(!current_turf)
		return FALSE

	// База синдиката загружена на зарезервированном уровне. Если не зарезервирован, нам все равно.
	if(!is_reserved_level(current_turf.z))
		return FALSE

	var/static/list/syndie_typecache = typecacheof(list(
		/area/centcom/syndicate_mothership, // сама база синдиката
		/area/shuttle/assault_pod, // стальной дождь
		/area/shuttle/syndicate, // инфильтратор
	))

	if(is_type_in_typecache(current_turf.loc, syndie_typecache))
		return TRUE

	// Наконец, проверяем, находимся ли мы на сбежавшем шаттле
	return on_escaped_shuttle()

/**
 * Проверяет, что мы на шаттле, который сбежал
 *
 * * check_for_launch_status - Какой статус запуска мы проверяем? Обычно два, которые нужно проверить — это ENDGAME_LAUNCHED или ENDGAME_TRANSIT
 *
 * Возвращает TRUE, если этот атом находится на шаттле, который сбегает или уже сбежал, или FALSE в противном случае.
 */
/atom/proc/on_escaped_shuttle(check_for_launch_status = ENDGAME_LAUNCHED)
	var/turf/current_turf = get_turf(src)
	if(!current_turf)
		return FALSE

	for(var/obj/docking_port/mobile/mobile_docking_port as anything in SSshuttle.mobile_docking_ports)
		if(mobile_docking_port.launch_status != check_for_launch_status)
			continue
		for(var/area/shuttle/shuttle_area as anything in mobile_docking_port.shuttle_areas)
			if(shuttle_area == current_turf.loc)
				return TRUE

	return FALSE

/**
 * Находится ли атом в миссии на отдаленном объекте
 *
 * Должен быть на Z-уровне миссии на отдаленном объекте, чтобы вернуть TRUE
 *
 * Также используется в коде игрового режима для условий победы
 */
/atom/proc/onAwayMission()
	var/turf/current_turf = get_turf(src)
	if(!current_turf)
		return FALSE

	if(is_away_level(current_turf.z))
		return TRUE

	return FALSE

/**
 * Вызывается, когда предмет крафтится, либо через рецепты стеков, либо через рецепты крафта из меню крафта
 *
 * По умолчанию просто перебирает список движущихся объектов, использованных в рецепте, и вызывает used_in_craft() для каждого из них,
 * затем либо перемещает их внутрь объекта, если они находятся в списке частей рецепта,
 * либо удаляет их, если нет.
 * Процедура может быть переопределена подтипами, при условии, что она всегда вызывает родительскую.
 */
/atom/proc/on_craft_completion(list/components, datum/crafting_recipe/current_recipe, atom/crafter)
	SHOULD_CALL_PARENT(TRUE)
	SEND_SIGNAL(src, COMSIG_ATOM_ON_CRAFT, components, current_recipe)
	var/list/remaining_parts = current_recipe?.parts?.Copy()
	var/list/parts_by_type = remaining_parts?.Copy()
	for(var/parttype in parts_by_type) //необходимо для нашего вызова is_type_in_list() с аргументом zebra, установленным в true
		parts_by_type[parttype] = parttype
	for(var/atom/movable/movable as anything in components) // механизмы или структуры в списке гарантированно расходуются. Мы проверяем только предметы.
		movable.used_in_craft(src, current_recipe)
		var/matched_type = is_type_in_list(movable, parts_by_type, zebra = TRUE)
		if(!matched_type)
			continue

		if(isliving(movable.loc) && isitem(movable))
			var/mob/living/living = movable.loc
			living.transferItemToLoc(movable, src)
		else
			movable.forceMove(src)

		if(matched_type)
			remaining_parts[matched_type] -= 1
			if(remaining_parts[matched_type] <= 0)
				remaining_parts -= matched_type

///Забирает воздух из переданного датума газовой смеси
/atom/proc/assume_air(datum/gas_mixture/giver)
	return null

///Удаляет воздух из этого атома
/atom/proc/remove_air(amount)
	return null

///Возвращает текущую воздушную среду в этом атоме
/atom/proc/return_air()
	if(loc)
		return loc.return_air()
	else
		return null

///Возвращает воздух, если мы можем его проанализировать
/atom/proc/return_analyzable_air()
	return null

/atom/proc/Bumped(atom/movable/bumped_atom)
	set waitfor = FALSE
	SEND_SIGNAL(src, COMSIG_ATOM_BUMPED, bumped_atom)

/// Удобная процедура, чтобы проверить, открыт ли контейнер для химической обработки
/atom/proc/is_open_container()
	return is_refillable() && is_drainable()

/// Можно ли вводить этот атом в другие атомы
/atom/proc/is_injectable()
	return reagents && (reagents.flags & (INJECTABLE | REFILLABLE))

/// Можем ли мы забирать из этого атома с помощью инъекционного атома
/atom/proc/is_drawable()
	return reagents && (reagents.flags & (DRAWABLE | DRAINABLE))

/// Можно ли пополнять реагенты этого атома
/atom/proc/is_refillable()
	return reagents && (reagents.flags & REFILLABLE)

/// Можно ли откачивать реагенты из этого атома
/atom/proc/is_drainable()
	return reagents && (reagents.flags & DRAINABLE)

/** Обрабатывает воздействие на этот атом списка реагентов.
 *
 * Отправляет COMSIG_ATOM_EXPOSE_REAGENTS
 * Вызывает expose_atom() для каждого реагента в списке реагентов.
 *
 * Аргументы:
 * - [reagents][/list]: Список реагентов, которым подвергается атом.
 * - [source][/datum/reagents]: Хранилище реагентов, из которого берутся реагенты.
 * - methods: Как атом подвергается воздействию реагентов. Битовые флаги.
 * - show_message: Показывать ли что-либо мобам при воздействии.
 */
/atom/proc/expose_reagents(list/reagents, datum/reagents/source, methods=TOUCH, show_message=TRUE)
	. = SEND_SIGNAL(src, COMSIG_ATOM_EXPOSE_REAGENTS, reagents, source, methods, show_message)
	if(. & COMPONENT_NO_EXPOSE_REAGENTS)
		return

	for(var/datum/reagent/current_reagent as anything in reagents)
		. |= current_reagent.expose_atom(src, reagents[current_reagent], methods)

/// Разрешено ли бросать предметы внутрь этого атома
/atom/proc/AllowDrop()
	return FALSE

///Находится ли этот атом в пределах 1 тайла от другого атома
/atom/proc/HasProximity(atom/movable/proximity_check_mob as mob|obj)
	return

/// Устанавливает датум проводов атома
/atom/proc/set_wires(datum/wires/new_wires)
	wires = new_wires

///Возвращает true, если мы внутри переданного атома
/atom/proc/in_contents_of(container)//может принимать класс или экземпляр объекта в качестве аргумента
	if(ispath(container))
		if(istype(src.loc, container))
			return TRUE
	else if(src in container)
		return TRUE
	return FALSE

/**
 * Проверяет лок атома и вызывает update_held_items на нем, если это моб.
 *
 * Это следует использовать только в ситуациях, когда вы не можете использовать /datum/element/update_icon_updates_onmob по какой-либо причине.
 * Проверьте code/datums/elements/update_icon_updates_onmob.dm перед использованием этого. Добавление этого к атому и вызов update_appearance будет работать в большинстве случаев.
 *
 * Аргументы:
 * * mob/target - Моб, иконки которого нужно обновить. Необязательный аргумент, используйте, если лок атома — не тот моб, которого вы хотите обновить.
 */
/atom/proc/update_inhand_icon(mob/target = loc)
	SHOULD_CALL_PARENT(TRUE)
	if(!istype(target))
		return

	target.update_held_items()

	SEND_SIGNAL(src, COMSIG_ATOM_UPDATE_INHAND_ICON, target)

/**
 * Атом, к которому мы пристегнуты или который содержится внутри нас, попытался переместиться
 *
 * Поведение по умолчанию — отправить предупреждение, что пользователь не может двигаться, пока пристегнут, пока
 * не истек [buckle_message_cooldown][/atom/var/buckle_message_cooldown] (50 тиков)
 */
/atom/proc/relaymove(mob/living/user, direction)
	if(SEND_SIGNAL(src, COMSIG_ATOM_RELAYMOVE, user, direction) & COMSIG_BLOCK_RELAYMOVE)
		return
	if(buckle_message_cooldown <= world.time)
		buckle_message_cooldown = world.time + 25
		balloon_alert(user, "вы пристёгнуты")
	return

/**
 * Особый случай relaymove(), когда человек, передающий движение, может "управлять" этим атомом
 *
 * Это особый случай для транспортных средств и ездовых животных, когда переданное движение может обрабатываться
 * компонентом езды, прикрепленным к этому атому. Возвращает TRUE, пока ничто не блокирует
 * движение, или FALSE, если сигнал получает ответ, который явно блокирует движение
 */
/atom/proc/relaydrive(mob/living/user, direction)
	return !(SEND_SIGNAL(src, COMSIG_RIDDEN_DRIVER_MOVE, user, direction) & COMPONENT_DRIVER_BLOCK_MOVE)

///возвращает информацию о ДНК моба в виде списка для вставки в список blood_DNA объекта
/mob/living/proc/get_blood_dna_list()
	var/datum/blood_type/blood_type = get_bloodtype()
	if (!blood_type)
		return

	return list(blood_type.dna_string = blood_type)

///Получить список ДНК моба
/mob/living/carbon/get_blood_dna_list()
	var/datum/blood_type/blood_type = get_bloodtype()
	if (!blood_type)
		return

	if (dna?.unique_enzymes)
		return list(dna.unique_enzymes = blood_type)
	return list(blood_type.dna_string = blood_type)

/mob/living/silicon/get_blood_dna_list()
	return

///Находится ли этот атом в космосе
/atom/proc/isinspace()
	if(isspaceturf(get_turf(src)))
		return TRUE
	else
		return FALSE

/**
 * Если кто-то пытается сбросить предметы на наш атом, куда их следует сбросить?
 *
 * Верните лок для размещения объектов или null, чтобы остановить сброс.
 */
/atom/proc/get_dumping_location()
	return null

/**
 * нарушение зрения, которое нужно дать мобу, чья перспектива установлена на этот атом
 *
 * (например, несфокусированная камера дает ухудшенное зрение при взгляде через нее)
 */
/atom/proc/get_remote_view_fullscreens(mob/user)
	return

/**
 * изменения зрения, которые нужно дать мобу, чья перспектива установлена на этот атом
 *
 * (например, моб с ночным зрением теряет его при взгляде через обычную камеру)
 */
/atom/proc/update_remote_sight(mob/living/user)
	return


/**
 * Хук для выполнения кода при изменении направления
 *
 * Не рекомендуется к использованию, лучше слушать сигнал [COMSIG_ATOM_DIR_CHANGE] (отправляется этой процедурой)
 */
/atom/proc/setDir(newdir)
	SHOULD_CALL_PARENT(TRUE)
	if (SEND_SIGNAL(src, COMSIG_ATOM_PRE_DIR_CHANGE, dir, newdir) & COMPONENT_ATOM_BLOCK_DIR_CHANGE)
		newdir = dir
		return
	SEND_SIGNAL(src, COMSIG_ATOM_DIR_CHANGE, dir, newdir)
	var/oldDir = dir
	dir = newdir
	SEND_SIGNAL(src, COMSIG_ATOM_POST_DIR_CHANGE, oldDir, newdir)
	if(smoothing_flags & SMOOTH_BORDER_OBJECT)
		QUEUE_SMOOTH_NEIGHBORS(src)

/**
 * Помыть этот атом
 *
 * Это очистит его от любых временных загрязнений, таких как кровь. Переопределите это в вашем предмете, чтобы добавить пользовательское поведение очистки.
 * Возвращает true, если какая-либо мойка была необходима и, следовательно, выполнена
 * Аргументы:
 * * clean_types: любые из констант CLEAN_
 * Возвращает: Битфлаг, если что-то было успешно очищено: например, COMPONENT_CLEANED, или NONE, если нет. Установка COMPONENT_CLEANED_GAIN_XP сигнализирует о том, должна ли очистка давать опыт очистки.
 */
/atom/proc/wash(clean_types)
	SHOULD_CALL_PARENT(TRUE)
	. = SEND_SIGNAL(src, COMSIG_COMPONENT_CLEAN_ACT, clean_types)
	if(.)
		return

	// По сути "если имеет моющуюся окраску"
	if(length(atom_colours) >= WASHABLE_COLOUR_PRIORITY && atom_colours[WASHABLE_COLOUR_PRIORITY])
		remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
		return COMPONENT_CLEANED|COMPONENT_CLEANED_GAIN_XP
	return NONE

///Куда должны падать атомы, если взяты из этого атома
/atom/proc/drop_location()
	var/atom/location = loc
	if(!location)
		return null
	return location.AllowDrop() ? location : location.drop_location()

/**
 * Атом вошел в содержимое этого атома
 *
 * Поведение по умолчанию — отправить сигнал [COMSIG_ATOM_ENTERED]
 */
/atom/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	SEND_SIGNAL(src, COMSIG_ATOM_ENTERED, arrived, old_loc, old_locs)
	SEND_SIGNAL(arrived, COMSIG_ATOM_ENTERING, src, old_loc, old_locs)

/**
 * Атом пытается покинуть содержимое этого атома
 *
 * Поведение по умолчанию — отправить сигнал [COMSIG_ATOM_EXIT]
 */
/atom/Exit(atom/movable/leaving, direction)
	// Не вызывайте `..()` здесь, иначе будет вызван `Uncross()`.
	// Смотрите комментарий к `Uncross()`, чтобы узнать, почему это плохо.

	if(SEND_SIGNAL(src, COMSIG_ATOM_EXIT, leaving, direction) & COMPONENT_ATOM_BLOCK_EXIT)
		return FALSE

	return TRUE

/**
 * Атом покинул содержимое этого атома
 *
 * Поведение по умолчанию — отправить сигнал [COMSIG_ATOM_EXITED]
 */
/atom/Exited(atom/movable/gone, direction)
	SEND_SIGNAL(src, COMSIG_ATOM_EXITED, gone, direction)
	SEND_SIGNAL(gone, COMSIG_ATOM_EXITING, src, direction)

///Возвращает температуру атома
/atom/proc/return_temperature()
	return

/atom/proc/process_recipes(mob/living/user, obj/item/processed_object, list/processing_recipes)
	//Только один рецепт? используем первый
	if(processing_recipes.len == 1)
		StartProcessingAtom(user, processed_object, processing_recipes[1])
		return
	//В противном случае выбираем один через радиальное меню
	ShowProcessingGui(user, processed_object, processing_recipes)

///Создает радиальное меню и обрабатывает выбранный вариант
/atom/proc/ShowProcessingGui(mob/living/user, obj/item/processed_object, list/possible_options)
	var/list/choices_to_options = list() //Словарь имени объекта | словарь настроек обработки объекта
	var/list/choices = list()

	for(var/list/current_option as anything in possible_options)
		var/atom/current_option_type = current_option[TOOL_PROCESSING_RESULT]
		choices_to_options[initial(current_option_type.name)] = current_option
		var/image/option_image = image(icon = initial(current_option_type.icon), icon_state = initial(current_option_type.icon_state))
		choices += list("[initial(current_option_type.name)]" = option_image)

	var/pick = show_radial_menu(user, src, choices, radius = 36, require_near = TRUE)
	if(!pick)
		return

	StartProcessingAtom(user, processed_object, choices_to_options[pick])


/atom/proc/StartProcessingAtom(mob/living/user, obj/item/process_item, list/chosen_option)
	var/processing_time = chosen_option[TOOL_PROCESSING_TIME]
	var/sound_to_play = chosen_option[TOOL_PROCESSING_SOUND]
	to_chat(user, span_notice("Вы начинаете работать над [RU_SRC_INS]."))
	if(sound_to_play)
		playsound(src, sound_to_play, 50, TRUE)
	if(!process_item.use_tool(src, user, processing_time, volume=50))
		return
	var/atom/atom_to_create = chosen_option[TOOL_PROCESSING_RESULT]
	var/list/atom/created_atoms = list()
	var/amount_to_create = chosen_option[TOOL_PROCESSING_AMOUNT]
	for(var/i = 1 to amount_to_create)
		var/atom/created_atom = new atom_to_create(drop_location())
		created_atom.OnCreatedFromProcessing(user, process_item, chosen_option, src)
		if(custom_materials)
			created_atom.set_custom_materials(custom_materials, 1 / amount_to_create)
		created_atom.pixel_x = pixel_x
		created_atom.pixel_y = pixel_y
		if(i > 1)
			created_atom.pixel_x += rand(-8,8)
			created_atom.pixel_y += rand(-8,8)
		created_atoms.Add(created_atom)
	to_chat(user, span_notice("Вам удалось создать [amount_to_create] [initial(atom_to_create.gender) == PLURAL ? "[initial(atom_to_create.name)]" : "[initial(atom_to_create.name)][plural_s(initial(atom_to_create.name))]"] из [RU_SRC_GEN]."))
	SEND_SIGNAL(src, COMSIG_ATOM_PROCESSED, user, process_item, created_atoms)
	UsedforProcessing(user, process_item, chosen_option, created_atoms)

/atom/proc/UsedforProcessing(mob/living/user, obj/item/used_item, list/chosen_option, list/created_atoms)
	qdel(src)
	return

/atom/proc/OnCreatedFromProcessing(mob/living/user, obj/item/work_tool, list/chosen_option, atom/original_atom)
	SHOULD_CALL_PARENT(TRUE)

	if(HAS_TRAIT(original_atom, TRAIT_FOOD_SILVER))
		ADD_TRAIT(src, TRAIT_FOOD_SILVER, INNATE_TRAIT) // вонючая еда всегда вонючая

	SEND_SIGNAL(src, COMSIG_ATOM_CREATEDBY_PROCESSING, original_atom, chosen_option)
	if(user.mind)
		ADD_TRAIT(src, TRAIT_FOOD_CHEF_MADE, REF(user.mind))

///Подключить этот атом к шаттлу
/atom/proc/connect_to_shuttle(mapload, obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	return

/atom/proc/intercept_zImpact(list/falling_movables, levels = 1)
	SHOULD_CALL_PARENT(TRUE)
	. |= SEND_SIGNAL(src, COMSIG_ATOM_INTERCEPT_Z_FALL, falling_movables, levels)

///Сеттер для переменной `density` для добавления поведения, связанного с ее изменением.
/atom/proc/set_density(new_value)
	SHOULD_CALL_PARENT(TRUE)
	if(density == new_value)
		return
	. = density
	density = new_value
	SEND_SIGNAL(src, COMSIG_ATOM_DENSITY_CHANGED)

///Сеттер для переменной `base_pixel_x` для добавления поведения, связанного с ее изменением.
/atom/proc/set_base_pixel_x(new_value)
	if(base_pixel_x == new_value)
		return
	. = base_pixel_x
	base_pixel_x = new_value

	pixel_x = pixel_x + base_pixel_x - .

///Сеттер для переменной `base_pixel_y` для добавления поведения, связанного с ее изменением.
/atom/proc/set_base_pixel_y(new_value)
	if(base_pixel_y == new_value)
		return
	. = base_pixel_y
	base_pixel_y = new_value

	pixel_y = pixel_y + base_pixel_y - .

// Не допустимая операция, тайлы и движущиеся объекты обрабатывают блок по-разному
/atom/proc/set_explosion_block(explosion_block)
	return

/**
 * Возвращает true, если этот атом имеет гравитацию для переданного тайла
 *
 * Отправляет сигналы [COMSIG_ATOM_HAS_GRAVITY] и [COMSIG_TURF_HAS_GRAVITY], оба могут форсировать гравитацию с помощью
 * переменной forced_gravity.
 *
 * Микрооптимизировано до предела, потому что эта процедура очень горячая, вызывается несколько раз за движение при каждом движении.
 *
 * ЭЙ, ОЛУХ, СЛУШАЙ
 * ЕСЛИ ТЫ ДОБАВИШЬ ЧТО-ТО В ЭТУ ПРОЦЕДУРУ, УБЕДИСЬ, ЧТО /mob/living УЧИТЫВАЕТ ЭТО
 * Живые мобы обрабатывают гравитацию событийным образом. Мы разложили эту процедуру на различные проверки
 * для них. Если вы добавите что-то еще, убедитесь, что вы это сделали, иначе все будет вести себя странно
 *
 * Ситуации с гравитацией:
 * * Нет гравитации, если вы не в тайле
 * * Нет гравитации, если этот атом находится в космическом тайле
 * * Нет гравитации, если у зоны есть флаг NO_GRAVITY (космос, место взрыва орбитальной бомбы, ближняя станция, соляры)
 * * Гравитация, если зона, в которой он находится, всегда имеет гравитацию
 * * Гравитация, если на Z-уровне есть генератор гравитации
 * * Гравитация, если у Z-уровня есть SSMappingTrait для ZTRAIT_GRAVITY
 * * в противном случае нет гравитации
 */
/atom/proc/has_gravity(turf/gravity_turf)
	if(!isturf(gravity_turf))
		gravity_turf = get_turf(src)

		if(!gravity_turf)//нет гравитации в нуль-пространстве
			return FALSE

	var/list/forced_gravity = list()
	SEND_SIGNAL(src, COMSIG_ATOM_HAS_GRAVITY, gravity_turf, forced_gravity)
	SEND_SIGNAL(gravity_turf, COMSIG_TURF_HAS_GRAVITY, src, forced_gravity)
	if(length(forced_gravity))
		var/positive_grav = max(forced_gravity)
		var/negative_grav = min(min(forced_gravity), 0) //отрицательная гравитация должна быть ниже или равна 0

		//наша гравитация — это сумма самых больших положительных и отрицательных чисел, возвращенных сигналом
		//чтобы добавление двух элементов forced_gravity с размером эффекта 1 каждый не складывалось в 2 гравитации
		//но эффекты отрицательной силы гравитации могут компенсировать положительные

		return (positive_grav + negative_grav)

	var/area/turf_area = gravity_turf.loc

	return (!gravity_turf.force_no_gravity && !(turf_area.area_flags & NO_GRAVITY)) && (SSmapping.gravity_by_z_level[gravity_turf.z] || turf_area.default_gravity)

/**
 * Используется для установки чего-либо как 'открытого', если это используется в качестве грузового контейнера
 *
 * Переопределите это, если вы хотите, чтобы атом можно было использовать в качестве грузового контейнера.
 */
/atom/proc/setOpened()
	return

/**
 * Используется для установки чего-либо как 'закрытого', если это используется в качестве грузового контейнера
 *
 * Переопределите это, если вы хотите, чтобы атом можно было использовать в качестве грузового контейнера.
 */
/atom/proc/setClosed()
	return

///Вызывается после того, как атом 'приручен' для операций, специфичных для типа. Обычно вызывается компонентом tameable, но также и другими вещами.
/atom/proc/tamed(mob/living/tamer, obj/item/food)
	return

/**
 * Используется для попытки зарядить объект с компонентом оплаты.
 *
 * Используйте это, если атому нужно попытаться зарядить другой атом.
 */
/atom/proc/attempt_charge(atom/sender, atom/target, extra_fees = 0)
	return SEND_SIGNAL(sender, COMSIG_OBJ_ATTEMPT_CHARGE, target, extra_fees)

///Передает клики панели статистики браузера в игру и вызывает клик клиента на атоме
/atom/Topic(href, list/href_list)
	. = ..()
	if(!usr?.client)
		return
	var/client/usr_client = usr.client
	var/list/paramslist = list()

	if(href_list["statpanel_item_click"])
		switch(href_list["statpanel_item_click"])
			if("left")
				paramslist[LEFT_CLICK] = "1"
			if("right")
				paramslist[RIGHT_CLICK] = "1"
			if("middle")
				paramslist[MIDDLE_CLICK] = "1"
			else
				return

		if(href_list["statpanel_item_shiftclick"])
			paramslist[SHIFT_CLICK] = "1"
		if(href_list["statpanel_item_ctrlclick"])
			paramslist[CTRL_CLICK] = "1"
		if(href_list["statpanel_item_altclick"])
			paramslist[ALT_CLICK] = "1"

		var/mouseparams = list2params(paramslist)
		usr_client.Click(src, loc, null, mouseparams)
		return TRUE

/atom/MouseEntered(location, control, params)
	SSmouse_entered.hovers[usr.client] = src

/// Вызывается всякий раз, когда этот атом является самым последним, на который навели курсор за тик.
/// Предпочтительнее MouseEntered, если вам не нужна информация, такая как позиция мыши.
/// Особенно потому, что это отложено на тик, не доверяйте, что `client` не равен null.
/atom/proc/on_mouse_enter(client/client)
	SHOULD_NOT_SLEEP(TRUE)

	var/mob/user = client?.mob
	if (isnull(user))
		return

	SEND_SIGNAL(user, COMSIG_ATOM_MOUSE_ENTERED, src)

	// Скрин-подсказки
	var/datum/hud/active_hud = user.hud_used
	if(!active_hud)
		return

	var/screentips_enabled = active_hud.screentips_enabled
	if(screentips_enabled == SCREENTIP_PREFERENCE_DISABLED || flags_1 & NO_SCREENTIPS_1)
		active_hud.screentip_text.maptext = ""
		return

	var/lmb_rmb_line = ""
	var/ctrl_lmb_ctrl_rmb_line = ""
	var/alt_lmb_alt_rmb_line = ""
	var/shift_lmb_ctrl_shift_lmb_line = ""
	var/extra_lines = 0
	var/extra_context = ""
	var/used_name = RU_SRC_NOM

	if(isliving(user) || isovermind(user) || iscameramob(user) || (ghost_screentips && isobserver(user)))
		var/obj/item/held_item = user.get_active_held_item()

		if (user.mob_flags & MOB_HAS_SCREENTIPS_NAME_OVERRIDE)
			var/list/returned_name = list(used_name)

			var/name_override_returns = SEND_SIGNAL(user, COMSIG_MOB_REQUESTING_SCREENTIP_NAME_FROM_USER, returned_name, held_item, src)
			if (name_override_returns & SCREENTIP_NAME_SET)
				used_name = returned_name[1]

		if (flags_1 & HAS_CONTEXTUAL_SCREENTIPS_1 || held_item?.item_flags & ITEM_HAS_CONTEXTUAL_SCREENTIPS)
			var/list/context = list()

			var/contextual_screentip_returns = \
				SEND_SIGNAL(src, COMSIG_ATOM_REQUESTING_CONTEXT_FROM_ITEM, context, held_item, user) \
				| (held_item && SEND_SIGNAL(held_item, COMSIG_ITEM_REQUESTING_CONTEXT_FOR_TARGET, context, src, user))

			if (contextual_screentip_returns & CONTEXTUAL_SCREENTIP_SET)
				var/screentip_images = active_hud.screentip_images
				// ЛКМ и ПКМ на одной строке...
				var/lmb_text = build_context(context, SCREENTIP_CONTEXT_LMB, screentip_images)
				var/rmb_text = build_context(context, SCREENTIP_CONTEXT_RMB, screentip_images)

				if (lmb_text != "")
					lmb_rmb_line = lmb_text
					if (rmb_text != "")
						lmb_rmb_line += " | [rmb_text]"
				else if (rmb_text != "")
					lmb_rmb_line = rmb_text

				// Ctrl-ЛКМ, Ctrl-ПКМ на одной строке...
				if (lmb_rmb_line != "")
					lmb_rmb_line += "<br>"
					extra_lines++
				if (SCREENTIP_CONTEXT_CTRL_LMB in context)
					ctrl_lmb_ctrl_rmb_line += build_context(context, SCREENTIP_CONTEXT_CTRL_LMB, screentip_images)

				if (SCREENTIP_CONTEXT_CTRL_RMB in context)
					if (ctrl_lmb_ctrl_rmb_line != "")
						ctrl_lmb_ctrl_rmb_line += " | "
					ctrl_lmb_ctrl_rmb_line += build_context(context, SCREENTIP_CONTEXT_CTRL_RMB, screentip_images)

				// Alt-ЛКМ, Alt-ПКМ на одной строке...
				if (ctrl_lmb_ctrl_rmb_line != "")
					ctrl_lmb_ctrl_rmb_line += "<br>"
					extra_lines++
				if (SCREENTIP_CONTEXT_ALT_LMB in context)
					alt_lmb_alt_rmb_line += build_context(context, SCREENTIP_CONTEXT_ALT_LMB, screentip_images)
				if (SCREENTIP_CONTEXT_ALT_RMB in context)
					if (alt_lmb_alt_rmb_line != "")
						alt_lmb_alt_rmb_line += " | "
					alt_lmb_alt_rmb_line += build_context(context, SCREENTIP_CONTEXT_ALT_RMB, screentip_images)

				// Shift-ЛКМ, Ctrl-Shift-ЛКМ на одной строке...
				if (alt_lmb_alt_rmb_line != "")
					alt_lmb_alt_rmb_line += "<br>"
					extra_lines++
				if (SCREENTIP_CONTEXT_SHIFT_LMB in context)
					shift_lmb_ctrl_shift_lmb_line += build_context(context, SCREENTIP_CONTEXT_SHIFT_LMB, screentip_images)
				if (SCREENTIP_CONTEXT_CTRL_SHIFT_LMB in context)
					if (shift_lmb_ctrl_shift_lmb_line != "")
						shift_lmb_ctrl_shift_lmb_line += " | "
					shift_lmb_ctrl_shift_lmb_line += build_context(context, SCREENTIP_CONTEXT_CTRL_SHIFT_LMB, screentip_images)

				if (shift_lmb_ctrl_shift_lmb_line != "")
					extra_lines++

				if(extra_lines)
					extra_context = "<br><span class='subcontext'>[lmb_rmb_line][ctrl_lmb_ctrl_rmb_line][alt_lmb_alt_rmb_line][shift_lmb_ctrl_shift_lmb_line]</span>"

	var/new_maptext
	if (screentips_enabled == SCREENTIP_PREFERENCE_CONTEXT_ONLY && extra_context == "")
		new_maptext = ""
	else
		//Мы встраиваем здесь MAPTEXT(), потому что нет хорошего способа статически добавить к строке, подобной этой
		new_maptext = "<span class='context' style='text-align: center; color: [active_hud.screentip_color]'>[used_name][extra_context]</span>"

	if (length(used_name) * 10 > active_hud.screentip_text.maptext_width)
		INVOKE_ASYNC(src, PROC_REF(set_hover_maptext), client, active_hud, new_maptext)
		return

	active_hud.screentip_text.maptext = new_maptext
	active_hud.screentip_text.maptext_y = 10 - (extra_lines > 0 ? 11 + 9 * (extra_lines - 1): 0)

/atom/proc/set_hover_maptext(client/client, datum/hud/active_hud, new_maptext)
	var/map_height
	WXH_TO_HEIGHT(client.MeasureText(new_maptext, null, active_hud.screentip_text.maptext_width), map_height)
	active_hud.screentip_text.maptext = new_maptext
	active_hud.screentip_text.maptext_y = 26 - map_height

/**
 * Эта процедура используется для определения, может ли что-то пройти мимо этого атома в заданном направлении, для использования системой поиска пути.
 *
 * Попытка сгенерировать один длинный путь через станцию вызовет эту процедуру на каждом объекте на каждом тайле, через который мы пытаемся пройти, вероятно,
 * несколько раз на тайл, поскольку мы, скорее всего, проверяем, можем ли мы получить доступ к этому тайлу с нескольких направлений, так что делайте это как можно легче.
 *
 * Для тайлов это будет использоваться только если pathing_pass_method равен TURF_PATHING_PASS_PROC
 *
 * Аргументы:
 * * to_dir - В каком направлении мы пытаемся двигаться, актуально для таких вещей, как направленные окна, которые блокируют движение только в определенных направлениях
 * * pass_info - Датум, который хранит информацию о том, что пытается пройти через нас
 *
 * ВАЖНОЕ ПРИМЕЧАНИЕ: /turf/proc/LinkBlockedWithAccess предполагает, что переопределения CanAStarPass всегда возвращают true, если density равна FALSE
 * Если это НЕ ваш случай, убедитесь, что вы редактируете свою переменную can_astar_pass. Проверьте __DEFINES/path.dm
 **/
/atom/proc/CanAStarPass(to_dir, datum/can_pass_info/pass_info)
	if(pass_info.pass_flags & pass_flags_self)
		return TRUE
	. = !density
