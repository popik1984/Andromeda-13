/**
 * The wirebrush is a tool whose sole purpose is to remove rust from anything that is rusty.
 * Because of the inherent nature of hard countering rust heretics it does it very slowly.
 */
/obj/item/wirebrush
	name = "wirebrush"
	desc = "Инструмент для тщательной очистки стен от ржавчины. Не для волос!"
	icon = 'icons/obj/tools.dmi'
	icon_state = "wirebrush"
	tool_behaviour = TOOL_RUSTSCRAPER
	toolspeed = 1

/obj/item/wirebrush/get_ru_names()
	return list(
		NOMINATIVE = "металлическая щётка",
		GENITIVE = "металлической щётки",
		DATIVE = "металлической щётке",
		ACCUSATIVE = "металлическую щётку",
		INSTRUMENTAL = "металлической щёткой",
		PREPOSITIONAL = "металлической щётке",
	)
