/* Types of tanks!
 * Contains:
 * Oxygen
 * Anesthetic
 * Air
 * Plasma
 * Emergency Oxygen
 * Generic
 */
/obj/item/tank/internals
	interaction_flags_click = FORBID_TELEKINESIS_REACH|NEED_HANDS|ALLOW_RESTING


/// Allows carbon to toggle internals via AltClick of the equipped tank.
/obj/item/tank/internals/click_alt(mob/user)
	toggle_internals(user)
	return CLICK_ACTION_SUCCESS

/obj/item/tank/internals/examine(mob/user)
	. = ..()
	. += span_notice("[EXAMINE_HINT("Альт-клик")] по баку, чтобы переключить клапан.")

/*
 * Oxygen
 */
/obj/item/tank/internals/oxygen
	name = "oxygen tank"
	desc = "Бак с кислородом, этот синий."
	icon_state = "oxygen"
	inhand_icon_state = "oxygen_tank"
	tank_holder_icon_state = "holder_oxygen"
	distribute_pressure = TANK_DEFAULT_RELEASE_PRESSURE
	force = 10
	dog_fashion = /datum/dog_fashion/back

/obj/item/tank/internals/oxygen/get_ru_names()
	return alist(
		NOMINATIVE = "кислородный бак",
		GENITIVE = "кислородного бака",
		DATIVE = "кислородному баку",
		ACCUSATIVE = "кислородный бак",
		INSTRUMENTAL = "кислородным баком",
		PREPOSITIONAL = "кислородном баке",
	)

/obj/item/tank/internals/oxygen/populate_gas()
	air_contents.assert_gas(/datum/gas/oxygen)
	air_contents.gases[/datum/gas/oxygen][MOLES] = (6*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)


/obj/item/tank/internals/oxygen/yellow
	desc = "Бак с кислородом, этот жёлтый."
	icon_state = "oxygen_f"
	inhand_icon_state = "oxygen_f_tank"
	tank_holder_icon_state = "holder_oxygen_f"
	dog_fashion = null

/obj/item/tank/internals/oxygen/red
	desc = "Бак с кислородом, этот красный."
	icon_state = "oxygen_fr"
	inhand_icon_state = "oxygen_fr_tank"
	tank_holder_icon_state = "holder_oxygen_fr"
	dog_fashion = null

/obj/item/tank/internals/oxygen/empty/populate_gas()
	return

/*
 * Anesthetic
 */
/obj/item/tank/internals/anesthetic
	name = "anesthetic tank"
	desc = "Бак со смесью газов N2O/O2."
	icon_state = "anesthetic"
	inhand_icon_state = "an_tank"
	tank_holder_icon_state = "holder_anesthetic"
	force = 10

/obj/item/tank/internals/anesthetic/get_ru_names()
	return alist(
		NOMINATIVE = "бак анестетика",
		GENITIVE = "бака анестетика",
		DATIVE = "баку анестетика",
		ACCUSATIVE = "бак анестетика",
		INSTRUMENTAL = "баком анестетика",
		PREPOSITIONAL = "баке анестетика",
	)

/obj/item/tank/internals/anesthetic/populate_gas()
	air_contents.assert_gases(/datum/gas/oxygen, /datum/gas/nitrous_oxide)
	air_contents.gases[/datum/gas/oxygen][MOLES] = (3*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * O2STANDARD
	air_contents.gases[/datum/gas/nitrous_oxide][MOLES] = (3*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * N2STANDARD

/obj/item/tank/internals/anesthetic/examine(mob/user)
	. = ..()
	. += span_notice("На [RU_SRC_PRE] выгравировано предупреждение...")
	. += span_warning("В организме нет процессов, использующих N2O, поэтому пациенты будут выдыхать N2O... подвергая вас его воздействию. Убедитесь, что работаете в хорошо проветриваемом помещении, чтобы избежать сонных инцидентов.")

/obj/item/tank/internals/anesthetic/pure
	desc = "Бак с чистым N2O. На бак грубо наклеена наклейка с предупреждением."
	icon_state = "anesthetic_warning"

/obj/item/tank/internals/anesthetic/pure/populate_gas()
	air_contents.assert_gases(/datum/gas/nitrous_oxide)
	air_contents.gases[/datum/gas/nitrous_oxide][MOLES] = (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)

/*
 * Plasma
 */
/obj/item/tank/internals/plasma
	name = "plasma tank"
	desc = "Содержит опасную плазму. Не вдыхать. Внимание: чрезвычайно легко воспламеняется."
	icon_state = "plasma"
	inhand_icon_state = "plasma_tank"
	worn_icon_state = "plasmatank"
	tank_holder_icon_state = null
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = null //they have no straps!
	force = 8

/obj/item/tank/internals/plasma/get_ru_names()
	return alist(
		NOMINATIVE = "бак плазмы",
		GENITIVE = "бака плазмы",
		DATIVE = "баку плазмы",
		ACCUSATIVE = "бак плазмы",
		INSTRUMENTAL = "баком плазмы",
		PREPOSITIONAL = "баке плазмы",
	)

/obj/item/tank/internals/plasma/populate_gas()
	air_contents.assert_gas(/datum/gas/plasma)
	air_contents.gases[/datum/gas/plasma][MOLES] = (3*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)

/obj/item/tank/internals/plasma/attackby(obj/item/W, mob/user, list/modifiers, list/attack_modifiers)
	if(istype(W, /obj/item/flamethrower))
		var/obj/item/flamethrower/F = W
		if ((!F.status) || (F.ptank))
			return
		if(!user.transferItemToLoc(src, F))
			return
		src.master = F
		F.ptank = src
		F.update_appearance()
	else
		return ..()

/obj/item/tank/internals/plasma/full/populate_gas()
	air_contents.assert_gas(/datum/gas/plasma)
	air_contents.gases[/datum/gas/plasma][MOLES] = (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)

/obj/item/tank/internals/plasma/empty/populate_gas()
	return

/*
 * Plasmaman Plasma Tank
 */

/obj/item/tank/internals/plasmaman
	name = "plasma internals tank"
	desc = "Бак с газом плазмы, разработанный специально для использования в качестве дыхательного аппарата, в частности для плазменных форм жизни. Если вы не плазмамен, вам, вероятно, не следует это использовать."
	icon_state = "plasmaman_tank"
	inhand_icon_state = "plasmaman_tank"
	tank_holder_icon_state = null
	force = 10
	distribute_pressure = TANK_PLASMAMAN_RELEASE_PRESSURE

/obj/item/tank/internals/plasmaman/get_ru_names()
	return alist(
		NOMINATIVE = "дыхательный бак плазмы",
		GENITIVE = "дыхательного бака плазмы",
		DATIVE = "дыхательному баку плазмы",
		ACCUSATIVE = "дыхательный бак плазмы",
		INSTRUMENTAL = "дыхательным баком плазмы",
		PREPOSITIONAL = "дыхательном баке плазмы",
	)

/obj/item/tank/internals/plasmaman/populate_gas()
	air_contents.assert_gas(/datum/gas/plasma)
	air_contents.gases[/datum/gas/plasma][MOLES] = (3*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)

/obj/item/tank/internals/plasmaman/full/populate_gas()
	air_contents.assert_gas(/datum/gas/plasma)
	air_contents.gases[/datum/gas/plasma][MOLES] = (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)


/obj/item/tank/internals/plasmaman/belt
	icon_state = "plasmaman_tank_belt"
	inhand_icon_state = "plasmaman_tank_belt"
	worn_icon_state = "plasmaman_tank_belt"
	tank_holder_icon_state = null
	worn_icon = null
	slot_flags = ITEM_SLOT_BELT
	force = 5
	volume = 6 //same size as the engineering ones but plasmamen have special lungs that consume less plasma per breath
	w_class = WEIGHT_CLASS_SMALL //thanks i forgot this

/obj/item/tank/internals/plasmaman/belt/full/populate_gas()
	air_contents.assert_gas(/datum/gas/plasma)
	air_contents.gases[/datum/gas/plasma][MOLES] = (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)

/obj/item/tank/internals/plasmaman/belt/empty/populate_gas()
	return



/*
 * Emergency Oxygen
 */
/obj/item/tank/internals/emergency_oxygen
	name = "emergency oxygen tank"
	desc = "Используется в чрезвычайных ситуациях. Содержит очень мало кислорода, поэтому старайтесь экономить его, пока он вам действительно не понадобится."
	icon_state = "emergency"
	inhand_icon_state = "emergency_tank"
	worn_icon_state = "emergency"
	tank_holder_icon_state = "holder_emergency"
	worn_icon = null
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	force = 4
	distribute_pressure = TANK_DEFAULT_RELEASE_PRESSURE
	volume = 3 //Tiny. Real life equivalents only have 21 breaths of oxygen in them. They're EMERGENCY tanks anyway -errorage (dangercon 2011)

/obj/item/tank/internals/emergency_oxygen/get_ru_names()
	return alist(
		NOMINATIVE = "аварийный кислородный бак",
		GENITIVE = "аварийного кислородного бака",
		DATIVE = "аварийному кислородному баку",
		ACCUSATIVE = "аварийный кислородный бак",
		INSTRUMENTAL = "аварийным кислородным баком",
		PREPOSITIONAL = "аварийном кислородном баке",
	)

/obj/item/tank/internals/emergency_oxygen/populate_gas()
	air_contents.assert_gas(/datum/gas/oxygen)
	air_contents.gases[/datum/gas/oxygen][MOLES] = (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)


/obj/item/tank/internals/emergency_oxygen/empty/populate_gas()
	return

/obj/item/tank/internals/emergency_oxygen/engi
	name = "extended-capacity emergency oxygen tank"
	icon_state = "emergency_engi"
	inhand_icon_state = "emergency_engi_tank"
	worn_icon_state = "emergency_engi"
	tank_holder_icon_state = "holder_emergency_engi"
	worn_icon = null
	volume = 6 // should last 24 minutes if full

/obj/item/tank/internals/emergency_oxygen/engi/get_ru_names()
	return alist(
		NOMINATIVE = "аварийный кислородный бак увеличенной ёмкости",
		GENITIVE = "аварийного кислородного бака увеличенной ёмкости",
		DATIVE = "аварийному кислородному баку увеличенной ёмкости",
		ACCUSATIVE = "аварийный кислородный бак увеличенной ёмкости",
		INSTRUMENTAL = "аварийным кислородным баком увеличенной ёмкости",
		PREPOSITIONAL = "аварийном кислородном баке увеличенной ёмкости",
	)

/obj/item/tank/internals/emergency_oxygen/engi/empty/populate_gas()
	return

/obj/item/tank/internals/emergency_oxygen/double
	name = "double emergency oxygen tank"
	icon_state = "emergency_double"
	worn_icon_state = "emergency_engi"
	tank_holder_icon_state = "holder_emergency_engi"
	volume = 12 //If it's double of the above, shouldn't it be double the volume??

/obj/item/tank/internals/emergency_oxygen/double/get_ru_names()
	return alist(
		NOMINATIVE = "двойной аварийный кислородный бак",
		GENITIVE = "двойного аварийного кислородного бака",
		DATIVE = "двойному аварийному кислородному баку",
		ACCUSATIVE = "двойной аварийный кислородный бак",
		INSTRUMENTAL = "двойным аварийным кислородным баком",
		PREPOSITIONAL = "двойном аварийном кислородном баке",
	)

/obj/item/tank/internals/emergency_oxygen/double/empty/populate_gas()
	return

// *
// * GENERIC
// *

/obj/item/tank/internals/generic
	name = "gas tank"
	desc = "Универсальный бак, используемый для хранения и транспортировки газов. Может использоваться для дыхания."
	icon_state = "generic"
	inhand_icon_state = "generic_tank"
	distribute_pressure = TANK_DEFAULT_RELEASE_PRESSURE
	force = 10
	dog_fashion = /datum/dog_fashion/back

/obj/item/tank/internals/generic/get_ru_names()
	return alist(
		NOMINATIVE = "газовый бак",
		GENITIVE = "газового бака",
		DATIVE = "газовому баку",
		ACCUSATIVE = "газовый бак",
		INSTRUMENTAL = "газовым баком",
		PREPOSITIONAL = "газовом баке",
	)

/obj/item/tank/internals/generic/populate_gas()
	return

/*
 * Funny internals
 */
/obj/item/tank/internals/emergency_oxygen/engi/clown
	name = "funny emergency oxygen tank"
	desc = "Используется в чрезвычайных ситуациях. Содержит очень мало кислорода с добавлением веселящего газа, так что постарайтесь экономить его, пока он вам действительно не понадобится."
	icon_state = "emergency_clown"
	inhand_icon_state = "emergency_clown"
	worn_icon_state = "emergency_clown"
	tank_holder_icon_state = "holder_emergency_clown"
	distribute_pressure = TANK_CLOWN_RELEASE_PRESSURE

/obj/item/tank/internals/emergency_oxygen/engi/clown/get_ru_names()
	return alist(
		NOMINATIVE = "смешной аварийный кислородный бак",
		GENITIVE = "смешного аварийного кислородного бака",
		DATIVE = "смешному аварийному кислородному баку",
		ACCUSATIVE = "смешной аварийный кислородный бак",
		INSTRUMENTAL = "смешным аварийным кислородным баком",
		PREPOSITIONAL = "смешном аварийном кислородном баке",
	)

/obj/item/tank/internals/emergency_oxygen/engi/clown/n2o

/obj/item/tank/internals/emergency_oxygen/engi/clown/n2o/populate_gas()
	air_contents.assert_gases(/datum/gas/oxygen, /datum/gas/nitrous_oxide)
	air_contents.gases[/datum/gas/oxygen][MOLES] = (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.95
	air_contents.gases[/datum/gas/nitrous_oxide][MOLES] = (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.05

/obj/item/tank/internals/emergency_oxygen/engi/clown/bz

/obj/item/tank/internals/emergency_oxygen/engi/clown/bz/populate_gas()
	air_contents.assert_gases(/datum/gas/oxygen, /datum/gas/bz)
	air_contents.gases[/datum/gas/oxygen][MOLES] = (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.9
	air_contents.gases[/datum/gas/bz][MOLES] = (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.1

/obj/item/tank/internals/emergency_oxygen/engi/clown/helium
	distribute_pressure = TANK_CLOWN_RELEASE_PRESSURE + 2

/obj/item/tank/internals/emergency_oxygen/engi/clown/helium/populate_gas()
	air_contents.assert_gases(/datum/gas/oxygen, /datum/gas/helium)
	air_contents.gases[/datum/gas/oxygen][MOLES] = (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.75
	air_contents.gases[/datum/gas/helium][MOLES] = (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.25
