/obj/machinery/rnd/production/protolathe/department
	name = "department protolathe"
	desc = "Специальный протолат со встроенным интерфейсом для использования в отделах. Оснащён приёмниками ExoSync, позволяющими печатать проекты, соответствующие закодированному в ПЗУ типу отдела."
	icon_state = "protolathe"
	circuit = /obj/item/circuitboard/machine/protolathe/department

/obj/machinery/rnd/production/protolathe/department/get_ru_names()
	return alist(
		NOMINATIVE = "протолат отдела",
		GENITIVE = "протолата отдела",
		DATIVE = "протолату отдела",
		ACCUSATIVE = "протолат отдела",
		INSTRUMENTAL = "протолатом отдела",
		PREPOSITIONAL = "протолате отдела",
	)

/obj/machinery/rnd/production/protolathe/department/engineering
	name = "department protolathe (Engineering)"
	allowed_department_flags = DEPARTMENT_BITFLAG_ENGINEERING
	circuit = /obj/item/circuitboard/machine/protolathe/department/engineering
	stripe_color = "#EFB341"
	payment_department = ACCOUNT_ENG

/obj/machinery/rnd/production/protolathe/department/engineering/get_ru_names()
	return alist(
		NOMINATIVE = "протолат инженерного отдела",
		GENITIVE = "протолата инженерного отдела",
		DATIVE = "протолату инженерного отдела",
		ACCUSATIVE = "протолат инженерного отдела",
		INSTRUMENTAL = "протолатом инженерного отдела",
		PREPOSITIONAL = "протолате инженерного отдела",
	)

/obj/machinery/rnd/production/protolathe/department/service
	name = "department protolathe (Service)"
	allowed_department_flags = DEPARTMENT_BITFLAG_SERVICE
	circuit = /obj/item/circuitboard/machine/protolathe/department/service
	stripe_color = "#83ca41"
	payment_department = ACCOUNT_SRV

/obj/machinery/rnd/production/protolathe/department/service/get_ru_names()
	return alist(
		NOMINATIVE = "протолат сервисного отдела",
		GENITIVE = "протолата сервисного отдела",
		DATIVE = "протолату сервисного отдела",
		ACCUSATIVE = "протолат сервисного отдела",
		INSTRUMENTAL = "протолатом сервисного отдела",
		PREPOSITIONAL = "протолате сервисного отдела",
	)

/obj/machinery/rnd/production/protolathe/department/medical
	name = "department protolathe (Medical)"
	allowed_department_flags = DEPARTMENT_BITFLAG_MEDICAL
	circuit = /obj/item/circuitboard/machine/protolathe/department/medical
	stripe_color = "#52B4E9"
	payment_department = ACCOUNT_MED

/obj/machinery/rnd/production/protolathe/department/medical/get_ru_names()
	return alist(
		NOMINATIVE = "протолат медицинского отдела",
		GENITIVE = "протолата медицинского отдела",
		DATIVE = "протолату медицинского отдела",
		ACCUSATIVE = "протолат медицинского отдела",
		INSTRUMENTAL = "протолатом медицинского отдела",
		PREPOSITIONAL = "протолате медицинского отдела",
	)

/obj/machinery/rnd/production/protolathe/department/cargo
	name = "department protolathe (Cargo)"
	allowed_department_flags = DEPARTMENT_BITFLAG_CARGO
	circuit = /obj/item/circuitboard/machine/protolathe/department/cargo
	stripe_color = "#956929"
	payment_department = ACCOUNT_CAR

/obj/machinery/rnd/production/protolathe/department/cargo/get_ru_names()
	return alist(
		NOMINATIVE = "протолат отдела снабжения",
		GENITIVE = "протолата отдела снабжения",
		DATIVE = "протолату отдела снабжения",
		ACCUSATIVE = "протолат отдела снабжения",
		INSTRUMENTAL = "протолатом отдела снабжения",
		PREPOSITIONAL = "протолате отдела снабжения",
	)

/obj/machinery/rnd/production/protolathe/department/science
	name = "department protolathe (Science)"
	allowed_department_flags = DEPARTMENT_BITFLAG_SCIENCE
	circuit = /obj/item/circuitboard/machine/protolathe/department/science
	stripe_color = "#D381C9"
	payment_department = ACCOUNT_SCI

/obj/machinery/rnd/production/protolathe/department/science/get_ru_names()
	return alist(
		NOMINATIVE = "протолат научного отдела",
		GENITIVE = "протолата научного отдела",
		DATIVE = "протолату научного отдела",
		ACCUSATIVE = "протолат научного отдела",
		INSTRUMENTAL = "протолатом научного отдела",
		PREPOSITIONAL = "протолате научного отдела",
	)

/obj/machinery/rnd/production/protolathe/department/security
	name = "department protolathe (Security)"
	allowed_department_flags = DEPARTMENT_BITFLAG_SECURITY
	circuit = /obj/item/circuitboard/machine/protolathe/department/security
	stripe_color = "#DE3A3A"
	payment_department = ACCOUNT_SEC

/obj/machinery/rnd/production/protolathe/department/security/get_ru_names()
	return alist(
		NOMINATIVE = "протолат службы безопасности",
		GENITIVE = "протолата службы безопасности",
		DATIVE = "протолату службы безопасности",
		ACCUSATIVE = "протолат службы безопасности",
		INSTRUMENTAL = "протолатом службы безопасности",
		PREPOSITIONAL = "протолате службы безопасности",
	)
