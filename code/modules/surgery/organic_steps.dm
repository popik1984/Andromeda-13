
/**
 * MARK: НАДРЕЗ
 */

/// Надрез
/datum/surgery_step/incise
	name = "сделайте надрез"
	implements = list(
		TOOL_SCALPEL = 100,
		/obj/item/melee/energy/sword = 75,
		/obj/item/knife = 65,
		/obj/item/shard = 45,
		/obj/item = 25)
	time = 1.5 SECONDS
	preop_sound = 'sound/items/handling/surgery/scalpel1.ogg'
	success_sound = 'sound/items/handling/surgery/scalpel2.ogg'
	surgery_effects_mood = TRUE

/datum/surgery_step/incise/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете делать надрез в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]..."),
		span_notice("[user] начинает делать надрез в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
		span_notice("[user] начинает делать надрез в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
	)
	display_pain(target, "Вы чувствуете колющую боль в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)].")

/datum/surgery_step/incise/tool_check(mob/user, obj/item/tool)
	if(implement_type == /obj/item && !tool.get_sharpness())
		return FALSE

	return TRUE

/datum/surgery_step/incise/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if ishuman(target)
		var/mob/living/carbon/human/human_target = target
		if (human_target.can_bleed())
			var/blood_name = human_target.get_bloodtype()?.get_blood_name() || "крови"
			display_results(
				user,
				target,
				span_notice("Вокруг [target.parse_zone_with_bodypart(target_zone, GENITIVE)] у [human_target] образуется лужа [blood_name]."),
				span_notice("Вокруг [target.parse_zone_with_bodypart(target_zone, GENITIVE)] у [human_target] образуется лужа [blood_name]."),
				span_notice("Вокруг [target.parse_zone_with_bodypart(target_zone, GENITIVE)] у [human_target] образуется лужа [blood_name]."),
			)
			var/obj/item/bodypart/target_bodypart = target.get_bodypart(target_zone)
			if(target_bodypart)
				target_bodypart.adjustBleedStacks(10)
	return ..()

/datum/surgery_step/incise/nobleed/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете <i>осторожно</i> делать надрез в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]..."),
		span_notice("[user] начинает <i>осторожно</i> делать надрез в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
		span_notice("[user] начинает <i>осторожно</i> делать надрез в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
	)
	display_pain(target, "Вы чувствуете <i>осторожный</i> колющий удар в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)].")


/// Вена
/datum/surgery_step/incise/vein
	name = "перерезать вену"

/datum/surgery_step/incise/vein/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете делать надрез в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]..."),
		span_notice("[user] начинает делать надрез в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
		span_notice("[user] начинает делать надрез в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
	)
	display_pain(target, "Вы чувствуете колющую боль в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)].")

/datum/surgery_step/incise/vein/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if ishuman(target)
		var/mob/living/carbon/human/human_target = target
		if (human_target.can_bleed())
			var/blood_name = human_target.get_bloodtype()?.get_blood_name() || "крови"
			display_results(
				user,
				target,
				span_notice("Вокруг [target.parse_zone_with_bodypart(target_zone, GENITIVE)] у [human_target] образуется лужа [blood_name]."),
				span_notice("Вокруг [target.parse_zone_with_bodypart(target_zone, GENITIVE)] у [human_target] образуется лужа [blood_name]."),
				span_notice("Вокруг [target.parse_zone_with_bodypart(target_zone, GENITIVE)] у [human_target] образуется лужа [blood_name]."),
			)
			var/obj/item/bodypart/target_bodypart = target.get_bodypart(target_zone)
			if(target_bodypart)
				target_bodypart.adjustBleedStacks(10)
	return ..()

/// Артерия
/datum/surgery_step/incise/artery
	name = "перерезать артерию"

/datum/surgery_step/incise/artery/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете делать надрез в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]..."),
		span_notice("[user] начинает делать надрез в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
		span_notice("[user] начинает делать надрез в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
	)
	display_pain(target, "Вы чувствуете колющую боль в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)].")

/datum/surgery_step/incise/artery/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if ishuman(target)
		var/mob/living/carbon/human/human_target = target
		if (human_target.can_bleed())
			var/blood_name = human_target.get_bloodtype()?.get_blood_name() || "крови"
			display_results(
				user,
				target,
				span_notice("Вокруг [target.parse_zone_with_bodypart(target_zone, GENITIVE)] у [human_target] образуется лужа [blood_name]."),
				span_notice("Вокруг [target.parse_zone_with_bodypart(target_zone, GENITIVE)] у [human_target] образуется лужа [blood_name]."),
				span_notice("Вокруг [target.parse_zone_with_bodypart(target_zone, GENITIVE)] у [human_target] образуется лужа [blood_name]."),
			)
			var/obj/item/bodypart/target_bodypart = target.get_bodypart(target_zone)
			if(target_bodypart)
				target_bodypart.adjustBleedStacks(10)
	return ..()

/**
 * MARK: РАЗДВИНУТЬ
 */

/datum/surgery_step/retract
	name = "раздвиньте"
	implements = list(
		TOOL_RETRACTOR = 100,
		TOOL_SCREWDRIVER = 45,
		TOOL_WIRECUTTER = 35,
		/obj/item/stack/rods = 35)
	time = 3.0 SECONDS
	preop_sound = 'sound/items/handling/surgery/retractor1.ogg'
	success_sound = 'sound/items/handling/surgery/retractor2.ogg'

/// Кожа
/datum/surgery_step/retract/skin
	name = "раздвиньте кожу"
	time = 2.0 SECONDS

/datum/surgery_step/retract/skin/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете раздвигать кожу в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]..."),
		span_notice("[user] начинаете раздвигать кожу в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
		span_notice("[user] начинаете раздвигать кожу в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
	)
	display_pain(target, "Вы чувствуете сильную жгучую боль, распространяющуюся везде по [target.parse_zone_with_bodypart(target_zone, DATIVE)], по мере того, как кожа возвращается в прежнее состояние!")

/// Ткани (Внутрянка)
/datum/surgery_step/retract/tissues
	name = "раздвиньте ткани"
	time = 3.5 SECONDS

/datum/surgery_step/retract/tissues/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете раздвигать внутренние ткани в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]..."),
		span_notice("[user] начинаете раздвигать внутренние ткани в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
		span_notice("[user] начинаете раздвигать внутренние ткани в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
	)
	display_pain(target, "Вы чувствуете сильную жгучую боль, распространяющуюся везде по [target.parse_zone_with_bodypart(target_zone, DATIVE)], по мере того, как кожа возвращается в прежнее состояние!")

/**
 * MARK: НАЙТИ
 */

/datum/surgery_step/find
	name = "найти вену"
	accept_hand = TRUE
	time = 0.5 SECONDS

// Вена
/datum/surgery_step/find/vein
	name = "найти вену" /// Ахахахаха, где вена?! Куда крокодаил колоть?

/datum/surgery_step/find/vein/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете искать вену в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
		span_notice("[user] начинаете искать вену в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
		span_notice("[user] начинает что-то искат в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
	)
	display_pain(target, "Ваша [target.parse_zone_with_bodypart(target_zone, NOMINATIVE)] горит от сильной боли!")

// Артерия
/datum/surgery_step/find/artery
	name = "найти артерию"

/datum/surgery_step/find/artery/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете искать артерию в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
		span_notice("[user] начинаете искать артерию в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
		span_notice("[user] начинает что-то искат в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
	)
	display_pain(target, "Ваша [target.parse_zone_with_bodypart(target_zone, NOMINATIVE)] горит от сильной боли!")

// Нерв
/datum/surgery_step/find/nerve
	name = "найти нерв"

/datum/surgery_step/find/nerve/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете искать артерию в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
		span_notice("[user] начинаете искать артерию в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
		span_notice("[user] начинает что-то искат в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
	)
	display_pain(target, "Ваша [target.parse_zone_with_bodypart(target_zone, NOMINATIVE)] горит от сильной боли!")

/**
 * MARK: ЗАЖАТЬ
 */

/datum/surgery_step/clamp
	name = "зажмите кровеносные сосуды"
	implements = list(
		TOOL_HEMOSTAT = 100,
		TOOL_WIRECUTTER = 60,
		/obj/item/stack/package_wrap = 35,
		/obj/item/stack/cable_coil = 15)
	time = 2.5 SECONDS
	preop_sound = 'sound/items/handling/surgery/hemostat1.ogg'

/// Зажать сосуды
/datum/surgery_step/clamp/vessels
	name = "зажмите кровеносные сосуды"
	time = 2.5 SECONDS

/datum/surgery_step/clamp/vessels/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете зажимать кровеносные сосуды в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]..."),
		span_notice("[user] начинает зажимать кровеносные сосуды в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
		span_notice("[user] начинает зажимать кровеносные сосуды в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
	)
	display_pain(target, "Вы чувствуете укол, после чего кровотечение в вашей [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] замедляется.")

/datum/surgery_step/clamp/vessels/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results)
	if(locate(/datum/surgery_step/saw) in surgery.steps)
		target.heal_bodypart_damage(20, 0, target_zone = target_zone)
	if (ishuman(target))
		var/mob/living/carbon/human/human_target = target
		var/obj/item/bodypart/target_bodypart = human_target.get_bodypart(target_zone)
		if(target_bodypart)
			target_bodypart.adjustBleedStacks(-3)
	return ..()

/// Зажать вену
/datum/surgery_step/clamp/vein
	name = "зажмите вену"
	time = 3.0 SECONDS

/datum/surgery_step/clamp/vein/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете зажимать вену в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]..."),
		span_notice("[user] начинает зажимать вену в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
		span_notice("[user] начинает зажимать вену в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
	)
	display_pain(target, "Вы чувствуете укол, после чего кровотечение в вашей [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] замедляется.")

/datum/surgery_step/clamp/vein/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results)
	if(locate(/datum/surgery_step/saw) in surgery.steps)
		target.heal_bodypart_damage(20, 0, target_zone = target_zone)
	if (ishuman(target))
		var/mob/living/carbon/human/human_target = target
		var/obj/item/bodypart/target_bodypart = human_target.get_bodypart(target_zone)
		if(target_bodypart)
			target_bodypart.adjustBleedStacks(-3)
	return ..()

/// Зажать артерию
/datum/surgery_step/clamp/artery
	name = "зажмите артерию"
	time = 3.5 SECONDS

/datum/surgery_step/clamp/artery/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете зажимать артерию в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]..."),
		span_notice("[user] начинает зажимать артерию в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
		span_notice("[user] начинает зажимать артерию в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
	)
	display_pain(target, "Вы чувствуете укол, после чего кровотечение в вашей [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] замедляется.")

/datum/surgery_step/clamp/artery/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results)
	if(locate(/datum/surgery_step/saw) in surgery.steps)
		target.heal_bodypart_damage(20, 0, target_zone = target_zone)
	if (ishuman(target))
		var/mob/living/carbon/human/human_target = target
		var/obj/item/bodypart/target_bodypart = human_target.get_bodypart(target_zone)
		if(target_bodypart)
			target_bodypart.adjustBleedStacks(-3)
	return ..()

/**
 * MARK: КОСТНЫЕ ТКАНИ
 */

/// Распилить кость
/datum/surgery_step/saw
	name = "распилите кость"
	implements = list(
		TOOL_SAW = 100,
		/obj/item/shovel/serrated = 75,
		/obj/item/melee/arm_blade = 75,
		/obj/item/fireaxe = 50,
		/obj/item/hatchet = 35,
		/obj/item/knife/butcher = 35,
		/obj/item = 25)
	time = 5.4 SECONDS
	preop_sound = list(
		/obj/item/circular_saw = 'sound/items/handling/surgery/saw.ogg',
		/obj/item/melee/arm_blade = 'sound/items/handling/surgery/scalpel1.ogg',
		/obj/item/fireaxe = 'sound/items/handling/surgery/scalpel1.ogg',
		/obj/item/hatchet = 'sound/items/handling/surgery/scalpel1.ogg',
		/obj/item/knife/butcher = 'sound/items/handling/surgery/scalpel1.ogg',
		/obj/item = 'sound/items/handling/surgery/scalpel1.ogg',
	)
	success_sound = 'sound/items/handling/surgery/organ2.ogg'
	surgery_effects_mood = TRUE

/datum/surgery_step/saw/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете распиливать кость в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]..."),
		span_notice("[user] начинает распиливать кость в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
		span_notice("[user] начинает распиливать кость в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
	)
	display_pain(target, "Вы чувствуете ужасную боль внутри [target.parse_zone_with_bodypart(target_zone, GENITIVE)]!")

/datum/surgery_step/saw/tool_check(mob/user, obj/item/tool)
	if(implement_type == /obj/item && !(tool.get_sharpness() && (tool.force >= 10)))
		return FALSE
	return TRUE

/datum/surgery_step/saw/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results)
	target.apply_damage(50, BRUTE, "[target_zone]", wound_bonus=CANT_WOUND)
	display_results(
		user,
		target,
		span_notice("Вы вскрываете [target.parse_zone_with_bodypart(target_zone, ACCUSATIVE)] у [target]."),
		span_notice("[user] вскрывает [target.parse_zone_with_bodypart(target_zone, ACCUSATIVE)] у [target]!"),
		span_notice("[user] вскрывает [target.parse_zone_with_bodypart(target_zone, ACCUSATIVE)] у [target]!"),
	)
	display_pain(target, "Такое ощущение, что в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] что-то сломано!")
	return ..()

/// Просверлить кость
/datum/surgery_step/drill
	name = "просверлите кость"
	implements = list(
		TOOL_DRILL = 100,
		/obj/item/screwdriver/power = 80,
		/obj/item/pickaxe/drill = 60,
		TOOL_SCREWDRIVER = 25,
		/obj/item/kitchen/spoon = 20)
	time = 3 SECONDS

/datum/surgery_step/drill/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете сверлить прямо в кости в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]..."),
		span_notice("[user] начинает сверлить прямо в кости в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
		span_notice("[user] начинает сверлить прямо в кости в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
	)
	display_pain(target, "Вы чувствуете ужасную пронзительную боль в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)]!")

/datum/surgery_step/drill/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	display_results(
		user,
		target,
		span_notice("Вы просверлили [target.parse_zone_with_bodypart(target_zone, ACCUSATIVE)] у [target]."),
		span_notice("[user] просверливает [target.parse_zone_with_bodypart(target_zone, ACCUSATIVE)] у [target]!"),
		span_notice("[user] просверливает [target.parse_zone_with_bodypart(target_zone, ACCUSATIVE)] у [target]!"),
	)
	return ..()

/**
 * MARK: ПРИЖЕЧЬ
 */

/datum/surgery_step/cauterize
	name = "прижечь"
	implements = list(
		TOOL_CAUTERY = 100,
		TOOL_WELDER = 70,
		/obj/item = 25,
		/obj/item/gun/energy/laser = 10,
		)
	time = 1 SECONDS
	preop_sound = 'sound/items/handling/surgery/cautery1.ogg'
	success_sound = 'sound/items/handling/surgery/cautery2.ogg'

/datum/surgery_step/cauterize/tool_check(mob/user, obj/item/tool)
	if(implement_type == TOOL_WELDER || implement_type == /obj/item)
		return tool.get_temperature()

	return TRUE

/// Прижечь сосуды
/datum/surgery_step/cauterize/vessels
	name = "прижечь сосуды"
	time = 1.5 SECONDS

/datum/surgery_step/cauterize/vessels/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете прижигать сосуды в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]..."),
		span_notice("[user] начинает прижигать сосуды в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
		span_notice("[user] начинает прижигать сосуды в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
	)
	display_pain(target, "Ваша [target.parse_zone_with_bodypart(target_zone)] прижигается!")

/// Прижечь вены
/datum/surgery_step/cauterize/vein
	name = "прижечь вену"
	time = 2.5 SECONDS

/datum/surgery_step/cauterize/vein/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете прижигать вену в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]..."),
		span_notice("[user] начинает прижигать вену в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
		span_notice("[user] начинает прижигать вену в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
	)
	display_pain(target, "Ваша [target.parse_zone_with_bodypart(target_zone)] прижигается!")

/// Прижечь артерию
/datum/surgery_step/cauterize/artery
	name = "прижечь артерию"
	time = 4 SECONDS

/datum/surgery_step/cauterize/artery/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете прижигать артерию в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]..."),
		span_notice("[user] начинает прижигать артерию в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
		span_notice("[user] начинает прижигать артерию в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
	)
	display_pain(target, "Ваша [target.parse_zone_with_bodypart(target_zone)] прижигается!")

/**
 * MARK: ЗАВЕРШИТЬ
 */

/datum/surgery_step/close
	name = "закройте разрез"
	implements = list(
		TOOL_CAUTERY = 100,
		TOOL_WELDER = 70,
		/obj/item = 30,
		/obj/item/gun/energy/laser = 10,
		)
	time = 2.4 SECONDS
	preop_sound = 'sound/items/handling/surgery/cautery1.ogg'
	success_sound = 'sound/items/handling/surgery/cautery2.ogg'

/datum/surgery_step/close/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("Вы начинаете прижигать разрез в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]..."),
		span_notice("[user] начинает прижигать разрез в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
		span_notice("[user] начинает прижигать разрез в [target.parse_zone_with_bodypart(target_zone, PREPOSITIONAL)] у [target]."),
	)
	display_pain(target, "Ваша [target.parse_zone_with_bodypart(target_zone)] прижигается!")

/datum/surgery_step/close/tool_check(mob/user, obj/item/tool)
	if(implement_type == TOOL_WELDER || implement_type == /obj/item)
		return tool.get_temperature()

	return TRUE

/datum/surgery_step/close/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results)
	if(locate(/datum/surgery_step/saw) in surgery.steps)
		target.heal_bodypart_damage(45, 0, target_zone = target_zone)
	if (ishuman(target))
		var/mob/living/carbon/human/human_target = target
		var/obj/item/bodypart/target_bodypart = human_target.get_bodypart(target_zone)
		if(target_bodypart)
			target_bodypart.adjustBleedStacks(-3)
	return ..()
