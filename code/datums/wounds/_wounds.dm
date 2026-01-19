/*
	Раны - это конкретные медицинские осложнения, которые могут возникнуть и быть применены (в настоящее время) к углеродным формам жизни, с акцентом на людей. Весь код, относящийся к этому, находится в стадии активной разработки,
	и документация будет сосредоточена на объяснении того, к чему ведет каждая часть, до тех пор, пока я не закончу основные реализации. Оригинальный дизайн-документ
	можно найти по адресу https://hackmd.io/@Ryll/r1lb4SOwU

	Раны - это датумы, которые работают как смесь болезней, травм мозга и компонентов, и применяются к /obj/item/bodypart (предпочтительно прикрепленной к углеродной форме жизни), когда они получают большие всплески урона
	или при других определенных условиях (сильный бросок о стену, длительное воздействие плазменного огня и т.д.). Раны классифицируются по следующим трем критериям:
		1. Тяжесть: УМЕРЕННАЯ, СЕРЬЕЗНАЯ или КРИТИЧЕСКАЯ. См. hackmd для более подробной информации.
		2. Применимые зоны: К каким частям тела применима рана. Общие раны, такие как переломы костей и сильные ожоги, могут применяться к каждой зоне, но вы можете добавить особые раны для определенных конечностей,
			как вывих лодыжки только для ног, или открытое воздействие воздуха на органы для особенно ужасных ран груди. Раны должны быть способны функционировать для каждой зоны, для которой они отмечены как применимые.
		3. Тип урона: В настоящее время либо БРУТАЛЬНЫЙ, либо ОЖОГОВЫЙ. Опять же, см. hackmd для разъяснения моих планов для каждого типа.

	Когда часть тела получает достаточно урона, чтобы получить рану, тяжесть (определяемая броском или чем-то подобным, худший урон приводит к худшим ранам), пораженная конечность и полученный тип урона учитываются
	при решении, какая конкретная рана будет применена. Я хотел бы иметь несколько различных типов ран по крайней мере для некоторых вариантов, но сейчас я делаю лишь грубые общие черты. Ожидайте полировки.
*/

#define WOUND_CRITICAL_BLUNT_DISMEMBER_BONUS 15

/datum/wound
	/// Как она называется
	var/name = "Рана"
	/// Опционально, как называется рана, когда кто-то проверяет себя (т.е. без сканера - только своими глазами и руками)
	var/undiagnosed_name
	/// Описание, показываемое на сканерах
	var/desc = ""
	/// Базовое лечение, предлагаемое анализаторами здоровья
	var/treat_text = ""
	/// Еще более базовое лечение
	var/treat_text_short = ""
	/// Как выглядит конечность при беглом осмотре
	var/examine_desc = "сильно повреждена"

	/// Простое описание, сокращенное для ясности, если определено. Иначе просто берется обычный desc в процедуре анализатора.
	var/simple_desc
	/// Простое описание раны в анализаторе, которое меньше фокусируется на клиническом аспекте раны и больше на легко читаемых инструкциях по лечению.
	var/simple_treat_text = "Иди в медотсек, идиот"
	/// Самодельные средства, указанные только анализатором первой помощи.
	var/homemade_treat_text = "Не забывайте пить много воды!"

	/// Если эта рана может генерировать шрам.
	var/can_scar = TRUE

	/// Файл по умолчанию, из которого мы берем описания шрамов, если нам не удается получить идеальный файл.
	var/default_scar_file

	/// Видимое сообщение, когда это происходит
	var/occur_text = ""
	/// Этот звук будет воспроизведен при нанесении раны
	var/sound_effect
	/// Громкость [sound_effect]
	var/sound_volume = 70

	/// Либо WOUND_SEVERITY_TRIVIAL (мемные раны вроде ушиба пальца), WOUND_SEVERITY_MODERATE, WOUND_SEVERITY_SEVERE, либо WOUND_SEVERITY_CRITICAL (или, возможно, WOUND_SEVERITY_LOSS)
	var/severity = WOUND_SEVERITY_MODERATE

	/// Кто является владельцем части тела, которую мы раним
	var/mob/living/carbon/victim = null
	/// Часть тела, к которой мы привязаны. Не гарантировано, что не-null, особенно после/во время удаления или если мы еще не были применены
	var/obj/item/bodypart/limb = null

	/// Конкретные предметы, такие как бинты или швы, которые могут попытаться напрямую лечить эту рану
	var/list/treatable_by
	/// Любые инструменты с любым из флагов в этом списке будут пригодны для попытки прямого лечения этой раны
	var/list/treatable_tools
	/// Сколько времени займет лечение этой раны стандартным эффективным инструментом, предполагая, что ей не нужна операция
	var/base_treat_time = 5 SECONDS

	/// Использование этой конечности во взаимодействии do_after будет умножать длительность на этот штраф (руки)
	var/interaction_efficiency_penalty = 1
	/// Входящий урон по этой конечности будет умножен на это, чтобы имитировать болезненность и уязвимость (в основном ожоги).
	var/damage_multiplier_penalty = 1
	/// Если установлено и эта рана применена к ноге, мы добавляем столько десятых секунды за каждый шаг на этой ноге
	var/limp_slowdown
	/// Если у этой раны есть limp_slowdown и она применена к ноге, у нее есть этот шанс прихрамывать при каждом шаге
	var/limp_chance
	/// Насколько мы способствуем кровотечению этой конечности (bleed_rate)
	var/blood_flow

	/// Насколько наличие этой раны добавит ко всем будущим броскам check_wounding() на этой конечности, чтобы позволить прогрессировать к худшим травмам при повторном уроне
	var/threshold_penalty
	/// Насколько наличие этой раны добавит ко всем будущим броскам check_wounding() на этой конечности, но только для ран ее собственной серии
	var/series_threshold_penalty = 0
	/// Если нам нужно обрабатываться каждый жизненный тик
	var/processes = FALSE

	/// Делает ли наличие этой раны в настоящее время родительскую часть тела непригодной к использованию
	var/disabling

	/// Какой эффект статуса мы назначаем при применении
	var/status_effect_type
	/// если вы ленивый тип и просто бросите их в криокамеру, рана исчезнет после накопления тяжесть * [base_xadone_progress_to_qdel] мощности
	var/cryo_progress

	/// Базовое количество [cryo_progress], необходимое для полного заживления нас крио. Умножается на тяжесть.
	var/base_xadone_progress_to_qdel = 33

	/// Какие шрамы эта рана создаст описательно после заживления
	var/scar_keyword = "generic"
	/// Если мы уже пытались создать шрам при удалении (remove_wound может быть вызван дважды в цепочке del, давайте будем добры к нашему коду, да?) TODO: сделать это чище
	var/already_scarred = FALSE
	/// Источник того, как мы получили рану, обычно оружие.
	var/wound_source

	/// Какие флаги применяются к этой ране
	var/wound_flags = (ACCEPTS_GAUZE) // ПРИНИМАЕТ_ПОВЯЗКУ

	/// Уникальный ID нашей раны для использования с [actionspeed_mod]. По умолчанию REF(src).
	var/unique_id
	/// Модификатор скорости действий, который мы будем использовать, если мы на руках и имеем штраф взаимодействия. Удаляется (qdel) при уничтожении.
	var/datum/actionspeed_modifier/wound_interaction_inefficiency/actionspeed_mod

/datum/wound/New()
	. = ..()

	unique_id = generate_unique_id()
	update_actionspeed_modifier()

/datum/wound/Destroy()
	if (limb)
		remove_wound()

	QDEL_NULL(actionspeed_mod)

	return ..()

/// Если у нас должен быть actionspeed_mod, обеспечиваем его наличие и обновляем его замедление. В противном случае, обеспечиваем его отсутствие
/// путем удаления (qdel) любого существующего модификатора.
/datum/wound/proc/update_actionspeed_modifier()
	if (should_have_actionspeed_modifier())
		if (!actionspeed_mod)
			generate_actionspeed_modifier()
		actionspeed_mod.multiplicative_slowdown = get_effective_actionspeed_modifier()
		victim?.update_actionspeed()
	else
		remove_actionspeed_modifier()

/// Возвращает TRUE, если у нас есть interaction_efficiency_penalty, и если мы на руках, FALSE в противном случае.
/datum/wound/proc/should_have_actionspeed_modifier()
	return (limb && victim && (limb.body_zone == BODY_ZONE_L_ARM || limb.body_zone == BODY_ZONE_R_ARM) && interaction_efficiency_penalty != 0)

/// Если у нас нет actionspeed_mod, генерирует новый с нашим уникальным ID, устанавливает actionspeed_mod в него, затем возвращает его.
/datum/wound/proc/generate_actionspeed_modifier()
	RETURN_TYPE(/datum/actionspeed_modifier)

	if (actionspeed_mod)
		return actionspeed_mod

	var/datum/actionspeed_modifier/wound_interaction_inefficiency/new_modifier = new /datum/actionspeed_modifier/wound_interaction_inefficiency(unique_id, src)
	new_modifier.multiplicative_slowdown = get_effective_actionspeed_modifier()
	victim?.add_actionspeed_modifier(new_modifier)

	actionspeed_mod = new_modifier
	return actionspeed_mod

/// Если у нас есть actionspeed_mod, удаляет его (qdel) и устанавливает нашу ссылку на него в null.
/datum/wound/proc/remove_actionspeed_modifier()
	if (!actionspeed_mod)
		return

	victim?.remove_actionspeed_modifier(actionspeed_mod)
	QDEL_NULL(actionspeed_mod)

/// Генерирует ID, который мы используем для [unique_id], который также установлен как ID нашего модификатора скорости действий
/datum/wound/proc/generate_unique_id()
	return REF(src) // уникальный, не может измениться, идеальный id

/**
 * apply_wound() используется после создания экземпляра типа раны, чтобы назначить его части тела и фактически вступить в игру.
 *
 *
 * Аргументы:
 * * limb: Часть тела, которую мы раним, нам неважен человек, мы можем получить его через конечность
 * * silent: На самом деле не нужен, думаю, изначально использовался для понижения ран, чтобы они не создавали новых сообщений, но, я думаю, old_wound взял на себя эту роль, я могу удалить это вскоре
 * * old_wound: Если наша новая рана является заменой одной того же типа (повышение или понижение), мы можем сослаться на старую прямо перед ее удалением, чтобы скопировать необходимые переменные
 * * smited- Если это кара, нам не важна эта рана для целей отслеживания статистики (еще не реализовано)
 * * attack_direction: Для брызг крови, если уместно
 * * wound_source: Источник раны, например, оружие.
 */
/datum/wound/proc/apply_wound(obj/item/bodypart/limb, silent = FALSE, datum/wound/old_wound = null, smited = FALSE, attack_direction = null, wound_source = "Неизвестно", replacing = FALSE)
	if (!limb.is_woundable() || !can_be_applied_to(limb, old_wound))
		qdel(src)
		return FALSE

	if(isatom(wound_source))
		var/atom/wound_atom = wound_source
		src.wound_source = wound_atom.name
	else if(istext(wound_source))
		src.wound_source = wound_source
	else
		src.wound_source = "Неизвестно"

	set_victim(limb.owner)
	set_limb(limb, replacing)
	LAZYADD(victim.all_wounds, src)
	LAZYADD(limb.wounds, src)
	update_descriptions()
	limb.update_wounds()
	if(status_effect_type)
		victim.apply_status_effect(status_effect_type, src)
	SEND_SIGNAL(victim, COMSIG_CARBON_GAIN_WOUND, src, limb)
	victim.update_health_hud()

	var/demoted
	if(old_wound)
		demoted = (severity <= old_wound.severity)

	if(severity == WOUND_SEVERITY_TRIVIAL)
		return

	if(!silent && !demoted)
		var/msg = span_danger("[victim]'s [limb.plaintext_zone] [occur_text]!")
		var/vis_dist = COMBAT_MESSAGE_RANGE

		if(severity > WOUND_SEVERITY_SEVERE)
			msg = "<b>[msg]</b>"
			vis_dist = DEFAULT_MESSAGE_RANGE

		victim.visible_message(msg, span_userdanger("Ваша [limb.plaintext_zone] [occur_text]!"), vision_distance = vis_dist)
		if(sound_effect)
			playsound(limb.owner, sound_effect, sound_volume + (20 * severity), TRUE, falloff_exponent = SOUND_FALLOFF_EXPONENT + 2,  ignore_walls = FALSE, falloff_distance = 0)

	wound_injury(old_wound, attack_direction = attack_direction)
	if(!demoted)
		second_wind()

	return TRUE

/// Возвращает TRUE, если мы можем быть применены к конечности.
/datum/wound/proc/can_be_applied_to(obj/item/bodypart/limb, datum/wound/old_wound)
	var/datum/wound_pregen_data/pregen_data = GLOB.all_wound_pregen_data[type]

	// Мы предполагаем, что нас не применяют случайно - у нас нет оснований так считать
	// И, кроме того, если бы это было так, вы могли бы так же легко проверить наши предварительно сгенерированные данные, а не запускать эту процедуру
	// Вообще говоря, эта процедура вызывается в apply_wound, который вызывается, когда вызывающий уже уверен в своей возможности быть примененным
	return pregen_data.can_be_applied_to(limb, old_wound = old_wound)

/// Возвращает зоны, к которым мы можем быть применены.
/datum/wound/proc/get_viable_zones()
	var/datum/wound_pregen_data/pregen_data = GLOB.all_wound_pregen_data[type]

	return pregen_data.viable_zones

/// Возвращает биологическое состояние, которое мы требуем для применения.
/datum/wound/proc/get_required_biostate()
	var/datum/wound_pregen_data/pregen_data = GLOB.all_wound_pregen_data[type]

	return pregen_data.required_limb_biostate

// Обновляет описательные тексты для раны, на случай, если они могут быть изменены по какой-либо причине
/datum/wound/proc/update_descriptions()
	return

/datum/wound/proc/null_victim()
	SIGNAL_HANDLER
	set_victim(null)

/// Сеттер для [victim]. Должен полностью передавать сигналы, атрибуты и т.д. новому victim - если он есть, так как он может быть null.
/datum/wound/proc/set_victim(new_victim)
	if(victim)
		UnregisterSignal(victim, list(COMSIG_QDELETING, COMSIG_MOB_SWAP_HANDS, COMSIG_CARBON_POST_REMOVE_LIMB, COMSIG_CARBON_POST_ATTACH_LIMB))
		UnregisterSignal(victim, COMSIG_QDELETING)
		UnregisterSignal(victim, COMSIG_MOB_SWAP_HANDS)
		UnregisterSignal(victim, COMSIG_CARBON_POST_REMOVE_LIMB)
		UnregisterSignal(victim, COMSIG_ATOM_ITEM_INTERACTION)
		if (actionspeed_mod)
			victim.remove_actionspeed_modifier(actionspeed_mod) // не нужно удалять (qdel), просто удаляем его из нашего victim

	remove_wound_from_victim()
	victim = new_victim
	if(victim)
		RegisterSignal(victim, COMSIG_QDELETING, PROC_REF(null_victim))
		RegisterSignals(victim, list(COMSIG_MOB_SWAP_HANDS, COMSIG_CARBON_POST_REMOVE_LIMB, COMSIG_CARBON_POST_ATTACH_LIMB), PROC_REF(add_or_remove_actionspeed_mod))
		RegisterSignal(victim, COMSIG_ATOM_ITEM_INTERACTION, PROC_REF(interact_try_treating))
		if (limb)
			start_limping_if_we_should() // эффект статуса уже сам удаляет себя
			add_or_remove_actionspeed_mod()

/// Процедура, вызываемая для изменения переменной `limb` и реакции на событие.
/datum/wound/proc/set_limb(obj/item/bodypart/new_value, replaced = FALSE)
	if(limb == new_value)
		return FALSE // Limb может быть либо ссылкой на что-то, либо `null`. Возврат числовой переменной делает понятным, что изменений не было.
	. = limb
	if(limb) // если мы обнуляем limb, мы фактически открепляемся от него, поэтому в этом случае мы должны удалить себя
		UnregisterSignal(limb, COMSIG_QDELETING)
		UnregisterSignal(limb, list(COMSIG_BODYPART_GAUZED, COMSIG_BODYPART_UNGAUZED))
		LAZYREMOVE(limb.wounds, src)
		limb.update_wounds(replaced)
		if (disabling)
			limb.remove_traits(list(TRAIT_PARALYSIS, TRAIT_DISABLED_BY_WOUND), REF(src))

	limb = new_value

	// ПОСЛЕ ИЗМЕНЕНИЯ

	if (limb)
		RegisterSignal(limb, COMSIG_QDELETING, PROC_REF(source_died))
		RegisterSignals(limb, list(COMSIG_BODYPART_GAUZED, COMSIG_BODYPART_UNGAUZED), PROC_REF(gauze_state_changed))
		if (disabling)
			limb.add_traits(list(TRAIT_PARALYSIS, TRAIT_DISABLED_BY_WOUND), REF(src))

		if (victim)
			start_limping_if_we_should() // эффект статуса уже сам удаляет себя
			add_or_remove_actionspeed_mod()

		update_inefficiencies(replaced)

/datum/wound/proc/add_or_remove_actionspeed_mod()
	update_actionspeed_modifier()
	if (actionspeed_mod)
		if(victim.get_active_hand() == limb)
			victim.add_actionspeed_modifier(actionspeed_mod, TRUE)
		else
			victim.remove_actionspeed_modifier(actionspeed_mod)

/datum/wound/proc/start_limping_if_we_should()
	if ((limb.body_zone == BODY_ZONE_L_LEG || limb.body_zone == BODY_ZONE_R_LEG) && limp_slowdown > 0 && limp_chance > 0)
		victim.apply_status_effect(/datum/status_effect/limp) // хромота

/datum/wound/proc/source_died()
	SIGNAL_HANDLER
	qdel(src)

/// Удаляет рану из того, кого она поражает, и очищает любые эффекты статуса или модификаторы времени взаимодействия, которые она имела. ignore_limb используется для откреплений, когда мы хотим только забыть victim
/datum/wound/proc/remove_wound(ignore_limb, replaced = FALSE)
	//TODO: иметь лучший способ определить, удаляемся ли мы без замены (полное заживление) для шрамов
	var/old_victim = victim
	var/old_limb = limb

	set_disabling(FALSE)
	if(limb && can_scar && !already_scarred && !replaced)
		already_scarred = TRUE
		var/datum/scar/new_scar = new
		new_scar.generate(limb, src)

	remove_actionspeed_modifier()

	null_victim() // мы используем процедуру здесь, потому что некоторое поведение может зависеть от изменения victim на какое-то новое значение

	if(limb && !ignore_limb)
		set_limb(null, replaced) // поскольку мы удаляем ссылку limb на нас, мы должны сделать то же самое
		// если вы хотите сохранить ссылку, сделайте это извне, нам нет причин ее помнить

	if (ismob(old_victim))
		var/mob/mob_victim = old_victim
		SEND_SIGNAL(mob_victim, COMSIG_CARBON_POST_LOSE_WOUND, src, old_limb, ignore_limb, replaced)
		if(!replaced && !limb)
			mob_victim.update_health_hud()

/datum/wound/proc/remove_wound_from_victim()
	if(!victim)
		return
	LAZYREMOVE(victim.all_wounds, src)
	SEND_SIGNAL(victim, COMSIG_CARBON_LOSE_WOUND, src, limb)

/**
 * replace_wound() используется, когда вы хотите заменить текущую рану новой раной, предположительно той же категории, но другой тяжести (как повышение, так и понижение)
 *
 * Аргументы:
 * * new_wound- Экземпляр раны, которым вы хотите заменить эту
 * * smited- Если это кара, нам не важна эта рана для целей отслеживания статистики (еще не реализовано)
 */
/datum/wound/proc/replace_wound(datum/wound/new_wound, smited = FALSE, attack_direction = attack_direction)
	already_scarred = TRUE
	var/obj/item/bodypart/cached_limb = limb // remove_wound() обнуляет limb, поэтому мы должны отслеживать его локально
	remove_wound(replaced=TRUE)
	new_wound.apply_wound(cached_limb, old_wound = src, smited = smited, attack_direction = attack_direction, wound_source = wound_source, replacing = TRUE)
	. = new_wound
	qdel(src)

/// Непосредственные негативные эффекты, с которыми сталкиваются в результате раны
/datum/wound/proc/wound_injury(datum/wound/old_wound = null, attack_direction = null)
	return

/// Процедура, вызываемая для изменения переменной `disabling` и реакции на событие.
/datum/wound/proc/set_disabling(new_value)
	if(disabling == new_value)
		return
	. = disabling
	disabling = new_value
	if(disabling)
		if(!. && limb) // Получили отключающий эффект.
			limb.add_traits(list(TRAIT_PARALYSIS, TRAIT_DISABLED_BY_WOUND), REF(src))
	else if(. && limb) // Потеряли отключающий эффект.
		limb.remove_traits(list(TRAIT_PARALYSIS, TRAIT_DISABLED_BY_WOUND), REF(src))
	if(limb?.can_be_disabled)
		limb.update_disabled()

/// Сеттер для [interaction_efficiency_penalty]. Обновляет скорость действий нашего модификатора actionspeed_mod.
/datum/wound/proc/set_interaction_efficiency_penalty(new_value)
	var/should_update = (new_value != interaction_efficiency_penalty)

	interaction_efficiency_penalty = new_value

	if (should_update)
		update_actionspeed_modifier()

/// Возвращает "скорректированный" interaction_efficiency_penalty, который будет использоваться для модификатора actionspeed_mod.
/datum/wound/proc/get_effective_actionspeed_modifier()
	return interaction_efficiency_penalty - 1

/// Возвращает множитель десятых секунды для любых кликовых взаимодействий, предполагая, что наша конечность используется.
/datum/wound/proc/get_action_delay_mult()
	SHOULD_BE_PURE(TRUE)

	return interaction_efficiency_penalty

/// Возвращает приращение десятых секунды для любых кликовых взаимодействий, предполагая, что наша конечность используется.
/datum/wound/proc/get_action_delay_increment()
	SHOULD_BE_PURE(TRUE)

	return 0

/// Сигнальная процедура на случай, если на нашу конечность была наложена или удалена повязка.
/datum/wound/proc/gauze_state_changed()
	SIGNAL_HANDLER

	if (wound_flags & ACCEPTS_GAUZE) // ПРИНИМАЕТ_ПОВЯЗКУ
		update_inefficiencies()

/// Обновляет наши штрафы хромоты и взаимодействия в соответствии с нашей повязкой.
/datum/wound/proc/update_inefficiencies(replaced_or_replacing = FALSE)
	if (wound_flags & ACCEPTS_GAUZE) // ПРИНИМАЕТ_ПОВЯЗКУ
		if(limb.body_zone in list(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))
			if(limb.current_gauze?.splint_factor) // фактор_шины
				limp_slowdown = initial(limp_slowdown) * limb.current_gauze.splint_factor
				limp_chance = initial(limp_chance) * limb.current_gauze.splint_factor
			else
				limp_slowdown = initial(limp_slowdown)
				limp_chance = initial(limp_chance)
		else if(limb.body_zone in GLOB.arm_zones)
			if(limb.current_gauze?.splint_factor)
				set_interaction_efficiency_penalty(1 + ((get_effective_actionspeed_modifier()) * limb.current_gauze.splint_factor))
			else
				set_interaction_efficiency_penalty(initial(interaction_efficiency_penalty))

		if(initial(disabling))
			set_disabling(isnull(limb.current_gauze))

		limb.update_wounds(replaced_or_replacing)

	start_limping_if_we_should()

/// Дополнительные благоприятные эффекты при получении раны, на случай, если вы хотите дать временный усилитель, чтобы позволить жертве попытаться сбежать или совершить последний бой
/datum/wound/proc/second_wind()
	switch(severity)
		if(WOUND_SEVERITY_MODERATE)
			victim.reagents.add_reagent(/datum/reagent/determination, WOUND_DETERMINATION_MODERATE) // решимость
		if(WOUND_SEVERITY_SEVERE)
			victim.reagents.add_reagent(/datum/reagent/determination, WOUND_DETERMINATION_SEVERE)
		if(WOUND_SEVERITY_CRITICAL)
			victim.reagents.add_reagent(/datum/reagent/determination, WOUND_DETERMINATION_CRITICAL)
		if(WOUND_SEVERITY_LOSS)
			victim.reagents.add_reagent(/datum/reagent/determination, WOUND_DETERMINATION_LOSS)

/datum/wound/proc/interact_try_treating(datum/source, mob/living/user, obj/item/tool, ...)
	SIGNAL_HANDLER

	return try_treating(tool, user)

/**
 * Попытка лечить рану данным предметом/инструментом данным пользователем
 * Эта процедура ведет к [/datum/wound/proc/treat]
 *
 * Вы можете указать, какие предметы или инструменты вы хотите перехватывать
 * с помощью var/list/treatable_by и var/treatable_tool,
 * затем, если предмет соответствует одному из этих требований и наша рана заявляет его первой,
 * он передается в treat() и treat_self().
 *
 * Аргументы:
 * * I: Предмет, который мы пытаемся использовать
 * * user: Моб, пытающийся использовать его на нас
 */
/datum/wound/proc/try_treating(obj/item/tool, mob/living/user)
	SHOULD_NOT_OVERRIDE(TRUE)

	if(limb.body_zone != user.zone_selected)
		return NONE

	if(user.combat_mode && tool.force)
		return NONE

	if(!item_can_treat(tool, user))
		return NONE

	// теперь, когда мы определили, что у нас есть действительная попытка лечения,
	// мы можем раздавить их мечты, если мы уже взаимодействуем с пациентом или если их часть скрыта
	if(DOING_INTERACTION_WITH_TARGET(user, victim))
		to_chat(user, span_warning("Вы уже взаимодействуете с [victim]!"))
		return ITEM_INTERACT_BLOCKING

	// далее мы проверяем, доступна ли часть тела (не под толстой одеждой). Мы пропускаем проверку черты вида, так как скелеты
	// и подобные могут нуждаться в использовании костного геля, но могут носить скафандр по... какой-то причине, по которой скелет носил бы скафандр
	if(ishuman(victim))
		var/mob/living/carbon/human/victim_human = victim
		if(!victim_human.try_inject(user, injection_flags = INJECT_CHECK_IGNORE_SPECIES | INJECT_TRY_SHOW_ERROR_MESSAGE))
			return ITEM_INTERACT_BLOCKING

	INVOKE_ASYNC(src, PROC_REF(treat), tool, user)
	return ITEM_INTERACT_SUCCESS

/// Возвращает TRUE, если предмет может быть использован для лечения наших ран. Перехватывается в treat() - только вещи, возвращающие TRUE здесь, могут быть использованы там.
/datum/wound/proc/item_can_treat(obj/item/potential_treater, mob/user)
	// проверяем, есть ли у нас действительный лечащий инструмент
	if(potential_treater.tool_behaviour in treatable_tools)
		return TRUE
	// в противном случае, проверяем, агрессивно ли мы хватаем их и есть ли у нас предмет, который работает только при агрессивном захвате
	if((user == victim || (user.pulling == victim && user.grab_state >= GRAB_AGGRESSIVE)) && check_grab_treatments(potential_treater, user))
		return TRUE
	// иначе, проверяем, есть ли у нас общеразрешенный предмет
	if(is_type_in_list(potential_treater, treatable_by))
		return TRUE
	return FALSE

/// Возвращает TRUE, если у нас есть предмет, который можно использовать только при агрессивном захвате
/// (невооруженные лечения при агрессивном захвате идут в [/datum/wound/proc/try_handling]).
/// Лечение все равно обрабатывается в [/datum/wound/proc/treat]
/datum/wound/proc/check_grab_treatments(obj/item/tool, mob/user)
	return FALSE

/// Похоже на try_treating(), но для невооруженных взаимодействий, используется, например, для ручного вправления вывиха сустава.
/// Игнорирует проверки толстой одежды, так как вы можете вправить руку на место через толстый костюм, в отличие от использования швов
/datum/wound/proc/try_handling(mob/living/user)
	return FALSE

/// Кто-то использует что-то, что может быть использовано для лечения раны на этой конечности
/datum/wound/proc/treat(obj/item/tool, mob/user)
	return

/// Если var/processing равен TRUE, это запускается каждый жизненный тик
/datum/wound/proc/handle_process(seconds_per_tick, times_fired)
	return

/// Для использования в проверках обратного вызова do_after
/datum/wound/proc/still_exists()
	return (!QDELETED(src) && limb)

/// Когда наша родительская часть тела повреждена.
/datum/wound/proc/receive_damage(wounding_type, wounding_dmg, wound_bonus, attack_direction, damage_source)
	return

/// Вызывается из криоксадона и пироксадона, когда они действуют. Раны будут медленно фиксироваться отдельно от других методов, когда они действуют. Плохое название, но ладно
/datum/wound/proc/on_xadone(power)
	cryo_progress += power

	return handle_xadone_progress()

/// Выполняет различные действия на основе [cryo_progress]. По умолчанию удаляет рану (qdel) после определенного порога.
/datum/wound/proc/handle_xadone_progress()
	if(cryo_progress > get_xadone_progress_to_qdel())
		qdel(src)

/// Возвращает количество [cryo_progress], необходимое для нашего удаления (qdel).
/datum/wound/proc/get_xadone_progress_to_qdel()
	SHOULD_BE_PURE(TRUE)

	return base_xadone_progress_to_qdel * severity

/// Когда синтетическая плоть применяется к жертве, мы вызываем это. Нет смысла настраивать целую систему химических реакций для ран, когда нас волнуют лишь несколько химикатов. Вероятно, изменится в будущем
/datum/wound/proc/on_synthflesh(reac_volume)
	return

/// Вызывается, когда пациент находится в стазисе, чтобы полностью вылеченная рана не заставляла вас беспомощно сидеть, пока вы не догадаетесь отстегнуть их
/datum/wound/proc/on_stasis(seconds_per_tick, times_fired)
	return

/// Устанавливает наш кровоток
/datum/wound/proc/set_blood_flow(set_to)
	adjust_blood_flow(set_to - blood_flow)

/// Используйте это для изменения кровотока. Вы должны использовать это для изменения переменной
/// Принимает количество, на которое нужно скорректировать, и минимальное количество, которое мы можем иметь после корректировки
/datum/wound/proc/adjust_blood_flow(adjust_by, minimum = 0)
	if(!adjust_by)
		return
	var/old_flow = blood_flow
	blood_flow = max(blood_flow + adjust_by, minimum)

	if(old_flow == blood_flow)
		return

	/// Обновляем нашу скорость кровотечения
	limb.refresh_bleed_rate()

/// Используется, когда нас тащат во время кровотечения, значение, которое мы возвращаем, - это сколько потери крови эта рана вызывает от волочения. Поскольку это процедура, вы можете позволить повязкам впитать часть крови
/datum/wound/proc/drag_bleed_amount()
	return

/**
 * get_bleed_rate_of_change() используется в [/mob/living/carbon/proc/bleed_warn] для оценки, становится ли эта рана (если кровоточит) хуже, лучше или остается той же с течением времени
 *
 * Возвращает BLOOD_FLOW_STEADY, если мы не кровоточим или нет изменений (как при проколе), BLOOD_FLOW_DECREASING, если мы свертываемся (несерьезные порезы, с повязкой, коагулянт и т.д.), BLOOD_FLOW_INCREASING, если мы раскрываемся (серьезные порезы/гепарин/закись азота)
 */
/datum/wound/proc/get_bleed_rate_of_change()
	if(blood_flow && HAS_TRAIT(victim, TRAIT_BLOOD_FOUNTAIN)) // ИСТОЧНИК_КРОВИ
		return BLOOD_FLOW_INCREASING
	return BLOOD_FLOW_STEADY

/**
 * get_examine_description() используется в carbon/examine и human/examine для показа статуса этой раны. Полезно, если вам нужно показать какой-то статус, например, наложение шины или повязки на рану.
 *
 * Возвращает полную строку, которую вы хотите показать, обратите внимание, что мы уже имеем дело с тегом 'warning' на этом этапе, и \n уже добавлен за вас в месте вызова
 *
 * Аргументы:
 * * mob/user: Пользователь, осматривающий владельца раны, если это имеет значение
 */
/datum/wound/proc/get_examine_description(mob/user)
	. = get_wound_description(user)
	if(HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		. += span_notice("<br>Рядом с раной есть голо-изображение, которое, кажется, содержит указания для лечения.")

	return .

/datum/wound/proc/get_wound_description(mob/user)
	var/desc

	if ((wound_flags & ACCEPTS_GAUZE) && limb.current_gauze) // ПРИНИМАЕТ_ПОВЯЗКУ
		var/sling_condition = get_gauze_condition()
		desc = "[victim.p_Their()] [limb.plaintext_zone] [sling_condition] закреплена в перевязи из [limb.current_gauze.name]"
	else
		desc = "[victim.p_Their()] [limb.plaintext_zone] [examine_desc]"

	desc = modify_desc_before_span(desc, user)

	return get_desc_intensity(desc)

/**
 * Используется, когда моб осматривает себя / свои конечности
 *
 * Сообщает, как эта рана выглядит для них
 *
 * Должно быть отформатировано как продолжение конечности:
 * Входные данные - что-то вроде "Ваша грудь ушиблена.",
 * вы добавили бы что-то вроде "Она кровоточит."
 *
 * * self_aware - если TRUE, осматривающий более осознает себя и, следовательно, может получить более подробную информацию
 *
 * Возвращает строку для объединения с другими строками статуса органов / конечностей. Включайте теги и знаки препинания.
 */
/datum/wound/proc/get_self_check_description(self_aware)
	switch(severity)
		if(WOUND_SEVERITY_TRIVIAL)
			return span_danger("Она страдает от [LOWER_TEXT(undiagnosed_name || name)].")
		if(WOUND_SEVERITY_MODERATE)
			return span_warning("Она страдает от [LOWER_TEXT(undiagnosed_name || name)].")
		if(WOUND_SEVERITY_SEVERE)
			return span_boldwarning("Она страдает от [LOWER_TEXT(undiagnosed_name || name)]!")
		if(WOUND_SEVERITY_CRITICAL)
			return span_boldwarning("Она страдает от [LOWER_TEXT(undiagnosed_name || name)]!!")

/// Хук-процедура, используемая для изменения desc перед ее оборачиванием в теги через [get_desc_intensity]. Полезна для самостоятельной вставки тегов.
/datum/wound/proc/modify_desc_before_span(desc, mob/user)
	return desc

/datum/wound/proc/get_gauze_condition()
	SHOULD_BE_PURE(TRUE)
	if (!limb.current_gauze)
		return null

	switch(limb.current_gauze.absorption_capacity) // ёмкость_впитывания
		if(0 to 1.25)
			return "едва"
		if(1.25 to 2.75)
			return "слабо"
		if(2.75 to 4)
			return "в основном"
		if(4 to INFINITY)
			return "туго"

/// Оборачивает [desc] в теги на основе нашей тяжести.
/datum/wound/proc/get_desc_intensity(desc)
	SHOULD_BE_PURE(TRUE)
	if (severity > WOUND_SEVERITY_MODERATE)
		return span_bold("[desc]!")
	return "[desc]."

/**
 * Выводит подробности о ране для сканера ран в простом режиме
 */
/datum/wound/proc/get_scanner_description(mob/user)
	return "Тип: [name]<br>\
		Тяжесть: [severity_text()]<br>\
		Описание: [desc]<br>\
		Рекомендуемое лечение: [treat_text]"

/**
 * Выводит подробности о ране для сканера ран в сложном режиме
 */
/datum/wound/proc/get_simple_scanner_description(mob/user)
	var/severity_text_formatted = severity_text()
	for(var/i in 1 to severity)
		severity_text_formatted += "!"

	return "Обнаружено: [name]!<br>\
		Риск: [severity_text_formatted]<br>\
		Описание: [simple_desc || desc]<br>\
		<i>Руководство по лечению: [simple_treat_text]</i><br>\
		<i>Самодельные средства: [homemade_treat_text]</i>"

/**
 * Возвращает текстовое описание тяжести этой раны
 */
/datum/wound/proc/severity_text()
	switch(severity)
		if(WOUND_SEVERITY_TRIVIAL)
			return "Незначительная"
		if(WOUND_SEVERITY_MODERATE)
			return "Умеренная"
		if(WOUND_SEVERITY_SEVERE)
			return "<b>Серьезная</b>"
		if(WOUND_SEVERITY_CRITICAL)
			return "<b>Критическая</b>"

/// Возвращает TRUE, если наша конечность - голова или грудь, FALSE в противном случае.
/// Важна в смысле "мы не можем жить без нее".
/datum/wound/proc/limb_essential()
	return (limb.body_zone == BODY_ZONE_HEAD || limb.body_zone == BODY_ZONE_CHEST)

/// Геттер для нашего scar_keyword, на случай, если у нас может быть какая-то пользовательская логика генерации шрамов.
/datum/wound/proc/get_scar_keyword(obj/item/bodypart/scarred_limb, add_to_scars)
	return scar_keyword

/// Геттер для нашего scar_file, на случай, если у нас может быть какая-то пользовательская логика генерации шрамов.
/datum/wound/proc/get_scar_file(obj/item/bodypart/scarred_limb, add_to_scars)
	var/datum/wound_pregen_data/pregen_data = get_pregen_data()
	// в основном мы перебираем биотипы, пока не найдем тот, который нам нужен
	// мясистые ожоги будут искать плоть, затем кость
	// вывихи будут искать плоть, затем кость, затем металл
	var/file = default_scar_file
	for (var/biotype in pregen_data.scar_priorities)
		if (scarred_limb.biological_state & text2num(biotype))
			file = GLOB.biotypes_to_scar_file[biotype]
			break

	return file

/// Возвращает, какая строка отображается при осмотре конечности, которая получила эту рану
/// (Это осмотр САМОЙ КОНЕЧНОСТИ, когда она не прикреплена к кому-либо.)
/datum/wound/proc/get_limb_examine_description()
	return

/// Получает плоский процентный бонус шанса ампутации, если попытка ампутации предпринимается (требуется изувеченная плоть и кость). возврат 15 = +15%.
/datum/wound/proc/get_dismember_chance_bonus(existing_chance)
	SHOULD_BE_PURE(TRUE)

	var/datum/wound_pregen_data/pregen_data = get_pregen_data()

	if (pregen_data.required_wounding_type == WOUND_BLUNT && severity >= WOUND_SEVERITY_CRITICAL)
		return WOUND_CRITICAL_BLUNT_DISMEMBER_BONUS // нам требуется только изувеченная кость (T2 тупая), но если есть критическая тупая травма, мы добавим еще 15%

/// Возвращает наши предварительно сгенерированные данные, которые практически гарантированно существуют, поэтому эту процедуру можно безопасно использовать напрямую.
/// Фактически, поскольку она RETURN_TYPE'd в wound_pregen_data, вы можете даже напрямую обращаться к переменным, не сохраняя значение этой процедуры в типизированной переменной.
/// Пример: get_pregen_data().wound_series
/datum/wound/proc/get_pregen_data()
	RETURN_TYPE(/datum/wound_pregen_data)

	return GLOB.all_wound_pregen_data[type]

#undef WOUND_CRITICAL_BLUNT_DISMEMBER_BONUS
