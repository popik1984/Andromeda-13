/**
 * Возвращает правильную форму слова, соответствующую русскому склонению числительных.
 *
 * Учитывает правила русского языка, определяющие окончания числительных, на основе переданного числа.
 * Использует три формы: единственное число (1), двойственное число (2-4) и множественное число (5+).
 *
 * Аргументы:
 * * num - Число, для которого необходимо определить форму слова
 * * single_name - Форма слова для 1 (например, "стол")
 * * double_name - Форма слова для 2-4 (например, "стола")
 * * multiple_name - Форма слова для 5+ (например, "столов")
 */
/proc/declension_ru(num, single_name, double_name, multiple_name)
	if(!isnum(num))
		stack_trace("Invalid number argument in declension_ru proc.")
		return double_name
	if(!istext(single_name) || !istext(double_name) || !istext(multiple_name))
		stack_trace("Invalid word arguments in declension_ru proc.")
		return double_name
	if(round(num) != num)
		return double_name // fractional numbers
	if(((num % 10) == 1) && ((num % 100) != 11)) // 1, not 11
		return single_name
	if(((num % 10) in 2 to 4) && !((num % 100) in 12 to 14)) // 2, 3, 4, not 12, 13, 14
		return double_name
	return multiple_name // 5, 6, 7, 8, 9, 0

// Секунд, минут, единиц
#define DECL_SEC_MIN(num) declension_ru(num, "у", "ы", "")
// Кредит, символ
#define DECL_CREDIT(num) declension_ru(num, "", "а", "ов")

/**
 * Возвращает форму слова с учётом грамматического рода в русском языке.
 *
 * Выбирает правильную форму слова в зависимости от его грамматического рода (MALE, FEMALE, NEUTER)
 * или множественного числа (PLURAL). Используется для прилагательных, местоимений и глаголов,
 * изменяющихся по родам.
 *
 * Аргументы:
 * * gender - Грамматический род (MALE, FEMALE, NEUTER, PLURAL)
 * * male_word - Мужская форма (например, "тыкнул")
 * * female_word - Женская форма (например, "тыкнула")
 * * neuter_word - Средняя форма (например, "тыкнуло")
 * * multiple_word - Форма множественного числа (например, "тыкнули")
 */
/proc/genderize_ru(gender, male_word, female_word, neuter_word, multiple_word)
	if(!(gender in list(MALE, FEMALE, NEUTER, PLURAL)))
		stack_trace("Invalid gender argument in genderize_ru proc.")
		return multiple_word
	if(!istext(male_word) || !istext(female_word) || !istext(neuter_word) || !istext(multiple_word))
		stack_trace("Invalid word arguments in genderize_ru proc.")
		return multiple_word
	return gender == MALE ? male_word : (gender == FEMALE ? female_word : (gender == NEUTER ? neuter_word : multiple_word))

// Местоимения.
#define GEND_HE_SHE(target) genderize_ru(target.gender, "он", "она", "оно", "они")
#define GEND_HE_SHE_CAP(target) capitalize(genderize_ru(target.gender, "он", "она", "оно", "они"))
#define GEND_HIS_HER(target) genderize_ru(target.gender, "его", "её", "его", "их")
#define GEND_HIS_HER_CAP(target) capitalize(genderize_ru(target.gender, "его", "её", "его", "их"))
#define GEND_HIM_HER(target) genderize_ru(target.gender, "ему", "ей", "ему", "им")
#define GEND_ON_IN_HIM(target) genderize_ru(target.gender, "нём", "ней", "нём", "них")
#define GEND_YOUR(target) genderize_ru(target.gender, "ваш", "вашу", "ваше", "ваши")
#define GEND_YOURS(target) genderize_ru(target.gender, "вашего", "вашей", "вашего", "ваших")
// Окончания. Y — буква Ы.
#define GEND_A_O_I(target) genderize_ru(target.gender, "", "а", "о", "и")
#define GEND_A_O_Y(target) genderize_ru(target.gender, "", "а", "о", "ы")
#define GEND_A_E_I(target) genderize_ru(target.gender, "", "а", "е", "и")
#define GEND_SYA_AS_OS_IS(target) genderize_ru(target.gender, "ся", "ась", "ось", "ись")
#define GEND_LA_LO_LI(target) genderize_ru(target.gender, "", "ла", "ло", "ли")
#define GEND_EN_NA_NO_NY(target) genderize_ru(target.gender, "ен", "на", "но", "ны")
#define GEND_EM_EI_EM_IH(target) genderize_ru(target.gender, "ем", "ей", "ем", "их")
#define GEND_YM_OI_YM_YMI(target) genderize_ru(target.gender, "ым", "ой", "ым", "ыми")
#define GEND_IM_EI_IM_IMI(target) genderize_ru(target.gender, "им", "ей", "им", "ими")
#define GEND_YI_AYA_OE_YE(target) genderize_ru(target.gender, "ый", "ая", "ое", "ые")
#define GEND_II_AYA_II_IE(target) genderize_ru(target.gender, "ий", "ая", "ий", "ие")
// Макросы для случаев, когда обычные не применимы.
#define GEND_SHEL(target) genderize_ru(target.gender, "шёл", "шла", "шло", "шли")

/**
 * Возвращает форму единственного или множественного числа в зависимости от грамматического рода.
 *
 * Простой инструмент, который помогает легко переключаться между формами единственного и
 * множественного числа, основываясь на указанном роде.
 *
 * Аргументы:
 * * gender - Грамматический род (MALE, FEMALE, NEUTER, PLURAL)
 * * single_word - Форма единственного числа (например, "делает")
 * * plural_word - Форма множественного числа (например, "делают")
 */
/proc/pluralize_ru(gender, single_word, plural_word)
	return gender == PLURAL ? plural_word : single_word

#define PLUR_ET_YUT(target) pluralize_ru(target.gender, "ет", "ют")
#define PLUR_YOT_YUT(target) pluralize_ru(target.gender, "ёт", "ют")
#define PLUR_ET_UT(target) pluralize_ru(target.gender, "ет", "ут")
#define PLUR_YOT_UT(target) pluralize_ru(target.gender, "ёт", "ут")
#define PLUR_IT_YAT(target) pluralize_ru(target.gender, "ит", "ят")
#define PLUR_IT_AT(target) pluralize_ru(target.gender, "ит", "ат")
#define PLUR_I(target) pluralize_ru(target.gender, "", "и")
// Макросы для случаев, когда обычные не применимы.
#define PLUR_JET_GUT(target) pluralize_ru(target.gender, "жет", "гут")
#define PLUR_CHET_TYAT(target) pluralize_ru(target.gender, "чет", "тят")

/**
 * Обрабатывает гендерно-зависимую текстовую разметку в строке.
 *
 * Заменяет шаблоны %(SINGLE,PLURAL)% и %(MALE,FEMALE,NEUTER,PLURAL)% в сообщении
 * на соответствующую форму слова в зависимости от пола моба.
 * Используйте * для пропуска конкретной формы рода (например, %(*,FEMALE,*,PLURAL)%).
 * Обрабатывает все шаблоны до тех пор, пока они полностью не исчезнут.
 *
 * Аргументы:
 * * user - Моб, чей пол определяет форму слов (использует NEUTER, если не моб)
 * * msg - Строка с гендерной разметкой для обработки
 */
/proc/genderize_decode(mob/user, msg)
	if(!istext(msg))
		stack_trace("Invalid arguments in genderize_decode proc.")
	var/gender
	if(ismob(user))
		gender = user.gender
	else
		gender = NEUTER
	while(TRUE)
		var/prefix = findtext_char(msg, "%(")
		if(!prefix)
			break
		var/postfix = findtext_char(msg, ")%")
		if(!postfix)
			stack_trace("Genderize string is missing proper ending, expected )%.")
		var/list/pieces = splittext(copytext_char(msg, prefix + 2, postfix), ",")
		switch(length(pieces))
			if(2) // pluralize if only two parts present
				msg = replacetext(splicetext_char(msg, prefix, postfix + 2, pluralize_ru(gender, pieces[1], pieces[2])), "*", "")
			if(4) // use full genderize if all four parts exist
				msg = replacetext(splicetext_char(msg, prefix, postfix + 2, genderize_ru(gender, pieces[1], pieces[2], pieces[3], pieces[4])), "*", "")
			else
				stack_trace("Invalid data sent to genderize_decode proc.")
	return msg

// ==================== МАКРОСЫ ДЛЯ ОБЩЕГО ИСПОЛЬЗОВАНИЯ ====================

// "[hanging_parent] falls apart!"
// "[RU_NOM(hanging_parent))] разваливается!" - "стул разваливается!"

#define RU_NOM(target) declent_ru(target, NOMINATIVE)      // именительный
#define RU_GEN(target) declent_ru(target, GENITIVE)        // родительный
#define RU_DAT(target) declent_ru(target, DATIVE)          // дательный
#define RU_ACC(target) declent_ru(target, ACCUSATIVE)      // винительный - Ахахахах АСС. Ну типо ЭЭЭЭЭССССССС. Как типо как ASS. Не смешно? Иди нахуй.
#define RU_INS(target) declent_ru(target, INSTRUMENTAL)    // творительный
#define RU_PRE(target) declent_ru(target, PREPOSITIONAL)   // предложный

// ==================== МАКРОСЫ С ЗАГЛАВНОЙ БУКВОЙ ====================

// "[hanging_parent] falls apart!"
// "[CAP_RU_NOM(hanging_parent))] разваливается!" - "Стул разваливается!"

#define CAP_RU_NOM(target) capitalize(RU_NOM(target))      // "Стол"
#define CAP_RU_GEN(target) capitalize(RU_GEN(target))      // "Стола"
#define CAP_RU_DAT(target) capitalize(RU_DAT(target))      // "Столу"
#define CAP_RU_ACC(target) capitalize(RU_ACC(target))      // "Стол" - Ахахахах АС.. Бля, я уже шутил про это. Ладно.
#define CAP_RU_INS(target) capitalize(RU_INS(target))      // "Столом"
#define CAP_RU_PRE(target) capitalize(RU_PRE(target))      // "Столе"

// ==================== МАКРОСЫ ДЛЯ SRC ====================

// "You hit [scr]!"
// "Вы ударили [RU_SRC_ACC]!" - "Вы ударили обезъяну!"

#define RU_SRC(case) declent_ru(src, case)
#define RU_SRC_NOM RU_SRC(NOMINATIVE)                      // src в именительном
#define RU_SRC_GEN RU_SRC(GENITIVE)                        // src в родительном
#define RU_SRC_DAT RU_SRC(DATIVE)                          // src в дательном
#define RU_SRC_ACC RU_SRC(ACCUSATIVE)                      // src в винительном
#define RU_SRC_INS RU_SRC(INSTRUMENTAL)                    // src в творительном
#define RU_SRC_PRE RU_SRC(PREPOSITIONAL)                   // src в предложном

// ==================== МАКРОСЫ ДЛЯ TARGET ====================

// "You hit [scr]!"
// "Вы ударили [RU_TAR_ACC]!" - "Вы ударили обезъяну!"

#define RU_TAR(case) declent_ru(target, case)
#define RU_TAR_NOM RU_TAR(NOMINATIVE)              // target в именительном
#define RU_TAR_GEN RU_TAR(GENITIVE)                // target в родительном
#define RU_TAR_DAT RU_TAR(DATIVE)                  // target в дательном
#define RU_TAR_ACC RU_TAR(ACCUSATIVE)              // target в винительном
#define RU_TAR_INS RU_TAR(INSTRUMENTAL)            // target в творительном
#define RU_TAR_PRE RU_TAR(PREPOSITIONAL)           // target в предложном

// ==================== МАКРОСЫ ДЛЯ USER ====================

// "[user] hit [scr]!"
// "[RU_USER_NOM] ударили [RU_TAR_ACC]!" - "Человек ударили обезъяну!"

#define RU_USER(case) declent_ru(user, case)
#define RU_USER_NOM RU_USER(NOMINATIVE)              // user в именительном
#define RU_USER_GEN RU_USER(GENITIVE)                // user в родительном
#define RU_USER_DAT RU_USER(DATIVE)                  // user в дательном
#define RU_USER_ACC RU_USER(ACCUSATIVE)              // user в винительном
#define RU_USER_INS RU_USER(INSTRUMENTAL)            // user в творительном
#define RU_USER_PRE RU_USER(PREPOSITIONAL)           // user в предложном

// ==================== МАКРОСЫ ДЛЯ OWNER ====================

// "[owner] hit [scr]!"
// "[RU_OWN_NOM] ударили [RU_TAR_ACC]!" - "Человек ударили обезъяну!"

#define RU_OWN(case) declent_ru(owner, case)
#define RU_OWN_NOM RU_OWN(NOMINATIVE)              // owner в именительном
#define RU_OWN_GEN RU_OWN(GENITIVE)                // owner в родительном
#define RU_OWN_DAT RU_OWN(DATIVE)                  // owner в дательном
#define RU_OWN_ACC RU_OWN(ACCUSATIVE)              // owner в винительном
#define RU_OWN_INS RU_OWN(INSTRUMENTAL)            // owner в творительном
#define RU_OWN_PRE RU_OWN(PREPOSITIONAL)           // owner в предложном
