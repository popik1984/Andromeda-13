/*
	Колотые раны
*/
/datum/wound/pierce
	undiagnosed_name = "Прокол"
	threshold_penalty = 5

/datum/wound/pierce/get_self_check_description(self_aware)
	if(!limb.can_bleed())
		return ..()

	switch(severity)
		if(WOUND_SEVERITY_TRIVIAL)
			return span_danger("Она сочится кровью из маленького [LOWER_TEXT(undiagnosed_name || name)].")
		if(WOUND_SEVERITY_MODERATE)
			return span_warning("Она сочится кровью из [LOWER_TEXT(undiagnosed_name || name)].")
		if(WOUND_SEVERITY_SEVERE)
			return span_boldwarning("Она сочится кровью из серьезного [LOWER_TEXT(undiagnosed_name || name)]!")
		if(WOUND_SEVERITY_CRITICAL)
			return span_boldwarning("Она сочится кровью из крупного [LOWER_TEXT(undiagnosed_name || name)]!!")

/datum/wound/pierce/bleed
	name = "Колотая рана"
	sound_effect = 'sound/items/weapons/slice.ogg'
	processes = TRUE
	treatable_tools = list(TOOL_CAUTERY) // ИНСТРУМЕНТ_ПРИЖИГАНИЯ
	base_treat_time = 3 SECONDS
	wound_flags = (ACCEPTS_GAUZE | CAN_BE_GRASPED) // ПРИНИМАЕТ_ПОВЯЗКУ | МОЖЕТ_БЫТЬ_СХВАЧЕНА

	default_scar_file = FLESH_SCAR_FILE

	/// Сколько крови мы начинаем терять, когда эта рана впервые нанесена
	var/initial_flow
	/// Насколько наш кровоток будет естественно уменьшаться в секунду, даже без повязки
	var/clot_rate // СКОРОСТЬ_СВЕРТЫВАНИЯ
	/// Если наложена повязка, какой процент внутреннего кровотечения фактически свертывается от общей скорости впитывания
	var/gauzed_clot_rate

	/// При ударе по этой части тела у нас есть этот шанс потерять немного крови + входящий урон
	var/internal_bleeding_chance
	/// Если мы выделяем кровь при ударе, максимальная потеря крови равна этому * входящий урон
	var/internal_bleeding_coefficient
	/// If TRUE we are ready to be mended in surgery
	VAR_FINAL/mend_state = FALSE

/datum/wound/pierce/bleed/wound_injury(datum/wound/old_wound = null, attack_direction = null)
	set_blood_flow(initial_flow)
	if(limb.can_bleed() && attack_direction && victim.get_blood_volume() > BLOOD_VOLUME_OKAY) // ОБЪЕМ_КРОВИ_НОРМАЛЬНЫЙ
		victim.spray_blood(attack_direction, severity)

	return ..()

/datum/wound/pierce/bleed/receive_damage(wounding_type, wounding_dmg, wound_bonus)
	if(victim.stat == DEAD || (wounding_dmg < 5) || !limb.can_bleed() || !victim.get_blood_volume() || !prob(internal_bleeding_chance + wounding_dmg))
		return
	if(limb.current_gauze?.splint_factor)
		wounding_dmg *= (1 - limb.current_gauze.splint_factor)
	var/blood_bled = rand(1, wounding_dmg * internal_bleeding_coefficient) // лом на 12 брута может вызвать до 15/18/21 потери крови при умер/серьез/крит
	switch(blood_bled)
		if(1 to 6)
			victim.bleed(blood_bled, TRUE)
		if(7 to 13)
			victim.visible_message(
				span_smalldanger("Капли крови разлетаются из дыры в [limb.plaintext_zone] [victim]."),
				span_danger("Вы откашливаете немного крови от удара по вашей [limb.plaintext_zone]."),
				vision_distance = COMBAT_MESSAGE_RANGE,
			)
			victim.bleed(blood_bled, TRUE)
		if(14 to 19)
			victim.visible_message(
				span_smalldanger("Небольшая струйка крови брызгает из дыры в [limb.plaintext_zone] [victim]!"),
				span_danger("Вы выплевываете струйку крови от удара по вашей [limb.plaintext_zone]!"),
				vision_distance = COMBAT_MESSAGE_RANGE,
			)
			victim.create_splatter(victim.dir)
			victim.bleed(blood_bled)
		if(20 to INFINITY)
			victim.visible_message(
				span_danger("Струя крови вытекает из раны в [limb.plaintext_zone] [victim]!"),
				span_bolddanger("Вы давитесь потоком крови от удара по вашей [limb.plaintext_zone]!"),
				vision_distance = COMBAT_MESSAGE_RANGE,
			)
			victim.bleed(blood_bled)
			victim.create_splatter(victim.dir)
			victim.add_splatter_floor(get_step(victim.loc, victim.dir))

/datum/wound/pierce/bleed/get_bleed_rate_of_change()
	// в основном, если вид не истекает кровью, рана застойная и не заживет сама по себе (но и не ухудшится)
	if(!limb.can_bleed())
		return BLOOD_FLOW_STEADY
	if(HAS_TRAIT(victim, TRAIT_BLOOD_FOUNTAIN))
		return BLOOD_FLOW_INCREASING
	if(limb.current_gauze || clot_rate > 0)
		return BLOOD_FLOW_DECREASING
	if(clot_rate < 0)
		return BLOOD_FLOW_INCREASING
	return BLOOD_FLOW_STEADY

/datum/wound/pierce/bleed/handle_process(seconds_per_tick, times_fired)
	if (!victim || HAS_TRAIT(victim, TRAIT_STASIS))
		return


	if(limb.can_bleed())
		if(victim.bodytemperature < (BODYTEMP_NORMAL - 10))
			adjust_blood_flow(-0.1 * seconds_per_tick)
			if(QDELETED(src))
				return
			if(SPT_PROB(2.5, seconds_per_tick))
				to_chat(victim, span_notice("Вы чувствуете, как [LOWER_TEXT(undiagnosed_name || name)] в вашей [limb.plaintext_zone] укрепляется от холода!"))

		if(HAS_TRAIT(victim, TRAIT_BLOOD_FOUNTAIN))
			adjust_blood_flow(0.25 * seconds_per_tick) // старый гепарин просто добавлял +2 к стекам кровотечения за тик, это добавляет 0.5 кровотока ко всем открытым порезам, что, вероятно, даже сильнее, если вы сможете сначала их порезать

	// повязка всегда уменьшает кровоток, даже для неистекающих кровью
	if(limb.current_gauze)
		if(clot_rate > 0)
			adjust_blood_flow(-clot_rate * seconds_per_tick)
		var/gauze_power = limb.current_gauze.absorption_rate // скорость_впитывания
		limb.seep_gauze(gauze_power * seconds_per_tick)
		adjust_blood_flow(-gauze_power * gauzed_clot_rate * seconds_per_tick)
	// иначе свертывание происходит только если истекает кровью
	else if(limb.can_bleed())
		adjust_blood_flow(-clot_rate * seconds_per_tick)

/datum/wound/pierce/bleed/adjust_blood_flow(adjust_by, minimum)
	. = ..()
	if(blood_flow > WOUND_MAX_BLOODFLOW)
		blood_flow = WOUND_MAX_BLOODFLOW
	if(blood_flow <= 0 && !QDELETED(src))
		to_chat(victim, span_green("Дыры на вашей [limb.plaintext_zone] [!limb.can_bleed() ? "зажили" : "перестали кровоточить"]!"))
		qdel(src)

/datum/wound/pierce/bleed/check_grab_treatments(obj/item/tool, mob/user)
	// если мы используем что-то горячее, но не прижигатель, нам нужно сначала агрессивно схватить их,
	// чтобы мы не попытались лечить того, кого мы режем мечом
	return tool.get_temperature()

/datum/wound/pierce/bleed/treat(obj/item/tool, mob/user)
	if(tool.tool_behaviour == TOOL_CAUTERY || tool.get_temperature())
		tool_cauterize(tool, user)

/datum/wound/pierce/bleed/on_xadone(power)
	. = ..()

	if (limb) // родитель может вызвать наше удаление, поэтому разумно проверить, все ли мы еще наложены
		adjust_blood_flow(-0.03 * power) // я думаю, это минимум 3 силы, так что уменьшение кровотока на .09 за тик довольно хорошо за 0 усилий

/datum/wound/pierce/bleed/on_synthflesh(reac_volume)
	. = ..()
	adjust_blood_flow(-0.025 * reac_volume) // 20ед. * 0.05 = -1 кровоток, меньше, чем у порезов, но все равно хорошо, учитывая меньшие скорости кровотечения

/// Если кто-то использует либо инструмент для прижигания, либо что-то горячее, чтобы прижечь этот прокол
/datum/wound/pierce/bleed/proc/tool_cauterize(obj/item/I, mob/user)

	var/improv_penalty_mult = (I.tool_behaviour == TOOL_CAUTERY ? 1 : 1.25) // на 25% дольше и менее эффективно, если вы не используете настоящий прижигатель
	var/self_penalty_mult = (user == victim ? 1.5 : 1) // на 50% дольше и менее эффективно, если вы делаете это себе

	var/treatment_delay = base_treat_time * self_penalty_mult * improv_penalty_mult

	if(HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		treatment_delay *= 0.5
		user.visible_message(span_danger("[user] начинает профессионально прижигать [limb.plaintext_zone] [victim] с помощью [I]..."), span_warning("Вы начинаете прижигать [user == victim ? "свою" : "[limb.plaintext_zone] [victim]"] с помощью [I], держа в памяти указания голо-изображения..."))
	else
		user.visible_message(span_danger("[user] начинает прижигать [limb.plaintext_zone] [victim] с помощью [I]..."), span_warning("Вы начинаете прижигать [user == victim ? "свою" : "[limb.plaintext_zone] [victim]"] с помощью [I]..."))

	playsound(user, 'sound/items/handling/surgery/cautery1.ogg', 75, TRUE)

	if(!do_after(user, treatment_delay, target = victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	playsound(user, 'sound/items/handling/surgery/cautery2.ogg', 75, TRUE)

	var/bleeding_wording = (!limb.can_bleed() ? "дырки" : "кровотечение")
	user.visible_message(span_green("[user] прижигает часть [bleeding_wording] на [victim]."), span_green("Вы прижигаете часть [bleeding_wording] на [victim]."))
	victim.apply_damage(2 + severity, BURN, limb, wound_bonus = CANT_WOUND)
	if(prob(30))
		victim.emote("scream")
	var/blood_cauterized = (0.6 / (self_penalty_mult * improv_penalty_mult))
	adjust_blood_flow(-blood_cauterized)

	if(blood_flow > 0)
		try_treating(I, user)

/datum/wound_pregen_data/flesh_pierce // ПЛОТЬ_ПРОКОЛ
	abstract = TRUE

	required_limb_biostate = BIO_FLESH
	required_wounding_type = WOUND_PIERCE

	wound_series = WOUND_SERIES_FLESH_PUNCTURE_BLEED // СЕРИЯ_РАН_ПЛОТЬ_ПРОКОЛ_КРОВОТЕЧЕНИЕ

/datum/wound/pierce/get_limb_examine_description()
	return span_warning("Плоть на этой конечности выглядит сильно перфорированной.")

/datum/wound/pierce/bleed/moderate
	name = "Рваное ранение"
	desc = "Кожа пациента была разорвана, вызывая сильные синяки и незначительное внутреннее кровотечение в пораженной области."
	treat_text = "Наложите повязку или швы на рану, используйте средства для свертывания крови, \
		прижигание или, в крайних случаях, воздействие экстремального холода или вакуума. \
		Затем следует еда и период отдыха."
	treat_text_short = "Наложите повязку или швы."
	examine_desc = "имеет маленькую, рваную дыру, слегка кровоточащую"
	occur_text = "выбрасывает тонкую струйку крови"
	sound_effect = 'sound/effects/wounds/pierce1.ogg'
	severity = WOUND_SEVERITY_MODERATE
	initial_flow = 1.5
	gauzed_clot_rate = 0.8
	clot_rate = 0.03
	internal_bleeding_chance = 30
	internal_bleeding_coefficient = 1.25
	series_threshold_penalty = 20
	status_effect_type = /datum/status_effect/wound/pierce/moderate
	scar_keyword = "piercemoderate" // "проколумеренный"

	simple_treat_text = "<b>Перевязка</b> раны уменьшит потерю крови, поможет ране закрыться быстрее самостоятельно и ускорит период восстановления крови. Саму рану можно медленно <b>зашить</b>."
	homemade_treat_text = "<b>Чай</b> стимулирует естественные системы заживления организма, слегка ускоряя свертывание. Саму рану также можно промыть в раковине или душе. Другие средства не нужны."

/datum/wound/pierce/bleed/moderate/update_descriptions()
	if(!limb.can_bleed())
		examine_desc = "имеет маленькую, рваную дыру"
		occur_text = "разрывает маленькую дыру"

/datum/wound_pregen_data/flesh_pierce/breakage // РАЗРЫВ
	abstract = FALSE

	wound_path_to_generate = /datum/wound/pierce/bleed/moderate

	threshold_minimum = 30

/datum/wound_pregen_data/flesh_pierce/breakage/get_weight(obj/item/bodypart/limb, woundtype, damage, attack_direction, damage_source)
	if (isprojectile(damage_source))
		return 0
	return weight

/datum/wound/pierce/bleed/moderate/needle_fail // для анализа крови
	name = "Пункционная рана"
	desc = "Кожа пациента была глубоко проколота, вызывая легкое кровотечение."
	treat_text_short = "Наложите повязку или швы."
	examine_desc = "имеет маленькую красную точку от укола, слегка кровоточащую"
	initial_flow = 0.5 // очень незначительное, в основном для атмосферы и напоминания "не делай так, идиот"
	gauzed_clot_rate = 0.1
	clot_rate = 0.03 // быстро закроется сама
	internal_bleeding_chance = 0
	internal_bleeding_coefficient = 1
	threshold_penalty = 5

/datum/wound_pregen_data/flesh_pierce/open_puncture/pinprick // ОТКРЫТЫЙ_ПРОКОЛ/УКОЛ
	wound_path_to_generate = /datum/wound/pierce/bleed/moderate/needle_fail
	can_be_randomly_generated = FALSE
	abstract = FALSE

/datum/wound/pierce/bleed/moderate/projectile
	name = "Сквозное ранение"
	desc = "Кожа пациента была пронзена насквозь, вызывая сильные синяки и незначительное внутреннее кровотечение в пораженной области."
	treat_text = "Наложите повязку или швы на рану, используйте средства для свертывания крови, \
		прижигание или, в крайних случаях, воздействие экстремального холода или вакуума. \
		Затем следует еда и период отдыха."
	examine_desc = "имеет маленькую, круглую дыру, слегка кровоточащую"
	clot_rate = 0

/datum/wound/pierce/bleed/moderate/projectile/update_descriptions()
	if(!limb.can_bleed())
		examine_desc = "имеет маленькую, круглую дыру"
		occur_text = "разрывает маленькую дыру"

/datum/wound_pregen_data/flesh_pierce/breakage/projectile
	wound_path_to_generate = /datum/wound/pierce/bleed/moderate/projectile

/datum/wound_pregen_data/flesh_pierce/breakage/projectile/get_weight(obj/item/bodypart/limb, woundtype, damage, attack_direction, damage_source)
	if (!isprojectile(damage_source))
		return 0
	return weight

/datum/wound/pierce/bleed/severe
	name = "Глубокое рваное ранение"
	desc = "Внутренняя ткань пациента пронзена, вызывая значительное внутреннее кровотечение и снижение стабильности конечности."
	treat_text = "Быстро наложите повязку или швы на рану, используйте средства для свертывания крови или солевой глюкозный раствор, \
		прижигание или, в крайних случаях, воздействие экстремального холода или вакуума. \
		Затем следует прием препаратов железа и период отдыха."
	treat_text_short = "Наложите повязку, швы, средства для свертывания или прижигание."
	examine_desc = "пронзена насквозь, с кусочками ткани, заслоняющими открытую дыру"
	occur_text = "выпускает яростный поток крови, обнажая пронзенную рану"
	sound_effect = 'sound/effects/wounds/pierce2.ogg'
	severity = WOUND_SEVERITY_SEVERE
	initial_flow = 2.25
	gauzed_clot_rate = 0.6
	clot_rate = 0.02
	internal_bleeding_chance = 60
	internal_bleeding_coefficient = 1.5
	series_threshold_penalty = 35
	status_effect_type = /datum/status_effect/wound/pierce/severe
	scar_keyword = "piercesevere" // "проколсерьезный"

	simple_treat_text = "<b>Перевязка</b> раны необходима и уменьшит потерю крови. После этого рану можно <b>зашить</b>, предпочтительно пока пациент отдыхает и/или держится за свою рану."
	homemade_treat_text = "Простыни можно разорвать, чтобы сделать <b>самодельную марлю</b>. <b>Мука, поваренная соль или соль, смешанная с водой</b>, нанесенные непосредственно, помогут остановить поток, хотя несмешанная соль раздразит кожу и ухудшит естественное заживление. Отдых и удержание раны также уменьшат кровотечение."

/datum/wound/pierce/bleed/severe/update_descriptions()
	if(!limb.can_bleed())
		occur_text = "разрывает дыру"

/datum/wound_pregen_data/flesh_pierce/open_puncture
	abstract = FALSE

	wound_path_to_generate = /datum/wound/pierce/bleed/severe

	threshold_minimum = 50

/datum/wound_pregen_data/flesh_pierce/open_puncture/get_weight(obj/item/bodypart/limb, woundtype, damage, attack_direction, damage_source)
	if (isprojectile(damage_source))
		return 0
	return weight

/datum/wound/pierce/bleed/severe/projectile
	name = "Глубокое сквозное ранение"
	examine_desc = "пронзена насквозь, с кусочками ткани, заслоняющими чисто разорванную дыру"
	clot_rate = 0

/datum/wound_pregen_data/flesh_pierce/open_puncture/projectile
	wound_path_to_generate = /datum/wound/pierce/bleed/severe/projectile

/datum/wound_pregen_data/flesh_pierce/open_puncture/projectile/get_weight(obj/item/bodypart/limb, woundtype, damage, attack_direction, damage_source)
	if (!isprojectile(damage_source))
		return 0
	return weight

/datum/wound/pierce/bleed/severe/eye
	name = "Размозжение глазного яблока"
	desc = "Глаз пациента получил экстремальные повреждения, вызывая сильное кровотечение из глазной полости."
	occur_text = "выпускает яростный поток крови, обнажая раздавленное глазное яблоко"
	var/right_side = FALSE

/datum/wound/pierce/bleed/severe/eye/apply_wound(obj/item/bodypart/limb, silent, datum/wound/old_wound, smited, attack_direction, wound_source, replacing, right_side)
	var/obj/item/organ/eyes/eyes = locate() in limb
	if (!istype(eyes))
		return FALSE
	. = ..()
	src.right_side = right_side
	examine_desc = "имеет свой [right_side ? "правый" : "левый"] глаз пронзенным насквозь, кровь хлещет из полости"
	RegisterSignal(limb, COMSIG_BODYPART_UPDATE_WOUND_OVERLAY, PROC_REF(wound_overlay))
	limb.update_part_wound_overlay()

/datum/wound/pierce/bleed/severe/eye/remove_wound(ignore_limb, replaced)
	if (!isnull(limb))
		UnregisterSignal(limb, COMSIG_BODYPART_UPDATE_WOUND_OVERLAY)
	return ..()

/datum/wound/pierce/bleed/severe/eye/proc/wound_overlay(obj/item/bodypart/source, limb_bleed_rate)
	SIGNAL_HANDLER

	if (limb_bleed_rate <= BLEED_OVERLAY_LOW || limb_bleed_rate > BLEED_OVERLAY_GUSH) // НИЗКИЙ_УРОВЕНЬ_КРОВОТЕЧЕНИЯ_ОВЕРЛЕЙ, ПРОРЫВ_КРОВОТЕЧЕНИЯ_ОВЕРЛЕЙ
		return

	if (blood_flow <= BLEED_OVERLAY_LOW)
		return

	source.bleed_overlay_icon = right_side ? "r_eye" : "l_eye" // иконка_кровотечения_оверлей
	return COMPONENT_PREVENT_WOUND_OVERLAY_UPDATE // КОМПОНЕНТ_ПРЕДОТВРАТИТЬ_ОБНОВЛЕНИЕ_ОВЕРЛЕЯ_РАНЫ

/datum/wound_pregen_data/flesh_pierce/open_puncture/eye
	wound_path_to_generate = /datum/wound/pierce/bleed/severe/eye
	viable_zones = list(BODY_ZONE_HEAD)
	can_be_randomly_generated = FALSE

/datum/wound_pregen_data/flesh_pierce/open_puncture/eye/can_be_applied_to(obj/item/bodypart/limb, list/suggested_wounding_types, datum/wound/old_wound, random_roll, duplicates_allowed, care_about_existing_wounds)
	if (isnull(locate(/obj/item/organ/eyes) in limb))
		return FALSE
	return ..()

/datum/wound/pierce/bleed/severe/magicalearpain // что происходит, если вы попытаетесь услышать сердцебиение коррумпированного сердца, не будучи еретиком
	name = "Кровоточащие уши"
	desc = "Уши пациента сильно кровоточат, кровь просачивается через внутреннюю плоть уха каким-то неизвестным образом."
	examine_desc = "покрыты кровью, черно-фиолетовая жидкость течет из ушей"
	occur_text = "заливается, когда две струи черной жидкости брызгают из ушей"
	internal_bleeding_chance = 0 // просто ваши уши

/datum/wound_pregen_data/flesh_pierce/open_puncture/magicalearpain
	wound_path_to_generate = /datum/wound/pierce/bleed/severe/magicalearpain
	viable_zones = list(BODY_ZONE_HEAD)
	can_be_randomly_generated = FALSE

/datum/wound/pierce/bleed/severe/magicalearpain/apply_wound(obj/item/bodypart/limb, silent, datum/wound/old_wound, smited, attack_direction, wound_source, replacing)
	var/obj/item/organ/ears/ears = locate() in limb
	if (!istype(ears))
		return FALSE
	. = ..()

/datum/wound/pierce/bleed/critical
	name = "Разорванная полость"
	desc = "Внутренняя ткань и кровеносная система пациента разорваны, вызывая значительное внутреннее кровотечение и повреждение внутренних органов."
	treat_text = "Немедленно наложите повязку или швы на рану, используйте средства для свертывания крови или солевой глюкозный раствор, \
		прижигание или, в крайних случаях, воздействие экстремального холода или вакуума. \
		Затем следует контролируемое переливание крови."
	treat_text_short = "Наложите повязку, швы, средства для свертывания или прижигание."
	examine_desc = "разорвана насквозь, едва удерживаемая обнаженной костью"
	occur_text = "разрывается на части, разбрасывая куски внутренностей во всех направлениях"
	sound_effect = 'sound/effects/wounds/pierce3.ogg'
	severity = WOUND_SEVERITY_CRITICAL
	initial_flow = 3
	gauzed_clot_rate = 0.4
	internal_bleeding_chance = 80
	internal_bleeding_coefficient = 1.75
	threshold_penalty = 15
	status_effect_type = /datum/status_effect/wound/pierce/critical
	scar_keyword = "piercecritical" // "проколкритический"
	wound_flags = (ACCEPTS_GAUZE | MANGLES_EXTERIOR | CAN_BE_GRASPED) // ИЗУВЕЧИВАЕТ_ЭКСТЕРЬЕР

	simple_treat_text = "<b>Перевязка</b> раны имеет первостепенное значение, как и обращение за прямой медицинской помощью - <b>Смерть</b> наступит, если лечение будет отложено хоть сколько-нибудь, из-за недостатка <b>кислорода</b>, убивающего пациента, поэтому <b>Еда, Железо и солевой раствор</b> всегда рекомендуются после лечения. Эта рана не закроется сама по себе."
	homemade_treat_text = "Простыни можно разорвать, чтобы сделать <b>самодельную марлю</b>. <b>Мука, соль и соленая вода</b>, нанесенные местно, помогут. Падение на землю и удержание раны уменьшит кровоток."

/datum/wound_pregen_data/flesh_pierce/cavity // ПОЛОСТЬ
	abstract = FALSE

	wound_path_to_generate = /datum/wound/pierce/bleed/critical

	threshold_minimum = 100
