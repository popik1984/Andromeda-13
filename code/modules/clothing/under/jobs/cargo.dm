/obj/item/clothing/under/rank/cargo
	icon = 'icons/obj/clothing/under/cargo.dmi'
	worn_icon = 'icons/mob/clothing/under/cargo.dmi'
	abstract_type = /obj/item/clothing/under/rank/cargo

/obj/item/clothing/under/rank/cargo/qm
	name = "quartermaster's uniform"
	desc = "Коричневая сорочка в паре с чёрными брюками. Специально разработаны для свидания на ящиках пива."
	icon_state = "qm"
	inhand_icon_state = "lb_suit"

/obj/item/clothing/under/rank/cargo/qm/get_ru_names()
	return alist(
		NOMINATIVE = "униформа квартирмейстера",
		GENITIVE = "униформы квартирмейстера",
		DATIVE = "униформе квартирмейстера",
		ACCUSATIVE = "униформу квартирмейстера",
		INSTRUMENTAL = "униформой квартирмейстера",
		PREPOSITIONAL = "униформе квартирмейстера",
	)

/obj/item/clothing/under/rank/cargo/qm/skirt
	name = "quartermaster's skirt"
	desc = "Коричневая сорочка в паре с длинной плиссированной чёрной юбкой. Специально разработаны для свидания на ящиках пива."
	icon_state = "qm_skirt"
	inhand_icon_state = "lb_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/cargo/qm/skirt/get_ru_names()
	return alist(
		NOMINATIVE = "юбка квартирмейстера",
		GENITIVE = "юбки квартирмейстера",
		DATIVE = "юбке квартирмейстера",
		ACCUSATIVE = "юбку квартирмейстера",
		INSTRUMENTAL = "юбкой квартирмейстера",
		PREPOSITIONAL = "юбке квартирмейстера",
	)

/obj/item/clothing/under/rank/cargo/tech
	name = "cargo technician's uniform"
	desc = "Коричневый свитшот с чёрными джинсами, которые странно часто рвутся в районе пятой точки при попытке сделать становую тягу с ящиком пива."
	icon_state = "cargotech"
	inhand_icon_state = "lb_suit"

/obj/item/clothing/under/rank/cargo/tech/get_ru_names()
	return alist(
		NOMINATIVE = "униформа грузчика",
		GENITIVE = "униформы грузчика",
		DATIVE = "униформе грузчика",
		ACCUSATIVE = "униформу грузчика",
		INSTRUMENTAL = "униформой грузчика",
		PREPOSITIONAL = "униформе грузчика",
	)

/obj/item/clothing/under/rank/cargo/tech/alt
	name = "cargo technician's shorts"
	desc = "Футболка с шортами. Больше подходит для работяг со смуглым тоном кожи."
	icon_state = "cargotech_alt"
	inhand_icon_state = "lb_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/cargo/tech/alt/get_ru_names()
	return alist(
		NOMINATIVE = "шорты грузчика",
		GENITIVE = "шорт грузчика",
		DATIVE = "шортам грузчика",
		ACCUSATIVE = "шорты грузчика",
		INSTRUMENTAL = "шортами грузчика",
		PREPOSITIONAL = "шортах грузчика",
	)

/obj/item/clothing/under/rank/cargo/tech/skirt
	name = "cargo technician's skirt"
	desc = "Коричневый свитшот и чёрная юбка. Кажется, или юбка не идёт грузчику?"
	icon_state = "cargo_skirt"
	inhand_icon_state = "lb_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/cargo/tech/skirt/get_ru_names()
	return alist(
		NOMINATIVE = "юбка грузчика",
		GENITIVE = "юбки грузчика",
		DATIVE = "юбке грузчика",
		ACCUSATIVE = "юбку грузчика",
		INSTRUMENTAL = "юбкой грузчика",
		PREPOSITIONAL = "юбке грузчика",
	)

/obj/item/clothing/under/rank/cargo/tech/skirt/alt
	name = "cargo technician's shortskirt"
	desc = "Футболка с короткой юбкой. Другие грузчики слишком часто отвлекаются на эту форму..."
	icon_state = "cargo_skirt_alt"

/obj/item/clothing/under/rank/cargo/tech/skirt/alt/get_ru_names()
	return alist(
		NOMINATIVE = "короткая юбка грузчика",
		GENITIVE = "короткой юбки грузчика",
		DATIVE = "короткой юбке грузчика",
		ACCUSATIVE = "короткую юбку грузчика",
		INSTRUMENTAL = "короткой юбкой грузчика",
		PREPOSITIONAL = "короткой юбке грузчика",
	)

/obj/item/clothing/under/rank/cargo/miner
	name = "shaft miner's jumpsuit"
	desc = "Это стильный комбинезон с подтяжками. Почему верх этой формы выполнен в фиолетовом цвете."
	icon_state = "miner"
	inhand_icon_state = null
	armor_type = /datum/armor/clothing_under/cargo_miner
	resistance_flags = NONE

/datum/armor/clothing_under/cargo_miner
	fire = 80
	wound = 10

/obj/item/clothing/under/rank/cargo/miner/get_ru_names()
	return alist(
		NOMINATIVE = "комбинезон шахтёра",
		GENITIVE = "комбинезона шахтёра",
		DATIVE = "комбинезону шахтёра",
		ACCUSATIVE = "комбинезон шахтёра",
		INSTRUMENTAL = "комбинезоном шахтёра",
		PREPOSITIONAL = "комбинезоне шахтёра",
	)

/obj/item/clothing/under/rank/cargo/miner/lavaland
	name = "shaft miner's jumpsuit"
	desc = "Серая униформа для работы в опасных условиях лаваленда. Носитель этой формы никогда не спит, он говорит, что никогда не умрёт, он работает и на свету и в тени, а в его руке ускоритель..."
	icon_state = "explorer"
	inhand_icon_state = null

/obj/item/clothing/under/rank/cargo/miner/lavaland/get_ru_names()
	return alist(
		NOMINATIVE = "комбинезон шахтёра",
		GENITIVE = "комбинезона шахтёра",
		DATIVE = "комбинезону шахтёра",
		ACCUSATIVE = "комбинезон шахтёра",
		INSTRUMENTAL = "комбинезоном шахтёра",
		PREPOSITIONAL = "комбинезоне шахтёра",
	)

/obj/item/clothing/under/rank/cargo/bitrunner
	name = "bitrunner's jumpsuit"
	desc = "Это кожаный комбинезон, который носит битраннер. Безвкусный, но удобный для ношения при длительной симуляции с вульпами."
	icon_state = "bitrunner"
	inhand_icon_state = "w_suit"

/obj/item/clothing/under/rank/cargo/bitrunner/get_ru_names()
	return alist(
		NOMINATIVE = "комбинезон битраннера",
		GENITIVE = "комбинезона битраннера",
		DATIVE = "комбинезону битраннера",
		ACCUSATIVE = "комбинезон битраннера",
		INSTRUMENTAL = "комбинезоном битраннера",
		PREPOSITIONAL = "комбинезоне битраннера",
	)
