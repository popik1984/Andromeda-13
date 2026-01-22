/// Создать контекстную подсказку (screentip) типа "Type-A", регистрируя `add_item_context()`.
/// `add_item_context()` будет вызываться при наведении предмета на другой объект.
/// `add_item_context()` *не* сработает без вызова этой процедуры.
/// Для типа "Type-A" это не обязательно, можно вручную добавить флаг и сигнал.
/obj/item/proc/register_item_context()
	item_flags |= ITEM_HAS_CONTEXTUAL_SCREENTIPS
	RegisterSignal(
		src,
		COMSIG_ITEM_REQUESTING_CONTEXT_FOR_TARGET,
		PROC_REF(add_item_context),
	)

/// Создать контекстную подсказку (screentip) типа "Type-A".
/// Вызывается при наведении предмета на цель для отображения подсказки.
/// Для работы необходимо вызвать `register_item_context()`.
/// Контекстный список использует ключи SCREENTIP_CONTEXT_* (из __DEFINES/screentips.dm),
/// сопоставленные с текстом действия.
/// При изменении списка внутри сигнала вернуть CONTEXTUAL_SCREENTIP_SET.
/// `source` можно заменить на `src`, присутствует из-за связи с сигналом.
/obj/item/proc/add_item_context(
	obj/item/source,
	list/context,
	atom/target,
	mob/living/user,
)
	SIGNAL_HANDLER

	return NONE
