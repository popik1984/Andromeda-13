/obj/item/circuitboard/computer
	name = "Generic"
	gender = FEMALE
	abstract_type = /obj/item/circuitboard/computer
	name_extension = "(Компьютерная плата)"

/obj/item/circuitboard/computer/get_ru_names()
	return alist(
		NOMINATIVE = "универсальная плата",
		GENITIVE = "универсальной платы",
		DATIVE = "универсальной плате",
		ACCUSATIVE = "универсальную плату",
		INSTRUMENTAL = "универсальной платой",
		PREPOSITIONAL = "универсальной плате",
	)

/obj/item/circuitboard/computer/examine()
	. = ..()
	if(GetComponent(/datum/component/gps))
		. += span_info("на ней маленький мигающий огонёк!")

//Command

/obj/item/circuitboard/computer/aiupload
	name = "AI Upload"
	greyscale_colors = CIRCUIT_COLOR_COMMAND
	build_path = /obj/machinery/computer/upload/ai

/obj/item/circuitboard/computer/aiupload/get_ru_names()
	return alist(
		NOMINATIVE = "плата загрузки ИИ",
		GENITIVE = "платы загрузки ИИ",
		DATIVE = "плате загрузки ИИ",
		ACCUSATIVE = "плату загрузки ИИ",
		INSTRUMENTAL = "платой загрузки ИИ",
		PREPOSITIONAL = "плате загрузки ИИ",
	)

/obj/item/circuitboard/computer/borgupload
	name = "Cyborg Upload"
	greyscale_colors = CIRCUIT_COLOR_COMMAND
	build_path = /obj/machinery/computer/upload/borg

/obj/item/circuitboard/computer/borgupload/get_ru_names()
	return alist(
		NOMINATIVE = "плата загрузки киборгов",
		GENITIVE = "платы загрузки киборгов",
		DATIVE = "плате загрузки киборгов",
		ACCUSATIVE = "плату загрузки киборгов",
		INSTRUMENTAL = "платой загрузки киборгов",
		PREPOSITIONAL = "плате загрузки киборгов",
	)

/obj/item/circuitboard/computer/bsa_control
	name = "Bluespace Artillery Controls"
	build_path = /obj/machinery/computer/bsa_control

/obj/item/circuitboard/computer/bsa_control/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления БСА",
		GENITIVE = "платы управления БСА",
		DATIVE = "плате управления БСА",
		ACCUSATIVE = "плату управления БСА",
		INSTRUMENTAL = "платой управления БСА",
		PREPOSITIONAL = "плате управления БСА",
	)

/obj/item/circuitboard/computer/accounting
	name = "Account Lookup Console"
	greyscale_colors = CIRCUIT_COLOR_COMMAND
	build_path = /obj/machinery/computer/accounting

/obj/item/circuitboard/computer/accounting/get_ru_names()
	return alist(
		NOMINATIVE = "плата консоли счетов",
		GENITIVE = "платы консоли счетов",
		DATIVE = "плате консоли счетов",
		ACCUSATIVE = "плату консоли счетов",
		INSTRUMENTAL = "платой консоли счетов",
		PREPOSITIONAL = "плате консоли счетов",
	)

/obj/item/circuitboard/computer/bankmachine
	name = "Bank Machine Console"
	greyscale_colors = CIRCUIT_COLOR_COMMAND
	build_path = /obj/machinery/computer/bank_machine

/obj/item/circuitboard/computer/bankmachine/get_ru_names()
	return alist(
		NOMINATIVE = "плата банкомата",
		GENITIVE = "платы банкомата",
		DATIVE = "плате банкомата",
		ACCUSATIVE = "плату банкомата",
		INSTRUMENTAL = "платой банкомата",
		PREPOSITIONAL = "плате банкомата",
	)

//Engineering

/obj/item/circuitboard/computer/apc_control
	name = "\improper Power Flow Control Console"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/apc_control

/obj/item/circuitboard/computer/apc_control/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления потоком энергии",
		GENITIVE = "платы управления потоком энергии",
		DATIVE = "плате управления потоком энергии",
		ACCUSATIVE = "плату управления потоком энергии",
		INSTRUMENTAL = "платой управления потоком энергии",
		PREPOSITIONAL = "плате управления потоком энергии",
	)

/obj/item/circuitboard/computer/atmos_alert
	name = "Atmospheric Alert"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/atmos_alert
	var/station_only = FALSE

/obj/item/circuitboard/computer/atmos_alert/get_ru_names()
	return alist(
		NOMINATIVE = "плата атмосферной тревоги",
		GENITIVE = "платы атмосферной тревоги",
		DATIVE = "плате атмосферной тревоги",
		ACCUSATIVE = "плату атмосферной тревоги",
		INSTRUMENTAL = "платой атмосферной тревоги",
		PREPOSITIONAL = "плате атмосферной тревоги",
	)

/obj/item/circuitboard/computer/atmos_alert/station_only
	station_only = TRUE

/obj/item/circuitboard/computer/atmos_alert/examine(mob/user)
	. = ..()
	. += span_info("Плата настроена на [station_only ? "отслеживание всех сигналов тревоги на станции и в шахте" : "отслеживание тревог на этом же z-уровне"].")
	. += span_notice("Режим платы можно изменить с помощью [EXAMINE_HINT("мультитула")].")

/obj/item/circuitboard/computer/atmos_alert/multitool_act(mob/living/user)
	station_only = !station_only
	balloon_alert(user, "отслеживание: [station_only ? "станция" : "z-уровень"]")
	return TRUE

/obj/item/circuitboard/computer/atmos_control
	name = "Atmospheric Control"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/atmos_control

/obj/item/circuitboard/computer/atmos_control/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления атмосферой",
		GENITIVE = "платы управления атмосферой",
		DATIVE = "плате управления атмосферой",
		ACCUSATIVE = "плату управления атмосферой",
		INSTRUMENTAL = "платой управления атмосферой",
		PREPOSITIONAL = "плате управления атмосферой",
	)

/obj/item/circuitboard/computer/atmos_control/nocontrol
	name = "Atmospheric Monitor"
	build_path = /obj/machinery/computer/atmos_control/nocontrol

/obj/item/circuitboard/computer/atmos_control/nocontrol/get_ru_names()
	return alist(
		NOMINATIVE = "плата мониторинга атмосферы",
		GENITIVE = "платы мониторинга атмосферы",
		DATIVE = "плате мониторинга атмосферы",
		ACCUSATIVE = "плату мониторинга атмосферы",
		INSTRUMENTAL = "платой мониторинга атмосферы",
		PREPOSITIONAL = "плате мониторинга атмосферы",
	)

/obj/item/circuitboard/computer/atmos_control/noreconnect
	name = "Atmospheric Control"
	build_path = /obj/machinery/computer/atmos_control/noreconnect

/obj/item/circuitboard/computer/atmos_control/noreconnect/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления атмосферой",
		GENITIVE = "платы управления атмосферой",
		DATIVE = "плате управления атмосферой",
		ACCUSATIVE = "плату управления атмосферой",
		INSTRUMENTAL = "платой управления атмосферой",
		PREPOSITIONAL = "плате управления атмосферой",
	)

/obj/item/circuitboard/computer/atmos_control/fixed
	name = "Atmospheric Monitor"
	build_path = /obj/machinery/computer/atmos_control/fixed

/obj/item/circuitboard/computer/atmos_control/fixed/get_ru_names()
	return alist(
		NOMINATIVE = "плата мониторинга атмосферы",
		GENITIVE = "платы мониторинга атмосферы",
		DATIVE = "плате мониторинга атмосферы",
		ACCUSATIVE = "плату мониторинга атмосферы",
		INSTRUMENTAL = "платой мониторинга атмосферы",
		PREPOSITIONAL = "плате мониторинга атмосферы",
	)

/obj/item/circuitboard/computer/atmos_control/nocontrol/master
	name = "Station Atmospheric Monitor"
	build_path = /obj/machinery/computer/atmos_control/nocontrol/master

/obj/item/circuitboard/computer/atmos_control/nocontrol/master/get_ru_names()
	return alist(
		NOMINATIVE = "плата мониторинга атмосферы станции",
		GENITIVE = "платы мониторинга атмосферы станции",
		DATIVE = "плате мониторинга атмосферы станции",
		ACCUSATIVE = "плату мониторинга атмосферы станции",
		INSTRUMENTAL = "платой мониторинга атмосферы станции",
		PREPOSITIONAL = "плате мониторинга атмосферы станции",
	)

/obj/item/circuitboard/computer/atmos_control/nocontrol/incinerator
	name = "Incinerator Chamber Monitor"
	build_path = /obj/machinery/computer/atmos_control/nocontrol/incinerator

/obj/item/circuitboard/computer/atmos_control/nocontrol/incinerator/get_ru_names()
	return alist(
		NOMINATIVE = "плата мониторинга камеры сжигателя",
		GENITIVE = "платы мониторинга камеры сжигателя",
		DATIVE = "плате мониторинга камеры сжигателя",
		ACCUSATIVE = "плату мониторинга камеры сжигателя",
		INSTRUMENTAL = "платой мониторинга камеры сжигателя",
		PREPOSITIONAL = "плате мониторинга камеры сжигателя",
	)

/obj/item/circuitboard/computer/atmos_control/ordnancemix
	name = "Ordnance Chamber Control"
	build_path = /obj/machinery/computer/atmos_control/ordnancemix

/obj/item/circuitboard/computer/atmos_control/ordnancemix/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления камерой смешивания",
		GENITIVE = "платы управления камерой смешивания",
		DATIVE = "плате управления камерой смешивания",
		ACCUSATIVE = "плату управления камерой смешивания",
		INSTRUMENTAL = "платой управления камерой смешивания",
		PREPOSITIONAL = "плате управления камерой смешивания",
	)

/obj/item/circuitboard/computer/atmos_control/oxygen_tank
	name = "Oxygen Supply Control"
	build_path = /obj/machinery/computer/atmos_control/oxygen_tank

/obj/item/circuitboard/computer/atmos_control/oxygen_tank/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления подачей кислорода",
		GENITIVE = "платы управления подачей кислорода",
		DATIVE = "плате управления подачей кислорода",
		ACCUSATIVE = "плату управления подачей кислорода",
		INSTRUMENTAL = "платой управления подачей кислорода",
		PREPOSITIONAL = "плате управления подачей кислорода",
	)

/obj/item/circuitboard/computer/atmos_control/plasma_tank
	name = "Plasma Supply Control"
	build_path = /obj/machinery/computer/atmos_control/plasma_tank

/obj/item/circuitboard/computer/atmos_control/plasma_tank/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления подачей плазмы",
		GENITIVE = "платы управления подачей плазмы",
		DATIVE = "плате управления подачей плазмы",
		ACCUSATIVE = "плату управления подачей плазмы",
		INSTRUMENTAL = "платой управления подачей плазмы",
		PREPOSITIONAL = "плате управления подачей плазмы",
	)

/obj/item/circuitboard/computer/atmos_control/air_tank
	name = "Mixed Air Supply Control"
	build_path = /obj/machinery/computer/atmos_control/air_tank

/obj/item/circuitboard/computer/atmos_control/air_tank/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления подачей смеси",
		GENITIVE = "платы управления подачей смеси",
		DATIVE = "плате управления подачей смеси",
		ACCUSATIVE = "плату управления подачей смеси",
		INSTRUMENTAL = "платой управления подачей смеси",
		PREPOSITIONAL = "плате управления подачей смеси",
	)

/obj/item/circuitboard/computer/atmos_control/mix_tank
	name = "Gas Mix Supply Control"
	build_path = /obj/machinery/computer/atmos_control/mix_tank

/obj/item/circuitboard/computer/atmos_control/mix_tank/get_ru_names()
	return alist(
		NOMATIVE = "плата управления подачей газовой смеси",
		GENITIVE = "платы управления подачей газовой смеси",
		DATIVE = "плате управления подачей газовой смеси",
		ACCUSATIVE = "плату управления подачей газовой смеси",
		INSTRUMENTAL = "платой управления подачей газовой смеси",
		PREPOSITIONAL = "плате управления подачей газовой смеси",
	)

/obj/item/circuitboard/computer/atmos_control/nitrous_tank
	name = "Nitrous Oxide Supply Control"
	build_path = /obj/machinery/computer/atmos_control/nitrous_tank

/obj/item/circuitboard/computer/atmos_control/nitrous_tank/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления подачей оксида азота",
		GENITIVE = "платы управления подачей оксида азота",
		DATIVE = "плате управления подачей оксида азота",
		ACCUSATIVE = "плату управления подачей оксида азота",
		INSTRUMENTAL = "платой управления подачей оксида азота",
		PREPOSITIONAL = "плате управления подачей оксида азота",
	)

/obj/item/circuitboard/computer/atmos_control/nitrogen_tank
	name = "Nitrogen Supply Control"
	build_path = /obj/machinery/computer/atmos_control/nitrogen_tank

/obj/item/circuitboard/computer/atmos_control/nitrogen_tank/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления подачей азота",
		GENITIVE = "платы управления подачей азота",
		DATIVE = "плате управления подачей азота",
		ACCUSATIVE = "плату управления подачей азота",
		INSTRUMENTAL = "платой управления подачей азота",
		PREPOSITIONAL = "плате управления подачей азота",
	)

/obj/item/circuitboard/computer/atmos_control/carbon_tank
	name = "Carbon Dioxide Supply Control"
	build_path = /obj/machinery/computer/atmos_control/carbon_tank

/obj/item/circuitboard/computer/atmos_control/carbon_tank/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления подачей углекислого газа",
		GENITIVE = "платы управления подачей углекислого газа",
		DATIVE = "плате управления подачей углекислого газа",
		ACCUSATIVE = "плату управления подачей углекислого газа",
		INSTRUMENTAL = "платой управления подачей углекислого газа",
		PREPOSITIONAL = "плате управления подачей углекислого газа",
	)

/obj/item/circuitboard/computer/atmos_control/bz_tank
	name = "BZ Supply Control"
	build_path = /obj/machinery/computer/atmos_control/bz_tank

/obj/item/circuitboard/computer/atmos_control/bz_tank/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления подачей BZ",
		GENITIVE = "платы управления подачей BZ",
		DATIVE = "плате управления подачей BZ",
		ACCUSATIVE = "плату управления подачей BZ",
		INSTRUMENTAL = "платой управления подачей BZ",
		PREPOSITIONAL = "плате управления подачей BZ",
	)

/obj/item/circuitboard/computer/atmos_control/freon_tank
	name = "Freon Supply Control"
	build_path = /obj/machinery/computer/atmos_control/freon_tank

/obj/item/circuitboard/computer/atmos_control/freon_tank/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления подачей фреона",
		GENITIVE = "платы управления подачей фреона",
		DATIVE = "плате управления подачей фреона",
		ACCUSATIVE = "плату управления подачей фреона",
		INSTRUMENTAL = "платой управления подачей фреона",
		PREPOSITIONAL = "плате управления подачей фреона",
	)

/obj/item/circuitboard/computer/atmos_control/halon_tank
	name = "Halon Supply Control"
	build_path = /obj/machinery/computer/atmos_control/halon_tank

/obj/item/circuitboard/computer/atmos_control/halon_tank/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления подачей галона",
		GENITIVE = "платы управления подачей галона",
		DATIVE = "плате управления подачей галона",
		ACCUSATIVE = "плату управления подачей галона",
		INSTRUMENTAL = "платой управления подачей галона",
		PREPOSITIONAL = "плате управления подачей галона",
	)

/obj/item/circuitboard/computer/atmos_control/healium_tank
	name = "Healium Supply Control"
	build_path = /obj/machinery/computer/atmos_control/healium_tank

/obj/item/circuitboard/computer/atmos_control/healium_tank/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления подачей хилиума",
		GENITIVE = "платы управления подачей хилиума",
		DATIVE = "плате управления подачей хилиума",
		ACCUSATIVE = "плату управления подачей хилиума",
		INSTRUMENTAL = "платой управления подачей хилиума",
		PREPOSITIONAL = "плате управления подачей хилиума",
	)

/obj/item/circuitboard/computer/atmos_control/hydrogen_tank
	name = "Hydrogen Supply Control"
	build_path = /obj/machinery/computer/atmos_control/hydrogen_tank

/obj/item/circuitboard/computer/atmos_control/hydrogen_tank/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления подачей водорода",
		GENITIVE = "платы управления подачей водорода",
		DATIVE = "плате управления подачей водорода",
		ACCUSATIVE = "плату управления подачей водорода",
		INSTRUMENTAL = "платой управления подачей водорода",
		PREPOSITIONAL = "плате управления подачей водорода",
	)

/obj/item/circuitboard/computer/atmos_control/hypernoblium_tank
	name = "Hypernoblium Supply Control"
	build_path = /obj/machinery/computer/atmos_control/hypernoblium_tank

/obj/item/circuitboard/computer/atmos_control/hypernoblium_tank/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления подачей гиперноблия",
		GENITIVE = "платы управления подачей гиперноблия",
		DATIVE = "плате управления подачей гиперноблия",
		ACCUSATIVE = "плату управления подачей гиперноблия",
		INSTRUMENTAL = "платой управления подачей гиперноблия",
		PREPOSITIONAL = "плате управления подачей гиперноблия",
	)

/obj/item/circuitboard/computer/atmos_control/miasma_tank
	name = "Miasma Supply Control"
	build_path = /obj/machinery/computer/atmos_control/miasma_tank

/obj/item/circuitboard/computer/atmos_control/miasma_tank/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления подачей миазмов",
		GENITIVE = "платы управления подачей миазмов",
		DATIVE = "плате управления подачей миазмов",
		ACCUSATIVE = "плату управления подачей миазмов",
		INSTRUMENTAL = "платой управления подачей миазмов",
		PREPOSITIONAL = "плате управления подачей миазмов",
	)

/obj/item/circuitboard/computer/atmos_control/nitrium_tank
	name = "Nitrium Supply Control"
	build_path = /obj/machinery/computer/atmos_control/nitrium_tank

/obj/item/circuitboard/computer/atmos_control/nitrium_tank/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления подачей нитрия",
		GENITIVE = "платы управления подачей нитрия",
		DATIVE = "плате управления подачей нитрия",
		ACCUSATIVE = "плату управления подачей нитрия",
		INSTRUMENTAL = "платой управления подачей нитрия",
		PREPOSITIONAL = "плате управления подачей нитрия",
	)

/obj/item/circuitboard/computer/atmos_control/pluoxium_tank
	name = "Pluoxium Supply Control"
	build_path = /obj/machinery/computer/atmos_control/pluoxium_tank

/obj/item/circuitboard/computer/atmos_control/pluoxium_tank/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления подачей плюоксия",
		GENITIVE = "платы управления подачей плюоксия",
		DATIVE = "плате управления подачей плюоксия",
		ACCUSATIVE = "плату управления подачей плюоксия",
		INSTRUMENTAL = "платой управления подачей плюоксия",
		PREPOSITIONAL = "плате управления подачей плюоксия",
	)

/obj/item/circuitboard/computer/atmos_control/proto_nitrate_tank
	name = "Proto-Nitrate Supply Control"
	build_path = /obj/machinery/computer/atmos_control/proto_nitrate_tank

/obj/item/circuitboard/computer/atmos_control/proto_nitrate_tank/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления подачей протонитрата",
		GENITIVE = "платы управления подачей протонитрата",
		DATIVE = "плате управления подачей протонитрата",
		ACCUSATIVE = "плату управления подачей протонитрата",
		INSTRUMENTAL = "платой управления подачей протонитрата",
		PREPOSITIONAL = "плате управления подачей протонитрата",
	)

/obj/item/circuitboard/computer/atmos_control/tritium_tank
	name = "Tritium Supply Control"
	build_path = /obj/machinery/computer/atmos_control/tritium_tank

/obj/item/circuitboard/computer/atmos_control/tritium_tank/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления подачей трития",
		GENITIVE = "платы управления подачей трития",
		DATIVE = "плате управления подачей трития",
		ACCUSATIVE = "плату управления подачей трития",
		INSTRUMENTAL = "платой управления подачей трития",
		PREPOSITIONAL = "плате управления подачей трития",
	)

/obj/item/circuitboard/computer/atmos_control/water_vapor
	name = "Water Vapor Supply Control"
	build_path = /obj/machinery/computer/atmos_control/water_vapor

/obj/item/circuitboard/computer/atmos_control/water_vapor/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления подачей водяного пара",
		GENITIVE = "платы управления подачей водяного пара",
		DATIVE = "плате управления подачей водяного пара",
		ACCUSATIVE = "плату управления подачей водяного пара",
		INSTRUMENTAL = "платой управления подачей водяного пара",
		PREPOSITIONAL = "плате управления подачей водяного пара",
	)

/obj/item/circuitboard/computer/atmos_control/zauker_tank
	name = "Zauker Supply Control"
	build_path = /obj/machinery/computer/atmos_control/zauker_tank

/obj/item/circuitboard/computer/atmos_control/zauker_tank/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления подачей заукера",
		GENITIVE = "платы управления подачей заукера",
		DATIVE = "плате управления подачей заукера",
		ACCUSATIVE = "плату управления подачей заукера",
		INSTRUMENTAL = "платой управления подачей заукера",
		PREPOSITIONAL = "плате управления подачей заукера",
	)

/obj/item/circuitboard/computer/atmos_control/helium_tank
	name = "Helium Supply Control"
	build_path = /obj/machinery/computer/atmos_control/helium_tank

/obj/item/circuitboard/computer/atmos_control/helium_tank/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления подачей гелия",
		GENITIVE = "платы управления подачей гелия",
		DATIVE = "плате управления подачей гелия",
		ACCUSATIVE = "плату управления подачей гелия",
		INSTRUMENTAL = "платой управления подачей гелия",
		PREPOSITIONAL = "плате управления подачей гелия",
	)

/obj/item/circuitboard/computer/atmos_control/antinoblium_tank
	name = "Antinoblium Supply Control"
	build_path = /obj/machinery/computer/atmos_control/antinoblium_tank

/obj/item/circuitboard/computer/atmos_control/antinoblium_tank/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления подачей антиноблия",
		GENITIVE = "платы управления подачей антиноблия",
		DATIVE = "плате управления подачей антиноблия",
		ACCUSATIVE = "плату управления подачей антиноблия",
		INSTRUMENTAL = "платой управления подачей антиноблия",
		PREPOSITIONAL = "плате управления подачей антиноблия",
	)

/obj/item/circuitboard/computer/auxiliary_base
	name = "Auxiliary Base Management Console"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/auxiliary_base

/obj/item/circuitboard/computer/auxiliary_base/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления вспомогательной базой",
		GENITIVE = "платы управления вспомогательной базой",
		DATIVE = "плате управления вспомогательной базой",
		ACCUSATIVE = "плату управления вспомогательной базой",
		INSTRUMENTAL = "платой управления вспомогательной базой",
		PREPOSITIONAL = "плате управления вспомогательной базой",
	)

/obj/item/circuitboard/computer/base_construction
	name = "Generic Base Construction Console"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/camera_advanced/base_construction

/obj/item/circuitboard/computer/base_construction/get_ru_names()
	return alist(
		NOMINATIVE = "плата конструктора баз",
		GENITIVE = "платы конструктора баз",
		DATIVE = "плате конструктора баз",
		ACCUSATIVE = "плату конструктора баз",
		INSTRUMENTAL = "платой конструктора баз",
		PREPOSITIONAL = "плате конструктора баз",
	)

/obj/item/circuitboard/computer/base_construction/aux
	name = "Aux Mining Base Construction Console"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/camera_advanced/base_construction/aux

/obj/item/circuitboard/computer/base_construction/aux/get_ru_names()
	return alist(
		NOMINATIVE = "плата конструктора шахтёрской базы",
		GENITIVE = "платы конструктора шахтёрской базы",
		DATIVE = "плате конструктора шахтёрской базы",
		ACCUSATIVE = "плату конструктора шахтёрской базы",
		INSTRUMENTAL = "платой конструктора шахтёрской базы",
		PREPOSITIONAL = "плате конструктора шахтёрской базы",
	)

/obj/item/circuitboard/computer/base_construction/centcom
	name = "Centcom Base Construction Console"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/camera_advanced/base_construction/centcom

/obj/item/circuitboard/computer/base_construction/centcom/get_ru_names()
	return alist(
		NOMINATIVE = "плата конструктора базы Центкома",
		GENITIVE = "платы конструктора базы Центкома",
		DATIVE = "плате конструктора базы Центкома",
		ACCUSATIVE = "плату конструктора базы Центкома",
		INSTRUMENTAL = "платой конструктора базы Центкома",
		PREPOSITIONAL = "плате конструктора базы Центкома",
	)

/obj/item/circuitboard/computer/comm_monitor
	name = "Telecommunications Monitor"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/telecomms/monitor

/obj/item/circuitboard/computer/comm_monitor/get_ru_names()
	return alist(
		NOMINATIVE = "плата мониторинга телекоммуникаций",
		GENITIVE = "платы мониторинга телекоммуникаций",
		DATIVE = "плате мониторинга телекоммуникаций",
		ACCUSATIVE = "плату мониторинга телекоммуникаций",
		INSTRUMENTAL = "платой мониторинга телекоммуникаций",
		PREPOSITIONAL = "плате мониторинга телекоммуникаций",
	)

/obj/item/circuitboard/computer/comm_server
	name = "Telecommunications Server Monitor"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/telecomms/server

/obj/item/circuitboard/computer/comm_server/get_ru_names()
	return alist(
		NOMINATIVE = "плата мониторинга телекоммуникационного сервера",
		GENITIVE = "платы мониторинга телекоммуникационного сервера",
		DATIVE = "плате мониторинга телекоммуникационного сервера",
		ACCUSATIVE = "плату мониторинга телекоммуникационного сервера",
		INSTRUMENTAL = "платой мониторинга телекоммуникационного сервера",
		PREPOSITIONAL = "плате мониторинга телекоммуникационного сервера",
	)

/obj/item/circuitboard/computer/communications
	name = "Communications"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/communications

/obj/item/circuitboard/computer/communications/get_ru_names()
	return alist(
		NOMINATIVE = "плата коммуникаций",
		GENITIVE = "платы коммуникаций",
		DATIVE = "плате коммуникаций",
		ACCUSATIVE = "плату коммуникаций",
		INSTRUMENTAL = "платой коммуникаций",
		PREPOSITIONAL = "плате коммуникаций",
	)

/obj/item/circuitboard/computer/communications/syndicate
	name = "Syndicate Communications"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/communications/syndicate

/obj/item/circuitboard/computer/communications/syndicate/get_ru_names()
	return alist(
		NOMINATIVE = "плата коммуникаций Синдиката",
		GENITIVE = "платы коммуникаций Синдиката",
		DATIVE = "плате коммуникаций Синдиката",
		ACCUSATIVE = "плату коммуникаций Синдиката",
		INSTRUMENTAL = "платой коммуникаций Синдиката",
		PREPOSITIONAL = "плате коммуникаций Синдиката",
	)

/obj/item/circuitboard/computer/message_monitor
	name = "Message Monitor"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/message_monitor

/obj/item/circuitboard/computer/message_monitor/get_ru_names()
	return alist(
		NOMINATIVE = "плата мониторинга сообщений",
		GENITIVE = "платы мониторинга сообщений",
		DATIVE = "плате мониторинга сообщений",
		ACCUSATIVE = "плату мониторинга сообщений",
		INSTRUMENTAL = "платой мониторинга сообщений",
		PREPOSITIONAL = "плате мониторинга сообщений",
	)

/obj/item/circuitboard/computer/modular_shield_console
	name = "Modular Shield Generator Console"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/modular_shield

/obj/item/circuitboard/computer/modular_shield_console/get_ru_names()
	return alist(
		NOMINATIVE = "плата генератора модульного щита",
		GENITIVE = "платы генератора модульного щита",
		DATIVE = "плате генератора модульного щита",
		ACCUSATIVE = "плату генератора модульного щита",
		INSTRUMENTAL = "платой генератора модульного щита",
		PREPOSITIONAL = "плате генератора модульного щита",
	)

/obj/item/circuitboard/computer/powermonitor
	name = "Power Monitor"  //name fixed 250810
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/monitor

/obj/item/circuitboard/computer/powermonitor/get_ru_names()
	return alist(
		NOMINATIVE = "плата мониторинга питания",
		GENITIVE = "платы мониторинга питания",
		DATIVE = "плате мониторинга питания",
		ACCUSATIVE = "плату мониторинга питания",
		INSTRUMENTAL = "платой мониторинга питания",
		PREPOSITIONAL = "плате мониторинга питания",
	)

/obj/item/circuitboard/computer/sat_control
	name = "Satellite Network Control"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/sat_control

/obj/item/circuitboard/computer/sat_control/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления спутниковой сетью",
		GENITIVE = "платы управления спутниковой сетью",
		DATIVE = "плате управления спутниковой сетью",
		ACCUSATIVE = "плату управления спутниковой сетью",
		INSTRUMENTAL = "платой управления спутниковой сетью",
		PREPOSITIONAL = "плате управления спутниковой сетью",
	)

/obj/item/circuitboard/computer/solar_control
	name = "Solar Control"  //name fixed 250810
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/solar_control

/obj/item/circuitboard/computer/solar_control/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления солнечными панелями",
		GENITIVE = "платы управления солнечными панелями",
		DATIVE = "плате управления солнечными панелями",
		ACCUSATIVE = "плату управления солнечными панелями",
		INSTRUMENTAL = "платой управления солнечными панелями",
		PREPOSITIONAL = "плате управления солнечными панелями",
	)

/obj/item/circuitboard/computer/station_alert
	name = "Station Alerts"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/station_alert

/obj/item/circuitboard/computer/station_alert/get_ru_names()
	return alist(
		NOMINATIVE = "плата станционных оповещений",
		GENITIVE = "платы станционных оповещений",
		DATIVE = "плате станционных оповещений",
		ACCUSATIVE = "плату станционных оповещений",
		INSTRUMENTAL = "платой станционных оповещений",
		PREPOSITIONAL = "плате станционных оповещений",
	)

/obj/item/circuitboard/computer/turbine_computer
	name = "Turbine Computer"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/turbine_computer

/obj/item/circuitboard/computer/turbine_computer/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления турбиной",
		GENITIVE = "платы управления турбиной",
		DATIVE = "плате управления турбиной",
		ACCUSATIVE = "плату управления турбиной",
		INSTRUMENTAL = "платой управления турбиной",
		PREPOSITIONAL = "плате управления турбиной",
	)

//Generic

/obj/item/circuitboard/computer/arcade/amputation
	name = "Mediborg's Amputation Adventure"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/arcade/amputation

/obj/item/circuitboard/computer/arcade/amputation/get_ru_names()
	return alist(
		NOMINATIVE = "плата \"Приключения Медиборга\"",
		GENITIVE = "платы \"Приключения Медиборга\"",
		DATIVE = "плате \"Приключения Медиборга\"",
		ACCUSATIVE = "плату \"Приключения Медиборга\"",
		INSTRUMENTAL = "платой \"Приключения Медиборга\"",
		PREPOSITIONAL = "плате \"Приключения Медиборга\"",
	)

/obj/item/circuitboard/computer/arcade/battle
	name = "Arcade Battle"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/arcade/battle

/obj/item/circuitboard/computer/arcade/battle/get_ru_names()
	return alist(
		NOMINATIVE = "плата \"Аркадная Битва\"",
		GENITIVE = "платы \"Аркадная Битва\"",
		DATIVE = "плате \"Аркадная Битва\"",
		ACCUSATIVE = "плату \"Аркадная Битва\"",
		INSTRUMENTAL = "платой \"Аркадная Битва\"",
		PREPOSITIONAL = "плате \"Аркадная Битва\"",
	)

/obj/item/circuitboard/computer/arcade/orion_trail
	name = "Orion Trail"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/arcade/orion_trail

/obj/item/circuitboard/computer/arcade/orion_trail/get_ru_names()
	return alist(
		NOMINATIVE = "плата \"Орион Трейл\"",
		GENITIVE = "платы \"Орион Трейл\"",
		DATIVE = "плате \"Орион Трейл\"",
		ACCUSATIVE = "плату \"Орион Трейл\"",
		INSTRUMENTAL = "платой \"Орион Трейл\"",
		PREPOSITIONAL = "плате \"Орион Трейл\"",
	)

/obj/item/circuitboard/computer/holodeck// Not going to let people get this, but it's just here for future
	name = "Holodeck Control"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/holodeck

/obj/item/circuitboard/computer/holodeck/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления голодеком",
		GENITIVE = "платы управления голодеком",
		DATIVE = "плате управления голодеком",
		ACCUSATIVE = "плату управления голодеком",
		INSTRUMENTAL = "платой управления голодеком",
		PREPOSITIONAL = "плате управления голодеком",
	)

/obj/item/circuitboard/computer/libraryconsole
	name = "Library Visitor Console"
	build_path = /obj/machinery/computer/libraryconsole

/obj/item/circuitboard/computer/libraryconsole/get_ru_names()
	return alist(
		NOMINATIVE = "плата терминала посетителя библиотеки",
		GENITIVE = "платы терминала посетителя библиотеки",
		DATIVE = "плате терминала посетителя библиотеки",
		ACCUSATIVE = "плату терминала посетителя библиотеки",
		INSTRUMENTAL = "платой терминала посетителя библиотеки",
		PREPOSITIONAL = "плате терминала посетителя библиотеки",
	)

/obj/item/circuitboard/computer/libraryconsole/bookconsole
	name =  "Book Inventory Management Console"
	build_path = /obj/machinery/computer/libraryconsole/bookmanagement

/obj/item/circuitboard/computer/libraryconsole/bookconsole/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления книжным инвентарём",
		GENITIVE = "платы управления книжным инвентарём",
		DATIVE = "плате управления книжным инвентарём",
		ACCUSATIVE = "плату управления книжным инвентарём",
		INSTRUMENTAL = "платой управления книжным инвентарём",
		PREPOSITIONAL = "плате управления книжным инвентарём",
	)

/obj/item/circuitboard/computer/libraryconsole/screwdriver_act(mob/living/user, obj/item/tool)
	if(build_path == /obj/machinery/computer/libraryconsole/bookmanagement)
		name = "Library Visitor Console"
		build_path = /obj/machinery/computer/libraryconsole
		to_chat(user, span_notice("Протоколы доступа сброшены."))
	else
		name = "Book Inventory Management Console"
		build_path = /obj/machinery/computer/libraryconsole/bookmanagement
		to_chat(user, span_notice("Протоколы доступа успешно обновлены."))
	return TRUE

/obj/item/circuitboard/computer/monastery_shuttle
	name = "Monastery Shuttle"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/shuttle/monastery_shuttle

/obj/item/circuitboard/computer/monastery_shuttle/get_ru_names()
	return alist(
		NOMINATIVE = "плата шаттла монастыря",
		GENITIVE = "платы шаттла монастыря",
		DATIVE = "плате шаттла монастыря",
		ACCUSATIVE = "плату шаттла монастыря",
		INSTRUMENTAL = "платой шаттла монастыря",
		PREPOSITIONAL = "плате шаттла монастыря",
	)

/obj/item/circuitboard/computer/olddoor
	name = "DoorMex"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/pod/old

/obj/item/circuitboard/computer/olddoor/get_ru_names()
	return alist(
		NOMINATIVE = "плата DoorMex",
		GENITIVE = "платы DoorMex",
		DATIVE = "плате DoorMex",
		ACCUSATIVE = "плату DoorMex",
		INSTRUMENTAL = "платой DoorMex",
		PREPOSITIONAL = "плате DoorMex",
	)

/obj/item/circuitboard/computer/pod
	name = "Massdriver control"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/pod

/obj/item/circuitboard/computer/pod/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления масс-драйвером",
		GENITIVE = "платы управления масс-драйвером",
		DATIVE = "плате управления масс-драйвером",
		ACCUSATIVE = "плату управления масс-драйвером",
		INSTRUMENTAL = "платой управления масс-драйвером",
		PREPOSITIONAL = "плате управления масс-драйвером",
	)

/obj/item/circuitboard/computer/slot_machine
	name = "Slot Machine"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/slot_machine

/obj/item/circuitboard/computer/slot_machine/get_ru_names()
	return alist(
		NOMINATIVE = "плата игрового автомата",
		GENITIVE = "платы игрового автомата",
		DATIVE = "плате игрового автомата",
		ACCUSATIVE = "плату игрового автомата",
		INSTRUMENTAL = "платой игрового автомата",
		PREPOSITIONAL = "плате игрового автомата",
	)

/obj/item/circuitboard/computer/swfdoor
	name = "Magix"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/pod/old/swf

/obj/item/circuitboard/computer/swfdoor/get_ru_names()
	return alist(
		NOMINATIVE = "плата Magix",
		GENITIVE = "платы Magix",
		DATIVE = "плате Magix",
		ACCUSATIVE = "плату Magix",
		INSTRUMENTAL = "платой Magix",
		PREPOSITIONAL = "плате Magix",
	)

/obj/item/circuitboard/computer/syndicate_shuttle
	name = "Syndicate Shuttle"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/shuttle/syndicate
	/// If operatives declared war this will be the time challenge was started
	var/challenge_start_time
	var/moved = FALSE

/obj/item/circuitboard/computer/syndicate_shuttle/get_ru_names()
	return alist(
		NOMINATIVE = "плата шаттла Синдиката",
		GENITIVE = "платы шаттла Синдиката",
		DATIVE = "плате шаттла Синдиката",
		ACCUSATIVE = "плату шаттла Синдиката",
		INSTRUMENTAL = "платой шаттла Синдиката",
		PREPOSITIONAL = "плате шаттла Синдиката",
	)

/obj/item/circuitboard/computer/syndicate_shuttle/Initialize(mapload)
	. = ..()
	GLOB.syndicate_shuttle_boards += src

/obj/item/circuitboard/computer/syndicate_shuttle/Destroy()
	GLOB.syndicate_shuttle_boards -= src
	return ..()

/obj/item/circuitboard/computer/syndicatedoor
	name = "ProComp Executive"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/pod/old/syndicate

/obj/item/circuitboard/computer/syndicatedoor/get_ru_names()
	return alist(
		NOMINATIVE = "плата ProComp Executive",
		GENITIVE = "платы ProComp Executive",
		DATIVE = "плате ProComp Executive",
		ACCUSATIVE = "плату ProComp Executive",
		INSTRUMENTAL = "платой ProComp Executive",
		PREPOSITIONAL = "плате ProComp Executive",
	)

/obj/item/circuitboard/computer/white_ship
	name = "White Ship"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/shuttle/white_ship

/obj/item/circuitboard/computer/white_ship/get_ru_names()
	return alist(
		NOMINATIVE = "плата Белого Корабля",
		GENITIVE = "платы Белого Корабля",
		DATIVE = "плате Белого Корабля",
		ACCUSATIVE = "плату Белого Корабля",
		INSTRUMENTAL = "платой Белого Корабля",
		PREPOSITIONAL = "плате Белого Корабля",
	)

/obj/item/circuitboard/computer/white_ship/bridge
	name = "White Ship Bridge"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/shuttle/white_ship/bridge

/obj/item/circuitboard/computer/white_ship/bridge/get_ru_names()
	return alist(
		NOMINATIVE = "плата мостика Белого Корабля",
		GENITIVE = "платы мостика Белого Корабля",
		DATIVE = "плате мостика Белого Корабля",
		ACCUSATIVE = "плату мостика Белого Корабля",
		INSTRUMENTAL = "платой мостика Белого Корабля",
		PREPOSITIONAL = "плате мостика Белого Корабля",
	)

/obj/item/circuitboard/computer/bountypad
	name = "Bounty Pad"
	build_path = /obj/machinery/computer/piratepad_control/civilian

/obj/item/circuitboard/computer/bountypad/get_ru_names()
	return alist(
		NOMINATIVE = "плата баунтипада",
		GENITIVE = "платы баунтипада",
		DATIVE = "плате баунтипада",
		ACCUSATIVE = "плату баунтипада",
		INSTRUMENTAL = "платой баунтипада",
		PREPOSITIONAL = "плате баунтипада",
	)

/obj/item/circuitboard/computer/tram_controls
	name = "Tram Controls"
	build_path = /obj/machinery/computer/tram_controls
	var/split_mode = FALSE

/obj/item/circuitboard/computer/tram_controls/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления трамваем",
		GENITIVE = "платы управления трамваем",
		DATIVE = "плате управления трамваем",
		ACCUSATIVE = "плату управления трамваем",
		INSTRUMENTAL = "платой управления трамваем",
		PREPOSITIONAL = "плате управления трамваем",
	)

/obj/item/circuitboard/computer/tram_controls/split
	split_mode = TRUE

/obj/item/circuitboard/computer/tram_controls/examine(mob/user)
	. = ..()
	. += span_info("Плата настроена на [split_mode ? "разделенное окно" : "нормальное окно"].")
	. += span_notice("Режим платы можно изменить с помощью [EXAMINE_HINT("мультитула")].")

/obj/item/circuitboard/computer/tram_controls/multitool_act(mob/living/user)
	split_mode = !split_mode
	to_chat(user, span_notice("Позиционирование [RU_SRC_GEN] установлено на [split_mode ? "разделенное окно" : "нормальное окно"]."))
	return TRUE

/obj/item/circuitboard/computer/terminal
	name = "Terminal"
	build_path = /obj/machinery/computer/terminal

/obj/item/circuitboard/computer/terminal/get_ru_names()
	return alist(
		NOMINATIVE = "плата терминала",
		GENITIVE = "платы терминала",
		DATIVE = "плате терминала",
		ACCUSATIVE = "плату терминала",
		INSTRUMENTAL = "платой терминала",
		PREPOSITIONAL = "плате терминала",
	)

//Medical

/obj/item/circuitboard/computer/crew
	name = "Crew Monitoring Console"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/computer/crew

/obj/item/circuitboard/computer/crew/get_ru_names()
	return alist(
		NOMINATIVE = "плата мониторинга экипажа",
		GENITIVE = "платы мониторинга экипажа",
		DATIVE = "плате мониторинга экипажа",
		ACCUSATIVE = "плату мониторинга экипажа",
		INSTRUMENTAL = "платой мониторинга экипажа",
		PREPOSITIONAL = "плате мониторинга экипажа",
	)

/obj/item/circuitboard/computer/med_data
	name = "Medical Records Console"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/computer/records/medical

/obj/item/circuitboard/computer/med_data/get_ru_names()
	return alist(
		NOMINATIVE = "плата медицинских записей",
		GENITIVE = "платы медицинских записей",
		DATIVE = "плате медицинских записей",
		ACCUSATIVE = "плату медицинских записей",
		INSTRUMENTAL = "платой медицинских записей",
		PREPOSITIONAL = "плате медицинских записей",
	)

/obj/item/circuitboard/computer/operating
	name = "Operating Computer"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/computer/operating

/obj/item/circuitboard/computer/operating/get_ru_names()
	return alist(
		NOMINATIVE = "плата операционного компьютера",
		GENITIVE = "платы операционного компьютера",
		DATIVE = "плате операционного компьютера",
		ACCUSATIVE = "плату операционного компьютера",
		INSTRUMENTAL = "платой операционного компьютера",
		PREPOSITIONAL = "плате операционного компьютера",
	)

/obj/item/circuitboard/computer/pandemic
	name = "PanD.E.M.I.C. 2200"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/computer/pandemic

/obj/item/circuitboard/computer/pandemic/get_ru_names()
	return alist(
		NOMINATIVE = "плата ПанД.Е.М.И.Я 2200",
		GENITIVE = "платы ПанД.Е.М.И.Я 2200",
		DATIVE = "плате ПанД.Е.М.И.Я 2200",
		ACCUSATIVE = "плату ПанД.Е.М.И.Я 2200",
		INSTRUMENTAL = "платой ПанД.Е.М.И.Я 2200",
		PREPOSITIONAL = "плате ПанД.Е.М.И.Я 2200",
	)

/obj/item/circuitboard/computer/experimental_cloner
	name = "Experimental Cloner Control Console"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/computer/experimental_cloner

/obj/item/circuitboard/computer/experimental_cloner/get_ru_names()
	return alist(
		NOMINATIVE = "плата экспериментального клонера",
		GENITIVE = "платы экспериментального клонера",
		DATIVE = "плате экспериментального клонера",
		ACCUSATIVE = "плату экспериментального клонера",
		INSTRUMENTAL = "платой экспериментального клонера",
		PREPOSITIONAL = "плате экспериментального клонера",
	)

//Science

/obj/item/circuitboard/computer/aifixer
	name = "AI Integrity Restorer"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/aifixer

/obj/item/circuitboard/computer/aifixer/get_ru_names()
	return alist(
		NOMINATIVE = "плата восстановления целостности ИИ",
		GENITIVE = "платы восстановления целостности ИИ",
		DATIVE = "плате восстановления целостности ИИ",
		ACCUSATIVE = "плату восстановления целостности ИИ",
		INSTRUMENTAL = "платой восстановления целостности ИИ",
		PREPOSITIONAL = "плате восстановления целостности ИИ",
	)

/obj/item/circuitboard/computer/launchpad_console
	name = "Launchpad Control Console"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/launchpad

/obj/item/circuitboard/computer/launchpad_console/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления лаунчпадом",
		GENITIVE = "платы управления лаунчпадом",
		DATIVE = "плате управления лаунчпадом",
		ACCUSATIVE = "плату управления лаунчпадом",
		INSTRUMENTAL = "платой управления лаунчпадом",
		PREPOSITIONAL = "плате управления лаунчпадом",
	)

/obj/item/circuitboard/computer/mech_bay_power_console
	name = "Mech Bay Power Control Console"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/mech_bay_power_console

/obj/item/circuitboard/computer/mech_bay_power_console/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления питанием мех-дока",
		GENITIVE = "платы управления питанием мех-дока",
		DATIVE = "плате управления питанием мех-дока",
		ACCUSATIVE = "плату управления питанием мех-дока",
		INSTRUMENTAL = "платой управления питанием мех-дока",
		PREPOSITIONAL = "плате управления питанием мех-дока",
	)

/obj/item/circuitboard/computer/mecha_control
	name = "Exosuit Control Console"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/mecha

/obj/item/circuitboard/computer/mecha_control/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления экзокостюмами",
		GENITIVE = "платы управления экзокостюмами",
		DATIVE = "плате управления экзокостюмами",
		ACCUSATIVE = "плату управления экзокостюмами",
		INSTRUMENTAL = "платой управления экзокостюмами",
		PREPOSITIONAL = "плате управления экзокостюмами",
	)

/obj/item/circuitboard/computer/rdconsole
	name = "R&D Console"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/rdconsole
	req_access = list(ACCESS_RESEARCH) // Research access is required to toggle the lock.

	var/silence_announcements = FALSE
	var/locked = TRUE

/obj/item/circuitboard/computer/rdconsole/get_ru_names()
	return alist(
		NOMINATIVE = "плата РнД консоли",
		GENITIVE = "платы РнД консоли",
		DATIVE = "плате РнД консоли",
		ACCUSATIVE = "плату РнД консоли",
		INSTRUMENTAL = "платой РнД консоли",
		PREPOSITIONAL = "плате РнД консоли",
	)

// An unlocked subtype of the board for mapping.
/obj/item/circuitboard/computer/rdconsole/unlocked
	locked = FALSE

/obj/item/circuitboard/computer/rdconsole/examine(mob/user)
	. = ..()
	. += span_info("Плата настроена на [silence_announcements ? "скрытие" : "объявление"] изученных технологий по радио.")
	. += span_notice("Режим платы можно изменить с помощью [EXAMINE_HINT("мультитула")].")
	. += span_notice("Плата [locked ? "заблокирована" : "разблокирована"], и может быть [locked ? "разблокирована" : "заблокирована"] ID картой с научным доступом.")

/obj/item/circuitboard/computer/rdconsole/multitool_act(mob/living/user)
	. = ..()
	if(obj_flags & EMAGGED)
		balloon_alert(user, "режим платы сломан!")
		return
	silence_announcements = !silence_announcements
	balloon_alert(user, "объявления [silence_announcements ? "отключены" : "включены"]")

/obj/item/circuitboard/computer/rdconsole/emag_act(mob/user, obj/item/card/emag/emag_card)
	if (locked)
		locked = FALSE
		to_chat(user, span_notice("Вы магнитно активируете запирающий механизм, заставляя его разблокироваться."))

	if (obj_flags & EMAGGED)
		return FALSE

	obj_flags |= EMAGGED
	silence_announcements = FALSE
	to_chat(user, span_notice("Вы перегружаете чип объявлений технологий, заставляя каждую технологию быть объявленной на общем канале."))
	return TRUE

/obj/item/circuitboard/computer/rdconsole/attackby(obj/item/attacking_item, mob/living/user, list/modifiers, list/attack_modifiers)
	if (user.combat_mode || !isidcard(attacking_item))
		return ..()
	if (check_access(attacking_item))
		locked = !locked
		balloon_alert(user, locked ? "заблокировано" : "разблокировано")
		user.visible_message(
			message = span_notice("[user] [locked ? "блокирует" : "разблокирует"] [RU_SRC_NOM] с помощью [attacking_item]."),
			self_message = span_notice("Вы [locked ? "блокируете" : "разблокируете"] [RU_SRC_NOM] с помощью [attacking_item]."),
			blind_message = span_hear("Слышен тихий писк."),
		)
	else
		balloon_alert(user, "нет доступа!")

/obj/item/circuitboard/computer/rdservercontrol
	name = "R&D Server Control"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/rdservercontrol

/obj/item/circuitboard/computer/rdservercontrol/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления РнД сервером",
		GENITIVE = "платы управления РнД сервером",
		DATIVE = "плате управления РнД сервером",
		ACCUSATIVE = "плату управления РнД сервером",
		INSTRUMENTAL = "платой управления РнД сервером",
		PREPOSITIONAL = "плате управления РнД сервером",
	)

/obj/item/circuitboard/computer/research
	name = "Research Monitor"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/security/research

/obj/item/circuitboard/computer/research/get_ru_names()
	return alist(
		NOMINATIVE = "плата научного монитора",
		GENITIVE = "платы научного монитора",
		DATIVE = "плате научного монитора",
		ACCUSATIVE = "плату научного монитора",
		INSTRUMENTAL = "платой научного монитора",
		PREPOSITIONAL = "плате научного монитора",
	)

/obj/item/circuitboard/computer/robotics
	name = "Robotics Control"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/robotics

/obj/item/circuitboard/computer/robotics/get_ru_names()
	return alist(
		NOMINATIVE = "плата контроля робототехники",
		GENITIVE = "платы контроля робототехники",
		DATIVE = "плате контроля робототехники",
		ACCUSATIVE = "плату контроля робототехники",
		INSTRUMENTAL = "платой контроля робототехники",
		PREPOSITIONAL = "плате контроля робототехники",
	)

/obj/item/circuitboard/computer/teleporter
	name = "Teleporter"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/teleporter

/obj/item/circuitboard/computer/teleporter/get_ru_names()
	return alist(
		NOMINATIVE = "плата телепорта",
		GENITIVE = "платы телепорта",
		DATIVE = "плате телепорта",
		ACCUSATIVE = "плату телепорта",
		INSTRUMENTAL = "платой телепорта",
		PREPOSITIONAL = "плате телепорта",
	)

/obj/item/circuitboard/computer/xenobiology
	name = "Xenobiology Console"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/camera_advanced/xenobio

/obj/item/circuitboard/computer/xenobiology/get_ru_names()
	return alist(
		NOMINATIVE = "плата ксенобиологии",
		GENITIVE = "платы ксенобиологии",
		DATIVE = "плате ксенобиологии",
		ACCUSATIVE = "плату ксенобиологии",
		INSTRUMENTAL = "платой ксенобиологии",
		PREPOSITIONAL = "плате ксенобиологии",
	)

/obj/item/circuitboard/computer/scan_consolenew
	name = "DNA Console"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/dna_console

/obj/item/circuitboard/computer/scan_consolenew/get_ru_names()
	return alist(
		NOMINATIVE = "плата консоли ДНК",
		GENITIVE = "платы консоли ДНК",
		DATIVE = "плате консоли ДНК",
		ACCUSATIVE = "плату консоли ДНК",
		INSTRUMENTAL = "платой консоли ДНК",
		PREPOSITIONAL = "плате консоли ДНК",
	)

/obj/item/circuitboard/computer/mechpad
	name = "Mecha Orbital Pad Console"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/mechpad

/obj/item/circuitboard/computer/mechpad/get_ru_names()
	return alist(
		NOMINATIVE = "плата орбитальной площадки мехов",
		GENITIVE = "платы орбитальной площадки мехов",
		DATIVE = "плате орбитальной площадки мехов",
		ACCUSATIVE = "плату орбитальной площадки мехов",
		INSTRUMENTAL = "платой орбитальной площадки мехов",
		PREPOSITIONAL = "плате орбитальной площадки мехов",
	)

//Security

/obj/item/circuitboard/computer/labor_shuttle
	name = "Labor Shuttle"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/computer/shuttle/labor

/obj/item/circuitboard/computer/labor_shuttle/get_ru_names()
	return alist(
		NOMINATIVE = "плата шахтёрского шаттла",
		GENITIVE = "платы шахтёрского шаттла",
		DATIVE = "плате шахтёрского шаттла",
		ACCUSATIVE = "плату шахтёрского шаттла",
		INSTRUMENTAL = "платой шахтёрского шаттла",
		PREPOSITIONAL = "плате шахтёрского шаттла",
	)

/obj/item/circuitboard/computer/labor_shuttle/one_way
	name = "Prisoner Shuttle Console"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/computer/shuttle/labor/one_way

/obj/item/circuitboard/computer/labor_shuttle/one_way/get_ru_names()
	return alist(
		NOMINATIVE = "плата тюремного шаттла",
		GENITIVE = "платы тюремного шаттла",
		DATIVE = "плате тюремного шаттла",
		ACCUSATIVE = "плату тюремного шаттла",
		INSTRUMENTAL = "платой тюремного шаттла",
		PREPOSITIONAL = "плате тюремного шаттла",
	)

/obj/item/circuitboard/computer/gulag_teleporter_console
	name = "Labor Camp teleporter console"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/computer/prisoner/gulag_teleporter_computer

/obj/item/circuitboard/computer/gulag_teleporter_console/get_ru_names()
	return alist(
		NOMINATIVE = "плата телепорта трудового лагеря",
		GENITIVE = "платы телепорта трудового лагеря",
		DATIVE = "плате телепорта трудового лагеря",
		ACCUSATIVE = "плату телепорта трудового лагеря",
		INSTRUMENTAL = "платой телепорта трудового лагеря",
		PREPOSITIONAL = "плате телепорта трудового лагеря",
	)

/obj/item/circuitboard/computer/prisoner
	name = "Prisoner Management Console"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/computer/prisoner/management

/obj/item/circuitboard/computer/prisoner/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления заключёнными",
		GENITIVE = "платы управления заключёнными",
		DATIVE = "плате управления заключёнными",
		ACCUSATIVE = "плату управления заключёнными",
		INSTRUMENTAL = "платой управления заключёнными",
		PREPOSITIONAL = "плате управления заключёнными",
	)

/obj/item/circuitboard/computer/secure_data
	name = "Security Records Console"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/computer/records/security

/obj/item/circuitboard/computer/secure_data/get_ru_names()
	return alist(
		NOMINATIVE = "плата записей службы безопасности",
		GENITIVE = "платы записей службы безопасности",
		DATIVE = "плате записей службы безопасности",
		ACCUSATIVE = "плату записей службы безопасности",
		INSTRUMENTAL = "платой записей службы безопасности",
		PREPOSITIONAL = "плате записей службы безопасности",
	)

/obj/item/circuitboard/computer/warrant
	name = "Security Warrant Viewer"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/computer/warrant

/obj/item/circuitboard/computer/warrant/get_ru_names()
	return alist(
		NOMINATIVE = "плата просмотра ордеров",
		GENITIVE = "платы просмотра ордеров",
		DATIVE = "плате просмотра ордеров",
		ACCUSATIVE = "плату просмотра ордеров",
		INSTRUMENTAL = "платой просмотра ордеров",
		PREPOSITIONAL = "плате просмотра ордеров",
	)

/obj/item/circuitboard/computer/security
	name = "Security Cameras"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/computer/security

/obj/item/circuitboard/computer/security/get_ru_names()
	return alist(
		NOMINATIVE = "плата камер безопасности",
		GENITIVE = "платы камер безопасности",
		DATIVE = "плате камер безопасности",
		ACCUSATIVE = "плату камер безопасности",
		INSTRUMENTAL = "платой камер безопасности",
		PREPOSITIONAL = "плате камер безопасности",
	)

/obj/item/circuitboard/computer/advanced_camera
	name = "Advanced Camera Console"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/computer/camera_advanced/syndie

/obj/item/circuitboard/computer/advanced_camera/get_ru_names()
	return alist(
		NOMINATIVE = "плата продвинутой консоли камер",
		GENITIVE = "платы продвинутой консоли камер",
		DATIVE = "плате продвинутой консоли камер",
		ACCUSATIVE = "плату продвинутой консоли камер",
		INSTRUMENTAL = "платой продвинутой консоли камер",
		PREPOSITIONAL = "плате продвинутой консоли камер",
	)

//Service
/obj/item/circuitboard/computer/order_console
	name = "Produce Orders Console"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/computer/order_console/cook

/obj/item/circuitboard/computer/order_console/get_ru_names()
	return alist(
		NOMINATIVE = "плата заказа продуктов",
		GENITIVE = "платы заказа продуктов",
		DATIVE = "плате заказа продуктов",
		ACCUSATIVE = "плату заказа продуктов",
		INSTRUMENTAL = "платой заказа продуктов",
		PREPOSITIONAL = "плате заказа продуктов",
	)

//Supply

/obj/item/circuitboard/computer/cargo
	name = "Supply Console"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/computer/cargo
	var/contraband = FALSE

/obj/item/circuitboard/computer/cargo/get_ru_names()
	return alist(
		NOMINATIVE = "плата консоли снабжения",
		GENITIVE = "платы консоли снабжения",
		DATIVE = "плате консоли снабжения",
		ACCUSATIVE = "плату консоли снабжения",
		INSTRUMENTAL = "платой консоли снабжения",
		PREPOSITIONAL = "плате консоли снабжения",
	)

/obj/item/circuitboard/computer/cargo/multitool_act(mob/living/user)
	. = ..()
	if(!(obj_flags & EMAGGED))
		contraband = !contraband
		to_chat(user, span_notice("Спектр приёмника установлен на [contraband ? "Широкий" : "Стандартный"]."))
	else
		to_chat(user, span_alert("Чип спектра не реагирует."))

/obj/item/circuitboard/computer/cargo/emag_act(mob/user, obj/item/card/emag/emag_card)
	if (obj_flags & EMAGGED)
		return FALSE

	contraband = TRUE
	obj_flags |= EMAGGED
	to_chat(user, span_notice("Вы настраиваете маршрутизацию и спектр приёмника [RU_SRC_GEN], открывая особые поставки и контрабанду."))
	return TRUE

/obj/item/circuitboard/computer/cargo/configure_machine(obj/machinery/computer/cargo/machine)
	if(!istype(machine))
		CRASH("Cargo board attempted to configure incorrect machine type: [machine] ([machine?.type])")

	machine.contraband = contraband
	if (obj_flags & EMAGGED)
		machine.obj_flags |= EMAGGED
	else
		machine.obj_flags &= ~EMAGGED

/obj/item/circuitboard/computer/cargo/express
	name = "Express Supply Console"
	build_path = /obj/machinery/computer/cargo/express

/obj/item/circuitboard/computer/cargo/express/get_ru_names()
	return alist(
		NOMINATIVE = "плата консоли экспресс-доставки",
		GENITIVE = "платы консоли экспресс-доставки",
		DATIVE = "плате консоли экспресс-доставки",
		ACCUSATIVE = "плату консоли экспресс-доставки",
		INSTRUMENTAL = "платой консоли экспресс-доставки",
		PREPOSITIONAL = "плате консоли экспресс-доставки",
	)

/obj/item/circuitboard/computer/cargo/express/emag_act(mob/user, obj/item/card/emag/emag_card)
	if (obj_flags & EMAGGED)
		return FALSE

	contraband = TRUE
	obj_flags |= EMAGGED
	to_chat(user, span_notice("Вы меняете протоколы маршрутизации, позволяя капсуле приземляться где угодно на станции."))
	return TRUE

/obj/item/circuitboard/computer/cargo/express/multitool_act(mob/living/user)
	if (!(obj_flags & EMAGGED))
		contraband = !contraband
		to_chat(user, span_notice("Спектр приёмника установлен на [contraband ? "Широкий" : "Стандартный"]."))
		return TRUE
	else
		to_chat(user, span_notice("Вы сбрасываете протоколы маршрутизации и спектр приёмника к заводским настройкам."))
		contraband = FALSE
		obj_flags &= ~EMAGGED
		return TRUE

/obj/item/circuitboard/computer/cargo/request
	name = "Supply Request Console"
	build_path = /obj/machinery/computer/cargo/request

/obj/item/circuitboard/computer/cargo/request/get_ru_names()
	return alist(
		NOMINATIVE = "плата консоли запроса поставок",
		GENITIVE = "платы консоли запроса поставок",
		DATIVE = "плате консоли запроса поставок",
		ACCUSATIVE = "плату консоли запроса поставок",
		INSTRUMENTAL = "платой консоли запроса поставок",
		PREPOSITIONAL = "плате консоли запроса поставок",
	)

/obj/item/circuitboard/computer/order_console/mining
	name = "Mining Vending Console"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/computer/order_console/mining

/obj/item/circuitboard/computer/order_console/mining/get_ru_names()
	return alist(
		NOMINATIVE = "плата шахтёрского вендомата",
		GENITIVE = "платы шахтёрского вендомата",
		DATIVE = "плате шахтёрского вендомата",
		ACCUSATIVE = "плату шахтёрского вендомата",
		INSTRUMENTAL = "платой шахтёрского вендомата",
		PREPOSITIONAL = "плате шахтёрского вендомата",
	)

/obj/item/circuitboard/computer/order_console/mining/golem
	name = "Golem Ship Equipment Vendor Console"
	build_path = /obj/machinery/computer/order_console/mining/golem

/obj/item/circuitboard/computer/order_console/mining/golem/get_ru_names()
	return alist(
		NOMINATIVE = "плата вендомата големов",
		GENITIVE = "платы вендомата големов",
		DATIVE = "плате вендомата големов",
		ACCUSATIVE = "плату вендомата големов",
		INSTRUMENTAL = "платой вендомата големов",
		PREPOSITIONAL = "плате вендомата големов",
	)

/obj/item/circuitboard/computer/order_console/bitrunning
	name = "Bitrunning Vendor Console"
	build_path = /obj/machinery/computer/order_console/bitrunning

/obj/item/circuitboard/computer/order_console/bitrunning/get_ru_names()
	return alist(
		NOMINATIVE = "плата вендомата битраннеров",
		GENITIVE = "платы вендомата битраннеров",
		DATIVE = "плате вендомата битраннеров",
		ACCUSATIVE = "плату вендомата битраннеров",
		INSTRUMENTAL = "платой вендомата битраннеров",
		PREPOSITIONAL = "плате вендомата битраннеров",
	)

/obj/item/circuitboard/computer/ferry
	name = "Transport Ferry"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/computer/shuttle/ferry

/obj/item/circuitboard/computer/ferry/get_ru_names()
	return alist(
		NOMINATIVE = "плата транспортного парома",
		GENITIVE = "платы транспортного парома",
		DATIVE = "плате транспортного парома",
		ACCUSATIVE = "плату транспортного парома",
		INSTRUMENTAL = "платой транспортного парома",
		PREPOSITIONAL = "плате транспортного парома",
	)

/obj/item/circuitboard/computer/ferry/request
	name = "Transport Ferry Console"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/computer/shuttle/ferry/request

/obj/item/circuitboard/computer/ferry/request/get_ru_names()
	return alist(
		NOMINATIVE = "плата вызова транспортного парома",
		GENITIVE = "платы вызова транспортного парома",
		DATIVE = "плате вызова транспортного парома",
		ACCUSATIVE = "плату вызова транспортного парома",
		INSTRUMENTAL = "платой вызова транспортного парома",
		PREPOSITIONAL = "плате вызова транспортного парома",
	)

/obj/item/circuitboard/computer/mining
	name = "Outpost Status Display"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/computer/security/mining

/obj/item/circuitboard/computer/mining/get_ru_names()
	return alist(
		NOMINATIVE = "плата дисплея статуса аванпоста",
		GENITIVE = "платы дисплея статуса аванпоста",
		DATIVE = "плате дисплея статуса аванпоста",
		ACCUSATIVE = "плату дисплея статуса аванпоста",
		INSTRUMENTAL = "платой дисплея статуса аванпоста",
		PREPOSITIONAL = "плате дисплея статуса аванпоста",
	)

/obj/item/circuitboard/computer/mining_shuttle
	name = "Mining Shuttle"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/computer/shuttle/mining

/obj/item/circuitboard/computer/mining_shuttle/get_ru_names()
	return alist(
		NOMINATIVE = "плата шахтёрского шаттла",
		GENITIVE = "платы шахтёрского шаттла",
		DATIVE = "плате шахтёрского шаттла",
		ACCUSATIVE = "плату шахтёрского шаттла",
		INSTRUMENTAL = "платой шахтёрского шаттла",
		PREPOSITIONAL = "плате шахтёрского шаттла",
	)

/obj/item/circuitboard/computer/mining_shuttle/common
	name = "Lavaland Shuttle"
	build_path = /obj/machinery/computer/shuttle/mining/common

/obj/item/circuitboard/computer/mining_shuttle/common/get_ru_names()
	return alist(
		NOMINATIVE = "плата лавового шаттла",
		GENITIVE = "платы лавового шаттла",
		DATIVE = "плате лавового шаттла",
		ACCUSATIVE = "плату лавового шаттла",
		INSTRUMENTAL = "платой лавового шаттла",
		PREPOSITIONAL = "плате лавового шаттла",
	)

/obj/item/circuitboard/computer/emergency_pod
	name = "Emergency Pod Controls"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/shuttle/pod

/obj/item/circuitboard/computer/emergency_pod/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления аварийной капсулой",
		GENITIVE = "платы управления аварийной капсулой",
		DATIVE = "плате управления аварийной капсулой",
		ACCUSATIVE = "плату управления аварийной капсулой",
		INSTRUMENTAL = "платой управления аварийной капсулой",
		PREPOSITIONAL = "плате управления аварийной капсулой",
	)

/obj/item/circuitboard/computer/exoscanner_console
	name = "Scanner Array Control Console"
	build_path = /obj/machinery/computer/exoscanner_control

/obj/item/circuitboard/computer/exoscanner_console/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления массивом сканеров",
		GENITIVE = "платы управления массивом сканеров",
		DATIVE = "плате управления массивом сканеров",
		ACCUSATIVE = "плату управления массивом сканеров",
		INSTRUMENTAL = "платой управления массивом сканеров",
		PREPOSITIONAL = "плате управления массивом сканеров",
	)

/obj/item/circuitboard/computer/exodrone_console
	name = "Exploration Drone Control Console"
	build_path = /obj/machinery/computer/exodrone_control_console

/obj/item/circuitboard/computer/exodrone_console/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления исследовательским дроном",
		GENITIVE = "платы управления исследовательским дроном",
		DATIVE = "плате управления исследовательским дроном",
		ACCUSATIVE = "плату управления исследовательским дроном",
		INSTRUMENTAL = "платой управления исследовательским дроном",
		PREPOSITIONAL = "плате управления исследовательским дроном",
	)

/obj/item/circuitboard/computer/shuttle
	var/shuttle_id

/obj/item/circuitboard/computer/shuttle/configure_machine(obj/machinery/machine)
	var/obj/docking_port/mobile/custom/shuttle = shuttle_id ? SSshuttle.getShuttle(shuttle_id) : SSshuttle.get_containing_shuttle(machine)
	if(!shuttle)
		var/on_shuttle_frame = HAS_TRAIT((get_turf(machine)), TRAIT_SHUTTLE_CONSTRUCTION_TURF)
		machine.say(on_shuttle_frame ? "Консоль автоматически подключится после завершения строительства шаттла." : "Нет доступных шаттлов для подключения.")
	else if(!istype(shuttle))
		machine.say("Невозможно подключиться к такому типу шаттла!")
	else
		machine.connect_to_shuttle(TRUE, shuttle)

/obj/item/circuitboard/computer/shuttle/flight_control
	name = "Shuttle Flight Control"
	build_path = /obj/machinery/computer/shuttle/custom_shuttle

/obj/item/circuitboard/computer/shuttle/flight_control/get_ru_names()
	return alist(
		NOMINATIVE = "плата управления полётом шаттла",
		GENITIVE = "платы управления полётом шаттла",
		DATIVE = "плате управления полётом шаттла",
		ACCUSATIVE = "плату управления полётом шаттла",
		INSTRUMENTAL = "платой управления полётом шаттла",
		PREPOSITIONAL = "плате управления полётом шаттла",
	)

/obj/item/circuitboard/computer/shuttle/docker
	name = "Shuttle Navigation Computer"
	build_path = /obj/machinery/computer/camera_advanced/shuttle_docker/custom

/obj/item/circuitboard/computer/shuttle/docker/get_ru_names()
	return alist(
		NOMINATIVE = "плата навигации шаттла",
		GENITIVE = "платы навигации шаттла",
		DATIVE = "плате навигации шаттла",
		ACCUSATIVE = "плату навигации шаттла",
		INSTRUMENTAL = "платой навигации шаттла",
		PREPOSITIONAL = "плате навигации шаттла",
	)
