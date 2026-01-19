/*
	Тупые/Костные травмы
*/

/datum/wound/blunt
	name = "Травма"
	sound_effect = 'sound/effects/wounds/crack1.ogg'
	undiagnosed_name = "Болезненный Ушиб"

/datum/wound_pregen_data/bone
	abstract = TRUE
	required_limb_biostate = BIO_BONE // БИО_КОСТЬ

	required_wounding_type = WOUND_BLUNT // ТУПАЯ_ТРАВМА

	wound_series = WOUND_SERIES_BONE_BLUNT_BASIC // СЕРИЯ_РАН_КОСТЬ_ТУПАЯ_БАЗОВАЯ

/datum/wound/blunt/bone
	name = "Тупая травма"
	wound_flags = (ACCEPTS_GAUZE) // ПРИНИМАЕТ_ПОВЯЗКУ

	default_scar_file = BONE_SCAR_FILE // ФАЙЛ_ШРАМОВ_КОСТИ
	threshold_penalty = 5

	/// Были ли мы обработаны костным гелем?
	var/gelled
	/// Были ли мы заклеены?
	var/taped
	/// Если мы использовали метод лечения переломов гелем + хирургической лентой, сколько тиков требуется для заживления по умолчанию
	var/regen_ticks_needed
	/// Наш текущий счетчик для регенерации гелем + хирургической лентой
	var/regen_ticks_current
	/// Если мы страдаем от серьезных повреждений головы, мы можем получить связанные с ними травмы мозга
	var/datum/brain_trauma/active_trauma
	/// Какая группа травм мозга, если есть, может быть использована для ран головы
	var/brain_trauma_group
	/// Если мы вызываем травмы мозга, когда следующая должна произойти?
	var/next_trauma_cycle
	/// Как долго мы ждем +/- 20% до следующей травмы?
	var/trauma_cycle_cooldown
	/// Если это рана груди и это установлено, у нас есть этот шанс откашлять кровь при ударе в грудь
	var/internal_bleeding_chance = 0 // ШАНС_ВНУТРЕННЕГО_КРОВОТЕЧЕНИЯ

/*
	Переопределение базовых процедур
*/
/datum/wound/blunt/bone/wound_injury(datum/wound/old_wound = null, attack_direction = null)
	// перехват наложения/снятия повязки, чтобы критические костные травмы могли включаться/выключаться в зависимости от того, наложена ли шина
	if(limb.body_zone == BODY_ZONE_HEAD && brain_trauma_group)
		processes = TRUE
		active_trauma = victim.gain_trauma_type(brain_trauma_group, TRAUMA_RESILIENCE_WOUND) // УСТОЙЧИВОСТЬ_К_ТРАВМЕ_РАНА
		next_trauma_cycle = world.time + (rand(100-WOUND_BONE_HEAD_TIME_VARIANCE, 100+WOUND_BONE_HEAD_TIME_VARIANCE) * 0.01 * trauma_cycle_cooldown)

	if(limb.held_index && victim.get_item_for_held_index(limb.held_index) && (disabling || prob(30 * severity)))
		var/obj/item/I = victim.get_item_for_held_index(limb.held_index)
		if(istype(I, /obj/item/offhand)) // предмет_в_другой_руке
			I = victim.get_inactive_held_item() // неактивный_предмет_в_руке

		if(I && victim.dropItemToGround(I))
			victim.visible_message(span_danger("[victim] роняет [I] от шока!"), span_warning("<b>Сила воздействия на вашу [limb.plaintext_zone] заставляет вас уронить [I]!</b>"), vision_distance=COMBAT_MESSAGE_RANGE) // ДИАПАЗОН_БОЕВОГО_СООБЩЕНИЯ

	update_inefficiencies()
	return ..()

/datum/wound/blunt/bone/set_victim(new_victim)

	if (victim)
		UnregisterSignal(victim, list(COMSIG_LIVING_UNARMED_ATTACK, COMSIG_MOB_FIRED_GUN)) // СИГНАЛ_ЖИВОЕ_БЕЗОРУЖНОЕ_НАПАДЕНИЕ, СИГНАЛ_МОБ_ПРОИЗВЕЛ_ВЫСТРЕЛ_ИЗ_ОРУЖИЯ
	if (new_victim)
		RegisterSignal(new_victim, COMSIG_LIVING_UNARMED_ATTACK, PROC_REF(attack_with_hurt_hand))
		RegisterSignal(new_victim, COMSIG_MOB_FIRED_GUN, PROC_REF(firing_with_messed_up_hand))

	return ..()

/datum/wound/blunt/bone/remove_wound(ignore_limb, replaced)
	limp_slowdown = 0
	limp_chance = 0
	QDEL_NULL(active_trauma)
	return ..()

/datum/wound/blunt/bone/handle_process(seconds_per_tick, times_fired)
	. = ..()

	if (!victim || HAS_TRAIT(victim, TRAIT_STASIS)) // СТАЗИС
		return

	if(limb.body_zone == BODY_ZONE_HEAD && brain_trauma_group && world.time > next_trauma_cycle)
		if(active_trauma)
			QDEL_NULL(active_trauma)
		else
			active_trauma = victim.gain_trauma_type(brain_trauma_group, TRAUMA_RESILIENCE_WOUND) // УСТОЙЧИВОСТЬ_К_ТРАВМЕ_РАНА
		next_trauma_cycle = world.time + (rand(100-WOUND_BONE_HEAD_TIME_VARIANCE, 100+WOUND_BONE_HEAD_TIME_VARIANCE) * 0.01 * trauma_cycle_cooldown)

	var/is_bone_limb = ((limb.biological_state & BIO_BONE) && !(limb.biological_state & (BIO_FLESH|BIO_CHITIN)))
	if(!gelled || (!taped && !is_bone_limb))
		return

	regen_ticks_current++
	if(victim.body_position == LYING_DOWN) // ЛЕЖИТ
		if(SPT_PROB(30, seconds_per_tick))
			regen_ticks_current += 1
		if(victim.IsSleeping() && SPT_PROB(30, seconds_per_tick))
			regen_ticks_current += 1

	if(!is_bone_limb && SPT_PROB(severity * 1.5, seconds_per_tick))
		victim.take_bodypart_damage(rand(1, severity * 2), wound_bonus=CANT_WOUND) // НЕ_МОЖЕТ_БЫТЬ_РАНОЙ
		victim.adjust_stamina_loss(rand(2, severity * 2.5))
		if(prob(33))
			to_chat(victim, span_danger("Вы чувствуете острую боль в теле, когда ваши кости переформировываются!"))

	if(regen_ticks_current > regen_ticks_needed)
		if(!victim || !limb)
			qdel(src)
			return
		to_chat(victim, span_green("Ваша [limb.plaintext_zone] восстановилась от [LOWER_TEXT(undiagnosed_name || name)]!"))
		remove_wound()

/// Если мы человек, который бьет что-то сломанной рукой, мы можем навредить себе, делая это
/datum/wound/blunt/bone/proc/attack_with_hurt_hand(mob/M, atom/target, proximity)
	SIGNAL_HANDLER

	if(victim.get_active_hand() != limb || !proximity || !victim.combat_mode || !ismob(target) || severity <= WOUND_SEVERITY_MODERATE)
		return NONE

	// При серьезной или критической ране у вас есть 15% или 30% шанс вызвать боль при ударе
	if(prob((severity - 1) * 15))
		// И у вас есть 70% или 50% шанс фактически нанести удар соответственно
		if(HAS_TRAIT(victim, TRAIT_ANALGESIA) || prob(70 - 20 * (severity - 1))) // АНАЛЬГЕЗИЯ
			if(!HAS_TRAIT(victim, TRAIT_ANALGESIA))
				to_chat(victim, span_danger("Перелом в вашей [limb.plaintext_zone] пронзает болью, когда вы бьете [target]!"))
			victim.apply_damage(rand(1, 5), BRUTE, limb, wound_bonus = CANT_WOUND, wound_clothing = FALSE) // НЕ_МОЖЕТ_БЫТЬ_РАНОЙ
		else
			victim.visible_message(span_danger("[victim] слабо ударяет [target] своей сломанной [limb.plaintext_zone], отшатываясь от боли!"), \
			span_userdanger("Вам не удается ударить [target], так как перелом в вашей [limb.plaintext_zone] вспыхивает невыносимой болью!"), vision_distance=COMBAT_MESSAGE_RANGE) // ДИАПАЗОН_БОЕВОГО_СООБЩЕНИЯ
			INVOKE_ASYNC(victim, TYPE_PROC_REF(/mob, emote), "scream")
			victim.Stun(0.5 SECONDS)
			victim.apply_damage(rand(3, 7), BRUTE, limb, wound_bonus = CANT_WOUND, wound_clothing = FALSE) // НЕ_МОЖЕТ_БЫТЬ_РАНОЙ
			return COMPONENT_CANCEL_ATTACK_CHAIN // КОМПОНЕНТ_ОТМЕНИТЬ_ЦЕПОЧКУ_АТАКИ

	return NONE

/// Если мы человек, который стреляет из оружия сломанной рукой, мы можем навредить себе, делая это
/datum/wound/blunt/bone/proc/firing_with_messed_up_hand(datum/source, obj/item/gun/gun, atom/firing_at, params, zone, bonus_spread_values) // БОНУСНЫЕ_ЗНАЧЕНИЯ_РАЗБРОСА
	SIGNAL_HANDLER

	switch(limb.body_zone)
		if(BODY_ZONE_L_ARM)
			// Тяжелое оружие использует обе руки, поэтому всегда будет получать штраф
			// (Да, это означает, что две сломанные руки сделают тяжелое оружие НАМНОГО хуже)
			// В противном случае убедитесь, что ЭТА рука стреляет из ЭТОГО оружия
			if(gun.weapon_weight <= WEAPON_MEDIUM && !IS_LEFT_INDEX(victim.get_held_index_of_item(gun))) // ВЕС_ОРУЖИЯ_СРЕДНИЙ, ЛЕВЫЙ_ИНДЕКС
				return

		if(BODY_ZONE_R_ARM)
			// То же, но для правой руки
			if(gun.weapon_weight <= WEAPON_MEDIUM && !IS_RIGHT_INDEX(victim.get_held_index_of_item(gun))) // ПРАВЫЙ_ИНДЕКС
				return

		else
			// Это не рана руки, поэтому нас не волнует
			return

	if(gun.recoil > 0 && severity >= WOUND_SEVERITY_SEVERE && prob(25 * (severity - 1)))
		if(!HAS_TRAIT(victim, TRAIT_ANALGESIA))
			to_chat(victim, span_danger("Перелом в вашей [limb.plaintext_zone] взрывается болью, когда [gun] отдает!"))
		victim.apply_damage(rand(1, 3) * (severity - 1) * gun.weapon_weight, BRUTE, limb, wound_bonus = CANT_WOUND, wound_clothing = FALSE) // НЕ_МОЖЕТ_БЫТЬ_РАНОЙ

	if(!HAS_TRAIT(victim, TRAIT_ANALGESIA))
		bonus_spread_values[MAX_BONUS_SPREAD_INDEX] += (15 * severity * (limb.current_gauze?.splint_factor || 1)) // ИНДЕКС_МАКСИМАЛЬНОГО_БОНУСА_РАЗБРОСА, фактор_шины

/datum/wound/blunt/bone/receive_damage(wounding_type, wounding_dmg, wound_bonus)
	if(!victim || wounding_dmg < WOUND_MINIMUM_DAMAGE || !victim.can_bleed())
		return

	if(limb.body_zone == BODY_ZONE_CHEST && victim.get_blood_volume() && prob(internal_bleeding_chance + wounding_dmg))
		var/blood_bled = rand(1, wounding_dmg * (severity == WOUND_SEVERITY_CRITICAL ? 2 : 1.5)) // 12 брута от лома может вызвать до 18/24 кровотечения при серьезной/критической ране груди
		switch(blood_bled)
			if(1 to 6)
				victim.bleed(blood_bled, TRUE)
			if(7 to 13)
				victim.visible_message(
					span_smalldanger("Тонкая струйка крови капает изо рта [victim] от удара по [victim.p_their()] груди."),
					span_danger("Вы откашливаете немного крови от удара по груди."),
					vision_distance = COMBAT_MESSAGE_RANGE, // ДИАПАЗОН_БОЕВОГО_СООБЩЕНИЯ
				)
				victim.bleed(blood_bled, TRUE)
			if(14 to 19)
				victim.visible_message(
					span_smalldanger("Кровь хлещет изо рта [victim] от удара по [victim.p_their()] груди!"),
					span_danger("Вы выплевываете струйку крови от удара по груди!"),
					vision_distance = COMBAT_MESSAGE_RANGE, // ДИАПАЗОН_БОЕВОГО_СООБЩЕНИЯ
				)
				victim.create_splatter(victim.dir)
				victim.bleed(blood_bled)
			if(20 to INFINITY)
				victim.visible_message(
					span_danger("Кровь брызгает изо рта [victim] от удара по [victim.p_their()] груди!"),
					span_bolddanger("Вы давитесь потоком крови от удара по груди!"),
					vision_distance = COMBAT_MESSAGE_RANGE, // ДИАПАЗОН_БОЕВОГО_СООБЩЕНИЯ
				)
				victim.bleed(blood_bled)
				victim.create_splatter(victim.dir)
				victim.add_splatter_floor(get_step(victim.loc, victim.dir))

/datum/wound/blunt/bone/modify_desc_before_span(desc)
	. = ..()

	if (!limb.current_gauze)
		if(taped)
			. += ", [span_notice("и, кажется, переформировывается под хирургической лентой!")]"
		else if(gelled)
			. += ", [span_notice("с шипящими брызгами синего костного геля, искрящегося на кости!")]"

/datum/wound/blunt/get_limb_examine_description()
	return span_warning("Кости в этой конечности выглядят сильно потрескавшимися.")

/*
	Новые общие процедуры для /datum/wound/blunt/bone/
*/

/datum/wound/blunt/bone/get_scar_file(obj/item/bodypart/scarred_limb, add_to_scars)
	if (scarred_limb.biological_state & BIO_BONE && (!(scarred_limb.biological_state & BIO_FLESH))) // только кость
		return BONE_SCAR_FILE // ФАЙЛ_ШРАМОВ_КОСТИ
	else if (scarred_limb.biological_state & BIO_FLESH && (!(scarred_limb.biological_state & BIO_BONE)))
		return FLESH_SCAR_FILE // ФАЙЛ_ШРАМОВ_ПЛОТИ

	return ..()

/// Вывих сустава (Умеренная тупая травма)
/datum/wound/blunt/bone/moderate
	name = "Вывих сустава"
	undiagnosed_name = "Вывих"
	desc = "Конечность пациента вышла из сустава, вызывая боль и снижение моторной функции."
	treat_text = "Нанесите Костоправ на пораженную конечность. \
		Ручное вправление с помощью агрессивного захвата и крепкого объятия пораженной конечности также может сработать."
	treat_text_short = "Нанесите Костоправ или вправьте конечность вручную."
	examine_desc = "неловко вывернута из места"
	occur_text = "резко дергается и выходит из сустава"
	severity = WOUND_SEVERITY_MODERATE
	interaction_efficiency_penalty = 1.3
	limp_slowdown = 3
	limp_chance = 50
	series_threshold_penalty = 15
	treatable_tools = list(TOOL_BONESET) // ИНСТРУМЕНТ_КОСТОПРАВ
	status_effect_type = /datum/status_effect/wound/blunt/bone/moderate
	scar_keyword = "dislocate" // "вывих"

	simple_desc = "Кость пациента была вывихнута, вызывая хромоту или снижение ловкости."
	simple_treat_text = "<b>Перевязка</b> раны уменьшит ее воздействие до лечения костоправом. Чаще всего лечится агрессивным захватом и полезным вправлением конечности, хотя при этом есть место для злонамеренности."
	homemade_treat_text = "Помимо перевязки и вправления, <b>костоправы</b> можно напечатать в латах и использовать на себе ценой сильной боли. В крайнем случае, <b>раздавливание</b> пациента <b>противопожарной дверью</b> иногда отмечалось как метод вправления вывихнутой конечности."

/datum/wound_pregen_data/bone/dislocate
	abstract = FALSE

	wound_path_to_generate = /datum/wound/blunt/bone/moderate

	required_limb_biostate = BIO_JOINTED // БИО_СУСТАВНОЙ

	threshold_minimum = 35

/datum/wound/blunt/bone/moderate/Destroy()
	if(victim)
		UnregisterSignal(victim, COMSIG_LIVING_DOORCRUSHED) // СИГНАЛ_ЖИВОЕ_РАЗДАВЛЕНО_ДВЕРЬЮ
	return ..()

/datum/wound/blunt/bone/moderate/set_victim(new_victim)

	if (victim)
		UnregisterSignal(victim, COMSIG_LIVING_DOORCRUSHED)
	if (new_victim)
		RegisterSignal(new_victim, COMSIG_LIVING_DOORCRUSHED, PROC_REF(door_crush))

	return ..()

/datum/wound/blunt/bone/moderate/get_self_check_description(self_aware)
	return span_warning("Она чувствуется вывихнутой!")

/// Попадание под раздавливание в шлюзе/противопожарной двери - последняя попытка вправить конечность
/datum/wound/blunt/bone/moderate/proc/door_crush()
	SIGNAL_HANDLER
	if(prob(40))
		victim.visible_message(span_danger("Вывихнутая [limb.plaintext_zone] [victim] становится на место со щелчком!"), span_userdanger("Ваша вывихнутая [limb.plaintext_zone] становится на место со щелчком! Ай!"))
		remove_wound()
		return DOORCRUSH_NO_WOUND // РАЗДАВЛЕНИЕ_ДВЕРЬЮ_БЕЗ_РАНЫ
	return NONE

/datum/wound/blunt/bone/moderate/try_handling(mob/living/user)
	if(user.usable_hands <= 0 || user.pulling != victim)
		return FALSE
	if(!isnull(user.hud_used?.zone_select) && user.zone_selected != limb.body_zone)
		return FALSE

	if(user.grab_state == GRAB_PASSIVE) // ЗАХВАТ_ПАССИВНЫЙ
		to_chat(user, span_warning("Вы должны держать [victim] в агрессивном захвате, чтобы манипулировать [victim.p_their()] [LOWER_TEXT(undiagnosed_name || name)]!"))
		return TRUE

	if(user.grab_state >= GRAB_AGGRESSIVE) // ЗАХВАТ_АГРЕССИВНЫЙ
		user.visible_message(span_danger("[user] начинает скручивать и напрягать вывихнутую [limb.plaintext_zone] [victim]!"), span_notice("Вы начинаете скручивать и напрягать вывихнутую [limb.plaintext_zone] [victim]..."), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user] начинает скручивать и напрягать вашу вывихнутую [limb.plaintext_zone]!"))
		if(!user.combat_mode)
			chiropractice(user)
		else
			malpractice(user)
		return TRUE

/// Если кто-то вправляет наш вывихнутый сустав вручную с агрессивным захватом и режимом помощи
/datum/wound/blunt/bone/moderate/proc/chiropractice(mob/living/carbon/human/user)
	var/time = base_treat_time

	if(!do_after(user, time, target=victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return

	if(prob(65))
		user.visible_message(span_danger("[user] со щелчком вправляет вывихнутую [limb.plaintext_zone] [victim] на место!"), span_notice("Вы со щелчком вправляете вывихнутую [limb.plaintext_zone] [victim] на место!"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user] со щелчком вправляет вашу вывихнутую [limb.plaintext_zone] на место!"))
		victim.emote("scream")
		victim.apply_damage(20, BRUTE, limb, wound_bonus = CANT_WOUND) // НЕ_МОЖЕТ_БЫТЬ_РАНОЙ
		qdel(src)
	else
		user.visible_message(span_danger("[user] болезненно выкручивает вывихнутую [limb.plaintext_zone] [victim]!"), span_danger("Вы болезненно выкручиваете вывихнутую [limb.plaintext_zone] [victim]!"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user] болезненно выкручивает вашу вывихнутую [limb.plaintext_zone]!"))
		victim.apply_damage(10, BRUTE, limb, wound_bonus = CANT_WOUND) // НЕ_МОЖЕТ_БЫТЬ_РАНОЙ
		chiropractice(user)

/// Если кто-то превращает наш вывихнутый сустав в перелом вручную с агрессивным захватом и режимом вреда или обезоруживания
/datum/wound/blunt/bone/moderate/proc/malpractice(mob/living/carbon/human/user)
	var/time = base_treat_time

	if(!do_after(user, time, target=victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return

	if(prob(65))
		user.visible_message(span_danger("[user] со sickening crack ломает вывихнутую [limb.plaintext_zone] [victim]!"), span_danger("Вы со sickening crack ломаете вывихнутую [limb.plaintext_zone] [victim]!"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user] со sickening crack ломает вашу вывихнутую [limb.plaintext_zone]!"))
		victim.emote("scream")
		victim.apply_damage(25, BRUTE, limb, wound_bonus = 30)
	else
		user.visible_message(span_danger("[user] болезненно выкручивает вывихнутую [limb.plaintext_zone] [victim]!"), span_danger("Вы болезненно выкручиваете вывихнутую [limb.plaintext_zone] [victim]!"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user] болезненно выкручивает вашу вывихнутую [limb.plaintext_zone]!"))
		victim.apply_damage(10, BRUTE, limb, wound_bonus = CANT_WOUND) // НЕ_МОЖЕТ_БЫТЬ_РАНОЙ
		malpractice(user)

/datum/wound/blunt/bone/moderate/treat(obj/item/tool, mob/user)
	var/scanned = HAS_TRAIT(src, TRAIT_WOUND_SCANNED) // ЧЕРТА_РАНА_ОТСКАНИРОВАНА
	var/self_penalty_mult = user == victim ? 1.5 : 1
	var/scanned_mult = scanned ? 0.5 : 1
	var/treatment_delay = base_treat_time * self_penalty_mult * scanned_mult

	if(victim == user)
		victim.visible_message(span_danger("[user] начинает [scanned ? "профессионально" : ""] вправлять [victim.p_their()] [limb.plaintext_zone] с помощью [tool]."), span_warning("Вы начинаете вправлять свою [limb.plaintext_zone] с помощью [tool][scanned ? ", держа в памяти указания голо-изображения" : ""]..."))
	else
		user.visible_message(span_danger("[user] начинает [scanned ? "профессионально" : ""] вправлять [limb.plaintext_zone] [victim] с помощью [tool]."), span_notice("Вы начинаете вправлять [limb.plaintext_zone] [victim] с помощью [tool][scanned ? ", держа в памяти указания голо-изображения" : ""]..."))

	if(!do_after(user, treatment_delay, target = victim, extra_checks=CALLBACK(src, PROC_REF(still_exists))))
		return

	if(victim == user)
		victim.apply_damage(15, BRUTE, limb, wound_bonus = CANT_WOUND) // НЕ_МОЖЕТ_БЫТЬ_РАНОЙ
		victim.visible_message(span_danger("[user] заканчивает вправлять [victim.p_their()] [limb.plaintext_zone]!"), span_userdanger("Вы вправляете свою [limb.plaintext_zone]!"))
	else
		victim.apply_damage(10, BRUTE, limb, wound_bonus = CANT_WOUND) // НЕ_МОЖЕТ_БЫТЬ_РАНОЙ
		user.visible_message(span_danger("[user] заканчивает вправлять [limb.plaintext_zone] [victim]!"), span_nicegreen("Вы заканчиваете вправлять [limb.plaintext_zone] [victim]!"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user] вправляет вашу [limb.plaintext_zone]!"))

	victim.emote("scream")
	qdel(src)

/*
	Серьезная (Закрытый перелом)
*/

/datum/wound/blunt/bone/severe
	name = "Закрытый перелом"
	desc = "Кость пациента получила трещину в основании, вызывая серьезную боль и снижение функциональности конечности."
	treat_text = "Лечите хирургически. В экстренном случае, нанесение костного геля на пораженную область со временем исправит ситуацию. \
		Шина или перевязь из медицинской марли также могут быть использованы, чтобы предотвратить ухудшение перелома."
	treat_text_short = "Лечите хирургически или нанесите костный гель. Также можно использовать шину или марлевую перевязь."
	examine_desc = "выглядит уродливо опухшей, неровные бугорки намекают на сколы в кости"
	occur_text = "разбрызгивает осколки кости и развивает ужасно выглядящий синяк"

	severity = WOUND_SEVERITY_SEVERE
	interaction_efficiency_penalty = 2
	limp_slowdown = 6
	limp_chance = 60
	series_threshold_penalty = 30
	treatable_by = list(/obj/item/stack/sticky_tape/surgical, /obj/item/stack/medical/bone_gel) // хирургическая_лента, костный_гель
	status_effect_type = /datum/status_effect/wound/blunt/bone/severe
	scar_keyword = "bluntsevere" // "тупаясерьезная"
	brain_trauma_group = BRAIN_TRAUMA_MILD // ТРАВМА_МОЗГА_ЛЕГКАЯ
	trauma_cycle_cooldown = 1.5 MINUTES
	internal_bleeding_chance = 40
	wound_flags = (ACCEPTS_GAUZE | MANGLES_INTERIOR) // ПРИНИМАЕТ_ПОВЯЗКУ | ИЗУВЕЧИВАЕТ_ИНТЕРЬЕР
	regen_ticks_needed = 120 // тики каждые 2 секунды, 240 секунд, примерно 4 минуты по умолчанию

	simple_desc = "Кость пациента треснула посередине, drastically снижая функциональность конечности."
	simple_treat_text = "<b>Перевязка</b> раны уменьшит ее воздействие до <b>хирургического лечения</b> костным гелем и хирургической лентой."
	homemade_treat_text = "<b>Костный гель и хирургическая лента</b> могут быть нанесены прямо на рану, хотя это довольно сложно для большинства людей сделать самостоятельно, если они не приняли одно или несколько <b>обезболивающих</b> (известно, что Морфин и Шахтерская мазь помогают)"


/datum/wound_pregen_data/bone/hairline
	abstract = FALSE

	wound_path_to_generate = /datum/wound/blunt/bone/severe

	threshold_minimum = 60

/// Открытый перелом (Критическая тупая травма)
/datum/wound/blunt/bone/critical
	name = "Открытый перелом"
	undiagnosed_name = null // вы можете определить открытый перелом с первого взгляда из-за разрыва кожи
	desc = "Кости пациента получили multiple переломы, \
		в сочетании с разрывом кожи, вызывая значительную боль и почти бесполезность конечности."
	treat_text = "Немедленно перевяжите пораженную конечность марлей или шиной. Лечите хирургически. \
		В экстренном случае, костный гель и хирургическая лента могут быть нанесены на пораженную область для исправления в течение длительного времени."
	treat_text_short = "Лечите хирургически или нанесите костный гель и хирургическую ленту. Также следует использовать шину или марлевую перевязь."
	examine_desc = "тщательно раздроблена и потрескалась, обнажая осколки кости открытому воздуху"
	occur_text = "трескается, обнажая сломанные кости открытому воздуху"

	severity = WOUND_SEVERITY_CRITICAL
	interaction_efficiency_penalty = 2.5
	limp_slowdown = 7
	limp_chance = 70
	sound_effect = 'sound/effects/wounds/crack2.ogg'
	threshold_penalty = 15
	disabling = TRUE
	treatable_by = list(/obj/item/stack/sticky_tape/surgical, /obj/item/stack/medical/bone_gel)
	status_effect_type = /datum/status_effect/wound/blunt/bone/critical
	scar_keyword = "bluntcritical" // "тупаякритическая"
	brain_trauma_group = BRAIN_TRAUMA_SEVERE // ТРАВМА_МОЗГА_ТЯЖЕЛАЯ
	trauma_cycle_cooldown = 2.5 MINUTES
	internal_bleeding_chance = 60
	wound_flags = (ACCEPTS_GAUZE | MANGLES_INTERIOR)
	regen_ticks_needed = 240 // тики каждые 2 секунды, 480 секунд, примерно 8 минут по умолчанию

	simple_desc = "Кости пациента практически полностью shattered, вызывая полную иммобилизацию конечности."
	simple_treat_text = "<b>Перевязка</b> раны slightly уменьшит ее воздействие до <b>хирургического лечения</b> костным гелем и хирургической лентой."
	homemade_treat_text = "Хотя это extremely сложно и медленно действует, <b>Костный гель и хирургическая лента</b> могут быть нанесены прямо на рану, хотя это почти невозможно для большинства людей сделать самостоятельно, если они не приняли одно или несколько <b>обезболивающих</b> (известно, что Морфин и Шахтерская мазь помогают)"

	/// Tracks if a surgeon has reset the bone (part one of the surgical treatment process)
	VAR_FINAL/reset = FALSE

/datum/wound_pregen_data/bone/compound
	abstract = FALSE

	wound_path_to_generate = /datum/wound/blunt/bone/critical

	threshold_minimum = 115

// не очень логично, чтобы "кость" торчала из вашей головы
/datum/wound/blunt/bone/critical/apply_wound(obj/item/bodypart/L, silent = FALSE, datum/wound/old_wound = null, smited = FALSE, attack_direction = null, wound_source = "Неизвестно", replacing = FALSE)
	if(L.body_zone == BODY_ZONE_HEAD)
		occur_text = "раскалывается, обнажая голый, потрескавшийся череп сквозь плоть и кровь"
		examine_desc = "имеет тревожную вмятину, с кусочками черепа, торчащими наружу"
	. = ..()

/// если кто-то использует костный гель на нашей ране
/datum/wound/blunt/bone/proc/gel(obj/item/stack/medical/bone_gel/I, mob/user)
	// скелеты получают более щадящее лечение костным гелем, поскольку их способность "reattach dismembered limbs by hand" отстой, когда конечность все еще критически ранена
	if((limb.biological_state & BIO_BONE) && !(limb.biological_state & (BIO_FLESH|BIO_CHITIN)))
		return skelly_gel(I, user)

	if(gelled)
		to_chat(user, span_warning("[user == victim ? "Ваша" : "[victim]'s"] [limb.plaintext_zone] уже покрыта костным гелем!"))
		return TRUE

	user.visible_message(span_danger("[user] начинает поспешно наносить [I] на [limb.plaintext_zone] [victim]..."), span_warning("Вы начинаете поспешно наносить [I] на [user == victim ? "свою" : "[victim]'s"] [limb.plaintext_zone], игнорируя предупреждающую надпись..."))

	if(!do_after(user, base_treat_time * 1.5 * (user == victim ? 1.5 : 1), target = victim, extra_checks=CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	I.use(1)
	victim.emote("scream")
	if(user != victim)
		user.visible_message(span_notice("[user] заканчивает наносить [I] на [limb.plaintext_zone] [victim], издавая шипящий звук!"), span_notice("Вы заканчиваете наносить [I] на [limb.plaintext_zone] [victim]!"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user] заканчивает наносить [I] на вашу [limb.plaintext_zone], и вы чувствуете, как кости взрываются болью, начиная плавиться и переформировываться!"))
	else
		if(!HAS_TRAIT(victim, TRAIT_ANALGESIA))
			if(prob(25 + (20 * (severity - 2)) - min(victim.get_drunk_amount(), 10))) // 25%/45% шанс провалить самостоятельное нанесение при серьезных и критических ранах, модифицированный опьянением
				victim.visible_message(span_danger("[victim] не удается закончить нанесение [I] на [victim.p_their()] [limb.plaintext_zone], теряя сознание от боли!"), span_notice("Вы теряете сознание от боли при нанесении [I] на свою [limb.plaintext_zone], не успев закончить!"))
				victim.AdjustUnconscious(5 SECONDS)
				return TRUE
		victim.visible_message(span_notice("[victim] заканчивает наносить [I] на [victim.p_their()] [limb.plaintext_zone], гримасничая от боли!"), span_notice("Вы заканчиваете наносить [I] на свою [limb.plaintext_zone], и ваши кости взрываются болью!"))

	victim.apply_damage(25, BRUTE, limb, wound_bonus = CANT_WOUND) // НЕ_МОЖЕТ_БЫТЬ_РАНОЙ
	victim.apply_damage(100, STAMINA)
	gelled = TRUE
	return TRUE

/// скелетам костный гель нравится больше, так как они буквально вся из кости
/datum/wound/blunt/bone/proc/skelly_gel(obj/item/stack/medical/bone_gel/I, mob/user)
	if(gelled)
		to_chat(user, span_warning("[user == victim ? "Ваша" : "[victim]'s"] [limb.plaintext_zone] уже покрыта костным гелем!"))
		return

	user.visible_message(span_danger("[user] начинает наносить [I] на [limb.plaintext_zone] [victim]..."), span_warning("Вы начинаете наносить [I] на [user == victim ? "свою" : "[victim]'s"] [limb.plaintext_zone]..."))

	if(!do_after(user, base_treat_time * (user == victim ? 1.5 : 1), target = victim, extra_checks=CALLBACK(src, PROC_REF(still_exists))))
		return

	I.use(1)
	if(user != victim)
		user.visible_message(span_notice("[user] заканчивает наносить [I] на [limb.plaintext_zone] [victim], издавая забавный шипящий звук!"), span_notice("Вы заканчиваете наносить [I] на [limb.plaintext_zone] [victim]!"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user] заканчивает наносить [I] на вашу [limb.plaintext_zone], и вы чувствуете забавное щекочущее шипение, когда они начинают переформировываться!"))
	else
		victim.visible_message(span_notice("[victim] заканчивает наносить [I] на [victim.p_their()] [limb.plaintext_zone], издавая забавный шипящий звук!"), span_notice("Вы заканчиваете наносить [I] на свою [limb.plaintext_zone], и чувствуете забавное щекочущее шипение, когда кость начинает переформировываться!"))

	gelled = TRUE
	processes = TRUE
	return TRUE

/// если кто-то использует хирургическую ленту на нашей ране
/datum/wound/blunt/bone/proc/tape(obj/item/stack/sticky_tape/surgical/I, mob/user)
	if(!gelled)
		to_chat(user, span_warning("[user == victim ? "Ваша" : "[victim]'s"] [limb.plaintext_zone] должна быть покрыта костным гелем для проведения этой экстренной операции!"))
		return TRUE
	if(taped)
		to_chat(user, span_warning("[user == victim ? "Ваша" : "[victim]'s"] [limb.plaintext_zone] уже обернута [I.name] и переформировывается!"))
		return TRUE

	user.visible_message(span_danger("[user] начинает наносить [I] на [limb.plaintext_zone] [victim]..."), span_warning("Вы начинаете наносить [I] на [user == victim ? "свою" : "[victim]'s"] [limb.plaintext_zone]..."))

	if(!do_after(user, base_treat_time * (user == victim ? 1.5 : 1), target = victim, extra_checks=CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	if(victim == user)
		regen_ticks_needed *= 1.5

	I.use(1)
	if(user != victim)
		user.visible_message(span_notice("[user] заканчивает наносить [I] на [limb.plaintext_zone] [victim], издавая шипящий звук!"), span_notice("Вы заканчиваете наносить [I] на [limb.plaintext_zone] [victim]!"), ignored_mobs=victim)
		to_chat(victim, span_green("[user] заканчивает наносить [I] на вашу [limb.plaintext_zone], вы сразу начинаете чувствовать, как ваши кости начинают переформировываться!"))
	else
		victim.visible_message(span_notice("[victim] заканчивает наносить [I] на [victim.p_their()] [limb.plaintext_zone]!"), span_green("Вы заканчиваете наносить [I] на свою [limb.plaintext_zone], и вы сразу начинаете чувствовать, как ваши кости начинают переформировываться!"))

	taped = TRUE
	processes = TRUE
	return TRUE

/datum/wound/blunt/bone/item_can_treat(obj/item/potential_treater, mob/user)
	// assume that - if working on a ready-to-operate limb - the surgery wants to do the real surgery instead of bone regeneration
	return ..() && !HAS_TRAIT(limb, TRAIT_READY_TO_OPERATE)

/datum/wound/blunt/bone/treat(obj/item/tool, mob/user)
	if(istype(tool, /obj/item/stack/medical/bone_gel))
		gel(tool, user)
	if(istype(tool, /obj/item/stack/sticky_tape/surgical))
		tape(tool, user)

/datum/wound/blunt/bone/get_scanner_description(mob/user)
	. = ..()

	. += "<div class='ml-3'>"

	if(severity > WOUND_SEVERITY_MODERATE)
		if((limb.biological_state & BIO_BONE) && !(limb.biological_state & (BIO_FLESH|BIO_CHITIN)))
			if(!gelled)
				. += "Рекомендуемое лечение: Нанесите костный гель непосредственно на поврежденную конечность. Существа из чистой кости, кажется, не против нанесения костного геля так сильно, как существа из плоти. Хирургическая лента также не потребуется.\n"
			else
				. += "[span_notice("Примечание: Регенерация кости в процессе. Кость регенерирована на [round(regen_ticks_current*100/regen_ticks_needed)]%.")]\n"
		else
			if(!gelled)
				. += "Альтернативное лечение: Нанесите костный гель непосредственно на поврежденную конечность, затем нанесите хирургическую ленту, чтобы начать регенерацию кости. Это одновременно мучительно больно и медленно, и рекомендуется только в крайних обстоятельствах.\n"
			else if(!taped)
				. += "[span_notice("Продолжить альтернативное лечение: Нанесите хирургическую ленту непосредственно на поврежденную конечность, чтобы начать регенерацию кости. Примечание, это одновременно мучительно больно и медленно, хотя сон или лежание ускорят восстановление.")]\n"
			else
				. += "[span_notice("Примечание: Регенерация кости в процессе. Кость регенерирована на [round(regen_ticks_current*100/regen_ticks_needed)]%.")]\n"

	if(limb.body_zone == BODY_ZONE_HEAD)
		. += "Обнаружена черепно-мозговая травма: Пациент будет страдать от случайных приступов [severity == WOUND_SEVERITY_SEVERE ? "легких" : "тяжелых"] травм мозга, пока кость не восстановлена."
	else if(limb.body_zone == BODY_ZONE_CHEST && CAN_HAVE_BLOOD(victim))
		. += "Обнаружена травма грудной клетки: Дальнейшая травма груди, вероятно, усугубит внутреннее кровотечение, пока кость не восстановлена."
	. += "</div>"
