//map and direction signs

/obj/structure/sign/map
	name = "station map"
	desc = "Навигационная схема станции."
	max_integrity = 500

/obj/structure/sign/map/get_ru_names()
	return alist(
		NOMINATIVE = "карта станции",
		GENITIVE = "карты станции",
		DATIVE = "карте станции",
		ACCUSATIVE = "карту станции",
		INSTRUMENTAL = "картой станции",
		PREPOSITIONAL = "карте станции",
	)

/obj/structure/sign/map/left
	icon_state = "map-left"
	desc = "Навигационная схема списанной станции Спинвардского сектора SS-02: Аванпост класса \"Бокс\"."

/obj/structure/sign/map/right
	icon_state = "map-right"
	desc = "Навигационная схема списанной станции Спинвардского сектора SS-02: Аванпост класса \"Бокс\"."

/obj/structure/sign/map/meta
	desc = "Изображение станции в рамке. По часовой стрелке от службы безопасности вверху (красный) вы видите инженерный отсек (жёлтый), научный отдел (фиолетовый), отбытие (красный и белый), медбей (зелёный), прибытие (синий и белый) и, наконец, карго (коричневый)."

/obj/structure/sign/map/meta/left
	icon_state = "map-left-MS"

/obj/structure/sign/map/meta/right
	icon_state = "map-right-MS"

/obj/structure/sign/map/pubby
	icon_state = "map-pubby"

/obj/structure/sign/directions/science
	name = "science department sign"
	desc = "Указатель, показывающий дорогу в научный отдел."
	icon_state = "direction_sci"

/obj/structure/sign/directions/science/get_ru_names()
	return alist(
		NOMINATIVE = "указатель научного отдела",
		GENITIVE = "указателя научного отдела",
		DATIVE = "указателю научного отдела",
		ACCUSATIVE = "указатель научного отдела",
		INSTRUMENTAL = "указателем научного отдела",
		PREPOSITIONAL = "указателе научного отдела",
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/science, 32)

/obj/structure/sign/directions/engineering
	name = "engineering department sign"
	desc = "Указатель, показывающий дорогу в инженерный отсек."
	icon_state = "direction_eng"

/obj/structure/sign/directions/engineering/get_ru_names()
	return alist(
		NOMINATIVE = "указатель инженерного отсека",
		GENITIVE = "указателя инженерного отсека",
		DATIVE = "указателю инженерного отсека",
		ACCUSATIVE = "указатель инженерного отсека",
		INSTRUMENTAL = "указателем инженерного отсека",
		PREPOSITIONAL = "указателе инженерного отсека",
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/engineering, 32)

/obj/structure/sign/directions/security
	name = "security department sign"
	desc = "Указатель, показывающий дорогу в службу безопасности."
	icon_state = "direction_sec"

/obj/structure/sign/directions/security/get_ru_names()
	return alist(
		NOMINATIVE = "указатель службы безопасности",
		GENITIVE = "указателя службы безопасности",
		DATIVE = "указателю службы безопасности",
		ACCUSATIVE = "указатель службы безопасности",
		INSTRUMENTAL = "указателем службы безопасности",
		PREPOSITIONAL = "указателе службы безопасности",
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/security, 32)

/obj/structure/sign/directions/medical
	name = "medbay sign"
	desc = "Указатель, показывающий дорогу в медбей."
	icon_state = "direction_med"

/obj/structure/sign/directions/medical/get_ru_names()
	return alist(
		NOMINATIVE = "указатель медбея",
		GENITIVE = "указателя медбея",
		DATIVE = "указателю медбея",
		ACCUSATIVE = "указатель медбея",
		INSTRUMENTAL = "указателем медбея",
		PREPOSITIONAL = "указателе медбея",
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/medical, 32)

/obj/structure/sign/directions/evac
	name = "evacuation sign"
	desc = "Указатель, показывающий дорогу к докам спасательного шаттла."
	icon_state = "direction_evac"

/obj/structure/sign/directions/evac/get_ru_names()
	return alist(
		NOMINATIVE = "указатель эвакуации",
		GENITIVE = "указателя эвакуации",
		DATIVE = "указателю эвакуации",
		ACCUSATIVE = "указатель эвакуации",
		INSTRUMENTAL = "указателем эвакуации",
		PREPOSITIONAL = "указателе эвакуации",
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/evac, 32)

/obj/structure/sign/directions/supply
	name = "cargo sign"
	desc = "Указатель, показывающий дорогу в отдел снабжения."
	icon_state = "direction_supply"

/obj/structure/sign/directions/supply/get_ru_names()
	return alist(
		NOMINATIVE = "указатель снабжения",
		GENITIVE = "указателя снабжения",
		DATIVE = "указателю снабжения",
		ACCUSATIVE = "указатель снабжения",
		INSTRUMENTAL = "указателем снабжения",
		PREPOSITIONAL = "указателе снабжения",
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/supply, 32)

/obj/structure/sign/directions/command
	name = "command department sign"
	desc = "Указатель, показывающий дорогу в отсек командования."
	icon_state = "direction_bridge"

/obj/structure/sign/directions/command/get_ru_names()
	return alist(
		NOMINATIVE = "указатель командования",
		GENITIVE = "указателя командования",
		DATIVE = "указателю командования",
		ACCUSATIVE = "указатель командования",
		INSTRUMENTAL = "указателем командования",
		PREPOSITIONAL = "указателе командования",
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/command, 32)

/obj/structure/sign/directions/vault
	name = "vault sign"
	desc = "Указатель, показывающий дорогу к хранилищу станции."
	icon_state = "direction_vault"

/obj/structure/sign/directions/vault/get_ru_names()
	return alist(
		NOMINATIVE = "указатель хранилища",
		GENITIVE = "указателя хранилища",
		DATIVE = "указателю хранилища",
		ACCUSATIVE = "указатель хранилища",
		INSTRUMENTAL = "указателем хранилища",
		PREPOSITIONAL = "указателе хранилища",
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/vault, 32)

/obj/structure/sign/directions/upload
	name = "upload sign"
	desc = "Указатель, показывающий дорогу к загрузочной ИИ."
	icon_state = "direction_upload"

/obj/structure/sign/directions/upload/get_ru_names()
	return alist(
		NOMINATIVE = "указатель загрузочной",
		GENITIVE = "указателя загрузочной",
		DATIVE = "указателю загрузочной",
		ACCUSATIVE = "указатель загрузочной",
		INSTRUMENTAL = "указателем загрузочной",
		PREPOSITIONAL = "указателе загрузочной",
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/upload, 32)

/obj/structure/sign/directions/dorms
	name = "dormitories sign"
	desc = "Указатель, показывающий дорогу в жилой отсек."
	icon_state = "direction_dorms"

/obj/structure/sign/directions/dorms/get_ru_names()
	return alist(
		NOMINATIVE = "указатель жилого отсека",
		GENITIVE = "указателя жилого отсека",
		DATIVE = "указателю жилого отсека",
		ACCUSATIVE = "указатель жилого отсека",
		INSTRUMENTAL = "указателем жилого отсека",
		PREPOSITIONAL = "указателе жилого отсека",
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/dorms, 32)

/obj/structure/sign/directions/lavaland
	name = "lava sign"
	desc = "Указатель, показывающий дорогу к чему-то горячему."
	icon_state = "direction_lavaland"

/obj/structure/sign/directions/lavaland/get_ru_names()
	return alist(
		NOMINATIVE = "указатель на лаву",
		GENITIVE = "указателя на лаву",
		DATIVE = "указателю на лаву",
		ACCUSATIVE = "указатель на лаву",
		INSTRUMENTAL = "указателем на лаву",
		PREPOSITIONAL = "указателе на лаву",
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/lavaland, 32)

/obj/structure/sign/directions/arrival
	name = "arrivals sign"
	desc = "Указатель, показывающий дорогу к докам шаттла прибытия."
	icon_state = "direction_arrival"

/obj/structure/sign/directions/arrival/get_ru_names()
	return alist(
		NOMINATIVE = "указатель прибытия",
		GENITIVE = "указателя прибытия",
		DATIVE = "указателю прибытия",
		ACCUSATIVE = "указатель прибытия",
		INSTRUMENTAL = "указателем прибытия",
		PREPOSITIONAL = "указателе прибытия",
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/arrival, 32)
