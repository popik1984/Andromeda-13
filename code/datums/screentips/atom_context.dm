/// Создать контекстную подсказку типа "Type-B", регистрируя `add_context()`.
/// `add_context()` будет вызываться при наведении предмета на этот атом.
/// `add_context()` *не* сработает без вызова этой процедуры.
/// Для типа "Type-B" это не обязательно, можно вручную добавить флаг и сигнал.
/atom/proc/register_context()
	flags_1 |= HAS_CONTEXTUAL_SCREENTIPS_1
	RegisterSignal(src, COMSIG_ATOM_REQUESTING_CONTEXT_FROM_ITEM, PROC_REF(add_context))

/// Создать контекстную подсказку типа "Type-B".
/// Вызывается при наведении предмета на этот атом для отображения подсказки.
/// Для работы необходимо вызвать `register_context()`.
/// Контекстный список использует ключи SCREENTIP_CONTEXT_* (из __DEFINES/screentips.dm),
/// сопоставленные с текстом действия.
/// При изменении списка внутри сигнала вернуть CONTEXTUAL_SCREENTIP_SET.
/// `source` можно заменить на `src`, присутствует из-за связи с сигналом.
/atom/proc/add_context(
	atom/source,
	list/context,
	obj/item/held_item,
	mob/user,
)
	SIGNAL_HANDLER

	return NONE
