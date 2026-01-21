/obj/item/crowbar
	name = "pocket crowbar"
	desc = "Небольшая монтировка. Этот удобный инструмент полезен для многих вещей, таких как поддевание напольной плитки или открытие обесточенных дверей."
	icon = 'icons/obj/tools.dmi'
	icon_state = "crowbar"
	inhand_icon_state = "crowbar"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	usesound = 'sound/items/tools/crowbar.ogg'
	operating_sound = 'sound/items/tools/crowbar_prying.ogg'
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BELT
	force = 5
	throwforce = 7
	demolition_mod = 1.25
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.5)
	drop_sound = 'sound/items/handling/tools/crowbar_drop.ogg'
	pickup_sound = 'sound/items/handling/tools/crowbar_pickup.ogg'

	attack_verb_continuous = list("атакует", "бьёт", "колотит", "дубасит", "ударяет")
	attack_verb_simple = list("атаковать", "ударить", "поколотить", "отдубасить", "ударить")
	tool_behaviour = TOOL_CROWBAR
	toolspeed = 1
	armor_type = /datum/armor/item_crowbar
	var/force_opens = FALSE

/datum/armor/item_crowbar
	fire = 50
	acid = 30

/obj/item/crowbar/get_ru_names()
	return alist(
		NOMINATIVE = "карманная монтировка",
		GENITIVE = "карманной монтировки",
		DATIVE = "карманной монтировке",
		ACCUSATIVE = "карманную монтировку",
		INSTRUMENTAL = "карманной монтировкой",
		PREPOSITIONAL = "карманной монтировке",
	)

/obj/item/crowbar/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/falling_hazard, damage = force, wound_bonus = wound_bonus, hardhat_safety = TRUE, crushes = FALSE, impact_sound = hitsound)

/obj/item/crowbar/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] забивает себя до смерти [RU_SRC_INS]! Похоже, [user.p_theyre()] пытается совершить суицид!"))
	playsound(loc, 'sound/items/weapons/genhit.ogg', 50, TRUE, -1)
	return BRUTELOSS

/obj/item/crowbar/red
	icon_state = "crowbar_red"
	inhand_icon_state = "crowbar_red"
	force = 8

/obj/item/crowbar/abductor
	name = "alien crowbar"
	desc = "Монтировка из твёрдого света. Кажется, она поддевает предметы сама по себе, не требуя никаких усилий."
	icon = 'icons/obj/antags/abductor.dmi'
	usesound = 'sound/items/weapons/sonic_jackhammer.ogg'
	custom_materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = SHEET_MATERIAL_AMOUNT*1.25, /datum/material/plasma =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/titanium =SHEET_MATERIAL_AMOUNT, /datum/material/diamond =SHEET_MATERIAL_AMOUNT)
	icon_state = "crowbar"
	inside_belt_icon_state = "crowbar_alien"
	toolspeed = 0.1

/obj/item/crowbar/abductor/get_ru_names()
	return alist(
		NOMINATIVE = "инопланетная монтировка",
		GENITIVE = "инопланетной монтировки",
		DATIVE = "инопланетной монтировке",
		ACCUSATIVE = "инопланетную монтировку",
		INSTRUMENTAL = "инопланетной монтировкой",
		PREPOSITIONAL = "инопланетной монтировке",
	)

/obj/item/crowbar/large
	name = "large crowbar"
	desc = "Это большой лом. Он не влезает в карманы, потому что большой."
	force = 12
	w_class = WEIGHT_CLASS_NORMAL
	throw_speed = 3
	throw_range = 3
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.7)
	icon_state = "crowbar_large"
	worn_icon_state = "crowbar"
	toolspeed = 0.7

/obj/item/crowbar/large/get_ru_names()
	return alist(
		NOMINATIVE = "большой лом",
		GENITIVE = "большого лома",
		DATIVE = "большому лому",
		ACCUSATIVE = "большой лом",
		INSTRUMENTAL = "большим ломом",
		PREPOSITIONAL = "большом ломе",
	)

/obj/item/crowbar/large/emergency
	name = "emergency crowbar"
	desc = "Громоздкий лом. Кажется, он намеренно создан так, чтобы не влезать в рюкзак."
	w_class = WEIGHT_CLASS_BULKY

/obj/item/crowbar/large/emergency/get_ru_names()
	return alist(
		NOMINATIVE = "аварийный лом",
		GENITIVE = "аварийного лома",
		DATIVE = "аварийному лому",
		ACCUSATIVE = "аварийный лом",
		INSTRUMENTAL = "аварийным ломом",
		PREPOSITIONAL = "аварийном ломе",
	)

/obj/item/crowbar/hammer
	name = "claw hammer"
	desc = "Тяжёлый молоток с гвоздодёром на обратной стороне. Гвозди в космосе не часто встречаются, но этот инструмент всё равно можно использовать как оружие или лом."
	force = 11
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'icons/obj/weapons/hammer.dmi'
	icon_state = "clawhammer"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/hammers_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/hammers_righthand.dmi'
	inhand_icon_state = "clawhammer"
	inside_belt_icon_state = "clawhammer"
	throwforce = 10
	throw_range = 5
	throw_speed = 3
	toolspeed = 2
	custom_materials = list(/datum/material/wood=SMALL_MATERIAL_AMOUNT*0.5, /datum/material/iron=SMALL_MATERIAL_AMOUNT*0.7)
	wound_bonus = 35

/obj/item/crowbar/hammer/get_ru_names()
	return alist(
		NOMINATIVE = "молоток-гвоздодёр",
		GENITIVE = "молотка-гвоздодёра",
		DATIVE = "молотку-гвоздодёру",
		ACCUSATIVE = "молоток-гвоздодёр",
		INSTRUMENTAL = "молотком-гвоздодёром",
		PREPOSITIONAL = "молотке-гвоздодёре",
	)

/obj/item/crowbar/hammer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/kneejerk)

/obj/item/crowbar/large/twenty_force //from space ruin
	name = "heavy crowbar"
	desc = "Это большой лом. Он не влезает в карманы, потому что большой. Ощущается странно тяжёлым."
	force = 20
	icon_state = "crowbar_powergame"
	inhand_icon_state = "crowbar_red"

/obj/item/crowbar/large/twenty_force/get_ru_names()
	return alist(
		NOMINATIVE = "тяжёлый лом",
		GENITIVE = "тяжёлого лома",
		DATIVE = "тяжёлому лому",
		ACCUSATIVE = "тяжёлый лом",
		INSTRUMENTAL = "тяжёлым ломом",
		PREPOSITIONAL = "тяжёлом ломе",
	)

/obj/item/crowbar/large/old
	name = "old crowbar"
	desc = "Это старый лом. Намного больше карманных версий и гораздо увесистее. Такие больше не делают."
	throwforce = 10
	throw_speed = 2

/obj/item/crowbar/large/old/get_ru_names()
	return alist(
		NOMINATIVE = "старый лом",
		GENITIVE = "старого лома",
		DATIVE = "старому лому",
		ACCUSATIVE = "старый лом",
		INSTRUMENTAL = "старым ломом",
		PREPOSITIONAL = "старом ломе",
	)

/obj/item/crowbar/large/old/Initialize(mapload)
	. = ..()
	if(prob(50))
		icon_state = "crowbar_powergame"

/obj/item/crowbar/power
	name = "jaws of life"
	desc = "Комплект челюстей жизни, сжатый магией науки."
	icon_state = "jaws"
	inhand_icon_state = "jawsoflife"
	worn_icon_state = "jawsoflife"
	icon_angle = 180
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*2.25, /datum/material/silver = SHEET_MATERIAL_AMOUNT*1.25, /datum/material/titanium = SHEET_MATERIAL_AMOUNT*1.75)
	usesound = 'sound/items/tools/jaws_pry.ogg'
	hitsound = SFX_SWING_HIT
	force = 15
	w_class = WEIGHT_CLASS_NORMAL
	toolspeed = 0.7
	force_opens = TRUE
	/// Used on Initialize, how much time to cut cable restraints and zipties.
	var/snap_time_weak_handcuffs = 0 SECONDS
	/// Used on Initialize, how much time to cut real handcuffs. Null means it can't.
	var/snap_time_strong_handcuffs = 0 SECONDS
	/// The text used for our jaws tool description while active
	var/active_text = "резак"
	/// The text used for our jaws tool description while inactive
	var/inactive_text = "лом"
	/// The default tool behavior. This should match tool_behavior
	var/first_tool_behavior = TOOL_CROWBAR
	/// The active tool behavior. This should not match tool_behavior on init.
	var/second_tool_behavior = TOOL_WIRECUTTER
	/// Determines if we want to limit our jaws of life from opening certain doors or not.
	var/limit_jaws_access = FALSE
	/// The access on doors that block our jaws of life from opening if limit_jaws_access is TRUE. Does nothing if FALSE.
	var/list/blacklisted_access = list()
	/// Whether or not our jaws throw out an alert when we pry open a door. Default alert sends out a message to security comms.
	var/radio_alert = FALSE
	/// If radio_alert is TRUE, access in this list that is found on our pried open door is ignored.
	var/list/ignored_access = list(
		ACCESS_MAINT_TUNNELS,
		ACCESS_AUX_BASE,
		ACCESS_EXTERNAL_AIRLOCKS,
	)
	COOLDOWN_DECLARE(alert_cooldown)
	/// How long between announcements from our jaws of life. Keeps the jaws from getting too radio spammy.
	var/alert_cooldown_time = 1 MINUTES

/obj/item/crowbar/power/get_ru_names()
	return alist(
		NOMINATIVE = "челюсти жизни",
		GENITIVE = "челюстей жизни",
		DATIVE = "челюстям жизни",
		ACCUSATIVE = "челюсти жизни",
		INSTRUMENTAL = "челюстями жизни",
		PREPOSITIONAL = "челюстях жизни",
	)

/obj/item/crowbar/power/get_all_tool_behaviours()
	return list(first_tool_behavior, second_tool_behavior)

/obj/item/crowbar/power/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/transforming, \
		force_on = force, \
		throwforce_on = throwforce, \
		hitsound_on = hitsound, \
		w_class_on = w_class, \
		clumsy_check = FALSE, \
		inhand_icon_change = FALSE, \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))
	RegisterSignal(src, COMSIG_TOOL_FORCE_OPEN_AIRLOCK, PROC_REF(on_force_open))

/obj/item/crowbar/power/examine()
	. = ..()
	. += "Оснащены насадкой типа [tool_behaviour == first_tool_behavior ? inactive_text : active_text]."

/*
 * Signal proc for [COMSIG_TRANSFORMING_ON_TRANSFORM].
 *
 * Toggles between crowbar and wirecutters and gives feedback to the user.
 */
/obj/item/crowbar/power/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	tool_behaviour = (active ? second_tool_behavior : first_tool_behavior)
	if(user)
		balloon_alert(user, "насадка: [tool_behaviour == first_tool_behavior ? inactive_text : active_text]")
	playsound(src, 'sound/items/tools/change_jaws.ogg', 50, TRUE)
	if(tool_behaviour != TOOL_WIRECUTTER)
		RemoveElement(/datum/element/cuffsnapping, snap_time_weak_handcuffs, snap_time_strong_handcuffs)
	else
		AddElement(/datum/element/cuffsnapping, snap_time_weak_handcuffs, snap_time_strong_handcuffs)
	return COMPONENT_NO_DEFAULT_MESSAGE

/*
 * Signal proc for [COMSIG_TOOL_FORCE_OPEN_AIRLOCK].
 *
 * Determines if our jaws of life is restricted from opening some doors, and whether or not we need to alert over the radio whenever they are used to
 * pry open a door. Useful if you want to restrict jaws of life in some fashion.
 */

/obj/item/crowbar/power/proc/on_force_open(obj/item/source, mob/user, obj/machinery/door/airlock/target)
	SIGNAL_HANDLER

	var/list/collective_access = list()
	collective_access += target.req_access
	collective_access += target.req_one_access

	if(limit_jaws_access)
		for(var/possible_blacklisted_access in collective_access)
			if(possible_blacklisted_access in blacklisted_access)
				playsound(src.loc, 'sound/machines/buzz/buzz-sigh.ogg', 50, FALSE)
				user.balloon_alert(user, "не получается поддеть!")
				return COMPONENT_TOOL_DO_NOT_ALLOW_FORCE_OPEN

	if(radio_alert && COOLDOWN_FINISHED(src, alert_cooldown))

		if(!collective_access) //Return if the door has literally no access at all
			return COMPONENT_TOOL_ALLOW_FORCE_OPEN

		for(var/possible_public_access in collective_access) //Return if the door has otherwise unimportant access
			if((possible_public_access in ignored_access))
				return COMPONENT_TOOL_ALLOW_FORCE_OPEN

		sound_the_alarms(user, target)
		COOLDOWN_START(src, alert_cooldown, alert_cooldown_time)
	return COMPONENT_TOOL_ALLOW_FORCE_OPEN

///Our alert for our jaws of life.
/obj/item/crowbar/power/proc/sound_the_alarms(mob/user, obj/machinery/door/airlock/target)
		aas_config_announce(/datum/aas_config_entry/jaws_entry_alert, list(
			"PERSON" = user.name,
			"LOCATION" = get_area_name(target),
			"TOOL" = name), src, list(RADIO_CHANNEL_SECURITY), RADIO_CHANNEL_SECURITY)

/datum/aas_config_entry/jaws_entry_alert
	// This tool screams into the radio whenever the user successfully pries open an airlock.
	name = "Door Forced Entry Alert"
	announcement_lines_map = list(
		RADIO_CHANNEL_SECURITY = "ТРЕВОГА СБ: %PERSON взламывает дверь в %LOCATION, используя %TOOL. Подтвердите, что это было сделано во время чрезвычайной ситуации уполномоченным персоналом.",
	)
	vars_and_tooltips_map = list(
		"PERSON" = "will be replaced with the name of the user",
		"LOCATION" = "with the area of the door",
		"TOOL" = "replaced with the tool used",
	)

/obj/item/crowbar/power/suicide_act(mob/living/user)
	if(tool_behaviour == TOOL_CROWBAR)
		user.visible_message(span_suicide("[user] засовывает свою голову в [RU_SRC_ACC], похоже, [user.p_theyre()] пытается совершить суицид!"))
		playsound(loc, 'sound/items/tools/jaws_pry.ogg', 50, TRUE, -1)
	else
		user.visible_message(span_suicide("[user] оборачивает [RU_SRC_ACC] вокруг своей шеи. Похоже, [user.p_theyre()] пытается оторвать себе голову!"))
		playsound(loc, 'sound/items/tools/jaws_cut.ogg', 50, TRUE, -1)
		if(iscarbon(user))
			var/mob/living/carbon/suicide_victim = user
			var/obj/item/bodypart/target_bodypart = suicide_victim.get_bodypart(BODY_ZONE_HEAD)
			if(target_bodypart)
				target_bodypart.drop_limb()
				playsound(loc, SFX_DESECRATION, 50, TRUE, -1)
	return BRUTELOSS

/obj/item/crowbar/power/syndicate
	name = "jaws of death"
	desc = "Улучшенная, более быстрая и компактная копия стандартных челюстей жизни Nanotrasen. Может использоваться для принудительного открытия шлюзов в конфигурации лома."
	icon_state = "jaws_syndie"
	w_class = WEIGHT_CLASS_SMALL
	toolspeed = 0.5

/obj/item/crowbar/power/syndicate/get_ru_names()
	return alist(
		NOMINATIVE = "челюсти смерти",
		GENITIVE = "челюстей смерти",
		DATIVE = "челюстям смерти",
		ACCUSATIVE = "челюсти смерти",
		INSTRUMENTAL = "челюстями смерти",
		PREPOSITIONAL = "челюстях смерти",
	)

/obj/item/crowbar/power/paramedic
	name = "jaws of recovery"
	desc = "Специализированная версия челюстей жизни, предназначенная в первую очередь для парамедиков, чтобы извлекать раненых и недавно умерших. Вместо резака этот инструмент оснащён аппаратом для вправления костей. Не может получить доступ к некоторым зонам высокой безопасности из соображений безопасности."
	icon_state = "jaws_paramedic"
	inhand_icon_state = "jawsparamedic"
	worn_icon_state = "jawsparamedic"
	w_class = WEIGHT_CLASS_BULKY
	toolspeed = 1
	slot_flags = null
	active_text = "костоправ"
	second_tool_behavior = TOOL_BONESET
	limit_jaws_access = TRUE
	blacklisted_access = list(
		ACCESS_COMMAND,
		ACCESS_AI_UPLOAD,
		ACCESS_CAPTAIN,
		ACCESS_HOP,
		ACCESS_SECURITY,
		ACCESS_BRIG,
		ACCESS_ARMORY,
		ACCESS_HOS,
		ACCESS_DETECTIVE,
		ACCESS_CE,
		ACCESS_CMO,
		ACCESS_QM,
		ACCESS_VAULT,
		ACCESS_RD,
		ACCESS_SYNDICATE,
	)
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4.75,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2.50,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 1.75,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.25,
	)
	radio_alert = TRUE

/obj/item/crowbar/power/paramedic/get_ru_names()
	return alist(
		NOMINATIVE = "челюсти восстановления",
		GENITIVE = "челюстей восстановления",
		DATIVE = "челюстям восстановления",
		ACCUSATIVE = "челюсти восстановления",
		INSTRUMENTAL = "челюстями восстановления",
		PREPOSITIONAL = "челюстях восстановления",
	)

/obj/item/crowbar/power/paramedic/sound_the_alarms(mob/user, obj/machinery/door/airlock/target)
		aas_config_announce(/datum/aas_config_entry/jaws_entry_alert_paramedic, list(
			"PERSON" = user.name,
			"LOCATION" = get_area_name(target),
			"TOOL" = name), src, list(RADIO_CHANNEL_SECURITY), RADIO_CHANNEL_SECURITY)

		aas_config_announce(/datum/aas_config_entry/jaws_entry_alert_paramedic, list(
			"PERSON" = user.name,
			"LOCATION" = get_area_name(target),
			"TOOL" = name), src, list(RADIO_CHANNEL_MEDICAL), RADIO_CHANNEL_MEDICAL)

/datum/aas_config_entry/jaws_entry_alert_paramedic
	// This tool screams into the radio whenever the user successfully pries open an airlock.
	name = "Door Forced Entry Medical Alert"
	announcement_lines_map = list(
		RADIO_CHANNEL_SECURITY = "ТРЕВОГА СБ: %PERSON взламывает дверь в %LOCATION, используя %TOOL. Подтвердите, что это было сделано во время чрезвычайной ситуации уполномоченным персоналом.",
		RADIO_CHANNEL_MEDICAL = "МЕДИЦИНСКАЯ ТРЕВОГА: %PERSON взламывает дверь в %LOCATION, используя %TOOL. Подтвердите, что это было сделано во время чрезвычайной ситуации уполномоченным персоналом.",
	)
	vars_and_tooltips_map = list(
		"PERSON" = "will be replaced with the name of the user",
		"LOCATION" = "with the area of the door",
		"TOOL" = "replaced with the tool used",
	)

/obj/item/crowbar/power/paramedic/silent
	desc = "Специализированная версия челюстей жизни, предназначенная в первую очередь для парамедиков, чтобы извлекать раненых и недавно умерших. Вместо резака этот инструмент оснащён аппаратом для вправления костей. Выглядят улучшенными."
	w_class = WEIGHT_CLASS_NORMAL // it's a modified, normal jaws
	limit_jaws_access = FALSE
	radio_alert = FALSE

/obj/item/crowbar/cyborg
	name = "hydraulic crowbar"
	desc = "Гидравлический инструмент для поддевания, простой, но мощный."
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "toolkit_engiborg_crowbar"
	worn_icon_state = "toolkit_engiborg_crowbar" //error sprite - this shouldn't have been dropped
	icon_angle = 0
	usesound = 'sound/items/tools/jaws_pry.ogg'
	force = 10
	toolspeed = 0.5

/obj/item/crowbar/cyborg/get_ru_names()
	return alist(
		NOMINATIVE = "гидравлический лом",
		GENITIVE = "гидравлического лома",
		DATIVE = "гидравлическому лому",
		ACCUSATIVE = "гидравлический лом",
		INSTRUMENTAL = "гидравлическим ломом",
		PREPOSITIONAL = "гидравлическом ломе",
	)

/obj/item/crowbar/mechremoval
	name = "mech removal tool"
	desc = "Э... реально большой лом. Вы уверены, что им можно вскрыть мех, но в остальном он кажется неудобным."
	icon_state = "mechremoval0"
	base_icon_state = "mechremoval"
	inhand_icon_state = null
	icon = 'icons/obj/mechremoval.dmi'
	icon_angle = -65
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = NONE
	toolspeed = 1.25
	armor_type = /datum/armor/crowbar_mechremoval
	resistance_flags = FIRE_PROOF
	exposed_wound_bonus = 15
	wound_bonus = 10

/datum/armor/crowbar_mechremoval
	bomb = 100
	fire = 100

/obj/item/crowbar/mechremoval/get_ru_names()
	return alist(
		NOMINATIVE = "инструмент вскрытия мехов",
		GENITIVE = "инструмента вскрытия мехов",
		DATIVE = "инструменту вскрытия мехов",
		ACCUSATIVE = "инструмент вскрытия мехов",
		INSTRUMENTAL = "инструментом вскрытия мехов",
		PREPOSITIONAL = "инструменте вскрытия мехов",
	)

/obj/item/crowbar/mechremoval/Initialize(mapload)
	. = ..()
	transform = transform.Translate(0, -8)
	AddComponent(/datum/component/two_handed, force_unwielded = 5, force_wielded = 19, icon_wielded = "[base_icon_state]1")

/obj/item/crowbar/mechremoval/update_icon_state()
	icon_state = "[base_icon_state]0"
	return ..()

/obj/item/crowbar/mechremoval/proc/empty_mech(obj/vehicle/sealed/mecha/mech, mob/user)
	if(!HAS_TRAIT(src, TRAIT_WIELDED))
		mech.balloon_alert(user, "нужно взять в две руки!")
		return
	var/obj/item/mecha_parts/mecha_equipment/sleeper/mech_sleeper = locate() in mech
	if((!LAZYLEN(mech.occupants) || (LAZYLEN(mech.occupants) == 1 && mech.mecha_flags & SILICON_PILOT)) && (!mech_sleeper || !mech_sleeper.patient)) //if no occupants, or only an ai
		mech.balloon_alert(user, "пусто!")
		return
	var/list/log_list_before = LAZYCOPY(mech.occupants)
	if(mech_sleeper?.patient)
		log_list_before += mech_sleeper.patient
	user.log_message("tried to pry open [mech], located at [loc_name(mech)], which is occupied by [log_list_before.Join(", ")].", LOG_ATTACK)
	var/mech_dir = mech.dir
	mech.balloon_alert(user, "вскрываю...")
	playsound(mech, 'sound/machines/airlock/airlock_alien_prying.ogg', 100, TRUE)
	if(!use_tool(mech, user, (mech.mecha_flags & IS_ENCLOSED) ? 5 SECONDS : 3 SECONDS, volume = 0, extra_checks = CALLBACK(src, PROC_REF(extra_checks), mech, mech_dir, mech_sleeper)))
		mech.balloon_alert(user, "прервано!")
		return
	var/list/log_list_after = LAZYCOPY(mech.occupants)
	if(mech_sleeper?.patient)
		log_list_after += mech_sleeper.patient
		mech_sleeper.go_out()
	user.log_message("pried open [mech], located at [loc_name(mech)], which was occupied by [log_list_after.Join(", ")].", LOG_ATTACK)
	for(var/mob/living/occupant as anything in SANITIZE_LIST(mech.occupants))
		if(isAI(occupant) || isbrain(occupant))
			continue
		mech.mob_exit(occupant)
	playsound(mech, 'sound/machines/airlock/airlockforced.ogg', 75, TRUE)

/obj/item/crowbar/mechremoval/proc/extra_checks(obj/vehicle/sealed/mecha/mech, mech_dir, obj/item/mecha_parts/mecha_equipment/sleeper/mech_sleeper)
	return HAS_TRAIT(src, TRAIT_WIELDED) && (LAZYLEN(mech.occupants) || mech_sleeper?.patient) && (mech.dir == mech_dir)
