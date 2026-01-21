//Command

/obj/item/circuitboard/machine/bsa/back
	name = "Bluespace Artillery Generator"
	greyscale_colors = CIRCUIT_COLOR_COMMAND
	build_path = /obj/machinery/bsa/back //No freebies!
	specific_parts = TRUE
	req_components = list(
		/datum/stock_part/capacitor/tier4 = 5,
		/obj/item/stack/cable_coil = 2)

/obj/item/circuitboard/machine/bsa/back/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата генератора БСА",
		GENITIVE = "машинной платы генератора БСА",
		DATIVE = "машинной плате генератора БСА",
		ACCUSATIVE = "машинную плату генератора БСА",
		INSTRUMENTAL = "машинной платой генератора БСА",
		PREPOSITIONAL = "машинной плате генератора БСА",
	)

/obj/item/circuitboard/machine/bsa/front
	name = "Bluespace Artillery Bore"
	greyscale_colors = CIRCUIT_COLOR_COMMAND
	build_path = /obj/machinery/bsa/front
	specific_parts = TRUE
	req_components = list(
		/datum/stock_part/servo/tier4 = 5,
		/obj/item/stack/cable_coil = 2)

/obj/item/circuitboard/machine/bsa/front/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата дула БСА",
		GENITIVE = "машинной платы дула БСА",
		DATIVE = "машинной плате дула БСА",
		ACCUSATIVE = "машинную плату дула БСА",
		INSTRUMENTAL = "машинной платой дула БСА",
		PREPOSITIONAL = "машинной плате дула БСА",
	)

/obj/item/circuitboard/machine/bsa/middle
	name = "Bluespace Artillery Fusor"
	greyscale_colors = CIRCUIT_COLOR_COMMAND
	build_path = /obj/machinery/bsa/middle
	req_components = list(
		/obj/item/stack/ore/bluespace_crystal = 20,
		/obj/item/stack/cable_coil = 2)

/obj/item/circuitboard/machine/bsa/middle/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата фузора БСА",
		GENITIVE = "машинной платы фузора БСА",
		DATIVE = "машинной плате фузора БСА",
		ACCUSATIVE = "машинную плату фузора БСА",
		INSTRUMENTAL = "машинной платой фузора БСА",
		PREPOSITIONAL = "машинной плате фузора БСА",
	)

/obj/item/circuitboard/machine/dna_vault
	name = "DNA Vault"
	greyscale_colors = CIRCUIT_COLOR_COMMAND
	build_path = /obj/machinery/dna_vault //No freebies!
	specific_parts = TRUE
	req_components = list(
		/datum/stock_part/capacitor/tier3 = 5,
		/datum/stock_part/servo/tier3 = 5,
		/obj/item/stack/cable_coil = 2)

/obj/item/circuitboard/machine/dna_vault/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата хранилища ДНК",
		GENITIVE = "машинной платы хранилища ДНК",
		DATIVE = "машинной плате хранилища ДНК",
		ACCUSATIVE = "машинную плату хранилища ДНК",
		INSTRUMENTAL = "машинной платой хранилища ДНК",
		PREPOSITIONAL = "машинной плате хранилища ДНК",
	)

//Engineering

/obj/item/circuitboard/machine/announcement_system
	name = "Announcement System"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/announcement_system
	req_components = list(
		/obj/item/stack/cable_coil = 2,
		/obj/item/stack/sheet/glass = 1)

/obj/item/circuitboard/machine/announcement_system/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата системы оповещения",
		GENITIVE = "машинной платы системы оповещения",
		DATIVE = "машинной плате системы оповещения",
		ACCUSATIVE = "машинную плату системы оповещения",
		INSTRUMENTAL = "машинной платой системы оповещения",
		PREPOSITIONAL = "машинной плате системы оповещения",
	)

/obj/item/circuitboard/machine/suit_storage_unit
	name = "Suit Storage Unit"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/suit_storage_unit
	req_components = list(
		/obj/item/stack/sheet/glass = 2,
		/obj/item/stack/cable_coil = 5,
		/datum/stock_part/capacitor = 1,
		/obj/item/electronics/airlock = 1)

/obj/item/circuitboard/machine/suit_storage_unit/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата хранилища скафандров",
		GENITIVE = "машинной платы хранилища скафандров",
		DATIVE = "машинной плате хранилища скафандров",
		ACCUSATIVE = "машинную плату хранилища скафандров",
		INSTRUMENTAL = "машинной платой хранилища скафандров",
		PREPOSITIONAL = "машинной плате хранилища скафандров",
	)

/obj/item/circuitboard/machine/mass_driver
	name = "Mass Driver"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/mass_driver
	req_components = list(
		/datum/stock_part/servo = 1,)

/obj/item/circuitboard/machine/mass_driver/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата масс-драйвера",
		GENITIVE = "машинной платы масс-драйвера",
		DATIVE = "машинной плате масс-драйвера",
		ACCUSATIVE = "машинную плату масс-драйвера",
		INSTRUMENTAL = "машинной платой масс-драйвера",
		PREPOSITIONAL = "машинной плате масс-драйвера",
	)

/obj/item/circuitboard/machine/autolathe
	name = "Autolathe"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/autolathe
	req_components = list(
		/datum/stock_part/matter_bin = 3,
		/datum/stock_part/servo = 1,
		/obj/item/stack/sheet/glass = 1)

/obj/item/circuitboard/machine/autolathe/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата автолата",
		GENITIVE = "машинной платы автолата",
		DATIVE = "машинной плате автолата",
		ACCUSATIVE = "машинную плату автолата",
		INSTRUMENTAL = "машинной платой автолата",
		PREPOSITIONAL = "машинной плате автолата",
	)

/obj/item/circuitboard/machine/grounding_rod
	name = "Grounding Rod"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/energy_accumulator/grounding_rod
	req_components = list(/datum/stock_part/capacitor = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/grounding_rod/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата заземляющего стержня",
		GENITIVE = "машинной платы заземляющего стержня",
		DATIVE = "машинной плате заземляющего стержня",
		ACCUSATIVE = "машинную плату заземляющего стержня",
		INSTRUMENTAL = "машинной платой заземляющего стержня",
		PREPOSITIONAL = "машинной плате заземляющего стержня",
	)

/obj/item/circuitboard/machine/telecomms/broadcaster
	name = "Subspace Broadcaster"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/telecomms/broadcaster
	req_components = list(
		/datum/stock_part/servo = 2,
		/obj/item/stack/cable_coil = 1,
		/datum/stock_part/filter = 1,
		/datum/stock_part/crystal = 1,
		/datum/stock_part/micro_laser = 2,
	)

/obj/item/circuitboard/machine/telecomms/broadcaster/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата подпространственного вещателя",
		GENITIVE = "машинной платы подпространственного вещателя",
		DATIVE = "машинной плате подпространственного вещателя",
		ACCUSATIVE = "машинную плату подпространственного вещателя",
		INSTRUMENTAL = "машинной платой подпространственного вещателя",
		PREPOSITIONAL = "машинной плате подпространственного вещателя",
	)

/obj/item/circuitboard/machine/telecomms/bus
	name = "Bus Mainframe"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/telecomms/bus
	req_components = list(
		/datum/stock_part/servo = 2,
		/obj/item/stack/cable_coil = 1,
		/datum/stock_part/filter = 1,
	)

/obj/item/circuitboard/machine/telecomms/bus/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата шины мейнфрейма",
		GENITIVE = "машинной платы шины мейнфрейма",
		DATIVE = "машинной плате шины мейнфрейма",
		ACCUSATIVE = "машинную плату шины мейнфрейма",
		INSTRUMENTAL = "машинной платой шины мейнфрейма",
		PREPOSITIONAL = "машинной плате шины мейнфрейма",
	)

/obj/item/circuitboard/machine/telecomms/hub
	name = "Hub Mainframe"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/telecomms/hub
	req_components = list(
		/datum/stock_part/servo = 2,
		/obj/item/stack/cable_coil = 2,
		/datum/stock_part/filter = 2,
	)

/obj/item/circuitboard/machine/telecomms/hub/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата хаба мейнфрейма",
		GENITIVE = "машинной платы хаба мейнфрейма",
		DATIVE = "машинной плате хаба мейнфрейма",
		ACCUSATIVE = "машинную плату хаба мейнфрейма",
		INSTRUMENTAL = "машинной платой хаба мейнфрейма",
		PREPOSITIONAL = "машинной плате хаба мейнфрейма",
	)

/obj/item/circuitboard/machine/telecomms/message_server
	name = "Messaging Server"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/telecomms/message_server
	req_components = list(
		/datum/stock_part/servo = 2,
		/obj/item/stack/cable_coil = 1,
		/datum/stock_part/filter = 3,
	)

/obj/item/circuitboard/machine/telecomms/message_server/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата сервера сообщений",
		GENITIVE = "машинной платы сервера сообщений",
		DATIVE = "машинной плате сервера сообщений",
		ACCUSATIVE = "машинную плату сервера сообщений",
		INSTRUMENTAL = "машинной платой сервера сообщений",
		PREPOSITIONAL = "машинной плате сервера сообщений",
	)

/obj/item/circuitboard/machine/telecomms/processor
	name = "Processor Unit"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/telecomms/processor
	req_components = list(
		/datum/stock_part/servo = 3,
		/datum/stock_part/filter = 1,
		/datum/stock_part/treatment = 2,
		/datum/stock_part/analyzer = 1,
		/obj/item/stack/cable_coil = 2,
		/datum/stock_part/amplifier = 1,
	)

/obj/item/circuitboard/machine/telecomms/processor/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата процессорного модуля",
		GENITIVE = "машинной платы процессорного модуля",
		DATIVE = "машинной плате процессорного модуля",
		ACCUSATIVE = "машинную плату процессорного модуля",
		INSTRUMENTAL = "машинной платой процессорного модуля",
		PREPOSITIONAL = "машинной плате процессорного модуля",
	)

/obj/item/circuitboard/machine/telecomms/receiver
	name = "Subspace Receiver"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/telecomms/receiver
	req_components = list(
		/datum/stock_part/ansible = 1,
		/datum/stock_part/filter = 1,
		/datum/stock_part/servo = 2,
		/datum/stock_part/micro_laser = 1,
	)

/obj/item/circuitboard/machine/telecomms/receiver/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата подпространственного приёмника",
		GENITIVE = "машинной платы подпространственного приёмника",
		DATIVE = "машинной плате подпространственного приёмника",
		ACCUSATIVE = "машинную плату подпространственного приёмника",
		INSTRUMENTAL = "машинной платой подпространственного приёмника",
		PREPOSITIONAL = "машинной плате подпространственного приёмника",
	)

/obj/item/circuitboard/machine/telecomms/relay
	name = "Relay Mainframe"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/telecomms/relay
	req_components = list(
		/datum/stock_part/servo = 2,
		/obj/item/stack/cable_coil = 2,
		/datum/stock_part/filter = 2,
	)

/obj/item/circuitboard/machine/telecomms/relay/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата реле мейнфрейма",
		GENITIVE = "машинной платы реле мейнфрейма",
		DATIVE = "машинной плате реле мейнфрейма",
		ACCUSATIVE = "машинную плату реле мейнфрейма",
		INSTRUMENTAL = "машинной платой реле мейнфрейма",
		PREPOSITIONAL = "машинной плате реле мейнфрейма",
	)

/obj/item/circuitboard/machine/telecomms/server
	name = "Telecommunication Server"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/telecomms/server
	req_components = list(
		/datum/stock_part/servo = 2,
		/obj/item/stack/cable_coil = 1,
		/datum/stock_part/filter = 1,
	)

/obj/item/circuitboard/machine/telecomms/server/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата телекоммуникационного сервера",
		GENITIVE = "машинной платы телекоммуникационного сервера",
		DATIVE = "машинной плате телекоммуникационного сервера",
		ACCUSATIVE = "машинную плату телекоммуникационного сервера",
		INSTRUMENTAL = "машинной платой телекоммуникационного сервера",
		PREPOSITIONAL = "машинной плате телекоммуникационного сервера",
	)

/obj/item/circuitboard/machine/tesla_coil
	name = "Tesla Controller"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	desc = "Does not let you shoot lightning from your hands."
	build_path = /obj/machinery/power/energy_accumulator/tesla_coil
	req_components = list(/datum/stock_part/capacitor = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/tesla_coil/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата контроллера Теслы",
		GENITIVE = "машинной платы контроллера Теслы",
		DATIVE = "машинной плате контроллера Теслы",
		ACCUSATIVE = "машинную плату контроллера Теслы",
		INSTRUMENTAL = "машинной платой контроллера Теслы",
		PREPOSITIONAL = "машинной плате контроллера Теслы",
	)

/obj/item/circuitboard/machine/modular_shield_generator/gate
	name = "Modular Shield Gate"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/modular_shield_generator/gate
	req_components = list(
		/datum/stock_part/servo = 1,
		/datum/stock_part/micro_laser = 1,
		/datum/stock_part/capacitor = 1,
		/obj/item/stack/sheet/plasteel = 2,
	)

/obj/item/circuitboard/machine/modular_shield_generator/gate/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата врат модульного щита",
		GENITIVE = "машинной платы врат модульного щита",
		DATIVE = "машинной плате врат модульного щита",
		ACCUSATIVE = "машинную плату врат модульного щита",
		INSTRUMENTAL = "машинной платой врат модульного щита",
		PREPOSITIONAL = "машинной плате врат модульного щита",
	)

/obj/item/circuitboard/machine/modular_shield_generator
	name = "Modular Shield Generator"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/modular_shield_generator
	req_components = list(
		/datum/stock_part/servo = 1,
		/datum/stock_part/micro_laser = 1,
		/datum/stock_part/capacitor = 1,
		/obj/item/stack/sheet/plasteel = 3,
	)

/obj/item/circuitboard/machine/modular_shield_generator/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата модульного генератора щита",
		GENITIVE = "машинной платы модульного генератора щита",
		DATIVE = "машинной плате модульного генератора щита",
		ACCUSATIVE = "машинную плату модульного генератора щита",
		INSTRUMENTAL = "машинной платой модульного генератора щита",
		PREPOSITIONAL = "машинной плате модульного генератора щита",
	)

/obj/item/circuitboard/machine/modular_shield_node
	name = "Modular Shield Node"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/modular_shield/module/node
	req_components = list(
		/obj/item/stack/cable_coil = 15,
		/obj/item/stack/sheet/plasteel = 2,
	)

/obj/item/circuitboard/machine/modular_shield_node/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата узла модульного щита",
		GENITIVE = "машинной платы узла модульного щита",
		DATIVE = "машинной плате узла модульного щита",
		ACCUSATIVE = "машинную плату узла модульного щита",
		INSTRUMENTAL = "машинной платой узла модульного щита",
		PREPOSITIONAL = "машинной плате узла модульного щита",
	)

/obj/item/circuitboard/machine/modular_shield_cable
	name = "Modular Shield Cable"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/modular_shield/module/node/cable
	req_components = list(
		/obj/item/stack/sheet/plasteel = 1,
	)

/obj/item/circuitboard/machine/modular_shield_cable/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата кабеля модульного щита",
		GENITIVE = "машинной платы кабеля модульного щита",
		DATIVE = "машинной плате кабеля модульного щита",
		ACCUSATIVE = "машинную плату кабеля модульного щита",
		INSTRUMENTAL = "машинной платой кабеля модульного щита",
		PREPOSITIONAL = "машинной плате кабеля модульного щита",
	)

/obj/item/circuitboard/machine/modular_shield_well
	name = "Modular Shield Well"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/modular_shield/module/well
	req_components = list(
		/datum/stock_part/capacitor = 3,
		/obj/item/stack/sheet/plasteel = 2,
	)

/obj/item/circuitboard/machine/modular_shield_well/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата колодца модульного щита",
		GENITIVE = "машинной платы колодца модульного щита",
		DATIVE = "машинной плате колодца модульного щита",
		ACCUSATIVE = "машинную плату колодца модульного щита",
		INSTRUMENTAL = "машинной платой колодца модульного щита",
		PREPOSITIONAL = "машинной плате колодца модульного щита",
	)

/obj/item/circuitboard/machine/modular_shield_relay
	name = "Modular Shield Relay"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/modular_shield/module/relay
	req_components = list(
		/datum/stock_part/micro_laser = 3,
		/obj/item/stack/sheet/plasteel = 2,
	)

/obj/item/circuitboard/machine/modular_shield_relay/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата реле модульного щита",
		GENITIVE = "машинной платы реле модульного щита",
		DATIVE = "машинной плате реле модульного щита",
		ACCUSATIVE = "машинную плату реле модульного щита",
		INSTRUMENTAL = "машинной платой реле модульного щита",
		PREPOSITIONAL = "машинной плате реле модульного щита",
	)

/obj/item/circuitboard/machine/modular_shield_charger
	name = "Modular Shield Charger"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/modular_shield/module/charger
	req_components = list(
		/datum/stock_part/servo = 3,
		/obj/item/stack/sheet/plasteel = 2,
	)

/obj/item/circuitboard/machine/modular_shield_charger/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата зарядника модульного щита",
		GENITIVE = "машинной платы зарядника модульного щита",
		DATIVE = "машинной плате зарядника модульного щита",
		ACCUSATIVE = "машинную плату зарядника модульного щита",
		INSTRUMENTAL = "машинной платой зарядника модульного щита",
		PREPOSITIONAL = "машинной плате зарядника модульного щита",
	)

/obj/item/circuitboard/machine/cell_charger
	name = "Cell Charger"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/cell_charger
	req_components = list(/datum/stock_part/capacitor = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/cell_charger/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата зарядника батареек",
		GENITIVE = "машинной платы зарядника батареек",
		DATIVE = "машинной плате зарядника батареек",
		ACCUSATIVE = "машинную плату зарядника батареек",
		INSTRUMENTAL = "машинной платой зарядника батареек",
		PREPOSITIONAL = "машинной плате зарядника батареек",
	)

/obj/item/circuitboard/machine/circulator
	name = "Circulator/Heat Exchanger"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/atmospherics/components/binary/circulator
	req_components = list()

/obj/item/circuitboard/machine/circulator/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата циркулятора",
		GENITIVE = "машинной платы циркулятора",
		DATIVE = "машинной плате циркулятора",
		ACCUSATIVE = "машинную плату циркулятора",
		INSTRUMENTAL = "машинной платой циркулятора",
		PREPOSITIONAL = "машинной плате циркулятора",
	)

/obj/item/circuitboard/machine/emitter
	name = "Emitter"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/emitter
	req_components = list(
		/datum/stock_part/micro_laser = 1,
		/datum/stock_part/servo = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/emitter/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата излучателя",
		GENITIVE = "машинной платы излучателя",
		DATIVE = "машинной плате излучателя",
		ACCUSATIVE = "машинную плату излучателя",
		INSTRUMENTAL = "машинной платой излучателя",
		PREPOSITIONAL = "машинной плате излучателя",
	)

/obj/item/circuitboard/machine/thermoelectric_generator
	name = "Thermo-Electric Generator"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/thermoelectric_generator
	req_components = list()

/obj/item/circuitboard/machine/thermoelectric_generator/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата ТЭГ",
		GENITIVE = "машинной платы ТЭГ",
		DATIVE = "машинной плате ТЭГ",
		ACCUSATIVE = "машинную плату ТЭГ",
		INSTRUMENTAL = "машинной платой ТЭГ",
		PREPOSITIONAL = "машинной плате ТЭГ",
	)

/obj/item/circuitboard/machine/ntnet_relay
	name = "NTNet Relay"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/ntnet_relay
	req_components = list(
		/obj/item/stack/cable_coil = 2,
		/datum/stock_part/filter = 1,
	)

/obj/item/circuitboard/machine/ntnet_relay/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата реле NTNet",
		GENITIVE = "машинной платы реле NTNet",
		DATIVE = "машинной плате реле NTNet",
		ACCUSATIVE = "машинную плату реле NTNet",
		INSTRUMENTAL = "машинной платой реле NTNet",
		PREPOSITIONAL = "машинной плате реле NTNet",
	)

/obj/item/circuitboard/machine/pacman
	name = "PACMAN-type Generator"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/port_gen/pacman
	req_components = list(
		/obj/item/stack/cable_coil = 5,
		/obj/item/stack/sheet/iron = 5
	)
	needs_anchored = FALSE
	var/high_production_profile = FALSE

/obj/item/circuitboard/machine/pacman/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата генератора ПАКМАН",
		GENITIVE = "машинной платы генератора ПАКМАН",
		DATIVE = "машинной плате генератора ПАКМАН",
		ACCUSATIVE = "машинную плату генератора ПАКМАН",
		INSTRUMENTAL = "машинной платой генератора ПАКМАН",
		PREPOSITIONAL = "машинной плате генератора ПАКМАН",
	)

/obj/item/circuitboard/machine/pacman/examine(mob/user)
	. = ..()
	var/message = high_production_profile ? "режим урана высокой мощности" : "режим плазмы средней мощности"
	. += span_notice("Установлен [message].")
	. += span_notice("Вы можете переключить режим, используя отвёртку на [RU_SRC_PRE].")

/obj/item/circuitboard/machine/pacman/screwdriver_act(mob/living/user, obj/item/tool)
	high_production_profile = !high_production_profile
	var/message = high_production_profile ? "режим урана высокой мощности" : "режим плазмы средней мощности"
	to_chat(user, span_notice("Вы переключаете плату на [message]"))

/obj/item/circuitboard/machine/turbine_compressor
	name = "Turbine - Inlet Compressor"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/turbine/inlet_compressor
	req_components = list(
		/obj/item/stack/cable_coil = 5,
		/obj/item/stack/sheet/iron = 5)

/obj/item/circuitboard/machine/turbine_compressor/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата входного компрессора турбины",
		GENITIVE = "машинной платы входного компрессора турбины",
		DATIVE = "машинной плате входного компрессора турбины",
		ACCUSATIVE = "машинную плату входного компрессора турбины",
		INSTRUMENTAL = "машинной платой входного компрессора турбины",
		PREPOSITIONAL = "машинной плате входного компрессора турбины",
	)

/obj/item/circuitboard/machine/turbine_rotor
	name = "Turbine - Core Rotor"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/turbine/core_rotor
	req_components = list(
		/obj/item/stack/cable_coil = 5,
		/obj/item/stack/sheet/iron = 5)

/obj/item/circuitboard/machine/turbine_rotor/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата ротора ядра турбины",
		GENITIVE = "машинной платы ротора ядра турбины",
		DATIVE = "машинной плате ротора ядра турбины",
		ACCUSATIVE = "машинную плату ротора ядра турбины",
		INSTRUMENTAL = "машинной платой ротора ядра турбины",
		PREPOSITIONAL = "машинной плате ротора ядра турбины",
	)

/obj/item/circuitboard/machine/turbine_stator
	name = "Turbine - Turbine Outlet"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/turbine/turbine_outlet
	req_components = list(
		/obj/item/stack/cable_coil = 5,
		/obj/item/stack/sheet/iron = 5)

/obj/item/circuitboard/machine/turbine_stator/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата выходного патрубка турбины",
		GENITIVE = "машинной платы выходного патрубка турбины",
		DATIVE = "машинной плате выходного патрубка турбины",
		ACCUSATIVE = "машинную плату выходного патрубка турбины",
		INSTRUMENTAL = "машинной платой выходного патрубка турбины",
		PREPOSITIONAL = "машинной плате выходного патрубка турбины",
	)

/obj/item/circuitboard/machine/protolathe/department/engineering
	name = "Departmental Protolathe - Engineering"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/rnd/production/protolathe/department/engineering

/obj/item/circuitboard/machine/protolathe/department/engineering/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата инженерного протолата",
		GENITIVE = "машинной платы инженерного протолата",
		DATIVE = "машинной плате инженерного протолата",
		ACCUSATIVE = "машинную плату инженерного протолата",
		INSTRUMENTAL = "машинной платой инженерного протолата",
		PREPOSITIONAL = "машинной плате инженерного протолата",
	)

/obj/item/circuitboard/machine/rtg
	name = "RTG"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/rtg
	req_components = list(
		/obj/item/stack/cable_coil = 5,
		/datum/stock_part/capacitor = 1,
		/obj/item/stack/sheet/mineral/uranium = 10) // We have no Pu-238, and this is the closest thing to it.

/obj/item/circuitboard/machine/rtg/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата РИТЭГ",
		GENITIVE = "машинной платы РИТЭГ",
		DATIVE = "машинной плате РИТЭГ",
		ACCUSATIVE = "машинную плату РИТЭГ",
		INSTRUMENTAL = "машинной платой РИТЭГ",
		PREPOSITIONAL = "машинной плате РИТЭГ",
	)

/obj/item/circuitboard/machine/rtg/advanced
	name = "Advanced RTG"
	build_path = /obj/machinery/power/rtg/advanced
	req_components = list(
		/obj/item/stack/cable_coil = 5,
		/datum/stock_part/capacitor = 1,
		/datum/stock_part/micro_laser = 1,
		/obj/item/stack/sheet/mineral/uranium = 10,
		/obj/item/stack/sheet/mineral/plasma = 5)

/obj/item/circuitboard/machine/rtg/advanced/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата продвинутого РИТЭГ",
		GENITIVE = "машинной платы продвинутого РИТЭГ",
		DATIVE = "машинной плате продвинутого РИТЭГ",
		ACCUSATIVE = "машинную плату продвинутого РИТЭГ",
		INSTRUMENTAL = "машинной платой продвинутого РИТЭГ",
		PREPOSITIONAL = "машинной плате продвинутого РИТЭГ",
	)

/obj/item/circuitboard/machine/scanner_gate
	name = "Scanner Gate"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/scanner_gate
	req_components = list(
		/datum/stock_part/scanning_module = 3)

/obj/item/circuitboard/machine/scanner_gate/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата сканирующих ворот",
		GENITIVE = "машинной платы сканирующих ворот",
		DATIVE = "машинной плате сканирующих ворот",
		ACCUSATIVE = "машинную плату сканирующих ворот",
		INSTRUMENTAL = "машинной платой сканирующих ворот",
		PREPOSITIONAL = "машинной плате сканирующих ворот",
	)

/obj/item/circuitboard/machine/smes
	name = "SMES"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/smes
	req_components = list(
		/obj/item/stack/cable_coil = 5,
		/obj/item/stock_parts/power_store/battery = 5,
		/datum/stock_part/capacitor = 1)
	def_components = list(/obj/item/stock_parts/power_store/battery = /obj/item/stock_parts/power_store/battery/high/empty)

/obj/item/circuitboard/machine/smes/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата СМЕС",
		GENITIVE = "машинной платы СМЕС",
		DATIVE = "машинной плате СМЕС",
		ACCUSATIVE = "машинную плату СМЕС",
		INSTRUMENTAL = "машинной платой СМЕС",
		PREPOSITIONAL = "машинной плате СМЕС",
	)

/obj/item/circuitboard/machine/smes/connector
	name = "power connector"
	build_path = /obj/machinery/power/smes/connector
	req_components = list(
		/obj/item/stack/cable_coil = 5,
		/datum/stock_part/capacitor = 1,)

/obj/item/circuitboard/machine/smes/connector/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата коннектора питания",
		GENITIVE = "машинной платы коннектора питания",
		DATIVE = "машинной плате коннектора питания",
		ACCUSATIVE = "машинную плату коннектора питания",
		INSTRUMENTAL = "машинной платой коннектора питания",
		PREPOSITIONAL = "машинной плате коннектора питания",
	)

/obj/item/circuitboard/machine/smesbank
	name = "portable SMES"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	needs_anchored = FALSE
	build_path = /obj/machinery/smesbank
	req_components = list(
		/obj/item/stack/cable_coil = 5,
		/obj/item/stock_parts/power_store/battery = 5,)
	def_components = list(/obj/item/stock_parts/power_store/battery = /obj/item/stock_parts/power_store/battery/high/empty)

/obj/item/circuitboard/machine/smesbank/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата портативного СМЕС",
		GENITIVE = "машинной платы портативного СМЕС",
		DATIVE = "машинной плате портативного СМЕС",
		ACCUSATIVE = "машинную плату портативного СМЕС",
		INSTRUMENTAL = "машинной платой портативного СМЕС",
		PREPOSITIONAL = "машинной плате портативного СМЕС",
	)

/obj/item/circuitboard/machine/techfab/department/engineering
	name = "\improper Departmental Techfab - Engineering"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/rnd/production/techfab/department/engineering

/obj/item/circuitboard/machine/techfab/department/engineering/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата инженерного техфаба",
		GENITIVE = "машинной платы инженерного техфаба",
		DATIVE = "машинной плате инженерного техфаба",
		ACCUSATIVE = "машинную плату инженерного техфаба",
		INSTRUMENTAL = "машинной платой инженерного техфаба",
		PREPOSITIONAL = "машинной плате инженерного техфаба",
	)

/obj/item/circuitboard/machine/smes/super
	def_components = list(/obj/item/stock_parts/power_store/battery = /obj/item/stock_parts/power_store/battery/super/empty)

/obj/item/circuitboard/machine/smesbank/super
	def_components = list(/obj/item/stock_parts/power_store/battery = /obj/item/stock_parts/power_store/battery/super/empty)

/obj/item/circuitboard/machine/thermomachine
	name = "Thermomachine"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/atmospherics/components/unary/thermomachine/freezer
	var/pipe_layer = PIPING_LAYER_DEFAULT
	req_components = list(
		/datum/stock_part/matter_bin = 2,
		/datum/stock_part/micro_laser = 2,
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/glass = 1)

/obj/item/circuitboard/machine/thermomachine/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата термомашины",
		GENITIVE = "машинной платы термомашины",
		DATIVE = "машинной плате термомашины",
		ACCUSATIVE = "машинную плату термомашины",
		INSTRUMENTAL = "машинной платой термомашины",
		PREPOSITIONAL = "машинной плате термомашины",
	)

/obj/item/circuitboard/machine/thermomachine/multitool_act(mob/living/user, obj/item/multitool/multitool)
	. = ..()
	pipe_layer = (pipe_layer >= PIPING_LAYER_MAX) ? PIPING_LAYER_MIN : (pipe_layer + 1)
	to_chat(user, span_notice("Вы меняете слой платы на [pipe_layer]."))

/obj/item/circuitboard/machine/thermomachine/examine()
	. = ..()
	. += span_notice("Установлена на слой [pipe_layer].")

/obj/item/circuitboard/machine/HFR_fuel_input
	name = "HFR Fuel Input"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/atmospherics/components/unary/hypertorus/fuel_input
	req_components = list(
		/obj/item/stack/sheet/plasteel = 5)

/obj/item/circuitboard/machine/HFR_fuel_input/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата ввода топлива HFR",
		GENITIVE = "машинной платы ввода топлива HFR",
		DATIVE = "машинной плате ввода топлива HFR",
		ACCUSATIVE = "машинную плату ввода топлива HFR",
		INSTRUMENTAL = "машинной платой ввода топлива HFR",
		PREPOSITIONAL = "машинной плате ввода топлива HFR",
	)

/obj/item/circuitboard/machine/HFR_waste_output
	name = "HFR Waste Output"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/atmospherics/components/unary/hypertorus/waste_output
	req_components = list(
		/obj/item/stack/sheet/plasteel = 5)

/obj/item/circuitboard/machine/HFR_waste_output/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата вывода отходов HFR",
		GENITIVE = "машинной платы вывода отходов HFR",
		DATIVE = "машинной плате вывода отходов HFR",
		ACCUSATIVE = "машинную плату вывода отходов HFR",
		INSTRUMENTAL = "машинной платой вывода отходов HFR",
		PREPOSITIONAL = "машинной плате вывода отходов HFR",
	)

/obj/item/circuitboard/machine/HFR_moderator_input
	name = "HFR Moderator Input"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/atmospherics/components/unary/hypertorus/moderator_input
	req_components = list(
		/obj/item/stack/sheet/plasteel = 5)

/obj/item/circuitboard/machine/HFR_moderator_input/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата ввода замедлителя HFR",
		GENITIVE = "машинной платы ввода замедлителя HFR",
		DATIVE = "машинной плате ввода замедлителя HFR",
		ACCUSATIVE = "машинную плату ввода замедлителя HFR",
		INSTRUMENTAL = "машинной платой ввода замедлителя HFR",
		PREPOSITIONAL = "машинной плате ввода замедлителя HFR",
	)

/obj/item/circuitboard/machine/HFR_core
	name = "HFR core"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/atmospherics/components/unary/hypertorus/core
	req_components = list(
		/obj/item/stack/cable_coil = 10,
		/obj/item/stack/sheet/glass = 10,
		/obj/item/stack/sheet/plasteel = 10)

/obj/item/circuitboard/machine/HFR_core/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата ядра HFR",
		GENITIVE = "машинной платы ядра HFR",
		DATIVE = "машинной плате ядра HFR",
		ACCUSATIVE = "машинную плату ядра HFR",
		INSTRUMENTAL = "машинной платой ядра HFR",
		PREPOSITIONAL = "машинной плате ядра HFR",
	)

/obj/item/circuitboard/machine/HFR_corner
	name = "HFR Corner"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/hypertorus/corner
	req_components = list(
		/obj/item/stack/sheet/plasteel = 5)

/obj/item/circuitboard/machine/HFR_corner/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата угла HFR",
		GENITIVE = "машинной платы угла HFR",
		DATIVE = "машинной плате угла HFR",
		ACCUSATIVE = "машинную плату угла HFR",
		INSTRUMENTAL = "машинной платой угла HFR",
		PREPOSITIONAL = "машинной плате угла HFR",
	)

/obj/item/circuitboard/machine/HFR_interface
	name = "HFR Interface"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/hypertorus/interface
	req_components = list(
		/obj/item/stack/cable_coil = 10,
		/obj/item/stack/sheet/glass = 10,
		/obj/item/stack/sheet/plasteel = 5)

/obj/item/circuitboard/machine/HFR_interface/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата интерфейса HFR",
		GENITIVE = "машинной платы интерфейса HFR",
		DATIVE = "машинной плате интерфейса HFR",
		ACCUSATIVE = "машинную плату интерфейса HFR",
		INSTRUMENTAL = "машинной платой интерфейса HFR",
		PREPOSITIONAL = "машинной плате интерфейса HFR",
	)

/obj/item/circuitboard/machine/crystallizer
	name = "Crystallizer"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/atmospherics/components/binary/crystallizer
	req_components = list(
		/obj/item/stack/cable_coil = 10,
		/obj/item/stack/sheet/glass = 10,
		/obj/item/stack/sheet/plasteel = 5)

/obj/item/circuitboard/machine/crystallizer/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата кристаллизатора",
		GENITIVE = "машинной платы кристаллизатора",
		DATIVE = "машинной плате кристаллизатора",
		ACCUSATIVE = "машинную плату кристаллизатора",
		INSTRUMENTAL = "машинной платой кристаллизатора",
		PREPOSITIONAL = "машинной плате кристаллизатора",
	)

//Generic
/obj/item/circuitboard/machine/component_printer
	name = "\improper Component Printer"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/component_printer
	req_components = list(
		/datum/stock_part/matter_bin = 2,
		/datum/stock_part/servo = 2,
	)

/obj/item/circuitboard/machine/component_printer/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата принтера компонентов",
		GENITIVE = "машинной платы принтера компонентов",
		DATIVE = "машинной плате принтера компонентов",
		ACCUSATIVE = "машинную плату принтера компонентов",
		INSTRUMENTAL = "машинной платой принтера компонентов",
		PREPOSITIONAL = "машинной плате принтера компонентов",
	)

/obj/item/circuitboard/machine/module_duplicator
	name = "\improper Module Duplicator"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/module_duplicator
	req_components = list(
		/datum/stock_part/matter_bin = 2,
		/datum/stock_part/servo = 2,
	)

/obj/item/circuitboard/machine/module_duplicator/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата дубликатора модулей",
		GENITIVE = "машинной платы дубликатора модулей",
		DATIVE = "машинной плате дубликатора модулей",
		ACCUSATIVE = "машинную плату дубликатора модулей",
		INSTRUMENTAL = "машинной платой дубликатора модулей",
		PREPOSITIONAL = "машинной плате дубликатора модулей",
	)

/obj/item/circuitboard/machine/circuit_imprinter
	name = "Circuit Imprinter"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/rnd/production/circuit_imprinter
	req_components = list(
		/datum/stock_part/matter_bin = 1,
		/datum/stock_part/servo = 1,
		)

/obj/item/circuitboard/machine/circuit_imprinter/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата принтера схем",
		GENITIVE = "машинной платы принтера схем",
		DATIVE = "машинной плате принтера схем",
		ACCUSATIVE = "машинную плату принтера схем",
		INSTRUMENTAL = "машинной платой принтера схем",
		PREPOSITIONAL = "машинной плате принтера схем",
	)

/obj/item/circuitboard/machine/circuit_imprinter/offstation
	name = "Ancient Circuit Imprinter"
	build_path = /obj/machinery/rnd/production/circuit_imprinter/offstation

/obj/item/circuitboard/machine/circuit_imprinter/offstation/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата древнего принтера схем",
		GENITIVE = "машинной платы древнего принтера схем",
		DATIVE = "машинной плате древнего принтера схем",
		ACCUSATIVE = "машинную плату древнего принтера схем",
		INSTRUMENTAL = "машинной платой древнего принтера схем",
		PREPOSITIONAL = "машинной плате древнего принтера схем",
	)

/obj/item/circuitboard/machine/circuit_imprinter/department
	name = "Departmental Circuit Imprinter"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/rnd/production/circuit_imprinter/department

/obj/item/circuitboard/machine/circuit_imprinter/department/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата отдельного принтера схем",
		GENITIVE = "машинной платы отдельного принтера схем",
		DATIVE = "машинной плате отдельного принтера схем",
		ACCUSATIVE = "машинную плату отдельного принтера схем",
		INSTRUMENTAL = "машинной платой отдельного принтера схем",
		PREPOSITIONAL = "машинной плате отдельного принтера схем",
	)

/obj/item/circuitboard/machine/holopad
	name = "AI Holopad"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/holopad
	req_components = list(/datum/stock_part/capacitor = 1)
	needs_anchored = FALSE //wew lad
	var/secure = FALSE

/obj/item/circuitboard/machine/holopad/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата ИИ голопада",
		GENITIVE = "машинной платы ИИ голопада",
		DATIVE = "машинной плате ИИ голопада",
		ACCUSATIVE = "машинную плату ИИ голопада",
		INSTRUMENTAL = "машинной платой ИИ голопада",
		PREPOSITIONAL = "машинной плате ИИ голопада",
	)

/obj/item/circuitboard/machine/holopad/multitool_act(mob/living/user, obj/item/tool)
	if(secure)
		build_path = /obj/machinery/holopad
		secure = FALSE
	else
		build_path = /obj/machinery/holopad/secure
		secure = TRUE
	to_chat(user, span_notice("Вы [secure? "вк" : "вык"]лючаете защиту на [RU_SRC_PRE]"))
	return TRUE

/obj/item/circuitboard/machine/holopad/examine(mob/user)
	. = ..()
	. += "На этой плате есть порт подключения, который можно <b>пропульсировать</b>."
	if(secure)
		. += "Рядом со словом \"защита\" мигает красная лампочка."

/obj/item/circuitboard/machine/launchpad
	name = "Bluespace Launchpad"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/launchpad
	req_components = list(
		/obj/item/stack/ore/bluespace_crystal = 1,
		/datum/stock_part/servo = 1)
	def_components = list(/obj/item/stack/ore/bluespace_crystal = /obj/item/stack/ore/bluespace_crystal/artificial)

/obj/item/circuitboard/machine/launchpad/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата блюспейс лаунчпада",
		GENITIVE = "машинной платы блюспейс лаунчпада",
		DATIVE = "машинной плате блюспейс лаунчпада",
		ACCUSATIVE = "машинную плату блюспейс лаунчпада",
		INSTRUMENTAL = "машинной платой блюспейс лаунчпада",
		PREPOSITIONAL = "машинной плате блюспейс лаунчпада",
	)

/obj/item/circuitboard/machine/protolathe
	name = "Protolathe"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/rnd/production/protolathe
	req_components = list(
		/datum/stock_part/matter_bin = 2,
		/datum/stock_part/servo = 2,
		)

/obj/item/circuitboard/machine/protolathe/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата протолата",
		GENITIVE = "машинной платы протолата",
		DATIVE = "машинной плате протолата",
		ACCUSATIVE = "машинную плату протолата",
		INSTRUMENTAL = "машинной платой протолата",
		PREPOSITIONAL = "машинной плате протолата",
	)

/obj/item/circuitboard/machine/protolathe/offstation
	name = "Ancient Protolathe"
	build_path = /obj/machinery/rnd/production/protolathe/offstation

/obj/item/circuitboard/machine/protolathe/offstation/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата древнего протолата",
		GENITIVE = "машинной платы древнего протолата",
		DATIVE = "машинной плате древнего протолата",
		ACCUSATIVE = "машинную плату древнего протолата",
		INSTRUMENTAL = "машинной платой древнего протолата",
		PREPOSITIONAL = "машинной плате древнего протолата",
	)

/obj/item/circuitboard/machine/protolathe/department
	name = "Departmental Protolathe"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/rnd/production/protolathe/department

/obj/item/circuitboard/machine/protolathe/department/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата отдельного протолата",
		GENITIVE = "машинной платы отдельного протолата",
		DATIVE = "машинной плате отдельного протолата",
		ACCUSATIVE = "машинную плату отдельного протолата",
		INSTRUMENTAL = "машинной платой отдельного протолата",
		PREPOSITIONAL = "машинной плате отдельного протолата",
	)

/obj/item/circuitboard/machine/reagentgrinder
	name = "All-In-One Grinder"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/reagentgrinder
	req_components = list(
		/datum/stock_part/servo = 1,
		/datum/stock_part/matter_bin = 1,
	)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/reagentgrinder/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата измельчителя \"Всё-в-одном\"",
		GENITIVE = "машинной платы измельчителя \"Всё-в-одном\"",
		DATIVE = "машинной плате измельчителя \"Всё-в-одном\"",
		ACCUSATIVE = "машинную плату измельчителя \"Всё-в-одном\"",
		INSTRUMENTAL = "машинной платой измельчителя \"Всё-в-одном\"",
		PREPOSITIONAL = "машинной плате измельчителя \"Всё-в-одном\"",
	)

/obj/item/circuitboard/machine/smartfridge
	name = "Smartfridge"
	build_path = /obj/machinery/smartfridge
	req_components = list(/datum/stock_part/matter_bin = 1)
	var/static/list/fridges_name_paths = list(/obj/machinery/smartfridge = "plant produce",
		/obj/machinery/smartfridge/food = "food",
		/obj/machinery/smartfridge/drinks = "drinks",
		/obj/machinery/smartfridge/extract = "slimes",
		/obj/machinery/smartfridge/petri = "petri",
		/obj/machinery/smartfridge/organ = "organs",
		/obj/machinery/smartfridge/chemistry = "chems",
		/obj/machinery/smartfridge/chemistry/virology = "viruses",
		/obj/machinery/smartfridge/disks = "disks")
	needs_anchored = FALSE
	var/is_special_type = FALSE

/obj/item/circuitboard/machine/smartfridge/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата умного холодильника",
		GENITIVE = "машинной платы умного холодильника",
		DATIVE = "машинной плате умного холодильника",
		ACCUSATIVE = "машинную плату умного холодильника",
		INSTRUMENTAL = "машинной платой умного холодильника",
		PREPOSITIONAL = "машинной плате умного холодильника",
	)

/obj/item/circuitboard/machine/smartfridge/apply_default_parts(obj/machinery/smartfridge/smartfridge)
	build_path = smartfridge.base_build_path
	if(!fridges_name_paths.Find(build_path))
		name = "[initial(smartfridge.name)]" //if it's a unique type, give it a unique name.
		is_special_type = TRUE
	return ..()

/obj/item/circuitboard/machine/smartfridge/screwdriver_act(mob/living/user, obj/item/tool)
	if (is_special_type)
		return FALSE
	var/position = fridges_name_paths.Find(build_path, fridges_name_paths)
	position = (position == length(fridges_name_paths)) ? 1 : (position + 1)
	build_path = fridges_name_paths[position]
	to_chat(user, span_notice("Вы устанавливаете плату на [fridges_name_paths[build_path]]."))
	return TRUE

/obj/item/circuitboard/machine/smartfridge/examine(mob/user)
	. = ..()
	if(is_special_type)
		return
	. += span_info("[RU_SRC_NOM] установлена на [fridges_name_paths[build_path]]. Вы можете использовать отвертку для перенастройки.")

/obj/item/circuitboard/machine/dehydrator
	name = "Dehydrator"
	build_path = /obj/machinery/smartfridge/drying
	req_components = list(/datum/stock_part/matter_bin = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/dehydrator/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата дегидратора",
		GENITIVE = "машинной платы дегидратора",
		DATIVE = "машинной плате дегидратора",
		ACCUSATIVE = "машинную плату дегидратора",
		INSTRUMENTAL = "машинной платой дегидратора",
		PREPOSITIONAL = "машинной плате дегидратора",
	)

/obj/item/circuitboard/machine/space_heater
	name = "Space Heater"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/space_heater
	req_components = list(
		/datum/stock_part/micro_laser = 1,
		/datum/stock_part/capacitor = 1,
		/obj/item/stack/cable_coil = 3)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/space_heater/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата обогревателя",
		GENITIVE = "машинной платы обогревателя",
		DATIVE = "машинной плате обогревателя",
		ACCUSATIVE = "машинную плату обогревателя",
		INSTRUMENTAL = "машинной платой обогревателя",
		PREPOSITIONAL = "машинной плате обогревателя",
	)

/obj/item/circuitboard/machine/electrolyzer
	name = "Electrolyzer"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/electrolyzer
	req_components = list(
		/datum/stock_part/servo = 2,
		/datum/stock_part/capacitor = 2,
		/obj/item/stack/cable_coil = 5,
		/obj/item/stack/sheet/glass = 1)

	needs_anchored = FALSE

/obj/item/circuitboard/machine/electrolyzer/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата электролизера",
		GENITIVE = "машинной платы электролизера",
		DATIVE = "машинной плате электролизера",
		ACCUSATIVE = "машинную плату электролизера",
		INSTRUMENTAL = "машинной платой электролизера",
		PREPOSITIONAL = "машинной плате электролизера",
	)

/obj/item/circuitboard/machine/techfab
	name = "\improper Techfab"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/rnd/production/techfab
	req_components = list(
		/datum/stock_part/matter_bin = 2,
		/datum/stock_part/servo = 2,
		)

/obj/item/circuitboard/machine/techfab/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата техфаба",
		GENITIVE = "машинной платы техфаба",
		DATIVE = "машинной плате техфаба",
		ACCUSATIVE = "машинную плату техфаба",
		INSTRUMENTAL = "машинной платой техфаба",
		PREPOSITIONAL = "машинной плате техфаба",
	)

/obj/item/circuitboard/machine/techfab/department
	name = "\improper Departmental Techfab"
	build_path = /obj/machinery/rnd/production/techfab/department

/obj/item/circuitboard/machine/techfab/department/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата отдельного техфаба",
		GENITIVE = "машинной платы отдельного техфаба",
		DATIVE = "машинной плате отдельного техфаба",
		ACCUSATIVE = "машинную плату отдельного техфаба",
		INSTRUMENTAL = "машинной платой отдельного техфаба",
		PREPOSITIONAL = "машинной плате отдельного техфаба",
	)

/obj/item/circuitboard/machine/vendor
	name = "Custom Vendor"
	desc = "Вы можете повернуть переключатель \"выбора бренда\" с помощью отвертки."
	custom_premium_price = PAYCHECK_CREW * 1.5
	build_path = /obj/machinery/vending/custom
	req_components = list(/obj/item/vending_refill/custom = 1)

	///Assoc list (machine name = machine typepath) of all vendors that can be chosen when the circuit is screwdrivered
	var/static/list/valid_vendor_names_paths

/obj/item/circuitboard/machine/vendor/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата настраиваемого вендомата",
		GENITIVE = "машинной платы настраиваемого вендомата",
		DATIVE = "машинной плате настраиваемого вендомата",
		ACCUSATIVE = "машинную плату настраиваемого вендомата",
		INSTRUMENTAL = "машинной платой настраиваемого вендомата",
		PREPOSITIONAL = "машинной плате настраиваемого вендомата",
	)

/obj/item/circuitboard/machine/vendor/Initialize(mapload)
	. = ..()
	if(!valid_vendor_names_paths)
		valid_vendor_names_paths = list()
		for(var/obj/machinery/vending/vendor_type as anything in subtypesof(/obj/machinery/vending))
			if(vendor_type::allow_custom && vendor_type::refill_canister)
				valid_vendor_names_paths[vendor_type::name] = vendor_type

/obj/item/circuitboard/machine/vendor/screwdriver_act(mob/living/user, obj/item/tool)
	. = ITEM_INTERACT_FAILURE
	var/choice = tgui_input_list(user, "Выберите новый бренд", "Выберите предмет", sort_list(valid_vendor_names_paths))
	if(isnull(choice))
		return
	if(!user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		return
	set_type(valid_vendor_names_paths[choice])
	return ITEM_INTERACT_SUCCESS

/**
 * Sets circuitboard details based on the vending machine type to create
 *
 * Arguments
 * * obj/machinery/vending/typepath - the vending machine type to create
*/
/obj/item/circuitboard/machine/vendor/proc/set_type(obj/machinery/vending/typepath)
	build_path = typepath
	name = "[typepath::name] Vendor"
	req_components = list(initial(typepath.refill_canister) = 1)
	flatpack_components = list(initial(typepath.refill_canister))

/obj/item/circuitboard/machine/vendor/apply_default_parts(obj/machinery/machine)
	set_type(machine.type)
	return ..()

/obj/item/circuitboard/machine/bountypad
	name = "Civilian Bounty Pad"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/piratepad/civilian
	req_components = list(
		/datum/stock_part/card_reader = 1,
		/datum/stock_part/scanning_module = 1,
		/datum/stock_part/micro_laser = 1
	)

/obj/item/circuitboard/machine/bountypad/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата гражданского баунтипада",
		GENITIVE = "машинной платы гражданского баунтипада",
		DATIVE = "машинной плате гражданского баунтипада",
		ACCUSATIVE = "машинную плату гражданского баунтипада",
		INSTRUMENTAL = "машинной платой гражданского баунтипада",
		PREPOSITIONAL = "машинной плате гражданского баунтипада",
	)

/obj/item/circuitboard/machine/fax
	name = "Fax Machine"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/fax
	req_components = list(
		/datum/stock_part/crystal = 1,
		/datum/stock_part/scanning_module = 1,
		/datum/stock_part/micro_laser = 1,
		/datum/stock_part/servo = 1,)

/obj/item/circuitboard/machine/fax/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата факса",
		GENITIVE = "машинной платы факса",
		DATIVE = "машинной плате факса",
		ACCUSATIVE = "машинную плату факса",
		INSTRUMENTAL = "машинной платой факса",
		PREPOSITIONAL = "машинной плате факса",
	)

/obj/item/circuitboard/machine/bookbinder
	name = "Book Binder"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/bookbinder
	req_components = list(
		/datum/stock_part/servo = 1,
	)

/obj/item/circuitboard/machine/bookbinder/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата переплётчика книг",
		GENITIVE = "машинной платы переплётчика книг",
		DATIVE = "машинной плате переплётчика книг",
		ACCUSATIVE = "машинную плату переплётчика книг",
		INSTRUMENTAL = "машинной платой переплётчика книг",
		PREPOSITIONAL = "машинной плате переплётчика книг",
	)

/obj/item/circuitboard/machine/libraryscanner
	name = "Book Scanner"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/libraryscanner
	req_components = list(
		/datum/stock_part/scanning_module = 1,
	)

/obj/item/circuitboard/machine/libraryscanner/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата сканера книг",
		GENITIVE = "машинной платы сканера книг",
		DATIVE = "машинной плате сканера книг",
		ACCUSATIVE = "машинную плату сканера книг",
		INSTRUMENTAL = "машинной платой сканера книг",
		PREPOSITIONAL = "машинной плате сканера книг",
	)

/obj/item/circuitboard/machine/photocopier
	name = "Photocopier"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/photocopier
	req_components = list(
		/datum/stock_part/scanning_module = 1,
		/datum/stock_part/micro_laser = 1,
		/datum/stock_part/matter_bin = 1
	)

/obj/item/circuitboard/machine/photocopier/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата фотокопира",
		GENITIVE = "машинной платы фотокопира",
		DATIVE = "машинной плате фотокопира",
		ACCUSATIVE = "машинную плату фотокопира",
		INSTRUMENTAL = "машинной платой фотокопира",
		PREPOSITIONAL = "машинной плате фотокопира",
	)

//Medical

/obj/item/circuitboard/machine/chem_dispenser
	name = "Chem Dispenser"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/chem_dispenser
	req_components = list(
		/datum/stock_part/matter_bin = 2,
		/datum/stock_part/capacitor = 1,
		/datum/stock_part/servo = 1,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stock_parts/power_store/cell = 1)
	def_components = list(/obj/item/stock_parts/power_store/cell = /obj/item/stock_parts/power_store/cell/high)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/chem_dispenser/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата раздатчика химикатов",
		GENITIVE = "машинной платы раздатчика химикатов",
		DATIVE = "машинной плате раздатчика химикатов",
		ACCUSATIVE = "машинную плату раздатчика химикатов",
		INSTRUMENTAL = "машинной платой раздатчика химикатов",
		PREPOSITIONAL = "машинной плате раздатчика химикатов",
	)

/obj/item/circuitboard/machine/chem_dispenser/fullupgrade
	build_path = /obj/machinery/chem_dispenser/fullupgrade
	specific_parts = TRUE
	req_components = list(
		/datum/stock_part/matter_bin/tier4 = 2,
		/datum/stock_part/capacitor/tier4 = 2,
		/datum/stock_part/servo/tier4 = 2,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stock_parts/power_store/cell/bluespace = 1,
	)

/obj/item/circuitboard/machine/chem_dispenser/mutagensaltpeter
	build_path = /obj/machinery/chem_dispenser/mutagensaltpeter
	specific_parts = TRUE
	req_components = list(
		/datum/stock_part/matter_bin/tier4 = 2,
		/datum/stock_part/capacitor/tier4 = 2,
		/datum/stock_part/servo/tier4 = 2,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stock_parts/power_store/cell/bluespace = 1,
	)

/obj/item/circuitboard/machine/chem_dispenser/abductor
	name = "Reagent Synthesizer"
	name_extension = "(Abductor Machine Board)"
	icon_state = "abductor_mod"
	build_path = /obj/machinery/chem_dispenser/abductor
	specific_parts = TRUE
	req_components = list(
		/datum/stock_part/matter_bin/tier4 = 2,
		/datum/stock_part/capacitor/tier4 = 2,
		/datum/stock_part/servo/tier4 = 2,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stock_parts/power_store/cell/bluespace = 1,
	)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/chem_dispenser/abductor/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата синтезатора реагентов",
		GENITIVE = "машинной платы синтезатора реагентов",
		DATIVE = "машинной плате синтезатора реагентов",
		ACCUSATIVE = "машинную плату синтезатора реагентов",
		INSTRUMENTAL = "машинной платой синтезатора реагентов",
		PREPOSITIONAL = "машинной плате синтезатора реагентов",
	)

/obj/item/circuitboard/machine/chem_heater
	name = "Chemical Heater"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/chem_heater
	req_components = list(
		/datum/stock_part/micro_laser = 1,
		/obj/item/stack/sheet/glass = 1)

/obj/item/circuitboard/machine/chem_heater/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата хим. нагревателя",
		GENITIVE = "машинной платы хим. нагревателя",
		DATIVE = "машинной плате хим. нагревателя",
		ACCUSATIVE = "машинную плату хим. нагревателя",
		INSTRUMENTAL = "машинной платой хим. нагревателя",
		PREPOSITIONAL = "машинной плате хим. нагревателя",
	)

/obj/item/circuitboard/machine/chem_mass_spec
	name = "High-Performance Liquid Chromatography Machine"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/chem_mass_spec
	req_components = list(
	/datum/stock_part/micro_laser = 1,
	/obj/item/stack/cable_coil = 5)

/obj/item/circuitboard/machine/chem_mass_spec/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата хроматографа",
		GENITIVE = "машинной платы хроматографа",
		DATIVE = "машинной плате хроматографа",
		ACCUSATIVE = "машинную плату хроматографа",
		INSTRUMENTAL = "машинной платой хроматографа",
		PREPOSITIONAL = "машинной плате хроматографа",
	)

/obj/item/circuitboard/machine/chem_master
	name = "ChemMaster 3000"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/chem_master
	desc = "Вы можете повернуть переключатель \"выбора режима\" с помощью отвертки."
	req_components = list(
		/obj/item/reagent_containers/cup/beaker = 2,
		/datum/stock_part/servo = 1,
		/obj/item/stack/sheet/glass = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/chem_master/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата ХимМастера 3000",
		GENITIVE = "машинной платы ХимМастера 3000",
		DATIVE = "машинной плате ХимМастера 3000",
		ACCUSATIVE = "машинную плату ХимМастера 3000",
		INSTRUMENTAL = "машинной платой ХимМастера 3000",
		PREPOSITIONAL = "машинной плате ХимМастера 3000",
	)

/obj/item/circuitboard/machine/chem_master/screwdriver_act(mob/living/user, obj/item/tool)
	var/new_name = "ChemMaster"
	var/new_path = /obj/machinery/chem_master

	if(build_path == /obj/machinery/chem_master)
		new_name = "CondiMaster"
		new_path = /obj/machinery/chem_master/condimaster

	build_path = new_path
	name = "[new_name] 3000"
	to_chat(user, span_notice("Вы меняете настройки платы на \"[new_name]\"."))
	return TRUE

/obj/item/circuitboard/machine/cryo_tube
	name = "Cryotube"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/cryo_cell
	req_components = list(
		/datum/stock_part/matter_bin = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/glass = 4)

/obj/item/circuitboard/machine/cryo_tube/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата криосауны",
		GENITIVE = "машинной платы криосауны",
		DATIVE = "машинной плате криосауны",
		ACCUSATIVE = "машинную плату криосауны",
		INSTRUMENTAL = "машинной платой криосауны",
		PREPOSITIONAL = "машинной плате криосауны",
	)

/obj/item/circuitboard/machine/fat_sucker
	name = "Lipid Extractor"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/fat_sucker
	req_components = list(/datum/stock_part/micro_laser = 1,
		/obj/item/kitchen/fork = 1)

/obj/item/circuitboard/machine/fat_sucker/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата экстрактора липидов",
		GENITIVE = "машинной платы экстрактора липидов",
		DATIVE = "машинной плате экстрактора липидов",
		ACCUSATIVE = "машинную плату экстрактора липидов",
		INSTRUMENTAL = "машинной платой экстрактора липидов",
		PREPOSITIONAL = "машинной плате экстрактора липидов",
	)

/obj/item/circuitboard/machine/harvester
	name = "Harvester"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/harvester
	req_components = list(/datum/stock_part/micro_laser = 4)

/obj/item/circuitboard/machine/harvester/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата комбайна",
		GENITIVE = "машинной платы комбайна",
		DATIVE = "машинной плате комбайна",
		ACCUSATIVE = "машинную плату комбайна",
		INSTRUMENTAL = "машинной платой комбайна",
		PREPOSITIONAL = "машинной плате комбайна",
	)

/obj/item/circuitboard/machine/medical_kiosk
	name = "Medical Kiosk"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/medical_kiosk
	var/custom_cost = 10
	req_components = list(
		/obj/item/healthanalyzer = 1,
		/datum/stock_part/scanning_module = 1)

/obj/item/circuitboard/machine/medical_kiosk/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата медицинского киоска",
		GENITIVE = "машинной платы медицинского киоска",
		DATIVE = "машинной плате медицинского киоска",
		ACCUSATIVE = "машинную плату медицинского киоска",
		INSTRUMENTAL = "машинной платой медицинского киоска",
		PREPOSITIONAL = "машинной плате медицинского киоска",
	)

/obj/item/circuitboard/machine/medical_kiosk/multitool_act(mob/living/user)
	. = ..()
	var/new_cost = tgui_input_number(user, "Новая стоимость использования этого медицинского киоска", "Цены", custom_cost, 1000, 10)
	if(!new_cost || QDELETED(user) || QDELETED(src) || !user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		return
	if(loc != user)
		to_chat(user, span_warning("Вы должны держать плату, чтобы изменить её стоимость!"))
		return
	custom_cost = new_cost
	to_chat(user, span_notice("Стоимость установлена на [custom_cost]."))

/obj/item/circuitboard/machine/medical_kiosk/examine(mob/user)
	. = ..()
	. += "Стоимость использования этого киоска установлена на [custom_cost]."

/obj/item/circuitboard/machine/limbgrower
	name = "Limb Grower"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/limbgrower
	req_components = list(
		/datum/stock_part/servo = 1,
		/obj/item/reagent_containers/cup/beaker = 2,
		/obj/item/stack/sheet/glass = 1)

/obj/item/circuitboard/machine/limbgrower/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата выращивателя конечностей",
		GENITIVE = "машинной платы выращивателя конечностей",
		DATIVE = "машинной плате выращивателя конечностей",
		ACCUSATIVE = "машинную плату выращивателя конечностей",
		INSTRUMENTAL = "машинной платой выращивателя конечностей",
		PREPOSITIONAL = "машинной плате выращивателя конечностей",
	)

/obj/item/circuitboard/machine/limbgrower/fullupgrade
	name = "Limb Grower"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/limbgrower
	req_components = list(
		/datum/stock_part/servo/tier4  = 1,
		/obj/item/reagent_containers/cup/beaker/bluespace = 2,
		/obj/item/stack/sheet/glass = 1)

/obj/item/circuitboard/machine/protolathe/department/medical
	name = "Departmental Protolathe - Medical"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/rnd/production/protolathe/department/medical

/obj/item/circuitboard/machine/protolathe/department/medical/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата медицинского протолата",
		GENITIVE = "машинной платы медицинского протолата",
		DATIVE = "машинной плате медицинского протолата",
		ACCUSATIVE = "машинную плату медицинского протолата",
		INSTRUMENTAL = "машинной платой медицинского протолата",
		PREPOSITIONAL = "машинной плате медицинского протолата",
	)

/obj/item/circuitboard/machine/sleeper
	name = "Sleeper"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/sleeper
	req_components = list(
		/datum/stock_part/matter_bin = 1,
		/datum/stock_part/servo = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/glass = 2)

/obj/item/circuitboard/machine/sleeper/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата слипера",
		GENITIVE = "машинной платы слипера",
		DATIVE = "машинной плате слипера",
		ACCUSATIVE = "машинную плату слипера",
		INSTRUMENTAL = "машинной платой слипера",
		PREPOSITIONAL = "машинной плате слипера",
	)

/obj/item/circuitboard/machine/sleeper/syndie
	build_path = /obj/machinery/sleeper/syndie

/obj/item/circuitboard/machine/sleeper/fullupgrade
	build_path = /obj/machinery/sleeper/syndie/fullupgrade
	req_components = list(
		/datum/stock_part/matter_bin/tier4 = 1,
		/datum/stock_part/servo/tier4 = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/glass = 2)

/obj/item/circuitboard/machine/sleeper/party
	name = "Party Pod"
	build_path = /obj/machinery/sleeper/party

/obj/item/circuitboard/machine/sleeper/party/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата патипода",
		GENITIVE = "машинной платы патипода",
		DATIVE = "машинной плате патипода",
		ACCUSATIVE = "машинную плату патипода",
		INSTRUMENTAL = "машинной платой патипода",
		PREPOSITIONAL = "машинной плате патипода",
	)

/obj/item/circuitboard/machine/smoke_machine
	name = "Smoke Machine"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/smoke_machine
	req_components = list(
		/datum/stock_part/matter_bin = 2,
		/datum/stock_part/capacitor = 1,
		/datum/stock_part/servo = 1,
		/obj/item/stack/sheet/glass = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/smoke_machine/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата дым-машины",
		GENITIVE = "машинной платы дым-машины",
		DATIVE = "машинной плате дым-машины",
		ACCUSATIVE = "машинную плату дым-машины",
		INSTRUMENTAL = "машинной платой дым-машины",
		PREPOSITIONAL = "машинной плате дым-машины",
	)

/obj/item/circuitboard/machine/stasis
	name = "\improper Lifeform Stasis Unit"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/stasis
	req_components = list(
		/obj/item/stack/cable_coil = 3,
		/datum/stock_part/servo = 1,
		/datum/stock_part/capacitor = 1)

/obj/item/circuitboard/machine/stasis/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата стазис-кровати",
		GENITIVE = "машинной платы стазис-кровати",
		DATIVE = "машинной плате стазис-кровати",
		ACCUSATIVE = "машинную плату стазис-кровати",
		INSTRUMENTAL = "машинной платой стазис-кровати",
		PREPOSITIONAL = "машинной плате стазис-кровати",
	)

/obj/item/circuitboard/machine/medipen_refiller
	name = "Medipen Refiller"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/medipen_refiller
	req_components = list(
		/datum/stock_part/matter_bin = 1)

/obj/item/circuitboard/machine/medipen_refiller/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата заправщика медипенов",
		GENITIVE = "машинной платы заправщика медипенов",
		DATIVE = "машинной плате заправщика медипенов",
		ACCUSATIVE = "машинную плату заправщика медипенов",
		INSTRUMENTAL = "машинной платой заправщика медипенов",
		PREPOSITIONAL = "машинной плате заправщика медипенов",
	)

/obj/item/circuitboard/machine/techfab/department/medical
	name = "\improper Departmental Techfab - Medical"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/rnd/production/techfab/department/medical

/obj/item/circuitboard/machine/techfab/department/medical/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата медицинского техфаба",
		GENITIVE = "машинной платы медицинского техфаба",
		DATIVE = "машинной плате медицинского техфаба",
		ACCUSATIVE = "машинную плату медицинского техфаба",
		INSTRUMENTAL = "машинной платой медицинского техфаба",
		PREPOSITIONAL = "машинной плате медицинского техфаба",
	)

//Science

/obj/item/circuitboard/machine/circuit_imprinter/department/science
	name = "Departmental Circuit Imprinter - Science"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/rnd/production/circuit_imprinter/department/science

/obj/item/circuitboard/machine/circuit_imprinter/department/science/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата научного принтера схем",
		GENITIVE = "машинной платы научного принтера схем",
		DATIVE = "машинной плате научного принтера схем",
		ACCUSATIVE = "машинную плату научного принтера схем",
		INSTRUMENTAL = "машинной платой научного принтера схем",
		PREPOSITIONAL = "машинной плате научного принтера схем",
	)

/obj/item/circuitboard/machine/cyborgrecharger
	name = "Cyborg Recharger"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/recharge_station
	req_components = list(
		/datum/stock_part/capacitor = 2,
		/obj/item/stock_parts/power_store/cell = 1,
		/datum/stock_part/servo = 1)
	def_components = list(/obj/item/stock_parts/power_store/cell = /obj/item/stock_parts/power_store/cell/high)

/obj/item/circuitboard/machine/cyborgrecharger/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата зарядника киборгов",
		GENITIVE = "машинной платы зарядника киборгов",
		DATIVE = "машинной плате зарядника киборгов",
		ACCUSATIVE = "машинную плату зарядника киборгов",
		INSTRUMENTAL = "машинной платой зарядника киборгов",
		PREPOSITIONAL = "машинной плате зарядника киборгов",
	)

/obj/item/circuitboard/machine/destructive_analyzer
	name = "Destructive Analyzer"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/rnd/destructive_analyzer
	req_components = list(
		/datum/stock_part/scanning_module = 1,
		/datum/stock_part/servo = 1,
		/datum/stock_part/micro_laser = 1,
	)

/obj/item/circuitboard/machine/destructive_analyzer/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата деструктивного анализатора",
		GENITIVE = "машинной платы деструктивного анализатора",
		DATIVE = "машинной плате деструктивного анализатора",
		ACCUSATIVE = "машинную плату деструктивного анализатора",
		INSTRUMENTAL = "машинной платой деструктивного анализатора",
		PREPOSITIONAL = "машинной плате деструктивного анализатора",
	)

/obj/item/circuitboard/machine/experimentor
	name = "E.X.P.E.R.I-MENTOR"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/rnd/experimentor
	req_components = list(
		/datum/stock_part/scanning_module = 1,
		/datum/stock_part/servo = 2,
		/datum/stock_part/micro_laser = 2)

/obj/item/circuitboard/machine/experimentor/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата Э.К.С.П.Е.Р.И-МЕНТОРа",
		GENITIVE = "машинной платы Э.К.С.П.Е.Р.И-МЕНТОРа",
		DATIVE = "машинной плате Э.К.С.П.Е.Р.И-МЕНТОРа",
		ACCUSATIVE = "машинную плату Э.К.С.П.Е.Р.И-МЕНТОРа",
		INSTRUMENTAL = "машинной платой Э.К.С.П.Е.Р.И-МЕНТОРа",
		PREPOSITIONAL = "машинной плате Э.К.С.П.Е.Р.И-МЕНТОРа",
	)

/obj/item/circuitboard/machine/mech_recharger
	name = "Mechbay Recharger"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/mech_bay_recharge_port
	req_components = list(
		/obj/item/stack/cable_coil = 2,
		/datum/stock_part/capacitor = 5)

/obj/item/circuitboard/machine/mech_recharger/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата зарядника мехов",
		GENITIVE = "машинной платы зарядника мехов",
		DATIVE = "машинной плате зарядника мехов",
		ACCUSATIVE = "машинную плату зарядника мехов",
		INSTRUMENTAL = "машинной платой зарядника мехов",
		PREPOSITIONAL = "машинной плате зарядника мехов",
	)

/obj/item/circuitboard/machine/mechfab
	name = "Exosuit Fabricator"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/mecha_part_fabricator
	req_components = list(
		/datum/stock_part/matter_bin = 2,
		/datum/stock_part/servo = 1,
		/datum/stock_part/micro_laser = 1,
		/obj/item/stack/sheet/glass = 1)

/obj/item/circuitboard/machine/mechfab/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата фабрикатора экзокостюмов",
		GENITIVE = "машинной платы фабрикатора экзокостюмов",
		DATIVE = "машинной плате фабрикатора экзокостюмов",
		ACCUSATIVE = "машинную плату фабрикатора экзокостюмов",
		INSTRUMENTAL = "машинной платой фабрикатора экзокостюмов",
		PREPOSITIONAL = "машинной плате фабрикатора экзокостюмов",
	)

/obj/item/circuitboard/machine/vatgrower
	name = "Growing Vat"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/vatgrower

/obj/item/circuitboard/machine/vatgrower/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата бака для выращивания",
		GENITIVE = "машинной платы бака для выращивания",
		DATIVE = "машинной плате бака для выращивания",
		ACCUSATIVE = "машинную плату бака для выращивания",
		INSTRUMENTAL = "машинной платой бака для выращивания",
		PREPOSITIONAL = "машинной плате бака для выращивания",
	)

/obj/item/circuitboard/machine/monkey_recycler
	name = "Monkey Recycler"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/monkey_recycler
	req_components = list(
		/datum/stock_part/matter_bin = 1,
		/datum/stock_part/servo = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/monkey_recycler/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата переработчика обезьян",
		GENITIVE = "машинной платы переработчика обезьян",
		DATIVE = "машинной плате переработчика обезьян",
		ACCUSATIVE = "машинную плату переработчика обезьян",
		INSTRUMENTAL = "машинной платой переработчика обезьян",
		PREPOSITIONAL = "машинной плате переработчика обезьян",
	)

/obj/item/circuitboard/machine/processor/slime
	name = "Slime Processor"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/processor/slime

/obj/item/circuitboard/machine/processor/slime/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата переработчика слаймов",
		GENITIVE = "машинной платы переработчика слаймов",
		DATIVE = "машинной плате переработчика слаймов",
		ACCUSATIVE = "машинную плату переработчика слаймов",
		INSTRUMENTAL = "машинной платой переработчика слаймов",
		PREPOSITIONAL = "машинной плате переработчика слаймов",
	)

/obj/item/circuitboard/machine/processor/slime/fullupgrade
	build_path = /obj/machinery/processor/slime/fullupgrade
	specific_parts = TRUE
	req_components = list(
		/datum/stock_part/matter_bin/tier4 = 1,
		/datum/stock_part/servo/tier4 = 1,
	)

/obj/item/circuitboard/machine/protolathe/department/science
	name = "Departmental Protolathe - Science"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/rnd/production/protolathe/department/science

/obj/item/circuitboard/machine/protolathe/department/science/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата научного протолата",
		GENITIVE = "машинной платы научного протолата",
		DATIVE = "машинной плате научного протолата",
		ACCUSATIVE = "машинную плату научного протолата",
		INSTRUMENTAL = "машинной платой научного протолата",
		PREPOSITIONAL = "машинной плате научного протолата",
	)

/obj/item/circuitboard/machine/quantumpad
	name = "Quantum Pad"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/quantumpad
	req_components = list(
		/obj/item/stack/ore/bluespace_crystal = 1,
		/datum/stock_part/capacitor = 1,
		/datum/stock_part/servo = 1,
		/obj/item/stack/cable_coil = 1)
	def_components = list(/obj/item/stack/ore/bluespace_crystal = /obj/item/stack/ore/bluespace_crystal/artificial)

/obj/item/circuitboard/machine/quantumpad/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата квантовой площадки",
		GENITIVE = "машинной платы квантовой площадки",
		DATIVE = "машинной плате квантовой площадки",
		ACCUSATIVE = "машинную плату квантовой площадки",
		INSTRUMENTAL = "машинной платой квантовой площадки",
		PREPOSITIONAL = "машинной плате квантовой площадки",
	)

/obj/item/circuitboard/machine/rdserver
	name = "R&D Server"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/rnd/server
	req_components = list(
		/obj/item/stack/cable_coil = 2,
		/datum/stock_part/scanning_module = 1,
	)

/obj/item/circuitboard/machine/rdserver/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата РнД сервера",
		GENITIVE = "машинной платы РнД сервера",
		DATIVE = "машинной плате РнД сервера",
		ACCUSATIVE = "машинную плату РнД сервера",
		INSTRUMENTAL = "машинной платой РнД сервера",
		PREPOSITIONAL = "машинной плате РнД сервера",
	)

/obj/item/circuitboard/machine/rdserver/oldstation
	name = "Ancient R&D Server"
	build_path = /obj/machinery/rnd/server/oldstation

/obj/item/circuitboard/machine/rdserver/oldstation/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата древнего РнД сервера",
		GENITIVE = "машинной платы древнего РнД сервера",
		DATIVE = "машинной плате древнего РнД сервера",
		ACCUSATIVE = "машинную плату древнего РнД сервера",
		INSTRUMENTAL = "машинной платой древнего РнД сервера",
		PREPOSITIONAL = "машинной плате древнего РнД сервера",
	)

/obj/item/circuitboard/machine/techfab/department/science
	name = "\improper Departmental Techfab - Science"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/rnd/production/techfab/department/science

/obj/item/circuitboard/machine/techfab/department/science/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата научного техфаба",
		GENITIVE = "машинной платы научного техфаба",
		DATIVE = "машинной плате научного техфаба",
		ACCUSATIVE = "машинную плату научного техфаба",
		INSTRUMENTAL = "машинной платой научного техфаба",
		PREPOSITIONAL = "машинной плате научного техфаба",
	)

/obj/item/circuitboard/machine/teleporter_hub
	name = "Teleporter Hub"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/teleport/hub
	req_components = list(
		/obj/item/stack/ore/bluespace_crystal = 3,
		/datum/stock_part/matter_bin = 1)
	def_components = list(/obj/item/stack/ore/bluespace_crystal = /obj/item/stack/ore/bluespace_crystal/artificial)

/obj/item/circuitboard/machine/teleporter_hub/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата узла телепорта",
		GENITIVE = "машинной платы узла телепорта",
		DATIVE = "машинной плате узла телепорта",
		ACCUSATIVE = "машинную плату узла телепорта",
		INSTRUMENTAL = "машинной платой узла телепорта",
		PREPOSITIONAL = "машинной плате узла телепорта",
	)

/obj/item/circuitboard/machine/teleporter_station
	name = "Teleporter Station"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/teleport/station
	req_components = list(
		/obj/item/stack/ore/bluespace_crystal = 2,
		/datum/stock_part/capacitor = 2,
		/obj/item/stack/sheet/glass = 1)
	def_components = list(/obj/item/stack/ore/bluespace_crystal = /obj/item/stack/ore/bluespace_crystal/artificial)

/obj/item/circuitboard/machine/teleporter_station/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата станции телепорта",
		GENITIVE = "машинной платы станции телепорта",
		DATIVE = "машинной плате станции телепорта",
		ACCUSATIVE = "машинную плату станции телепорта",
		INSTRUMENTAL = "машинной платой станции телепорта",
		PREPOSITIONAL = "машинной плате станции телепорта",
	)

/obj/item/circuitboard/machine/dnascanner
	name = "DNA Scanner"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/dna_scannernew
	req_components = list(
		/datum/stock_part/scanning_module = 1,
		/datum/stock_part/matter_bin = 1,
		/datum/stock_part/micro_laser = 1,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stack/cable_coil = 2)

/obj/item/circuitboard/machine/dnascanner/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата сканера ДНК",
		GENITIVE = "машинной платы сканера ДНК",
		DATIVE = "машинной плате сканера ДНК",
		ACCUSATIVE = "машинную плату сканера ДНК",
		INSTRUMENTAL = "машинной платой сканера ДНК",
		PREPOSITIONAL = "машинной плате сканера ДНК",
	)


/obj/item/circuitboard/machine/dna_infuser
	name = "DNA Infuser"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/dna_infuser
	req_components = list(
		/datum/stock_part/scanning_module = 1,
		/datum/stock_part/matter_bin = 1,
		/datum/stock_part/micro_laser = 1,
		/obj/item/stack/cable_coil = 2,
	)

/obj/item/circuitboard/machine/dna_infuser/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата инфузора ДНК",
		GENITIVE = "машинной платы инфузора ДНК",
		DATIVE = "машинной плате инфузора ДНК",
		ACCUSATIVE = "машинную плату инфузора ДНК",
		INSTRUMENTAL = "машинной платой инфузора ДНК",
		PREPOSITIONAL = "машинной плате инфузора ДНК",
	)

/obj/item/circuitboard/machine/experimental_cloner_scanner
	name = "Experimental Cloning Scanner"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/experimental_cloner_scanner
	req_components = list(
		/datum/stock_part/scanning_module = 1,
		/datum/stock_part/matter_bin = 1,
		/datum/stock_part/micro_laser = 1,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stack/cable_coil = 2
	)

/obj/item/circuitboard/machine/experimental_cloner_scanner/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата экспериментального сканера клонирования",
		GENITIVE = "машинной платы экспериментального сканера клонирования",
		DATIVE = "машинной плате экспериментального сканера клонирования",
		ACCUSATIVE = "машинную плату экспериментального сканера клонирования",
		INSTRUMENTAL = "машинной платой экспериментального сканера клонирования",
		PREPOSITIONAL = "машинной плате экспериментального сканера клонирования",
	)

/obj/item/circuitboard/machine/experimental_cloner
	name = "Experimental Cloning Pod"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/experimental_cloner
	req_components = list(
		/datum/stock_part/matter_bin = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/glass = 4
	)

/obj/item/circuitboard/machine/experimental_cloner/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата экспериментального клонера",
		GENITIVE = "машинной платы экспериментального клонера",
		DATIVE = "машинной плате экспериментального клонера",
		ACCUSATIVE = "машинную плату экспериментального клонера",
		INSTRUMENTAL = "машинной платой экспериментального клонера",
		PREPOSITIONAL = "машинной плате экспериментального клонера",
	)

/obj/item/circuitboard/machine/mechpad
	name = "Mecha Orbital Pad"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/mechpad
	req_components = list()

/obj/item/circuitboard/machine/mechpad/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата орбитальной площадки мехов",
		GENITIVE = "машинной платы орбитальной площадки мехов",
		DATIVE = "машинной плате орбитальной площадки мехов",
		ACCUSATIVE = "машинную плату орбитальной площадки мехов",
		INSTRUMENTAL = "машинной платой орбитальной площадки мехов",
		PREPOSITIONAL = "машинной плате орбитальной площадки мехов",
	)

/obj/item/circuitboard/machine/botpad
	name = "Bot launchpad"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/botpad
	req_components = list()

/obj/item/circuitboard/machine/botpad/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата бот-лаунчпада",
		GENITIVE = "машинной платы бот-лаунчпада",
		DATIVE = "машинной плате бот-лаунчпада",
		ACCUSATIVE = "машинную плату бот-лаунчпада",
		INSTRUMENTAL = "машинной платой бот-лаунчпада",
		PREPOSITIONAL = "машинной плате бот-лаунчпада",
	)

//Security

/obj/item/circuitboard/machine/protolathe/department/security
	name = "Departmental Protolathe - Security"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/rnd/production/protolathe/department/security

/obj/item/circuitboard/machine/protolathe/department/security/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата охранного протолата",
		GENITIVE = "машинной платы охранного протолата",
		DATIVE = "машинной плате охранного протолата",
		ACCUSATIVE = "машинную плату охранного протолата",
		INSTRUMENTAL = "машинной платой охранного протолата",
		PREPOSITIONAL = "машинной плате охранного протолата",
	)

/obj/item/circuitboard/machine/recharger
	name = "Weapon Recharger"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/recharger
	req_components = list(/datum/stock_part/capacitor = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/recharger/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата зарядника оружия",
		GENITIVE = "машинной платы зарядника оружия",
		DATIVE = "машинной плате зарядника оружия",
		ACCUSATIVE = "машинную плату зарядника оружия",
		INSTRUMENTAL = "машинной платой зарядника оружия",
		PREPOSITIONAL = "машинной плате зарядника оружия",
	)

/obj/item/circuitboard/machine/techfab/department/security
	name = "\improper Departmental Techfab - Security"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/rnd/production/techfab/department/security

/obj/item/circuitboard/machine/techfab/department/security/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата охранного техфаба",
		GENITIVE = "машинной платы охранного техфаба",
		DATIVE = "машинной плате охранного техфаба",
		ACCUSATIVE = "машинную плату охранного техфаба",
		INSTRUMENTAL = "машинной платой охранного техфаба",
		PREPOSITIONAL = "машинной плате охранного техфаба",
	)

//Service
/obj/item/circuitboard/machine/photobooth
	name = "Photobooth"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/photobooth
	req_components = list(
		/datum/stock_part/matter_bin = 1,
		/datum/stock_part/servo = 1,
	)

/obj/item/circuitboard/machine/photobooth/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата фотобудки",
		GENITIVE = "машинной платы фотобудки",
		DATIVE = "машинной плате фотобудки",
		ACCUSATIVE = "машинную плату фотобудки",
		INSTRUMENTAL = "машинной платой фотобудки",
		PREPOSITIONAL = "машинной плате фотобудки",
	)

/obj/item/circuitboard/machine/photobooth/security
	name = "Security Photobooth"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/photobooth/security

/obj/item/circuitboard/machine/photobooth/security/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата охранной фотобудки",
		GENITIVE = "машинной платы охранной фотобудки",
		DATIVE = "машинной плате охранной фотобудки",
		ACCUSATIVE = "машинную плату охранной фотобудки",
		INSTRUMENTAL = "машинной платой охранной фотобудки",
		PREPOSITIONAL = "машинной плате охранной фотобудки",
	)

/obj/item/circuitboard/machine/biogenerator
	name = "Biogenerator"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/biogenerator
	req_components = list(
		/datum/stock_part/matter_bin = 1,
		/datum/stock_part/servo = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/glass = 1)

/obj/item/circuitboard/machine/biogenerator/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата биогенератора",
		GENITIVE = "машинной платы биогенератора",
		DATIVE = "машинной плате биогенератора",
		ACCUSATIVE = "машинную плату биогенератора",
		INSTRUMENTAL = "машинной платой биогенератора",
		PREPOSITIONAL = "машинной плате биогенератора",
	)

/obj/item/circuitboard/machine/chem_dispenser/drinks
	name = "Soda Dispenser"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/chem_dispenser/drinks

/obj/item/circuitboard/machine/chem_dispenser/drinks/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата автомата с газировкой",
		GENITIVE = "машинной платы автомата с газировкой",
		DATIVE = "машинной плате автомата с газировкой",
		ACCUSATIVE = "машинную плату автомата с газировкой",
		INSTRUMENTAL = "машинной платой автомата с газировкой",
		PREPOSITIONAL = "машинной плате автомата с газировкой",
	)

/obj/item/circuitboard/machine/chem_dispenser/drinks/fullupgrade
	build_path = /obj/machinery/chem_dispenser/drinks/fullupgrade
	req_components = list(
		/datum/stock_part/matter_bin/tier4 = 2,
		/datum/stock_part/capacitor/tier4 = 2,
		/datum/stock_part/servo/tier4 = 2,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stock_parts/power_store/cell/bluespace = 1,
	)

/obj/item/circuitboard/machine/chem_dispenser/drinks/beer
	name = "Booze Dispenser"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/chem_dispenser/drinks/beer

/obj/item/circuitboard/machine/chem_dispenser/drinks/beer/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата раздатчика алкоголя",
		GENITIVE = "машинной платы раздатчика алкоголя",
		DATIVE = "машинной плате раздатчика алкоголя",
		ACCUSATIVE = "машинную плату раздатчика алкоголя",
		INSTRUMENTAL = "машинной платой раздатчика алкоголя",
		PREPOSITIONAL = "машинной плате раздатчика алкоголя",
	)

/obj/item/circuitboard/machine/chem_dispenser/drinks/beer/fullupgrade
	build_path = /obj/machinery/chem_dispenser/drinks/beer/fullupgrade
	req_components = list(
		/datum/stock_part/matter_bin/tier4 = 2,
		/datum/stock_part/capacitor/tier4 = 2,
		/datum/stock_part/servo/tier4 = 2,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stock_parts/power_store/cell/bluespace = 1,
	)

/obj/item/circuitboard/machine/chem_master/condi
	name = "CondiMaster 3000"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/chem_master/condimaster

/obj/item/circuitboard/machine/chem_master/condi/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата КондиМастера 3000",
		GENITIVE = "машинной платы КондиМастера 3000",
		DATIVE = "машинной плате КондиМастера 3000",
		ACCUSATIVE = "машинную плату КондиМастера 3000",
		INSTRUMENTAL = "машинной платой КондиМастера 3000",
		PREPOSITIONAL = "машинной плате КондиМастера 3000",
	)

/obj/item/circuitboard/machine/deep_fryer
	name = "Deep Fryer"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/deepfryer
	req_components = list(/datum/stock_part/micro_laser = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/deep_fryer/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата фритюрницы",
		GENITIVE = "машинной платы фритюрницы",
		DATIVE = "машинной плате фритюрницы",
		ACCUSATIVE = "машинную плату фритюрницы",
		INSTRUMENTAL = "машинной платой фритюрницы",
		PREPOSITIONAL = "машинной плате фритюрницы",
	)

/obj/item/circuitboard/machine/griddle
	name = "Griddle"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/griddle
	req_components = list(/datum/stock_part/micro_laser = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/griddle/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата сковороды",
		GENITIVE = "машинной платы сковороды",
		DATIVE = "машинной плате сковороды",
		ACCUSATIVE = "машинную плату сковороды",
		INSTRUMENTAL = "машинной платой сковороды",
		PREPOSITIONAL = "машинной плате сковороды",
	)

/obj/item/circuitboard/machine/oven
	name = "Oven"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/oven
	req_components = list(/datum/stock_part/micro_laser = 1)
	needs_anchored = TRUE

/obj/item/circuitboard/machine/oven/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата духовки",
		GENITIVE = "машинной платы духовки",
		DATIVE = "машинной плате духовки",
		ACCUSATIVE = "машинную плату духовки",
		INSTRUMENTAL = "машинной платой духовки",
		PREPOSITIONAL = "машинной плате духовки",
	)

/obj/item/circuitboard/machine/stove
	name = "Stove"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/stove
	req_components = list(/datum/stock_part/micro_laser = 1)
	needs_anchored = TRUE

/obj/item/circuitboard/machine/stove/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата плиты",
		GENITIVE = "машинной платы плиты",
		DATIVE = "машинной плате плиты",
		ACCUSATIVE = "машинную плату плиты",
		INSTRUMENTAL = "машинной платой плиты",
		PREPOSITIONAL = "машинной плате плиты",
	)

/obj/item/circuitboard/machine/range
	name = "Range (Oven & Stove)"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/oven/range
	req_components = list(/datum/stock_part/micro_laser = 2)
	needs_anchored = TRUE

/obj/item/circuitboard/machine/range/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата кухонной плиты",
		GENITIVE = "машинной платы кухонной плиты",
		DATIVE = "машинной плате кухонной плиты",
		ACCUSATIVE = "машинную плату кухонной плиты",
		INSTRUMENTAL = "машинной платой кухонной плиты",
		PREPOSITIONAL = "машинной плате кухонной плиты",
	)

/obj/item/circuitboard/machine/dish_drive
	name = "Dish Drive"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/dish_drive
	req_components = list(
		/obj/item/stack/sheet/glass = 1,
		/datum/stock_part/servo = 1,
		/datum/stock_part/matter_bin = 2)
	var/suction = TRUE
	var/transmit = TRUE
	needs_anchored = FALSE

/obj/item/circuitboard/machine/dish_drive/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата диш-драйва",
		GENITIVE = "машинной платы диш-драйва",
		DATIVE = "машинной плате диш-драйва",
		ACCUSATIVE = "машинную плату диш-драйва",
		INSTRUMENTAL = "машинной платой диш-драйва",
		PREPOSITIONAL = "машинной плате диш-драйва",
	)

/obj/item/circuitboard/machine/dish_drive/examine(mob/user)
	. = ..()
	. += span_notice("Её функция всасывания [suction ? "включена" : "отключена"]. Используйте её в руке, чтобы переключить.")
	. += span_notice("Её функция авто-отправки в мусор [transmit ? "включена" : "отключена"]. Альт-кликните, чтобы переключить.")

/obj/item/circuitboard/machine/dish_drive/attack_self(mob/living/user)
	suction = !suction
	to_chat(user, span_notice("Вы [suction ? "включаете" : "выключаете"] функцию всасывания платы."))

/obj/item/circuitboard/machine/dish_drive/click_alt(mob/living/user)
	transmit = !transmit
	to_chat(user, span_notice("Вы [transmit ? "включаете" : "выключаете"] функцию авто-отправки в мусор платы."))
	return CLICK_ACTION_SUCCESS

/obj/item/circuitboard/machine/gibber
	name = "Gibber"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/gibber
	req_components = list(
		/datum/stock_part/matter_bin = 1,
		/datum/stock_part/servo = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/gibber/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата гибки",
		GENITIVE = "машинной платы гибки",
		DATIVE = "машинной плате гибки",
		ACCUSATIVE = "машинную плату гибки",
		INSTRUMENTAL = "машинной платой гибки",
		PREPOSITIONAL = "машинной плате гибки",
	)

/obj/item/circuitboard/machine/hydroponics
	name = "Hydroponics Tray"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/hydroponics/constructable
	req_components = list(
		/datum/stock_part/matter_bin = 2,
		/datum/stock_part/servo = 1,
		/obj/item/stack/sheet/glass = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/hydroponics/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата гидропонной ванны",
		GENITIVE = "машинной платы гидропонной ванны",
		DATIVE = "машинной плате гидропонной ванны",
		ACCUSATIVE = "машинную плату гидропонной ванны",
		INSTRUMENTAL = "машинной платой гидропонной ванны",
		PREPOSITIONAL = "машинной плате гидропонной ванны",
	)

/obj/item/circuitboard/machine/hydroponics/fullupgrade
	build_path = /obj/machinery/hydroponics/constructable/fullupgrade
	specific_parts = TRUE
	req_components = list(
		/datum/stock_part/matter_bin/tier4 = 2,
		/datum/stock_part/servo/tier4 = 1,
		/obj/item/stack/sheet/glass = 1
	)

/obj/item/circuitboard/machine/microwave
	name = "Microwave"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/microwave
	req_components = list(
		/datum/stock_part/micro_laser = 1,
		/datum/stock_part/matter_bin = 1,
		/datum/stock_part/capacitor = 1,
		/obj/item/stack/cable_coil = 2,
		/obj/item/stack/sheet/glass = 2)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/microwave/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата микроволновки",
		GENITIVE = "машинной платы микроволновки",
		DATIVE = "машинной плате микроволновки",
		ACCUSATIVE = "машинную плату микроволновки",
		INSTRUMENTAL = "машинной платой микроволновки",
		PREPOSITIONAL = "машинной плате микроволновки",
	)

/obj/item/circuitboard/machine/microwave/engineering
	name = "Wireless Microwave Oven"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/microwave/engineering
	req_components = list(
		/datum/stock_part/micro_laser = 1,
		/datum/stock_part/matter_bin = 1,
		/datum/stock_part/capacitor/tier2 = 1,
		/obj/item/stack/cable_coil = 4,
		/obj/item/stack/sheet/glass = 2)

/obj/item/circuitboard/machine/microwave/engineering/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата беспроводной микроволновки",
		GENITIVE = "машинной платы беспроводной микроволновки",
		DATIVE = "машинной плате беспроводной микроволновки",
		ACCUSATIVE = "машинную плату беспроводной микроволновки",
		INSTRUMENTAL = "машинной платой беспроводной микроволновки",
		PREPOSITIONAL = "машинной плате беспроводной микроволновки",
	)

/obj/item/circuitboard/machine/processor
	name = "Food Processor"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/processor
	req_components = list(
		/datum/stock_part/matter_bin = 1,
		/datum/stock_part/servo = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/processor/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата кухонного комбайна",
		GENITIVE = "машинной платы кухонного комбайна",
		DATIVE = "машинной плате кухонного комбайна",
		ACCUSATIVE = "машинную плату кухонного комбайна",
		INSTRUMENTAL = "машинной платой кухонного комбайна",
		PREPOSITIONAL = "машинной плате кухонного комбайна",
	)

/obj/item/circuitboard/machine/processor/screwdriver_act(mob/living/user, obj/item/tool)
	if(build_path == /obj/machinery/processor)
		name = "Slime Processor"
		build_path = /obj/machinery/processor/slime
		to_chat(user, span_notice("Протоколы имен успешно обновлены."))
	else
		name = "Food Processor"
		build_path = /obj/machinery/processor
		to_chat(user, span_notice("Сброс протоколов имен."))
	return TRUE

/obj/item/circuitboard/machine/protolathe/department/service
	name = "Departmental Protolathe - Service"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/rnd/production/protolathe/department/service

/obj/item/circuitboard/machine/protolathe/department/service/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата сервисного протолата",
		GENITIVE = "машинной платы сервисного протолата",
		DATIVE = "машинной плате сервисного протолата",
		ACCUSATIVE = "машинную плату сервисного протолата",
		INSTRUMENTAL = "машинной платой сервисного протолата",
		PREPOSITIONAL = "машинной плате сервисного протолата",
	)

/obj/item/circuitboard/machine/recycler
	name = "Recycler"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/recycler
	req_components = list(
		/datum/stock_part/servo = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/recycler/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата переработчика мусора",
		GENITIVE = "машинной платы переработчика мусора",
		DATIVE = "машинной плате переработчика мусора",
		ACCUSATIVE = "машинную плату переработчика мусора",
		INSTRUMENTAL = "машинной платой переработчика мусора",
		PREPOSITIONAL = "машинной плате переработчика мусора",
	)

/obj/item/circuitboard/machine/seed_extractor
	name = "Seed Extractor"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/seed_extractor
	req_components = list(
		/datum/stock_part/matter_bin = 1,
		/datum/stock_part/servo = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/seed_extractor/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата экстрактора семян",
		GENITIVE = "машинной платы экстрактора семян",
		DATIVE = "машинной плате экстрактора семян",
		ACCUSATIVE = "машинную плату экстрактора семян",
		INSTRUMENTAL = "машинной платой экстрактора семян",
		PREPOSITIONAL = "машинной плате экстрактора семян",
	)

/obj/item/circuitboard/machine/techfab/department/service
	name = "\improper Departmental Techfab - Service"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/rnd/production/techfab/department/service

/obj/item/circuitboard/machine/techfab/department/service/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата сервисного техфаба",
		GENITIVE = "машинной платы сервисного техфаба",
		DATIVE = "машинной плате сервисного техфаба",
		ACCUSATIVE = "машинную плату сервисного техфаба",
		INSTRUMENTAL = "машинной платой сервисного техфаба",
		PREPOSITIONAL = "машинной плате сервисного техфаба",
	)

/obj/item/circuitboard/machine/fishing_portal_generator
	name = "Fishing Portal Generator"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/fishing_portal_generator
	req_components = list(
		/datum/stock_part/matter_bin = 2,
		/datum/stock_part/capacitor = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/fishing_portal_generator/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата генератора рыболовного портала",
		GENITIVE = "машинной платы генератора рыболовного портала",
		DATIVE = "машинной плате генератора рыболовного портала",
		ACCUSATIVE = "машинную плату генератора рыболовного портала",
		INSTRUMENTAL = "машинной платой генератора рыболовного портала",
		PREPOSITIONAL = "машинной плате генератора рыболовного портала",
	)

/obj/item/circuitboard/machine/fishing_portal_generator/emagged
	name = "Emagged Fishing Portal Generator"
	build_path = /obj/machinery/fishing_portal_generator/emagged

/obj/item/circuitboard/machine/fishing_portal_generator/emagged/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата взломанного генератора рыболовного портала",
		GENITIVE = "машинной платы взломанного генератора рыболовного портала",
		DATIVE = "машинной плате взломанного генератора рыболовного портала",
		ACCUSATIVE = "машинную плату взломанного генератора рыболовного портала",
		INSTRUMENTAL = "машинной платой взломанного генератора рыболовного портала",
		PREPOSITIONAL = "машинной плате взломанного генератора рыболовного портала",
	)

//Supply
/obj/item/circuitboard/machine/ore_redemption
	name = "Ore Redemption"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/mineral/ore_redemption
	req_components = list(
		/obj/item/stack/sheet/glass = 1,
		/datum/stock_part/matter_bin = 1,
		/datum/stock_part/micro_laser = 1,
		/datum/stock_part/servo = 1,
		/obj/item/assembly/igniter = 1)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/ore_redemption/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата переплавщика руды",
		GENITIVE = "машинной платы переплавщика руды",
		DATIVE = "машинной плате переплавщика руды",
		ACCUSATIVE = "машинную плату переплавщика руды",
		INSTRUMENTAL = "машинной платой переплавщика руды",
		PREPOSITIONAL = "машинной плате переплавщика руды",
	)

/obj/item/circuitboard/machine/ore_redemption/offstation
	build_path = /obj/machinery/mineral/ore_redemption/offstation

/obj/item/circuitboard/machine/ore_silo
	name = "Ore Silo"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/ore_silo
	req_components = list()

/obj/item/circuitboard/machine/ore_silo/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата рудного хранилища",
		GENITIVE = "машинной платы рудного хранилища",
		DATIVE = "машинной плате рудного хранилища",
		ACCUSATIVE = "машинную плату рудного хранилища",
		INSTRUMENTAL = "машинной платой рудного хранилища",
		PREPOSITIONAL = "машинной плате рудного хранилища",
	)

/obj/item/circuitboard/machine/protolathe/department/cargo
	name = "Departmental Protolathe - Cargo"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/rnd/production/protolathe/department/cargo

/obj/item/circuitboard/machine/protolathe/department/cargo/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата грузового протолата",
		GENITIVE = "машинной платы грузового протолата",
		DATIVE = "машинной плате грузового протолата",
		ACCUSATIVE = "машинную плату грузового протолата",
		INSTRUMENTAL = "машинной платой грузового протолата",
		PREPOSITIONAL = "машинной плате грузового протолата",
	)

/obj/item/circuitboard/machine/stacking_machine
	name = "Stacking Machine"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/mineral/stacking_machine
	req_components = list(
		/datum/stock_part/servo = 2,
		/datum/stock_part/matter_bin = 2)

/obj/item/circuitboard/machine/stacking_machine/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата стакера",
		GENITIVE = "машинной платы стакера",
		DATIVE = "машинной плате стакера",
		ACCUSATIVE = "машинную плату стакера",
		INSTRUMENTAL = "машинной платой стакера",
		PREPOSITIONAL = "машинной плате стакера",
	)

/obj/item/circuitboard/machine/stacking_unit_console
	name = "Stacking Machine Console"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/mineral/stacking_unit_console
	req_components = list(
		/obj/item/stack/sheet/glass = 2,
		/obj/item/stack/cable_coil = 5)

/obj/item/circuitboard/machine/stacking_unit_console/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата консоли стакера",
		GENITIVE = "машинной платы консоли стакера",
		DATIVE = "машинной плате консоли стакера",
		ACCUSATIVE = "машинную плату консоли стакера",
		INSTRUMENTAL = "машинной платой консоли стакера",
		PREPOSITIONAL = "машинной плате консоли стакера",
	)

/obj/item/circuitboard/machine/techfab/department/cargo
	name = "\improper Departmental Techfab - Cargo"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/rnd/production/techfab/department/cargo

/obj/item/circuitboard/machine/techfab/department/cargo/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата грузового техфаба",
		GENITIVE = "машинной платы грузового техфаба",
		DATIVE = "машинной плате грузового техфаба",
		ACCUSATIVE = "машинную плату грузового техфаба",
		INSTRUMENTAL = "машинной платой грузового техфаба",
		PREPOSITIONAL = "машинной плате грузового техфаба",
	)

/obj/item/circuitboard/machine/materials_market
	name = "Galactic Materials Market"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/materials_market
	req_components = list(
		/obj/item/stack/cable_coil = 5,
		/datum/stock_part/scanning_module = 1,
		/datum/stock_part/card_reader = 1)

/obj/item/circuitboard/machine/materials_market/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата рынка материалов",
		GENITIVE = "машинной платы рынка материалов",
		DATIVE = "машинной плате рынка материалов",
		ACCUSATIVE = "машинную плату рынка материалов",
		INSTRUMENTAL = "машинной платой рынка материалов",
		PREPOSITIONAL = "машинной плате рынка материалов",
	)

/obj/item/circuitboard/machine/mailsorter
	name = "Mail Sorter"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/mailsorter
	req_components = list(
		/obj/item/stack/sheet/glass = 1,
		/datum/stock_part/matter_bin = 2,
		/datum/stock_part/scanning_module = 1)
	needs_anchored = TRUE

/obj/item/circuitboard/machine/mailsorter/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата сортировщика почты",
		GENITIVE = "машинной платы сортировщика почты",
		DATIVE = "машинной плате сортировщика почты",
		ACCUSATIVE = "машинную плату сортировщика почты",
		INSTRUMENTAL = "машинной платой сортировщика почты",
		PREPOSITIONAL = "машинной плате сортировщика почты",
	)

//Tram
/obj/item/circuitboard/machine/crossing_signal
	name = "Crossing Signal"
	build_path = /obj/machinery/transport/crossing_signal
	req_components = list(
		/datum/stock_part/micro_laser = 1,
	)

/obj/item/circuitboard/machine/crossing_signal/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата сигнала перехода",
		GENITIVE = "машинной платы сигнала перехода",
		DATIVE = "машинной плате сигнала перехода",
		ACCUSATIVE = "машинную плату сигнала перехода",
		INSTRUMENTAL = "машинной платой сигнала перехода",
		PREPOSITIONAL = "машинной плате сигнала перехода",
	)

/obj/item/circuitboard/machine/guideway_sensor
	name = "Guideway Sensor"
	build_path = /obj/machinery/transport/guideway_sensor
	req_components = list(
		/obj/item/assembly/prox_sensor = 1,
	)

/obj/item/circuitboard/machine/guideway_sensor/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата путевого датчика",
		GENITIVE = "машинной платы путевого датчика",
		DATIVE = "машинной плате путевого датчика",
		ACCUSATIVE = "машинную плату путевого датчика",
		INSTRUMENTAL = "машинной платой путевого датчика",
		PREPOSITIONAL = "машинной плате путевого датчика",
	)

//Misc
/obj/item/circuitboard/machine/sheetifier
	name = "Sheet-meister 2000"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/sheetifier
	req_components = list(
		/datum/stock_part/servo = 2,
		/datum/stock_part/matter_bin = 2)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/sheetifier/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата Листо-мейстера 2000",
		GENITIVE = "машинной платы Листо-мейстера 2000",
		DATIVE = "машинной плате Листо-мейстера 2000",
		ACCUSATIVE = "машинную плату Листо-мейстера 2000",
		INSTRUMENTAL = "машинной платой Листо-мейстера 2000",
		PREPOSITIONAL = "машинной плате Листо-мейстера 2000",
	)

/obj/item/circuitboard/machine/restaurant_portal
	name = "Restaurant Portal"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/restaurant_portal
	req_components = list(
		/datum/stock_part/scanning_module = 2,
		/obj/item/stack/sheet/glass = 1)
	needs_anchored = TRUE
	/// Type of the venue that we're linked to
	var/venue_type = /datum/venue/restaurant

/obj/item/circuitboard/machine/restaurant_portal/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата ресторанного портала",
		GENITIVE = "машинной платы ресторанного портала",
		DATIVE = "машинной плате ресторанного портала",
		ACCUSATIVE = "машинную плату ресторанного портала",
		INSTRUMENTAL = "машинной платой ресторанного портала",
		PREPOSITIONAL = "машинной плате ресторанного портала",
	)

/obj/item/circuitboard/machine/restaurant_portal/multitool_act(mob/living/user)
	var/list/radial_items = list()
	var/list/radial_results = list()

	for(var/type_key in SSrestaurant.all_venues)
		var/datum/venue/venue = SSrestaurant.all_venues[type_key]
		radial_items[venue.name] = image('icons/obj/machines/restaurant_portal.dmi', venue.name)
		radial_results[venue.name] = type_key

	var/choice = show_radial_menu(user, src, radial_items, null, require_near = TRUE)

	if(!choice)
		return ITEM_INTERACT_BLOCKING

	venue_type = radial_results[choice]
	to_chat(user, span_notice("Вы изменяете место проведения, связанное с [RU_SRC_INS]."))
	return ITEM_INTERACT_SUCCESS

/obj/item/circuitboard/machine/restaurant_portal/examine(mob/user)
	. = ..()
	if (venue_type)
		var/datum/venue/as_venue = venue_type
		. += span_notice("[RU_SRC_NOM] связан с заведением [initial(as_venue.name)].")

/obj/item/circuitboard/machine/restaurant_portal/configure_machine(obj/machinery/restaurant_portal/machine)
	if(!istype(machine))
		CRASH("Cargo board attempted to configure incorrect machine type: [machine] ([machine?.type])")
	machine.linked_venue = SSrestaurant.all_venues[venue_type]
	machine.linked_venue.restaurant_portals += machine

/obj/item/circuitboard/machine/abductor
	name = "alien board (Report This)"
	icon_state = "abductor_mod"

/obj/item/circuitboard/machine/abductor/get_ru_names()
	return alist(
		NOMINATIVE = "инопланетная плата",
		GENITIVE = "инопланетной платы",
		DATIVE = "инопланетной плате",
		ACCUSATIVE = "инопланетную плату",
		INSTRUMENTAL = "инопланетной платой",
		PREPOSITIONAL = "инопланетной плате",
	)

/obj/item/circuitboard/machine/abductor/core
	name = "alien board"
	name_extension = "(Void Core)"
	build_path = /obj/machinery/power/rtg/abductor
	req_components = list(
		/datum/stock_part/capacitor = 1,
		/datum/stock_part/micro_laser = 1,
		/obj/item/stock_parts/power_store/cell/infinite/abductor = 1)
	def_components = list(
		/datum/stock_part/capacitor = /datum/stock_part/capacitor/tier4,
		/datum/stock_part/micro_laser = /datum/stock_part/micro_laser/tier4)

/obj/item/circuitboard/machine/hypnochair
	name = "Enhanced Interrogation Chamber"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/hypnochair
	req_components = list(
		/datum/stock_part/micro_laser = 2,
		/datum/stock_part/scanning_module = 2
	)

/obj/item/circuitboard/machine/hypnochair/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата камеры допроса",
		GENITIVE = "машинной платы камеры допроса",
		DATIVE = "машинной плате камеры допроса",
		ACCUSATIVE = "машинную плату камеры допроса",
		INSTRUMENTAL = "машинной платой камеры допроса",
		PREPOSITIONAL = "машинной плате камеры допроса",
	)

/obj/item/circuitboard/machine/plumbing_receiver
	name = "Chemical Recipient"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/plumbing/receiver
	req_components = list(
		/obj/item/stack/ore/bluespace_crystal = 1,
		/datum/stock_part/capacitor = 2,
		/obj/item/stack/sheet/glass = 1)
	def_components = list(/obj/item/stack/ore/bluespace_crystal = /obj/item/stack/ore/bluespace_crystal/artificial)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/plumbing_receiver/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата химического получателя",
		GENITIVE = "машинной платы химического получателя",
		DATIVE = "машинной плате химического получателя",
		ACCUSATIVE = "машинную плату химического получателя",
		INSTRUMENTAL = "машинной платой химического получателя",
		PREPOSITIONAL = "машинной плате химического получателя",
	)

/obj/item/circuitboard/machine/skill_station
	name = "Skill Station"
	build_path = /obj/machinery/skill_station
	req_components = list(
		/datum/stock_part/matter_bin = 2,
		/datum/stock_part/micro_laser = 2,
		/datum/stock_part/scanning_module = 2
	)

/obj/item/circuitboard/machine/skill_station/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата станции навыков",
		GENITIVE = "машинной платы станции навыков",
		DATIVE = "машинной плате станции навыков",
		ACCUSATIVE = "машинную плату станции навыков",
		INSTRUMENTAL = "машинной платой станции навыков",
		PREPOSITIONAL = "машинной плате станции навыков",
	)

/obj/item/circuitboard/machine/destructive_scanner
	name = "Experimental Destructive Scanner"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/destructive_scanner
	req_components = list(
		/datum/stock_part/micro_laser = 2,
		/datum/stock_part/matter_bin = 1,
		/datum/stock_part/servo = 2)

/obj/item/circuitboard/machine/destructive_scanner/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата деструктивного сканера",
		GENITIVE = "машинной платы деструктивного сканера",
		DATIVE = "машинной плате деструктивного сканера",
		ACCUSATIVE = "машинную плату деструктивного сканера",
		INSTRUMENTAL = "машинной платой деструктивного сканера",
		PREPOSITIONAL = "машинной плате деструктивного сканера",
	)

/obj/item/circuitboard/machine/doppler_array
	name = "Tachyon-Doppler Research Array"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/doppler_array
	req_components = list(
		/datum/stock_part/micro_laser = 2,
		/datum/stock_part/scanning_module = 4)

/obj/item/circuitboard/machine/doppler_array/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата тахионно-доплеровского массива",
		GENITIVE = "машинной платы тахионно-доплеровского массива",
		DATIVE = "машинной плате тахионно-доплеровского массива",
		ACCUSATIVE = "машинную плату тахионно-доплеровского массива",
		INSTRUMENTAL = "машинной платой тахионно-доплеровского массива",
		PREPOSITIONAL = "машинной плате тахионно-доплеровского массива",
	)

/obj/item/circuitboard/machine/exoscanner
	name = "Exoscanner"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/exoscanner
	req_components = list(
		/datum/stock_part/micro_laser = 4,
		/datum/stock_part/scanning_module = 4)

/obj/item/circuitboard/machine/exoscanner/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата экзосканера",
		GENITIVE = "машинной платы экзосканера",
		DATIVE = "машинной плате экзосканера",
		ACCUSATIVE = "машинную плату экзосканера",
		INSTRUMENTAL = "машинной платой экзосканера",
		PREPOSITIONAL = "машинной плате экзосканера",
	)

/obj/item/circuitboard/machine/exodrone_launcher
	name = "Exploration Drone Launcher"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/exodrone_launcher
	req_components = list(
		/datum/stock_part/micro_laser = 4,
		/datum/stock_part/scanning_module = 4)

/obj/item/circuitboard/machine/exodrone_launcher/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата пускателя дронов",
		GENITIVE = "машинной платы пускателя дронов",
		DATIVE = "машинной плате пускателя дронов",
		ACCUSATIVE = "машинную плату пускателя дронов",
		INSTRUMENTAL = "машинной платой пускателя дронов",
		PREPOSITIONAL = "машинной плате пускателя дронов",
	)

/obj/item/circuitboard/machine/ecto_sniffer
	name = "Ectoscopic Sniffer"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/ecto_sniffer
	req_components = list(
		/datum/stock_part/scanning_module = 1)

/obj/item/circuitboard/machine/ecto_sniffer/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата экто-сниффера",
		GENITIVE = "машинной платы экто-сниффера",
		DATIVE = "машинной плате экто-сниффера",
		ACCUSATIVE = "машинную плату экто-сниффера",
		INSTRUMENTAL = "машинной платой экто-сниффера",
		PREPOSITIONAL = "машинной плате экто-сниффера",
	)

/obj/item/circuitboard/machine/anomaly_refinery
	name = "Anomaly Refinery"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/research/anomaly_refinery
	req_components = list(
		/obj/item/stack/sheet/plasteel = 15,
		/datum/stock_part/scanning_module = 1,
		/datum/stock_part/servo = 1,
		)

/obj/item/circuitboard/machine/anomaly_refinery/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата переработчика аномалий",
		GENITIVE = "машинной платы переработчика аномалий",
		DATIVE = "машинной плате переработчика аномалий",
		ACCUSATIVE = "машинную плату переработчика аномалий",
		INSTRUMENTAL = "машинной платой переработчика аномалий",
		PREPOSITIONAL = "машинной плате переработчика аномалий",
	)

/obj/item/circuitboard/machine/tank_compressor
	name = "Tank Compressor"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/atmospherics/components/binary/tank_compressor
	req_components = list(
		/obj/item/stack/sheet/plasteel = 5,
		/datum/stock_part/scanning_module = 4,
		)

/obj/item/circuitboard/machine/tank_compressor/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата компрессора баков",
		GENITIVE = "машинной платы компрессора баков",
		DATIVE = "машинной плате компрессора баков",
		ACCUSATIVE = "машинную плату компрессора баков",
		INSTRUMENTAL = "машинной платой компрессора баков",
		PREPOSITIONAL = "машинной плате компрессора баков",
	)

/obj/item/circuitboard/machine/coffeemaker
	name = "Coffeemaker"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/coffeemaker
	req_components = list(
		/obj/item/stack/sheet/glass = 1,
		/obj/item/reagent_containers/cup/beaker = 2,
		/datum/stock_part/water_recycler = 1,
		/datum/stock_part/capacitor = 1,
		/datum/stock_part/micro_laser = 1,
	)

/obj/item/circuitboard/machine/coffeemaker/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата кофеварки",
		GENITIVE = "машинной платы кофеварки",
		DATIVE = "машинной плате кофеварки",
		ACCUSATIVE = "машинную плату кофеварки",
		INSTRUMENTAL = "машинной платой кофеварки",
		PREPOSITIONAL = "машинной плате кофеварки",
	)

/obj/item/circuitboard/machine/coffeemaker/impressa
	name = "Impressa Coffeemaker"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/coffeemaker/impressa
	req_components = list(
		/obj/item/stack/sheet/glass = 1,
		/obj/item/reagent_containers/cup/beaker = 2,
		/datum/stock_part/water_recycler = 1,
		/datum/stock_part/capacitor/tier2 = 1,
		/datum/stock_part/micro_laser/tier2 = 2,
	)

/obj/item/circuitboard/machine/coffeemaker/impressa/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата кофеварки Импресса",
		GENITIVE = "машинной платы кофеварки Импресса",
		DATIVE = "машинной плате кофеварки Импресса",
		ACCUSATIVE = "машинную плату кофеварки Импресса",
		INSTRUMENTAL = "машинной платой кофеварки Импресса",
		PREPOSITIONAL = "машинной плате кофеварки Импресса",
	)

/obj/item/circuitboard/machine/navbeacon
	name = "Bot Navigational Beacon"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/navbeacon
	req_components = list()

/obj/item/circuitboard/machine/navbeacon/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата навигационного маяка",
		GENITIVE = "машинной платы навигационного маяка",
		DATIVE = "машинной плате навигационного маяка",
		ACCUSATIVE = "машинную плату навигационного маяка",
		INSTRUMENTAL = "машинной платой навигационного маяка",
		PREPOSITIONAL = "машинной плате навигационного маяка",
	)

/obj/item/circuitboard/machine/radioactive_nebula_shielding
	name = "Radioactive Nebula Shielding"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/nebula_shielding/radiation
	req_components = list(
		/datum/stock_part/capacitor = 2,
		/obj/item/mod/module/rad_protection = 1,
		/obj/item/stack/sheet/plasteel = 2,
	)

/obj/item/circuitboard/machine/radioactive_nebula_shielding/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата радиационного щита",
		GENITIVE = "машинной платы радиационного щита",
		DATIVE = "машинной плате радиационного щита",
		ACCUSATIVE = "машинную плату радиационного щита",
		INSTRUMENTAL = "машинной платой радиационного щита",
		PREPOSITIONAL = "машинной плате радиационного щита",
	)

/obj/item/circuitboard/machine/brm
	name = "Boulder Retrieval Matrix"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/brm
	req_components = list(
		/datum/stock_part/capacitor = 1,
		/datum/stock_part/scanning_module = 1,
		/datum/stock_part/micro_laser = 1,
	)

/obj/item/circuitboard/machine/brm/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата МИВа",
		GENITIVE = "машинной платы МИВа",
		DATIVE = "машинной плате МИВа",
		ACCUSATIVE = "машинную плату МИВа",
		INSTRUMENTAL = "машинной платой МИВа",
		PREPOSITIONAL = "машинной плате МИВа",
	)

/obj/item/circuitboard/machine/refinery
	name = "Boulder Refinery"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/bouldertech/refinery
	req_components = list(
		/obj/item/assembly/igniter/condenser = 1,
		/datum/stock_part/servo = 2,
		/datum/stock_part/matter_bin = 2,
	)

/obj/item/circuitboard/machine/refinery/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата переработчика валунов",
		GENITIVE = "машинной платы переработчика валунов",
		DATIVE = "машинной плате переработчика валунов",
		ACCUSATIVE = "машинную плату переработчика валунов",
		INSTRUMENTAL = "машинной платой переработчика валунов",
		PREPOSITIONAL = "машинной плате переработчика валунов",
	)

/obj/item/circuitboard/machine/smelter
	name = "Boulder Smelter"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/bouldertech/refinery/smelter
	req_components = list(
		/obj/item/assembly/igniter = 1,
		/datum/stock_part/servo = 2,
		/datum/stock_part/matter_bin = 2,
	)

/obj/item/circuitboard/machine/smelter/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата плавильни валунов",
		GENITIVE = "машинной платы плавильни валунов",
		DATIVE = "машинной плате плавильни валунов",
		ACCUSATIVE = "машинную плату плавильни валунов",
		INSTRUMENTAL = "машинной платой плавильни валунов",
		PREPOSITIONAL = "машинной плате плавильни валунов",
	)

/obj/item/circuitboard/machine/shieldwallgen
	name = "Shield Wall Generator"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/power/shieldwallgen
	req_components = list(
		/datum/stock_part/capacitor/tier2 = 2,
		/datum/stock_part/micro_laser/tier2 = 2,
		/obj/item/stack/sheet/plasteel = 2,
	)

/obj/item/circuitboard/machine/shieldwallgen/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата генератора защитного поля",
		GENITIVE = "машинной платы генератора защитного поля",
		DATIVE = "машинной плате генератора защитного поля",
		ACCUSATIVE = "машинную плату генератора защитного поля",
		INSTRUMENTAL = "машинной платой генератора защитного поля",
		PREPOSITIONAL = "машинной плате генератора защитного поля",
	)

/obj/item/circuitboard/machine/flatpacker
	name = "Flatpacker"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/flatpacker
	req_components = list(
		/datum/stock_part/matter_bin = 2,
		/datum/stock_part/micro_laser = 2,
		/datum/stock_part/servo = 1,
		/obj/item/stack/sheet/plasteel = 5,
	)

/obj/item/circuitboard/machine/flatpacker/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата флэтпакера",
		GENITIVE = "машинной платы флэтпакера",
		DATIVE = "машинной плате флэтпакера",
		ACCUSATIVE = "машинную плату флэтпакера",
		INSTRUMENTAL = "машинной платой флэтпакера",
		PREPOSITIONAL = "машинной плате флэтпакера",
	)

/obj/item/circuitboard/machine/scrubber
	name = "Portable Air Scrubber"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/portable_atmospherics/scrubber
	needs_anchored = FALSE
	req_components = list(
		/obj/item/pipe/directional/scrubber = 1,
	)

/obj/item/circuitboard/machine/scrubber/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата переносного скруббера",
		GENITIVE = "машинной платы переносного скруббера",
		DATIVE = "машинной плате переносного скруббера",
		ACCUSATIVE = "машинную плату переносного скруббера",
		INSTRUMENTAL = "машинной платой переносного скруббера",
		PREPOSITIONAL = "машинной плате переносного скруббера",
	)

/obj/item/circuitboard/machine/pump
	name = "Portable Air Pump"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/portable_atmospherics/pump
	needs_anchored = FALSE
	req_components = list(
		/obj/item/pipe/directional/vent = 1,
	)

/obj/item/circuitboard/machine/pump/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата переносного насоса",
		GENITIVE = "машинной платы переносного насоса",
		DATIVE = "машинной плате переносного насоса",
		ACCUSATIVE = "машинную плату переносного насоса",
		INSTRUMENTAL = "машинной платой переносного насоса",
		PREPOSITIONAL = "машинной плате переносного насоса",
	)

/obj/item/circuitboard/machine/pipe_scrubber
	name = "Portable Pipe Scrubber"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/portable_atmospherics/pipe_scrubber
	needs_anchored = FALSE
	req_components = list(
		/obj/item/pipe/trinary/flippable/filter = 1,
	)

/obj/item/circuitboard/machine/pipe_scrubber/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата переносного скруббера труб",
		GENITIVE = "машинной платы переносного скруббера труб",
		DATIVE = "машинной плате переносного скруббера труб",
		ACCUSATIVE = "машинную плату переносного скруббера труб",
		INSTRUMENTAL = "машинной платой переносного скруббера труб",
		PREPOSITIONAL = "машинной плате переносного скруббера труб",
	)

/obj/item/circuitboard/machine/portagrav
	name = "Portable Gravity Unit"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/portagrav
	req_components = list(
		/datum/stock_part/capacitor = 2,
		/datum/stock_part/micro_laser = 2,
		/obj/item/stack/sheet/glass = 1)

/obj/item/circuitboard/machine/portagrav/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата портативного генератора гравитации",
		GENITIVE = "машинной платы портативного генератора гравитации",
		DATIVE = "машинной плате портативного генератора гравитации",
		ACCUSATIVE = "машинную плату портативного генератора гравитации",
		INSTRUMENTAL = "машинной платой портативного генератора гравитации",
		PREPOSITIONAL = "машинной плате портативного генератора гравитации",
	)

/obj/item/circuitboard/machine/big_manipulator
	name = "Big Manipulator"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/big_manipulator
	req_components = list(
		/datum/stock_part/servo = 1,
		)

/obj/item/circuitboard/machine/big_manipulator/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата большого манипулятора",
		GENITIVE = "машинной платы большого манипулятора",
		DATIVE = "машинной плате большого манипулятора",
		ACCUSATIVE = "машинную плату большого манипулятора",
		INSTRUMENTAL = "машинной платой большого манипулятора",
		PREPOSITIONAL = "машинной плате большого манипулятора",
	)

/obj/item/circuitboard/machine/manucrafter
	name = /obj/machinery/power/manufacturing/crafter::name
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/manufacturing/crafter
	req_components = list(
		/obj/item/stack/sheet/iron = 5,
		/datum/stock_part/servo = 1,
	)

/obj/item/circuitboard/machine/manucrafter/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата производственного крафтера",
		GENITIVE = "машинной платы производственного крафтера",
		DATIVE = "машинной плате производственного крафтера",
		ACCUSATIVE = "машинную плату производственного крафтера",
		INSTRUMENTAL = "машинной платой производственного крафтера",
		PREPOSITIONAL = "машинной плате производственного крафтера",
	)

/obj/item/circuitboard/machine/manulathe
	name = /obj/machinery/power/manufacturing/lathe::name
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/manufacturing/lathe
	req_components = list(
		/obj/item/stack/sheet/iron = 5,
		/datum/stock_part/matter_bin = 1,
	)

/obj/item/circuitboard/machine/manulathe/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата производственного станка",
		GENITIVE = "машинной платы производственного станка",
		DATIVE = "машинной плате производственного станка",
		ACCUSATIVE = "машинную плату производственного станка",
		INSTRUMENTAL = "машинной платой производственного станка",
		PREPOSITIONAL = "машинной плате производственного станка",
	)

/obj/item/circuitboard/machine/manucrusher
	name = /obj/machinery/power/manufacturing/crusher::name
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/manufacturing/crusher
	req_components = list(
		/obj/item/stack/sheet/iron = 5,
		/datum/stock_part/servo = 1,
	)

/obj/item/circuitboard/machine/manucrusher/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата производственного дробителя",
		GENITIVE = "машинной платы производственного дробителя",
		DATIVE = "машинной плате производственного дробителя",
		ACCUSATIVE = "машинную плату производственного дробителя",
		INSTRUMENTAL = "машинной платой производственного дробителя",
		PREPOSITIONAL = "машинной плате производственного дробителя",
	)

/obj/item/circuitboard/machine/manuunloader
	name = /obj/machinery/power/manufacturing/unloader::name
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/manufacturing/unloader
	req_components = list(
		/obj/item/stack/sheet/iron = 5,
		/datum/stock_part/servo = 1,
	)

/obj/item/circuitboard/machine/manuunloader/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата производственного выгрузчика",
		GENITIVE = "машинной платы производственного выгрузчика",
		DATIVE = "машинной плате производственного выгрузчика",
		ACCUSATIVE = "машинную плату производственного выгрузчика",
		INSTRUMENTAL = "машинной платой производственного выгрузчика",
		PREPOSITIONAL = "машинной плате производственного выгрузчика",
	)

/obj/item/circuitboard/machine/manusorter
	name = /obj/machinery/power/manufacturing/sorter::name
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/manufacturing/sorter
	req_components = list(
		/obj/item/stack/sheet/iron = 5,
		/datum/stock_part/scanning_module = 1,
	)

/obj/item/circuitboard/machine/manusorter/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата производственного сортировщика",
		GENITIVE = "машинной платы производственного сортировщика",
		DATIVE = "машинной плате производственного сортировщика",
		ACCUSATIVE = "машинную плату производственного сортировщика",
		INSTRUMENTAL = "машинной платой производственного сортировщика",
		PREPOSITIONAL = "машинной плате производственного сортировщика",
	)

/obj/item/circuitboard/machine/manusmelter
	name = /obj/machinery/power/manufacturing/smelter::name
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/manufacturing/smelter
	req_components = list(
		/obj/item/stack/sheet/iron = 5,
		/datum/stock_part/micro_laser = 1,
	)

/obj/item/circuitboard/machine/manusmelter/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата производственной плавильни",
		GENITIVE = "машинной платы производственной плавильни",
		DATIVE = "машинной плате производственной плавильни",
		ACCUSATIVE = "машинную плату производственной плавильни",
		INSTRUMENTAL = "машинной платой производственной плавильни",
		PREPOSITIONAL = "машинной плате производственной плавильни",
	)

/obj/item/circuitboard/machine/manurouter
	name = /obj/machinery/power/manufacturing/router::name
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/manufacturing/router
	req_components = list(
		/obj/item/stack/sheet/iron = 5,
	)

/obj/item/circuitboard/machine/manurouter/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата производственного маршрутизатора",
		GENITIVE = "машинной платы производственного маршрутизатора",
		DATIVE = "машинной плате производственного маршрутизатора",
		ACCUSATIVE = "машинную плату производственного маршрутизатора",
		INSTRUMENTAL = "машинной платой производственного маршрутизатора",
		PREPOSITIONAL = "машинной плате производственного маршрутизатора",
	)

/obj/item/circuitboard/machine/atmos_shield_gen
	name = /obj/machinery/atmos_shield_gen::name
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/atmos_shield_gen
	req_components = list(
		/datum/stock_part/micro_laser = 1,
		/datum/stock_part/capacitor = 1,
	)

/obj/item/circuitboard/machine/atmos_shield_gen/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата атмосферного генератора щита",
		GENITIVE = "машинной платы атмосферного генератора щита",
		DATIVE = "машинной плате атмосферного генератора щита",
		ACCUSATIVE = "машинную плату атмосферного генератора щита",
		INSTRUMENTAL = "машинной платой атмосферного генератора щита",
		PREPOSITIONAL = "машинной плате атмосферного генератора щита",
	)

/obj/item/circuitboard/machine/engine
	name = "Shuttle Engine"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/shuttle_engine
	needs_anchored = FALSE
	req_components = list(
		/datum/stock_part/capacitor = 2,
		/datum/stock_part/micro_laser = 2,
	)

/obj/item/circuitboard/machine/engine/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата двигателя шаттла",
		GENITIVE = "машинной платы двигателя шаттла",
		DATIVE = "машинной плате двигателя шаттла",
		ACCUSATIVE = "машинную плату двигателя шаттла",
		INSTRUMENTAL = "машинной платой двигателя шаттла",
		PREPOSITIONAL = "машинной плате двигателя шаттла",
	)

/obj/item/circuitboard/machine/engine/heater
	name = "Shuttle Engine Heater"
	build_path = /obj/machinery/power/shuttle_engine/heater

/obj/item/circuitboard/machine/engine/heater/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата обогревателя двигателя шаттла",
		GENITIVE = "машинной платы обогревателя двигателя шаттла",
		DATIVE = "машинной плате обогревателя двигателя шаттла",
		ACCUSATIVE = "машинную плату обогревателя двигателя шаттла",
		INSTRUMENTAL = "машинной платой обогревателя двигателя шаттла",
		PREPOSITIONAL = "машинной плате обогревателя двигателя шаттла",
	)

/obj/item/circuitboard/machine/engine/propulsion
	name = "Shuttle Engine Propulsion"
	build_path = /obj/machinery/power/shuttle_engine/propulsion

/obj/item/circuitboard/machine/engine/propulsion/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата сопла двигателя шаттла",
		GENITIVE = "машинной платы сопла двигателя шаттла",
		DATIVE = "машинной плате сопла двигателя шаттла",
		ACCUSATIVE = "машинную плату сопла двигателя шаттла",
		INSTRUMENTAL = "машинной платой сопла двигателя шаттла",
		PREPOSITIONAL = "машинной плате сопла двигателя шаттла",
	)

/obj/item/circuitboard/machine/quantum_server
	name = "Quantum Server"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/quantum_server
	req_components = list(
		/datum/stock_part/servo = 2,
		/datum/stock_part/scanning_module = 1,
		/datum/stock_part/capacitor = 1,
	)

/obj/item/circuitboard/machine/quantum_server/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата квантового сервера",
		GENITIVE = "машинной платы квантового сервера",
		DATIVE = "машинной плате квантового сервера",
		ACCUSATIVE = "машинную плату квантового сервера",
		INSTRUMENTAL = "машинной платой квантового сервера",
		PREPOSITIONAL = "машинной плате квантового сервера",
	)

/obj/item/circuitboard/machine/netpod
	name = "Netpod"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/netpod
	req_components = list(
		/datum/stock_part/servo = 1,
		/datum/stock_part/matter_bin = 2,
	)

/obj/item/circuitboard/machine/netpod/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата нетпода",
		GENITIVE = "машинной платы нетпода",
		DATIVE = "машинной плате нетпода",
		ACCUSATIVE = "машинную плату нетпода",
		INSTRUMENTAL = "машинной платой нетпода",
		PREPOSITIONAL = "машинной плате нетпода",
	)

/obj/item/circuitboard/computer/quantum_console
	name = "Quantum Console"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/computer/quantum_console

/obj/item/circuitboard/computer/quantum_console/get_ru_names()
	return alist(
		NOMINATIVE = "плата квантовой консоли",
		GENITIVE = "платы квантовой консоли",
		DATIVE = "плате квантовой консоли",
		ACCUSATIVE = "плату квантовой консоли",
		INSTRUMENTAL = "платой квантовой консоли",
		PREPOSITIONAL = "плате квантовой консоли",
	)

/obj/item/circuitboard/machine/byteforge
	name = "Byteforge"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/byteforge
	req_components = list(
		/datum/stock_part/micro_laser = 1,
	)

/obj/item/circuitboard/machine/byteforge/get_ru_names()
	return alist(
		NOMINATIVE = "машинная плата байт-кузницы",
		GENITIVE = "машинной платы байт-кузницы",
		DATIVE = "машинной плате байт-кузницы",
		ACCUSATIVE = "машинную плату байт-кузницы",
		INSTRUMENTAL = "машинной платой байт-кузницы",
		PREPOSITIONAL = "машинной плате байт-кузницы",
	)
