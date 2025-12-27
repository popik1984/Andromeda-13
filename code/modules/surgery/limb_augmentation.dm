
/////AUGMENTATION SURGERIES//////


//SURGERY STEPS

/datum/surgery_step/replace_limb
	name = "замените конечность"
	implements = list(
		/obj/item/bodypart = 100,
		/obj/item/borg/apparatus/organ_storage = 100)
	time = 3.2 SECONDS
	var/obj/item/bodypart/target_limb


/datum/surgery_step/replace_limb/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(HAS_TRAIT(target, TRAIT_NO_AUGMENTS))
		to_chat(user, span_warning("[target] не может быть проаугментирован!"))
		return SURGERY_STEP_FAIL
	if(istype(tool, /obj/item/borg/apparatus/organ_storage) && istype(tool.contents[1], /obj/item/bodypart))
		tool = tool.contents[1]
	var/obj/item/bodypart/aug = tool
	if(IS_ORGANIC_LIMB(aug))
		to_chat(user, span_warning("Это не аугментат!"))
		return SURGERY_STEP_FAIL
	if(aug.body_zone != target_zone)
		to_chat(user, span_warning("Для [target.parse_zone_with_bodypart(target_zone, GENITIVE)] не подходит [tool.declent_ru(NOMINATIVE)]."))
		return SURGERY_STEP_FAIL
	target_limb = surgery.operated_bodypart
	if(target_limb)
		display_results(
			user,
			target,
			span_notice("Вы начинаете аугментировать [target.parse_zone_with_bodypart(user.zone_selected, ACCUSATIVE)] у [target]..."),
			span_notice("[user] начинает аугментировать [target.parse_zone_with_bodypart(user.zone_selected, ACCUSATIVE)] у [target] с помощью [aug.declent_ru(GENITIVE)]."),
			span_notice("[user] начинает аугментировать [target.parse_zone_with_bodypart(user.zone_selected, ACCUSATIVE)] у [target]."),
		)
		display_pain(target, "Вы чувствуете ужасную боль в [target.parse_zone_with_bodypart(user.zone_selected, ACCUSATIVE)]!")
	else
		user.visible_message(span_notice("[user] ищет у [target] в [target.parse_zone_with_bodypart(user.zone_selected, PREPOSITIONAL)]."), span_notice("Вы ищете у [target] в [target.parse_zone_with_bodypart(user.zone_selected, PREPOSITIONAL)]..."))


//ACTUAL SURGERIES

/datum/surgery/augmentation
	name = "Аугментация"
	surgery_flags = SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB | SURGERY_REQUIRES_REAL_LIMB
	possible_locs = list(
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_LEG,
		BODY_ZONE_L_LEG,
		BODY_ZONE_CHEST,
		BODY_ZONE_HEAD,
	)
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract/skin,
		/datum/surgery_step/clamp/vessels,
		/datum/surgery_step/replace_limb,
	)

//SURGERY STEP SUCCESSES

/datum/surgery_step/replace_limb/success(mob/living/user, mob/living/carbon/target, target_zone, obj/item/bodypart/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(target_limb)
		if(istype(tool, /obj/item/borg/apparatus/organ_storage))
			tool.icon_state = initial(tool.icon_state)
			tool.desc = initial(tool.desc)
			tool.cut_overlays()
			tool = tool.contents[1]
		if(istype(tool) && user.temporarilyRemoveItemFromInventory(tool))
			if(!tool.replace_limb(target))
				display_results(
					user,
					target,
					span_warning("Вам не удается аугментировать [target.parse_zone_with_bodypart(target_zone, ACCUSATIVE)] у [target]! Тело отвергает [tool.declent_ru(ACCUSATIVE)]!"),
					span_warning("[user] не удается аугментировать [target.parse_zone_with_bodypart(target_zone, ACCUSATIVE)] у [target]!"),
					span_warning("[user] не удается аугментировать [target.parse_zone_with_bodypart(target_zone, ACCUSATIVE)] у [target]!"),
				)
				tool.forceMove(target.loc)
				return
		if(tool.check_for_frankenstein(target))
			tool.bodypart_flags |= BODYPART_IMPLANTED
		display_results(
			user,
			target,
			span_notice("Вы успешно заменяете [target.parse_zone_with_bodypart(target_zone, ACCUSATIVE)] у [target]."),
			span_notice("[user] успешно заменяет [target.parse_zone_with_bodypart(target_zone, ACCUSATIVE)] у [target] на [tool.declent_ru(ACCUSATIVE)]!"),
			span_notice("[user] успешно заменяет  [target.parse_zone_with_bodypart(target_zone, ACCUSATIVE)] у [target]!"),
		)
		display_pain(target, "Ваша [target.parse_zone_with_bodypart(target_zone, NOMINATIVE)] наполняется синтетическими ощущениями!", mechanical_surgery = TRUE)
		log_combat(user, target, "augmented", addition="by giving him new [target.parse_zone_with_bodypart(target_zone)] COMBAT MODE: [uppertext(user.combat_mode)]")
	else
		to_chat(user, span_warning("У [target] [target.parse_zone_with_bodypart(target_zone, NOMINATIVE)] не из органики!"))
	return ..()
