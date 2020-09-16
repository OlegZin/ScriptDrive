unit uConst;

interface

uses SysUtils;

const
    FOLDER_DATA = 'DATA\';

    FILE_MENU_DATA = '\menu.dat';
    FILE_GAME_DATA = '\toto.dat';

    /// состояние меню при первом запуске
    MENU_DATA_DEF =
    '{Gold:0, '+
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
         'MenuLang:   {Name:{ENG:"LANGUAGE",RU:"ЯЗЫК"},'+
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
        'AutoActions: 0,'+
        'CurrStep: 1,'+
        'CurrFloor: 1,'+
        'resources:{'+
            'wood:   {count: 0},'+
            'stone:  {count: 0},'+
            'herbal: {count: 0},'+
            'wheat:  {count: 0},'+
            'meat:   {count: 0},'+
            'blood:  {count: 0},'+
            'bone:   {count: 0},'+
            'skin:   {count: 0},'+
            'ore:    {count: 0},'+
            'essence:{count: 0}'+
        '},'+
        'player: {'+
            'params: {LVL:1, HP:100, MP:20, ATK:5, DEF:0, MDEF:0, REG:1, EXP:0},'+
            'skills: {},'+
            'items: {},'+
            'buffs: {},'+
            'autobuffs: {},'+
            'loot: {},'+
            'events: {OnAttack:"DoDamageToCreature(GetPlayerAttr(ATK));"},'+
        '},'+
        'creature: {'+
            'name: {RU:"", ENG:""},'+
            'params: {LVL:1, HP:0, MP:0, ATK:0, DEF:0, MDEF:0, REG:0},'+
            'skills: {},'+
            'items: {},'+
            'buffs: {},'+
            'autobuffs: {},'+
            'loot: {},'+
            'events: {OnAttack:"DoDamageToPlayer(GetCreatureAttr(ATK));"},'+
        '},'+
        'items:{'+
            'gold:         { cost:    0, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'restoreHealth:{ cost:  100, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'restoreMana:  { cost:  250, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'permanentATK: { cost:  200, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'permanentDEF: { cost:  200, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'PermanentMDEF:{ cost:  200, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'exp:          { cost:  100, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'regenHP:      { cost:  300, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'regenMP:      { cost:  500, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'buffATK:      { cost:  100, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'buffDEF:      { cost:  100, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'buffMDEF:     { cost:  100, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'buffEXP:      { cost:  100, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'buffREG:      { cost:  100, craft: {}, isCraftAllow: false, isUseAllow: true},'+
            'autoAction:   { cost: 1000, craft: {}, isCraftAllow: false, isUseAllow: true}'+
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
        //// набор объектов на каждом этаже
        'floors:{'+
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
        'blood:  {name:"blood",   caption:{RU:"Кровь",   ENG:"Blood"},   rarity:  3,  cost: 17},'+
        'bone:   {name:"bone",    caption:{RU:"Кость",   ENG:"Bone"},    rarity:  3,  cost: 17},'+
        'skin:   {name:"skin",    caption:{RU:"Шкура",   ENG:"Skin"},    rarity:  3,  cost: 17},'+
        'ore:    {name:"ore",     caption:{RU:"Руда",    ENG:"Ore"},     rarity:  2,  cost: 25},'+
        'essence:{name:"essence", caption:{RU:"Эссенция",ENG:"Essence"}, rarity:  1,  cost: 50}'+
    '},'+

    /// rarity - редкость ресурса. чем меньше, тем реже встречается
    /// allowCount - количество, доступное для распределения: -1 = без ограничений
    'objRaritySumm: 50,'+
    'floorObjects:{'+
        'Diary: {name:"Diary", caption:{RU:"Мусор",ENG:"Trash"}, rarity:1, allowCount:1,'+
            'hpCalc:"Rand(GetCurrFloor() * 50) + 50",'+
            'script:"'+
            'OpenThink(Diary);'+
            'IF(GetLang() = RU, 2);'+
            'AddEvent(\"Похоже, он зашифрован, придется поработать над расшифровкой...\");'+
            'AddEvent(!!! Обнаружен Дневник !!!);'+
            'IF(GetLang() = ENG, 2);'+
            'AddEvent(\"It looks like it is encrypted, we will have to work on decryption ...\");'+
            'AddEvent(!!! The player discovered the Diary !!!);'+
        '"},'+
        'Shovel: {name:"Shovel", caption:{RU:"Мусор",ENG:"Trash"}, rarity:1, allowCount:1,'+
            'hpCalc:"Rand(GetCurrFloor() * 50) + 50",'+
            'script:"'+
            'AllowTool(Shovel);' +
            'IF(GetLang() = RU, 1);'+
            'AddEvent(!!! Обнаружен артефакт Лопата !!!);'+
            'IF(GetLang() = ENG, 1);'+
            'AddEvent(!!! The player discovered the Shovel artifact !!!);'+
        '"},'+
        'Pick: {name:"Pick", caption:{RU:"Мусор",ENG:"Trash"}, rarity:1, allowCount:1,'+
            'hpCalc:"Rand(GetCurrFloor() * 50) + 50",'+
            'script:"'+
            'AllowTool(Pick);' +
            'IF(GetLang() = RU, 1);'+
            'AddEvent(!!! Игрок обнаружил артефакт Кирка !!!);'+
            'IF(GetLang() = ENG, 1);'+
            'AddEvent(!!! The player discovered the Pick artifact !!!);'+
        '"},'+
        'Axe: {name:"Axe", caption:{RU:"Мусор",ENG:"Trash"}, rarity:1, allowCount:1,'+
            'hpCalc:"Rand(GetCurrFloor() * 50) + 50",'+
            'script:"'+
            'AllowTool(Axe);' +
            'IF(GetLang() = RU}, 1);'+
            'AddEvent(!!! Игрок обнаружил артефакт Топор !!!);'+
            'IF(GetLang() = ENG, 1);'+
            'AddEvent(!!! The player discovered the Axe artifact !!!);'+
        '"},'+
        'lockpick: {name:"lockpick", caption:{RU:"Мусор",ENG:"Trash"}, rarity:1, allowCount:1,'+
            'hpCalc:"Rand(GetCurrFloor() * 50) + 50",'+
            'script:"'+
            'AllowTool(lockpick);' +
            'IF(GetLang() = RU, 1);'+
            'AddEvent(!!! Игрок обнаружил артифакт Отмычка !!!);'+
            'IF(GetLang() = ENG, 1);'+
            'AddEvent(!!! The player discovered the Lock pick artifact !!!);'+
        '"},'+
        'TimeSand: {name:"TimeSand", caption:{RU:"Сундук",ENG:"Chest"}, rarity:1, allowCount:1,'+
            'hpCalc:"Rand(GetCurrFloor() * 80) + 200",'+
            'script:"'+
            'AllowTool(TimeSand);'+
            'If(GetLang() = RU, 1);'+
            'AddEvent(!!! Найден артефакт Пески времени !!!);'+
            'If(GetLang() = ENG, 1);'+
            'AddEvent(!!! The player found Sand of Time artifact !!!);'+
        '"},'+
        'leggings: {name:"leggings", caption:{RU:"Каменный завал",ENG:"Stone blockage"}, rarity:1, allowCount:1,'+
            'hpCalc:"Rand(GetCurrFloor() * 250) + 1000",'+
            'script:"'+
            'AllowTool(leggings);'+
            'If(GetLang() = RU, 1);'+
            'AddEvent(!!! Найден артефакт Поножи !!!);'+
            'If(GetLang() = ENG, 1);'+
            'AddEvent(!!! The player found the leggings artifact !!!);'+
        '"},'+
        'LifeAmulet: {name:"LifeAmulet", caption:{RU:"Тайник",ENG:"Cache"}, rarity:1, allowCount:1,'+
            'hpCalc:"Rand(GetCurrFloor() * 70) + 150",'+
            'script:"'+
            'AllowTool(LifeAmulet);'+
            'If(GetLang() = RU, 1);'+
            'AddEvent(!!! Найден артефакт Амулет Жизни !!!);'+
            'If(GetLang() = ENG, 1);'+
            'AddEvent(!!! The player found the Amulet of Life artifact !!!);'+
        '"},'+



        'Cache: {name:"Cache", caption:{RU:"Тайник",ENG:"Cache"}, rarity:1, allowCount:-1,'+
            'hpCalc:"Rand(GetCurrFloor() * 70) + 150",'+
            'script:"'+
            'SetVar(gold, Rand(GetCurrFloor() * 10000) + 1);'+
            'ChangePlayerItemCount(Gold, GetVar(gold));'+

            'If(GetLang() = RU, 1);'+
            'AddEvent(Получено GetVar(gold) золота);'+
            'If(GetLang() = ENG, 1);'+
            'AddEvent(Gained GetVar(gold) gold);'+
        '"},'+
        'Spider: {name:"Spider", caption:{RU:"Паук",ENG:"Spider"}, rarity:2, allowCount:-1,'+
            'hpCalc:"1",'+
            'script:"'+
            'SetVar(val, Rand(100));'+

            'IF(GetVar(val) > GetArtLvl(leggings), 5);'+
            'SetPlayerAutoBuff(HP, -Rand(GetCurrFloor() * 100));'+
            'If(GetLang() = RU, 1);'+
            'AddEvent(Ядовитый паук укусил тебя!);'+
            'If(GetLang() = ENG, 1);'+
            'AddEvent(The poisonous spider bit you!);'+

            'IF(GetVar(val) <= GetArtLvl(leggings), 4);'+
            'If(GetLang() = RU, 1);'+
            'AddEvent(Ядовитый паук пытался укусить, но Поножи спасли от яда!);'+
            'If(GetLang() = ENG, 1);'+
            'AddEvent(Poisonous spider tried to bite you but Leggings saved you from poison!);'+
        '"},'+
        'Trap: {name:"Trap", caption:{RU:"Ловушка",ENG:"Trap"}, rarity:2, allowCount:-1,'+
            'hpCalc:"1",'+
            'script:"'+
            'SetVar(case, Rand(3));'+
            'IF(GetVar(case) = 0, 1);'+
            'SetVar(param, ATK);'+
            'IF(GetVar(case) = 1, 1);'+
            'SetVar(param, DEF);'+
            'IF(GetVar(case) = 2, 1);'+
            'SetVar(param, MDEF);'+

            'SetVar(val, Rand(100));'+

            'IF(GetVar(val) > GetArtLvl(leggings), 5);'+
            'ChangePlayerParam(GetVar(param), -1);'+
            'If(GetLang() = RU, 1);'+
            'AddEvent(Ловушка нанесла травму! Потеряно 1 GetVar(param)!);'+
            'If(GetLang() = ENG, 1);'+
            'AddEvent(The trap hurt! Lost 1 GetVar(param)!);'+

            'IF([GetVar(val) <= GetArtLvl(leggings)], 4);'+
            'If(GetLang() = RU, 1);'+
            'AddEvent(Ловушка сработала но эффект был заблокирован Поножами!);'+
            'If(GetLang() = ENG, 1);'+
            'AddEvent(The trap was triggered but the effect was blocked by Leggins!);'+
        '"},'+
        'StoneBlockage: {name:"StoneBlockage", caption:{RU:"Каменный завал",ENG:"Stone blockage"}, rarity:2, allowCount:-1,'+
            'hpCalc:"Rand(GetCurrFloor() * 250) + 1000",'+
            'script:"'+
            'SetVar(count, Rand(GetCurrFloor() * 100) + 10]);'+
            'SetPlayerRes(Stone, GetVar(count));' +
            'If(GetLang() = RU, 1);'+
            'AddEvent(Получено GetVar(count) камня);'+
            'If(GetLang() = ENG, 1);'+
            'AddEvent(Gained GetVar(count) stone);'+
        '"},'+
        'WoodBlockage: {name:"WoodBlockage", caption:{RU:"Деревянный завал",ENG:"Wood blockage"}, rarity:2, allowCount:-1,'+
            'hpCalc:"Rand(GetCurrFloor() * 250) + 1000",'+
            'script:"'+
            'SetVar(count, Rand(GetCurrFloor() * 100) + 10);'+
            'SetPlayerRes(Wood, GetVar(count));' +
            'If(GetLang() = RU, 1);'+
            'AddEvent(Получено GetVar(count) дерева);'+
            'If(GetLang() = ENG, 1);'+
            'AddEvent(Gained GetVar(count) wood);'+
        '"},'+
        'Chest: {name:"Chest", caption:{RU:"Сундук",ENG:"Chest"}, rarity:2, allowCount:-1,'+
            'hpCalc:"Rand(GetCurrFloor() * 80) + 200",'+
            'script:"'+
            'SetVar(iName, GetRandItemName());'+
            'SetVar(iCount, Rand(GetCurrFloor()) + 1);'+
            'ChangePlayerItemCount(GetVar(iName), GetVar(iCount));'+

            'SetVar(lName, GetRandResName());'+
            'SetVar(lCount, Random(GetCurrFloor() * 2) + 1);'+
            'SetPlayerRes(GetVar(lName), GetVar(lCount));' +

            'SetVar(gold, Rand(GetCurrFloor() * 1000) + 1);'+
            'ChangePlayerItemCount(Gold, GetVar(gold));'+

            'If(GetLang() = RU, 3);'+
            'AddEvent(Получено GetVar(gold) золота);'+
            'AddEvent(Получено GetVar(lCount) GetVar(lName)!);'+
            'AddEvent(Получено GetVar(iCount) GetVar(iName)!);'+
            'If(GetLang() = ENG, 3);'+
            'AddEvent(Gained GetVar(gold) Gold!);'+
            'AddEvent(Gained GetVar(lCount) GetVar(lName)!);'+
            'AddEvent(Gained GetVar(iCount) GetVar(iName)!);'+
        '"},'+
        'Box: {name:"Box", caption:{RU:"Ящик",ENG:"Box"}, rarity:3, allowCount:-1,'+
            'hpCalc:"Rand(GetCurrFloor() * 60) + 100",'+
            'script:"'+
            'SetVar(iName, GetRandItemName());'+
            'ChangePlayerItemCount(GetVar(iName), 1);'+
            'If(GetLang() = RU, 1);'+
            'AddEvent(Получено GetVar(iName));'+
            'If(GetLang() = ENG, 1);'+
            'AddEvent(Gained GetVar(iName));'+
        '"},'+
        'Rat: {name:"Rat", caption:{RU:"Крыса",ENG:"Rat"}, rarity:5, allowCount:-1,'+
            'hpCalc:"1",'+
            'script:"'+
            'SetVar(val, Rand(100));'+

            'IF(GetVar(val) > GetArtLvl(leggings), 6);'+
            'SetVar(dmg, Rand(GetCurrFloor() * 25) + 20);'+
            'ChangePlayerParam(HP, -GetVar(dmg));'+
            'If(GetLang() = RU, 1);'+
            'AddEvent(Из кучи мусора выскочила крыса и укусила на GetVar(dmg) HP!);'+
            'If(GetLang() = ENG, 1);'+
            'AddEvent(A rat jumped out of a pile of garbage and bit you for GetVar(dmg) HP!);'+

            'IF(GetVar(val) <= GetArtLvl(leggings), 4);'+
            'If(GetLang() = RU, 1);'+
            'AddEvent(Из кучи мусора выскочила крыса но не смогла прокусить Поножи!);'+
            'If(GetLang() = ENG, 1);'+
            'AddEvent(A rat jumped out of a pile of garbage but could not bite through the Leggings!);'+
        '"},'+
        'Trash: {name:"Trash", caption:{RU:"Мусор",ENG:"Trash"}, rarity:10, allowCount:-1,'+
            'hpCalc:"Rand(GetCurrFloor() * 50) + 50",'+
            'script:"'+
            'SetVar(obj, GetRandResName());'+
            'SetVar(count, Rand(GetCurrFloor() * 10) + 1);'+
            'SetPlayerRes(GetVar(obj), GetVar(count));' +
            'IF(GetLang() = RU, 1);'+
            'AddEvent(Игрок обнаружил GetVar(count) GetVar(obj)!);'+
            'IF(GetLang() = ENG, 1);'+
            'AddEvent(Player found GetVar(count) GetVar(obj)!);'+
        '"},'+
    '},'+



    /// cost - стоимость покупки в золоте
    /// craft - набор ресурсов для крафта. случайно генерится при старте игры
    /// isCraftAllow - доступен ли для крафта
    /// isUseAllow - доступен ли для использования
    'itemsCount: 15,'+
    'items:{'+
        'gold:{'+
            'name:"gold",'+
            'caption: {RU:"Золото", ENG:"Gold"},'+
            'description:{'+
                'RU:"Полновесные золотые монеты. За 10 000 монет можно получить случайный предмет. Испытаем удачу?",'+
                'ENG:"Full-weight gold coins. For 10,000 coins, you can get a random item. Lets try our luck?"'+
            '},'+
            'script:"'+
                'SetTarget(Player);' +
                'If(GetItemCount(Gold) < 10000, 5);'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(Не достаточно золота!);'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(You do not have enougth Gold!);'+
                'ChangeItemCount(Gold, 1);'+

                'If(GetItemCount(Gold) > 9999, 7);'+
                'SetVar(iName, GetRandItemName());'+
                'ChangeItemCount(GetVar(iName), 1);'+
                'ChangeItemCount(Gold, -9999);'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(Получено GetVar(iName)!);'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(Gained GetVar(iName)!);'+
        '"},'+
        'restoreHealth:{'+
            'name:"restoreHealth",'+
            'caption: {RU:"Зелье здоровья", ENG:"Potion of health"},'+
            'description:{'+
                'RU:"Мгновенно добавляет здоровье. Количество случайно: от нуля до 100 умноженного на текущий уровень игрока.",'+
                'ENG:"Instantly adds health. The amount is random: from zero to 100 multiplied by the players current level."'+
            '},'+
            'script:"'+
                'SetVar(IncHP,Rand(GetPlayerAttr(LVL) * 100));'+
                'ChangePlayerParam(HP,GetVar(IncHP));'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(Gained GetVar(IncHP) health);'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(Получено GetVar(IncHP) здоровья);'+
        '"},'+
        'restoreMana:{'+
            'name:"restoreMana",'+
            'caption: {RU:"Зелье маны", ENG:"Potion of mana"},'+
            'description:{'+
                'RU:"Мгновенно добавляет ману. Количество случайно: от нуля до 50 умноженного на текущий уровень игрока.",'+
                'ENG:"Instantly adds mana. The amount is random: from zero to 50 multiplied by the players current level."'+
            '},'+
            'script:"'+
                'SetVar(IncMP,Rand(GetPlayerAttr(LVL) * 50));'+
                'ChangePlayerParam(MP,GetVar(IncMP));'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(Gained GetVar(IncMP) mana);'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(Получено GetVar(IncMP) маны);'+
        '"},'+
        'permanentATK:{'+
            'name:"permanentATK",'+
            'caption: {RU:"Зелье атаки", ENG:"Potion of attack"},'+
            'description:{'+
                'RU:"Повышает потенциал атаки. Постоянный эффект.",'+
                'ENG:"Increases attack potential. Permanent effect."'+
            '},'+
            'script:"'+
                'ChangePlayerParam(ATK,1);'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(Gained +1 attack!);'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(Получено +1 к атаке!);'+
        '"},'+
        'permanentDEF:{'+
            'name:"permanentDEF",'+
            'caption: {RU:"Зелье защиты", ENG:"Potion of defence"},'+
            'description:{'+
                'RU:"Повышает физическую защиту. Постоянный эффект.",'+
                'ENG:"Increases physical protection. Permanent effect."'+
            '},'+
            'script:"'+
                'ChangePlayerParam(DEF,1);'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(Gained +1 defence!);'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(Получено +1 к защите!);'+
        '"},'+
        'PermanentMDEF:{'+
            'name:"PermanentMDEF",'+
            'caption: {RU:"Зелье магической защиты", ENG:"Potion of magic defence"},'+
            'description:{'+
                'RU:"Повышает защиту от магии и энергитических воздействий. Постоянный эффект.",'+
                'ENG:"Increases protection against magic and energetic influences. Permanent effect."'+
            '},'+
            'script:"'+
                'ChangePlayerParam(MDEF,1);'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(Gained +1 magic defence!);'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(Получено +1 магической защиты!);'+
        '"},'+
        'exp:{'+
            'name:"exp",'+
            'caption: {RU:"Зелье опыта", ENG:"Potion of experience"},'+
            'description:{'+
                'RU:"Мгновенно дает бесплатный опыт. Количество от 0 до 100 умноженное на текущий уровень игрока.",'+
                'ENG:"Gives you a free experience instantly. A number between 0 and 100 multiplied by the players current level."'+
            '},'+
            'script:"'+
                'SetVar(EXP,Rand(GetPlayerAttr(LVL) * 100));'+
                'ChangePlayerParam(EXP,GetVar(EXP));'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(Gained GetVar(EXP) experience!);'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(Получено GetVar(EXP) опыта!);'+
        '"},'+
        'regenHP:{'+
            'name:"regenHP",'+
            'caption: {RU:"Мазь здоровья", ENG:"Ointment of health"},'+
            'description:{'+
                'RU:"Постепенно восстанавливает здоровье. Потенциал восстановления от 0 до 500 умноженное на текущий уровень игрока.",'+
                'ENG:"Restores health over time. Recovery potential from 0 to 500 multiplied by the players current level."'+
            '},'+
            'script:"SetPlayerAutoBuff(HP,Rand(GetPlayerAttr(LVL) * 500));'+
        '"},'+
        'regenMP:{'+
            'name:"regenMP",'+
            'caption: {RU:"Мазь энергии", ENG:"Ointment of mana"},'+
            'description:{'+
                'RU:"Постепенно восстанавливает ману. Потенциал восстановления от 0 до 500 умноженное на текущий уровень игрока.",'+
                'ENG:"Restores mana over time. Recovery potential from 0 to 500 multiplied by the players current level."'+
            '},'+
            'script:"SetPlayerAutoBuff(MP,Rand(GetPlayerAttr(LVL) * 50));'+
        '"},'+
        'buffATK:{'+
            'name:"buffATK",'+
            'caption: {RU:"Порошок атаки", ENG:"Powder of attack"},'+
            'description:{'+
                'RU:"Временно повышает потенциал атаки. Снижается после каждой атаки игрока.",'+
                'ENG:"Temporarily increases attack potential. Decreases after each player attack."'+
            '},'+
            'script:"SetPlayerBuff(ATK,Rand(GetPlayerAttr(LVL)) + 1);'+
        '"},'+
        'buffDEF:{'+
            'name:"buffDEF",'+
            'caption: {RU:"Порошок защиты", ENG:"Powder of defence"},'+
            'description:{'+
                'RU:"Временно повышает потенциал защиты. Снижается после каждой атаки по игроку.",'+
                'ENG:"Temporarily increases attack potential. Decreases after each attack on the player."'+
            '},'+
            'script:"SetPlayerBuff(DEF,Rand(GetPlayerAttr(LVL)) + 1);'+
        '"},'+
        'buffMDEF:{'+
            'name:"buffMDEF",'+
            'caption: {RU:"Порошок магической защиты", ENG:"Powder of magic defence"},'+
            'description:{'+
                'RU:"Временно повышает потенциал магической защиты. Снижается после каждого магического или энергетического воздействия на игрока.",'+
                'ENG:"Temporarily increases the potential of magic protection. Decreases after each magical or energy impact on the player."'+
            '},'+
            'script:"SetPlayerBuff(MDEF,Rand(GetPlayerAttr(LVL)) + 1);'+
        '"},'+
        'buffEXP:{'+
            'name:"buffEXP",'+
            'caption: {RU:"Порошок опыта", ENG:"Powder of experience"},'+
            'description:{'+
                'RU:"Временно повышает потенциал получения опыта. Снижается после каждого получения опыта игроком.",'+
                'ENG:"Temporarily increases the potential for gaining experience. Decreased after each player gains experience."'+
            '},'+
            'script:"SetPlayerBuff(EXP,Rand(GetPlayerAttr(LVL)) + 1);'+
        '"},'+
        'buffREG:{'+
            'name:"buffREG",'+
            'caption: {RU:"Порошок регенерации", ENG:"Powder of regeneration"},'+
            'description:{'+
                'RU:"Временно повышает силу эффекта регенерации. Снижается после каждой регенерации.",'+
                'ENG:"Temporarily increases the strength of the regeneration effect. Decreases after each regeneration."'+
            '},'+
            'script:"SetPlayerBuff(REG,Rand(GetPlayerAttr(LVL) * 10) + 10);'+
        '"},'+
        'autoAction:{'+
            'name:"autoAction",'+
            'caption: {RU:"Зелье автодействий", ENG:"Potion of autoactions"},'+
            'description:{'+
                'RU:"Добавляет автодействия. Эффект от 0 до 100 умноженное на уровень игрока, но не больше 2000.",'+
                'ENG:"Adds auto-actions. The effect is from 0 to 100 multiplied by the players level, but not more than 2000."'+
            '},'+
            'script:"ChangeAutoATK(Rand(Min(GetPlayerAttr(LVL) * 100, 2000)));'+
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
                'SetTargetBuff(REG,GetVar(value));'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(Target speed up regeneration by GetVar(value));'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(Регенерация цели увеличена на GetVar(value));'+
        '"}'+
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


    /// список целей по уровням
    'targets:['+
        '{level: 1,script:"'+
             'ChangePlayerItemCount(Gold, 100000);'+
             'AddEvent(..................);'+

             'AddEvent(    Получено 100 000 золота);'+
             'AddEvent( );'+
             'AddEvent(\"БОЙ!\");'+
             'AddEvent(\"Рука непроизвольно стиснула рукоять непонятно откуда взявшегося кинжала и выбросила его навстречу летящему на тебя монстру.\");'+
             'AddEvent(\"Неподалеку, за кучами мусора, послышалось шевеление и тихое рычание.\");'+
             'AddEvent(\"Несколько раз перечитав послание, ты так и не понял его смысла. Но долго думать об этом тебе не дали.\");'+
             'AddEvent( );'+
             'AddEvent(\"Это на первое время. Больше ничем помочь не могу. Знаю, что сейчас ты сбит с толку и ничего не помнишь, '+
                 'но это было необходимо сделать. Позднее сам все поймешь. И что бы не происходило в Башне, помни: нужно найти выход! Сейчас ты в самой дальней от него, но и самой безопасной точке входа. Удачи, мой друг!\");'+
             'AddEvent( );'+
             'AddEvent(\"В слабом свете факелов ты с трудом разбираешь текст:\");'+
             'AddEvent(\"Практически под рукой обнаруживается увесистый тряпичный мешочек с пришпиленной к нему запиской.\");'+
             'AddEvent(\"Окна отсутствуют. Только факела коптят по стенам. В дальнем углу смутно виднеется лестница наверх к массивной, оббитой железом двери.\");'+
             'AddEvent(\"Немного оглядевшись, ты понимаешь, что находишься в каком-то большом пустом помещении, заваленном различным хламом.\");'+
             'AddEvent(\"В голове пустота, сердце сжимается от ощущение утраты.\");'+
             'AddEvent(\"Ты открываешь глаза в полумраке на каменном полу.\");'+

             'AddEvent( );'+
             'AddEvent( );'+
             'AddEvent( );'+

             'AddEvent(    Gained 100 000 Gold);'+
             'AddEvent( );'+
             'AddEvent(\"FIGHT!\");'+
             'AddEvent(\"The hand involuntarily gripped the handle of the dagger that had come from nowhere and threw it out towards the monster flying at you.\");'+
             'AddEvent(\"Nearby, behind heaps of rubbish, there was a stirring and a low growl.\");'+
             'AddEvent(\"After rereading the message several times, you still do not understand its meaning. But you were not allowed to think about it for a long time.\");'+
             'AddEvent( );'+
             'AddEvent(\"This is for the first time. I can not help you anymore. I know that now you are confused and do not remember anything, '+
                 'but it was necessary to do it. Later you will understand everything yourself. And whatever happens in the Tower, remember: you need to find a way out! Now you are at the farthest from him, but also the safest entry point. Good luck my friend!\");'+
             'AddEvent( );'+
             'AddEvent(\"In the faint light of torches, you can hardly make out the text:\");'+
             'AddEvent(\"Almost at hand, a weighty rag bag with a note pinned to it is found.\");'+
             'AddEvent(\"There are no windows. Only torches are smoked on the walls. In the far corner, a staircase upstairs to a massive iron-clad door is dimly visible.\");'+
             'AddEvent(\"Looking around a little, you realize that you are in some large empty room littered with various rubbish.\");'+
             'AddEvent(\"There is emptiness in my head, my heart squeezes from the feeling of loss.\");'+
             'AddEvent(\"You open your eyes in the twilight on the stone floor.\");'+

             'AddEvent(..................);'+

             'SetNextTarget();'
        +'"},'+
        '{level: 2,script:"'+
             'SetBreak(Tower);'+
             'SetVar(gold, Rand(100000));'+
             'AddEvent(..................);'+

             'IF(GetLang() = RU, 14);'+
             'AddEvent(    Получено GetVar(gold) золота);'+
             'AddEvent(    Доступен режим Раздумий!);'+
             'AddEvent( );'+
             'AddEvent(\"Следует как следует подумать об этом!\");'+
             'AddEvent(\"Подождите. Какая башня, какой Темный мастер? Что я здесь делаю?\");'+
             'AddEvent( );'+
             'AddEvent(\"О, горе! Я потерял свой дневник в кучах этого хлама! Годы накопленных знаний пропали! Даже не смотря на то, что он зашифрован, страшно представить каких бед он может принести в плохих руках... О, боги!..\");'+
             'AddEvent( );'+
             'AddEvent(\"Только я собрался навести порядок на этажах, проклятые монстры разбили сундук с инструментами и растащили их по этажам! Я знаю, что их науськал этот проклятый Икки, прихвостень Темного Мастера.\");'+
             'AddEvent( );'+
             'AddEvent(\"Темный Мастер охраняет свою башню днем и ночью, бродя по бесконечным этажам. Ни одна живая душа не избегнет его гнева и ярости его чудовищ.\");'+
             'AddEvent( );'+
             'AddEvent(\"Так же, в сундуке лежит несколько смятых листов:\");'+
             'AddEvent(\"В ржавом сундуке между этажами нашлось немного золота.\");'+

             'IF(GetLang() = ENG, 14);'+
             'AddEvent(    Gained GetVar(gold) Gold);'+
             'AddEvent(    Think mode available!);'+
             'AddEvent( );'+
             'AddEvent(\"Think about it well!\");'+
             'AddEvent(\"Wait. Which tower, which Dark master? What am I doing here?\");'+
             'AddEvent( );'+
             'AddEvent(\"Oh woe! I lost my diary in a lot of this junk! Years of accumulated knowledge are gone! Even in spite of the fact that it is encrypted, it is scary to imagine what troubles it can bring in bad hands ... Oh, gods! ..\");'+
             'AddEvent( );'+
             'AddEvent(\"As soon as I was about to put things in order on the floors, the damn monsters smashed the chest with tools and took them to the floors! I know that this damned Ikki, the Dark Master henchman, brought them up.\");'+
             'AddEvent( );'+
             'AddEvent(\"The Dark Master guards his tower day and night, roaming the endless floors. No living soul can escape his wrath and the fury of his monsters.\");'+             'AddEvent( );'+
             'AddEvent(\"Also, there are several crumpled sheets in the chest:\");'+
             'AddEvent(\"There was some gold in a rusty chest between floors.\");'+

             'AddEvent(..................);'+

             'AllowMode(Think, 1);'+
             'ChangePlayerItemCount(Gold, GetVar(gold));'+
             'SetNextTarget();'
        +'"},'+
        '{level: 3,script:"'+
             'SetBreak(Tower);'+
             'SetVar(count, 10);'+
             'AddEvent(..................);'+

             'IF(GetLang() = RU, 2);'+
             'AddEvent(Получено GetVar(count) зелий AutoAction);'+
             'AddEvent(В ржавом сундуке между этажами нашлось немного зелий.);'+

             'IF(GetLang() = ENG, 2);'+
             'AddEvent(Gained GetVar(count) AutoAction items);'+
             'AddEvent(Some potions were found in a rusty chest between floors.);'+

             'AddEvent(..................);'+

             'ChangePlayerItemCount(AutoAction, GetVar(count));'+
             'SetNextTarget();'
        +'"},'+
        '{level: 4,script:"'+
             'SetBreak(Tower);'+
             'AddEvent(..................);'+

             'SetVar(iName, GetRandItemName());'+
             'ChangePlayerItemCount(GetVar(iName), 1);'+
             'If(GetLang() = RU, 1);'+
             'AddEvent(Получено GetVar(iName)!);'+
             'If(GetLang() = ENG, 1);'+
             'AddEvent(Gained GetVar(iName)!);'+

             'SetVar(iName, GetRandItemName());'+
             'ChangePlayerItemCount(GetVar(iName), 1);'+
             'If(GetLang() = RU, 1);'+
             'AddEvent(Получено GetVar(iName)!);'+
             'If(GetLang() = ENG, 1);'+
             'AddEvent(Gained GetVar(iName)!);'+

             'SetVar(iName, GetRandItemName());'+
             'ChangePlayerItemCount(GetVar(iName), 1);'+
             'If(GetLang() = RU, 1);'+
             'AddEvent(Получено GetVar(iName)!);'+
             'If(GetLang() = ENG, 1);'+
             'AddEvent(Gained GetVar(iName)!);'+

             'SetVar(iName, GetRandItemName());'+
             'ChangePlayerItemCount(GetVar(iName), 1);'+
             'If(GetLang() = RU, 1);'+
             'AddEvent(Получено GetVar(iName)!);'+
             'If(GetLang() = ENG, 1);'+
             'AddEvent(Gained GetVar(iName)!);'+

             'SetVar(iName, GetRandItemName());'+
             'ChangePlayerItemCount(GetVar(iName), 1);'+
             'If(GetLang() = RU, 1);'+
             'AddEvent(Получено GetVar(iName)!);'+
             'If(GetLang() = ENG, 1);'+
             'AddEvent(Gained GetVar(iName)!);'+

             'AddEvent( );'+

             'If(GetLang() = RU, 1);'+
             'AddEvent(Огромный сундк! Замок поддается не с первого раза...);'+
             'If(GetLang() = ENG, 1);'+
             'AddEvent(You have found a huge chest! The lock does not give in the first time ...);'+

             'AddEvent(..................);'+
             'SetNextTarget();'
        +'"},'+
        '{level: 5,script:"'+
             'SetBreak(Tower);'+

             'SetCreature('+
                 '{RUS:ТЕМНЫЙ МАСТЕР, ENG:DARK MASTER},'+
                 '{HP:9999, ATK:100, DEF:0, MAXHP:9999, MP:0, MDEF:0, REG:0},'+
                 '{SpiritBless:1}, );'+

             'AddEvent(..................);'+

             'IF(GetLang() = ENG, 3);'+
             'AddEvent(\" - YOU WILL NOT PASS!\");' +
             'AddEvent(\" - What are you doing in my Tower, insignificance!?\");' +
             'SetCreatureScript(OnDeath,\"AddEvent(..................);AddEvent(- You defeated ME!? Can not be! Who are You?!);AddEvent(..................);AddEvent( );AddEvent(    Player got Sword artifact!);AllowTool(Sword);SetNextTarget();\");'+

             'IF(GetLang() = RU, 3);'+
             'AddEvent(\" - ТЫ НЕ ПРОЙДЕШЬ!\");' +
             'AddEvent(\" - Что ты делаешь в моей Башне, ничтожество!?\");' +
             'SetCreatureScript(OnDeath,\"SetBreak(Tower);AddEvent(..................);AddEvent(- Ты победил МЕНЯ!? Не может быть! Кто ты такой!?);AddEvent(..................);AddEvent( );AddEvent(    Игрок получил артефакт Меч!);AllowTool(Sword);SetNextTarget();\");'+

             'AddEvent(..................);'
        +'"},'+
        '{level: 7,script:"'+
             'SetBreak(Tower);'+

             'SetCreature('+
                 '{RUS:ТЕМНЫЙ МАСТЕР, ENG:DARK MASTER},'+
                 '{HP:99999, ATK:1000, DEF:0, MAXHP:99999, MP:0, MDEF:0, REG:0},'+
                 '{SpiritBless:1}, );'+

             'AddEvent(..................);'+

             'IF(GetLang() = ENG, 3);'+
             'SetVar(DarkMaster,ANGRY DARK MASTER);'+
             'AddEvent(\" - This is our last meeting, stranger! You will not leave my Tower!\");' +
             'SetCreatureScript(OnDeath,\"AddEvent(..................);AddEvent(- You defeated ME!? Can not be! Who are You?!);AddEvent(..................);SetNextTarget();\");'+

             'IF(GetLang() = RU, 3);'+
             'SetVar(DarkMaster,ЗЛОЙ ТЕМНЫЙ МАСТЕР);'+
             'AddEvent(\" - Это наша последняя встреча, чужак! Ты не выйдешь из моей Башни!\");' +
             'SetCreatureScript(OnDeath,\"AddEvent(..................);AddEvent(- Ты победил МЕНЯ!? Не может быть! Кто ты такой!?);AddEvent(..................);SetNextTarget();\");'+

             'AddEvent(..................);'+
             'SetNextTarget();'
        +'"},'+
        '{level: 10,script:"'+
             'SetBreak(Tower);'+

             'AddEvent(..................);'+

             'IF(GetLang() = ENG, 3);'+
             'AddEvent(\" - You broke into my Tower, scared monsters, looted chests. Who are you after that !?\");' +
             'AddEvent(\" - Now EXACTLY our last meeting!\");' +
             'SetCreatureScript(OnDeath,\"AddEvent(..................);AddEvent(- You defeated ME!? Can not be! Who are You?!);AddEvent(..................);SetNextTarget();\");'+

             'IF(GetLang() = RU, 3);'+
             'AddEvent(\" - Ты вломился в мою Башню, рапугал монстров, разграбил сундуки. Да кто ты такой после этого!?\");' +
             'AddEvent(\" - Вот теперь ТОЧНО наша последняя встреча!\");' +
             'SetCreatureScript(OnDeath,\"AddEvent(..................);AddEvent(- Ты победил МЕНЯ!? Не может быть! Кто ты такой!?);AddEvent(..................);SetNextTarget();\");'+

             'SetCreature('+
                 '{RUS:ТЕМНЫЙ МАСТЕР, ENG:DARK MASTER},'+
                 '{HP:999999, ATK:10000, DEF:0, MAXHP:999999, MP:0, MDEF:0, REG:0},'+
                 '{SpiritBless:1}, );'+

             'AddEvent(..................);'+
             'SetNextTarget();'
        +'"},'+
        '{level: 11,script:"'+
             'SetBreak(Tower);'+
             'AddEvent(..................);'+
             'IF(GetLang() = ENG, 2);'+
             'AddEvent(!!! INCREDIBLE !!!);' +
             'AddEvent(!!! YOU PASS THE GAME !!!);' +

             'IF(GetLang() = RU, 2);'+
             'AddEvent(!!! НЕВЕРОЯТНО !!!);' +
             'AddEvent(!!! ТЫ ПРОШЕЛ ИГРУ !!!);' +
             'AddEvent(..................);'+

             'CurrentLevel(1);InitCreatures();'
        +'"}'+
    '],'+



    /// размышлялки
    'thinks:{'+
    '},'+



    /// имена для монстров
    'names:{'+
        'count: 40,'+
        'first:['+
            '{RU:"Упоротый",ENG:"Stoned"},{RU:"Сильный",ENG:"Strong"},{RU:"Отважный",ENG:"Brave"},{RU:"Северный",ENG:"Northern"},{RU:"Обреченный",ENG:"Doomed"},'+
            '{RU:"Местный",ENG:"Local"},{RU:"Коварный",ENG:"Insidious"},{RU:"Великолепный",ENG:"Great"},{RU:"Смертоносный",ENG:"Deadly"},{RU:"Точный",ENG:"Accurate"},'+
            '{RU:"Голодный",ENG:"Hungry"},{RU:"Тяжелый",ENG:"Heavy"},{RU:"Сонный",ENG:"Sleepy"},{RU:"Святой",ENG:"Holy"},{RU:"Лысый",ENG:"Bold"},'+
            '{RU:"Газовый",ENG:"Gas"},{RU:"Красивый",ENG:"Beautiful"},{RU:"Аналогичный",ENG:"Similar"},{RU:"Безобразный",ENG:"Ugly"},{RU:"Стеклянный",ENG:"Glassy"},'+
            '{RU:"Теплый",ENG:"Warm"},{RU:"Современный",ENG:"Modern"},{RU:"Узкий",ENG:"Narrow"},{RU:"Неприятный",ENG:"Unpleasant"},{RU:"Мертвый",ENG:"Dead"},'+
            '{RU:"Конечный",ENG:"Finite"},{RU:"Основной",ENG:"Main"},{RU:"Возможный",ENG:"Possible"},{RU:"Вечерний",ENG:"Evening"},{RU:"Материальный",ENG:"Physical"},'+
            '{RU:"Предыдущий",ENG:"Previous"},{RU:"Холодный",ENG:"Cold"},{RU:"Удобный",ENG:"Convenient"},{RU:"Эффективный",ENG:"Efficient"},{RU:"Истинный",ENG:"Genuine"},'+
            '{RU:"Хороший",ENG:"Good"},{RU:"Чудовищный",ENG:"Monstrous"},{RU:"Зеленый",ENG:"Green"},{RU:"Любой",ENG:"Any"},{RU:"Видный",ENG:"Prominent"}'+
        '],'+
        'middle:['+
            '{RU:"Урод",ENG:"Freak"},{RU:"Майор",ENG:"Major"},{RU:"Искатель",ENG:"Seeker"},{RU:"Житель",ENG:"Dweller"},{RU:"Крушитель",ENG:"Crusher"},'+
            '{RU:"Барьер",ENG:"Wall"},{RU:"Тюфяк",ENG:"Mattress"},{RU:"Министр",ENG:"Minister"},{RU:"Жадина",ENG:"Greedy"},{RU:"Армия",ENG:"Army"},'+
            '{RU:"Выпивоха",ENG:"Drinker"},{RU:"Результат",ENG:"Result"},{RU:"Пептид",ENG:"Peptide"},{RU:"Солдат",ENG:"Soldier"},{RU:"Отсекатель",ENG:"Cutter"},'+
            '{RU:"Воздух",ENG:"Air"},{RU:"НяшМяш",ENG:"Kawaii"},{RU:"Птиц",ENG:"Bird"},{RU:"Крутыш",ENG:"Winner"},{RU:"Последователь",ENG:"Follower"},'+
            '{RU:"Хвост",ENG:"Tail"},{RU:"Подарок",ENG:"Gift"},{RU:"Чемодан",ENG:"Bag"},{RU:"Закрыватель",ENG:"System"},{RU:"Танк",ENG:"Tank"},'+
            '{RU:"Кризис",ENG:"Crisis"},{RU:"Массив",ENG:"Mass"},{RU:"Разжигатель",ENG:"Dream"},{RU:"Призрак",ENG:"Future"},{RU:"Фаталист",ENG:"Fate"},'+
            '{RU:"Костюм",ENG:"Suit"},{RU:"Разрушитель",ENG:"Doom"},{RU:"Образ",ENG:"Word"},{RU:"Властитель",ENG:"Power"},{RU:"Родственник",ENG:"Relative"},'+
            '{RU:"Аппарат",ENG:"Machine"},{RU:"Мозг",ENG:"Brain"},{RU:"Ужас",ENG:"Horror"},{RU:"Дым",ENG:"Smoke"},{RU:"Металл",ENG:"Steel"}'+
        '],'+
        'last:['+
            '{RU:"Поликлиники",ENG:"of Hospital"},{RU:"Предательства",ENG:"of Betrayal"},{RU:"of Hell",ENG:"of Hell"},{RU:"Блаженства",ENG:"of Bliss"},'+
            '{RU:"Иных миров",ENG:"of Worlds"},{RU:"Недоразумения",ENG:"of Misunderstanding"},{RU:"Подземелий",ENG:"of Dungeons"},{RU:"Бесконечности",ENG:"of Infinity"},'+
            '{RU:"Лесов",ENG:"of Forest"},{RU:"Богатства",ENG:"of Wealth"},{RU:"Безумия",ENG:"of Madness"},{RU:"Нищеты",ENG:"of Poverty"},'+
            '{RU:"Тайн",ENG:"of Mistery"},{RU:"Праздника",ENG:"of Holiday"},{RU:"Безнадежности",ENG:"of Hopeless"},{RU:"Уныния",ENG:"of Despondency"},'+
            '{RU:"Героизма",ENG:"of Heroism"},{RU:"Удачи",ENG:"of Luck"},{RU:"Коварства",ENG:"of Deceit"},{RU:"Повтора",ENG:"of Replay"},'+
            '{RU:"Договора",ENG:"of Agreement"},{RU:"Оружия",ENG:"of Weapon"},{RU:"Crisis",ENG:"of Кризиса"},{RU:"Весны",ENG:"of Spring"},'+
            '{RU:"Сердца",ENG:"of Heart"},{RU:"Тела",ENG:"of Body"},{RU:"Подруги",ENG:"of Girlfriend"},{RU:"Детства",ENG:"of Childhood"},'+
            '{RU:"Сознания",ENG:"of Conscious"},{RU:"Воспоминаний",ENG:"of Memory"},{RU:"Поддержки",ENG:"of Support"},{RU:"Звезды",ENG:"of Stars"},'+
            '{RU:"Сути",ENG:"of Essence"},{RU:"Сцены",ENG:"of Scene"},{RU:"Сомнений",ENG:"of Doubt"},{RU:"Риска",ENG:"of Risk"},'+
            '{RU:"Реальности",ENG:"of Reality"},{RU:"Охраны",ENG:"of Guard"},{RU:"Убийства",ENG:"of Murders"},{RU:"Пути",ENG:"of Path"}'+
        ']'+
    '},'+

    '}';


var
    DIR_DATA :string;


implementation

initialization
    DIR_DATA := ExtractFilePath( paramstr(0) ) + FOLDER_DATA;

end.



















