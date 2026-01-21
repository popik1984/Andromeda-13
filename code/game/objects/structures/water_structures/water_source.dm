//Источник воды, используйте тип water_source для неограниченных источников воды, как классические раковины.
/obj/structure/water_source
	name = "Water Source"
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "sink"
	desc = "Раковина для мытья рук и лица. Кажется, вода в ней бесконечна!"
	anchored = TRUE
	///Булево значение: моется ли что-то в данный момент, предотвращает одновременное мытье несколькими людьми.
	var/busy = FALSE
	///Реагент, который выдается из этого источника, по умолчанию это вода.
	var/datum/reagent/dispensedreagent = /datum/reagent/water

/obj/structure/water_source/get_ru_names()
	return alist(
		NOMINATIVE = "источник воды",
		GENITIVE = "источника воды",
		DATIVE = "источнику воды",
		ACCUSATIVE = "источник воды",
		INSTRUMENTAL = "источником воды",
		PREPOSITIONAL = "источнике воды",
	)

/obj/structure/water_source/Initialize(mapload)
	. = ..()
	create_reagents(INFINITY, NO_REACT)
	reagents.add_reagent(dispensedreagent, INFINITY)

/obj/structure/water_source/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(!iscarbon(user))
		return
	if(!Adjacent(user))
		return

	if(busy)
		to_chat(user, span_warning("Кто-то уже умывается здесь!"))
		return
	var/selected_area = user.parse_zone_with_bodypart(user.zone_selected)
	var/washing_face = FALSE
	if(selected_area in list(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_EYES))
		washing_face = TRUE
	user.visible_message(
		span_notice("[user] начинает мыть [washing_face ? "своё лицо" : "свои руки"]..."),
		span_notice("Вы начинаете мыть [washing_face ? "своё лицо" : "свои руки"]..."))
	busy = TRUE

	if(!do_after(user, 4 SECONDS, target = src))
		busy = FALSE
		return

	busy = FALSE

	if(washing_face)
		SEND_SIGNAL(user, COMSIG_COMPONENT_CLEAN_FACE_ACT, CLEAN_WASH)
	else if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		if(!human_user.wash_hands(CLEAN_WASH))
			to_chat(user, span_warning("Ваши руки чем-то закрыты!"))
			return
	else
		user.wash(CLEAN_WASH)

	user.visible_message(
		span_notice("[RU_USER_NOM] моет [washing_face ? "своё лицо" : "свои руки"], используя [RU_SRC_ACC]."),
		span_notice("Вы моете [washing_face ? "своё лицо" : "свои руки"], используя [RU_SRC_ACC]."),
	)

/obj/structure/water_source/attackby(obj/item/attacking_item, mob/living/user, list/modifiers, list/attack_modifiers)
	if(busy)
		to_chat(user, span_warning("Кто-то уже умывается здесь!"))
		return

	if(attacking_item.item_flags & ABSTRACT) //Абстрактные предметы, такие как захваты, не моются. Предметы с no-drop будут мыться, так как технически это всё ещё предмет в руке.
		return

	if(is_reagent_container(attacking_item))
		var/obj/item/reagent_containers/container = attacking_item
		if(container.is_refillable())
			if(!container.reagents.holder_full())
				container.reagents.add_reagent(dispensedreagent, min(container.volume - container.reagents.total_volume, container.amount_per_transfer_from_this))
				to_chat(user, span_notice("Вы наполняете [RU_ACC(container)] из [RU_SRC_GEN]."))
				return TRUE
			to_chat(user, span_notice("[RU_NOM(container)] полон."))
			return FALSE

	if(istype(attacking_item, /obj/item/melee/baton/security))
		var/obj/item/melee/baton/security/baton = attacking_item
		if(baton.cell?.charge && baton.active)
			flick("baton_active", src)
			user.Paralyze(baton.knockdown_time)
			user.set_stutter(baton.knockdown_time)
			baton.cell.use(baton.cell_hit_cost)
			user.visible_message(
				span_warning("[RU_USER_NOM] бьёт себя током при попытке помыть [RU_ACC(baton)] в активном состоянии!"),
				span_userdanger("Вы опрометчиво пытаетесь помыть [RU_ACC(baton)] во включённом состоянии."))
			playsound(src, baton.on_stun_sound, 50, TRUE)
			return

	if(istype(attacking_item, /obj/item/mop))
		attacking_item.reagents.add_reagent(dispensedreagent, 5)
		to_chat(user, span_notice("Вы смачиваете [RU_ACC(attacking_item)] в [RU_SRC_PRE]."))
		playsound(loc, 'sound/effects/slosh.ogg', 25, TRUE)
		return

	if(!user.combat_mode || (attacking_item.item_flags & NOBLUDGEON))
		to_chat(user, span_notice("Вы начинаете мыть [RU_ACC(attacking_item)]..."))
		busy = TRUE
		if(!do_after(user, 4 SECONDS, target = src))
			busy = FALSE
			return TRUE
		busy = FALSE
		attacking_item.wash(CLEAN_WASH)
		reagents.expose(attacking_item, TOUCH, 5 / max(reagents.total_volume, 5))
		user.visible_message(
			span_notice("[RU_USER_NOM] моет [RU_ACC(attacking_item)], используя [RU_SRC_ACC]."),
			span_notice("Вы моете [RU_ACC(attacking_item)], используя [RU_SRC_ACC]."))
		return TRUE

	return ..()

/obj/structure/water_source/puddle //хлюп хлюп ^_^
	name = "puddle"
	desc = "Лужа, в которой можно помыть руки и лицо."
	icon_state = "puddle"
	base_icon_state = "puddle"
	resistance_flags = UNACIDABLE

/obj/structure/water_source/puddle/get_ru_names()
	return alist(
		NOMINATIVE = "лужа",
		GENITIVE = "лужи",
		DATIVE = "луже",
		ACCUSATIVE = "лужу",
		INSTRUMENTAL = "лужей",
		PREPOSITIONAL = "луже",
	)

/obj/structure/water_source/puddle/Initialize(mapload)
	. = ..()
	register_context()

/obj/structure/water_source/puddle/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(isnull(held_item))
		context[SCREENTIP_CONTEXT_RMB] = "Зачерпнуть головастиков"

//ATTACK HAND ИГНОРИРУЕТ ВОЗВРАЩАЕМОЕ ЗНАЧЕНИЕ РОДИТЕЛЯ
/obj/structure/water_source/puddle/attack_hand(mob/user, list/modifiers)
	icon_state = "[base_icon_state]-splash"
	. = ..()
	icon_state = base_icon_state

/obj/structure/water_source/puddle/attackby(obj/item/attacking_item, mob/user, list/modifiers, list/attack_modifiers)
	icon_state = "[base_icon_state]-splash"
	. = ..()
	icon_state = base_icon_state

/obj/structure/water_source/puddle/attack_hand_secondary(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	if(DOING_INTERACTION_WITH_TARGET(user, src))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	icon_state = "[base_icon_state]-splash"
	balloon_alert(user, "зачерпываю головастиков...")
	if(do_after(user, 5 SECONDS, src))
		playsound(loc, 'sound/effects/slosh.ogg', 15, TRUE)
		balloon_alert(user, "головастик пойман")
		var/obj/item/fish/tadpole/tadpole = new(loc)
		tadpole.randomize_size_and_weight()
		user.put_in_hands(tadpole)
	icon_state = base_icon_state
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
