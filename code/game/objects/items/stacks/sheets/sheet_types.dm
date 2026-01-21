/* Diffrent misc types of sheets
 * Contains:
 * Iron
 * Plasteel
 * Wood
 * Cloth
 * Plastic
 * Cardboard
 * Paper Frames
 * Runed Metal (cult)
 * Bronze (bake brass)
 */

/*
 * MARK: Железо
 */
GLOBAL_LIST_INIT(metal_recipes, list ( \
	new/datum/stack_recipe("табурет", /obj/structure/chair/stool, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("барный стул", /obj/structure/chair/stool/bar, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("кровать", /obj/structure/bed, 2, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("двуспальная кровать", /obj/structure/bed/double, 4, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	null, \
	new/datum/stack_recipe_list("Офисные стулья", list( \
		new/datum/stack_recipe("тёмный офисный стул", /obj/structure/chair/office, 5, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new/datum/stack_recipe("светлый офисный стул", /obj/structure/chair/office/light, 5, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		)), \
	new/datum/stack_recipe_list("Удобные кресла", list( \
		new/datum/stack_recipe("бежевое удобное кресло", /obj/structure/chair/comfy/beige, 2, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new/datum/stack_recipe("чёрное удобное кресло", /obj/structure/chair/comfy/black, 2, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new/datum/stack_recipe("коричневое удобное кресло", /obj/structure/chair/comfy/brown, 2, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new/datum/stack_recipe("лаймовое удобное кресло", /obj/structure/chair/comfy/lime, 2, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new/datum/stack_recipe("бирюзовое удобное кресло", /obj/structure/chair/comfy/teal, 2, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		)), \
	new/datum/stack_recipe_list("Диваны", list(
		new /datum/stack_recipe("диван (середина)", /obj/structure/chair/sofa/middle, 1, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE),
		new /datum/stack_recipe("диван (левый)", /obj/structure/chair/sofa/left, 1, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE),
		new /datum/stack_recipe("диван (правый)", /obj/structure/chair/sofa/right, 1, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE),
		new /datum/stack_recipe("диван (угловой)", /obj/structure/chair/sofa/corner, 1, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE)
		)), \
	new/datum/stack_recipe_list("Корпоративные диваны", list( \
		new /datum/stack_recipe("диван (середина)", /obj/structure/chair/sofa/corp, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("диван (левый)", /obj/structure/chair/sofa/corp/left, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("диван (правый)", /obj/structure/chair/sofa/corp/right, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("диван (угловой)", /obj/structure/chair/sofa/corp/corner, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		)), \
	new /datum/stack_recipe_list("Скамейки", list( \
		new /datum/stack_recipe("скамейка (середина)", /obj/structure/chair/sofa/bench, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("скамейка (левая)", /obj/structure/chair/sofa/bench/left, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("скамейка (правая)", /obj/structure/chair/sofa/bench/right, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("скамейка (угловая)", /obj/structure/chair/sofa/bench/corner, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("трамвайная скамейка (одиночная)", /obj/structure/chair/sofa/bench/tram/solo, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("трамвайная скамейка (середина)", /obj/structure/chair/sofa/bench/tram, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("трамвайная скамейка (левая)", /obj/structure/chair/sofa/bench/tram/left, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("трамвайная скамейка (правая)", /obj/structure/chair/sofa/bench/tram/right, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("трамвайная скамейка (угловая)", /obj/structure/chair/sofa/bench/tram/corner, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		)), \
	new /datum/stack_recipe_list("Шахматные фигуры", list( \
		new /datum/stack_recipe("белая пешка", /obj/structure/chess/whitepawn, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("белая ладья", /obj/structure/chess/whiterook, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("белый конь", /obj/structure/chess/whiteknight, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("белый слон", /obj/structure/chess/whitebishop, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("белый ферзь", /obj/structure/chess/whitequeen, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("белый король", /obj/structure/chess/whiteking, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("чёрная пешка", /obj/structure/chess/blackpawn, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("чёрная ладья", /obj/structure/chess/blackrook, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("чёрный конь", /obj/structure/chess/blackknight, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("чёрный слон", /obj/structure/chess/blackbishop, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("чёрный ферзь", /obj/structure/chess/blackqueen, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("чёрный король", /obj/structure/chess/blackking, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
	)),
	new /datum/stack_recipe_list("Шашки", list( \
		new /datum/stack_recipe("белая шашка", /obj/structure/chess/checker/whiteman, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("белый король-шашка", /obj/structure/chess/checker/whiteking, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("чёрная шашка", /obj/structure/chess/checker/blackman, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("чёрный король-шашка", /obj/structure/chess/checker/blackking, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
	)),
	null, \
	new/datum/stack_recipe("детали стеллажа", /obj/item/rack_parts, category = CAT_FURNITURE), \
	new/datum/stack_recipe("шкаф", /obj/structure/closet, 2, time = 1.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	null, \
	new/datum/stack_recipe("канистра", /obj/machinery/portable_atmospherics/canister, 10, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ATMOSPHERIC), \
	new/datum/stack_recipe("труба", /obj/item/pipe/quaternary/pipe/crafted, 1, time = 4 SECONDS, crafting_flags = NONE, category = CAT_ATMOSPHERIC), \
	null, \
	new/datum/stack_recipe("железная плитка", /obj/item/stack/tile/iron/base, 1, 4, 20, category = CAT_TILES), \
	new/datum/stack_recipe("железный прут", /obj/item/stack/rods, 1, 2, 60, category = CAT_MISC), \
	null, \
	new/datum/stack_recipe("каркас стены (закреплённый)", /obj/structure/girder, 2, time = 4 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, placement_checks = STACK_CHECK_TRAM_FORBIDDEN, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
	new /datum/stack_recipe_list("Платформы (закреплённые)", list( \
		new /datum/stack_recipe("закруглённая железная платформа", /obj/structure/platform, 2, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
		new /datum/stack_recipe("железная платформа", /obj/structure/platform/iron, 2, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
		new /datum/stack_recipe("ступеньки платформы", /obj/structure/steps, 2, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
	)),
	null, \
	new/datum/stack_recipe("каркас компьютера", /obj/structure/frame/computer, 5, time = 2.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("модульная консоль", /obj/machinery/modular_computer, 10, time = 2.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("каркас машины", /obj/structure/frame/machine, 5, time = 2.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	null, \
	new /datum/stack_recipe_list("Шлюзы", list( \
		new /datum/stack_recipe("стандартная каркас шлюза", /obj/structure/door_assembly, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
		new /datum/stack_recipe("каркас общественного шлюза", /obj/structure/door_assembly/door_assembly_public, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
		new /datum/stack_recipe("каркас командного шлюза", /obj/structure/door_assembly/door_assembly_com, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
		new /datum/stack_recipe("каркас шлюза безопасности", /obj/structure/door_assembly/door_assembly_sec, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
		new /datum/stack_recipe("каркас инженерного шлюза", /obj/structure/door_assembly/door_assembly_eng, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
		new /datum/stack_recipe("каркас шахтёрского шлюза", /obj/structure/door_assembly/door_assembly_min, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
		new /datum/stack_recipe("каркас атмосферного шлюза", /obj/structure/door_assembly/door_assembly_atmo, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
		new /datum/stack_recipe("каркас исследовательского шлюза", /obj/structure/door_assembly/door_assembly_research, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
		new /datum/stack_recipe("каркас морозильного шлюза", /obj/structure/door_assembly/door_assembly_fre, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
		new /datum/stack_recipe("каркас научного шлюза", /obj/structure/door_assembly/door_assembly_science, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
		new /datum/stack_recipe("каркас медицинского шлюза", /obj/structure/door_assembly/door_assembly_med, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
		new /datum/stack_recipe("каркас гидропонного шлюза", /obj/structure/door_assembly/door_assembly_hydro, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
		new /datum/stack_recipe("каркас вирусологического шлюза", /obj/structure/door_assembly/door_assembly_viro, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
		new /datum/stack_recipe("каркас шлюза техтоннелей", /obj/structure/door_assembly/door_assembly_mai, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
		new /datum/stack_recipe("каркас внешнего шлюза", /obj/structure/door_assembly/door_assembly_ext, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
		new /datum/stack_recipe("каркас внешнего шлюза техтоннелей", /obj/structure/door_assembly/door_assembly_extmai, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
		new /datum/stack_recipe("каркас герметичного люка", /obj/structure/door_assembly/door_assembly_hatch, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
		new /datum/stack_recipe("каркас люка техтоннелей", /obj/structure/door_assembly/door_assembly_mhatch, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
	)), \
	null, \
	new/datum/stack_recipe("каркас противопожарного шлюза", /obj/structure/firelock_frame, 3, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
	new/datum/stack_recipe("направленный каркас противопожарного шлюза", /obj/structure/firelock_frame/border_only, 2, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ON_SOLID_GROUND | CRAFT_CHECK_DIRECTION, category = CAT_DOORS), \
	new/datum/stack_recipe("каркас турели", /obj/machinery/porta_turret_construct, 5, time = 2.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("каркас мясного шипа", /obj/structure/kitchenspike_frame, 5, time = 2.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("каркас рефлектора", /obj/structure/reflector, 5, time = 2.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	null, \
	new/datum/stack_recipe("корпус гранаты", /obj/item/grenade/chem_grenade, crafting_flags = NONE, category = CAT_CHEMISTRY), \
	new/datum/stack_recipe("каркас светильника", /obj/item/wallframe/light_fixture, 2, crafting_flags = NONE, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("каркас маленького светильника", /obj/item/wallframe/light_fixture/small, 1, crafting_flags = NONE, category = CAT_STRUCTURE), \
	null, \
	new/datum/stack_recipe("каркас ЛКП", /obj/item/wallframe/apc, 2, crafting_flags = NONE, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("каркас воздушной тревоги", /obj/item/wallframe/airalarm, 2, crafting_flags = NONE, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("каркас пожарной тревоги", /obj/item/wallframe/firealarm, 2, crafting_flags = NONE, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("каркас шкафа с огнетушителем", /obj/item/wallframe/extinguisher_cabinet, 2, crafting_flags = NONE, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("каркас кнопки", /obj/item/wallframe/button, 1, crafting_flags = NONE, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("каркас выключателя света", /obj/item/wallframe/light_switch, 1, crafting_flags = NONE, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("каркас искровителя", /obj/item/wallframe/sparker, 1, crafting_flags = NONE, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("каркас управления турелями", /obj/item/wallframe/turret_control, 6, crafting_flags = NONE, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("каркас камеры", /obj/item/wallframe/camera, 1, crafting_flags = NONE, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("каркас новостника", /obj/item/wallframe/newscaster, 7, crafting_flags = NONE, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("каркас дисплея статуса", /obj/item/wallframe/status_display, 7, crafting_flags = NONE, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("каркас интеркома", /obj/item/wallframe/intercom, 2, crafting_flags = NONE, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("каркас консоли запросов", /obj/item/wallframe/requests_console, 7, crafting_flags = NONE, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("каркас телеэкрана турбины", /obj/item/wallframe/telescreen/turbine, 7, crafting_flags = NONE, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("каркас телеэкрана двигателя", /obj/item/wallframe/telescreen/engine, 7, crafting_flags = NONE, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("каркас телеэкрана вспомогательной базы", /obj/item/wallframe/telescreen/auxbase, 7, crafting_flags = NONE, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("каркас контроллера трамвая", /obj/item/wallframe/tram, 20, crafting_flags = NONE, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("каркас дисплея трамвая", /obj/item/wallframe/indicator_display, 7, crafting_flags = NONE, category = CAT_STRUCTURE), \
	null, \
	new/datum/stack_recipe("железная дверь", /obj/structure/mineral_door/iron, 20, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
	new/datum/stack_recipe("картотечный шкаф", /obj/structure/filingcabinet, 2, time = 10 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("настольный звонок", /obj/structure/desk_bell, 2, time = 3 SECONDS, crafting_flags = NONE, category = CAT_FURNITURE), \
	new/datum/stack_recipe("каркас прожектора", /obj/structure/floodlight_frame, 5, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("урна для голосования", /obj/structure/votebox, 15, time = 5 SECONDS, crafting_flags = NONE, category = CAT_ENTERTAINMENT), \
	new/datum/stack_recipe("пестик", /obj/item/pestle, 1, time = 5 SECONDS, crafting_flags = NONE, category = CAT_CHEMISTRY), \
	new/datum/stack_recipe("каркас гигиенбота", /obj/item/bot_assembly/hygienebot, 2, time = 5 SECONDS, crafting_flags = NONE, category = CAT_ROBOT), \
	new/datum/stack_recipe("каркас душа", /obj/structure/showerframe, 2, time = 2 SECONDS, crafting_flags = NONE, category = CAT_FURNITURE), \
	new/datum/stack_recipe("писсуар", /obj/item/wallframe/urinal, 2, time = 1 SECONDS, crafting_flags = NONE, category = CAT_FURNITURE)
))

/obj/item/stack/sheet/iron
	name = "iron"
	desc = "Листы, сделанные из железа."
	singular_name = "iron sheet"
	icon_state = "sheet-metal"
	inhand_icon_state = "sheet-metal"
	mats_per_unit = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT)
	throwforce = 10
	obj_flags = CONDUCTS_ELECTRICITY
	resistance_flags = FIRE_PROOF
	merge_type = /obj/item/stack/sheet/iron
	grind_results = list(/datum/reagent/iron = 20)
	gulag_valid = TRUE
	table_type = /obj/structure/table
	material_type = /datum/material/iron
	matter_amount = 4
	cost = SHEET_MATERIAL_AMOUNT
	source = /datum/robot_energy_storage/material/iron
	stairs_type = /obj/structure/stairs
	sniffable = TRUE

/obj/item/stack/sheet/iron/get_ru_names()
	return alist(
		NOMINATIVE = "железо",
		GENITIVE = "железа",
		DATIVE = "железу",
		ACCUSATIVE = "железо",
		INSTRUMENTAL = "железом",
		PREPOSITIONAL = "железе"
	)

/obj/item/stack/sheet/iron/Initialize(mapload)
	. = ..()
	var/static/list/tool_behaviors = list(
		TOOL_WELDER = list(
			SCREENTIP_CONTEXT_LMB = "Создать арматурины",
			SCREENTIP_CONTEXT_RMB = "Создать напольные плитки",
		),
	)
	AddElement(/datum/element/contextual_screentip_tools, tool_behaviors)

/obj/item/stack/sheet/iron/examine(mob/user)
	. = ..()
	. += span_notice("ПКМ по полу для строительства:")
	. += span_notice("- Каркаса стены (не закреплённый)")
	. += span_notice("- Каркаса компьютера или машины (с платой в неактивной руке)")

/obj/item/stack/sheet/iron/fifty
	amount = 50

/obj/item/stack/sheet/iron/twenty
	amount = 20

/obj/item/stack/sheet/iron/ten
	amount = 10

/obj/item/stack/sheet/iron/five
	amount = 5

/obj/item/stack/sheet/iron/get_main_recipes()
	. = ..()
	. += GLOB.metal_recipes

/obj/item/stack/sheet/iron/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("[RU_USER_NOM] начинает бить себя по голове [RU_SRC_INS]! Похоже, [GEND_HE_SHE(user)] пытается покончить с собой!"))
	return BRUTELOSS

/obj/item/stack/sheet/iron/welder_act(mob/living/user, obj/item/tool)
	if(tool.use_tool(src, user, delay = 0, volume = 40))
		var/obj/item/stack/rods/two/new_item = new(user.loc)
		user.visible_message(
			span_notice("[RU_USER_NOM] придал [RU_SRC_DAT] форму напольных арматурин с помощью [RU_GEN(tool)]."),
			blind_message = span_hear("Вы слышите сварку."),
			vision_distance = COMBAT_MESSAGE_RANGE,
			ignored_mobs = user
		)
		use(1)
		user.put_in_inactive_hand(new_item)
		return ITEM_INTERACT_SUCCESS

/obj/item/stack/sheet/iron/welder_act_secondary(mob/living/user, obj/item/tool)
	if(tool.use_tool(src, user, delay = 0, volume = 40))
		var/obj/item/stack/tile/iron/four/new_item = new(user.loc)
		user.visible_message(
			span_notice("[RU_USER_NOM] придал [RU_SRC_DAT] форму напольных плиток с помощью [RU_GEN(tool)]."),
			blind_message = span_hear("Вы слышите сварку."),
			vision_distance = COMBAT_MESSAGE_RANGE,
			ignored_mobs = user
		)
		use(1)
		user.put_in_inactive_hand(new_item)
		return ITEM_INTERACT_SUCCESS

/obj/item/stack/sheet/iron/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isopenturf(interacting_with))
		return NONE
	var/turf/open/build_on = interacting_with
	if(!user.Adjacent(build_on))
		return ITEM_INTERACT_BLOCKING
	if(isgroundlessturf(build_on))
		user.balloon_alert(user, "нельзя разместить здесь!")
		return ITEM_INTERACT_BLOCKING
	if(build_on.is_blocked_turf())
		user.balloon_alert(user, "что-то блокирует плитку!")
		return ITEM_INTERACT_BLOCKING

	var/frame_path = null
	var/cost = 2 // Default girder cost
	var/time = 4 SECONDS //Default girder build time
	var/obj/item/circuitboard/held_board = locate() in user.held_items
	if(!isnull(held_board))
		if(istype(held_board, /obj/item/circuitboard/machine))
			frame_path = /obj/structure/frame/machine
		else
			frame_path = /obj/structure/frame/computer
		for(var/datum/stack_recipe/recipe in GLOB.metal_recipes)
			if(recipe.result_type == frame_path)
				time = recipe.time
				cost = recipe.req_amount
				break
	if(get_amount() < cost)
		user.balloon_alert(user, "нужно [cost] листов железа!")
		return ITEM_INTERACT_BLOCKING
	if(!do_after(user, time, build_on))
		return ITEM_INTERACT_BLOCKING
	if(build_on.is_blocked_turf())
		user.balloon_alert(user, "что-то блокирует плитку!")
		return ITEM_INTERACT_BLOCKING
	if(!use(cost))
		user.balloon_alert(user, "недостаточно материала!")
		return ITEM_INTERACT_BLOCKING
	if(frame_path)
		var/obj/structure/frame/constructed_frame = new frame_path(build_on)
		constructed_frame.setDir(REVERSE_DIR(user.dir)) // Для выравнивания каркаса компьютера по направлению игрока
		user.balloon_alert(user, "каркас создан")
	else
		new/obj/structure/girder/displaced(build_on)
		user.balloon_alert(user, "каркас стены создана")
	return ITEM_INTERACT_SUCCESS

/*
 * MARK: Пласталь
 */
GLOBAL_LIST_INIT(plasteel_recipes, list ( \
	new/datum/stack_recipe("ядро ИИ", /obj/structure/ai_core, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF, category = CAT_ROBOT),
	new/datum/stack_recipe("каркас бомбы", /obj/machinery/syndicatebomb/empty, 10, time = 5 SECONDS, crafting_flags = NONE, category = CAT_CHEMISTRY),
	new/datum/stack_recipe("большая газовая цистерна", /obj/structure/tank_frame, 4, time=1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF, category = CAT_ATMOSPHERIC),
	new/datum/stack_recipe("каркас ставней", /obj/machinery/door/poddoor/shutters/preopen/deconstructed, 5, time = 5 SECONDS, crafting_flags = CRAFT_ONE_PER_TURF, category = CAT_DOORS),
	null,
	new /datum/stack_recipe_list("Шлюзы", list( \
		new/datum/stack_recipe("каркас шлюза высокой безопасности", /obj/structure/door_assembly/door_assembly_highsecurity, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS),
		new/datum/stack_recipe("каркас шлюза хранилища", /obj/structure/door_assembly/door_assembly_vault, 6, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS),
	)), \
))

/obj/item/stack/sheet/plasteel
	name = "plasteel"
	singular_name = "plasteel sheet"
	desc = "Этот лист является сплавом железа и плазмы."
	icon_state = "sheet-plasteel"
	inhand_icon_state = "sheet-plasteel"
	mats_per_unit = list(/datum/material/alloy/plasteel=SHEET_MATERIAL_AMOUNT)
	material_type = /datum/material/alloy/plasteel
	throwforce = 10
	obj_flags = CONDUCTS_ELECTRICITY
	armor_type = /datum/armor/sheet_plasteel
	resistance_flags = FIRE_PROOF
	merge_type = /obj/item/stack/sheet/plasteel
	grind_results = list(/datum/reagent/iron = 20, /datum/reagent/toxin/plasma = 20)
	gulag_valid = TRUE
	table_type = /obj/structure/table/reinforced
	material_flags = NONE
	matter_amount = 12

/obj/item/stack/sheet/plasteel/get_ru_names()
	return alist(
		NOMINATIVE = "пласталь",
		GENITIVE = "пластали",
		DATIVE = "пластали",
		ACCUSATIVE = "пласталь",
		INSTRUMENTAL = "пласталью",
		PREPOSITIONAL = "пластали"
	)

/datum/armor/sheet_plasteel
	fire = 100
	acid = 80

/obj/item/stack/sheet/plasteel/get_main_recipes()
	. = ..()
	. += GLOB.plasteel_recipes

/obj/item/stack/sheet/plasteel/twenty
	amount = 20

/obj/item/stack/sheet/plasteel/fifty
	amount = 50

/*
 * MARK: Дерево
 */
GLOBAL_LIST_INIT(wood_recipes, list ( \
	new/datum/stack_recipe("сандалии", /obj/item/clothing/shoes/sandal, 1, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("деревянная плитка", /obj/item/stack/tile/wood, 1, 4, 20, crafting_flags = NONE, category = CAT_TILES), \
	new/datum/stack_recipe("каркас стола", /obj/structure/table_frame/wood, 2, time = 1 SECONDS, crafting_flags = NONE, category = CAT_FURNITURE), \
	new /datum/stack_recipe_list("Платформы (закреплённые)", list( \
		new /datum/stack_recipe("деревянная платформа", /obj/structure/platform/wood, 2, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
		new /datum/stack_recipe("деревянная сцена", /obj/structure/platform/wood/stage, 2, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
	)),
	new/datum/stack_recipe("скалка", /obj/item/kitchen/rollingpin, 2, time = 3 SECONDS, crafting_flags = NONE, category = CAT_TOOLS), \
	new/datum/stack_recipe("деревянный стул", /obj/structure/chair/wood/, 3, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("деревянный стул с крыльями", /obj/structure/chair/wood/wings, 3, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("баррикада", /obj/structure/barricade/wooden, 5, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("деревянная дверь", /obj/structure/mineral_door/wood, 10, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
	new/datum/stack_recipe("каркас лестницы", /obj/structure/stairs_frame/wood, 10, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("забор", /obj/structure/railing/wooden_fence, 2, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("корыто для раптора", /obj/structure/ore_container/food_trough/raptor_trough, 5, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("кошачий домик", /obj/structure/cat_house, 5, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("гроб", /obj/structure/closet/crate/coffin, 5, time = 1.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("книжный шкаф", /obj/structure/bookcase, 4, time = 1.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("сушилка", /obj/machinery/smartfridge/drying/rack, 10, time = 1.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_TOOLS), \
	new/datum/stack_recipe("бочка", /obj/structure/fermenting_barrel, 8, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("собачья лежанка", /obj/structure/bed/dogbed, 10, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("комод", /obj/structure/dresser, 10, time = 1.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("фоторамка", /obj/item/wallframe/picture, 1, time = 1 SECONDS, crafting_flags = NONE, category = CAT_ENTERTAINMENT),\
	new/datum/stack_recipe("рамка для картины", /obj/item/wallframe/painting, 1, time = 1 SECONDS, crafting_flags = NONE, category = CAT_ENTERTAINMENT),\
	new/datum/stack_recipe("каркас витрины", /obj/structure/displaycase_chassis, 5, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("баклер", /obj/item/shield/buckler, 20, time = 4 SECONDS, crafting_flags = NONE, category = CAT_EQUIPMENT), \
	new/datum/stack_recipe("пасека", /obj/structure/beebox, 40, time = 5 SECONDS, crafting_flags = NONE, category = CAT_TOOLS),\
	new/datum/stack_recipe("манекен", /obj/structure/mannequin/wood, 25, time = 5 SECONDS, crafting_flags = CRAFT_ONE_PER_TURF, category = CAT_ENTERTAINMENT), \
	new/datum/stack_recipe("маска тики", /obj/item/clothing/mask/gas/tiki_mask, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("курительная трубка", /obj/item/cigarette/pipe, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("рамка для мёда", /obj/item/honey_frame, 5, time = 1 SECONDS, crafting_flags = NONE, category = CAT_TOOLS),\
	new/datum/stack_recipe("ведро", /obj/item/reagent_containers/cup/bucket/wooden, 3, time = 1 SECONDS, crafting_flags = NONE, category = CAT_CONTAINERS),\
	new/datum/stack_recipe("грабли", /obj/item/cultivator/rake, 5, time = 1 SECONDS, crafting_flags = NONE, category = CAT_TOOLS),\
	new/datum/stack_recipe("ящик для руды", /obj/structure/ore_box, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_CONTAINERS),\
	new/datum/stack_recipe("ящик", /obj/structure/closet/crate/wooden, 6, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE),\
	new/datum/stack_recipe("бейсбольная бита", /obj/item/melee/baseball_bat, 5, time = 1.5 SECONDS, crafting_flags = NONE, category = CAT_WEAPON_MELEE, removed_mats = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 1.5)),\
	new/datum/stack_recipe("костыль", /obj/item/cane/crutch/wood, 5, time = 1.5 SECONDS, crafting_flags = NONE, category = CAT_WEAPON_MELEE),\
	new/datum/stack_recipe("ткацкий станок", /obj/structure/loom, 10, time = 1.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_TOOLS), \
	new/datum/stack_recipe("ступка", /obj/item/reagent_containers/cup/mortar, 3, crafting_flags = NONE, category = CAT_CHEMISTRY), \
	new/datum/stack_recipe("горящая щепка", /obj/item/match/firebrand, 2, time = 10 SECONDS, crafting_flags = NONE, category = CAT_TOOLS), \
	new/datum/stack_recipe("костёр", /obj/structure/bonfire, 10, time = 6 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_TOOLS), \
	new/datum/stack_recipe("мольберт", /obj/structure/easel, 5, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
	new/datum/stack_recipe("доска объявлений", /obj/item/wallframe/noticeboard, 1, time = 1 SECONDS, crafting_flags = NONE, category = CAT_FURNITURE), \
	new/datum/stack_recipe("рыбный трофей", /obj/item/wallframe/fish, 2, time = 3 SECONDS, crafting_flags = NONE, category = CAT_FURNITURE),\
	new/datum/stack_recipe("стойка для пробирок", /obj/item/storage/test_tube_rack, 1, time = 1 SECONDS, crafting_flags = NONE, category = CAT_CHEMISTRY), \
	null, \
	new/datum/stack_recipe_list("Скамьи", list(
		new /datum/stack_recipe("скамья (середина)", /obj/structure/chair/pew, 3, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE),
		new /datum/stack_recipe("скамья (левая)", /obj/structure/chair/pew/left, 3, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE),
		new /datum/stack_recipe("скамья (правая)", /obj/structure/chair/pew/right, 3, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE)
		)),
	new/datum/stack_recipe_list("Деревянные протезы", list(
		new /datum/stack_recipe("левая деревянная рука (левая)", /obj/item/bodypart/arm/left/ghetto, 2, crafting_flags = NONE, category = CAT_MISC),
		new /datum/stack_recipe("деревянная рука (правая)", /obj/item/bodypart/arm/right/ghetto, 2, crafting_flags = NONE, category = CAT_MISC),
		new /datum/stack_recipe("деревянная нога (левая)", /obj/item/bodypart/leg/left/ghetto, 2, crafting_flags = NONE, category = CAT_MISC),
		new /datum/stack_recipe("деревянная нога (правая)", /obj/item/bodypart/leg/right/ghetto, 2, crafting_flags = NONE, category = CAT_MISC)
	)),
	null, \
	))

/obj/item/stack/sheet/mineral/wood
	name = "wooden plank"
	desc = "Можно лишь догадываться, что это куча дерева."
	singular_name = "wood plank"
	icon_state = "sheet-wood"
	inhand_icon_state = "sheet-wood"
	icon = 'icons/obj/stack_objects.dmi'
	mats_per_unit = list(/datum/material/wood=SHEET_MATERIAL_AMOUNT)
	construction_path_type = "wood"
	armor_type = /datum/armor/mineral_wood
	resistance_flags = FLAMMABLE
	merge_type = /obj/item/stack/sheet/mineral/wood
	material_type = /datum/material/wood
	grind_results = list(/datum/reagent/cellulose = 20) //no lignocellulose or lignin reagents yet,
	walltype = /turf/closed/wall/mineral/wood
	stairs_type = /obj/structure/stairs/wood
	pickup_sound = 'sound/items/handling/materials/wood_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/wood_drop.ogg'

/obj/item/stack/sheet/mineral/wood/get_ru_names()
	return alist(
		NOMINATIVE = "деревянная доска",
		GENITIVE = "деревянной доски",
		DATIVE = "деревянной доске",
		ACCUSATIVE = "деревянную доску",
		INSTRUMENTAL = "деревянной доской",
		PREPOSITIONAL = "деревянной доске"
	)

/datum/armor/mineral_wood
	fire = 50

/obj/item/stack/sheet/mineral/wood/get_main_recipes()
	. = ..()
	. += GLOB.wood_recipes

/obj/item/stack/sheet/mineral/wood/fifty
	amount = 50

/**
 * - TODO: Rewokin: Я не очень понял, починка чего? Если это деревянный протез, то НУЖНО переформулировать visible_message.
 */

/obj/item/stack/sheet/mineral/wood/interact_with_atom(mob/living/carbon/human/target, mob/user)
	if(!istype(target))
		return NONE

	var/obj/item/bodypart/affecting = target.get_bodypart(check_zone(user.zone_selected))
	if(affecting && IS_PEG_LIMB(affecting))
		if(user == target)
			user.visible_message(span_notice("[user] начинает чинить свою [affecting.name]."), span_notice("Вы начинаете чинить [target == user ? "[GEND_YOUR(user)]" : "[target] [affecting.name]"]."))
			if(!do_after(user, 5 SECONDS, target))
				return ITEM_INTERACT_FAILURE
		if(target.item_heal(user, brute_heal = 15, burn_heal = 15, heal_message_brute = "раненую", heal_message_burn = "обожжённую", required_bodytype = BODYTYPE_PEG))
			use(1)
		return ITEM_INTERACT_SUCCESS
	else
		return NONE

/*
 * MARK: Бамбук
 */
GLOBAL_LIST_INIT(bamboo_recipes, list ( \
	new/datum/stack_recipe("ловушка из заострённых кольев", /obj/structure/punji_sticks, 5, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_EQUIPMENT), \
	new/datum/stack_recipe("бамбуковое копьё", /obj/item/spear/bamboospear, 25, time = 9 SECONDS, crafting_flags = NONE, category = CAT_WEAPON_MELEE), \
	new/datum/stack_recipe("духовая трубка", /obj/item/gun/syringe/blowgun, 10, time = 7 SECONDS, crafting_flags = NONE, category = CAT_WEAPON_RANGED), \
	new/datum/stack_recipe("грубый шприц", /obj/item/reagent_containers/syringe/crude, 5, time = 1 SECONDS, crafting_flags = NONE, category = CAT_CHEMISTRY), \
	new/datum/stack_recipe("коническая шляпа", /obj/item/clothing/head/costume/rice_hat, 10, time = 7 SECONDS, crafting_flags = CRAFT_SKIP_MATERIALS_PARITY, category = CAT_CLOTHING), \
	null, \
	new/datum/stack_recipe("бамбуковый табурет", /obj/structure/chair/stool/bamboo, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("бамбуковый мат", /obj/item/stack/tile/bamboo, 1, 4, 20, crafting_flags = NONE, category = CAT_TILES), \
	null, \
	new /datum/stack_recipe("бамбуковая платформа", /obj/structure/platform/bamboo, 2, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
	new/datum/stack_recipe_list("Скамейки", list(
		new /datum/stack_recipe("бамбуковая скамейка (середина)", /obj/structure/chair/sofa/bamboo, 3, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE),
		new /datum/stack_recipe("бамбуковая скамейка (левая)", /obj/structure/chair/sofa/bamboo/left, 3, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE),
		new /datum/stack_recipe("бамбуковая скамейка (правая)", /obj/structure/chair/sofa/bamboo/right, 3, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE)
		)),	\
	))

/obj/item/stack/sheet/mineral/bamboo
	name = "bamboo cuttings"
	desc = "Аккуратно нарезанные бамбуковые палочки."
	singular_name = "cut bamboo stick"
	icon_state = "sheet-bamboo"
	inhand_icon_state = "sheet-bamboo"
	icon = 'icons/obj/stack_objects.dmi'
	construction_path_type = "bamboo"
	mats_per_unit = list(/datum/material/bamboo = SHEET_MATERIAL_AMOUNT)
	throwforce = 15
	armor_type = /datum/armor/mineral_bamboo
	resistance_flags = FLAMMABLE
	merge_type = /obj/item/stack/sheet/mineral/bamboo
	grind_results = list(/datum/reagent/cellulose = 10)
	material_type = /datum/material/bamboo
	walltype = /turf/closed/wall/mineral/bamboo
	drop_sound = null
	pickup_sound = null

/obj/item/stack/sheet/mineral/bamboo/get_ru_names()
	return alist(
		NOMINATIVE = "нарезка бамбука",
		GENITIVE = "нарезки бамбука",
		DATIVE = "нарезке бамбука",
		ACCUSATIVE = "нарезку бамбука",
		INSTRUMENTAL = "нарезкой бамбука",
		PREPOSITIONAL = "нарезке бамбука"
	)

/datum/armor/mineral_bamboo
	fire = 50

/obj/item/stack/sheet/mineral/bamboo/get_main_recipes()
	. = ..()
	. += GLOB.bamboo_recipes

/obj/item/stack/sheet/mineral/bamboo/fifty
	amount = 50

/*
 * MARK: Ткань
 */
GLOBAL_LIST_INIT(cloth_recipes, list ( \
	new/datum/stack_recipe("белая юбка-комбинезон", /obj/item/clothing/under/color/jumpskirt/white, 3, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("белый комбинезон", /obj/item/clothing/under/color/white, 3, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("белые туфли", /obj/item/clothing/shoes/sneakers/white, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("белый шарф", /obj/item/clothing/neck/scarf, 1, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("белая бандана", /obj/item/clothing/mask/bandana/white, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
	null, \
	new/datum/stack_recipe("рюкзак", /obj/item/storage/backpack, 4, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("сумка", /obj/item/storage/backpack/satchel, 4, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("почтальонская сумка", /obj/item/storage/backpack/messenger, 4, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("вещмешок", /obj/item/storage/backpack/duffelbag, 6, crafting_flags = NONE, category = CAT_CONTAINERS), \
	null, \
	new/datum/stack_recipe("ботаническая сумка", /obj/item/storage/bag/plants, 4, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("книжная сумка", /obj/item/storage/bag/books, 4, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("шахтёрская сумка", /obj/item/storage/bag/ore, 4, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("химическая сумка", /obj/item/storage/bag/chemistry, 4, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("биологическая сумка", /obj/item/storage/bag/bio, 4, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("научная сумка", /obj/item/storage/bag/xeno, 4, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("строительная сумка", /obj/item/storage/bag/construction, 4, crafting_flags = NONE, category = CAT_CONTAINERS), \
	null, \
	new/datum/stack_recipe("импровизированный бинт", /obj/item/stack/medical/gauze/improvised, 1, 2, 6, crafting_flags = NONE, category = CAT_TOOLS), \
	new/datum/stack_recipe("тряпка", /obj/item/rag, 1, crafting_flags = NONE, category = CAT_CHEMISTRY), \
	new/datum/stack_recipe("одеяло", /obj/item/bedsheet, 3, crafting_flags = NONE, category = CAT_FURNITURE), \
	new/datum/stack_recipe("двойное одеяло", /obj/item/bedsheet/double, 6, crafting_flags = NONE, category = CAT_FURNITURE), \
	new/datum/stack_recipe("пустой мешок", /obj/item/emptysandbag, 4, crafting_flags = NONE, category = CAT_CONTAINERS), \
	null, \
	new/datum/stack_recipe("беспалые перчатки", /obj/item/clothing/gloves/fingerless, 1, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("белые перчатки", /obj/item/clothing/gloves/color/white, 3, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("белая мягкая кепка", /obj/item/clothing/head/soft/mime, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("белая шапочка", /obj/item/clothing/head/beanie, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
	null, \
	new/datum/stack_recipe("повязка на глаза", /obj/item/clothing/glasses/blindfold, 2, crafting_flags = NONE, category = CAT_ENTERTAINMENT), \
	null, \
	new/datum/stack_recipe("холст 19x19", /obj/item/canvas/nineteen_nineteen, 3, crafting_flags = NONE, category = CAT_ENTERTAINMENT), \
	new/datum/stack_recipe("холст 23x19", /obj/item/canvas/twentythree_nineteen, 4, crafting_flags = NONE, category = CAT_ENTERTAINMENT), \
	new/datum/stack_recipe("холст 23x23", /obj/item/canvas/twentythree_twentythree, 5, crafting_flags = NONE, category = CAT_ENTERTAINMENT), \
	new/datum/stack_recipe("подушка", /obj/item/pillow, 3, category = CAT_FURNITURE), \
	))

/obj/item/stack/sheet/cloth
	name = "cloth"
	desc = "Хлопок? Лён? Джинса? Мешковина? Холст? Не угадать."
	singular_name = "cloth roll"
	icon_state = "sheet-cloth"
	inhand_icon_state = null
	resistance_flags = FLAMMABLE
	force = 0
	throwforce = 0
	merge_type = /obj/item/stack/sheet/cloth
	drop_sound = 'sound/items/handling/cloth/cloth_drop1.ogg'
	pickup_sound = 'sound/items/handling/cloth/cloth_pickup1.ogg'
	grind_results = list(/datum/reagent/cellulose = 20)
	pickup_sound = SFX_CLOTH_PICKUP
	drop_sound = SFX_CLOTH_DROP

/obj/item/stack/sheet/cloth/get_ru_names()
	return alist(
		NOMINATIVE = "ткань",
		GENITIVE = "ткани",
		DATIVE = "ткани",
		ACCUSATIVE = "ткань",
		INSTRUMENTAL = "тканью",
		PREPOSITIONAL = "ткани"
	)

/obj/item/stack/sheet/cloth/get_main_recipes()
	. = ..()
	. += GLOB.cloth_recipes

/obj/item/stack/sheet/cloth/ten
	amount = 10

/obj/item/stack/sheet/cloth/five
	amount = 5

/*
 * MARK: Прочная ткань
 */
GLOBAL_LIST_INIT(durathread_recipes, list ( \
	new/datum/stack_recipe("комбинезон из дюраткани", /obj/item/clothing/under/misc/durathread, 4, time = 4 SECONDS, crafting_flags = NONE, category = CAT_CLOTHING),
	new/datum/stack_recipe("берет из дюраткани", /obj/item/clothing/head/beret/durathread, 2, time = 4 SECONDS, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("шапочка из дюраткани", /obj/item/clothing/head/beanie/durathread, 2, time = 4 SECONDS, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("бандана из дюраткани", /obj/item/clothing/mask/bandana/durathread, 1, time = 2.5 SECONDS, crafting_flags = NONE, category = CAT_CLOTHING), \
	))

/obj/item/stack/sheet/durathread
	name = "durathread"
	desc = "Ткань, сотканная из невероятно прочных нитей, известная своей полезностью в производстве брони."
	singular_name = "durathread roll"
	icon_state = "sheet-durathread"
	inhand_icon_state = null
	resistance_flags = FLAMMABLE
	force = 0
	throwforce = 0
	merge_type = /obj/item/stack/sheet/durathread
	drop_sound = 'sound/items/handling/cloth/cloth_drop1.ogg'
	pickup_sound = 'sound/items/handling/cloth/cloth_pickup1.ogg'

/obj/item/stack/sheet/durathread/get_ru_names()
	return alist(
		NOMINATIVE = "дюраткань",
		GENITIVE = "дюраткани",
		DATIVE = "дюраткани",
		ACCUSATIVE = "дюраткань",
		INSTRUMENTAL = "дюратьканью",
		PREPOSITIONAL = "дюраткани"
	)

/obj/item/stack/sheet/durathread/Initialize(mapload)
	. = ..()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/durathread_helmet, /datum/crafting_recipe/durathread_vest)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/stack/sheet/durathread/get_main_recipes()
	. = ..()
	. += GLOB.durathread_recipes

/obj/item/stack/sheet/durathread/used_in_craft(atom/created, datum/crafting_recipe/recipe)
	. = ..()
	created.set_armor_rating(CONSUME, max(50, created.get_armor_rating(CONSUME)))

/*
 * MARK: Сырьё ткани
 */
/obj/item/stack/sheet/cotton
	name = "raw cotton bundle"
	desc = "Связка сырого хлопка, готового к прядению на ткацком станке."
	singular_name = "raw cotton ball"
	icon_state = "sheet-cotton"
	resistance_flags = FLAMMABLE
	force = 0
	throwforce = 0
	merge_type = /obj/item/stack/sheet/cotton
	grind_results = list(/datum/reagent/cellulose = 20)
	var/loom_result = /obj/item/stack/sheet/cloth
	var/loom_time = 1 SECONDS
	drop_sound = 'sound/items/handling/cloth/cloth_drop1.ogg'
	pickup_sound = 'sound/items/handling/cloth/cloth_pickup1.ogg'

/obj/item/stack/sheet/cotton/get_ru_names()
	return alist(
		NOMINATIVE = "сырой хлопок",
		GENITIVE = "сырого хлопка",
		DATIVE = "сырому хлопку",
		ACCUSATIVE = "сырой хлопок",
		INSTRUMENTAL = "сырым хлопком",
		PREPOSITIONAL = "сыром хлопке"
	)

/obj/item/stack/sheet/cotton/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/loomable, resulting_atom = loom_result, loom_time = loom_time)

/obj/item/stack/sheet/cotton/durathread
	name = "raw durathread bundle"
	desc = "Связка сырой прочной ткани, готовой к прядению на ткацком станке."
	singular_name = "raw durathread ball"
	icon_state = "sheet-durathreadraw"
	merge_type = /obj/item/stack/sheet/cotton/durathread
	loom_result = /obj/item/stack/sheet/durathread

/obj/item/stack/sheet/cotton/durathread/get_ru_names()
	return alist(
		NOMINATIVE = "сырая прочная ткань",
		GENITIVE = "сырой прочной ткани",
		DATIVE = "сырой прочной ткани",
		ACCUSATIVE = "сырую прочную ткань",
		INSTRUMENTAL = "сырой прочной тканью",
		PREPOSITIONAL = "сырой прочной ткани"
	)

/obj/item/stack/sheet/cotton/wool
	name = "raw wool bundle"
	desc = "Связка сырой шерсти, готовой к прядению на ткацком станке."
	singular_name = "raw wool ball"
	icon_state = "sheet-wool"
	merge_type = /obj/item/stack/sheet/cotton/wool
	loom_result = /obj/item/stack/sheet/cloth

/obj/item/stack/sheet/cotton/wool/get_ru_names()
	return alist(
		NOMINATIVE = "сырая шерсть",
		GENITIVE = "сырой шерсти",
		DATIVE = "сырой шерсти",
		ACCUSATIVE = "сырую шерсть",
		INSTRUMENTAL = "сырой шерстью",
		PREPOSITIONAL = "сырой шерсти"
	)

/*
 * MARK: Картон
 */
GLOBAL_LIST_INIT(cardboard_recipes, list ( \
	new/datum/stack_recipe("коробка", /obj/item/storage/box, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("карборг костюм", /obj/item/clothing/suit/costume/cardborg, 3, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("шлем карборга", /obj/item/clothing/head/costume/cardborg, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("большая коробка", /obj/structure/closet/cardboard, 4, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("средняя коробка", /obj/structure/closet/crate/cardboard, 4, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("картонный макет", /obj/item/cardboard_cutout, 5, crafting_flags = NONE, category = CAT_ENTERTAINMENT), \
	null, \

	new/datum/stack_recipe("коробка для пиццы", /obj/item/pizzabox, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("папка", /obj/item/folder, crafting_flags = NONE, category = CAT_CONTAINERS), \
	null, \
	//TO-DO: Find a proper way to just change the illustration on the box. Code isn't the issue, input is.
	new/datum/stack_recipe_list("Специальные коробки", list(
		new /datum/stack_recipe("коробка для пончиков", /obj/item/storage/fancy/donut_box, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка для яиц", /obj/item/storage/fancy/egg_box, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка донк-покетов", /obj/item/storage/box/donkpockets, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка острых донк-покетов", /obj/item/storage/box/donkpockets/donkpocketspicy, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка терияки донк-покетов", /obj/item/storage/box/donkpockets/donkpocketteriyaki, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка пицца донк-покетов", /obj/item/storage/box/donkpockets/donkpocketpizza, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка ягодных донк-покетов", /obj/item/storage/box/donkpockets/donkpocketberry, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка хонк донк-покетов", /obj/item/storage/box/donkpockets/donkpockethonk, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка кубиков обезьян", /obj/item/storage/box/monkeycubes, crafting_flags = NONE, category = CAT_CONTAINERS),
		new /datum/stack_recipe("коробка наггетсов", /obj/item/storage/fancy/nugget_box, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка стаканов", /obj/item/storage/box/drinkingglasses, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка бумажных стаканчиков", /obj/item/storage/box/cups, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("сигарный кейс", /obj/item/storage/fancy/cigarettes/cigars, crafting_flags = NONE, category = CAT_CONTAINERS), \
		null, \

		new /datum/stack_recipe("коробка летальных патронов", /obj/item/storage/box/lethalshot, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка резиновых патронов", /obj/item/storage/box/rubbershot, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка патронов с дробью", /obj/item/storage/box/beanbag, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка светошумовых гранат", /obj/item/storage/box/flashbangs, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка светошумовых гранат", /obj/item/storage/box/flashes, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка наручников", /obj/item/storage/box/handcuffs, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка ID карт", /obj/item/storage/box/ids, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка КПК", /obj/item/storage/box/pdas, crafting_flags = NONE, category = CAT_CONTAINERS), \
		null, \

		new /datum/stack_recipe("коробка баночек для таблеток", /obj/item/storage/box/pillbottles, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка медицинских гелей", /obj/item/storage/box/medigels, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка мензурок", /obj/item/storage/box/beakers, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка шприцев", /obj/item/storage/box/syringes, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка латексных перчаток", /obj/item/storage/box/gloves, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка стерильных масок", /obj/item/storage/box/masks, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка мешков для тел", /obj/item/storage/box/bodybags, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка очков по рецепту", /obj/item/storage/box/rxglasses, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка медипенов", /obj/item/storage/box/medipens, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка ДНК инъекторов", /obj/item/storage/box/injectors, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка кислородных баллонов", /obj/item/storage/box/emergencytank, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка расширенных кислородных баллонов", /obj/item/storage/box/engitank, crafting_flags = NONE, category = CAT_CONTAINERS), \
		null, \

		new /datum/stack_recipe("коробка выживания", /obj/item/storage/box/survival/crafted, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("расширенная коробка выживания", /obj/item/storage/box/survival/engineer/crafted, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка дисков", /obj/item/storage/box/disks, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка ламп-трубок", /obj/item/storage/box/lights/tubes, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка лампочек", /obj/item/storage/box/lights/bulbs, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка смешанных ламп", /obj/item/storage/box/lights/mixed, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка мышеловок", /obj/item/storage/box/mousetraps, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка свечей", /obj/item/storage/fancy/candle_box, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("коробка бинтов", /obj/item/storage/box/bandages, crafting_flags = NONE, category = CAT_CONTAINERS)
		)),

	null, \
))

/obj/item/stack/sheet/cardboard //BubbleWrap //it's cardboard you fuck
	name = "cardboard"
	desc = "Большие листы картона, как сложенные коробки."
	singular_name = "cardboard sheet"
	icon_state = "sheet-card"
	inhand_icon_state = "sheet-card"
	mats_per_unit = list(/datum/material/cardboard = SHEET_MATERIAL_AMOUNT)
	resistance_flags = FLAMMABLE
	force = 0
	throwforce = 0
	merge_type = /obj/item/stack/sheet/cardboard
	grind_results = list(/datum/reagent/cellulose = 10)
	material_type = /datum/material/cardboard
	pickup_sound = 'sound/items/handling/materials/cardboard_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/cardboard_drop.ogg'

/obj/item/stack/sheet/cardboard/get_ru_names()
	return alist(
		NOMINATIVE = "картон",
		GENITIVE = "картона",
		DATIVE = "картону",
		ACCUSATIVE = "картон",
		INSTRUMENTAL = "картоном",
		PREPOSITIONAL = "картоне"
	)

/obj/item/stack/sheet/cardboard/Initialize(mapload, new_amount, merge, list/mat_override, mat_amt)
	. = ..()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/cardboard_id)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/stack/sheet/cardboard/get_main_recipes()
	. = ..()
	. += GLOB.cardboard_recipes

/obj/item/stack/sheet/cardboard/fifty
	amount = 50

/obj/item/stack/sheet/cardboard/attackby(obj/item/I, mob/user, list/modifiers, list/attack_modifiers)
	if(istype(I, /obj/item/stamp/clown) && !istype(loc, /obj/item/storage))
		var/atom/droploc = drop_location()
		if(use(1))
			playsound(I, 'sound/items/bikehorn.ogg', 50, TRUE, -1)
			to_chat(user, span_notice("Вы ставите штамп на картоне! Это клоунская коробка! Хонк!"))
			if (amount >= 0)
				new/obj/item/storage/box/clown(droploc) // Исправление бага
	if(istype(I, /obj/item/stamp/chameleon) && !istype(loc, /obj/item/storage))
		var/atom/droploc = drop_location()
		if(use(1))
			to_chat(user, span_notice("Вы ставите штамп на картоне зловещим образом."))
			if (amount >= 0)
				new/obj/item/storage/box/syndie_kit(droploc)
	else
		. = ..()

/*
 * MARK: Бронза
 */
GLOBAL_LIST_INIT(bronze_recipes, list ( \
	new/datum/stack_recipe("стеновая шестерня", /obj/structure/girder/bronze, 2, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	new /datum/stack_recipe("бронзовая платформа", /obj/structure/platform/bronze, 2, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
	null,
	new/datum/stack_recipe("направленное бронзовое окно", /obj/structure/window/bronze/unanchored, time = 0, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ON_SOLID_GROUND | CRAFT_CHECK_DIRECTION, category = CAT_WINDOWS), \
	new/datum/stack_recipe("бронзовое окно", /obj/structure/window/bronze/fulltile/unanchored, 2, time = 0, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ON_SOLID_GROUND | CRAFT_IS_FULLTILE, category = CAT_WINDOWS), \
	new/datum/stack_recipe("каркас шестерёнчатого шлюза", /obj/structure/door_assembly/door_assembly_bronze, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
	new/datum/stack_recipe("каркас прозрачного шестерёнчатого шлюза", /obj/structure/door_assembly/door_assembly_bronze/seethru, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
	new/datum/stack_recipe("бронзовая плитка", /obj/item/stack/tile/bronze, 1, 4, 20, crafting_flags = NONE, category = CAT_TILES), \
	new/datum/stack_recipe("бронзовый шлем", /obj/item/clothing/head/costume/bronze, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("бронзовый костюм", /obj/item/clothing/suit/costume/bronze, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("бронзовые ботинки", /obj/item/clothing/shoes/bronze, crafting_flags = NONE, category = CAT_CLOTHING), \
	null,
	new/datum/stack_recipe("бронзовый стул", /obj/structure/chair/bronze, 1, time = 0, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
))

/obj/item/stack/sheet/bronze
	name = "bronze"
	desc = "При ближайшем рассмотрении оказывается, что то, что казалось совершенно непригодной для строительства латунью, на самом деле является более структурно стабильной бронзой."
	singular_name = "bronze sheet"
	icon_state = "sheet-brass"
	inhand_icon_state = "sheet-brass"
	icon = 'icons/obj/stack_objects.dmi'
	mats_per_unit = list(/datum/material/bronze = SHEET_MATERIAL_AMOUNT)
	lefthand_file = 'icons/mob/inhands/items/sheets_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/sheets_righthand.dmi'
	resistance_flags = FIRE_PROOF | ACID_PROOF
	construction_path_type = "bronze"
	force = 5
	throwforce = 10
	max_amount = 50
	throw_speed = 1
	throw_range = 3
	novariants = FALSE
	grind_results = list(/datum/reagent/iron = 20, /datum/reagent/copper = 12) //we have no "tin" reagent so this is the closest thing
	merge_type = /obj/item/stack/sheet/bronze
	table_type = /obj/structure/table/bronze
	material_type = /datum/material/bronze
	walltype = /turf/closed/wall/mineral/bronze
	has_unique_girder = TRUE

/obj/item/stack/sheet/bronze/get_ru_names()
	return alist(
		NOMINATIVE = "бронза",
		GENITIVE = "бронзы",
		DATIVE = "бронзе",
		ACCUSATIVE = "бронзу",
		INSTRUMENTAL = "бронзой",
		PREPOSITIONAL = "бронзе"
	)

/obj/item/stack/sheet/bronze/get_main_recipes()
	. = ..()
	. += GLOB.bronze_recipes

/obj/item/stack/sheet/bronze/thirty
	amount = 30

/*
 * MARK: Самоцветы
 */
/obj/item/stack/sheet/lessergem
	name = "lesser gems"
	desc = "Редкий вид самоцветов, которые можно получить только кровавой жертвой младшим божествам. Они необходимы для создания могущественных предметов."
	singular_name = "lesser gem"
	icon_state = "sheet-lessergem"
	inhand_icon_state = null
	novariants = TRUE
	merge_type = /obj/item/stack/sheet/lessergem

/obj/item/stack/sheet/lessergem/get_ru_names()
	return alist(
		NOMINATIVE = "малые самоцветы",
		GENITIVE = "малых самоцветов",
		DATIVE = "малым самоцветам",
		ACCUSATIVE = "малые самоцветы",
		INSTRUMENTAL = "малыми самоцветами",
		PREPOSITIONAL = "малых самоцветах"
	)

/obj/item/stack/sheet/greatergem
	name = "greater gems"
	desc = "Редкий вид самоцветов, которые можно получить только кровавой жертвой старшим божествам. Они необходимы для создания могущественных предметов."
	singular_name = "greater gem"
	icon_state = "sheet-greatergem"
	inhand_icon_state = null
	novariants = TRUE
	merge_type = /obj/item/stack/sheet/greatergem

/obj/item/stack/sheet/greatergem/get_ru_names()
	return alist(
		NOMINATIVE = "великие самоцветы",
		GENITIVE = "великих самоцветов",
		DATIVE = "великим самоцветам",
		ACCUSATIVE = "великие самоцветы",
		INSTRUMENTAL = "великими самоцветами",
		PREPOSITIONAL = "великих самоцветах"
	)

/*
 * MARK: Кости
 */
/obj/item/stack/sheet/bone
	name = "bones"
	icon = 'icons/obj/stack_objects.dmi'
	icon_state = "bone"
	inhand_icon_state = null
	mats_per_unit = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)
	singular_name = "bone"
	desc = "Кто-то пил своё молоко."
	force = 7
	throwforce = 5
	max_amount = 12
	w_class = WEIGHT_CLASS_NORMAL
	throw_speed = 1
	throw_range = 3
	grind_results = list(/datum/reagent/carbon = 10)
	merge_type = /obj/item/stack/sheet/bone
	material_type = /datum/material/bone
	drop_sound = null
	pickup_sound = null
	resistance_flags = FIRE_PROOF | LAVA_PROOF

/obj/item/stack/sheet/bone/get_ru_names()
	return alist(
		NOMINATIVE = "кости",
		GENITIVE = "костей",
		DATIVE = "костям",
		ACCUSATIVE = "кости",
		INSTRUMENTAL = "костями",
		PREPOSITIONAL = "костях"
	)

/obj/item/stack/sheet/bone/Initialize(mapload, new_amount, merge, list/mat_override, mat_amt)
	. = ..()

	// As bone and sinew have just a little too many recipes for this, we'll just split them up.
	// Sinew slapcrafting will mostly-sinew recipes, and bones will have mostly-bones recipes.
	var/static/list/slapcraft_recipe_list = list(
		/datum/crafting_recipe/bonearmor,
		/datum/crafting_recipe/boneaxe,
		/datum/crafting_recipe/bonedagger,
		/datum/crafting_recipe/bonespear,
		/datum/crafting_recipe/bracers,
		/datum/crafting_recipe/skullhelm,
	)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/*
 * MARK: Пластик
 */
GLOBAL_LIST_INIT(plastic_recipes, list(
	new /datum/stack_recipe("пластиковая плитка", /obj/item/stack/tile/plastic, 1, 4, 20, time = 2 SECONDS, crafting_flags = NONE, category = CAT_TILES), \
	new /datum/stack_recipe("светлая плитка", /obj/item/stack/thermoplastic/light, 1, 4, 20, time = 2 SECONDS, crafting_flags = NONE, category = CAT_TILES), \
	new /datum/stack_recipe("тёмная плитка", /obj/item/stack/thermoplastic, 1, 4, 20, time = 2 SECONDS, crafting_flags = NONE, category = CAT_TILES), \
	new /datum/stack_recipe("пластиковый стул", /obj/structure/chair/plastic, 2, crafting_flags = NONE, category = CAT_FURNITURE), \
	new /datum/stack_recipe("пластиковые шторки", /obj/structure/plasticflaps, 5, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, time = 4 SECONDS, category = CAT_FURNITURE), \
	new /datum/stack_recipe("бутылка воды", /obj/item/reagent_containers/cup/glass/waterbottle/empty, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new /datum/stack_recipe("большая бутылка воды", /obj/item/reagent_containers/cup/glass/waterbottle/large/empty, 3, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new /datum/stack_recipe("стаканчик", /obj/item/reagent_containers/cup/glass/colocup, 1, crafting_flags = NONE, category = CAT_CONTAINERS, removed_mats = list(/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)), \
	new /datum/stack_recipe("манекен", /obj/structure/mannequin/plastic, 25, time = 5 SECONDS, crafting_flags = CRAFT_ONE_PER_TURF, category = CAT_ENTERTAINMENT), \
	new /datum/stack_recipe("знак 'мокрый пол'", /obj/item/clothing/suit/caution, 2, crafting_flags = NONE, category = CAT_EQUIPMENT), \
	new /datum/stack_recipe("предупредительный конус", /obj/item/clothing/head/cone, 2, crafting_flags = NONE, category = CAT_EQUIPMENT), \
	new /datum/stack_recipe("пустая настенная табличка", /obj/item/sign, 1, crafting_flags = NONE, category = CAT_FURNITURE), \
	new /datum/stack_recipe("кувшин для кулера", /obj/item/reagent_containers/cooler_jug, 4, time = 5 SECONDS, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new /datum/stack_recipe("кулер для воды", /obj/structure/reagent_dispensers/water_cooler/jugless, 25, time = 10 SECONDS, crafting_flags = NONE, category = CAT_STRUCTURE), \
	new /datum/stack_recipe("маска восстания", /obj/item/clothing/mask/rebellion, 1, crafting_flags = NONE, category = CAT_CLOTHING)))

/obj/item/stack/sheet/plastic
	name = "plastic"
	desc = "Сожмите динозавра на протяжении миллионов лет, затем очистите, разделите и отформуйте — и вуаля! У вас есть пластик."
	singular_name = "plastic sheet"
	icon_state = "sheet-plastic"
	inhand_icon_state = "sheet-plastic"
	mats_per_unit = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT)
	throwforce = 7
	material_type = /datum/material/plastic
	merge_type = /obj/item/stack/sheet/plastic
	pickup_sound = 'sound/items/handling/materials/plastic_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/plastic_drop.ogg'

/obj/item/stack/sheet/plastic/get_ru_names()
	return alist(
		NOMINATIVE = "пластик",
		GENITIVE = "пластика",
		DATIVE = "пластику",
		ACCUSATIVE = "пластик",
		INSTRUMENTAL = "пластиком",
		PREPOSITIONAL = "пластике"
	)

/obj/item/stack/sheet/plastic/fifty
	amount = 50

/obj/item/stack/sheet/plastic/five
	amount = 5

/obj/item/stack/sheet/plastic/get_main_recipes()
	. = ..()
	. += GLOB.plastic_recipes

/*
 * MARK: Плотная бумага
 */
GLOBAL_LIST_INIT(paperframe_recipes, list(
	new /datum/stack_recipe("бумажная перегородка", /obj/structure/window/paperframe, 2, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND | CRAFT_IS_FULLTILE, time = 1 SECONDS), \
	new /datum/stack_recipe("бумажная дверь", /obj/structure/mineral_door/paperframe, 3, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, time = 1 SECONDS ), \
	new /datum/stack_recipe("бумажная платформа", /obj/structure/platform/paper, 2, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
))

/obj/item/stack/sheet/paperframes
	name = "paper frames"
	desc = "Тонкая деревянная рамка с прикреплённой бумагой."
	singular_name = "paper frame"
	icon_state = "sheet-paper"
	inhand_icon_state = "sheet-paper"
	mats_per_unit = list(/datum/material/paper = SHEET_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/paperframes
	resistance_flags = FLAMMABLE
	grind_results = list(/datum/reagent/cellulose = 20)
	material_type = /datum/material/paper
	drop_sound = null
	pickup_sound = null

/obj/item/stack/sheet/paperframes/get_ru_names()
	return alist(
		NOMINATIVE = "бумажная рамка",
		GENITIVE = "бумажной рамки",
		DATIVE = "бумажной рамке",
		ACCUSATIVE = "бумажную рамку",
		INSTRUMENTAL = "бумажной рамкой",
		PREPOSITIONAL = "бумажной рамке"
	)

/obj/item/stack/sheet/paperframes/get_main_recipes()
	. = ..()
	. += GLOB.paperframe_recipes
/obj/item/stack/sheet/paperframes/five
	amount = 5
/obj/item/stack/sheet/paperframes/twenty
	amount = 20
/obj/item/stack/sheet/paperframes/fifty
	amount = 50

/*
 * MARK: Еда
 */
/obj/item/stack/sheet/meat
	name = "meat sheets"
	desc = "Чьё-то кровавое мясо, спрессованное в хороший твёрдый лист."
	singular_name = "meat sheet"
	icon_state = "sheet-meat"
	material_flags = MATERIAL_EFFECTS | MATERIAL_COLOR
	mats_per_unit = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/meat
	material_type = /datum/material/meat
	material_modifier = 1 //None of that wussy stuff
	drop_sound = null
	pickup_sound = null

/obj/item/stack/sheet/meat/get_ru_names()
	return alist(
		NOMINATIVE = "мясной лист",
		GENITIVE = "мясного листа",
		DATIVE = "мясному листу",
		ACCUSATIVE = "мясной лист",
		INSTRUMENTAL = "мясным листом",
		PREPOSITIONAL = "мясном листе"
	)

/obj/item/stack/sheet/meat/fifty
	amount = 50
/obj/item/stack/sheet/meat/twenty
	amount = 20
/obj/item/stack/sheet/meat/five
	amount = 5

GLOBAL_LIST_INIT(pizza_sheet_recipes, list(
	new/datum/stack_recipe("огромная пицца", /obj/structure/platform/pizza, 2, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
))

/obj/item/stack/sheet/pizza
	name = "sheet pizza"
	desc = "Это восхитительно прямоугольный лист пиццы!"
	singular_name = "sheet pizza"
	icon_state = "sheet-pizza"
	mats_per_unit = list(/datum/material/pizza = SHEET_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/pizza
	material_type = /datum/material/pizza
	material_modifier = 1
	drop_sound = null
	pickup_sound = null

/obj/item/stack/sheet/pizza/get_ru_names()
	return alist(
		NOMINATIVE = "лист пиццы",
		GENITIVE = "листа пиццы",
		DATIVE = "листу пиццы",
		ACCUSATIVE = "лист пиццы",
		INSTRUMENTAL = "листом пиццы",
		PREPOSITIONAL = "листе пиццы"
	)

/obj/item/stack/sheet/pizza/get_main_recipes()
	. = ..()
	. += GLOB.pizza_sheet_recipes

/obj/item/stack/sheet/pizza/fifty
	amount = 50
/obj/item/stack/sheet/pizza/twenty
	amount = 20
/obj/item/stack/sheet/pizza/five
	amount = 5

/*
 * MARK: Проклятое
 */
/obj/item/stack/sheet/hauntium
	name = "haunted sheets"
	desc = "Эти листы кажутся проклятыми."
	singular_name = "haunted sheet"
	icon_state = "sheet-meat"
	material_flags = MATERIAL_EFFECTS | MATERIAL_COLOR
	mats_per_unit = list(/datum/material/hauntium = SHEET_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/hauntium
	material_type = /datum/material/hauntium
	material_modifier = 1 //None of that wussy stuff
	grind_results = list(/datum/reagent/hauntium = 20)

/obj/item/stack/sheet/hauntium/get_ru_names()
	return alist(
		NOMINATIVE = "проклятые листы",
		GENITIVE = "проклятых листов",
		DATIVE = "проклятым листам",
		ACCUSATIVE = "проклятые листы",
		INSTRUMENTAL = "проклятыми листами",
		PREPOSITIONAL = "проклятых листах"
	)

/obj/item/stack/sheet/hauntium/fifty
	amount = 50
/obj/item/stack/sheet/hauntium/twenty
	amount = 20
/obj/item/stack/sheet/hauntium/five
	amount = 5
