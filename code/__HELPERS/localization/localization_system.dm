/**
 * # СИСТЕМА ЛОКАЛИЗАЦИИ SS13 ОТ АНДРОМЕДЫ-13
 * 		Для всех братьев славян из бульёнда!

 * Универсальная система склонения русских названий игровых объектов по падежам.
 * Поддерживает все типы объектов: атомы, материалы, реагенты, части тела и т.д.

 * Всего 4 файла для работы:
 * 1. Andromeda-byond/code/__HELPERS/localization/localization_system.dm - система
 * 2. Andromeda-byond/code/__HELPERS/localization/localization_helpers.dm - макросы для кайфа, советую
 * 3. Andromeda-byond/code/_globalvars/lists/localization.dm - глобал кээээш
 * 4. Andromeda-byond/code/__DEFINES/localization.dm - дефайны падежей

 *	И инструкция, но она иногда не успевает за изменениями, уточняйте у @Rewokin
 *	Andromeda-byond/.github/guides/LOCALIZATION.md

 * ## ОСНОВНОЙ ПРИНЦИП РАБОТЫ
 * 1. Каждый датум может иметь список переводов `ru_names` с 6 падежами
 * 2. При первом обращении система кэширует переводы для типа
 * 3. Последующие обращения используют кэш для максимальной производительности

 * ## ТРЕХУРОВНЕВЫЙ КЭШ (ОПТИМИЗАЦИЯ)
 * ┌─────────────────────────────────────────┐
 * │ УРОВЕНЬ 1: Прямо в объекте              │ → target.vars["ru_names"]
 * │       0.1 мс - данные в памяти объекта  │
 * ├─────────────────────────────────────────┤
 * │ УРОВЕНЬ 2: Глобальный кэш по типам      │ → GLOB.cached_ru_names[type]
 * │       0.3 мс - хеш-таблица              │
 * ├─────────────────────────────────────────┤
 * │ УРОВЕНЬ 3: Вычисление через get_ru_names│
 * │       3-10 мс - первое обращение к типу │
 * └─────────────────────────────────────────┘

 * Круто да? Я сам в ахуе, как такое смогло заговнокодиться.
 */

// ==================== БАЗОВЫЕ ОПРЕДЕЛЕНИЯ ====================

/datum
    /// Список русских названий в падежах
    var/list/ru_names

/datum/proc/get_ru_names()
    return null

// ===================== ОСНОВНАЯ СИСТЕМА =====================

/**
 * Универсальная процедура склонения русского названия.
 * Принимает объект и нужный падеж, возвращает название в этом падеже.
 */
/proc/declent_ru(datum/target, case_id)
    // Проверка входных данных - если что-то отсутствует, возвращаем пустую строку
    if(!target || !case_id)
        return ""

    // ПЕРВЫЙ УРОВЕНЬ КЭША: смотрим прямо в объекте
    // target.vars["ru_names"] - прямой доступ к переменной, быстрее чем target.ru_names
    var/list/ru_names = target.vars["ru_names"]

    // ВТОРОЙ УРОВЕНЬ КЭША: если в объекте нет, проверяем глобальный кэш
    if(!ru_names)
        // Ищем в кэше по типу объекта (например, /obj/item/scalpel)
        ru_names = GLOB.cached_ru_names[target.type]

        // ТРЕТИЙ УРОВЕНЬ: если в кэше нет (isnull, а не !ru_names)
        if(isnull(ru_names))  // isnnull отличает "не вычисляли" от "пустой список"
            // Вызываем get_ru_names() объекта (может вернуть список или null)
            ru_names = target.get_ru_names()
            // Сохраняем в кэш ДАЖЕ ЕСЛИ null (чтобы не вычислять повторно)
            GLOB.cached_ru_names[target.type] = ru_names

    // Если нашли перевод для нужного падежа - возвращаем его
    if(ru_names && ru_names[case_id])
        return ru_names[case_id]

    // FALLBACK: если перевода нет, используем стандартное имя
    // Кэшируем fallback-имя тоже, чтобы не вычислять каждый раз
    var/fallback = GLOB.cached_fallback_names[target.type]
    if(isnull(fallback))
        // Вычисляем имя по умолчанию
        fallback = compute_fallback_name(target)
        // Сохраняем в кэш
        GLOB.cached_fallback_names[target.type] = fallback

    return fallback

/**
 * Вычисление имени по умолчанию, когда нет перевода.
 * Иерархия fallback:
 */
/proc/compute_fallback_name(datum/target)
    // 1. Если это часть тела - используем plaintext_zone
    if(istype(target, /obj/item/bodypart))
        var/obj/item/bodypart/BP = target
        if(BP.plaintext_zone)
            return BP.plaintext_zone  // например, "левая рука"

    // 2. Пытаемся получить переменную name объекта
    var/name = target.vars["name"]  // прямой доступ через vars
    if(name)
        return name  // английское или уже переведенное имя

    // 3. Последний вариант: берем имя типа без пути
    var/type_string = "[target.type]"  // превращаем путь в строку
    var/last_slash = findtextEx(type_string, "/", 1, 0)  // ищем последний слэш
    if(last_slash)
        return copytext(type_string, last_slash + 1)  // обрезаем путь
    return type_string  // если слэшей нет, возвращаем как есть
