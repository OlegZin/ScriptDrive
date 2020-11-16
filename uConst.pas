unit uConst;

interface

uses SysUtils;

const
    FOLDER_DATA = 'DATA\';

    FILE_MENU_DATA = '\menu.dat';
    FILE_GAME_DATA = '\toto.dat';
    FILE_GAME_DATA_TEST = '\test_toto.txt';
    FILE_GAME_LOG = '\log.txt';

    STEPS_BY_FLOOR = 5; /// констранта для вычисления количества шагов.
                        /// умножается на номер текущего этажа

    MONSTER_IMAGE_COUNT = 30;

    /// синонимы имен предметов для единообразия упоминания,
    /// поскольку имена регистрочувствительны в json
    ITEM_GOLD = 'gold';
    ITEM_SPEED_BUFF = 'buffSPEED';

    /// синонимы имен
    /// поскольку имена регистрочувствительны в json


    /// синонимы параметров
    PRM_NEEDEXP = 'needexp';

    /// флаги частей интерфейса
    INT_MAIN  = 1;
    INT_LOG   = 2;
    INT_TOWER = 4;
    INT_THINK = 8;
    INT_FLOOR = 16;
    INT_ALL   = MaxInt;

    CREATURE_SHABLON = '{'+
        'name: {RU:"", ENG:""},'+
        'params: {LVL:1, HP:0, MP:0, ATK:0, DEF:0, MDEF:0, BODY:0},'+
        'skills: {},'+
        'items: {},'+
        'effects: {},'+
        'loot: {},'+
        'events: {'+
            'OnAttack:"",'+
            'onParamChange:"",'+
            'onDeath:"",'+
            'onRestore:"",'+
        '},'+
    '},';

    /// состояние меню при первом запуске
    MENU_DATA_DEF =
    '{gold:0, '+
     'Lang:ENG, '+
     'NewLevel:1, '+
     'IntroOver:0, '+
     'Skills: {'+
         'Research:     {Name:{ENG:"Research",RU:"Исследования"},Enabled:0, Level:0, NeedGold:10,  NeedResearch:1 },'+
         'MoneyEaring:  {Name:{ENG:"Money Earing",RU:"Доход"},Enabled:0, Level:1, NeedGold:20,  NeedResearch:5 },'+
         'BuildSpeed:   {Name:{ENG:"Build Speed",RU:"Строительство"},Enabled:0, Level:1, NeedGold:50,  NeedResearch:10},'+
         'AutoMoney:    {Name:{ENG:"Auto Money",RU:"Автодоход"},Enabled:0, Level:0, NeedGold:500, NeedResearch:15}'+
    '},'+
     'Objects: {'+
         'Logo:       {NeedResearch:3,  BuildCost:5,  Attempts:0, FullAttempts:10 },'+
         'MenuExit:   {Name:{ENG:"EXIT",RU:"ВЫХОД"}, '+
                      'NeedResearch:6,  BuildCost:10, Attempts:0, FullAttempts:20 },'+
         'MenuLang:   {Name:{ENG:"ЯЗЫК",RU:"LANGUAGE"},'+
                      'NeedResearch:9,  BuildCost:20, Attempts:0, FullAttempts:50 },'+
         'MenuResume: {Name:{ENG:"RESUME",RU:"ПРОДОЛЖИТЬ"},'+
                      'NeedResearch:11, BuildCost:30, Attempts:0, FullAttempts:100 },'+
         'MenuNew:    {Name:{ENG:"NEW GAME",RU:"НОВАЯ ИГРА"},'+
                      'NeedResearch:14, BuildCost:50, Attempts:0, FullAttempts:150 },'+
         'Tower1: {NeedResearch:17, BuildCost:100, Attempts:0, FullAttempts:100 },'+
         'Tower2: {NeedResearch:20, BuildCost:150, Attempts:0, FullAttempts:150 },'+
         'Tower3: {NeedResearch:23, BuildCost:200, Attempts:0, FullAttempts:200 },'+
         'Tower4: {NeedResearch:26, BuildCost:250, Attempts:0, FullAttempts:250 }'+
    '}}';

    GAME_DATA =
    '{'+
    'state: {'+
        'Lang:"ENG",'+
        'CurrStep: 1,'+
        'MaxStep: 1,'+
        'CurrFloor: 1,'+
        'CurrTargetFloor: 1,'+
        'CurrItem: "gold",'+
        'CurrThink: "",'+      /// мыслишка, на которую будут начисляться очки
        'CurrThinkKind: "",'+  /// если устанвлен, в интерфейс мыслей нужно вернуть список исследованных мыслей этого типа,
                               /// вместо текущей CurrBookThink
        'CurrBookThink: "",'+      /// исследованная мыслишка, данные которой показать в книге
        'thinks:{'+
//          'wakeup: 100,'+        /// совпадает с именем из объекта раздумий. наличие означает, что доступно для исследования
                                   /// количество - остаток до завершения. при нуле - отображается в дневнике
        '},'+
        'modes:{'+            /// флаги доступности различных игровых режмов
          'tower: {'+         /// режим башни
              'allow: true,'+ /// достпен ли режим
              'pool: 0,'+     /// сколько действий в локальном пуле
              'auto: false,'+ /// включен ли режим автодействий за внешние очки действий
          '},'+
          'think: {'+         /// режим раздумий
              'allow: false,'+
              'pool: 0,'+
              'auto: false,'+
          '},'+
        '},'+
        'player: {'+
            'params: {AutoAction: 0, LVL:1, HP:100, MP:20, ATK:5, DEF:0, MDEF:0, BODY:1, MIND:1, ENERGY:1, TECH:1, EXP:0, needexp:0 },'+
            'skills: {},'+
            'items: {},'+    // инвентарь
            'effects: {},'+  // временные эффекты (бафы и дебафы)
            'loot: {},'+     // ресурсы
            'events: {'+
                'onAttack:"",'+  /// набор скриптов, которые будут отработаны на событие атаки игроком монстра в башне
                'onParamChange:"",'+
                'onDeath:"",'+
                'onRestore:"",'+
                'onLevelUp:"",'+
///                   'default:""'+  с крипт имеет имя и команды. имя используется для идентификации каким эффектом
///                                  эффектом он был повешен и при снятии эффекта можно было дропнуть и скрипт

            '},'+
        '},'+
        'creature: {'+
            'name: {RU:"", ENG:""},'+
            'params: {LVL:1, HP:0, MP:0, ATK:0, DEF:0, MDEF:0, BODY:0},'+
            'skills: {},'+
            'items: {},'+
            'effects: {},'+
            'loot: {},'+
            'events: {'+
                'OnAttack:"",'+
                'onParamChange:"",'+
                'onDeath:"",'+
                'onRestore:"",'+
                'onLevelUp:"",'+
            '},'+
        '},'+
        'items:{'+
            'gold:         { count: 0, cost:    0, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'restoreHealth:{ count: 0, cost:  100, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'restoreMana:  { count: 0, cost:  250, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'permanentATK: { count: 0, cost:  200, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'permanentDEF: { count: 0, cost:  200, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'PermanentMDEF:{ count: 0, cost:  200, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'exp:          { count: 0, cost:  150, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'regenHP:      { count: 0, cost:  300, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'regenMP:      { count: 0, cost:  500, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'buffATK:      { count: 0, cost:  100, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'buffDEF:      { count: 0, cost:  100, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'buffMDEF:     { count: 0, cost:  100, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'buffEXP:      { count: 0, cost:  100, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'buffREG:      { count: 0, cost:  100, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'autoAction:   { count: 0, cost: 1000, craft: {}, isCraftAllow: false, isUseAllow: true}'+
        '},'+
        'skills:{'+
            'healing:      {lvl: 0, cost: 10, isEnabled: true},'+
            'explosion:    {lvl: 0, cost: 50, isEnabled: true},'+
            'heroism:      {lvl: 0, cost: 20, isEnabled: true},'+
            'breakDEF:     {lvl: 0, cost: 15, isEnabled: true},'+
            'breakMDEF:    {lvl: 0, cost: 15, isEnabled: true},'+
            'breakATK:     {lvl: 0, cost: 30, isEnabled: true},'+
            'leakMP:       {lvl: 0, cost: 10, isEnabled: true},'+
            'vampireStrike:{lvl: 0, cost: 10, isEnabled: true},'+
            'metabolism:   {lvl: 0, cost: 10, isEnabled: true}'+
        '},'+
        'tools:{'+
            'shovel:       {isAllow: false,lvl: 1},'+
            'pick:         {isAllow: false,lvl: 1},'+
            'axe:          {isAllow: false,lvl: 1},'+
            'lockpick:     {isAllow: false,lvl: 1},'+
            'sword:        {isAllow: false,lvl: 0},'+
            'lifeAmulet:   {isAllow: false,lvl: 0},'+
            'timeSand:     {isAllow: false,lvl: 0},'+
            'leggings:     {isAllow: false,lvl: 0},'+
            'wisdom:       {isAllow: false,lvl: 1},'+
            'resist:       {isAllow: false,lvl: 0},'+
            'expStone:     {isAllow: false,lvl: 0}'+
        '},'+

        //// набор объектов на каждом этаже. заполняется при старте новой игры
        'floors:{'+
          '1:{'+                     // номер этажа
            'count:0,'+              // количество оставшихся на этаже объектов
            'loot: [],'+             // типы предметов из спарвочника items.
                                     // хранит все предметы, которые могут выпасть на этаже.
                                     // могут быть получены из скриптов универсальным методом GetFloorItem.
                                     // хранение отдельно позволяет не запиливать индивидуальные скрипты с конкретным дропом,
                                     // а так же, модифицировать их набор на лету.
                                     // последний объект на этаже дропает весь оставшийся лут.
            '1:{'+                   // id объекта на этаже
              'id: 1,'+              // сервисный повтор id
              'kind: "",'+           // тип объекта из floorObjects
              'params: {HP: 0},'+    // параметры. может быть такой же набор как у существа
                                     // поскольку может быть целью способностей и эффектов
              'script: "",'+         // персональный скрипт при уничтожении. если нет, будет отработан
                                     // дефолтный на основе типа
              'x: 0,'+               // положение объекта в интерфейсе этажа
              'y: 0,'+               // положение объекта в интерфейсе этажа
              'percent: 1,'+         // модификатор параметров объекта. значение от 1 и меньше
                                     // чем "дальше" объект от игрока в интерфейсе этажа
                                     // тем он меньше в масштабе и темнее в оераске.
                                     // данный мараметр отвечает за процент масштаба и затемнения.
            '},'+
          '},'+
        '},'+

        /// набор глобальных переменных, используемых в рамках скриптов на различные события.
        /// например, установленные переменные боя, перед вызовом события onAttack.
        /// так же здесь хранятся мусорные переменные из скриптов
        'vars:{'+
            'GAME_SPEED: 1000,'+  /// скорость игры. 1000 = 1 секунда на тик. минимум = 100
            'first_meet: 1,'+     /// сюжетная переменная первой встречи с Темным Мастером
            'ikki: 0,'+           /// сюжетная переменная общения с Икки
            'MaxFloor: 1,'+       /// максимально достигнутый этаж, чтобы отрабатывать скрипты на первое вхождение
            // переменне, инициализируемые перед вызоваом скриптов на onAttack
            'mc_DMG: 0,'+ // выкинутый монстром урон
            'mc_BLK: 0,'+ // вычисленная величина блока урона от игрока
            'mc_GEM: 0,'+ // количество полученных монстром кристаллов
            'pl_DMG: 0,'+ // вычисленный урон игрока по монстру
            'pl_BLK: 0,'+ // вычисленная величина блока урона от монстра
            'gm_RED: 0,'+ // количество выпавших из монстра красных кристаллов
            'gm_WHT: 0,'+ // количество выпавших из монстра белых кристаллов
            'gm_BLU: 0,'+ // количество выпавших из монстра синих кристаллов
            'gm_GRN: 0,'+ // количество выпавших из монстра зеленых кристаллов
            'gm_PRP: 0,'+ // количество выпавших из монстра фиолетовых кристаллов
            'gm_YLW: 0,'+ // количество выпавших из монстра желтых кристаллов

            // переменне, инициализируемые перед вызоваом скриптов на onParamChange
            'prm_Action: "",'+ // имя события в рамках которого изменилось. в данном случае "onAttack"
                               // может использоваться для отсечения изменений,
                               // например блочить урон от атаки, но получать от магии
            'prm_Name: "",'+   // имя изменяемого параметра, например HP
            'prm_Delta: 0,'+   //целая/дробная величина изменеия, может быть как в плюс, так и в минус
        '},'+
    '},'+



    /// rarity - редкость ресурса. чем меньше, тем реже встречается
    /// cost - стоимость единицы ресурса в золоте
    ///        считается по формуле: cost = FULL / rarity, где FULL = сумма rarity всех ресурсов
    'resRaritySumm: 50,'+
    'resources:{'+
        'wood:   {name:"wood",    caption:{RU:"Дерево",  ENG:"Wood"},    rarity: 10,  cost:  5},'+
        'stone:  {name:"stone",   caption:{RU:"Камень",  ENG:"Stone"},   rarity: 10,  cost:  5},'+
        'herbal: {name:"herbal",  caption:{RU:"Трава",   ENG:"Herbal"},  rarity:  8,  cost:  6},'+
        'wheat:  {name:"wheat",   caption:{RU:"Зерно",   ENG:"Wheat"},   rarity:  6,  cost:  8},'+
        'meat:   {name:"meat",    caption:{RU:"Мясо",    ENG:"Meat"},    rarity:  4,  cost: 13},'+
        'water:  {name:"water",   caption:{RU:"Вода",    ENG:"Water"},   rarity:  3,  cost: 17},'+
        'bone:   {name:"bone",    caption:{RU:"Кость",   ENG:"Bone"},    rarity:  3,  cost: 17},'+
        'skin:   {name:"skin",    caption:{RU:"Шкура",   ENG:"Skin"},    rarity:  3,  cost: 17},'+
        'ore:    {name:"ore",     caption:{RU:"Руда",    ENG:"Ore"},     rarity:  2,  cost: 25},'+
        'essence:{name:"essence", caption:{RU:"Эссенция",ENG:"Essence"}, rarity:  1,  cost: 50}'+
    '},'+

    /// набор возможных эффектов при разборе объекта на этаже
    /// каждый из объектов может иметь любую комбинацию данных эффектов
    'floorScripts:{'+
        /// особые эффекты
        'Diary:         "GetRandomPage();"'+        /// получение случайной еще неполученной страницы
        'Shovel:        "AllowTool(Shovel);",'+     /// получение артефакта эффективен на Ground объектах
        'Pick:          "AllowTool(Pick);",'+       /// получение артефакта эффективен на Ore объектах
        'Axe:           "AllowTool(Axe);",'+        /// получение артефакта эффективен на Wood объектах
        'Lockpick:      "AllowTool(Lockpick);",'+   /// получение артефакта эффективен на Lock объектах
        'TimeSand:      "AllowTool(TimeSand);",'+   /// получение артефакта
        'Leggings:      "AllowTool(Leggings);",'+   /// получение артефакта
        'LifeAmulet:    "AllowTool(LifeAmulet);",'+ /// получение артефакта
        'Searcher:      "AllowTool(Searcher);",'+   /// получение артефакта (+к количеству эффектов объекта)
        'Shard:         "ChangePlayerItemCount(shard, 1);"'+  /// получение осколка воспоминаний

        /// предметы и ресурсы
        'Cash:          "ChangePlayerItemCount(gold, Rand(CurrFloor() * 10000) + 1);",'+             /// чисто денежный дроп
        'WoodPack:      "ChangePlayerLootCount(wood, Rand(CurrFloor() * 10) + 10);"},'+              /// получение базового ресурса
        'StonePack:     "ChangePlayerLootCount(stone, Rand(CurrFloor() * 10) + 10);"},'+             /// получение базового ресурса
        'OrePack:       "ChangePlayerLootCount(ore, Rand(CurrFloor() * 5) + 5);"},'+                 /// получение базового ресурса
        'LootHugePack:  "ChangePlayerLootCount(GetRandResName(), Rand(CurrFloor() * 100) + 10);"},'+ /// большой пак одного типа ресурса
        'LootNormalPack:"ChangePlayerLootCount(GetRandResName(), Rand(CurrFloor() * 50) + 10);"},'+  /// средний пак одного типа ресурса
        'LootSmallPack: "ChangePlayerLootCount(GetRandResName(), Rand(CurrFloor() * 10) + 10);"},'+  /// малый пак одного типа ресурса
        'ItemHugePack:  "ChangePlayerLootCount(GetRandItemName(), Rand(CurrFloor() * 3) + 10);"},'+  /// большой пак одного типа расходных предметов
        'ItemNormalPack:"ChangePlayerLootCount(GetRandItemName(), Rand(CurrFloor() * 2) + 5);"},'+   /// средний пак одного типа расходных предметов
        'ItemSmallPack: "ChangePlayerLootCount(GetRandItemName(), Rand(CurrFloor() * 1) + 1);"},'+   /// малый пак одного типа расходных предметов

        /// отравление(постепенное снижение здоровья)
        'Spider:"'+
            'SetVar(val, Rand(100));'+  /// шанс на избегание эффекта

            'IF(GetVar(val) > (GetArtLvl(Leggings) * 3), 6);'+
            'SetPlayerAsTarget();' +
            'AddEffect(RegenPlayerHP, -Rand(CurrFloor() * 100));'+
            'If(GetLang() = RU, 1);'+
            'Log(danger,\"Ядовитый паук укусил тебя!\");'+
            'If(GetLang() = ENG, 1);'+
            'Log(danger,\"The poisonous spider bit you!\");'+

            'IF(GetVar(val) <= (GetArtLvl(leggings) * 3), 4);'+
            'If(GetLang() = RU, 1);'+
            'Log(good,\"Ядовитый паук пытался укусить, но Поножи спасли от яда!\");'+
            'If(GetLang() = ENG, 1);'+
            'Log(good,\"Poisonous spider tried to bite you but Leggings saved you from poison!\");'+
        '",'+

        /// травма - снижение на постоянку ключевого параметра
        'Trap:"'+
            'SetVar(case, Rand(3));'+
            'IF(GetVar(case) = 0, 1);'+
            'SetVar(param, ATK);'+
            'IF(GetVar(case) = 1, 1);'+
            'SetVar(param, DEF);'+
            'IF(GetVar(case) = 2, 1);'+
            'SetVar(param, MDEF);'+

            'SetVar(val, Rand(100));'+  /// шанс на избегание эффекта

            'IF(GetVar(val) > (GetArtLvl(Leggings) * 3), 5);'+
            'ChangePlayerParam(GetVar(param), -1);'+
            'If(GetLang() = RU, 1);'+
            'Log(danger,\"Ловушка нанесла травму!\");'+
            'If(GetLang() = ENG, 1);'+
            'Log(danger,\"The trap hurt!\");'+

            'IF(GetVar(val) <= (GetArtLvl(leggings)* 3), 4);'+
            'If(GetLang() = RU, 1);'+
            'Log(good,\"Ловушка сработала но эффект был заблокирован Поножами!\");'+
            'If(GetLang() = ENG, 1);'+
            'Log(good,\"The trap was triggered but the effect was blocked by Leggins!\");'+
        '",'+

        /// разовое ранение
        'Rat:"'+
            'SetVar(val, Rand(100));'+

            'IF(GetVar(val) > (GetArtLvl(leggings) * 3), 5);'+
            'ChangePlayerParam(HP, -Rand(CurrFloor() * 25) + 20);'+
            'If(GetLang() = RU, 1);'+
            'Log(danger,\"Из кучи мусора выскочила крыса и цапнула за ногу!\");'+
            'If(GetLang() = ENG, 1);'+
            'Log(danger,\"A rat jumped out of a heap of garbage and grabbed the leg!\");'+

            'IF(GetVar(val) <= (GetArtLvl(leggings) * 3), 4);'+
            'If(GetLang() = RU, 1);'+
            'Log(good,\"Из кучи мусора выскочила крыса но не смогла прокусить Поножи!\");'+
            'If(GetLang() = ENG, 1);'+
            'Log(good,\"A rat jumped out of a pile of garbage but could not bite through the Leggings!\");'+
        '",'+

        /// постепенное снижение маны
        'ManaLeak:"'+
            'SetVar(val, Rand(100));'+

            'IF(GetVar(val) > (GetArtLvl(leggings) * 3), 6);'+
            'SetPlayerAsTarget();' +
            'AddEffect(RegenPlayerMP, -Rand(CurrFloor() * 50));'+
            'If(GetLang() = RU, 1);'+
            'Log(danger,\"Раздался громкий щелчок и ты чувствуешь, как энергия покидает тело...\");'+
            'If(GetLang() = ENG, 1);'+
            'Log(danger,\"There was a loud click and you feel the energy leaving the body ...\");'+

            'IF(GetVar(val) <= (GetArtLvl(leggings) * 3), 4);'+
            'If(GetLang() = RU, 1);'+
            'Log(good,\"Ты вовремя замечаешь появившуюся странную искру и отпинываешь ее. Искра отскакивает от поножей и с громким щелчком исчезает...\");'+
            'If(GetLang() = ENG, 1);'+
            'Log(good,\"You notice the strange spark that appears in time and kick it off. The spark bounces off the leggings and disappears with a loud click ...\");'+
        '",'+

        /// перенос на случайный этаж на -5...+5 от текущего
        'Portal:"'+
            'If(GetLang() = RU, 1);'+
            'Log(danger,\"Внезапно открылся портал и затянул в себя...\");'+
            'If(GetLang() = ENG, 1);'+
            'Log(danger,\"Suddenly a portal opened and sucked in ...\");'+

            'IF((GetVar(val) - CurrFloor()) < 1, 1);'+
            'SetCurrFloor( CALC( CurrFloor() - (5 - Rand(11)) ) );'+/// смещение по этажам от -5 до +5
        '",'+
    '},'+

    'floorObjects:{'+
        /// шкафы
        ///  основной источник малых и средних пачек предметов.
        ///  могут попасться особые объекты
        'locker1: {name:"locker1", '+  /// имя по которому будем искать визуальный объект
            'tool:"Axe",'+
                /// инструмент, который повышает эффективность на взаимодействие с этим объектом
            'params:{HP:0, count:2},'+
                /// count - количество срабатываний эффектов, рандомно выбираемых из массива effects
            'effects:["Spider","Rat","Rat","WoodPack","ItemNormalPack","Portal","Trap"],'+
                /// все возможные для этого объекта эффекты. имена из объекта floorScripts
            'hpCalc:"Calc(Rand(CurrFloor() * 100) + 100)",'+
                /// скрипт для вычисления HP при создании объекта
        '},'+
        'locker2: {name:"locker2", '+
            'tool:"Axe",'+
            'hpCalc:"Calc(Rand(CurrFloor() * 100) + 100)",'+
            'params:{HP:0, count:1},'+
            'effects:["Spider","Rat","WoodPack","ItemNormalPack","Trap","ItemHugePack"],'+
        '},'+
        'locker3: {name:"locker3", '+
            'tool:"Axe",'+
            'hpCalc:"Calc(Rand(CurrFloor() * 100) + 100)",'+
            'params:{HP:0, count:1},'+
            'effects:["Spider","Rat","WoodPack","ItemNormalPack","Cash","Trap"],'+
        '},'+
        'locker4: {name:"locker4", '+
            'tool:"Axe",'+
            'hpCalc:"Calc(Rand(CurrFloor() * 100) + 100)",'+
            'params:{HP:0, count:1},'+
            'effects:["Spider","Rat","WoodPack","ItemHugePack"],'+
        '},'+
        'locker5: {name:"locker5", '+
            'tool:"Axe",'+
            'hpCalc:"Calc(Rand(CurrFloor() * 100) + 100)",'+
            'params:{HP:0, count:1},'+
            'effects:["Spider","Rat","WoodPack","ManaLeak","ItemSmallPack"],'+
        '},'+
        'locker6: {name:"locker6", '+
            'tool:"Axe",'+
            'hpCalc:"Calc(Rand(CurrFloor() * 100) + 100)",'+
            'params:{HP:0, count:1},'+
            'effects:["Spider","Rat","WoodPack","Portal","ItemSmallPack"],'+
        '},'+
        'locker7: {name:"locker7", '+    /// трюмо
            'tool:"Lockpick",'+
            'hpCalc:"Calc(Rand(CurrFloor() * 100) + 100)",'+
            'params:{HP:0, count:1},'+
            'effects:["Shard","Trap","Spider","Cash","ManaLeak","ItemSmallPack"],'+
        '},'+

        /// стандартная шкатулка
        'cassette: {name:"cassette", '+
            'tool:"Lockpick",'+
            'hpCalc:"Calc(Rand(CurrFloor() * 100) + 1000)",'+
            'params:{HP:0, count:1},'+
            'effects:["Cash","Shard","Trap","ManaLeak","ItemSmallPack","Portal"],'+
        '},'+

        /// сундуки. бОльшее количество активируемых эффектов, чем в шкафах
        'chest1: {name:"chest1", '+
            'tool:"Lockpick",'+
            'hpCalc:"Calc(Rand(CurrFloor() * 250) + 1000)",'+
            'params:{HP:0,count:3},'+
            'effects:["Trap","Spider","Portal","ItemNormalPack","ItemNormalPack","LootSmallPack","LootSmallPack"],'+
        '},'+
        'chest2: {name:"chest2", '+
            'tool:"Lockpick",'+
            'hpCalc:"Calc(Rand(CurrFloor() * 250) + 1000)",'+
            'params:{HP:0,count:1},'+
            'effects:[],'+
        '},'+
        'chest3: {name:"chest3", '+
            'tool:"Lockpick",'+
            'hpCalc:"Calc(Rand(CurrFloor() * 250) + 1000)",'+
            'params:{HP:0,count:1},'+
            'effects:[],'+
        '},'+


        ': {name:"", '+
            'tool:"",'+
            'hpCalc:"Calc(Rand(CurrFloor() * 250) + 1000)",'+
            'params:{HP:0,count:1},'+
            'effects:[],'+
        '},'+
    '},'+



    /// cost - стоимость покупки в золоте
    /// craft - набор ресурсов для крафта. случайно генерится при старте игры
    /// isCraftAllow - доступен ли для крафта
    /// isUseAllow - доступен ли для использования
    'itemsCount: 16,'+
    'items:{'+
        'gold:{'+
            'name:"gold",'+
            'caption: {RU:"Золото", ENG:"Gold"},'+
            'description:{'+
                'RU:"Полновесные золотые монеты. За 10 000 монет можно получить случайный предмет. Испытаем удачу?",'+
                'ENG:"Full-weight gold coins. For 10,000 coins, you can get a random item. Lets try our luck?"'+
            '},'+
            'script:"'+
                'SetPlayerAsTarget();' +

                'If(GetItemCount(gold) < 10000, 4);'+
                'If(GetLang() = RU, 1);'+
                'Log(normal,\"Требуется 10 000 ICON_GOLD\");'+
                'If(GetLang() = ENG, 1);'+
                'Log(normal,\"Need 10 000 ICON_GOLD\");'+

                'SilentChange();'+
                'ChangeItemCount(gold, 1);'+

                'If(GetItemCount(gold) > 9999, 3);'+
                'SilentChange();'+
                'ChangeItemCount(gold, -10000);'+
                'ChangeItemCount(GetRandItemName(), 1);'+
        '"},'+
        'restoreHealth:{'+
            'name:"restoreHealth",'+
            'caption: {RU:"Зелье здоровья", ENG:"Potion of health"},'+
            'description:{'+
                'RU:"Мгновенно добавляет здоровье. Количество случайно: от нуля до 100 умноженного на текущий уровень игрока.",'+
                'ENG:"Instantly adds health. The amount is random: from zero to 100 multiplied by the players current level."'+
            '},'+
            'script:"'+
                'SetPlayerAsTarget();' +
                'ChangeParam(HP,Rand(GetParam(LVL) * 100));'+
        '"},'+
        'restoreMana:{'+
            'name:"restoreMana",'+
            'caption: {RU:"Зелье маны", ENG:"Potion of mana"},'+
            'description:{'+
                'RU:"Мгновенно добавляет энергию. Количество случайно: от нуля до 50 умноженного на текущий уровень игрока.",'+
                'ENG:"Instantly adds energy. The amount is random: from zero to 50 multiplied by the players current level."'+
            '},'+
            'script:"'+
                'SetPlayerAsTarget();' +
                'ChangeParam(MP,Rand(GetParam(LVL) * 50));'+
        '"},'+
        'permanentATK:{'+
            'name:"permanentATK",'+
            'caption: {RU:"Зелье атаки", ENG:"Potion of attack"},'+
            'description:{'+
                'RU:"Повышает потенциал атаки. Постоянный эффект.",'+
                'ENG:"Increases attack potential. Permanent effect."'+
            '},'+
            'script:"'+
                'SetPlayerAsTarget();' +
                'ChangeParam(ATK,1);'+
        '"},'+
        'permanentDEF:{'+
            'name:"permanentDEF",'+
            'caption: {RU:"Зелье защиты", ENG:"Potion of defence"},'+
            'description:{'+
                'RU:"Повышает физическую защиту. Постоянный эффект.",'+
                'ENG:"Increases physical protection. Permanent effect."'+
            '},'+
            'script:"'+
                'SetPlayerAsTarget();' +
                'ChangeParam(DEF,1);'+
        '"},'+
        'permanentMDEF:{'+
            'name:"permanentMDEF",'+
            'caption: {RU:"Зелье магической защиты", ENG:"Potion of magic defence"},'+
            'description:{'+
                'RU:"Повышает защиту от энергитических воздействий. Постоянный эффект.",'+
                'ENG:"Increases protection against energetic influences. Permanent effect."'+
            '},'+
            'script:"'+
                'SetPlayerAsTarget();' +
                'ChangeParam(MDEF,1);'+
        '"},'+
        'potionexp:{'+
            'name:"potionexp",'+
            'caption: {RU:"Зелье опыта", ENG:"Potion of experience"},'+
            'description:{'+
                'RU:"Мгновенно дает бесплатный опыт. Количество от 0 до 100 умноженное на текущий уровень игрока.",'+
                'ENG:"Gives you a free experience instantly. A number between 0 and 100 multiplied by the players current level."'+
            '},'+
            'script:"'+
                'SetPlayerAsTarget();' +
                'ChangeParam(EXP,Rand(GetParam(LVL) * 100));'+
        '"},'+
        'regenHP:{'+
            'name:"regenHP",'+
            'caption: {RU:"Мазь здоровья", ENG:"Ointment of health"},'+
            'description:{'+
                'RU:"Постепенно восстанавливает здоровье. Потенциал восстановления от 0 до 500 умноженное на текущий уровень игрока.",'+
                'ENG:"Restores health over time. Recovery potential from 0 to 500 multiplied by the players current level."'+
            '},'+
            'script:"'+
                'SetPlayerAsTarget();' +
                'AddEffect(RegenPlayerHP, Rand(GetParam(LVL) * 500));'+
        '"},'+
        'regenMP:{'+
            'name:"regenMP",'+
            'caption: {RU:"Мазь энергии", ENG:"Ointment of mana"},'+
            'description:{'+
                'RU:"Постепенно восстанавливает энергию. Потенциал восстановления от 0 до 250 умноженное на текущий уровень игрока.",'+
                'ENG:"Restores energy over time. Recovery potential from 0 to 250 multiplied by the players current level."'+
            '},'+
            'script:"'+
                'SetPlayerAsTarget();' +
                'AddEffect(RegenPlayerMP, Rand(GetParam(LVL) * 250));'+
        '"},'+
        'buffATK:{'+
            'name:"buffATK",'+
            'caption: {RU:"Порошок атаки", ENG:"Powder of attack"},'+
            'description:{'+
                'RU:"Временно повышает потенциал атаки. Снижается после каждой атаки игрока. Эффект от 1 до 10 умноженное на текущий уровнь игрока.",'+
                'ENG:"Temporarily increases attack potential. Decreases after each player attack. Potential from 1 to 10 multiplied by the players current level."'+
            '},'+
            'script:"'+
                'SetPlayerAsTarget();'+
                'AddEffect(PlayerATKBuff, Rand(GetParam(LVL) * 10) + 1);'+
        '"},'+
        'buffDEF:{'+
            'name:"buffDEF",'+
            'caption: {RU:"Порошок защиты", ENG:"Powder of defence"},'+
            'description:{'+
                'RU:"Временно повышает потенциал защиты. Снижается после каждой атаки по игроку. Эффект от 1 до 10 умноженное на текущий уровнь игрока.",'+
                'ENG:"Temporarily increases attack potential. Decreases after each attack on the player. Potential from 1 to 10 multiplied by the players current level."'+
            '},'+
            'script:"'+
                'SetPlayerAsTarget();'+
                'AddEffect(PlayerDEFBuff, Rand(GetParam(LVL) * 10) + 1);'+
        '"},'+
        'buffMDEF:{'+
            'name:"buffMDEF",'+
            'caption: {RU:"Порошок магической защиты", ENG:"Powder of magic defence"},'+
            'description:{'+
                'RU:"Временно повышает потенциал магической защиты. Снижается после каждого магического или энергетического воздействия на игрока. Эффект от 1 до 10 умноженного на текущий уровнь игрока.",'+
                'ENG:"Temporarily increases the potential of magic protection. Decreases after each magical or energy impact on the player. Potential from 1 to 10 multiplied by the players level."'+
            '},'+
            'script:"'+
                'SetPlayerAsTarget();'+
                'AddEffect(PlayerMDEFBuff, Rand(GetParam(LVL) * 10) + 1);'+
        '"},'+
        'buffEXP:{'+
            'name:"buffEXP",'+
            'caption: {RU:"Порошок опыта", ENG:"Powder of experience"},'+
            'description:{'+
                'RU:"Временно повышает потенциал получения опыта. Эффект от 1 до 5 умноженного на текущий уровнь игрока.",'+
                'ENG:"Temporarily increases the potential for gaining experience. Potential from 1 to 5 multiplied by the players current level."'+
            '},'+
            'script:"'+
                'SetPlayerAsTarget();'+
                'AddEffect(PlayerEXPBuff, Rand(GetParam(LVL) * 5) + 1);'+
        '"},'+
        'buffREG:{'+
            'name:"buffREG",'+
            'caption: {RU:"Зелье регенерации", ENG:"Potion of regeneration"},'+
            'description:{'+
                'RU:"Временно повышает силу эффекта регенерации. Снижается после каждой регенерации. Эффект от 1 до 10 умноженного на текущий уровень игрока.",'+
                'ENG:"Temporarily increases the strength of the regeneration effect. Potential ftom 10 to 10 multiplied by the players current level."'+
            '},'+
            'script:"'+
                'SetPlayerAsTarget();'+
                'AddEffect(PlayerREGBuff, Rand(GetParam(LVL) * 10) + 10);'+
        '"},'+
        'buffSPEED:{'+
            'name:"buffSPEED",'+
            'caption: {RU:"Билет времени", ENG:"Ticket of Time"},'+
            'description:{'+
                'RU:"Временно повышает скорость времени. Эффект 100 + 10 * уровень игрока.",'+
                'ENG:"Temporarily increases the speed of time. The duration depends on the current level of the player."'+
            '},'+
            'script:"'+
                'SetPlayerAsTarget();'+
                'AddEffect(BuffSPEED, GetParam(LVL) * 10 + 100);'+
        '"},'+
        'potionAuto:{'+
            'name:"potionAuto",'+
            'caption: {RU:"Зелье автодействий", ENG:"Potion of autoactions"},'+
            'description:{'+
                'RU:"Добавляет автодействия. Эффект от 500 до 1000.",'+
                'ENG:"Adds auto-actions. The effect is from 500 to 1000."'+
            '},'+
            'script:"'+
                'SetPlayerAsTarget();' +
                'ChangeParam(AutoAction,Rand(500) + 500);'+
        '"}'+
    '},'+


    /// cost - стоимость активации в мане за уровень скила
    /// lvl - стоимость активации в мане за уровень скила
    /// isActivated - активируемый или пассивный навык
    /// isEnabled - доступен ли для использования (будет ли отображаться в списке доступных)
    'skills:{'+
        'healing:{'+
            'caption:{RU:"Лечение",ENG:"Healing"},isActivated: true, '+
            'description:{'+
                'RU:"Восстанавливает здоровье цели. Эффект от 0 до 50 умноженное на уровень навыка. Стоимость 20 маны на уровень навыка.",'+
                'ENG:"Restores the targets health. The effect is from 0 to 50 multiplied by the skill level. Cost 20 mana per skill level."'+
            '},'+
            'script:"'+
                'SetVar(IncHP,Rand(GetSkillLvl(healing) * 50));'+
                'ChangeTargetParam(HP,GetVar(IncHP));'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(Тarget gets GetVar(IncHP) health);'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(Цель получет GetVar(IncHP) здоровья);'+
        '"},'+
        'explosion:{'+
            'caption:{RU:"Взрыв",ENG:"Explosion"},isActivated: true, '+
            'description:{'+
                'RU:"Наносит цели магический урон. Эффект от 0 до 300 умноженное на уровень навыка. Стоимость 50 маны на уровень навыка.",'+
                'ENG:"Deals magic damage to the target. The effect is from 0 to 300 multiplied by the skill level. Cost 50 mana per skill level."'+
            '},'+
            'script:"'+
                'SetVar(Expl,Rand(GetSkillLvl(explosion) * 300));'+
                'ChangeTargetParam(HP,-GetVar(Expl));'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(Target take GetVar(Expl) damage!);'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(Цель получет GetVar(Expl) урона!);'+
        '"},'+
        'heroism:{'+
            'caption:{RU:"Героизм",ENG:"Heroism"},isActivated: true, '+
            'description:{'+
                'RU:"Временно повышает параметры цели: атаку, защиту и магическую защиту. Эффект от 0 до 5 умноженное на уровень навыка. Стоимость 20 маны на уровень навыка.",'+
                'ENG:"Temporarily increases the parameters of the target: attack, defence and magic defence. The effect is from 0 to 5 multiplied by the skill level. Cost 20 mana per skill level."'+
            '},'+
            'script:"'+
                'SetVar(value,Rand(GetSkillLvl(heroism) * 5));'+
                'SetTargetBuff(ATK,GetVar(value));'+
                'SetTargetBuff(DEF,GetVar(value));'+
                'SetTargetBuff(MDEF,GetVar(value));'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(Target has received an attack and defence boost of GetVar(value));'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(Цель получила усиление атаки и защиты на GetVar(value));'+
        '"},'+
        'breakDEF:{'+
            'caption:{RU:"Пробитие защиты",ENG:"Defence break"},isActivated: true, '+
            'description:{'+
                'RU:"Снижает значение защиты цели. Эффект от 0 до 10 умноженное на уровень навыка. Стоимость 15 маны на уровень навыка.",'+
                'ENG:"Reduces the value of target defence. The effect is from 0 to 10 multiplied by the skill level. Cost 15 mana per skill level."'+
            '},'+
            'script:"'+
                'SetVar(value,Rand(GetSkillLvl(breakDEF) * 10));'+
                'ChangeTargetParam(DEF,-GetVar(value));'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(Target defense reduced by GetVar(value));'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(Защита цели снижена на GetVar(value));'+
        '"},'+
        'breakMDEF:{'+
            'caption:{RU:"Пробитие магической защиты",ENG:"Magic defence break"},isActivated: true, '+
            'description:{'+
                'RU:"Снижает значение магической защиты цели. Эффект от 0 до 10 умноженное на уровень навыка. Стоимость 15 маны на уровень навыка.",'+
                'ENG:"Reduces the value of target magic defence. The effect is from 0 to 10 multiplied by the skill level. Cost 15 mana per skill level."'+
            '},'+
            'script:"'+
                'SetVar(value,Rand(GetSkillLvl(breakMDEF) * 10));'+
                'ChangeTargetParam(MDEF,-GetVar(value));'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(Target magic defense reduced by GetVar(value));'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(Магическая защита цели снижена на GetVar(value));'+
        '"},'+
        'breakATK:{'+
            'caption:{RU:"Травма",ENG:"Injury"},isActivated: true, '+
            'description:{'+
                'RU:"Снижает атаку цели. Эффект от 0 до 5 умноженное на уровень навыка. Стоимость 30 маны на уровень навыка.",'+
                'ENG:"Reduces target attack. The effect is from 0 to 5 multiplied by the skill level. Cost of 30 mana per skill level."'+
            '},'+
            'script:"'+
                'SetVar(value,Rand(GetSkillLvl(breakATK) * 5));'+
                'ChangeTargetParam(ATK,-GetVar(value));'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(Target attack reduced by GetVar(value));'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(Атака цели снижена на GetVar(value));'+
        '"},'+
        'leakMP:{'+
            'caption:{RU:"Утечка маны",ENG:"Mana leak"},isActivated: true, '+
            'description:{'+
                'RU:"Забирает у цели ману, но не больше имеющегося количества. Игрок получает половину этого количества. Эффект от 0 до 30 умноженное на уровень навыка. Стоимость 10 маны за уровень.",'+
                'ENG:"It takes away mana from the target, but not more than the available amount. The player receives half of this amount. The effect is from 0 to 30 multiplied by the skill level. Cost 10 mana per level."'+
            '},'+
            'script:"'+
                'SetVar(leak,Rand(GetSkillLvl(leakMP) * 30));'+  // сколько пытается забрать навык
                'SetVar(monsterMP,GetTargetAttr(MP));'+           // сколько есть у монстра

                'IF(GetVar(leak) >= GetVar(monsterMP), 3);'+        // если забираем больше, чем есть
                'SetVar(leak, GetVar(monsterMP) / 2);'+          // получаемое игроком = половина от возможного
                'ChangeTargetParam(MP,-GetVar(monsterMP));'+     // забираем у монстра все
                'ChangePlayerParam(MP,GetVar(leak));'+             // игрок получает свое

                'IF(GetVar(leak) < GetVar(monsterMP), 4);'+        // если забираем меньше чем есть
                'SetVar(monsterMP, GetVar(leak));'+                // монстр будет терять в полном объеме
                'SetVar(leak, GetVar(leak) / 2);'+               // игрок получит половину от требуемого
                'ChangeTargetParam(MP,-GetVar(monsterMP));'+     // монстр теряет
                'ChangePlayerParam(MP,GetVar(leak));'+             // игрок получает

                'If(GetLang() = ENG, 2);'+
                'AddEvent(Target lost GetVar(monsterMP) mana);'+   // радуем игрока
                'AddEvent(Player got GetVar(leak) mana);'+
                'If(GetLang() = RU, 2);'+
                'AddEvent(Цель потеряла GetVar(monsterMP) маны);'+   // радуем игрока
                'AddEvent(Игрок получил GetVar(leak) маны);'+
        '"},'+
        'vampireStrike:{'+
            'caption:{RU:"Удар вампира",ENG:"Strike if vampire"},isActivated: true, '+
            'description:{'+
                'RU:"Забирает у цели здоровье, но не больше имеющегося количества. Игрок получает половину этого количества. Эффект от 0 до 20 умноженное на уровень навыка. Стоимость 10 маны за уровень.",'+
                'ENG:"It takes away health from the target, but not more than the available amount. The player receives half of this amount. The effect is from 0 to 20 multiplied by the skill level. Cost 10 mana per level."'+
            '},'+
            'script:"'+
                'SetVar(leak,Rand(GetSkillLvl(vampireStrike) * 20));'+  // сколько пытается забрать навык
                'SetVar(monsterHP,GetTargetAttr(HP));'+           // сколько есть у монстра

                'IF(GetVar(leak) >= GetVar(monsterHP), 3);'+        // если забираем больше, чем есть
                'SetVar(leak, GetVar(monsterHP) / 2);'+          // получаемое игроком = половина от возможного
                'ChangeTargetParam(HP,-GetVar(monsterHP));'+     // забираем у монстра все
                'ChangePlayerParam(HP,GetVar(leak));'+             // игрок получает свое

                'IF(GetVar(leak) < GetVar(monsterHP), 4);'+        // если забираем меньше чем есть
                'SetVar(monsterHP, GetVar(leak));'+                // монстр будет терять в полном объеме
                'SetVar(leak, GetVar(leak) / 2);'+               // игрок получит половину от требуемого
                'ChangeTargetParam(HP,-GetVar(monsterHP));'+     // монстр теряет
                'ChangePlayerParam(HP,GetVar(leak));'+             // игрок получает

                'If(GetLang() = ENG, 2);'+
                'AddEvent(Target lost GetVar(monsterHP) health);'+   // радуем игрока
                'AddEvent(Player got GetVar(leak) health);'+
                'If(GetLang() = RU, 2);'+
                'AddEvent(Цель потеряла GetVar(monsterHP) здоровья);'+   // радуем игрока
                'AddEvent(Игрок получил GetVar(leak) здоровья);'+
        '"},'+
        'metabolism:{'+
            'caption:{RU:"Метаболизм",ENG:"Metabolism"},isActivated: true, '+
            'description:{'+
                'RU:"Временно повышает силу эффекта регенерации. Эффект от 0 до 5 умноженное на уровень навыка. Стоимость 10 маны на уровень.",'+
                'ENG:"Temporarily increases the strength of the regeneration effect. The effect is from 0 to 5 multiplied by the skill level. Cost 10 mana per level."'+
            '},'+
            'script:"'+
                'SetVar(value,Rand(GetSkillLvl(metabolism) * 5) + 10);'+
                'SetTargetBuff(BODY,GetVar(value));'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(Target speed up regeneration by GetVar(value));'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(Регенерация цели увеличена на GetVar(value));'+
        '"}'+
    '},'+



    /// временные эффекты, которые могут быть наложены на цель (игрока, монстра,...)
    ///    каждый эффект имеет одноименную переменную в общем пуле и может иметь два скрипта
    ///    auto - вызывается методом CheckStatus для каждого активного эффекта (state.player.effects)
    ///           и позволяет реализовать эффекты по таймеру. например, постепенная регенерация энергии или хитов
    ///    use - срабатывает каждый раз, когда обращаются к значению переменной через GetEffect,
    ///          при этом используется автоматическая переменная LastValue,
    ///          чтобы не входить в бесконечную рекурсию запрашивая текущее значение через GetEffect
    'effects:{'+
        'playerregbuff:{'+
            'name:"playerregbuff",'+
            'script:{'+
                'auto:"",'+
                'use:"'+
                    'IF(GetVar(LastValue) > 1, 1);'+                                /// если висит бафф на величину регена
                        'ChangeEffect(PlayerREGBuff, -1);'+                       /// уменьшаем эффективность регена
                    'IF(GetVar(LastValue) <= 1, 1);'+                               /// если реген нулевой
                        'RemoveEffect(PlayerREGBuff);'+                         /// снимаем эффект
                '",'+
            '},'+
        '},'+

        'playerexpbuff:{'+
            'name:"playerexpbuff",'+
            'script:{'+
                'auto:"",'+
                'use:"'+
                    'IF(GetVar(LastValue) > 1, 1);'+                                /// если висит бафф на величину регена
                        'ChangeEffect(PlayerEXPBuff, -1);'+                       /// уменьшаем эффективность регена
                    'IF(GetVar(LastValue) <= 1, 1);'+                               /// если реген нулевой
                        'RemoveEffect(PlayerEXPBuff);'+                         /// снимаем эффект
                '",'+
            '},'+
        '},'+

        'playermdefbuff:{'+
            'name:"playermdefbuff",'+
            'script:{'+
                'auto:"",'+
                'use:"'+
                    'IF(GetVar(LastValue) > 1, 1);'+                               /// если висит бафф на величину регена
                        'ChangeEffect(PlayerMDEFBuff, -1);'+                      /// уменьшаем эффективность регена
                    'IF(GetVar(LastValue) <= 1, 1);'+                              /// если реген нулевой
                        'RemoveEffect(PlayerMDEFBuff);'+                        /// снимаем эффект
                '",'+
            '},'+
        '},'+

        'playerdefbuff:{'+
            'name:"playerdefbuff",'+
            'script:{'+
                'auto:"",'+
                'use:"'+
                    'IF(GetVar(LastValue) > 1, 1);'+                                /// если висит бафф на величину регена
                        'ChangeEffect(PlayerDEFBuff, -1);'+                       /// уменьшаем эффективность регена
                    'IF(GetVar(LastValue) <= 1, 1);'+                               /// если реген нулевой
                        'RemoveEffect(PlayerDEFBuff);'+                         /// снимаем эффект
                '",'+
            '},'+
        '},'+

        'playeratkbuff:{'+
            'name:"playeratkbuff",'+
            'script:{'+
                'auto:"",'+
                'use:"'+
                    'IF(GetVar(LastValue) > 1, 1);'+                                /// если висит бафф на величину регена
                        'ChangeEffect(PlayerATKBuff, -1);'+                       /// уменьшаем эффективность регена
                    'IF(GetVar(LastValue) <= 1, 1);'+                               /// если реген нулевой
                        'RemoveEffect(PlayerATKBuff);'+                         /// снимаем эффект
                '",'+
            '},'+
        '},'+

        'regenplayerhp:{'+
            'name:"regenplayerhp",'+
            'script:{'+
                'auto:"'+
                    'SetPlayerAsTarget();'+                                     /// целимся в игрока
                    'SetVar(tmp, GetEffect(PlayerREGBuff));'+               /// получаем текущий баф на реген, что атоматом снижает его на 1. потому, делаем это только один раз
                    'IF(GetEffect(RegenPlayerHP) > 0, 3);'+                     /// если величина остатака регенерации не нулевая
                        'SilentChange();'+
                        'ChangeParam(HP, GetParam(BODY) + GetVar(tmp));'+                /// перекачиваем в здоровье с учетом возможного бафа на реген
                        'ChangeEffect(RegenPlayerHP, -GetParam(BODY) - GetVar(tmp));'+    /// списываем с пула регена здоровья
                    'IF(GetEffect(RegenPlayerHP) <= 0, 1);'+                    /// если величина остатака регенерации нулевая
                        'RemoveEffect(RegenPlayerHP);'+                         /// снимаем эффект
                '",'+
                'use:"",'+
            '},'+
        '},'+

        'regenplayermp:{'+
            'name:"regenplayermp",'+
            'script:{'+
                'auto:"'+
                    'SetPlayerAsTarget();'+                                     /// целимся в игрока
                    'SetVar(tmp, GetEffect(PlayerREGBuff));'+               /// получаем текущий баф на реген, что атоматом снижает его на 1. потому, делаем это только один раз
                    'IF(GetEffect(RegenPlayerMP) > 0, 3);'+                     /// если величина остатака регенерации не нулевая
                        'SilentChange();'+
                        'ChangeParam(MP, GetParam(MIND) + GetVar(tmp));'+                /// перекачиваем в энергию с учетом возможного бафа на реген
                        'ChangeEffect(RegenPlayerMP, -GetParam(MIND) - GetVar(tmp));'+    /// списываем с пула регена энергии
                    'IF(GetEffect(RegenPlayerMP) <= 0, 1);'+                    /// если величина остатака регенерации нулевая
                        'RemoveEffect(RegenPlayerMP);'+                         /// снимаем эффект
                    '",'+
                'use:"",'+
            '},'+
        '},'+

        'buffspeed:{'+
            'name:"buffspeed",'+
            'script:{'+
                'auto:"'+
                    'SetPlayerAsTarget();'+
                    'IF(GetEffect(buffspeed) > 0, 2);'+
                        'ChangeEffect(buffspeed, -1);'+
                        'SetVar(GAME_SPEED,100);'+
                    'IF(GetEffect(buffspeed) <= 0, 2);'+
                        'SetVar(GAME_SPEED,1000);'+
                        'RemoveEffect(buffspeed);'+
                    '",'+
                'use:"'+
                '",'+
            '},'+
        '},'+

    '},'+



    /// isAllow - доступен ли для использования
    /// lvl - текущий уровень инструмента
    'tools:{'+
        'shovel:{'+
            'caption: {RU:"Лопата",ENG:"Shovel"},'+
            'desc: {RU:"Позволяет быстрее разгребать мусор",ENG:"Allows you to clear trash faster."},'+
            'script: "SetVar(SHOVEL_LVL, GetVar(SHOVEL_LVL) + 1);"'+
        '},'+
        'pick:{'+
            'caption: {RU:"Кирка",ENG:"Pick"},'+
            'desc: {RU:"Позволяет быстрее разбирать завалы.",ENG:"Allows you to quickly disassemble blockage."},'+
            'script: "SetVar(PICK_LVL, GetVar(PICK_LVL) + 1);"'+
        '},'+
        'axe:{'+
            'caption: {RU:"Топор",ENG:"Axe"},'+
            'desc: {RU:"Позволяет быстрее разбивать ящики.",ENG:"Allows you to break boxes faster."},'+
            'script: "SetVar(AXE_LVL, GetVar(AXE_LVL) + 1);"'+
        '},'+
        'lockpick:{'+
            'caption: {RU:"Отмычка",ENG:"Lockpick"},'+
            'desc: {RU:"Позволяет быстрее открывать сундуки.",ENG:"Allows you to open chests faster."},'+
            'script: "SetVar(KEY_LVL, GetVar(KEY_LVL) + 1);"'+
        '},'+
        'sword:{'+
            'caption: {RU:"Меч",ENG:"Sword"},'+
            'desc: {RU:"Увеличивает минимальный урон но не выше текущей атаки.",ENG:"Increases minimum damage but not higher than the current attack."},'+
            'script: "SetVar(SWORD_LVL, GetVar(SWORD_LVL) + 1);"'+
        '},'+
        'lifeAmulet:{'+
            'caption: {RU:"Амулет Здоровья",ENG:"Amulet of Health"},'+
            'desc: {RU:"При возрождении добавляет +100 здоровья за уровень.",ENG:"Adds +100 HP per level upon respawn."},'+
            'script: "SetVar(LIFEAMULET_LVL, GetVar(LIFEAMULET_LVL) + 1);"'+
        '},'+
        'timeSand:{'+
            'caption: {RU:"Пески Времени",ENG:"Sand of Time"},'+
            'desc: {RU:"Ускоряет Автодействия на 3% за уровень.",ENG:"Speeds up Auto Actions by 3% per level."},'+
            'script: "SetVar(TIMESAND_LVL, [GetVar(TIMESAND_LVL) + 3]);"'+
        '},'+
        'leggings:{'+
            'caption: {RU:"Поножи",ENG:"Leggings"},'+
            'desc: {RU:"Увеличивает шанс избежать эффекта ловушек крыс пауков и т.д. на 3% за уровень.",ENG:"Increases the chance to avoid the effect of traps rats spiders etc. 3% per level."},'+
            'script: "SetVar(LEGGINGS_LVL, GetVar(LEGGINGS_LVL) + 3);"'+
        '},'+
        'wisdom:{'+
            'caption: {RU:"Обруч Мудрости",ENG:"Circle of Wisdom"},'+
            'desc: {RU:"Проясняет мысли и позволяет быстрее находить новые идеи.",ENG:"Clarifies thoughts and allows you to find new ideas faster."},'+
            'script: "SetVar(WISDOM_LVL, GetVar(WISDOM_LVL) + 1);"'+
        '},'+
        'resist:{'+
            'caption: {RU:"Кольцо сопротивления",ENG:"Ring of resistance"},'+
            'desc: {RU:"Увеличивает на 2% за уровень шанс заблокировать эффекты, снижающие параметры персонажа.",ENG:"Increases by 2% per level the chance to block effects that reduce character parameters."},'+
            'script: "SetVar(RESIST_LVL, GetVar(RESIST_LVL) + 2);"'+
        '},'+
        'expStone:{'+
            'caption: {RU:"Камень опыта",ENG:"Experience stone"},'+
            'desc: {RU:"На 1 за уровень увеличивает получаемый опыт.",ENG:"Increases experience gained by 1 per level."},'+
            'script: "SetVar(EXP_LVL, GetVar(EXP_LVL) + 2);"'+
        '}'+
    '},'+


    /// размышлялки
    'thinks:{'+
      'defaultbody:{ENG:"You don''t have any diary entries yet...", RU:"В вашем дневнике пока нет записей..."},'+
      'wakeup:{'+
        'name: "wakeup",'+         /// уникальный идентификатор
        'parent: "",'+             /// идентификатор мысли при завершении которой открывается доступ к этой
        'cost: 10,'+              /// сколько очков обдумывания для получения статуса redy
        'kind: "tower",'+          /// за оформление карточки и раздел в дневнике, где будет отображаться
        'script:"'+                /// скрипт выполняемый на момент завершения обдымывания
          'SetPlayerAsTarget();'+
          'ChangeParam(EXP, 10);'+

          'AllowThink(tower);'+
          'AllowThink(monsters);'+
          'AllowThink(whoami);'+
        '",'+
        'caption:{'+               /// текст для отображения на карточке
          'ENG:"Where i am?",'+
          'RU:"Где я?"},'+
        'body:{'+                  /// текст (возможен html) для отображения в дневнике
          'ENG:"'+
            '<p>Not much time has passed since waking up in this terrible place. '+
               'It is frightening and ridiculous that I do not remember anything about myself at all! '+
               'This Tower, a strange note, cramped floors packed with monsters, some ridiculous Dark Master ...</p>'+
            '<p>My head is spinning from all this. And also from the fact that from the moment I woke up I was tormented by a wild headache.</p>'+
            '<p>However, despite all this, there are pleasant little things. I don’t know how and why, but I can imagine quite well how to fight with melee weapons. '+
               'At the moment of the first inspiration, there was no time to be surprised that this thin graceful dagger, '+
               'which I have in my hands, appeared practically out of thin air! '+
               'And how clever and convenient it is for them to chop and stab, as if I had been doing this for more than one year.</p>'+
            '<p>But the feeling that a different kind of weapon is closer to me does not leave me ... '+
               'My hands remember something more weighty and much more deadly ... And it certainly was not a sword or a bow ... '+
               'When trying to remember the pain in my head begins to throb and squeeze consciousness into nothingness.</p>'+
          '",'+
          'RU:"'+
            '<p>Совсем немного времени прошло с момента пробуждения в этом ужасном месте. Пугающе и нелепо, что я соврешенно ничего не помню о себе! '+
               'Эта Башня, странная записка, тесные этажи забитые монстрами, какой-то нелепый Темный Мастер... </p>'+
            '<p>Голова идет кругом от всего этого. И еще от того, что с момента пробуждения меня мучает дикая головная боль.</p>'+
            '<p>Однако, не смотря на все это, есть приятные мелочи. Не знаю как и почему, но я вполне сносно представляю как драться холодным оружием. '+
               'В момент первого наподения не было времени удивляться тому, что этот тонкий изящный кинжал, '+
               'который у меня в руках, появился практически из воздуха! И как же ловко и удобно им рубить и колоть, словно я занимался этим уже не один год.</p>'+
            '<p>Но меня не покидает ощущение, что мне ближе оружие иного рода... Руки помнят что-то более увесистое и гораздо более смертоносное... '+
               'И это точно не было мечом или луком... При попытках вспомнить боль в голове начинает пульсировать и выдавливать сознание в небытие.</p>'+
        '"},'+
      '},'+

      'darkmaster:{name: "darkmaster", cost: 200, kind: "tower",'+
        'script:"'+
          'SetPlayerAsTarget();'+
          'ChangeParam(EXP, 50);'+
        '",'+
        'caption:{'+
          'ENG:"The Dark Master? Seriously?!..",'+
          'RU:"Темный Мастер? Серьезно?!..."},'+
        'body:{'+
          'ENG:"'+
            '<p>What was it? I met some incredibly powerful magician, or whatever he is. Before I had time to look back, he literally destroyed me with several blows. I woke up already in the basement. I don''t know how long I lay unconscious.</p>'+
            '<p>If this is exactly the person mentioned in the note, he really should be feared and avoided. But how? I''m afraid a new meeting is inevitable ...</p>'+
          '",'+
          'RU:"'+
            '<p>Что это было? Я встретил какого-то невероятно мощного мага, или кто он там.  Оглянуться не успел, как буквально уничтожил меня несколькими ударами. '+
               'Очнулся я уже в подвале. Не знаю, сколько пролежал без сознания.</p>'+
            '<p>Если это именно тот, о ком говорилось в записке, его действительно стоит опасаться и избегать встреч. Но как? Боюсь, новая встреча неизбежна...</p>'+
          '"},'+
      '},'+

      'tower:{name: "tower", cost: 200, kind: "tower", parent: "",'+
        'script:"'+
          'SetPlayerAsTarget();'+
          'ChangeParam(EXP, 50);'+
          'AllowThink(floors);'+
        '",'+
        'caption:{'+
          'ENG:"The Tower?",'+
          'RU:"Башня?"},'+
        'body:{'+
          'ENG:"'+
            '<p>The floors of this Tower (?) Are similar to each other, but the higher, the larger they are. It feels like this strange tower is like a pyramid standing on top.</p>'+
            '<p>Who would think of building something like this? Perhaps this is a false impression.</p>'+
          '",'+
          'RU:"'+
            '<p>Этажи этой Башни(?) похожи друг на друга, но чем выше, тем они обширнее. Ощущение, что эта странная башня похожа на стоящую на вершине пирамиду.</p>'+
            '<p>Кому в голову придет строить нечто подобное? Возможнро, это ложное впечатление.</p>'+
          '"},'+
      '},'+

          'floors:{name: "floors", cost: 200, kind: "tower",'+
            'script:"'+
              'SetPlayerAsTarget();'+
              'ChangeParam(EXP, 50);'+
              'AllowMode(Floors);'+
            '",'+
            'caption:{'+
              'ENG:"Floors, endless floors...",'+
              'RU:"Этажи, бесконечные этажи..."},'+
            'body:{'+
              'ENG:"'+
                '<p></p>'+
                '<p>But the most interesting thing is that each floor is simply littered with various debris. I noticed that if you don''t make too much noise, '+
                    'the monsters will not react to me and you can study all this stuff. What if you can find a better weapon or some clues?</p>'+
                '<p>I remember that the note mentioned some kind of diary and tools. Resolved! I need to search all the available floors and find at least something that will help me in my current situation.</p>'+
              '",'+
              'RU:"'+
                '<p></p>'+
                '<p>Но самое интересное, что каждый этаж просто под завязку завален различным мусором. Я заметил, что если сильно не шуметь, монстры не будут на меня реагировать и '+
                    'можно будет изучить весь этот хлам. Вдруг получится найти оружие получше или какие-то подсказки?</p>'+
                '<p>Я помню, что в той записке упоминался какой-то дневник и инструменты. Решено! Нужно обыскать все доступные этажи и найти хоть что-то, что поможет мне в нынешнем положениию</p>'+
              '"},'+
          '},'+

      'monsters:{name: "monsters", cost: 200, kind: "tower",'+
        'script:"'+
          'SetPlayerAsTarget();'+
          'ChangeParam(EXP, 50);'+
          'ChangeParam(ATK, 5);'+
          'AllowThink(potions);'+
        '",'+
        'caption:{'+
          'ENG:"Monsters?",'+
          'RU:"Монстры?"},'+
        'body:{'+
          'ENG:"'+
            '<p>This tower is packed to capacity with a variety of creatures. They are all very aggressive. The author of the note did not lie. You can''t hide from them.</p>'+
            '<p>But at the door to the next floor there is always a much stronger monster. Perhaps this is a sign that the Dark Master, or who is in charge here, does not want anyone to rise higher.</p>'+
            '<p>Perhaps I would not do this, but I see no other way out. In this stone bag, the only way is up!</p>'+
            '<p>But these constant battles have their benefits. I became more attentive and began to notice the weak points of these animals. If things continue like this, the monsters will no longer be a serious obstacle to me! Find only better weapons.</p>'+
          '",'+
          'RU:"'+
            '<p>Эта башня под завязку забита разнообразными существами. Все они очень аггресивны. Автор записки не врал. От них не спрятаться.</p>'+
            '<p>Но у двери на следующий этаж всегда находится гораздо более сильное чудовище. Возможно, это признак того, что Темный Мастер, или кто тут главный, не хочет, чтобы кто-либо поднимался выше.</p>'+
            '<p>Я, может быть, и не стал бы этого делать, но не вижу другого выхода. В этом каменном мешке единственный путь - наверх!</p>'+
            '<p>Но эти постоянные сражения имеют свою пользу. Я стал более внимательным и начал подмечать слабые места у этих зверей. Если дело так пойдет и дальше, монстры больше не будут мне серьезной преградой! Найти бы только оружие получше.</p>'+
          '"},'+
      '},'+

          'potions:{name: "potions", cost: 200, kind: "tower",'+
            'script:"'+
              'SetPlayerAsTarget();'+
              'ChangeParam(EXP, 50);'+
            '",'+
            'caption:{'+
              'ENG:"Potions?",'+
              'RU:"Зелья?"},'+
            'body:{'+
              'ENG:"'+
                '<p>Everything would be completely awful, but after killing especially strong monsters, various flasks with multi-colored liquid and various debris are found: branches, stones, skins, and so on.</p>'+
                '<p>And these potions (let''s call them that) I dared to try. What else do I have to lose?</p>'+
                '<p>The effect is amazing! Despite not the most pleasant smell and taste, I felt stronger and better!</p>'+
                '<p>But suddenly I thought that I could try to study their composition. Who knows, maybe you can cook them yourself?</p>'+
              '",'+
              'RU:"'+
                '<p>Все было бы совсем ужасно, но после убийства особо сильных монстров обнаруживаются различные склянки с разноцветной жидкостью и различный мусор: ветки, камни, шкуры и прочее.</p>'+
                '<p>И эти зелья (назовем их так) я отважился попробовать. Что мне еще терять?</p>'+
                '<p>Эффект - поразительный! Не смотря на далеко не самый приятный запах и вкус, я почувствтал себя сильнее и лучше!</p>'+
                '<p>Но внезапно я подумал, что мог бы попробовать изучить их состав. Кто знает, может быть получится приготовить их самостоятельно?</p>'+
              '"},'+
          '},'+



      'whoami:{name: "whoami", cost: 200, kind: "persone",'+
        'script:"'+
          'SetPlayerAsTarget();'+
          'ChangeParam(EXP, 100);'+
          'AllowThink(calmness);'+
          'AllowThink(old_skills);'+
        '",'+
        'caption:{'+
          'ENG:"Who am I?!",'+
          'RU:"Кто я?!"},'+
        'body:{'+
          'ENG:"'+
            '<p>No specific memories. From this, panic rolls in waves and nausea rises.</p>'+
            '<p>No! You can''t rush and despair! Perhaps this is a temporary effect and you just need to calm down.</p>'+
            '<p>But muscle memory just surprises me! The dagger is in the palm of your hand and the hand knows exactly how to handle it. Not very confident and fast yet, '+
               'but if you practice a little, you might get better! And this can briefly distract from gloomy thoughts.</p>'+
          '",'+
          'RU:"'+
            '<p>Никаких конкретных воспоминаний. От этого паника накатывает волнами и поднимается тошнота.</p>'+
            '<p>Нет! Нельзя торопиться и отчаиваться! Возможно, это временный эффект и нужно просто успокоиться.</p>'+
            '<p>Но мышечная память меня просто удивляет! Кинжал в ладони как влитой и рука точно знает как им управляться. Пока не очень уверенно и быстро, '+
               'но если немного потренироваться, возможно, будет получаться лучше! И это сможет ненадолго отвлечь от мрачных мыслей.</p>'+
          '"},'+
      '},'+

          'calmness:{name: "calmness", cost: 300, kind: "tower",'+
            'script:"'+
              'SetPlayerAsTarget();'+
              'ChangeParam(EXP, 50);'+
              'ChangeParam(AutoAction, 5000);'+
            '",'+
            'caption:{'+
              'ENG:"This is some kind of nonsense! Need to calm down...",'+
              'RU:"Это какой-то бред! Нужно успокоиться..."},'+
            'body:{'+
              'ENG:"'+
                '<p>Yes! Now I see that this was the right decision.</p>'+
                '<p>Thoughts flow calmly. The heart no longer breaks from the chest. The panic subsided.</p>'+
                '<p>Now I understand that memories are not important. Not important yet. You need to make every effort to figure out what is happening and where I ended up. This can be the key that will allow you to restore the lost.</p>'+
                '<p>All I need now is confidence and discretion. I''m ready for action!</p>'+
              '",'+
              'RU:"'+
                '<p>Да! Теперь я вижу, что это было верным решением.</p>'+
                '<p>Мысли текут спокойно. Сердце больше не рвется из груди. Паника отступила.</p>'+
                '<p>Теперь я понимаю, что не важны воспоминания. Пока не важны. Нужно приложить все силы, чтобы разобраться в том что происходит и где я оказался. Это и может стать тем ключем, который позволит восстановить утерянное.</p>'+
                '<p>Все, что мне сейчас нужно - уверенность и рассудительность. Я готов к действиям!</p>'+
              '"},'+
          '},'+

          'old_skills:{name: "old_skills", cost: 600, kind: "persone",'+
            'script:"'+
              'SetPlayerAsTarget();'+
              'ChangeParam(EXP, 100);'+
              'ChangeParam(ATK, 5);'+
              'ChangeParam(DEF, 10);'+
            '",'+
            'caption:{'+
              'ENG:"The old skills",'+
              'RU:"Старые навыки"},'+
            'body:{'+
              'ENG:"'+
                '<p>I spent a few hours training and made sure it was not in vain!</p>'+
                '<p>The hand acquired firmness, and the blow acquired confidence and precision. I like it!</p>'+
              '",'+
              'RU:"'+
                '<p>Я потратил несколько часов на тренировки и убедился, что не зря!</p>'+
                '<p>Рука приобрела твердость, а удар - уверенность и точность. Это мне нравится!</p>'+
              '"},'+
          '},'+

      'other_path:{name: "other_path", cost: 400, kind: "tower",'+
        'script:"'+
          'SetPlayerAsTarget();'+
          'ChangeParam(EXP, 150);'+
        '",'+
        'caption:{'+
          'ENG:"Deceive the Master!",'+
          'RU:"Обмануть Мастера!"},'+
        'body:{'+
          'ENG:"'+
            '<p>Its end! This awful man (?) Locked me in the basement like in a dungeon! The only way out is upstairs, but there another defeat awaits me. And who knows when it will turn into <bold><red>real</red></bold> death !?</p>'+
            '<p>We must not despair! Surely you can think of something. Deceive the guard, find a loophole, defeat him, in the end!</p>'+
            '<p>I think we need to clear the floor and examine every inch of the floor and walls. It is possible that there may be secret passages or something like that.</p>'+
            '<p>Get down to business!</p>'+
          '",'+
          'RU:"'+
            '<p>Все кончено! Этот ужасный человек(?) запер меня в подвале как в темнице! Единственный выход - наверх, но там меня ожидает очередное поражение. И кто знает, когда это превратится в <bold><red>настоящую</red></bold> смерть!?</p>'+
            '<p>Нельзя отчаиваться! Наверняка, что-то можно придумать. Обмануть стража, найти лазейку, победить его, в конце-концов!</p>'+
            '<p>Думаю, необходимо расчистить этаж и изучить каждый сантиметр пола и стен. Не исключено, что тут могут быть тайные ходы или что-то в этом роде.</p>'+
            '<p>За дело!</p>'+
          '"},'+
      '},'+

      '"name":{'+
        'name: "name",'+           /// уникальный идентификатор
        'cost: 0,'+                /// сколько очков обдумывания для получения статуса redy
        'kind: "",'+                /// за оформление карточки и раздел в дневнике, где будет отображаться
        'script:"'+                /// скрипт выполняемый на момент завершения обдымывания
          '",'+
        'caption:{'+               /// текст для отображения на карточке
          'ENG:"",'+
          'RU:""},'+
        'body:{'+                  /// текст (возможен html) для отображения в дневнике
          'ENG:"'+
            '<p></p>'+
          '",'+
          'RU:"'+
            '<p></p>'+
          '"},'+
      '},'+
    '},'+



    /// имена для монстров
    'names:{'+
        'count: 40,'+
        'first:['+
            '{RU:"Упоротый",  ENG:"Stoned"},  {RU:"Сильный",    ENG:"Strong"},   {RU:"Отважный",    ENG:"Brave"},     {RU:"Северный",    ENG:"Northern"},  {RU:"Обреченный",  ENG:"Doomed"},'+
            '{RU:"Местный",   ENG:"Local"},   {RU:"Коварный",   ENG:"Insidious"},{RU:"Великолепный",ENG:"Great"},     {RU:"Смертоносный",ENG:"Deadly"},    {RU:"Точный",      ENG:"Accurate"},'+
            '{RU:"Голодный",  ENG:"Hungry"},  {RU:"Тяжелый",    ENG:"Heavy"},    {RU:"Сонный",      ENG:"Sleepy"},    {RU:"Святой",      ENG:"Holy"},      {RU:"Лысый",       ENG:"Bold"},'+
            '{RU:"Газовый",   ENG:"Gas"},     {RU:"Красивый",   ENG:"Beautiful"},{RU:"Аналогичный", ENG:"Similar"},   {RU:"Безобразный", ENG:"Ugly"},      {RU:"Стеклянный",  ENG:"Glassy"},'+
            '{RU:"Теплый",    ENG:"Warm"},    {RU:"Современный",ENG:"Modern"},   {RU:"Узкий",       ENG:"Narrow"},    {RU:"Неприятный",  ENG:"Unpleasant"},{RU:"Мертвый",     ENG:"Dead"},'+
            '{RU:"Конечный",  ENG:"Finite"},  {RU:"Основной",   ENG:"Main"},     {RU:"Возможный",   ENG:"Possible"},  {RU:"Вечерний",    ENG:"Evening"},   {RU:"Материальный",ENG:"Physical"},'+
            '{RU:"Предыдущий",ENG:"Previous"},{RU:"Холодный",   ENG:"Cold"},     {RU:"Удобный",     ENG:"Convenient"},{RU:"Эффективный", ENG:"Efficient"}, {RU:"Истинный",    ENG:"Genuine"},'+
            '{RU:"Хороший",   ENG:"Good"},    {RU:"Чудовищный", ENG:"Monstrous"},{RU:"Зеленый",     ENG:"Green"},     {RU:"Любой",       ENG:"Any"},       {RU:"Видный",      ENG:"Prominent"}'+
        '],'+
        'middle:['+
            '{RU:"Урод",    ENG:"Freak"},  {RU:"Майор",      ENG:"Major"},   {RU:"Искатель",   ENG:"Seeker"},  {RU:"Житель",     ENG:"Dweller"},{RU:"Крушитель",    ENG:"Crusher"},'+
            '{RU:"Барьер",  ENG:"Wall"},   {RU:"Тюфяк",      ENG:"Mattress"},{RU:"Министр",    ENG:"Minister"},{RU:"Жадина",     ENG:"Greedy"}, {RU:"Армия",        ENG:"Army"},'+
            '{RU:"Выпивоха",ENG:"Drinker"},{RU:"Результат",  ENG:"Result"},  {RU:"Пептид",     ENG:"Peptide"}, {RU:"Солдат",     ENG:"Soldier"},{RU:"Отсекатель",   ENG:"Cutter"},'+
            '{RU:"Воздух",  ENG:"Air"},    {RU:"НяшМяш",     ENG:"Kawaii"},  {RU:"Птах",       ENG:"Bird"},    {RU:"Крутыш",     ENG:"Winner"}, {RU:"Последователь",ENG:"Follower"},'+
            '{RU:"Хвост",   ENG:"Tail"},   {RU:"Подарок",    ENG:"Gift"},    {RU:"Чемодан",    ENG:"Bag"},     {RU:"Закрыватель",ENG:"System"}, {RU:"Танк",         ENG:"Tank"},'+
            '{RU:"Кризис",  ENG:"Crisis"}, {RU:"Массив",     ENG:"Mass"},    {RU:"Разжигатель",ENG:"Dream"},   {RU:"Призрак",    ENG:"Future"}, {RU:"Фаталист",     ENG:"Fate"},'+
            '{RU:"Костюм",  ENG:"Suit"},   {RU:"Разрушитель",ENG:"Doom"},    {RU:"Образ",      ENG:"Word"},    {RU:"Властитель", ENG:"Power"},  {RU:"Родственник",  ENG:"Relative"},'+
            '{RU:"Аппарат", ENG:"Machine"},{RU:"Мозг",       ENG:"Brain"},   {RU:"Ужас",       ENG:"Horror"},  {RU:"Дым",        ENG:"Smoke"},  {RU:"Металл",       ENG:"Steel"}'+
        '],'+
        'last:['+
            '{RU:"Поликлиники",ENG:"of Hospital"}, {RU:"Предательства",ENG:"of Betrayal"},        {RU:"Преисподней",  ENG:"of Hell"},      {RU:"Блаженства",   ENG:"of Bliss"},'+
            '{RU:"Иных миров", ENG:"of Worlds"},   {RU:"Недоразумения",ENG:"of Misunderstanding"},{RU:"Подземелий",   ENG:"of Dungeons"},  {RU:"Бесконечности",ENG:"of Infinity"},'+
            '{RU:"Лесов",      ENG:"of Forest"},   {RU:"Богатства",    ENG:"of Wealth"},          {RU:"Безумия",      ENG:"of Madness"},   {RU:"Нищеты",       ENG:"of Poverty"},'+
            '{RU:"Тайн",       ENG:"of Mistery"},  {RU:"Праздника",    ENG:"of Holiday"},         {RU:"Безнадежности",ENG:"of Hopeless"},  {RU:"Уныния",       ENG:"of Despondency"},'+
            '{RU:"Героизма",   ENG:"of Heroism"},  {RU:"Удачи",        ENG:"of Luck"},            {RU:"Коварства",    ENG:"of Deceit"},    {RU:"Повтора",      ENG:"of Replay"},'+
            '{RU:"Договора",   ENG:"of Agreement"},{RU:"Оружия",       ENG:"of Weapon"},          {RU:"Кризиса",      ENG:"of Crisis"},    {RU:"Весны",        ENG:"of Spring"},'+
            '{RU:"Сердца",     ENG:"of Heart"},    {RU:"Тела",         ENG:"of Body"},            {RU:"Подруги",      ENG:"of Girlfriend"},{RU:"Детства",      ENG:"of Childhood"},'+
            '{RU:"Сознания",   ENG:"of Conscious"},{RU:"Воспоминаний", ENG:"of Memory"},          {RU:"Поддержки",    ENG:"of Support"},   {RU:"Звезды",       ENG:"of Stars"},'+
            '{RU:"Сути",       ENG:"of Essence"},  {RU:"Сцены",        ENG:"of Scene"},           {RU:"Сомнений",     ENG:"of Doubt"},     {RU:"Риска",        ENG:"of Risk"},'+
            '{RU:"Реальности", ENG:"of Reality"},  {RU:"Охраны",       ENG:"of Guard"},           {RU:"Убийства",     ENG:"of Murders"},   {RU:"Пути",         ENG:"of Path"}'+
        ']'+
    '},'+

    '}';

var
    DIR_DATA :string;

implementation

initialization
    DIR_DATA := ExtractFilePath( paramstr(0) ) + FOLDER_DATA;

end.

