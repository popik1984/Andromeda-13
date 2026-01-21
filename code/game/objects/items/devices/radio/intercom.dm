/obj/item/radio/intercom
	name = "station intercom"
	desc = "Надёжный станционный интерком, готовый к работе даже когда гарнитуры замолкают."
	icon = 'icons/obj/machines/wallmounts.dmi'
	icon_state = "intercom"
	anchored = TRUE
	w_class = WEIGHT_CLASS_BULKY
	canhear_range = 2
	dog_fashion = null
	unscrewed = FALSE
	item_flags = NO_BLOOD_ON_ITEM

	overlay_speaker_idle = "intercom_s"
	overlay_speaker_active = "intercom_receive"

	overlay_mic_idle = "intercom_m"
	overlay_mic_active = null

	///The icon of intercom while its turned off
	var/icon_off = "intercom-p"

/obj/item/radio/intercom/get_ru_names()
	return alist(
		NOMINATIVE = "станционный интерком",
		GENITIVE = "станционного интеркома",
		DATIVE = "станционному интеркому",
		ACCUSATIVE = "станционный интерком",
		INSTRUMENTAL = "станционным интеркомом",
		PREPOSITIONAL = "станционном интеркоме",
	)

/obj/item/radio/intercom/unscrewed
	unscrewed = TRUE

/obj/item/radio/intercom/prison
	name = "receive-only intercom"
	desc = "Станционный интерком. Выглядит так, будто его модифицировали для запрета вещания."
	icon_state = "intercom_prison"
	icon_off = "intercom_prison-p"

/obj/item/radio/intercom/prison/get_ru_names()
	return alist(
		NOMINATIVE = "интерком (только приём)",
		GENITIVE = "интеркома (только приём)",
		DATIVE = "интеркому (только приём)",
		ACCUSATIVE = "интерком (только приём)",
		INSTRUMENTAL = "интеркомом (только приём)",
		PREPOSITIONAL = "интеркоме (только приём)",
	)

/obj/item/radio/intercom/prison/Initialize(mapload)
	. = ..()
	wires?.cut(WIRE_TX)

/obj/item/radio/intercom/Initialize(mapload)
	. = ..()
	var/area/current_area = get_area(src)
	if(!current_area)
		return
	RegisterSignal(current_area, COMSIG_AREA_POWER_CHANGE, PROC_REF(AreaPowerCheck))
	if(mapload)
		find_and_mount_on_atom()
	GLOB.intercoms_list += src

/obj/item/radio/intercom/Destroy()
	GLOB.intercoms_list -= src
	return ..()

/obj/item/radio/intercom/examine(mob/user)
	. = ..()
	. += span_notice("Используйте [MODE_TOKEN_INTERCOM], находясь рядом, чтобы говорить в него.")
	if(!unscrewed)
		. += span_notice("Он <b>привинчен</b> и закреплён на стене.")
	else
		. += span_notice("Он <i>отвинчен</i> от стены и может быть <b>снят</b>.")

	if(anonymize)
		. += span_notice("Разговор через этот интерком анонимизирует ваш голос.")

	if(freqlock == RADIO_FREQENCY_UNLOCKED)
		if(obj_flags & EMAGGED)
			. += span_warning("Его блокировка частоты закорочена...")
	else
		. += span_notice("Установлена блокировка частоты на [frequency/10].")

/obj/item/radio/intercom/screwdriver_act(mob/living/user, obj/item/tool)
	if(unscrewed)
		user.visible_message(span_notice("[user] начинает затягивать винты [RU_SRC_GEN]..."), span_notice("Вы начинаете завинчивать [RU_SRC_ACC]..."))
		if(tool.use_tool(src, user, 30, volume=50))
			user.visible_message(span_notice("[user] затягивает винты [RU_SRC_GEN]!"), span_notice("Вы затягиваете винты [RU_SRC_GEN]."))
			unscrewed = FALSE
	else
		user.visible_message(span_notice("[user] начинает ослаблять винты [RU_SRC_GEN]..."), span_notice("Вы начинаете отвинчивать [RU_SRC_ACC]..."))
		if(tool.use_tool(src, user, 40, volume=50))
			user.visible_message(span_notice("[user] ослабляет винты [RU_SRC_GEN]!"), span_notice("Вы отвинчиваете [RU_SRC_ACC], ослабляя его крепление к стене."))
			unscrewed = TRUE
	return TRUE

/obj/item/radio/intercom/wrench_act(mob/living/user, obj/item/tool)
	. = TRUE
	if(!unscrewed)
		to_chat(user, span_warning("Сначала нужно отвинтить [RU_SRC_ACC] от стены!"))
		return
	user.visible_message(span_notice("[user] начинает откреплять [RU_SRC_ACC]..."), span_notice("Вы начинаете откреплять [RU_SRC_ACC]..."))
	tool.play_tool_sound(src)
	if(tool.use_tool(src, user, 80))
		user.visible_message(span_notice("[user] открепляет [RU_SRC_ACC]!"), span_notice("Вы снимаете [RU_SRC_ACC] со стены."))
		playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
		deconstruct(TRUE)

/**
 * Override attack_tk_grab instead of attack_tk because we actually want attack_tk's
 * functionality. What we DON'T want is attack_tk_grab attempting to pick up the
 * intercom as if it was an ordinary item.
 */
/obj/item/radio/intercom/attack_tk_grab(mob/user)
	interact(user)
	return COMPONENT_CANCEL_ATTACK_CHAIN


/obj/item/radio/intercom/attack_ai(mob/user)
	interact(user)

/obj/item/radio/intercom/attack_robot(mob/user)
	interact(user)

/obj/item/radio/intercom/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	interact(user)

/obj/item/radio/intercom/ui_state(mob/user)
	return GLOB.default_state

/obj/item/radio/intercom/can_receive(freq, list/levels)
	if(levels != RADIO_NO_Z_LEVEL_RESTRICTION)
		var/turf/position = get_turf(src)
		if(isnull(position) || !(position.z in levels))
			return FALSE

	if(freq == FREQ_SYNDICATE)
		if(!(special_channels &= RADIO_SPECIAL_SYNDIE))
			return FALSE//Prevents broadcast of messages over devices lacking the encryption

	return TRUE

/obj/item/radio/intercom/Hear(atom/movable/speaker, message_langs, raw_message, radio_freq, radio_freq_name, radio_freq_color, list/spans, list/message_mods = list(), message_range)
	if(message_mods[RADIO_EXTENSION] == MODE_INTERCOM)
		return  // Avoid hearing the same thing twice
	return ..()

/obj/item/radio/intercom/emp_act(severity)
	. = ..() // Parent call here will set `on` to FALSE.
	update_appearance()

/obj/item/radio/intercom/end_emp_effect(curremp)
	. = ..()
	AreaPowerCheck() // Make sure the area/local APC is powered first before we actually turn back on.

/obj/item/radio/intercom/emag_act(mob/user, obj/item/card/emag/emag_card)
	. = ..()

	if(obj_flags & EMAGGED)
		return

	switch(freqlock)
		// Emagging an intercom with an emaggable lock will remove the lock
		if(RADIO_FREQENCY_EMAGGABLE_LOCK)
			balloon_alert(user, "блокировка частоты снята")
			playsound(src, SFX_SPARKS, 75, TRUE, SILENCED_SOUND_EXTRARANGE)
			freqlock = RADIO_FREQENCY_UNLOCKED
			obj_flags |= EMAGGED
			return TRUE

		// A fully locked one will do nothing, as locked is intended to be used for stuff that should never be changed
		if(RADIO_FREQENCY_LOCKED)
			balloon_alert(user, "невозможно обойти блокировку частоты!")
			playsound(src, 'sound/machines/buzz/buzz-two.ogg', 50, FALSE, SILENCED_SOUND_EXTRARANGE)
			return

		// Emagging an unlocked one will do nothing, for now
		else
			return

/obj/item/radio/intercom/update_icon_state()
	icon_state = on ? initial(icon_state) : icon_off
	return ..()

/**
 * Proc called whenever the intercom's area loses or gains power. Responsible for setting the `on` variable and calling `update_icon()`.
 *
 * Normally called after the intercom's area receives the `COMSIG_AREA_POWER_CHANGE` signal, but it can also be called directly.
 * Arguments:
 * * source - the area that just had a power change.
 */
/obj/item/radio/intercom/proc/AreaPowerCheck(datum/source)
	SIGNAL_HANDLER
	var/area/current_area = get_area(src)
	if(!current_area)
		set_on(FALSE)
	else
		set_on(current_area.powered(AREA_USAGE_EQUIP)) // set "on" to the equipment power status of our area.
	update_appearance()

/**
 * Called by the wall mount component and reused during the tool deconstruction proc.
 */
/obj/item/radio/intercom/atom_deconstruct(disassembled)
	new/obj/item/wallframe/intercom(get_turf(src))

//Created through the autolathe or through deconstructing intercoms. Can be applied to wall to make a new intercom on it!
/obj/item/wallframe/intercom
	name = "intercom frame"
	desc = "Готовый интерком. Просто прилепи на стену и прикрути!"
	icon = 'icons/obj/machines/wallmounts.dmi'
	icon_state = "intercom"
	result_path = /obj/item/radio/intercom/unscrewed
	pixel_shift = 26
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/wallframe/intercom/get_ru_names()
	return alist(
		NOMINATIVE = "каркас интеркома",
		GENITIVE = "каркаса интеркома",
		DATIVE = "каркасу интеркома",
		ACCUSATIVE = "каркас интеркома",
		INSTRUMENTAL = "каркасом интеркома",
		PREPOSITIONAL = "каркасе интеркома",
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom, 27)

/obj/item/radio/intercom/chapel
	name = "Confessional intercom"
	desc = "Говорите через него... чтобы исповедаться в своих грехах. Скрывает ваш голос, чтобы сохранить их в тайне."
	anonymize = TRUE
	freqlock = RADIO_FREQENCY_EMAGGABLE_LOCK

/obj/item/radio/intercom/chapel/get_ru_names()
	return alist(
		NOMINATIVE = "интерком исповедальни",
		GENITIVE = "интеркома исповедальни",
		DATIVE = "интеркому исповедальни",
		ACCUSATIVE = "интерком исповедальни",
		INSTRUMENTAL = "интеркомом исповедальни",
		PREPOSITIONAL = "интеркоме исповедальни",
	)

/obj/item/radio/intercom/chapel/Initialize(mapload)
	. = ..()
	set_frequency(1481)
	set_broadcasting(TRUE)

/obj/item/radio/intercom/command
	name = "command intercom"
	desc = "Особый интерком командования со свободной частотой. Это универсальный инструмент, который можно настроить на любую частоту, предоставляя доступ к каналам, на которых вас не должно быть. Плюс, он оснащён встроенным усилителем голоса для кристально чистой связи."
	icon_state = "intercom_command"
	freerange = TRUE
	command = TRUE
	icon_off = "intercom_command-p"

/obj/item/radio/intercom/command/get_ru_names()
	return alist(
		NOMINATIVE = "командный интерком",
		GENITIVE = "командного интеркома",
		DATIVE = "командному интеркому",
		ACCUSATIVE = "командный интерком",
		INSTRUMENTAL = "командным интеркомом",
		PREPOSITIONAL = "командном интеркоме",
	)

/obj/item/radio/intercom/syndicate
	name = "syndicate intercom"
	desc = "Поливайте грязью через это."
	command = TRUE
	special_channels = RADIO_SPECIAL_SYNDIE

/obj/item/radio/intercom/syndicate/get_ru_names()
	return alist(
		NOMINATIVE = "интерком Синдиката",
		GENITIVE = "интеркома Синдиката",
		DATIVE = "интеркому Синдиката",
		ACCUSATIVE = "интерком Синдиката",
		INSTRUMENTAL = "интеркомом Синдиката",
		PREPOSITIONAL = "интеркоме Синдиката",
	)

/obj/item/radio/intercom/syndicate/freerange
	name = "syndicate wide-band intercom"
	desc = "Заказной интерком Синдиката, используемый для передачи на всех частотах Nanotrasen. Особенно дорогой."
	freerange = TRUE

/obj/item/radio/intercom/syndicate/freerange/get_ru_names()
	return alist(
		NOMINATIVE = "широкополосный интерком Синдиката",
		GENITIVE = "широкополосного интеркома Синдиката",
		DATIVE = "широкополосному интеркому Синдиката",
		ACCUSATIVE = "широкополосный интерком Синдиката",
		INSTRUMENTAL = "широкополосным интеркомом Синдиката",
		PREPOSITIONAL = "широкополосном интеркоме Синдиката",
	)

/obj/item/radio/intercom/mi13
	name = "intercom"
	desc = "Говорите через него, чтобы связаться с тем, кто находится с вами в этом комплексе."
	freerange = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/prison, 27)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/chapel, 27)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/command, 27)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/syndicate, 27)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/syndicate/freerange, 27)
MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/mi13, 27)
