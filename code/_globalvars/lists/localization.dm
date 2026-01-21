// ==================== ГЛОБАЛЬНЫЕ ПЕРЕМЕННЫЕ ====================

/**
 * cached_ru_names - ГЛАВНЫЙ КЭШ ПЕРЕВОДОВ
 *
 * Формат: typepath → list(падежи) или null
 *
 * Пример:
 * /obj/item/scalpel → list(
 *     NOMINATIVE = "скальпель",
 *     GENITIVE = "скальпеля",
 *     ...
 * )
 *
 * ИЛИ null (если у типа нет перевода)
 *
 * Зачем нужен: Чтобы не вызывать get_ru_names() каждый раз
 * Первый скальпель: вычисляем перевод (3-10мс)
 * Второй скальпель: берем из кэша (0.3мс)
 */
GLOBAL_LIST_EMPTY(cached_ru_names)          // Создает пустой глобальный список
GLOBAL_PROTECT(cached_ru_names)             // Защищает от случайного удаления/очистки

/**
 * cached_fallback_names - КЭШ СТАНДАРТНЫХ ИМЕН
 *
 * Формат: typepath → string (имя по умолчанию)
 *
 * Пример:
 * /obj/item/scalpel → "scalpel" (английское имя)
 * /obj/item/bodypart/head → "голова" (plaintext_zone)
 *
 * Зачем нужен: Чтобы не вычислять fallback-имя каждый раз
 * Fallback используется когда нет русского перевода
 */
GLOBAL_LIST_EMPTY(cached_fallback_names)    // Создает пустой глобальный список
GLOBAL_PROTECT(cached_fallback_names)       // Защищает от случайного удаления/очистки


/**
 * Если на простом.
 * cached_ru_names = "библиотека переводов"
 * cached_fallback_names = "запасные английские имена" - обратка, если не находит русские буковки :)
 */
