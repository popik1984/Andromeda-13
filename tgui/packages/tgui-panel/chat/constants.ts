/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

export const MAX_VISIBLE_MESSAGES = 2500;
export const MAX_PERSISTED_MESSAGES = 1000;
export const MESSAGE_SAVE_INTERVAL = 10000;
export const MESSAGE_PRUNE_INTERVAL = 60000;
export const COMBINE_MAX_MESSAGES = 5;
export const COMBINE_MAX_TIME_WINDOW = 5000;
export const IMAGE_RETRY_DELAY = 250;
export const IMAGE_RETRY_LIMIT = 10;
export const IMAGE_RETRY_MESSAGE_AGE = 60000;

// Тип сообщения по умолчанию
export const MESSAGE_TYPE_UNKNOWN = 'unknown';

// Внутренний тип сообщения
export const MESSAGE_TYPE_INTERNAL = 'internal';

// Должны соответствовать дефайнам в code/__DEFINES/chat.dm
export const MESSAGE_TYPE_SYSTEM = 'system';
export const MESSAGE_TYPE_LOCALCHAT = 'localchat';
export const MESSAGE_TYPE_RADIO = 'radio';
export const MESSAGE_TYPE_ENTERTAINMENT = 'entertainment';
export const MESSAGE_TYPE_INFO = 'info';
export const MESSAGE_TYPE_WARNING = 'warning';
export const MESSAGE_TYPE_DEADCHAT = 'deadchat';
export const MESSAGE_TYPE_OOC = 'ooc';
export const MESSAGE_TYPE_ADMINPM = 'adminpm';
export const MESSAGE_TYPE_COMBAT = 'combat';
export const MESSAGE_TYPE_ADMINCHAT = 'adminchat';
export const MESSAGE_TYPE_MODCHAT = 'modchat';
export const MESSAGE_TYPE_PRAYER = 'prayer';
export const MESSAGE_TYPE_EVENTCHAT = 'eventchat';
export const MESSAGE_TYPE_ADMINLOG = 'adminlog';
export const MESSAGE_TYPE_ATTACKLOG = 'attacklog';
export const MESSAGE_TYPE_DEBUG = 'debug';

// Метаданные для каждого типа сообщений
export const MESSAGE_TYPES = [
  // Всегда включённые типы
  {
    type: MESSAGE_TYPE_SYSTEM,
    name: 'Системные сообщения',
    description: 'Сообщения от вашего клиента, всегда включены',
    selector: '.boldannounce',
    important: true,
  },
  // Основные типы
  {
    type: MESSAGE_TYPE_LOCALCHAT,
    name: 'Локальный чат',
    description: 'Внутриигровые локальные сообщения (сказать, эмоция и т.д.)',
    selector: '.say, .emote',
  },
  {
    type: MESSAGE_TYPE_RADIO,
    name: 'Радио',
    description: 'Все отделы радио сообщений',
    selector:
      '.alert, .minorannounce, .syndradio, .centcomradio, .aiprivradio, .comradio, .secradio, .gangradio, .engradio, .medradio, .sciradio, .suppradio, .servradio, .radio, .deptradio, .binarysay, .resonate, .abductor, .alien, .changeling',
  },
  {
    type: MESSAGE_TYPE_ENTERTAINMENT,
    name: 'Развлечения',
    description: 'Развлекательные трансляции и новости',
    selector: '.enteradio, .newscaster',
  },
  {
    type: MESSAGE_TYPE_INFO,
    name: 'Информация',
    description: 'Несрочные сообщения от игры и предметов',
    selector:
      '.notice:not(.pm), .adminnotice, .info, .sinister, .cult, .infoplain, .announce, .hear, .smallnotice, .holoparasite, .boldnotice',
  },
  {
    type: MESSAGE_TYPE_WARNING,
    name: 'Предупреждения',
    description: 'Срочные сообщения от игры и предметов',
    selector:
      '.warning:not(.pm), .critical, .userdanger, .italics, .alertsyndie, .warningplain',
  },
  {
    type: MESSAGE_TYPE_DEADCHAT,
    name: 'Призраки',
    description: 'Весь чат призраков',
    selector: '.deadsay, .ghostalert',
  },
  {
    type: MESSAGE_TYPE_OOC,
    name: 'OOC',
    description: 'Глобальные OOC сообщения',
    selector: '.ooc, .adminooc, .adminobserverooc, .oocplain',
  },
  {
    type: MESSAGE_TYPE_ADMINPM,
    name: 'Ахелп',
    description: 'Сообщения к/от администраторов (adminhelp)',
    selector: '.pm, .adminhelp',
  },
  {
    type: MESSAGE_TYPE_COMBAT,
    name: 'Бой',
    description: 'Урист МакТрейтор ударил вас ножом!',
    selector: '.danger',
  },
  {
    type: MESSAGE_TYPE_UNKNOWN,
    name: 'Несортированные',
    description: 'Всё, что не удалось отсортировать, всегда включено',
  },
  // Админские типы
  {
    type: MESSAGE_TYPE_ADMINCHAT,
    name: 'Администратор',
    description: 'Сообщения ASAY',
    selector: '.admin_channel, .adminsay',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_MODCHAT,
    name: 'Модератор',
    description: 'Сообщения MSAY',
    selector: '.mod_channel',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_PRAYER,
    name: 'Молитвы',
    description: 'Молитвы от игроков',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_ADMINLOG,
    name: 'Логи админа',
    description: 'АДМИН ЛОГ: Урист МакАдмин переместился к координатам X, Y, Z',
    selector: '.log_message',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_ATTACKLOG,
    name: 'Логи боя',
    description: 'Урист МакТрейтор выстрелил в Джона Доу',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_DEBUG,
    name: 'Отладочный логи',
    description: 'DEBUG: Подсистема SSPlanets Recover().',
    admin: true,
  },
];
