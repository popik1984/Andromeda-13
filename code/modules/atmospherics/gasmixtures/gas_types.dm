/proc/meta_gas_list()
	. = subtypesof(/datum/gas)
	for(var/gas_path in .)
		var/list/gas_info = new(8)
		var/datum/gas/gas = gas_path

		gas_info[META_GAS_SPECIFIC_HEAT] = initial(gas.specific_heat)
		gas_info[META_GAS_NAME] = initial(gas.name)

		gas_info[META_GAS_MOLES_VISIBLE] = initial(gas.moles_visible)
		if(initial(gas.moles_visible) != null)
			gas_info[META_GAS_OVERLAY] = generate_gas_overlays(0, SSmapping.max_plane_offset, gas)

		gas_info[META_GAS_FUSION_POWER] = initial(gas.fusion_power)
		gas_info[META_GAS_DANGER] = initial(gas.dangerous)
		gas_info[META_GAS_ID] = initial(gas.id)
		gas_info[META_GAS_DESC] = initial(gas.desc)
		.[gas_path] = gas_info

/proc/generate_gas_overlays(old_offset, new_offset, datum/gas/gas_type)
	var/list/to_return = list()
	for(var/i in old_offset to new_offset)
		var/fill = list()
		to_return += list(fill)
		for(var/j in 1 to TOTAL_VISIBLE_STATES)
			var/obj/effect/overlay/gas/gas = new (initial(gas_type.gas_overlay), log(4, (j+0.4*TOTAL_VISIBLE_STATES) / (0.35*TOTAL_VISIBLE_STATES)) * 255, i)
			fill += gas
	return to_return

/proc/gas_id2path(id)
	var/list/meta_gas = GLOB.meta_gas_info
	if(id in meta_gas)
		return id
	for(var/path in meta_gas)
		if(meta_gas[path][META_GAS_ID] == id)
			return path
	return ""

/*||||||||||||||/----------\||||||||||||||*\
||||||||||||||||[GAS DATUMS]||||||||||||||||
||||||||||||||||\__________/||||||||||||||||
|||| Их никогда не следует инстанцировать.|||
|||| Они существуют только для облегчения |||
|||| добавления нового газа. Доступ к ним |||
|||| осуществляется только через          |||
|||| meta_gas_list().                     |||
\*||||||||||||||||||||||||||||||||||||||||*/

//Это график, созданный с использованием значений экспорта газа. Каждый газ имеет значение, которое работает как своего рода мягкий предел, который ограничивает возможность зарабатывать миллиарды кредитов за продажу, на основе переменной base_value в самих газах. В результате большинство этих газов имеют довольно низкую стоимость при продаже, например, азот и кислород - 1500 и 600 соответственно при их максимальном значении.
/datum/gas
	var/id = ""
	var/specific_heat = 0
	var/name = ""
	///icon_state в icons/effects/atmospherics.dmi
	var/gas_overlay = ""
	var/moles_visible = null
	///в настоящее время используется канистрами
	var/dangerous = FALSE
	///Насколько газ ускоряет реакцию синтеза
	var/fusion_power = 0
	/// относительная редкость по сравнению с другими газами, используется при настройке списка реакций.
	var/rarity = 0
	///Можно ли купить газ этого типа через карго?
	var/purchaseable = FALSE
	///Сколько стоит продажа одного моля этого газа? Формула для расчёта максимального значения находится в code\modules\cargo\exports\large_objects.dm. Не имеет значения для газов, доступных в начале раунда.
	var/base_value = 0
	var/desc
	///RGB-код для использования, когда нужен общий цвет, представляющий газ. Цвета взяты из constants.ts
	var/primary_color


/datum/gas/oxygen
	id = GAS_O2
	specific_heat = 20
	name = "Oxygen"
	rarity = 900
	purchaseable = TRUE
	base_value = 0.2
	desc = "Газ, необходимый большинству форм жизни для выживания. Также окислитель."
	primary_color = "#0000ff"

/datum/gas/nitrogen
	id = GAS_N2
	specific_heat = 20
	name = "Nitrogen"
	rarity = 1000
	purchaseable = TRUE
	base_value = 0.1
	desc = "Очень распространённый газ, используемый для доведения искусственных атмосфер до обитаемого давления."
	primary_color = "#ffff00"

/datum/gas/carbon_dioxide //что это, блять?
	id = GAS_CO2
	specific_heat = 30
	name = "Carbon Dioxide"
	dangerous = TRUE
	rarity = 700
	purchaseable = TRUE
	base_value = 0.2
	desc = "Что, блять, такое углекислый газ?"
	primary_color = COLOR_GRAY

/datum/gas/plasma
	id = GAS_PLASMA
	specific_heat = 200
	name = "Plasma"
	gas_overlay = "plasma"
	moles_visible = MOLES_GAS_VISIBLE
	dangerous = TRUE
	rarity = 800
	base_value = 1.5
	desc = "Горючий газ со многими любопытными свойствами. Его исследование — одна из основных целей NT."
	primary_color = "#ffc0cb"

/datum/gas/water_vapor
	id = GAS_WATER_VAPOR
	specific_heat = 40
	name = "Water Vapor"
	gas_overlay = "water_vapor"
	moles_visible = MOLES_GAS_VISIBLE
	fusion_power = 8
	rarity = 500
	purchaseable = TRUE
	base_value = 0.5
	desc = "Вода в газообразной форме. Делает полы скользкими и смывает предметы на них."
	primary_color = "#b0c4de"

/datum/gas/hypernoblium
	id = GAS_HYPER_NOBLIUM
	specific_heat = 2000
	name = "Hyper-noblium"
	gas_overlay = "freon"
	moles_visible = MOLES_GAS_VISIBLE
	fusion_power = 10
	rarity = 50
	base_value = 2.5
	desc = "Самый благородный газ из всех. Большое количество гипер-ноблия активно предотвращает возникновение реакций."
	primary_color = COLOR_TEAL

/datum/gas/nitrous_oxide
	id = GAS_N2O
	specific_heat = 40
	name = "Nitrous Oxide"
	gas_overlay = "nitrous_oxide"
	moles_visible = MOLES_GAS_VISIBLE * 2
	fusion_power = 10
	dangerous = TRUE
	rarity = 600
	purchaseable = TRUE
	base_value = 1.5
	desc = "Вызывает сонливость, эйфорию и, в конечном итоге, потерю сознания."
	primary_color = "#ffe4c4"

/datum/gas/nitrium
	id = GAS_NITRIUM
	specific_heat = 10
	name = "Nitrium"
	fusion_power = 7
	gas_overlay = "nitrium"
	moles_visible = MOLES_GAS_VISIBLE
	dangerous = TRUE
	rarity = 1
	base_value = 6
	desc = "Экспериментальный газ, улучшающий производительность. Эффекты нитрия могут усиливаться по мере попадания его в кровоток."
	primary_color = "#a52a2a"

/datum/gas/tritium
	id = GAS_TRITIUM
	specific_heat = 10
	name = "Tritium"
	gas_overlay = "tritium"
	moles_visible = MOLES_GAS_VISIBLE
	dangerous = TRUE
	fusion_power = 5
	rarity = 300
	base_value = 2.5
	desc = "Сильногорючий и радиоактивный газ."
	primary_color = "#32cd32"

/datum/gas/bz
	id = GAS_BZ
	specific_heat = 20
	name = "BZ"
	dangerous = TRUE
	fusion_power = 8
	rarity = 400
	purchaseable = TRUE
	base_value = 1.5
	desc = "Мощное галлюциногенное нервно-паралитическое вещество, способное вызывать когнитивные нарушения."
	primary_color = "#9370db"

/datum/gas/pluoxium
	id = GAS_PLUOXIUM
	specific_heat = 80
	name = "Pluoxium"
	fusion_power = -10
	rarity = 200
	base_value = 2.5
	desc = "Газ, который при вдыхании может поставлять ещё больше кислорода в кровоток, не будучи окислителем."
	primary_color = "#7b68ee"

/datum/gas/miasma
	id = GAS_MIASMA
	specific_heat = 20
	name = "Miasma"
	dangerous = TRUE
	gas_overlay = "miasma"
	moles_visible = MOLES_GAS_VISIBLE * 60
	rarity = 250
	base_value = 1
	desc = "Не обязательно газ, миазмы относятся к биологическим загрязнителям, обнаруженным в атмосфере."
	primary_color = COLOR_OLIVE

/datum/gas/freon
	id = GAS_FREON
	specific_heat = 600
	name = "Freon"
	dangerous = TRUE
	gas_overlay = "freon"
	moles_visible = MOLES_GAS_VISIBLE *30
	fusion_power = -5
	rarity = 10
	base_value = 5
	desc = "Хладагент. В основном используется из-за его эндотермической реакции с кислородом."
	primary_color = "#afeeee"

/datum/gas/hydrogen
	id = GAS_HYDROGEN
	specific_heat = 15
	name = "Hydrogen"
	dangerous = TRUE
	fusion_power = 2
	rarity = 600
	base_value = 1
	desc = "Сильногорючий газ."
	primary_color = "#ffffff"

/datum/gas/healium
	id = GAS_HEALIUM
	specific_heat = 10
	name = "Healium"
	dangerous = TRUE
	gas_overlay = "healium"
	moles_visible = MOLES_GAS_VISIBLE
	rarity = 300
	base_value = 5.5
	desc = "Вызывает глубокий восстановительный сон."
	primary_color = "#fa8072"

/datum/gas/proto_nitrate
	id = GAS_PROTO_NITRATE
	specific_heat = 30
	name = "Proto Nitrate"
	dangerous = TRUE
	gas_overlay = "proto_nitrate"
	moles_visible = MOLES_GAS_VISIBLE
	rarity = 200
	base_value = 2.5
	desc = "Очень летучий газ, который по-разному реагирует с различными газами."
	primary_color = "#adff2f"

/datum/gas/zauker
	id = GAS_ZAUKER
	specific_heat = 350
	name = "Zauker"
	dangerous = TRUE
	gas_overlay = "zauker"
	moles_visible = MOLES_GAS_VISIBLE
	rarity = 1
	base_value = 7
	desc = "Высокотоксичный газ, его производство строго регулируется, помимо того, что оно сложно. Также распадается при контакте с азотом."
	primary_color = "#006400"

/datum/gas/halon
	id = GAS_HALON
	specific_heat = 175
	name = "Halon"
	dangerous = TRUE
	gas_overlay = "halon"
	moles_visible = MOLES_GAS_VISIBLE
	rarity = 300
	base_value = 4
	desc = "Мощное огнетушащее вещество. Удаляет кислород из высокотемпературных пожаров и охлаждает область."
	primary_color = COLOR_PURPLE

/datum/gas/helium
	id = GAS_HELIUM
	specific_heat = 15
	name = "Helium"
	fusion_power = 7
	rarity = 50
	base_value = 3.5
	desc = "Очень инертный газ, производимый синтезом водорода и его производных."
	primary_color = "#f0f8ff"

/datum/gas/antinoblium
	id = GAS_ANTINOBLIUM
	specific_heat = 1
	name = "Antinoblium"
	dangerous = TRUE
	gas_overlay = "antinoblium"
	moles_visible = MOLES_GAS_VISIBLE
	fusion_power = 20
	rarity = 1
	base_value = 10
	desc = "Мы до сих пор не знаем, что он делает, но он продаётся за большие деньги."
	primary_color = COLOR_MAROON

/obj/effect/overlay/gas
	icon = 'icons/effects/atmospherics.dmi'
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	anchored = TRUE  // должен появляться только в vis_contents, но на всякий случай
	layer = FLY_LAYER
	plane = ABOVE_GAME_PLANE
	appearance_flags = TILE_BOUND
	vis_flags = NONE
	// Визуальное смещение, на котором мы находимся.
	// Нельзя использовать традиционный loc, потому что мы хранимся в нуль-пространстве, и мы не можем установить plane перед init из-за помощи, которую SET_PLANE_EXPLICIT делает В init
	var/plane_offset = 0

/obj/effect/overlay/gas/New(state, alph, offset)
	. = ..()
	icon_state = state
	alpha = alph
	plane_offset = offset

/obj/effect/overlay/gas/Initialize(mapload)
	. = ..()
	SET_PLANE_W_SCALAR(src, initial(plane), plane_offset)
