#define TANK_PLATING_SHEETS 12

/obj/machinery/atmospherics/components/tank
	name = "pressure tank"
	desc = "Большой сосуд, содержащий газ под давлением."

	icon = 'icons/map_icons/objects.dmi'
	icon_state = "/obj/machinery/atmospherics/components/tank"
	post_init_icon_state = "canister-0"
	base_icon_state = "canister"

	max_integrity = 800
	integrity_failure = 0.2
	density = TRUE
	layer = ABOVE_WINDOW_LAYER

	custom_materials = list(/datum/material/iron = TANK_PLATING_SHEETS * SHEET_MATERIAL_AMOUNT) // plasteel is not a material to prevent two bugs: one where the default pressure is 1.5 times higher as plasteel's material modifier is added, and a second one where the tank names could be "plasteel plasteel" tanks
	material_flags = MATERIAL_EFFECTS | MATERIAL_GREYSCALE | MATERIAL_ADD_PREFIX | MATERIAL_AFFECT_STATISTICS

	pipe_flags = PIPING_ONE_PER_TURF
	device_type = QUATERNARY
	initialize_directions = NONE
	custom_reconcilation = TRUE

	smoothing_flags = SMOOTH_BITMASK | SMOOTH_OBJ
	smoothing_groups = SMOOTH_GROUP_GAS_TANK
	canSmoothWith = SMOOTH_GROUP_GAS_TANK
	appearance_flags = KEEP_TOGETHER|LONG_GLIDE

	greyscale_config = /datum/greyscale_config/stationary_canister
	greyscale_colors = "#ffffff"
	var/overlay_greyscale_config = /datum/greyscale_config/stationary_canister_overlays

	///The image showing the gases inside of the tank
	var/image/window

	/// The open node directions of the tank, assuming that the tank is facing NORTH.
	var/open_ports = NONE
	/// The volume of the gas mixture
	var/volume = 2500 //in liters
	/// The max pressure of the gas mixture before damaging the tank
	var/max_pressure = 46000
	/// The typepath of the gas this tank should be filled with.
	var/gas_type = null

	///Reference to the gas mix inside the tank
	var/datum/gas_mixture/air_contents

	/// The sounds that play when the tank is breaking from overpressure
	var/static/list/breaking_sounds = list(
		'sound/effects/structure_stress/pop1.ogg',
		'sound/effects/structure_stress/pop2.ogg',
		'sound/effects/structure_stress/pop3.ogg',
	)

	/// Shared images for the knob overlay representing a side of the tank that is open to connections
	var/static/list/knob_overlays

	/// Number of crack states to fill the list with. This exists because I'm lazy and didn't want to keeping adding more things manually to the below list.
	var/crack_states_count = 10
	/// The icon states for the cracks in the tank dmi
	var/static/list/crack_states

	/// The merger id used to create/get the merger group in charge of handling tanks that share an internal gas storage
	var/merger_id = "stationary_tanks"
	/// The typecache of types which are allowed to merge internal storage
	var/static/list/merger_typecache

/obj/machinery/atmospherics/components/tank/get_ru_names()
	return list(
		NOMINATIVE = "газовый бак",
		GENITIVE = "газового бака",
		DATIVE = "газовому баку",
		ACCUSATIVE = "газовый бак",
		INSTRUMENTAL = "газовым баком",
		PREPOSITIONAL = "газовом баке",
	)

/obj/machinery/atmospherics/components/tank/Initialize(mapload)
	. = ..()

	if(!knob_overlays)
		knob_overlays = list()
		for(var/dir in GLOB.cardinals)
			knob_overlays["[dir]"] = image('icons/obj/pipes_n_cables/stationary_canisters_misc.dmi', icon_state = "knob", dir = dir, layer = FLOAT_LAYER)

	if(!crack_states)
		crack_states = list()
		for(var/i in 1 to crack_states_count)
			crack_states += "crack[i]"

	if(!merger_typecache)
		merger_typecache = typecacheof(/obj/machinery/atmospherics/components/tank)

	AddComponent(/datum/component/gas_leaker, leak_rate = 0.05)
	AddElement(/datum/element/volatile_gas_storage)
	AddElement(/datum/element/crackable, 'icons/obj/pipes_n_cables/stationary_canisters_misc.dmi', crack_states)

	RegisterSignal(src, COMSIG_MERGER_ADDING, PROC_REF(merger_adding))
	RegisterSignal(src, COMSIG_MERGER_REMOVING, PROC_REF(merger_removing))
	RegisterSignal(src, COMSIG_ATOM_SMOOTHED_ICON, PROC_REF(smoothed))

	air_contents = new
	air_contents.temperature = T20C
	air_contents.volume = volume

	if(gas_type)
		fill_to_pressure(gas_type)

	QUEUE_SMOOTH(src)
	QUEUE_SMOOTH_NEIGHBORS(src)

	// Mapped in tanks should automatically connect to adjacent pipenets in the direction set in dir
	if(mapload)
		set_portdir_relative(dir, TRUE)
		set_init_directions()

	return INITIALIZE_HINT_LATELOAD

// We late initialize here so all stationary tanks have time to set up their
// initial gas mixes and signal registrations.
/obj/machinery/atmospherics/components/tank/post_machine_initialize()
	. = ..()
	GetMergeGroup(merger_id, merger_typecache)

/obj/machinery/atmospherics/components/tank/Destroy()
	QUEUE_SMOOTH_NEIGHBORS(src)
	return ..()

/obj/machinery/atmospherics/components/tank/examine(mob/user, thats)
	. = ..()
	var/wrench_hint = EXAMINE_HINT("гаечным ключом")
	if(!initialize_directions)
		. += span_notice("Порт трубы можно открыть [wrench_hint].")
	else
		. += span_notice("Порт трубы можно переместить или закрыть [wrench_hint].")
	. += span_notice("Голографическая наклейка на боку гласит, что максимальное безопасное давление составляет: [siunit_pressure(max_pressure, 0)].")

/obj/machinery/atmospherics/components/tank/finalize_material_effects(list/materials)
	. = ..()
	refresh_pressure_limit()

/// Recalculates pressure based on the current max integrity compared to original
/obj/machinery/atmospherics/components/tank/proc/refresh_pressure_limit()
	var/max_pressure_multiplier = max_integrity / initial(max_integrity)
	max_pressure = max_pressure_multiplier * initial(max_pressure)

/// Fills the tank to the maximum safe pressure.
/// Safety margin is a multiplier for the cap for the purpose of this proc so it doesn't have to be filled completely.
/obj/machinery/atmospherics/components/tank/proc/fill_to_pressure(gastype, safety_margin = 0.5)
	var/pressure_limit = max_pressure * safety_margin

	var/moles_to_add = (pressure_limit * air_contents.volume) / (R_IDEAL_GAS_EQUATION * air_contents.temperature)
	air_contents.assert_gas(gastype)
	air_contents.gases[gastype][MOLES] += moles_to_add
	air_contents.archive()

/obj/machinery/atmospherics/components/tank/process_atmos()
	if(air_contents.react(src))
		update_parents()

	if(air_contents.return_pressure() > max_pressure)
		take_damage(0.1, BRUTE, sound_effect = FALSE)
		if(prob(40))
			playsound(src, pick(breaking_sounds), 30, vary = TRUE)

	refresh_window()

///////////////////////////////////////////////////////////////////
// Port stuff

/**
 * Enables/Disables a port direction in var/open_ports. \
 * Use this, then call set_init_directions() instead of setting initialize_directions directly \
 * This system exists because tanks not having all initialize_directions set correctly breaks shuttle rotations
 */
/obj/machinery/atmospherics/components/tank/proc/set_portdir_relative(relative_port_dir, enable)
	ASSERT(!isnull(enable), "Did not receive argument enable")

	// Rotate the given dir so that it's relative to north
	var/port_dir
	if(dir == NORTH) // We're already facing north, no rotation needed
		port_dir = relative_port_dir
	else
		var/offnorth_angle = dir2angle(dir)
		port_dir = turn(relative_port_dir, offnorth_angle)

	if(enable)
		open_ports |= port_dir
	else
		open_ports &= ~port_dir

/**
 * Toggles a port direction in var/open_ports \
 * Use this, then call set_init_directions() instead of setting initialize_directions directly \
 * This system exists because tanks not having all initialize_directions set correctly breaks shuttle rotations
 */
/obj/machinery/atmospherics/components/tank/proc/toggle_portdir_relative(relative_port_dir)
	var/toggle = ((initialize_directions & relative_port_dir) ? FALSE : TRUE)
	set_portdir_relative(relative_port_dir, toggle)

/obj/machinery/atmospherics/components/tank/set_init_directions()
	if(!open_ports)
		initialize_directions = NONE
		return

	//We're rotating open_ports relative to dir, and
	//setting initialize_directions to that rotated dir
	var/relative_port_dirs = NONE
	var/dir_angle = dir2angle(dir)
	for(var/cardinal in GLOB.cardinals)
		var/current_dir = cardinal & open_ports
		if(!current_dir)
			continue

		var/rotated_dir = turn(current_dir, -dir_angle)
		relative_port_dirs |= rotated_dir

	initialize_directions = relative_port_dirs

/obj/machinery/atmospherics/components/tank/proc/toggle_side_port(port_dir)
	toggle_portdir_relative(port_dir)
	set_init_directions()

	for(var/i in 1 to length(nodes))
		var/obj/machinery/atmospherics/components/node = nodes[i]
		if(!node)
			continue
		if(src in node.nodes)
			node.disconnect(src)
		nodes[i] = null
		if(parents[i])
			nullify_pipenet(parents[i])

	atmos_init()

	for(var/obj/machinery/atmospherics/components/node as anything in nodes)
		if(!node)
			continue
		node.atmos_init()
		node.add_member(src)
	SSair.add_to_rebuild_queue(src)

	update_parents()

///////////////////////////////////////////////////////////////////
// Pipenet stuff

/obj/machinery/atmospherics/components/tank/return_analyzable_air()
	return air_contents

/obj/machinery/atmospherics/components/tank/return_airs_for_reconcilation(datum/pipeline/requester)
	. = ..()
	if(!air_contents)
		return
	. += air_contents

/obj/machinery/atmospherics/components/tank/return_pipenets_for_reconcilation(datum/pipeline/requester)
	. = ..()
	var/datum/merger/merge_group = GetMergeGroup(merger_id, merger_typecache)
	for(var/obj/machinery/atmospherics/components/tank/tank as anything in merge_group.members)
		. += tank.parents

///////////////////////////////////////////////////////////////////
// Merger handling

/obj/machinery/atmospherics/components/tank/proc/merger_adding(obj/machinery/atmospherics/components/tank/us, datum/merger/new_merger)
	SIGNAL_HANDLER
	if(new_merger.id != merger_id)
		return
	RegisterSignal(new_merger, COMSIG_MERGER_REFRESH_COMPLETE, PROC_REF(merger_refresh_complete))

/obj/machinery/atmospherics/components/tank/proc/merger_removing(obj/machinery/atmospherics/components/tank/us, datum/merger/old_merger)
	SIGNAL_HANDLER
	if(old_merger.id != merger_id)
		return
	UnregisterSignal(old_merger, COMSIG_MERGER_REFRESH_COMPLETE)

/// Handles the combined gas tank for the entire merger group, only the origin tank actualy runs this.
/obj/machinery/atmospherics/components/tank/proc/merger_refresh_complete(datum/merger/merger, list/leaving_members, list/joining_members)
	SIGNAL_HANDLER
	if(merger.origin != src)
		return
	var/shares = length(merger.members) + length(leaving_members) - length(joining_members)
	for(var/obj/machinery/atmospherics/components/tank/leaver as anything in leaving_members)
		var/datum/gas_mixture/gas_share = air_contents.remove_ratio(1 / shares--)
		air_contents.volume -= leaver.volume
		leaver.air_contents = gas_share
		leaver.update_appearance(UPDATE_ICON)

	for(var/obj/machinery/atmospherics/components/tank/joiner as anything in joining_members)
		if(joiner == src)
			continue
		var/datum/gas_mixture/joiner_share = joiner.air_contents
		if(joiner_share)
			air_contents.merge(joiner_share)
		joiner.air_contents = air_contents
		air_contents.volume += joiner.volume
		joiner.update_appearance(UPDATE_ICON)

	for(var/dir in GLOB.cardinals)
		if(dir & initialize_directions & merger.members[src])
			toggle_side_port(dir)

///////////////////////////////////////////////////////////////////
// Appearance stuff

/obj/machinery/atmospherics/components/tank/proc/smoothed()
	SIGNAL_HANDLER
	refresh_window()

/obj/machinery/atmospherics/components/tank/update_appearance()
	. = ..()
	refresh_window()

/obj/machinery/atmospherics/components/tank/update_overlays()
	. = ..()
	if(!initialize_directions)
		return
	for(var/dir in GLOB.cardinals)
		if(initialize_directions & dir)
			. += knob_overlays["[dir]"]

/obj/machinery/atmospherics/components/tank/update_greyscale()
	. = ..()
	refresh_window()

/obj/machinery/atmospherics/components/tank/proc/refresh_window()
	cut_overlay(window)

	if(!air_contents)
		window = null
		return
	var/icon/greyscaled_icon = SSgreyscale.GetColoredIconByType(overlay_greyscale_config, greyscale_colors)

	window = image(greyscaled_icon, icon_state = "window-bg", layer = FLOAT_LAYER)

	var/static/alpha_filter
	if(!alpha_filter) // Gotta do this separate since the icon may not be correct at world init
		alpha_filter = filter(type="alpha", icon = icon('icons/obj/pipes_n_cables/stationary_canisters_misc.dmi', "window-bg"))

	var/list/new_underlays = list()
	for(var/obj/effect/overlay/gas/gas as anything in air_contents.return_visuals(get_turf(src)))
		var/image/new_underlay = image(gas.icon, icon_state = gas.icon_state, layer = FLOAT_LAYER)
		new_underlay.filters = alpha_filter
		new_underlays += new_underlay

	var/image/foreground = image(greyscaled_icon, icon_state = "window-fg", layer = FLOAT_LAYER)
	foreground.underlays = new_underlays
	window.overlays = list(foreground)

	add_overlay(window)

///////////////////////////////////////////////////////////////////
// Tool interactions

/obj/machinery/atmospherics/components/tank/wrench_act(mob/living/user, obj/item/item)
	. = TRUE
	var/new_dir = get_dir(src, user)

	if(new_dir in GLOB.diagonals)
		return

	item.play_tool_sound(src, 10)
	if(!item.use_tool(src, user, 3 SECONDS))
		return

	toggle_side_port(new_dir)

	item.play_tool_sound(src, 50)

/obj/machinery/atmospherics/components/tank/welder_act(mob/living/user, obj/item/tool)
	. = ..()
	. = TRUE
	if(atom_integrity >= max_integrity)
		return
	if(!tool.tool_start_check(user, amount = 0, heat_required = HIGH_TEMPERATURE_REQUIRED))
		return
	to_chat(user, span_notice("Вы начинаете заделывать трещины в газовом баке..."))
	var/repair_amount = max_integrity / 10
	do
		if(!tool.use_tool(src, user, 2.5 SECONDS, volume = 40))
			return
	while(repair_damage(repair_amount))
	to_chat(user, span_notice("Газовый бак полностью отремонтирован, все трещины заделаны."))

/obj/machinery/atmospherics/components/tank/welder_act_secondary(mob/living/user, obj/item/tool)
	. = ..()
	. = TRUE
	to_chat(user, span_notice("Вы начинаете разрезать газовый бак..."))
	var/turf/current_location = get_turf(src)
	var/datum/gas_mixture/airmix = current_location.return_air()

	var/time_taken = 4 SECONDS
	var/unsafe = FALSE

	var/internal_pressure = air_contents.return_pressure() - airmix.return_pressure()
	if(internal_pressure > 2 * ONE_ATMOSPHERE)
		time_taken *= 2
		to_chat(user, span_warning("Бак, похоже, находится под давлением, вы уверены, что это хорошая идея?"))
		unsafe = TRUE

	if(!tool.use_tool(src, user, time_taken, volume = 60))
		return

	if(unsafe)
		unsafe_pressure_release(user, internal_pressure)
	deconstruct(disassembled=TRUE)
	to_chat(user, span_notice("Вы заканчиваете разрезать запечатанный газовый бак, открывая его внутренности."))

/obj/machinery/atmospherics/components/tank/on_deconstruction(disassembled)
	var/turf/location = drop_location()
	. = ..()
	location.assume_air(air_contents)
	if(!disassembled)
		return
	var/obj/structure/tank_frame/frame = new(location)
	frame.construction_state = TANK_PLATING_UNSECURED
	for(var/datum/material/material as anything in custom_materials)
		if (frame.material_end_product)
			// If something looks fishy, you get nothing
			message_admins("\The [src] had multiple materials set. Unless you were messing around with VV, yell at a coder")
			frame.material_end_product = null
			frame.construction_state = TANK_FRAME
			break
		else
			frame.material_end_product = material
	frame.update_appearance(UPDATE_ICON)

///////////////////////////////////////////////////////////////////
// Gas tank variants

/obj/machinery/atmospherics/components/tank/air
	name = "pressure tank (Air)"
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/machinery/atmospherics/components/tank/air/get_ru_names()
	return list(
		NOMINATIVE = "газовый бак (Воздух)",
		GENITIVE = "газового бака (Воздух)",
		DATIVE = "газовому баку (Воздух)",
		ACCUSATIVE = "газовый бак (Воздух)",
		INSTRUMENTAL = "газовым баком (Воздух)",
		PREPOSITIONAL = "газовом баке (Воздух)",
	)

/obj/machinery/atmospherics/components/tank/air/layer1
	piping_layer = 1

/obj/machinery/atmospherics/components/tank/air/layer2
	piping_layer = 2

/obj/machinery/atmospherics/components/tank/air/layer4
	piping_layer = 4

/obj/machinery/atmospherics/components/tank/air/layer5
	piping_layer = 5

/obj/machinery/atmospherics/components/tank/air/Initialize(mapload)
	. = ..()
	fill_to_pressure(/datum/gas/oxygen, safety_margin = (O2STANDARD * 0.5))
	fill_to_pressure(/datum/gas/nitrogen, safety_margin = (N2STANDARD * 0.5))

/obj/machinery/atmospherics/components/tank/carbon_dioxide
	gas_type = /datum/gas/carbon_dioxide
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/machinery/atmospherics/components/tank/carbon_dioxide/get_ru_names()
	return list(
		NOMINATIVE = "газовый бак (Диоксид углерода)",
		GENITIVE = "газового бака (Диоксид углерода)",
		DATIVE = "газовому баку (Диоксид углерода)",
		ACCUSATIVE = "газовый бак (Диоксид углерода)",
		INSTRUMENTAL = "газовым баком (Диоксид углерода)",
		PREPOSITIONAL = "газовом баке (Диоксид углерода)",
	)

/obj/machinery/atmospherics/components/tank/plasma
	gas_type = /datum/gas/plasma
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/machinery/atmospherics/components/tank/plasma/get_ru_names()
	return list(
		NOMINATIVE = "газовый бак (Плазма)",
		GENITIVE = "газового бака (Плазма)",
		DATIVE = "газовому баку (Плазма)",
		ACCUSATIVE = "газовый бак (Плазма)",
		INSTRUMENTAL = "газовым баком (Плазма)",
		PREPOSITIONAL = "газовом баке (Плазма)",
	)

/obj/machinery/atmospherics/components/tank/nitrogen
	gas_type = /datum/gas/nitrogen
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/machinery/atmospherics/components/tank/nitrogen/get_ru_names()
	return list(
		NOMINATIVE = "газовый бак (Азот)",
		GENITIVE = "газового бака (Азот)",
		DATIVE = "газовому баку (Азот)",
		ACCUSATIVE = "газовый бак (Азот)",
		INSTRUMENTAL = "газовым баком (Азот)",
		PREPOSITIONAL = "газовом баке (Азот)",
	)

/obj/machinery/atmospherics/components/tank/oxygen
	gas_type = /datum/gas/oxygen
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/machinery/atmospherics/components/tank/oxygen/get_ru_names()
	return list(
		NOMINATIVE = "газовый бак (Кислород)",
		GENITIVE = "газового бака (Кислород)",
		DATIVE = "газовому баку (Кислород)",
		ACCUSATIVE = "газовый бак (Кислород)",
		INSTRUMENTAL = "газовым баком (Кислород)",
		PREPOSITIONAL = "газовом баке (Кислород)",
	)

/obj/machinery/atmospherics/components/tank/nitrous
	gas_type = /datum/gas/nitrous_oxide
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/machinery/atmospherics/components/tank/nitrous/get_ru_names()
	return list(
		NOMINATIVE = "газовый бак (Оксид азота)",
		GENITIVE = "газового бака (Оксид азота)",
		DATIVE = "газовому баку (Оксид азота)",
		ACCUSATIVE = "газовый бак (Оксид азота)",
		INSTRUMENTAL = "газовым баком (Оксид азота)",
		PREPOSITIONAL = "газовом баке (Оксид азота)",
	)

/obj/machinery/atmospherics/components/tank/bz
	gas_type = /datum/gas/bz
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/machinery/atmospherics/components/tank/bz/get_ru_names()
	return list(
		NOMINATIVE = "газовый бак (BZ)",
		GENITIVE = "газового бака (BZ)",
		DATIVE = "газовому баку (BZ)",
		ACCUSATIVE = "газовый бак (BZ)",
		INSTRUMENTAL = "газовым баком (BZ)",
		PREPOSITIONAL = "газовом баке (BZ)",
	)

/obj/machinery/atmospherics/components/tank/freon
	gas_type = /datum/gas/freon
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/machinery/atmospherics/components/tank/freon/get_ru_names()
	return list(
		NOMINATIVE = "газовый бак (Фреон)",
		GENITIVE = "газового бака (Фреон)",
		DATIVE = "газовому баку (Фреон)",
		ACCUSATIVE = "газовый бак (Фреон)",
		INSTRUMENTAL = "газовым баком (Фреон)",
		PREPOSITIONAL = "газовом баке (Фреон)",
	)

/obj/machinery/atmospherics/components/tank/halon
	gas_type = /datum/gas/halon
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/machinery/atmospherics/components/tank/halon/get_ru_names()
	return list(
		NOMINATIVE = "газовый бак (Галон)",
		GENITIVE = "газового бака (Галон)",
		DATIVE = "газовому баку (Галон)",
		ACCUSATIVE = "газовый бак (Галон)",
		INSTRUMENTAL = "газовым баком (Галон)",
		PREPOSITIONAL = "газовом баке (Галон)",
	)

/obj/machinery/atmospherics/components/tank/healium
	gas_type = /datum/gas/healium
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/machinery/atmospherics/components/tank/healium/get_ru_names()
	return list(
		NOMINATIVE = "газовый бак (Хилиум)",
		GENITIVE = "газового бака (Хилиум)",
		DATIVE = "газовому баку (Хилиум)",
		ACCUSATIVE = "газовый бак (Хилиум)",
		INSTRUMENTAL = "газовым баком (Хилиум)",
		PREPOSITIONAL = "газовом баке (Хилиум)",
	)

/obj/machinery/atmospherics/components/tank/hydrogen
	gas_type = /datum/gas/hydrogen
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/machinery/atmospherics/components/tank/hydrogen/get_ru_names()
	return list(
		NOMINATIVE = "газовый бак (Водород)",
		GENITIVE = "газового бака (Водород)",
		DATIVE = "газовому баку (Водород)",
		ACCUSATIVE = "газовый бак (Водород)",
		INSTRUMENTAL = "газовым баком (Водород)",
		PREPOSITIONAL = "газовом баке (Водород)",
	)

/obj/machinery/atmospherics/components/tank/hypernoblium
	gas_type = /datum/gas/hypernoblium
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/machinery/atmospherics/components/tank/hypernoblium/get_ru_names()
	return list(
		NOMINATIVE = "газовый бак (Гиперноблий)",
		GENITIVE = "газового бака (Гиперноблий)",
		DATIVE = "газовому баку (Гиперноблий)",
		ACCUSATIVE = "газовый бак (Гиперноблий)",
		INSTRUMENTAL = "газовым баком (Гиперноблий)",
		PREPOSITIONAL = "газовом баке (Гиперноблий)",
	)

/obj/machinery/atmospherics/components/tank/miasma
	gas_type = /datum/gas/miasma
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/machinery/atmospherics/components/tank/miasma/get_ru_names()
	return list(
		NOMINATIVE = "газовый бак (Миазмы)",
		GENITIVE = "газового бака (Миазмы)",
		DATIVE = "газовому баку (Миазмы)",
		ACCUSATIVE = "газовый бак (Миазмы)",
		INSTRUMENTAL = "газовым баком (Миазмы)",
		PREPOSITIONAL = "газовом баке (Миазмы)",
	)

/obj/machinery/atmospherics/components/tank/nitrium
	gas_type = /datum/gas/nitrium
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/machinery/atmospherics/components/tank/nitrium/get_ru_names()
	return list(
		NOMINATIVE = "газовый бак (Нитриум)",
		GENITIVE = "газового бака (Нитриум)",
		DATIVE = "газовому баку (Нитриум)",
		ACCUSATIVE = "газовый бак (Нитриум)",
		INSTRUMENTAL = "газовым баком (Нитриум)",
		PREPOSITIONAL = "газовом баке (Нитриум)",
	)

/obj/machinery/atmospherics/components/tank/pluoxium
	gas_type = /datum/gas/pluoxium
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/machinery/atmospherics/components/tank/pluoxium/get_ru_names()
	return list(
		NOMINATIVE = "газовый бак (Плюоксиум)",
		GENITIVE = "газового бака (Плюоксиум)",
		DATIVE = "газовому баку (Плюоксиум)",
		ACCUSATIVE = "газовый бак (Плюоксиум)",
		INSTRUMENTAL = "газовым баком (Плюоксиум)",
		PREPOSITIONAL = "газовом баке (Плюоксиум)",
	)

/obj/machinery/atmospherics/components/tank/proto_nitrate
	gas_type = /datum/gas/proto_nitrate
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/machinery/atmospherics/components/tank/proto_nitrate/get_ru_names()
	return list(
		NOMINATIVE = "газовый бак (Протонитрат)",
		GENITIVE = "газового бака (Протонитрат)",
		DATIVE = "газовому баку (Протонитрат)",
		ACCUSATIVE = "газовый бак (Протонитрат)",
		INSTRUMENTAL = "газовым баком (Протонитрат)",
		PREPOSITIONAL = "газовом баке (Протонитрат)",
	)

/obj/machinery/atmospherics/components/tank/tritium
	gas_type = /datum/gas/tritium
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/machinery/atmospherics/components/tank/tritium/get_ru_names()
	return list(
		NOMINATIVE = "газовый бак (Тритий)",
		GENITIVE = "газового бака (Тритий)",
		DATIVE = "газовому баку (Тритий)",
		ACCUSATIVE = "газовый бак (Тритий)",
		INSTRUMENTAL = "газовым баком (Тритий)",
		PREPOSITIONAL = "газовом баке (Тритий)",
	)

/obj/machinery/atmospherics/components/tank/water_vapor
	gas_type = /datum/gas/water_vapor
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/machinery/atmospherics/components/tank/water_vapor/get_ru_names()
	return list(
		NOMINATIVE = "газовый бак (Водяной пар)",
		GENITIVE = "газового бака (Водяной пар)",
		DATIVE = "газовому баку (Водяной пар)",
		ACCUSATIVE = "газовый бак (Водяной пар)",
		INSTRUMENTAL = "газовым баком (Водяной пар)",
		PREPOSITIONAL = "газовом баке (Водяной пар)",
	)

/obj/machinery/atmospherics/components/tank/zauker
	gas_type = /datum/gas/zauker
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/machinery/atmospherics/components/tank/zauker/get_ru_names()
	return list(
		NOMINATIVE = "газовый бак (Заукер)",
		GENITIVE = "газового бака (Заукер)",
		DATIVE = "газовому баку (Заукер)",
		ACCUSATIVE = "газовый бак (Заукер)",
		INSTRUMENTAL = "газовым баком (Заукер)",
		PREPOSITIONAL = "газовом баке (Заукер)",
	)

/obj/machinery/atmospherics/components/tank/helium
	gas_type = /datum/gas/helium
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/machinery/atmospherics/components/tank/helium/get_ru_names()
	return list(
		NOMINATIVE = "газовый бак (Гелий)",
		GENITIVE = "газового бака (Гелий)",
		DATIVE = "газовому баку (Гелий)",
		ACCUSATIVE = "газовый бак (Гелий)",
		INSTRUMENTAL = "газовым баком (Гелий)",
		PREPOSITIONAL = "газовом баке (Гелий)",
	)

/obj/machinery/atmospherics/components/tank/antinoblium
	gas_type = /datum/gas/antinoblium
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/machinery/atmospherics/components/tank/antinoblium/get_ru_names()
	return list(
		NOMINATIVE = "газовый бак (Антиноблий)",
		GENITIVE = "газового бака (Антиноблий)",
		DATIVE = "газовому баку (Антиноблий)",
		ACCUSATIVE = "газовый бак (Антиноблий)",
		INSTRUMENTAL = "газовым баком (Антиноблий)",
		PREPOSITIONAL = "газовом баке (Антиноблий)",
	)

///////////////////////////////////////////////////////////////////
// Tank Frame Structure

/obj/structure/tank_frame
	icon = 'icons/obj/pipes_n_cables/stationary_canisters_misc.dmi'
	icon_state = "frame"
	anchored = FALSE
	density = TRUE
	custom_materials = list(/datum/material/alloy/plasteel = 4 * SHEET_MATERIAL_AMOUNT)
	var/construction_state = TANK_FRAME
	var/datum/material/material_end_product

/obj/structure/tank_frame/get_ru_names()
	return list(
		NOMINATIVE = "каркас бака",
		GENITIVE = "каркаса бака",
		DATIVE = "каркасу бака",
		ACCUSATIVE = "каркас бака",
		INSTRUMENTAL = "каркасом бака",
		PREPOSITIONAL = "каркасе бака",
	)

/obj/structure/tank_frame/examine(mob/user)
	. = ..()
	var/wrenched_hint = EXAMINE_HINT("прикручен")

	if(!anchored)
		. += span_notice("[src] ещё не [wrenched_hint] к полу.")
	else
		. += span_notice("[src] [wrenched_hint] к полу.")

	switch(construction_state)
		if(TANK_FRAME)
			var/screwed_hint = EXAMINE_HINT("свинчен")
			var/plating_hint = EXAMINE_HINT("металлических листов")
			. += span_notice("[src] [screwed_hint] и теперь требует [plating_hint].")
		if(TANK_PLATING_UNSECURED)
			var/crowbar_hint = EXAMINE_HINT("лом")
			var/welder_hint = EXAMINE_HINT("сварка")
			. += span_notice("Обшивка надежно закреплена и потребует [crowbar_hint] для отсоединения, но всё ещё нуждается в заварке [welder_hint].")

/obj/structure/tank_frame/atom_deconstruct(disassembled)
	if(disassembled)
		for(var/datum/material/mat as anything in custom_materials)
			new mat.sheet_type(drop_location(), custom_materials[mat] / SHEET_MATERIAL_AMOUNT)

/obj/structure/tank_frame/update_icon(updates)
	. = ..()
	switch(construction_state)
		if(TANK_FRAME)
			icon_state = "frame"
		if(TANK_PLATING_UNSECURED)
			icon_state = "plated_frame"

/obj/structure/tank_frame/attackby(obj/item/item, mob/living/user, list/modifiers, list/attack_modifiers)
	if(construction_state == TANK_FRAME && isstack(item) && add_plating(user, item))
		return
	return ..()

/obj/structure/tank_frame/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	default_unfasten_wrench(user, tool, time = 0.5 SECONDS)
	return ITEM_INTERACT_SUCCESS

/obj/structure/tank_frame/screwdriver_act_secondary(mob/living/user, obj/item/tool)
	. = ..()
	if(construction_state != TANK_FRAME)
		return
	. = TRUE
	to_chat(user, span_notice("Вы начинаете разбирать [declent_ru(ACCUSATIVE)]."))
	if(!tool.use_tool(src, user, 1 SECONDS))
		return
	deconstruct(TRUE)
	to_chat(user, span_notice("[src] разобран."))

/obj/structure/tank_frame/proc/add_plating(mob/living/user, obj/item/stack/stack)
	. = FALSE
	if(!stack.material_type)
		balloon_alert(user, "неподходящий материал!")
	var/datum/material/stack_mat = GET_MATERIAL_REF(stack.material_type)
	if(!(MAT_CATEGORY_RIGID in stack_mat.categories))
		to_chat(user, span_notice("Этот материал кажется недостаточно жёстким, чтобы держать форму бака..."))
		return

	. = TRUE
	to_chat(user, span_notice("Вы начинаете добавлять [stack] к [declent_ru(DATIVE)]..."))
	if(!stack.use_tool(src, user, 3 SECONDS))
		return
	if(!stack.use(TANK_PLATING_SHEETS))
		var/amount_more
		switch(100 * stack.amount / TANK_PLATING_SHEETS)
			if(0) // Wat?
				amount_more = "хоть сколько-то"
			if(1 to 25)
				amount_more = "намного больше"
			if(26 to 50)
				amount_more = "примерно в четыре раза больше"
			if(51 to 75)
				amount_more = "примерно в два раза больше"
			if(76 to 100)
				amount_more = "совсем немного больше"
			else
				amount_more = "неопределённое количество"
		to_chat(user, span_notice("У вас недостаточно [stack.declent_ru(GENITIVE)], чтобы добавить всю обшивку. Может, нужно [amount_more]."))
		return

	material_end_product = stack_mat
	construction_state = TANK_PLATING_UNSECURED
	update_appearance(UPDATE_ICON)
	to_chat(user, span_notice("Вы заканчиваете прикреплять [stack] к [declent_ru(DATIVE)]."))

/obj/structure/tank_frame/crowbar_act_secondary(mob/living/user, obj/item/tool)
	. = ..()
	if(construction_state != TANK_PLATING_UNSECURED)
		return
	. = TRUE
	to_chat(user, span_notice("Вы начинаете отрывать внешнюю обшивку..."))
	if(!tool.use_tool(src, user, 2 SECONDS))
		return
	construction_state = TANK_FRAME
	new material_end_product.sheet_type(drop_location(), TANK_PLATING_SHEETS)
	material_end_product = null
	update_appearance(UPDATE_ICON)

/obj/structure/tank_frame/welder_act(mob/living/user, obj/item/tool)
	. = ..()
	if(construction_state != TANK_PLATING_UNSECURED)
		return
	. = TRUE
	if(!anchored)
		to_chat(user, span_notice("Вам нужно <b>прикрутить</b> [declent_ru(ACCUSATIVE)] к полу, прежде чем закончить."))
		return
	if(!tool.tool_start_check(user, amount = 0, heat_required = HIGH_TEMPERATURE_REQUIRED))
		return
	to_chat(user, span_notice("Вы начинаете заваривать внешнюю обшивку сваркой..."))
	if(!tool.use_tool(src, user, 2 SECONDS, volume = 60))
		return

	var/turf/build_location = drop_location()
	if(!isturf(build_location))
		return
	var/obj/machinery/atmospherics/components/tank/new_tank = new(build_location)
	var/list/new_custom_materials = list((material_end_product) = TANK_PLATING_SHEETS * SHEET_MATERIAL_AMOUNT)
	new_tank.set_custom_materials(new_custom_materials)
	new_tank.on_construction(user, new_tank.pipe_color, new_tank.piping_layer)
	to_chat(user, span_notice("[new_tank] запечатан и готов к приёму газов."))
	qdel(src)

#undef TANK_PLATING_SHEETS
