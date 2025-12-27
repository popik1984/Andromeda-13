/**
 * MARK: Ампутация/органики
 */

// Голова
/datum/surgery/amputation
	name = "Ампутация"
	surgery_flags = SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB | SURGERY_MORBID_CURIOSITY
	possible_locs = list(
		BODY_ZONE_HEAD,
	)
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract/skin,
		/datum/surgery_step/cauterize/vessels,
		/datum/surgery_step/incise,
		/datum/surgery_step/retract/tissues,
		/datum/surgery_step/find/artery,
		/datum/surgery_step/clamp/artery,
		/datum/surgery_step/incise/artery,
		/datum/surgery_step/cauterize/artery,
		/datum/surgery_step/find/artery,
		/datum/surgery_step/clamp/artery,
		/datum/surgery_step/incise/artery,
		/datum/surgery_step/retract/tissues,
		/datum/surgery_step/find/vein,
		/datum/surgery_step/clamp/vein,
		/datum/surgery_step/incise/vein,
		/datum/surgery_step/cauterize/vein,
		/datum/surgery_step/find/nerve,
		/datum/surgery_step/incise,
		/datum/surgery_step/sever_limb,
	)

// Руки
/datum/surgery/amputation/arm
	possible_locs = list(
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_ARM,
	)
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract/skin,
		/datum/surgery_step/cauterize/vessels,
		/datum/surgery_step/find/vein,
		/datum/surgery_step/clamp/vein,
		/datum/surgery_step/incise/vein,
		/datum/surgery_step/cauterize/vein,
		/datum/surgery_step/incise,
		/datum/surgery_step/retract/tissues,
		/datum/surgery_step/incise,
		/datum/surgery_step/retract/tissues,
		/datum/surgery_step/find/artery,
		/datum/surgery_step/clamp/artery,
		/datum/surgery_step/incise/artery,
		/datum/surgery_step/cauterize/artery,
		/datum/surgery_step/find/nerve,
		/datum/surgery_step/incise,
		/datum/surgery_step/retract/tissues,
		/datum/surgery_step/sever_limb,
	)

// Ноги
/datum/surgery/amputation/leg
	possible_locs = list(
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG,
	)
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract/skin,
		/datum/surgery_step/cauterize/vessels,
		/datum/surgery_step/find/vein,
		/datum/surgery_step/clamp/vein,
		/datum/surgery_step/incise/vein,
		/datum/surgery_step/cauterize/vein,
		/datum/surgery_step/incise,
		/datum/surgery_step/retract/tissues,
		/datum/surgery_step/find/artery,
		/datum/surgery_step/clamp/artery,
		/datum/surgery_step/incise/artery,
		/datum/surgery_step/cauterize/artery,
		/datum/surgery_step/find/nerve,
		/datum/surgery_step/incise,
		/datum/surgery_step/retract/tissues,
		/datum/surgery_step/sever_limb,
	)

/**
 * MARK: Ампутация/силиконы
 */

// Голова
/datum/surgery/amputation/mechanic
	name = "Разбор"
	possible_locs = list(
		BODY_ZONE_HEAD,
	)
	requires_bodypart_type = BODYTYPE_ROBOTIC
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/open_hatch,
		/datum/surgery_step/sever_limb/mechanic,
	)

// Руки
/datum/surgery/amputation/mechanic/arm
	possible_locs = list(
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_ARM,
	)
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/open_hatch,
		/datum/surgery_step/sever_limb/mechanic,
	)

// Ноги
/datum/surgery/amputation/mechanic/leg
	possible_locs = list(
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG,
	)
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/open_hatch,
		/datum/surgery_step/sever_limb/mechanic,
	)

/**
 * MARK: Пиратские приколы
 */

/datum/surgery/amputation/peg
	name = "Отсоединить"
	requires_bodypart_type = BODYTYPE_PEG
	possible_locs = list(
		BODY_ZONE_HEAD,
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG,
	)
	steps = list(
		/datum/surgery_step/sever_limb/peg,	//Easy come, easy go
	)

/datum/surgery/amputation/can_start(mob/user, mob/living/patient)
	if(HAS_TRAIT(patient, TRAIT_NODISMEMBER))
		return FALSE
	return ..()

/datum/surgery_step/sever_limb
	name = "отрежьте конечность"
	implements = list(
		TOOL_SAW = 100,
		/obj/item/shovel/serrated = 75,
		/obj/item/melee/arm_blade = 80,
		/obj/item/fireaxe = 50,
		/obj/item/hatchet = 40,
		/obj/item/knife/butcher = 25,
	)
	time = 5 SECONDS
	preop_sound = 'sound/items/handling/surgery/scalpel1.ogg'
	success_sound = 'sound/items/handling/surgery/organ2.ogg'
	surgery_effects_mood = TRUE

/datum/surgery_step/sever_limb/mechanic
	name = "отсоедините конечность (ключ или лом)"
	implements = list(
		/obj/item/shovel/giant_wrench = 300,
		TOOL_WRENCH = 100,
		TOOL_CROWBAR = 100,
		TOOL_SCALPEL = 50,
		TOOL_SAW = 50,
	)
	time = 20 //WAIT I NEED THAT!!
	preop_sound = 'sound/items/tools/ratchet.ogg'
	preop_sound = 'sound/machines/airlock/doorclick.ogg'

/datum/surgery_step/sever_limb/peg
	name = "отсоедините конечность (циркулярная пила)"
	implements = list(
		TOOL_SAW = 100,
		/obj/item/shovel/serrated = 100,
		/obj/item/fireaxe = 90,
		/obj/item/hatchet = 75,
		TOOL_SCALPEL = 25,
	)
	time = 3 SECONDS
	preop_sound = 'sound/items/handling/surgery/saw.ogg'
	success_sound = 'sound/items/handling/materials/wood_drop.ogg'

/datum/surgery_step/sever_limb/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете отрезать [target.parse_zone_with_bodypart(target_zone, ACCUSATIVE)] у [target]..."),
		span_notice("[user] начинает отрезать [target.parse_zone_with_bodypart(target_zone, ACCUSATIVE)] у [target]!"),
		span_notice("[user] начинает отрезать [target.parse_zone_with_bodypart(target_zone, ACCUSATIVE)] у [target]!"),
	)
	display_pain(target, "Вы чувствуете жуткую боль в [parse_zone(target_zone, PREPOSITIONAL)]!")


/datum/surgery_step/sever_limb/success(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	display_results(
		user,
		target,
		span_notice("Вы отрезаете [target.parse_zone_with_bodypart(target_zone, ACCUSATIVE)] у [target]."),
		span_notice("[user] отрезает [target.parse_zone_with_bodypart(target_zone, ACCUSATIVE)] у [target]!"),
		span_notice("[user] отрезает [target.parse_zone_with_bodypart(target_zone, ACCUSATIVE)] у [target]!"),
	)
	display_pain(target, "Вы больше не чувствуете свою [target.parse_zone_with_bodypart(target_zone, ACCUSATIVE)]!")

	if(HAS_MIND_TRAIT(user, TRAIT_MORBID) && ishuman(user))
		var/mob/living/carbon/human/morbid_weirdo = user
		morbid_weirdo.add_mood_event("morbid_dismemberment", /datum/mood_event/morbid_dismemberment)

	if(surgery.operated_bodypart)
		var/obj/item/bodypart/target_limb = surgery.operated_bodypart
		target_limb.drop_limb()
	return ..()
