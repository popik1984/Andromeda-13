/datum/wound_pregen_data/cranial_fissure // ЧЕРЕПНАЯ_ТРЕЩИНА
	wound_path_to_generate = /datum/wound/cranial_fissure
	required_limb_biostate = BIO_BONE

	required_wounding_type = WOUND_ALL

	wound_series = WOUND_SERIES_CRANIAL_FISSURE // СЕРИЯ_РАН_ЧЕРЕПНАЯ_ТРЕЩИНА

	threshold_minimum = 110
	weight = 10

	viable_zones = list(BODY_ZONE_HEAD)

/datum/wound_pregen_data/cranial_fissure/get_weight(obj/item/bodypart/limb, woundtype, damage, attack_direction, damage_source)
	if (isnull(limb.owner))
		return ..()

	if (HAS_TRAIT(limb.owner, TRAIT_CURSED) && (limb.get_mangled_state() & BODYPART_MANGLED_INTERIOR)) // ПРОКЛЯТИЙ, СОСТОЯНИЕ_ИЗУВЕЧЕНИЯ_ИНТЕРЬЕРА
		return ..()

	if (limb.owner.stat >= HARD_CRIT) // ТЯЖЕЛЫЙ_КРИТ
		return ..()

	return 0

/// Рана, наносимая при получении достаточно значительного урона по голове.
/// Позволит другим игрокам вынимать ваши глаза из головы, а поскользнувшись,
/// вы заставите ваш мозг выпасть из головы.
/datum/wound/cranial_fissure // ЧЕРЕПНАЯ_ТРЕЩИНА
	name = "Перелом черепа"
	desc = "Череп пациента расколот, обнажая серьезные повреждения."
	treat_text = "Необходима хирургическая реконструкция черепа."
	treat_text_short = "Требуется хирургическая реконструкция."
	examine_desc = "расколот на части"
	occur_text = "раскалывается отдельные части"

	simple_desc = "Череп пациента расколот."
	threshold_penalty = 40

	severity = WOUND_SEVERITY_CRITICAL
	sound_effect = 'sound/effects/dismember.ogg'

	/// If TRUE we have been prepped for surgery (to repair)
	VAR_FINAL/prepped = FALSE

#define CRANIAL_FISSURE_FILTER_DISPLACEMENT "cranial_fissure_displacement" // ФИЛЬТР_СМЕЩЕНИЯ_ЧЕРЕПНОЙ_ТРЕЩИНЫ

/datum/wound/cranial_fissure/wound_injury(datum/wound/old_wound = null, attack_direction = null)
	ADD_TRAIT(limb, TRAIT_IMMUNE_TO_CRANIAL_FISSURE, type) // НЕВОСПРИИМЧИВОСТЬ_К_ЧЕРЕПНОЙ_ТРЕЩИНЕ
	ADD_TRAIT(victim, TRAIT_HAS_CRANIAL_FISSURE, type) // ИМЕЕТ_ЧЕРЕПНУЮ_ТРЕЩИНУ

	victim.add_filter(CRANIAL_FISSURE_FILTER_DISPLACEMENT, 2, displacement_map_filter(icon('icons/effects/cranial_fissure.dmi', "displacement"), size = 3))

	RegisterSignal(victim, COMSIG_MOB_SLIPPED, PROC_REF(on_owner_slipped)) // СИГНАЛ_МОБ_ПОСКОЛЬЗНУЛСЯ

/datum/wound/cranial_fissure/remove_wound(ignore_limb, replaced)
	REMOVE_TRAIT(limb, TRAIT_IMMUNE_TO_CRANIAL_FISSURE, type)
	if (!isnull(victim))
		REMOVE_TRAIT(victim, TRAIT_HAS_CRANIAL_FISSURE, type)
		victim.remove_filter(CRANIAL_FISSURE_FILTER_DISPLACEMENT)
		UnregisterSignal(victim, COMSIG_MOB_SLIPPED)
	return ..()

/datum/wound/cranial_fissure/proc/on_owner_slipped(mob/source)
	SIGNAL_HANDLER

	if (source.stat == DEAD)
		return

	var/obj/item/organ/brain/brain = source.get_organ_by_type(/obj/item/organ/brain)
	if (isnull(brain))
		return

	brain.Remove(source)

	var/turf/source_turf = get_turf(source)
	brain.forceMove(source_turf)
	brain.throw_at(get_step(source_turf, source.dir), 1, 1)

	source.visible_message(
		span_boldwarning("Мозг [source] вываливается прямо из [source.p_their()] головы!"),
		span_userdanger("Ваш мозг вываливается прямо из вашей головы!"),
	)

/datum/wound/cranial_fissure/try_handling(mob/living/user)
	if (user.usable_hands <= 0 || user.combat_mode)
		return FALSE

	if(!isnull(user.hud_used?.zone_select) && (user.zone_selected != BODY_ZONE_HEAD && user.zone_selected != BODY_ZONE_PRECISE_EYES)) // ЗОНА_ТОЧНЫЕ_ГЛАЗА
		return FALSE

	if (victim.body_position != LYING_DOWN)
		return FALSE

	var/obj/item/organ/eyes/eyes = victim.get_organ_by_type(/obj/item/organ/eyes)
	if (isnull(eyes))
		victim.balloon_alert(user, "нет глаз для извлечения!")
		return TRUE

	playsound(victim, 'sound/items/handling/surgery/organ2.ogg', 50, TRUE)
	victim.balloon_alert(user, "извлекаем глаза...")
	user.visible_message(
		span_boldwarning("[user] засовывает руку внутрь черепа [victim]..."),
		ignored_mobs = user
	)
	victim.show_message(
		span_userdanger("[victim] начинает вытаскивать ваши глаза!"),
		MSG_VISUAL,
		span_userdanger("Рука проникает внутрь вашего мозга и начинает тянуть за ваши глаза!"),
	)

	if (!do_after(user, 10 SECONDS, victim, extra_checks = CALLBACK(src, PROC_REF(still_has_eyes), eyes)))
		return TRUE

	eyes.Remove(victim)
	user.put_in_hands(eyes)

	log_combat(user, victim, "вырвал глаза у")

	playsound(victim, 'sound/items/handling/surgery/organ1.ogg', 75, TRUE)
	user.visible_message(
		span_boldwarning("[user] вырывает глаза [victim]!"),
		span_boldwarning("Вы вырываете глаза [victim]!"),
		ignored_mobs = victim,
	)

	victim.show_message(
		span_userdanger("[user] вырывает ваши глаза!"),
		MSG_VISUAL,
		span_userdanger("Вы чувствуете, как рука дергается внутри вашей головы, и понимаете, что чего-то очень важного не хватает!"),
	)

	return TRUE

/datum/wound/cranial_fissure/proc/still_has_eyes(obj/item/organ/eyes/eyes)
	PRIVATE_PROC(TRUE)

	return victim?.get_organ_by_type(/obj/item/organ/eyes) == eyes

#undef CRANIAL_FISSURE_FILTER_DISPLACEMENT
