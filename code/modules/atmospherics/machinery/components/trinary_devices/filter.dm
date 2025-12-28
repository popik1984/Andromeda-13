/obj/machinery/atmospherics/components/trinary/filter
	icon_state = "filter_off-0"
	density = FALSE

	name = "gas filter"
	desc = "Очень полезен для фильтрации газов."
	gender = MALE

	can_unwrench = TRUE
	construction_type = /obj/item/pipe/trinary/flippable/filter
	pipe_state = "filter"

	///Rate of transfer of the gases to the outputs
	var/transfer_rate = MAX_TRANSFER_RATE
	///What gases are we filtering, by typepath
	var/list/filter_type = list()

/obj/machinery/atmospherics/components/trinary/filter/get_ru_names()
	return list(
		NOMINATIVE = "газовый фильтр",
		GENITIVE = "газового фильтра",
		DATIVE = "газовому фильтру",
		ACCUSATIVE = "газовый фильтр",
		INSTRUMENTAL = "газовым фильтром",
		PREPOSITIONAL = "газовом фильтре",
	)

/obj/machinery/atmospherics/components/trinary/filter/Initialize(mapload)
	. = ..()
	register_context()

/obj/machinery/atmospherics/components/trinary/filter/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	context[SCREENTIP_CONTEXT_CTRL_LMB] = "[on ? "Выключить" : "Включить"]"
	context[SCREENTIP_CONTEXT_ALT_LMB] = "Максимальная скорость"
	return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/atmospherics/components/trinary/filter/click_ctrl(mob/user)
	if(is_operational)
		set_on(!on)
		balloon_alert(user, "[on ? "включено" : "выключено"]")
		investigate_log("was turned [on ? "on" : "off"] by [key_name(user)]", INVESTIGATE_ATMOS)
		return CLICK_ACTION_SUCCESS
	return CLICK_ACTION_BLOCKING

/obj/machinery/atmospherics/components/trinary/filter/click_alt(mob/user)
	if(transfer_rate == MAX_TRANSFER_RATE)
		return CLICK_ACTION_BLOCKING

	transfer_rate = MAX_TRANSFER_RATE
	investigate_log("was set to [transfer_rate] L/s by [key_name(user)]", INVESTIGATE_ATMOS)
	balloon_alert(user, "вывод установлен на [transfer_rate] л/с")
	return CLICK_ACTION_SUCCESS

/obj/machinery/atmospherics/components/trinary/filter/update_overlays()
	. = ..()
	for(var/direction in GLOB.cardinals)
		if(!(direction & initialize_directions))
			continue

		. += get_pipe_image(icon, "cap", direction, pipe_color, piping_layer, TRUE)

/obj/machinery/atmospherics/components/trinary/filter/update_icon_nopipes()
	var/on_state = on && nodes[1] && nodes[2] && nodes[3] && is_operational
	icon_state = "filter_[on_state ? "on" : "off"]-[set_overlay_offset(piping_layer)][flipped ? "_f" : ""]"

/obj/machinery/atmospherics/components/trinary/filter/process_atmos()
	..()
	if(!on || !(nodes[1] && nodes[2] && nodes[3]) || !is_operational)
		return

	//Early return
	var/datum/gas_mixture/air1 = airs[1]
	if(!air1 || air1.temperature <= 0)
		return

	var/datum/gas_mixture/air2 = airs[2]
	var/datum/gas_mixture/air3 = airs[3]

	var/transfer_ratio = transfer_rate / air1.volume

	if(transfer_ratio <= 0)
		return

	// Attempt to transfer the gas.

	// If the main output is full, we try to send filtered output to the side port (air2).
	// If the side output is full, we try to send the non-filtered gases to the main output port (air3).
	// Any gas that can't be moved due to its destination being too full is sent back to the input (air1).

	var/side_output_full = air2.return_pressure() >= MAX_OUTPUT_PRESSURE
	var/main_output_full = air3.return_pressure() >= MAX_OUTPUT_PRESSURE

	// If both output ports are full, there's nothing we can do. Don't bother removing anything from the input.
	if (side_output_full && main_output_full)
		return

	var/datum/gas_mixture/removed = air1.remove_ratio(transfer_ratio)

	if(!removed || !removed.total_moles())
		return

	var/filtering = TRUE
	if(!filter_type.len)
		filtering = FALSE

	// Process if we have a filter set.
	// If no filter is set, we just try to forward everything to air3 to avoid gas being outright lost.
	if(filtering)
		var/datum/gas_mixture/filtered_out = new

		for(var/gas in removed.gases & filter_type)
			var/datum/gas_mixture/removing = removed.remove_specific_ratio(gas, 1)
			if(removing)
				filtered_out.merge(removing)
		// Send things to the side output if we can, return them to the input if we can't.
		// This means that other gases continue to flow to the main output if the side output is blocked.
		if (side_output_full)
			air1.merge(filtered_out)
		else
			air2.merge(filtered_out)
		// Make sure we don't send any now-empty gas entries to the main output
		removed.garbage_collect()

	// Send things to the main output if we can, return them to the input if we can't.
	// This lets filtered gases continue to flow to the side output in a manner consistent with the main output behavior.
	if (main_output_full)
		air1.merge(removed)
	else
		air3.merge(removed)

	update_parents()

/obj/machinery/atmospherics/components/trinary/filter/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AtmosFilter", name)
		ui.open()

/obj/machinery/atmospherics/components/trinary/filter/ui_data()
	var/data = list()
	data["on"] = on
	data["rate"] = round(transfer_rate)
	data["max_rate"] = round(MAX_TRANSFER_RATE)

	data["filter_types"] = list()
	for(var/path in GLOB.meta_gas_info)
		var/list/gas = GLOB.meta_gas_info[path]
		data["filter_types"] += list(list("gas_id" = gas[META_GAS_ID], "enabled" = (path in filter_type)))

	return data

/obj/machinery/atmospherics/components/trinary/filter/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("power")
			set_on(!on)
			investigate_log("was turned [on ? "on" : "off"] by [key_name(usr)]", INVESTIGATE_ATMOS)
			. = TRUE
		if("rate")
			var/rate = params["rate"]
			if(rate == "max")
				rate = MAX_TRANSFER_RATE
				. = TRUE
			else if(text2num(rate) != null)
				rate = text2num(rate)
				. = TRUE
			if(.)
				transfer_rate = clamp(rate, 0, MAX_TRANSFER_RATE)
				investigate_log("was set to [transfer_rate] L/s by [key_name(usr)]", INVESTIGATE_ATMOS)
		if("toggle_filter")
			if(!gas_id2path(params["val"]))
				return TRUE
			filter_type ^= gas_id2path(params["val"])
			var/change
			if(gas_id2path(params["val"]) in filter_type)
				change = "added"
			else
				change = "removed"
			var/gas_name = GLOB.meta_gas_info[gas_id2path(params["val"])][META_GAS_NAME]
			usr.investigate_log("[change] [gas_name] from the filter type.", INVESTIGATE_ATMOS)
			. = TRUE
	update_appearance(UPDATE_ICON)

/obj/machinery/atmospherics/components/trinary/filter/can_unwrench(mob/user)
	. = ..()
	if(. && on && is_operational)
		balloon_alert(user, "выключите!")
		return FALSE

// mapping

/obj/machinery/atmospherics/components/trinary/filter/layer2
	piping_layer = 2
	icon_state = "filter_off_map-2"
/obj/machinery/atmospherics/components/trinary/filter/layer4
	piping_layer = 4
	icon_state = "filter_off_map-4"

/obj/machinery/atmospherics/components/trinary/filter/on
	on = TRUE
	icon_state = "filter_on-0"

/obj/machinery/atmospherics/components/trinary/filter/on/layer2
	piping_layer = 2
	icon_state = "filter_on_map-2"
/obj/machinery/atmospherics/components/trinary/filter/on/layer4
	piping_layer = 4
	icon_state = "filter_on_map-4"

/obj/machinery/atmospherics/components/trinary/filter/flipped
	icon_state = "filter_off-0_f"
	flipped = TRUE

/obj/machinery/atmospherics/components/trinary/filter/flipped/layer2
	piping_layer = 2
	icon_state = "filter_off_f_map-2"
/obj/machinery/atmospherics/components/trinary/filter/flipped/layer4
	piping_layer = 4
	icon_state = "filter_off_f_map-4"

/obj/machinery/atmospherics/components/trinary/filter/flipped/on
	on = TRUE
	icon_state = "filter_on-0_f"

/obj/machinery/atmospherics/components/trinary/filter/flipped/on/layer2
	piping_layer = 2
	icon_state = "filter_on_f_map-2"
/obj/machinery/atmospherics/components/trinary/filter/flipped/on/layer4
	piping_layer = 4
	icon_state = "filter_on_f_map-4"

/obj/machinery/atmospherics/components/trinary/filter/atmos //Used for atmos waste loops
	on = TRUE
	icon_state = "filter_on-0"
/obj/machinery/atmospherics/components/trinary/filter/atmos/n2
	name = "nitrogen filter"
	filter_type = list(/datum/gas/nitrogen)
/obj/machinery/atmospherics/components/trinary/filter/atmos/n2/get_ru_names()
	return list(
		NOMINATIVE = "азотный фильтр",
		GENITIVE = "азотного фильтра",
		DATIVE = "азотному фильтру",
		ACCUSATIVE = "азотный фильтр",
		INSTRUMENTAL = "азотным фильтром",
		PREPOSITIONAL = "азотном фильтре",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/o2
	name = "oxygen filter"
	filter_type = list(/datum/gas/oxygen)
/obj/machinery/atmospherics/components/trinary/filter/atmos/o2/get_ru_names()
	return list(
		NOMINATIVE = "кислородный фильтр",
		GENITIVE = "кислородного фильтра",
		DATIVE = "кислородному фильтру",
		ACCUSATIVE = "кислородный фильтр",
		INSTRUMENTAL = "кислородным фильтром",
		PREPOSITIONAL = "кислородном фильтре",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/co2
	name = "carbon dioxide filter"
	filter_type = list(/datum/gas/carbon_dioxide)
/obj/machinery/atmospherics/components/trinary/filter/atmos/co2/get_ru_names()
	return list(
		NOMINATIVE = "фильтр углекислого газа",
		GENITIVE = "фильтра углекислого газа",
		DATIVE = "фильтру углекислого газа",
		ACCUSATIVE = "фильтр углекислого газа",
		INSTRUMENTAL = "фильтром углекислого газа",
		PREPOSITIONAL = "фильтре углекислого газа",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/n2o
	name = "nitrous oxide filter"
	filter_type = list(/datum/gas/nitrous_oxide)
/obj/machinery/atmospherics/components/trinary/filter/atmos/n2o/get_ru_names()
	return list(
		NOMINATIVE = "фильтр оксида азота",
		GENITIVE = "фильтра оксида азота",
		DATIVE = "фильтру оксида азота",
		ACCUSATIVE = "фильтр оксида азота",
		INSTRUMENTAL = "фильтром оксида азота",
		PREPOSITIONAL = "фильтре оксида азота",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/plasma
	name = "plasma filter"
	filter_type = list(/datum/gas/plasma)
/obj/machinery/atmospherics/components/trinary/filter/atmos/plasma/get_ru_names()
	return list(
		NOMINATIVE = "плазменный фильтр",
		GENITIVE = "плазменного фильтра",
		DATIVE = "плазменному фильтру",
		ACCUSATIVE = "плазменный фильтр",
		INSTRUMENTAL = "плазменным фильтром",
		PREPOSITIONAL = "плазменном фильтре",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/bz
	name = "bz filter"
	filter_type = list(/datum/gas/bz)
/obj/machinery/atmospherics/components/trinary/filter/atmos/bz/get_ru_names()
	return list(
		NOMINATIVE = "фильтр BZ",
		GENITIVE = "фильтра BZ",
		DATIVE = "фильтру BZ",
		ACCUSATIVE = "фильтр BZ",
		INSTRUMENTAL = "фильтром BZ",
		PREPOSITIONAL = "фильтре BZ",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/freon
	name = "freon filter"
	filter_type = list(/datum/gas/freon)
/obj/machinery/atmospherics/components/trinary/filter/atmos/freon/get_ru_names()
	return list(
		NOMINATIVE = "фильтр фреона",
		GENITIVE = "фильтра фреона",
		DATIVE = "фильтру фреона",
		ACCUSATIVE = "фильтр фреона",
		INSTRUMENTAL = "фильтром фреона",
		PREPOSITIONAL = "фильтре фреона",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/halon
	name = "halon filter"
	filter_type = list(/datum/gas/halon)
/obj/machinery/atmospherics/components/trinary/filter/atmos/halon/get_ru_names()
	return list(
		NOMINATIVE = "фильтр галона",
		GENITIVE = "фильтра галона",
		DATIVE = "фильтру галона",
		ACCUSATIVE = "фильтр галона",
		INSTRUMENTAL = "фильтром галона",
		PREPOSITIONAL = "фильтре галона",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/healium
	name = "healium filter"
	filter_type = list(/datum/gas/healium)
/obj/machinery/atmospherics/components/trinary/filter/atmos/healium/get_ru_names()
	return list(
		NOMINATIVE = "фильтр хилиума",
		GENITIVE = "фильтра хилиума",
		DATIVE = "фильтру хилиума",
		ACCUSATIVE = "фильтр хилиума",
		INSTRUMENTAL = "фильтром хилиума",
		PREPOSITIONAL = "фильтре хилиума",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/h2
	name = "hydrogen filter"
	filter_type = list(/datum/gas/hydrogen)
/obj/machinery/atmospherics/components/trinary/filter/atmos/h2/get_ru_names()
	return list(
		NOMINATIVE = "водородный фильтр",
		GENITIVE = "водородного фильтра",
		DATIVE = "водородному фильтру",
		ACCUSATIVE = "водородный фильтр",
		INSTRUMENTAL = "водородным фильтром",
		PREPOSITIONAL = "водородном фильтре",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/hypernoblium
	name = "hypernoblium filter"
	filter_type = list(/datum/gas/hypernoblium)
/obj/machinery/atmospherics/components/trinary/filter/atmos/hypernoblium/get_ru_names()
	return list(
		NOMINATIVE = "фильтр гиперноблия",
		GENITIVE = "фильтра гиперноблия",
		DATIVE = "фильтру гиперноблия",
		ACCUSATIVE = "фильтр гиперноблия",
		INSTRUMENTAL = "фильтром гиперноблия",
		PREPOSITIONAL = "фильтре гиперноблия",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/miasma
	name = "miasma filter"
	filter_type = list(/datum/gas/miasma)
/obj/machinery/atmospherics/components/trinary/filter/atmos/miasma/get_ru_names()
	return list(
		NOMINATIVE = "фильтр миазмов",
		GENITIVE = "фильтра миазмов",
		DATIVE = "фильтру миазмов",
		ACCUSATIVE = "фильтр миазмов",
		INSTRUMENTAL = "фильтром миазмов",
		PREPOSITIONAL = "фильтре миазмов",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/no2
	name = "nitrium filter"
	filter_type = list(/datum/gas/nitrium)
/obj/machinery/atmospherics/components/trinary/filter/atmos/no2/get_ru_names()
	return list(
		NOMINATIVE = "нитриумный фильтр",
		GENITIVE = "нитриумного фильтра",
		DATIVE = "нитриумному фильтру",
		ACCUSATIVE = "нитриумный фильтр",
		INSTRUMENTAL = "нитриумным фильтром",
		PREPOSITIONAL = "нитриумном фильтре",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/pluoxium
	name = "pluoxium filter"
	filter_type = list(/datum/gas/pluoxium)
/obj/machinery/atmospherics/components/trinary/filter/atmos/pluoxium/get_ru_names()
	return list(
		NOMINATIVE = "плюоксиевый фильтр",
		GENITIVE = "плюоксиевого фильтра",
		DATIVE = "плюоксиевому фильтру",
		ACCUSATIVE = "плюоксиевый фильтр",
		INSTRUMENTAL = "плюоксиевым фильтром",
		PREPOSITIONAL = "плюоксиевом фильтре",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/proto_nitrate
	name = "proto-nitrate filter"
	filter_type = list(/datum/gas/proto_nitrate)
/obj/machinery/atmospherics/components/trinary/filter/atmos/proto_nitrate/get_ru_names()
	return list(
		NOMINATIVE = "протонитратный фильтр",
		GENITIVE = "протонитратного фильтра",
		DATIVE = "протонитратному фильтру",
		ACCUSATIVE = "протонитратный фильтр",
		INSTRUMENTAL = "протонитратным фильтром",
		PREPOSITIONAL = "протонитратном фильтре",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/tritium
	name = "tritium filter"
	filter_type = list(/datum/gas/tritium)
/obj/machinery/atmospherics/components/trinary/filter/atmos/tritium/get_ru_names()
	return list(
		NOMINATIVE = "тритиевый фильтр",
		GENITIVE = "тритиевого фильтра",
		DATIVE = "тритиевому фильтру",
		ACCUSATIVE = "тритиевый фильтр",
		INSTRUMENTAL = "тритиевым фильтром",
		PREPOSITIONAL = "тритиевом фильтре",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/h2o
	name = "water vapor filter"
	filter_type = list(/datum/gas/water_vapor)
/obj/machinery/atmospherics/components/trinary/filter/atmos/h2o/get_ru_names()
	return list(
		NOMINATIVE = "фильтр водяного пара",
		GENITIVE = "фильтра водяного пара",
		DATIVE = "фильтру водяного пара",
		ACCUSATIVE = "фильтр водяного пара",
		INSTRUMENTAL = "фильтром водяного пара",
		PREPOSITIONAL = "фильтре водяного пара",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/zauker
	name = "zauker filter"
	filter_type = list(/datum/gas/zauker)
/obj/machinery/atmospherics/components/trinary/filter/atmos/zauker/get_ru_names()
	return list(
		NOMINATIVE = "фильтр заукера",
		GENITIVE = "фильтра заукера",
		DATIVE = "фильтру заукера",
		ACCUSATIVE = "фильтр заукера",
		INSTRUMENTAL = "фильтром заукера",
		PREPOSITIONAL = "фильтре заукера",
	)

/obj/machinery/atmospherics/components/trinary/filter/atmos/helium
	name = "helium filter"
	filter_type = list(/datum/gas/helium)
/obj/machinery/atmospherics/components/trinary/filter/atmos/helium/get_ru_names()
	return list(
		NOMINATIVE = "гелиевый фильтр",
		GENITIVE = "гелиевого фильтра",
		DATIVE = "гелиевому фильтру",
		ACCUSATIVE = "гелиевый фильтр",
		INSTRUMENTAL = "гелиевым фильтром",
		PREPOSITIONAL = "гелиевом фильтре",
	)

/obj/machinery/atmospherics/components/trinary/filter/atmos/antinoblium
	name = "antinoblium filter"
	filter_type = list(/datum/gas/antinoblium)
/obj/machinery/atmospherics/components/trinary/filter/atmos/antinoblium/get_ru_names()
	return list(
		NOMINATIVE = "фильтр антиноблия",
		GENITIVE = "фильтра антиноблия",
		DATIVE = "фильтру антиноблия",
		ACCUSATIVE = "фильтр антиноблия",
		INSTRUMENTAL = "фильтром антиноблия",
		PREPOSITIONAL = "фильтре антиноблия",
	)

/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped //This feels wrong, I know
	icon_state = "filter_on-0_f"
	flipped = TRUE
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/n2
	name = "nitrogen filter"
	filter_type = list(/datum/gas/nitrogen)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/n2/get_ru_names()
	return list(
		NOMINATIVE = "азотный фильтр",
		GENITIVE = "азотного фильтра",
		DATIVE = "азотному фильтру",
		ACCUSATIVE = "азотный фильтр",
		INSTRUMENTAL = "азотным фильтром",
		PREPOSITIONAL = "азотном фильтре",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/o2
	name = "oxygen filter"
	filter_type = list(/datum/gas/oxygen)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/o2/get_ru_names()
	return list(
		NOMINATIVE = "кислородный фильтр",
		GENITIVE = "кислородного фильтра",
		DATIVE = "кислородному фильтру",
		ACCUSATIVE = "кислородный фильтр",
		INSTRUMENTAL = "кислородным фильтром",
		PREPOSITIONAL = "кислородном фильтре",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/co2
	name = "carbon dioxide filter"
	filter_type = list(/datum/gas/carbon_dioxide)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/co2/get_ru_names()
	return list(
		NOMINATIVE = "фильтр углекислого газа",
		GENITIVE = "фильтра углекислого газа",
		DATIVE = "фильтру углекислого газа",
		ACCUSATIVE = "фильтр углекислого газа",
		INSTRUMENTAL = "фильтром углекислого газа",
		PREPOSITIONAL = "фильтре углекислого газа",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/n2o
	name = "nitrous oxide filter"
	filter_type = list(/datum/gas/nitrous_oxide)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/n2o/get_ru_names()
	return list(
		NOMINATIVE = "фильтр оксида азота",
		GENITIVE = "фильтра оксида азота",
		DATIVE = "фильтру оксида азота",
		ACCUSATIVE = "фильтр оксида азота",
		INSTRUMENTAL = "фильтром оксида азота",
		PREPOSITIONAL = "фильтре оксида азота",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/plasma
	name = "plasma filter"
	filter_type = list(/datum/gas/plasma)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/plasma/get_ru_names()
	return list(
		NOMINATIVE = "плазменный фильтр",
		GENITIVE = "плазменного фильтра",
		DATIVE = "плазменному фильтру",
		ACCUSATIVE = "плазменный фильтр",
		INSTRUMENTAL = "плазменным фильтром",
		PREPOSITIONAL = "плазменном фильтре",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/bz
	name = "bz filter"
	filter_type = list(/datum/gas/bz)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/bz/get_ru_names()
	return list(
		NOMINATIVE = "фильтр BZ",
		GENITIVE = "фильтра BZ",
		DATIVE = "фильтру BZ",
		ACCUSATIVE = "фильтр BZ",
		INSTRUMENTAL = "фильтром BZ",
		PREPOSITIONAL = "фильтре BZ",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/freon
	name = "freon filter"
	filter_type = list(/datum/gas/freon)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/freon/get_ru_names()
	return list(
		NOMINATIVE = "фильтр фреона",
		GENITIVE = "фильтра фреона",
		DATIVE = "фильтру фреона",
		ACCUSATIVE = "фильтр фреона",
		INSTRUMENTAL = "фильтром фреона",
		PREPOSITIONAL = "фильтре фреона",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/halon
	name = "halon filter"
	filter_type = list(/datum/gas/halon)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/halon/get_ru_names()
	return list(
		NOMINATIVE = "фильтр галона",
		GENITIVE = "фильтра галона",
		DATIVE = "фильтру галона",
		ACCUSATIVE = "фильтр галона",
		INSTRUMENTAL = "фильтром галона",
		PREPOSITIONAL = "фильтре галона",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/healium
	name = "healium filter"
	filter_type = list(/datum/gas/healium)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/healium/get_ru_names()
	return list(
		NOMINATIVE = "фильтр хилиума",
		GENITIVE = "фильтра хилиума",
		DATIVE = "фильтру хилиума",
		ACCUSATIVE = "фильтр хилиума",
		INSTRUMENTAL = "фильтром хилиума",
		PREPOSITIONAL = "фильтре хилиума",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/h2
	name = "hydrogen filter"
	filter_type = list(/datum/gas/hydrogen)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/h2/get_ru_names()
	return list(
		NOMINATIVE = "водородный фильтр",
		GENITIVE = "водородного фильтра",
		DATIVE = "водородному фильтру",
		ACCUSATIVE = "водородный фильтр",
		INSTRUMENTAL = "водородным фильтром",
		PREPOSITIONAL = "водородном фильтре",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/hypernoblium
	name = "hypernoblium filter"
	filter_type = list(/datum/gas/hypernoblium)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/hypernoblium/get_ru_names()
	return list(
		NOMINATIVE = "фильтр гиперноблия",
		GENITIVE = "фильтра гиперноблия",
		DATIVE = "фильтру гиперноблия",
		ACCUSATIVE = "фильтр гиперноблия",
		INSTRUMENTAL = "фильтром гиперноблия",
		PREPOSITIONAL = "фильтре гиперноблия",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/miasma
	name = "miasma filter"
	filter_type = list(/datum/gas/miasma)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/miasma/get_ru_names()
	return list(
		NOMINATIVE = "фильтр миазмов",
		GENITIVE = "фильтра миазмов",
		DATIVE = "фильтру миазмов",
		ACCUSATIVE = "фильтр миазмов",
		INSTRUMENTAL = "фильтром миазмов",
		PREPOSITIONAL = "фильтре миазмов",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/no2
	name = "nitrium filter"
	filter_type = list(/datum/gas/nitrium)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/no2/get_ru_names()
	return list(
		NOMINATIVE = "нитриумный фильтр",
		GENITIVE = "нитриумного фильтра",
		DATIVE = "нитриумному фильтру",
		ACCUSATIVE = "нитриумный фильтр",
		INSTRUMENTAL = "нитриумным фильтром",
		PREPOSITIONAL = "нитриумном фильтре",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/pluoxium
	name = "pluoxium filter"
	filter_type = list(/datum/gas/pluoxium)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/pluoxium/get_ru_names()
	return list(
		NOMINATIVE = "плюоксиевый фильтр",
		GENITIVE = "плюоксиевого фильтра",
		DATIVE = "плюоксиевому фильтру",
		ACCUSATIVE = "плюоксиевый фильтр",
		INSTRUMENTAL = "плюоксиевым фильтром",
		PREPOSITIONAL = "плюоксиевом фильтре",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/proto_nitrate
	name = "proto-nitrate filter"
	filter_type = list(/datum/gas/proto_nitrate)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/proto_nitrate/get_ru_names()
	return list(
		NOMINATIVE = "протонитратный фильтр",
		GENITIVE = "протонитратного фильтра",
		DATIVE = "протонитратному фильтру",
		ACCUSATIVE = "протонитратный фильтр",
		INSTRUMENTAL = "протонитратным фильтром",
		PREPOSITIONAL = "протонитратном фильтре",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/tritium
	name = "tritium filter"
	filter_type = list(/datum/gas/tritium)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/tritium/get_ru_names()
	return list(
		NOMINATIVE = "тритиевый фильтр",
		GENITIVE = "тритиевого фильтра",
		DATIVE = "тритиевому фильтру",
		ACCUSATIVE = "тритиевый фильтр",
		INSTRUMENTAL = "тритиевым фильтром",
		PREPOSITIONAL = "тритиевом фильтре",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/h2o
	name = "water vapor filter"
	filter_type = list(/datum/gas/water_vapor)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/h2o/get_ru_names()
	return list(
		NOMINATIVE = "фильтр водяного пара",
		GENITIVE = "фильтра водяного пара",
		DATIVE = "фильтру водяного пара",
		ACCUSATIVE = "фильтр водяного пара",
		INSTRUMENTAL = "фильтром водяного пара",
		PREPOSITIONAL = "фильтре водяного пара",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/zauker
	name = "zauker filter"
	filter_type = list(/datum/gas/zauker)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/zauker/get_ru_names()
	return list(
		NOMINATIVE = "фильтр заукера",
		GENITIVE = "фильтра заукера",
		DATIVE = "фильтру заукера",
		ACCUSATIVE = "фильтр заукера",
		INSTRUMENTAL = "фильтром заукера",
		PREPOSITIONAL = "фильтре заукера",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/helium
	name = "helium filter"
	filter_type = list(/datum/gas/helium)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/helium/get_ru_names()
	return list(
		NOMINATIVE = "гелиевый фильтр",
		GENITIVE = "гелиевого фильтра",
		DATIVE = "гелиевому фильтру",
		ACCUSATIVE = "гелиевый фильтр",
		INSTRUMENTAL = "гелиевым фильтром",
		PREPOSITIONAL = "гелиевом фильтре",
	)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/antinoblium
	name = "antinoblium filter"
	filter_type = list(/datum/gas/antinoblium)
/obj/machinery/atmospherics/components/trinary/filter/atmos/flipped/antinoblium/get_ru_names()
	return list(
		NOMINATIVE = "фильтр антиноблия",
		GENITIVE = "фильтра антиноблия",
		DATIVE = "фильтру антиноблия",
		ACCUSATIVE = "фильтр антиноблия",
		INSTRUMENTAL = "фильтром антиноблия",
		PREPOSITIONAL = "фильтре антиноблия",
	)

// These two filter types have critical_machine flagged to on and thus causes the area they are in to be exempt from the Grid Check event.

/obj/machinery/atmospherics/components/trinary/filter/critical
	critical_machine = TRUE

/obj/machinery/atmospherics/components/trinary/filter/flipped/critical
	critical_machine = TRUE
