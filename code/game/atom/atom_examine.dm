/atom
	/// Если не null, переопределяет артикль (a/an/some) во всех случаях
	var/article
	/// Текст, появляющийся перед названием в [/atom/proc/examine_title]
	var/examine_thats = "Это"

/**
 * Вызывается, когда моб осматривает этот атом: [/mob/verb/examinate]
 *
 * Поведение по умолчанию: получить название и иконку объекта, а также его реагенты,
 * если на контейнере реагентов установлен флаг [TRANSPARENT]
 *
 * Генерирует сигнал [COMSIG_ATOM_EXAMINE] для модификации списка, возвращаемого этой процедурой
 */
/atom/proc/examine(mob/user)
	. = list()
	. += get_name_chaser(user)
	if(desc)
		. += "<i>[desc]</i>"

	var/list/tags_list = examine_tags(user)
	var/list/post_descriptor = examine_post_descriptor(user)
	var/post_desc_string = length(post_descriptor) ? " [jointext(post_descriptor, " ")]" : ""
	if (length(tags_list))
		var/tag_string = list()
		for (var/atom_tag in tags_list)
			tag_string += (isnull(tags_list[atom_tag]) ? atom_tag : span_tooltip(tags_list[atom_tag], atom_tag))
		// Регулярное выражение для предотвращения добавления лишнего "и", если последний элемент уже содержит его (не в подсказке)
		tag_string = english_list(tag_string, and_text = (findtext(tag_string[length(tag_string)], regex(@">.*?и .*?<"))) ? " " : " и ")
		. += "Это [tag_string] [examine_descriptor(user)][post_desc_string]."
	else if(post_desc_string)
		. += "Это [examine_descriptor(user)][post_desc_string]."

	if(reagents)
		var/user_sees_reagents = user.can_see_reagents()
		var/reagent_sigreturn = SEND_SIGNAL(src, COMSIG_ATOM_REAGENT_EXAMINE, user, ., user_sees_reagents)
		if(!(reagent_sigreturn & STOP_GENERIC_REAGENT_EXAMINE))
			if(reagents.flags & TRANSPARENT)
				if(reagents.total_volume)
					. += "Имеется  <b>[reagents.total_volume]</b> единиц различных химикатов[user_sees_reagents ? ":" : "."]"
					if(user_sees_reagents || (reagent_sigreturn & ALLOW_GENERIC_REAGENT_EXAMINE)) // Показывать каждый отдельный реагент для детального осмотра
						for(var/datum/reagent/current_reagent as anything in reagents.reagent_list)
							. += "&bull; [round(current_reagent.volume, CHEMICAL_VOLUME_ROUNDING)] единиц [current_reagent.name]"
						if(reagents.is_reacting)
							. += span_warning("Оно сейчас вступает в реакцию!")
						. += span_notice("pH раствора равен [round(reagents.ph, 0.01)] и имеет температуру в [reagents.chem_temp]K.")

				else
					. += "Содержит:<br>Ничего."
			else if(reagents.flags & AMOUNT_VISIBLE)
				if(reagents.total_volume)
					. += span_notice("Имеется [reagents.total_volume] единиц.")
				else
					. += span_danger("Пусто.")

	SEND_SIGNAL(src, COMSIG_ATOM_EXAMINE, user, .)

/**
 * Список "тегов", отображаемых после описания атома при осмотре.
 * Должен возвращать ассоциативный список тегов -> всплывающие подсказки для них.
 * Если значение равно null, то подсказка не назначается.
 *
 * * Всплывающие подсказки TGUI (не основной текст) в чате НЕ МОГУТ использовать HTML,
 *   поэтому попытки вроде `<b><big>ffff</big></b>` не будут работать для подсказок.
 *
 * Например:
 * ```byond
 * . = list()
 * .["маленький"] = "Это маленький предмет."
 * .["огнестойкий"] = "Сделан из огнеупорных материалов."
 * .["и проводящий"] = "Сделан из проводящих материалов и тому подобного. Бла-бла-бла." // наличие "и " в ключе тега тоже работает!
 * ```
 * даст результат:
 *
 * Это *маленький*, *огнестойкий* *и проводящий* объект.
 *
 * где "объект" берётся из [/atom/proc/examine_descriptor]
 */
/atom/proc/examine_tags(mob/user)
	. = list()
	if(abstract_type == type)
		.[span_hypnophrase("abstract")] = "Это абстрактный тип, вы должны сообщить об этом говнокодерам, что сломали это!"

	if(resistance_flags & INDESTRUCTIBLE)
		.["неразрушаемый"] = "Предмет очень прочный! Он выдержит всё, что с ним может случиться!"
	else
		if(resistance_flags & LAVA_PROOF)
			.["лавастойкий"] = "Предмет сделан из чрезвычайно жаропрочного материала, и, вероятно, сможет выдержать даже лаву!"
		if(resistance_flags & (ACID_PROOF | UNACIDABLE))
			.["кислотостойкий"] = "Предмет выглядит довольно прочным! Возможно, он выдержит воздействие кислоты!"
		if(resistance_flags & FREEZE_PROOF)
			.["морозостойкий"] = "Предмет изготовлен из моростойких материалов."
		if(resistance_flags & FIRE_PROOF)
			.["огнестойкий"] = "Предмет изготовлен из огнестойких материалов."
		if(resistance_flags & SHUTTLE_CRUSH_PROOF)
			.["очень прочный"] = "Предмет невероятно прочный. Должен выдержать даже наезд шаттла!"
		if(resistance_flags & BOMB_PROOF)
			.["взрывоустойчивый"] = "Предмет способен пережить взрыв!"
		if(resistance_flags & FLAMMABLE)
			.["легковоспламеняющийся"] = "Предмет может легко загореться."

	if(flags_1 & HOLOGRAM_1)
		.["голографический"] = "Похоже на голограмму."

	SEND_SIGNAL(src, COMSIG_ATOM_EXAMINE_TAGS, user, .)

/// Как этот атом должен называться в тегах осмотра
/atom/proc/examine_descriptor(mob/user)
	return "объект"

/// Возвращает список строк для отображения после описатения
/atom/proc/examine_post_descriptor(mob/user)
	. = list()
	if(!custom_materials)
		return
	var/mats_list = list()
	for(var/custom_material in custom_materials)
		var/datum/material/current_material = GET_MATERIAL_REF(custom_material)
		mats_list += span_tooltip("Объект сделан из [RU_GEN(current_material)].", RU_GEN(current_material))
	. += "из [english_list(mats_list)]"

/**
 * Вызывается, когда моб осматривает (Shift+клик или команда) этот атом дважды (или более) в течение EXAMINE_MORE_WINDOW (по умолчанию 1 секунда)
 *
 * Здесь можно разместить дополнительную информацию, которая может быть избыточной или неважной в критических игровых моментах,
 * позволяя игрокам вручную двойным осмотром присмотреться внимательнее
 *
 * Генерирует сигнал [COMSIG_ATOM_EXAMINE_MORE]
 */
/atom/proc/examine_more(mob/user)
	SHOULD_CALL_PARENT(TRUE)
	RETURN_TYPE(/list)

	. = list()
	SEND_SIGNAL(src, COMSIG_ATOM_EXAMINE_MORE, user, .)
	SEND_SIGNAL(user, COMSIG_MOB_EXAMINING_MORE, src, .)

/**
 * Получить название этого объекта для осмотра
 *
 * Вы можете переопределить возвращаемое значение этой процедуры, подписавшись на сигнал
 * [COMSIG_ATOM_GET_EXAMINE_NAME]
 */
/atom/proc/get_examine_name(mob/user, declent = NOMINATIVE)
	var/list/override = list(article, null, "<em>[get_visible_name(declent = declent)]</em>")
	SEND_SIGNAL(src, COMSIG_ATOM_GET_EXAMINE_NAME, user, override)

	if(!isnull(override[EXAMINE_POSITION_ARTICLE]))
		override -= null // Если нет "before", не пытаться объединить
		return jointext(override, " ")
	if(!isnull(override[EXAMINE_POSITION_BEFORE]))
		override -= null // Нет артикля, не пытаться объединить
		return "[jointext(override, " ")]"
	return RU_SRC(declent)

/mob/living/get_examine_name(mob/user)
	var/visible_name = get_visible_name()
	var/list/name_override = list(visible_name)
	if(SEND_SIGNAL(user, COMSIG_LIVING_PERCEIVE_EXAMINE_NAME, src, visible_name, name_override) & COMPONENT_EXAMINE_NAME_OVERRIDEN)
		return name_override[1]
	return visible_name

/// Иконка, отображаемая при осмотре
/atom/proc/get_examine_icon(mob/user)
	return icon2html(src, user)

/**
 * Форматирует название атома в строку для использования при осмотре (как "заголовок" атома)
 *
 * * user - моб, осматривающий атом
 * * thats - включать ли "Это" или подобное (мобы используют "Это") перед названием
 */
/atom/proc/examine_title(mob/user, thats = FALSE, declent = NOMINATIVE)
	var/examine_icon = get_examine_icon(user)
	return "[examine_icon ? "[examine_icon] " : ""][thats ? "[examine_thats] ":""]<em>[get_examine_name(user, declent)]</em>"

/**
 * Возвращает расширенный список строк осмотра для любых содержащихся ID-карт.
 *
 * Аргументы:
 * * user - Пользователь, который проводит осмотр.
 */
/atom/proc/get_id_examine_strings(mob/user)
	. = list()

/// Используется для вставки текста после названия, но перед описанием в examine()
/atom/proc/get_name_chaser(mob/user, list/name_chaser = list())
	return name_chaser

/**
 * Используется мобами для определения имени того, кто носит маску, имеет обезображенное или отсутствующее лицо.
 * По умолчанию просто возвращает название атома.
 *
 * * add_id_name - Если TRUE, добавляется информация с ID, такая как обращения или имя (если не совпадает)
 * * force_real_name - Если TRUE, всегда возвращает real_name и добавляет (как face_name/id_name), если оно не соответствует внешности
 */
/atom/proc/get_visible_name(add_id_name = TRUE, force_real_name = FALSE, declent = NOMINATIVE)
	return RU_SRC(declent)
