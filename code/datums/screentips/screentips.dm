#define HINT_ICON_FILE 'icons/ui/screentips/cursor_hints.dmi'

/// Хранит иконки подсказок курсора для контекстных screentip.
GLOBAL_LIST_INIT_TYPED(screentip_context_icons, /image, prepare_screentip_context_icons())

/proc/prepare_screentip_context_icons()
	var/list/output = list()
	for(var/state in icon_states(HINT_ICON_FILE))
		output[state] = image(HINT_ICON_FILE, icon_state = state)
	return output

/*
 * # Компилирует строку для этого ключа
 * Аргументы:
 * - context = list (ОБЯЗАТЕЛЕН)
 * 	- Должен содержать ключ
 * - key = string (ОБЯЗАТЕЛЕН)
 * - allow_image = boolean (не обязателен)
*/
/proc/build_context(list/context, key, allow_image)
	if(!length(context) || !context[key] || !key)
		return ""
	// Отделяет комбинации клавиш от кнопок мыши. Напр. `Ctrl-Shift-LMB` на входе, `Ctrl-Shift-` на выходе. Будет пустым для одиночных кнопок.
	var/key_combo = length(key) > 3 ? "[copytext(key, 1, -3)]" : ""
	// Получает кнопку мыши: LMB/RMB
	var/button = copytext(key, -3)
	if(allow_image)
		// Компилирует в изображение, если разрешено
		button = "\icon[GLOB.screentip_context_icons[button]]"

	// Готовый результат
	return "[key_combo][button][allow_image ? "" : ":"] [context[key]]"

#undef HINT_ICON_FILE
