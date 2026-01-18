/obj/machinery/rnd/production/circuit_imprinter
	name = "circuit imprinter"
	desc = "Производит печатные платы для сборки оборудования."
	icon_state = "circuit_imprinter"
	production_animation = "circuit_imprinter_ani"
	circuit = /obj/item/circuitboard/machine/circuit_imprinter
	allowed_buildtypes = IMPRINTER

/obj/machinery/rnd/production/circuit_imprinter/get_ru_names()
	return alist(
		NOMINATIVE = "принтер схем",
		GENITIVE = "принтера схем",
		DATIVE = "принтеру схем",
		ACCUSATIVE = "принтер схем",
		INSTRUMENTAL = "принтером схем",
		PREPOSITIONAL = "принтере схем",
	)

/obj/machinery/rnd/production/circuit_imprinter/compute_efficiency()
	var/rating = 0
	for(var/datum/stock_part/servo/servo in component_parts)
		rating += servo.tier

	return 0.5 ** max(rating - 1, 0) // One sheet, half sheet, quarter sheet, eighth sheet.

/obj/machinery/rnd/production/circuit_imprinter/flick_animation(datum/material/mat)
	return //we presently have no animation

/obj/machinery/rnd/production/circuit_imprinter/offstation
	name = "ancient circuit imprinter"
	desc = "Производит печатные платы для сборки оборудования. Его древняя конструкция может ограничивать возможность печати всех известных технологий."
	allowed_buildtypes = AWAY_IMPRINTER
	circuit = /obj/item/circuitboard/machine/circuit_imprinter/offstation

/obj/machinery/rnd/production/circuit_imprinter/offstation/get_ru_names()
	return alist(
		NOMINATIVE = "древний принтер схем",
		GENITIVE = "древнего принтера схем",
		DATIVE = "древнему принтеру схем",
		ACCUSATIVE = "древний принтер схем",
		INSTRUMENTAL = "древним принтером схем",
		PREPOSITIONAL = "древнем принтере схем",
	)
