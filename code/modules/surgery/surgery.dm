/datum/surgery
	///Название хирургической операции
	var/name = "хирургия"
	///Описание хирургии, что она делает.
	var/desc

	///Битовое поле для флагов, определяющих различное поведение и требования для операции. Смотри __DEFINES/surgery.dm
	var/surgery_flags = SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB
	///Текущий шаг операции, увеличивается каждый раз при выполнении шага.
	var/status = 1
	///Все шаги, которые нужно выполнить для завершения операции.
	var/list/steps = list()
	///Флаг, указывающий выполняется ли в данный момент шаг операции, чтобы предотвратить множественные операции.
	var/step_in_progress = FALSE

	///Часть тела, на которой проводится эта конкретная операция.
	var/location = BODY_ZONE_CHEST
	///Возможные части тела, на которых можно начать операцию.
	var/list/possible_locs = list()
	///Типы мобов, на которых допустимо проводить операцию.
	var/list/target_mobtypes = list(/mob/living/carbon/human)

	///Пациент, на котором проводится операция. Как ни странно, это не всегда карбон.
	VAR_FINAL/mob/living/carbon/target
	///Конкретная часть тела, над которой проводится операция.
	VAR_FINAL/obj/item/bodypart/operated_bodypart
	///Датум раны, над которой проводится операция.
	VAR_FINAL/datum/wound/operated_wound

	///Типы ран, на которые нацелена эта операция.
	var/targetable_wound
	///Типы частей тела, на которых можно проводить эту операцию. Используется для операций на протезах.
	var/requires_bodypart_type = BODYTYPE_ORGANIC

	///Модификатор скорости операции, заданный внешними средствами.
	var/speed_modifier = 1
	///Требует ли операция исследований для выполнения. Если используешь это, нужно добавить дизайн!
	var/requires_tech = FALSE
	///Тип операции, которая после исследования заменит эту операцию в меню операций.
	var/replaced_by
	///Орган, которым непосредственно манипулируют, используется для проверки, остался ли орган в теле после начала операции.
	var/organ_to_manipulate
	/// Количество нарушений стерильности во время операции
	var/sterility_risk_total = 0

/datum/surgery/New(atom/surgery_target, surgery_location, surgery_bodypart)
	. = ..()
	if(!surgery_target)
		return
	target = surgery_target
	target.surgeries += src
	if(surgery_location)
		location = surgery_location
	if(!surgery_bodypart)
		return
	operated_bodypart = surgery_bodypart
	if(targetable_wound)
		operated_wound = operated_bodypart.get_wound_type(targetable_wound)
		operated_wound.attached_surgery = src

	SEND_SIGNAL(surgery_target, COMSIG_MOB_SURGERY_STARTED, src, surgery_location, surgery_bodypart)

/datum/surgery/Destroy()
	if(operated_wound)
		operated_wound.attached_surgery = null
		operated_wound = null
	if(target)
		target.surgeries -= src
		if(!QDELING(target))
			SEND_SIGNAL(target, COMSIG_MOB_SURGERY_FINISHED, type, location, operated_bodypart)
	target = null
	operated_bodypart = null
	return ..()


/datum/surgery/proc/can_start(mob/user, mob/living/patient) //FALSE чтобы не показывать в списке
	SHOULD_CALL_PARENT(TRUE)

	. = TRUE
	if(replaced_by == /datum/surgery)
		return FALSE

	// Истинные хирурги (например, учёные похитителей) не нуждаются в инструкциях
	if(HAS_MIND_TRAIT(user, TRAIT_SURGEON))
		if(replaced_by) // показывать только операции высшего уровня
			return FALSE
		else
			return TRUE

	if(!requires_tech && !replaced_by)
		return TRUE

	if(requires_tech)
		. = FALSE

	var/surgery_signal = SEND_SIGNAL(user, COMSIG_SURGERY_STARTING, src, patient)
	if(surgery_signal & COMPONENT_FORCE_SURGERY)
		return TRUE
	if(surgery_signal & COMPONENT_CANCEL_SURGERY)
		return FALSE

	var/turf/patient_turf = get_turf(patient)

	//Получаем соответствующий операционный компьютер
	var/obj/machinery/computer/operating/opcomputer = locate_operating_computer(patient_turf)
	if (isnull(opcomputer))
		return .
	if(replaced_by in opcomputer.advanced_surgeries)
		return FALSE
	if(type in opcomputer.advanced_surgeries)
		return TRUE
	return .

/datum/surgery/proc/next_step(mob/living/user, modifiers)
	if(location != user.zone_selected)
		return FALSE
	if(user.combat_mode)
		return FALSE
	if(step_in_progress)
		return TRUE

	var/try_to_fail = FALSE
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		try_to_fail = TRUE

	var/datum/surgery_step/surgery_step = GLOB.surgery_steps[steps[status]]
	if(isnull(surgery_step))
		return FALSE
	var/obj/item/tool = user.get_active_held_item()
	if(tool)
		tool = tool.get_proxy_attacker_for(target, user)
	if(surgery_step.try_op(user, target, user.zone_selected, tool, src, try_to_fail))
		return TRUE
	if(!tool)
		return FALSE
	//То, что ты использовал неправильный инструмент, ещё не значит, что ты собирался ударить им пациента
	if((surgery_flags & SURGERY_CHECK_TOOL_BEHAVIOUR) ? tool.tool_behaviour : (tool.item_flags & SURGICAL_TOOL))
		to_chat(user, span_warning("Для этого шага требуется другой инструмент!"))
		return TRUE

	return FALSE

/datum/surgery/proc/get_surgery_next_step()
	if(status < steps.len)
		var/step_type = steps[status + 1]
		return new step_type
	return null

// Завершение операции
/datum/surgery/proc/complete(mob/surgeon)
	SSblackbox.record_feedback("tally", "surgeries_completed", 1, type)
	surgeon.add_mob_memory(/datum/memory/surgery, deuteragonist = surgeon, surgery_type = name)

	// По завершению операции, проверяется общий "штраф" за не соблюдение стерильности
	// Если общая сумма больше 0, то вызывает apply_sterility_consequences, где считается шанс на выпадение осложнения
	if(sterility_risk_total > 0)
		apply_sterility_consequences()

	qdel(src)

// Функция расчёта шанса осложнения при не соблюдении стерильнрсти
/datum/surgery/proc/apply_sterility_consequences()
	// Проверка на null и нулевой риск
	if(!target || sterility_risk_total <= 0)
		return
	// Ограничиваем максимум 100%, пациент не сможет получить 110% шанс на осложнение
	// Просто я уверен, что будет врач, что хуй клал на эту ваши санитарию
	// От чего шанс будет  +100500 и тут пациент в любом случае получит осложнение
	var/final_risk = min(sterility_risk_total, 100)
	// Базовый шанс = риск.  Сделал, чтоб не дёргать final_risk
	var/base_chance = final_risk
	// Модификатор иммунитета пациента. Персонаж и его состояние будет влиять на шанс получение осложнения.
	var/immunity_bonus = 0
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		// Если здоровье больше/меньше, то получает очки имунитета
		if(human_target.health > 90)
			immunity_bonus += 15
		else if(human_target.health > 70) // Сработает ТОЛЬКО если здоровье ≤ 90, если делать просто через if, он даст баф и за > 90 и за > 70, сумарно 25 очков имунитета
			immunity_bonus += 10
		// Как я это оправдываю? Ну блять, имунка хреново работает, от этого и шанс на осложнение выше, чем у здорового
		if(human_target.health < 20)
			immunity_bonus -= 5
		else if(human_target.health < 10)
			immunity_bonus -= 10
		// Старые уязвимее. Аналогично очкам за здоровье
		if(human_target.age > 60)
			immunity_bonus -= 10
		else if(human_target.age > 45)
			immunity_bonus -= 5
	// Итоговый шанс. Мы берём общий штраф после завершения операции и считаем с бонусами (или дебафами) от имунитета пациента
	var/final_chance = clamp(base_chance - immunity_bonus, 0, 100)
	// Тут уже выбирается, повезёт пациенту или нет
	// Если у пациента штраф в 80%, то у него может прокнуть 20%, ибо зачем ему страдать от Лобанова на хирурге
	if(prob(final_chance))
		// Если не повезло, вызывает функцию по выбору осложнения
		select_and_apply_complication(target, final_risk)

/datum/surgery/proc/select_and_apply_complication(mob/living/patient, risk_percent)
	if(!patient || !ishuman(patient))
		return
	// Назначаем пациента на human_patient
	var/mob/living/carbon/human/human_patient = patient
	// Выбор осложнения в зависимости от штрафа за несоблюдение стерильности. Чем выше штраф, тем страшнее болячка.
	var/complication_type
	if(risk_percent <= 50)
		// Лёгкие осложнения
		complication_type = pick(
			/datum/wound/pierce/bleed/moderate,
		)
	else if(risk_percent <= 70)
		// Средние осложнения
		complication_type = pick(
			/datum/wound/pierce/bleed/moderate,
		)
	else if(risk_percent <= 90)
		// Тяжёлые осложнения
		complication_type = pick(
			/datum/wound/pierce/bleed/moderate,
		)
	// Задержка: 3-7 минут (180-420 секунд)
	var/delay = rand(1800, 4200)
	// spawn создаёт отдельную легковесную задачу
	spawn(delay)
		// Проверяем что пациент ещё жив и доступен
		if(!human_patient || human_patient.stat == DEAD || QDELETED(human_patient))
			return
		var/obj/item/bodypart/limb = human_patient.get_bodypart(location)
		if(!limb)
			return
		limb.force_wound_upwards(complication_type)

/// Возвращает ближайший операционный компьютер, связанный с операционным столом
/datum/surgery/proc/locate_operating_computer(turf/patient_turf)
	if (isnull(patient_turf))
		return null

	var/obj/structure/table/optable/operating_table = locate(/obj/structure/table/optable, patient_turf)
	var/obj/machinery/computer/operating/operating_computer = operating_table?.computer

	if (isnull(operating_computer))
		return null

	if(operating_computer.machine_stat & (NOPOWER|BROKEN))
		return null

	return operating_computer

/datum/surgery/advanced
	name = "продвинутая хирургия"
	requires_tech = TRUE

/obj/item/disk/surgery
	name = "Surgery Procedure Disk"
	desc = "Диск, содержащий продвинутые хирургические процедуры, должен быть загружен в операционную консоль."
	icon_state = "datadisk1"
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass=SMALL_MATERIAL_AMOUNT)
	var/list/surgeries

/obj/item/disk/surgery/get_ru_names()
	return list(
		NOMINATIVE = "диск продвинутой хирургии",
		GENITIVE = "диска продвинутой хирургии",
		DATIVE = "диску продвинутой хирургии",
		ACCUSATIVE = "диск продвинутой хирургии",
		INSTRUMENTAL = "диском продвинутой хирургии",
		PREPOSITIONAL = "диске продвинутой хирургии",
	)

/obj/item/disk/surgery/debug
	name = "Debug Surgery Disk"
	desc = "Диск, содержащий все существующие хирургические процедуры. Если ВЫ игрок и ВЫ нашли это, сообщите администрации или кодерам."
	icon_state = "datadisk1"
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass=SMALL_MATERIAL_AMOUNT)

/obj/item/disk/surgery/debug/get_ru_names()
	return list(
		NOMINATIVE = "диск хирургии",
		GENITIVE = "диска хирургии",
		DATIVE = "диску хирургии",
		ACCUSATIVE = "диск хирургии",
		INSTRUMENTAL = "диском хирургии",
		PREPOSITIONAL = "диске хирургии",
	)

/obj/item/disk/surgery/debug/Initialize(mapload)
	. = ..()
	surgeries = list()
	var/list/req_tech_surgeries = subtypesof(/datum/surgery)
	for(var/datum/surgery/beep as anything in req_tech_surgeries)
		if(initial(beep.requires_tech))
			surgeries += beep

//ИНФОРМАЦИЯ
//Проверьте /mob/living/carbon/attackby, чтобы увидеть, как проходит операция, а также /mob/living/carbon/attack_hand.
//Начиная с 21 февраля 2013 года они находятся в code/modules/mob/living/carbon/carbon.dm, строки 459 и 51 соответственно.
//Другие важные переменные: var/list/surgeries (/mob/living) и var/list/organs (/mob/living/carbon)
// var/list/bodyparts (/mob/living/carbon/human) это КОНЕЧНОСТИ моба.
//Хирургические процедуры инициируются attempt_initiate_surgery(), который вызывается хирургическими простынями и простынями кровати.


//TODO
//конкретные шаги для некоторых операций (описательный текст)
//более интересные варианты неудач
//случайные осложнения
//больше операций!
//добавить модификатор вероятности в зависимости от состояния хирурга - здоровье, подёргивания и т.д. слепота, не дай бог.
//помощник для преобразования zone_sel.selecting в часть тела (для урона)


//РЕШЕННЫЕ ПРОБЛЕМЫ //Задачи "Todo", которые были выполнены
//объединить кисти/стопы с руками - Кисти/стопы были удалены - RR
//операции (не шаги), которые можно инициировать на любой части тела (соответствующей местам повреждения) - Считаем это выполненным, см. переменную possible_locs - c0
