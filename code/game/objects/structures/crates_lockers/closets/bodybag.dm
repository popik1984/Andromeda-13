/obj/structure/closet/body_bag
	name = "body bag"
	desc = "Пластиковый мешок, предназначенный для хранения и транспортировки трупов."
	gender = MALE
	icon = 'icons/obj/medical/bodybag.dmi'
	icon_state = "bodybag"
	density = FALSE
	mob_storage_capacity = 2
	open_sound = 'sound/items/zip/zip.ogg'
	close_sound = 'sound/items/zip/zip.ogg'
	open_sound_volume = 15
	close_sound_volume = 15
	integrity_failure = 0
	material_drop = /obj/item/stack/sheet/cloth
	delivery_icon = null //unwrappable
	anchorable = FALSE
	cutting_tool = null // Bodybags are not deconstructed by cutting
	drag_slowdown = 0
	has_closed_overlay = FALSE
	can_install_electronics = FALSE
	paint_jobs = null
	can_weld_shut = FALSE
	door_anim_time = 0

	var/foldedbag_path = /obj/item/bodybag
	var/obj/item/bodybag/foldedbag_instance = null
	/// The tagged name of the bodybag, also used to check if the bodybag IS tagged.
	var/tag_name

/obj/structure/closet/body_bag/get_ru_names()
	return alist(
		NOMINATIVE = "мешок для трупов",
		GENITIVE = "мешка для трупов",
		DATIVE = "мешку для трупов",
		ACCUSATIVE = "мешок для трупов",
		INSTRUMENTAL = "мешком для трупов",
		PREPOSITIONAL = "мешке для трупов",
	)

/obj/structure/closet/body_bag/Initialize(mapload)
	. = ..()
	var/static/list/tool_behaviors = list(
		TOOL_WIRECUTTER = list(
			SCREENTIP_CONTEXT_RMB = "Снять бирку",
		),
	)
	AddElement(/datum/element/contextual_screentip_tools, tool_behaviors)
	AddElement( \
		/datum/element/contextual_screentip_bare_hands, \
		rmb_text = "Свернуть", \
	)
	AddElement(/datum/element/contextual_screentip_sharpness, lmb_text = "Снять бирку")
	obj_flags |= UNIQUE_RENAME | RENAME_NO_DESC

/obj/structure/closet/body_bag/Destroy()
	// If we have a stored bag, and it's is in nullspace (not in someone's hand), delete it.
	if (foldedbag_instance && !foldedbag_instance.loc)
		QDEL_NULL(foldedbag_instance)
	return ..()

/obj/structure/closet/body_bag/attackby(obj/item/interact_tool, mob/user, list/modifiers, list/attack_modifiers)
	if(interact_tool.tool_behaviour == TOOL_WIRECUTTER || interact_tool.get_sharpness())
		to_chat(user, span_notice("Вы срезаете бирку с [RU_SRC_GEN]."))
		playsound(src, SFX_WRITING_PEN, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE, SOUND_FALLOFF_EXPONENT + 3, ignore_walls = FALSE)
		tag_name = null
		update_appearance()
		qdel(src.GetComponent(/datum/component/rename))

/obj/structure/closet/body_bag/nameformat(input, user)
	playsound(src, SFX_WRITING_PEN, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE, SOUND_FALLOFF_EXPONENT + 3, ignore_walls = FALSE)
	tag_name = input
	update_icon()
	return tag_name ? "[initial(name)] - [tag_name]" : initial(name)

/obj/structure/closet/body_bag/rename_reset()
	tag_name = null
	update_icon()

/obj/structure/closet/body_bag/update_overlays()
	. = ..()
	if(tag_name)
		. += "bodybag_label"

/obj/structure/closet/body_bag/after_close(mob/living/user)
	. = ..()
	set_density(FALSE)

/obj/structure/closet/body_bag/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(!attempt_fold(user))
		return SECONDARY_ATTACK_CONTINUE_CHAIN
	perform_fold(user)
	qdel(src)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

		/**
		  * Checks to see if we can fold. Return TRUE to actually perform the fold and delete.
			*
		  * Arguments:
		  * * the_folder - aka user
		  */
/obj/structure/closet/body_bag/proc/attempt_fold(mob/living/carbon/human/the_folder)
	. = FALSE
	if(!istype(the_folder))
		return
	if(opened)
		to_chat(the_folder, span_warning("Вы возитесь с [RU_SRC_GEN], но его не свернуть, пока он расстёгнут."))
		return
	for(var/content_thing in contents)
		if(istype(content_thing, /mob) || isobj(content_thing))
			to_chat(the_folder, span_warning("Внутри [RU_SRC_GEN] слишком много вещей, чтобы свернуть его!"))
			return
	// toto we made it!
	return TRUE

	/**
		* Performs the actual folding. Deleting is automatic, please do not include.
		*
		* Arguments:
		* * the_folder - aka user
		*/
/obj/structure/closet/body_bag/proc/perform_fold(mob/living/carbon/human/the_folder)
	visible_message(span_notice("[the_folder] сворачивает [RU_SRC_NOM]."))
	the_folder.put_in_hands(undeploy_bodybag(the_folder.loc))

/// Makes the bag into an item, returns that item
/obj/structure/closet/body_bag/proc/undeploy_bodybag(atom/fold_loc)
	var/obj/item/bodybag/folding_bodybag = foldedbag_instance || new foldedbag_path()
	if(fold_loc)
		folding_bodybag.forceMove(fold_loc)
	return folding_bodybag

/obj/structure/closet/body_bag/container_resist_act(mob/living/user, loc_required = TRUE)
	// ideally we support this natively but i guess that's for a later time
	if(!istype(loc, /obj/machinery/disposal))
		return ..()
	for(var/atom/movable/thing as anything in src)
		thing.forceMove(loc)
	undeploy_bodybag(loc)

/obj/structure/closet/body_bag/bluespace
	name = "bluespace body bag"
	desc = "Блюспейс мешок, предназначенный для хранения и транспортировки трупов."
	icon = 'icons/obj/medical/bodybag.dmi'
	icon_state = "bluebodybag"
	foldedbag_path = /obj/item/bodybag/bluespace
	mob_storage_capacity = 15
	max_mob_size = MOB_SIZE_LARGE

/obj/structure/closet/body_bag/bluespace/get_ru_names()
	return alist(
		NOMINATIVE = "блюспейс мешок для трупов",
		GENITIVE = "блюспейс мешка для трупов",
		DATIVE = "блюспейс мешку для трупов",
		ACCUSATIVE = "блюспейс мешок для трупов",
		INSTRUMENTAL = "блюспейс мешком для трупов",
		PREPOSITIONAL = "блюспейс мешке для трупов",
	)

/obj/structure/closet/body_bag/bluespace/attempt_fold(mob/living/carbon/human/the_folder)
	. = FALSE
	//copypaste zone, we do not want the content check so we don't want inheritance
	if(!istype(the_folder))
		return
	if(opened)
		to_chat(the_folder, span_warning("Вы возитесь с [RU_SRC_INS], но его не свернуть, пока он расстёгнут."))
		return
	//end copypaste zone
	if(contents.len >= mob_storage_capacity / 2)
		to_chat(the_folder, span_warning("Внутри [RU_SRC_GEN] слишком много вещей, чтобы свернуть его!"))
		return

	if(the_folder.in_contents_of(src))
		to_chat(the_folder, span_warning("Вы не можете свернуть [RU_SRC_NOM], пока находитесь внутри!"))
		return

	for(var/obj/item/bodybag/bluespace/B in src)
		to_chat(the_folder, span_warning("Вы не можете рекурсивно сворачивать блюспейс мешки для трупов!") )
		return
	return TRUE

/obj/structure/closet/body_bag/bluespace/perform_fold(mob/living/carbon/human/the_folder)
	visible_message(span_notice("[the_folder] сворачивает [RU_SRC_NOM]."))
	var/obj/item/bodybag/folding_bodybag = undeploy_bodybag(the_folder.loc)
	var/max_weight_of_contents = initial(folding_bodybag.w_class)
	for(var/am in contents)
		var/atom/movable/content = am
		content.forceMove(folding_bodybag)
		if(isliving(content))
			to_chat(content, span_userdanger("Вас внезапно запихнуло в крошечное, сжатое пространство!"))
		if(iscarbon(content))
			var/mob/living/carbon/mob = content
			if (mob.dna?.get_mutation(/datum/mutation/dwarfism))
				max_weight_of_contents = max(WEIGHT_CLASS_NORMAL, max_weight_of_contents)
				continue
		if(!isitem(content))
			max_weight_of_contents = max(WEIGHT_CLASS_BULKY, max_weight_of_contents)
			continue
		var/obj/item/A_is_item = content
		if(A_is_item.w_class < max_weight_of_contents)
			continue
		max_weight_of_contents = A_is_item.w_class
	folding_bodybag.update_weight_class(max_weight_of_contents)
	the_folder.put_in_hands(folding_bodybag)

/// Environmental bags. They protect against bad weather.

/obj/structure/closet/body_bag/environmental
	name = "environmental protection bag"
	desc = "Изолированный, усиленный мешок, предназначенный для защиты от экзопланетных штормов и других факторов окружающей среды."
	icon = 'icons/obj/medical/bodybag.dmi'
	icon_state = "envirobag"
	mob_storage_capacity = 1
	contents_pressure_protection = 0.8
	contents_thermal_insulation = 0.5
	foldedbag_path = /obj/item/bodybag/environmental
	/// The list of weathers we protect from.
	var/list/weather_protection = list(TRAIT_ASHSTORM_IMMUNE, TRAIT_RADSTORM_IMMUNE, TRAIT_SNOWSTORM_IMMUNE) // Does not protect against lava or the The Floor Is Lava spell.
	/// The contents of the gas to be distributed to an occupant. Set in Initialize()
	var/datum/gas_mixture/air_contents = null

/obj/structure/closet/body_bag/environmental/get_ru_names()
	return alist(
		NOMINATIVE = "защитный мешок",
		GENITIVE = "защитного мешка",
		DATIVE = "защитному мешку",
		ACCUSATIVE = "защитный мешок",
		INSTRUMENTAL = "защитным мешком",
		PREPOSITIONAL = "защитном мешке",
	)

/obj/structure/closet/body_bag/environmental/Initialize(mapload)
	. = ..()
	add_traits(weather_protection, INNATE_TRAIT)
	refresh_air()

/obj/structure/closet/body_bag/environmental/Destroy()
	if(air_contents)
		QDEL_NULL(air_contents)
	return ..()

/obj/structure/closet/body_bag/environmental/return_air()
	refresh_air()
	return air_contents

/obj/structure/closet/body_bag/environmental/remove_air(amount)
	refresh_air()
	return air_contents.remove(amount)

/obj/structure/closet/body_bag/environmental/return_analyzable_air()
	refresh_air()
	return air_contents

/obj/structure/closet/body_bag/environmental/togglelock(mob/living/user, silent)
	. = ..()
	for(var/mob/living/target in contents)
		to_chat(target, span_warning("Вы слышите слабое шипение, и белый туман заполняет ваш обзор..."))

/obj/structure/closet/body_bag/environmental/proc/refresh_air()
	air_contents = null
	air_contents = new(50) //liters
	air_contents.temperature = T20C

	air_contents.assert_gases(/datum/gas/oxygen, /datum/gas/nitrogen)
	air_contents.gases[/datum/gas/oxygen][MOLES] = (ONE_ATMOSPHERE*50)/(R_IDEAL_GAS_EQUATION*T20C) * O2STANDARD
	air_contents.gases[/datum/gas/nitrogen][MOLES] = (ONE_ATMOSPHERE*50)/(R_IDEAL_GAS_EQUATION*T20C) * N2STANDARD

/obj/structure/closet/body_bag/environmental/nanotrasen
	name = "elite environmental protection bag"
	desc = "Тяжело укреплённый и изолированный мешок, способный полностью изолировать своё содержимое от внешних факторов."
	icon = 'icons/obj/medical/bodybag.dmi'
	icon_state = "ntenvirobag"
	contents_pressure_protection = 1
	contents_thermal_insulation = 1
	foldedbag_path = /obj/item/bodybag/environmental/nanotrasen
	weather_protection = list(TRAIT_WEATHER_IMMUNE)

/obj/structure/closet/body_bag/environmental/nanotrasen/get_ru_names()
	return alist(
		NOMINATIVE = "элитный защитный мешок",
		GENITIVE = "элитного защитного мешка",
		DATIVE = "элитному защитному мешку",
		ACCUSATIVE = "элитный защитный мешок",
		INSTRUMENTAL = "элитным защитным мешком",
		PREPOSITIONAL = "элитном защитном мешке",
	)

/// Securable enviro. bags

/obj/structure/closet/body_bag/environmental/prisoner
	name = "prisoner transport bag"
	desc = "Предназначен для транспортировки заключённых через опасные среды, этот защитный мешок оснащён ремнями для фиксации пассажира."
	icon = 'icons/obj/medical/bodybag.dmi'
	icon_state = "prisonerenvirobag"
	foldedbag_path = /obj/item/bodybag/environmental/prisoner
	breakout_time = 4 MINUTES // because it's probably about as hard to get out of this as it is to get out of a straightjacket.
	/// How long it takes to sinch the bag.
	var/sinch_time = 10 SECONDS
	/// Whether or not the bag is sinched. Starts unsinched.
	var/sinched = FALSE
	/// The sound that plays when the bag is done sinching.
	var/sinch_sound = 'sound/items/equip/toolbelt_equip.ogg'

/obj/structure/closet/body_bag/environmental/prisoner/get_ru_names()
	return alist(
		NOMINATIVE = "мешок для транспортировки заключённых",
		GENITIVE = "мешка для транспортировки заключённых",
		DATIVE = "мешку для транспортировки заключённых",
		ACCUSATIVE = "мешок для транспортировки заключённых",
		INSTRUMENTAL = "мешком для транспортировки заключённых",
		PREPOSITIONAL = "мешке для транспортировки заключённых",
	)

/obj/structure/closet/body_bag/environmental/prisoner/attempt_fold(mob/living/carbon/human/the_folder)
	if(sinched)
		to_chat(the_folder, span_warning("Вы возитесь с [RU_SRC_INS], но его не свернуть, пока его ремни затянуты."))
		return FALSE
	return ..()

/obj/structure/closet/body_bag/environmental/prisoner/before_open(mob/living/user, force)
	. = ..()
	if(!.)
		return FALSE

	if(sinched && !force)
		to_chat(user, span_danger("Пряжки на [RU_SRC_PRE] затянуты, не давая ему открыться."))
		return FALSE

	sinched = FALSE //in case it was forced open unsinch it
	return TRUE

/obj/structure/closet/body_bag/environmental/prisoner/update_icon()
	. = ..()
	if(sinched)
		icon_state = initial(icon_state) + "_sinched"
	else
		icon_state = initial(icon_state)

/obj/structure/closet/body_bag/environmental/prisoner/container_resist_act(mob/living/user, loc_required = TRUE)
	// copy-pasted with changes because flavor text as well as some other misc stuff
	if(opened || ismovable(loc) || !sinched)
		return ..()

	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	user.visible_message(span_warning("Кто-то в [RU_SRC_PRE] начинает извиваться!"), \
		span_notice("Вы начинаете извиваться, пытаясь ослабить пряжки [RU_SRC_GEN]... (это займёт около [DisplayTimeText(breakout_time)].)"), \
		span_hear("Вы слышите натяжение ткани из [RU_SRC_GEN]."))
	if(do_after(user,(breakout_time), target = src))
		if(!user || user.stat != CONSCIOUS || user.loc != src || opened || !sinched )
			return
		//we check after a while whether there is a point of resisting anymore and whether the user is capable of resisting
		user.visible_message(span_danger("[user] успешно вырывается из [RU_SRC_GEN]!"),
							span_notice("Вы успешно вырвались из [RU_SRC_GEN]!"))
		if(istype(loc, /obj/machinery/disposal))
			return ..()
		bust_open()
	else
		if(user.loc == src) //so we don't get the message if we resisted multiple times and succeeded.
			to_chat(user, span_warning("Вам не удалось выбраться из [RU_SRC_GEN]!"))


/obj/structure/closet/body_bag/environmental/prisoner/bust_open()
	sinched = FALSE
	// We don't break the bag, because the buckles were backed out as opposed to fully broken.
	open()

/obj/structure/closet/body_bag/environmental/prisoner/attack_hand_secondary(mob/user, modifiers)
	if(!user.can_perform_action(src) || !isturf(loc))
		return
	togglelock(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/structure/closet/body_bag/environmental/prisoner/togglelock(mob/living/user, silent)
	if(opened)
		to_chat(user, span_warning("Вы не можете закрыть пряжки, пока [RU_SRC_NOM] расстёгнут!"))
		return
	if(user in contents)
		to_chat(user, span_warning("Вы не можете дотянуться до пряжек отсюда!"))
		return
	if(iscarbon(user))
		add_fingerprint(user)
	if(!sinched)
		for(var/mob/living/target in contents)
			to_chat(target, span_userdanger("Вы чувствуете, как подкладка [RU_SRC_GEN] затягивается вокруг вас! Скоро вы не сможете сбежать!"))
		user.visible_message(span_notice("[user] начинает затягивать пряжки на [RU_SRC_PRE]."))
		if(!(do_after(user,(sinch_time),target = src)))
			return
	sinched = !sinched
	if(sinched)
		playsound(loc, sinch_sound, 15, TRUE, -2)
	user.visible_message(span_notice("[user] [sinched ? "затягивает" : "ослабляет"] [RU_SRC_NOM]."),
							span_notice("Вы [sinched ? "затягиваете" : "ослабляете"] [RU_SRC_NOM]."),
							span_hear("Вы слышите растяжение, за которым следуют металлические щелчки от [RU_SRC_GEN]."))
	user.log_message("[sinched ? "sinched":"unsinched"] secure environmental bag [src]", LOG_GAME)
	update_appearance()

/obj/structure/closet/body_bag/environmental/prisoner/syndicate
	name = "syndicate prisoner transport bag"
	desc = "Модификация защитного мешка NanoTrasen, использовавшаяся в нескольких громких похищениях. Разработан для удержания жертвы без сознания, живой и надёжно зафиксированной во время транспортировки."
	icon = 'icons/obj/medical/bodybag.dmi'
	icon_state = "syndieenvirobag"
	contents_pressure_protection = 1
	contents_thermal_insulation = 1
	foldedbag_path = /obj/item/bodybag/environmental/prisoner/syndicate
	weather_protection = list(TRAIT_WEATHER_IMMUNE)
	breakout_time = 8 MINUTES
	sinch_time = 20 SECONDS

/obj/structure/closet/body_bag/environmental/prisoner/syndicate/get_ru_names()
	return alist(
		NOMINATIVE = "мешок для транспортировки заключённых Синдиката",
		GENITIVE = "мешка для транспортировки заключённых Синдиката",
		DATIVE = "мешку для транспортировки заключённых Синдиката",
		ACCUSATIVE = "мешок для транспортировки заключённых Синдиката",
		INSTRUMENTAL = "мешком для транспортировки заключённых Синдиката",
		PREPOSITIONAL = "мешке для транспортировки заключённых Синдиката",
	)

/obj/structure/closet/body_bag/environmental/prisoner/pressurized/syndicate/refresh_air()
	air_contents = null
	air_contents = new(50) //liters
	air_contents.temperature = T20C

	air_contents.assert_gases(/datum/gas/oxygen, /datum/gas/nitrous_oxide)
	air_contents.gases[/datum/gas/oxygen][MOLES] = (ONE_ATMOSPHERE*50)/(R_IDEAL_GAS_EQUATION*T20C) * O2STANDARD
	air_contents.gases[/datum/gas/nitrous_oxide][MOLES] = (ONE_ATMOSPHERE*50)/(R_IDEAL_GAS_EQUATION*T20C) * N2STANDARD

/obj/structure/closet/body_bag/environmental/hardlight
	name = "hardlight bodybag"
	desc = "Голографический мешок для хранения тел. Устойчив к космосу."
	icon_state = "holobag_med"
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	foldedbag_path = null
	weather_protection = list(TRAIT_SNOWSTORM_IMMUNE)

/obj/structure/closet/body_bag/environmental/hardlight/get_ru_names()
	return alist(
		NOMINATIVE = "голографический мешок для трупов",
		GENITIVE = "голографического мешка для трупов",
		DATIVE = "голографическому мешку для трупов",
		ACCUSATIVE = "голографический мешок для трупов",
		INSTRUMENTAL = "голографическим мешком для трупов",
		PREPOSITIONAL = "голографическом мешке для трупов",
	)

/obj/structure/closet/body_bag/environmental/hardlight/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	if(damage_type in list(BRUTE, BURN))
		playsound(src, 'sound/items/weapons/egloves.ogg', 80, TRUE)

/obj/structure/closet/body_bag/environmental/prisoner/hardlight
	name = "hardlight prisoner bodybag"
	desc = "Голографический мешок для хранения тел. Устойчив к космосу, может быть затянут для предотвращения побега."
	icon_state = "holobag_sec"
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	foldedbag_path = null
	weather_protection = list(TRAIT_SNOWSTORM_IMMUNE)

/obj/structure/closet/body_bag/environmental/prisoner/hardlight/get_ru_names()
	return alist(
		NOMINATIVE = "голографический мешок для заключённых",
		GENITIVE = "голографического мешка для заключённых",
		DATIVE = "голографическому мешку для заключённых",
		ACCUSATIVE = "голографический мешок для заключённых",
		INSTRUMENTAL = "голографическим мешком для заключённых",
		PREPOSITIONAL = "голографическом мешке для заключённых",
	)

/obj/structure/closet/body_bag/environmental/prisoner/hardlight/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	if(damage_type in list(BRUTE, BURN))
		playsound(src, 'sound/items/weapons/egloves.ogg', 80, TRUE)
