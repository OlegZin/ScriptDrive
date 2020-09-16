unit uConst;

interface

uses SysUtils;

const
    FOLDER_DATA = 'DATA\';

    FILE_MENU_DATA = '\menu.dat';
    FILE_GAME_DATA = '\toto.dat';

    /// ��������� ���� ��� ������ �������
    MENU_DATA_DEF =
    '{Gold:0, '+
     'Lang:ENG, '+
     'NewLevel:1, '+
     'IntroOver:0, '+
     'Skills: {'+
         'Research:     {Name:{ENG:"Research",RU:"������������"},Enabled:0, Level:0, NeedGold:10,  NeedResearch:1 },'+
         'MoneyEaring:  {Name:{ENG:"Money Earing",RU:"�����"},Enabled:0, Level:1, NeedGold:20,  NeedResearch:5 },'+
         'BuildSpeed:   {Name:{ENG:"Build Speed",RU:"�������������"},Enabled:0, Level:1, NeedGold:50,  NeedResearch:10},'+
         'AutoMoney:    {Name:{ENG:"Auto Money",RU:"���������"},Enabled:0, Level:0, NeedGold:500, NeedResearch:15}'+
    '},'+
     'Objects: {'+
         'Logo:       {NeedResearch:3,  BuildCost:5,  Attempts:0, FullAttempts:10 },'+
         'MenuExit:   {Name:{ENG:"EXIT",RU:"�����"}, '+
                      'NeedResearch:6,  BuildCost:10, Attempts:0, FullAttempts:20 },'+
         'MenuLang:   {Name:{ENG:"LANGUAGE",RU:"����"},'+
                      'NeedResearch:9,  BuildCost:20, Attempts:0, FullAttempts:50 },'+
         'MenuResume: {Name:{ENG:"RESUME",RU:"����������"},'+
                      'NeedResearch:11, BuildCost:30, Attempts:0, FullAttempts:100 },'+
         'MenuNew:    {Name:{ENG:"NEW GAME",RU:"����� ����"},'+
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
        //// ����� �������� �� ������ �����
        'floors:{'+
        '},'+
    '},'+



    /// rarity - �������� �������. ��� ������, ��� ���� �����������
    /// cost - ��������� ������� ������� � ������
    ///        ��������� �� �������: cost = FULL / rarity, ��� FULL = ����� rarity ���� ��������
    'resRaritySumm: 50,'+
    'resources:{'+
        'wood:   {name:"wood",    caption:{RU:"������",  ENG:"Wood"},    rarity: 10,  cost:  5},'+
        'stone:  {name:"stone",   caption:{RU:"������",  ENG:"Stone"},   rarity: 10,  cost:  5},'+
        'herbal: {name:"herbal",  caption:{RU:"�����",   ENG:"Herbal"},  rarity:  8,  cost:  6},'+
        'wheat:  {name:"wheat",   caption:{RU:"�����",   ENG:"Wheat"},   rarity:  6,  cost:  8},'+
        'meat:   {name:"meat",    caption:{RU:"����",    ENG:"Meat"},    rarity:  4,  cost: 13},'+
        'blood:  {name:"blood",   caption:{RU:"�����",   ENG:"Blood"},   rarity:  3,  cost: 17},'+
        'bone:   {name:"bone",    caption:{RU:"�����",   ENG:"Bone"},    rarity:  3,  cost: 17},'+
        'skin:   {name:"skin",    caption:{RU:"�����",   ENG:"Skin"},    rarity:  3,  cost: 17},'+
        'ore:    {name:"ore",     caption:{RU:"����",    ENG:"Ore"},     rarity:  2,  cost: 25},'+
        'essence:{name:"essence", caption:{RU:"��������",ENG:"Essence"}, rarity:  1,  cost: 50}'+
    '},'+

    /// rarity - �������� �������. ��� ������, ��� ���� �����������
    /// allowCount - ����������, ��������� ��� �������������: -1 = ��� �����������
    'objRaritySumm: 50,'+
    'floorObjects:{'+
        'Diary: {name:"Diary", caption:{RU:"�����",ENG:"Trash"}, rarity:1, allowCount:1,'+
            'hpCalc:"Rand(GetCurrFloor() * 50) + 50",'+
            'script:"'+
            'OpenThink(Diary);'+
            'IF(GetLang() = RU, 2);'+
            'AddEvent(\"������, �� ����������, �������� ���������� ��� ������������...\");'+
            'AddEvent(!!! ��������� ������� !!!);'+
            'IF(GetLang() = ENG, 2);'+
            'AddEvent(\"It looks like it is encrypted, we will have to work on decryption ...\");'+
            'AddEvent(!!! The player discovered the Diary !!!);'+
        '"},'+
        'Shovel: {name:"Shovel", caption:{RU:"�����",ENG:"Trash"}, rarity:1, allowCount:1,'+
            'hpCalc:"Rand(GetCurrFloor() * 50) + 50",'+
            'script:"'+
            'AllowTool(Shovel);' +
            'IF(GetLang() = RU, 1);'+
            'AddEvent(!!! ��������� �������� ������ !!!);'+
            'IF(GetLang() = ENG, 1);'+
            'AddEvent(!!! The player discovered the Shovel artifact !!!);'+
        '"},'+
        'Pick: {name:"Pick", caption:{RU:"�����",ENG:"Trash"}, rarity:1, allowCount:1,'+
            'hpCalc:"Rand(GetCurrFloor() * 50) + 50",'+
            'script:"'+
            'AllowTool(Pick);' +
            'IF(GetLang() = RU, 1);'+
            'AddEvent(!!! ����� ��������� �������� ����� !!!);'+
            'IF(GetLang() = ENG, 1);'+
            'AddEvent(!!! The player discovered the Pick artifact !!!);'+
        '"},'+
        'Axe: {name:"Axe", caption:{RU:"�����",ENG:"Trash"}, rarity:1, allowCount:1,'+
            'hpCalc:"Rand(GetCurrFloor() * 50) + 50",'+
            'script:"'+
            'AllowTool(Axe);' +
            'IF(GetLang() = RU}, 1);'+
            'AddEvent(!!! ����� ��������� �������� ����� !!!);'+
            'IF(GetLang() = ENG, 1);'+
            'AddEvent(!!! The player discovered the Axe artifact !!!);'+
        '"},'+
        'lockpick: {name:"lockpick", caption:{RU:"�����",ENG:"Trash"}, rarity:1, allowCount:1,'+
            'hpCalc:"Rand(GetCurrFloor() * 50) + 50",'+
            'script:"'+
            'AllowTool(lockpick);' +
            'IF(GetLang() = RU, 1);'+
            'AddEvent(!!! ����� ��������� �������� ������� !!!);'+
            'IF(GetLang() = ENG, 1);'+
            'AddEvent(!!! The player discovered the Lock pick artifact !!!);'+
        '"},'+
        'TimeSand: {name:"TimeSand", caption:{RU:"������",ENG:"Chest"}, rarity:1, allowCount:1,'+
            'hpCalc:"Rand(GetCurrFloor() * 80) + 200",'+
            'script:"'+
            'AllowTool(TimeSand);'+
            'If(GetLang() = RU, 1);'+
            'AddEvent(!!! ������ �������� ����� ������� !!!);'+
            'If(GetLang() = ENG, 1);'+
            'AddEvent(!!! The player found Sand of Time artifact !!!);'+
        '"},'+
        'leggings: {name:"leggings", caption:{RU:"�������� �����",ENG:"Stone blockage"}, rarity:1, allowCount:1,'+
            'hpCalc:"Rand(GetCurrFloor() * 250) + 1000",'+
            'script:"'+
            'AllowTool(leggings);'+
            'If(GetLang() = RU, 1);'+
            'AddEvent(!!! ������ �������� ������ !!!);'+
            'If(GetLang() = ENG, 1);'+
            'AddEvent(!!! The player found the leggings artifact !!!);'+
        '"},'+
        'LifeAmulet: {name:"LifeAmulet", caption:{RU:"������",ENG:"Cache"}, rarity:1, allowCount:1,'+
            'hpCalc:"Rand(GetCurrFloor() * 70) + 150",'+
            'script:"'+
            'AllowTool(LifeAmulet);'+
            'If(GetLang() = RU, 1);'+
            'AddEvent(!!! ������ �������� ������ ����� !!!);'+
            'If(GetLang() = ENG, 1);'+
            'AddEvent(!!! The player found the Amulet of Life artifact !!!);'+
        '"},'+



        'Cache: {name:"Cache", caption:{RU:"������",ENG:"Cache"}, rarity:1, allowCount:-1,'+
            'hpCalc:"Rand(GetCurrFloor() * 70) + 150",'+
            'script:"'+
            'SetVar(gold, Rand(GetCurrFloor() * 10000) + 1);'+
            'ChangePlayerItemCount(Gold, GetVar(gold));'+

            'If(GetLang() = RU, 1);'+
            'AddEvent(�������� GetVar(gold) ������);'+
            'If(GetLang() = ENG, 1);'+
            'AddEvent(Gained GetVar(gold) gold);'+
        '"},'+
        'Spider: {name:"Spider", caption:{RU:"����",ENG:"Spider"}, rarity:2, allowCount:-1,'+
            'hpCalc:"1",'+
            'script:"'+
            'SetVar(val, Rand(100));'+

            'IF(GetVar(val) > GetArtLvl(leggings), 5);'+
            'SetPlayerAutoBuff(HP, -Rand(GetCurrFloor() * 100));'+
            'If(GetLang() = RU, 1);'+
            'AddEvent(�������� ���� ������ ����!);'+
            'If(GetLang() = ENG, 1);'+
            'AddEvent(The poisonous spider bit you!);'+

            'IF(GetVar(val) <= GetArtLvl(leggings), 4);'+
            'If(GetLang() = RU, 1);'+
            'AddEvent(�������� ���� ������� �������, �� ������ ������ �� ���!);'+
            'If(GetLang() = ENG, 1);'+
            'AddEvent(Poisonous spider tried to bite you but Leggings saved you from poison!);'+
        '"},'+
        'Trap: {name:"Trap", caption:{RU:"�������",ENG:"Trap"}, rarity:2, allowCount:-1,'+
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
            'AddEvent(������� ������� ������! �������� 1 GetVar(param)!);'+
            'If(GetLang() = ENG, 1);'+
            'AddEvent(The trap hurt! Lost 1 GetVar(param)!);'+

            'IF([GetVar(val) <= GetArtLvl(leggings)], 4);'+
            'If(GetLang() = RU, 1);'+
            'AddEvent(������� ��������� �� ������ ��� ������������ ��������!);'+
            'If(GetLang() = ENG, 1);'+
            'AddEvent(The trap was triggered but the effect was blocked by Leggins!);'+
        '"},'+
        'StoneBlockage: {name:"StoneBlockage", caption:{RU:"�������� �����",ENG:"Stone blockage"}, rarity:2, allowCount:-1,'+
            'hpCalc:"Rand(GetCurrFloor() * 250) + 1000",'+
            'script:"'+
            'SetVar(count, Rand(GetCurrFloor() * 100) + 10]);'+
            'SetPlayerRes(Stone, GetVar(count));' +
            'If(GetLang() = RU, 1);'+
            'AddEvent(�������� GetVar(count) �����);'+
            'If(GetLang() = ENG, 1);'+
            'AddEvent(Gained GetVar(count) stone);'+
        '"},'+
        'WoodBlockage: {name:"WoodBlockage", caption:{RU:"���������� �����",ENG:"Wood blockage"}, rarity:2, allowCount:-1,'+
            'hpCalc:"Rand(GetCurrFloor() * 250) + 1000",'+
            'script:"'+
            'SetVar(count, Rand(GetCurrFloor() * 100) + 10);'+
            'SetPlayerRes(Wood, GetVar(count));' +
            'If(GetLang() = RU, 1);'+
            'AddEvent(�������� GetVar(count) ������);'+
            'If(GetLang() = ENG, 1);'+
            'AddEvent(Gained GetVar(count) wood);'+
        '"},'+
        'Chest: {name:"Chest", caption:{RU:"������",ENG:"Chest"}, rarity:2, allowCount:-1,'+
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
            'AddEvent(�������� GetVar(gold) ������);'+
            'AddEvent(�������� GetVar(lCount) GetVar(lName)!);'+
            'AddEvent(�������� GetVar(iCount) GetVar(iName)!);'+
            'If(GetLang() = ENG, 3);'+
            'AddEvent(Gained GetVar(gold) Gold!);'+
            'AddEvent(Gained GetVar(lCount) GetVar(lName)!);'+
            'AddEvent(Gained GetVar(iCount) GetVar(iName)!);'+
        '"},'+
        'Box: {name:"Box", caption:{RU:"����",ENG:"Box"}, rarity:3, allowCount:-1,'+
            'hpCalc:"Rand(GetCurrFloor() * 60) + 100",'+
            'script:"'+
            'SetVar(iName, GetRandItemName());'+
            'ChangePlayerItemCount(GetVar(iName), 1);'+
            'If(GetLang() = RU, 1);'+
            'AddEvent(�������� GetVar(iName));'+
            'If(GetLang() = ENG, 1);'+
            'AddEvent(Gained GetVar(iName));'+
        '"},'+
        'Rat: {name:"Rat", caption:{RU:"�����",ENG:"Rat"}, rarity:5, allowCount:-1,'+
            'hpCalc:"1",'+
            'script:"'+
            'SetVar(val, Rand(100));'+

            'IF(GetVar(val) > GetArtLvl(leggings), 6);'+
            'SetVar(dmg, Rand(GetCurrFloor() * 25) + 20);'+
            'ChangePlayerParam(HP, -GetVar(dmg));'+
            'If(GetLang() = RU, 1);'+
            'AddEvent(�� ���� ������ ��������� ����� � ������� �� GetVar(dmg) HP!);'+
            'If(GetLang() = ENG, 1);'+
            'AddEvent(A rat jumped out of a pile of garbage and bit you for GetVar(dmg) HP!);'+

            'IF(GetVar(val) <= GetArtLvl(leggings), 4);'+
            'If(GetLang() = RU, 1);'+
            'AddEvent(�� ���� ������ ��������� ����� �� �� ������ ��������� ������!);'+
            'If(GetLang() = ENG, 1);'+
            'AddEvent(A rat jumped out of a pile of garbage but could not bite through the Leggings!);'+
        '"},'+
        'Trash: {name:"Trash", caption:{RU:"�����",ENG:"Trash"}, rarity:10, allowCount:-1,'+
            'hpCalc:"Rand(GetCurrFloor() * 50) + 50",'+
            'script:"'+
            'SetVar(obj, GetRandResName());'+
            'SetVar(count, Rand(GetCurrFloor() * 10) + 1);'+
            'SetPlayerRes(GetVar(obj), GetVar(count));' +
            'IF(GetLang() = RU, 1);'+
            'AddEvent(����� ��������� GetVar(count) GetVar(obj)!);'+
            'IF(GetLang() = ENG, 1);'+
            'AddEvent(Player found GetVar(count) GetVar(obj)!);'+
        '"},'+
    '},'+



    /// cost - ��������� ������� � ������
    /// craft - ����� �������� ��� ������. �������� ��������� ��� ������ ����
    /// isCraftAllow - �������� �� ��� ������
    /// isUseAllow - �������� �� ��� �������������
    'itemsCount: 15,'+
    'items:{'+
        'gold:{'+
            'name:"gold",'+
            'caption: {RU:"������", ENG:"Gold"},'+
            'description:{'+
                'RU:"����������� ������� ������. �� 10 000 ����� ����� �������� ��������� �������. �������� �����?",'+
                'ENG:"Full-weight gold coins. For 10,000 coins, you can get a random item. Lets try our luck?"'+
            '},'+
            'script:"'+
                'SetTarget(Player);' +
                'If(GetItemCount(Gold) < 10000, 5);'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(�� ���������� ������!);'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(You do not have enougth Gold!);'+
                'ChangeItemCount(Gold, 1);'+

                'If(GetItemCount(Gold) > 9999, 7);'+
                'SetVar(iName, GetRandItemName());'+
                'ChangeItemCount(GetVar(iName), 1);'+
                'ChangeItemCount(Gold, -9999);'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(�������� GetVar(iName)!);'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(Gained GetVar(iName)!);'+
        '"},'+
        'restoreHealth:{'+
            'name:"restoreHealth",'+
            'caption: {RU:"����� ��������", ENG:"Potion of health"},'+
            'description:{'+
                'RU:"��������� ��������� ��������. ���������� ��������: �� ���� �� 100 ����������� �� ������� ������� ������.",'+
                'ENG:"Instantly adds health. The amount is random: from zero to 100 multiplied by the players current level."'+
            '},'+
            'script:"'+
                'SetVar(IncHP,Rand(GetPlayerAttr(LVL) * 100));'+
                'ChangePlayerParam(HP,GetVar(IncHP));'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(Gained GetVar(IncHP) health);'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(�������� GetVar(IncHP) ��������);'+
        '"},'+
        'restoreMana:{'+
            'name:"restoreMana",'+
            'caption: {RU:"����� ����", ENG:"Potion of mana"},'+
            'description:{'+
                'RU:"��������� ��������� ����. ���������� ��������: �� ���� �� 50 ����������� �� ������� ������� ������.",'+
                'ENG:"Instantly adds mana. The amount is random: from zero to 50 multiplied by the players current level."'+
            '},'+
            'script:"'+
                'SetVar(IncMP,Rand(GetPlayerAttr(LVL) * 50));'+
                'ChangePlayerParam(MP,GetVar(IncMP));'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(Gained GetVar(IncMP) mana);'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(�������� GetVar(IncMP) ����);'+
        '"},'+
        'permanentATK:{'+
            'name:"permanentATK",'+
            'caption: {RU:"����� �����", ENG:"Potion of attack"},'+
            'description:{'+
                'RU:"�������� ��������� �����. ���������� ������.",'+
                'ENG:"Increases attack potential. Permanent effect."'+
            '},'+
            'script:"'+
                'ChangePlayerParam(ATK,1);'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(Gained +1 attack!);'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(�������� +1 � �����!);'+
        '"},'+
        'permanentDEF:{'+
            'name:"permanentDEF",'+
            'caption: {RU:"����� ������", ENG:"Potion of defence"},'+
            'description:{'+
                'RU:"�������� ���������� ������. ���������� ������.",'+
                'ENG:"Increases physical protection. Permanent effect."'+
            '},'+
            'script:"'+
                'ChangePlayerParam(DEF,1);'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(Gained +1 defence!);'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(�������� +1 � ������!);'+
        '"},'+
        'PermanentMDEF:{'+
            'name:"PermanentMDEF",'+
            'caption: {RU:"����� ���������� ������", ENG:"Potion of magic defence"},'+
            'description:{'+
                'RU:"�������� ������ �� ����� � �������������� �����������. ���������� ������.",'+
                'ENG:"Increases protection against magic and energetic influences. Permanent effect."'+
            '},'+
            'script:"'+
                'ChangePlayerParam(MDEF,1);'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(Gained +1 magic defence!);'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(�������� +1 ���������� ������!);'+
        '"},'+
        'exp:{'+
            'name:"exp",'+
            'caption: {RU:"����� �����", ENG:"Potion of experience"},'+
            'description:{'+
                'RU:"��������� ���� ���������� ����. ���������� �� 0 �� 100 ���������� �� ������� ������� ������.",'+
                'ENG:"Gives you a free experience instantly. A number between 0 and 100 multiplied by the players current level."'+
            '},'+
            'script:"'+
                'SetVar(EXP,Rand(GetPlayerAttr(LVL) * 100));'+
                'ChangePlayerParam(EXP,GetVar(EXP));'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(Gained GetVar(EXP) experience!);'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(�������� GetVar(EXP) �����!);'+
        '"},'+
        'regenHP:{'+
            'name:"regenHP",'+
            'caption: {RU:"���� ��������", ENG:"Ointment of health"},'+
            'description:{'+
                'RU:"���������� ��������������� ��������. ��������� �������������� �� 0 �� 500 ���������� �� ������� ������� ������.",'+
                'ENG:"Restores health over time. Recovery potential from 0 to 500 multiplied by the players current level."'+
            '},'+
            'script:"SetPlayerAutoBuff(HP,Rand(GetPlayerAttr(LVL) * 500));'+
        '"},'+
        'regenMP:{'+
            'name:"regenMP",'+
            'caption: {RU:"���� �������", ENG:"Ointment of mana"},'+
            'description:{'+
                'RU:"���������� ��������������� ����. ��������� �������������� �� 0 �� 500 ���������� �� ������� ������� ������.",'+
                'ENG:"Restores mana over time. Recovery potential from 0 to 500 multiplied by the players current level."'+
            '},'+
            'script:"SetPlayerAutoBuff(MP,Rand(GetPlayerAttr(LVL) * 50));'+
        '"},'+
        'buffATK:{'+
            'name:"buffATK",'+
            'caption: {RU:"������� �����", ENG:"Powder of attack"},'+
            'description:{'+
                'RU:"�������� �������� ��������� �����. ��������� ����� ������ ����� ������.",'+
                'ENG:"Temporarily increases attack potential. Decreases after each player attack."'+
            '},'+
            'script:"SetPlayerBuff(ATK,Rand(GetPlayerAttr(LVL)) + 1);'+
        '"},'+
        'buffDEF:{'+
            'name:"buffDEF",'+
            'caption: {RU:"������� ������", ENG:"Powder of defence"},'+
            'description:{'+
                'RU:"�������� �������� ��������� ������. ��������� ����� ������ ����� �� ������.",'+
                'ENG:"Temporarily increases attack potential. Decreases after each attack on the player."'+
            '},'+
            'script:"SetPlayerBuff(DEF,Rand(GetPlayerAttr(LVL)) + 1);'+
        '"},'+
        'buffMDEF:{'+
            'name:"buffMDEF",'+
            'caption: {RU:"������� ���������� ������", ENG:"Powder of magic defence"},'+
            'description:{'+
                'RU:"�������� �������� ��������� ���������� ������. ��������� ����� ������� ����������� ��� ��������������� ����������� �� ������.",'+
                'ENG:"Temporarily increases the potential of magic protection. Decreases after each magical or energy impact on the player."'+
            '},'+
            'script:"SetPlayerBuff(MDEF,Rand(GetPlayerAttr(LVL)) + 1);'+
        '"},'+
        'buffEXP:{'+
            'name:"buffEXP",'+
            'caption: {RU:"������� �����", ENG:"Powder of experience"},'+
            'description:{'+
                'RU:"�������� �������� ��������� ��������� �����. ��������� ����� ������� ��������� ����� �������.",'+
                'ENG:"Temporarily increases the potential for gaining experience. Decreased after each player gains experience."'+
            '},'+
            'script:"SetPlayerBuff(EXP,Rand(GetPlayerAttr(LVL)) + 1);'+
        '"},'+
        'buffREG:{'+
            'name:"buffREG",'+
            'caption: {RU:"������� �����������", ENG:"Powder of regeneration"},'+
            'description:{'+
                'RU:"�������� �������� ���� ������� �����������. ��������� ����� ������ �����������.",'+
                'ENG:"Temporarily increases the strength of the regeneration effect. Decreases after each regeneration."'+
            '},'+
            'script:"SetPlayerBuff(REG,Rand(GetPlayerAttr(LVL) * 10) + 10);'+
        '"},'+
        'autoAction:{'+
            'name:"autoAction",'+
            'caption: {RU:"����� ������������", ENG:"Potion of autoactions"},'+
            'description:{'+
                'RU:"��������� ������������. ������ �� 0 �� 100 ���������� �� ������� ������, �� �� ������ 2000.",'+
                'ENG:"Adds auto-actions. The effect is from 0 to 100 multiplied by the players level, but not more than 2000."'+
            '},'+
            'script:"ChangeAutoATK(Rand(Min(GetPlayerAttr(LVL) * 100, 2000)));'+
        '"}'+
    '},'+


    /// cost - ��������� ��������� � ���� �� ������� �����
    /// lvl - ��������� ��������� � ���� �� ������� �����
    /// isActivated - ������������ ��� ��������� �����
    /// isEnabled - �������� �� ��� ������������� (����� �� ������������ � ������ ���������)
    'skills:{'+
        'healing:{'+
            'caption:{RU:"�������",ENG:"Healing"},isActivated: true, '+
            'description:{'+
                'RU:"��������������� �������� ����. ������ �� 0 �� 50 ���������� �� ������� ������. ��������� 20 ���� �� ������� ������.",'+
                'ENG:"Restores the targets health. The effect is from 0 to 50 multiplied by the skill level. Cost 20 mana per skill level."'+
            '},'+
            'script:"'+
                'SetVar(IncHP,Rand(GetSkillLvl(healing) * 50));'+
                'ChangeTargetParam(HP,GetVar(IncHP));'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(�arget gets GetVar(IncHP) health);'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(���� ������� GetVar(IncHP) ��������);'+
        '"},'+
        'explosion:{'+
            'caption:{RU:"�����",ENG:"Explosion"},isActivated: true, '+
            'description:{'+
                'RU:"������� ���� ���������� ����. ������ �� 0 �� 300 ���������� �� ������� ������. ��������� 50 ���� �� ������� ������.",'+
                'ENG:"Deals magic damage to the target. The effect is from 0 to 300 multiplied by the skill level. Cost 50 mana per skill level."'+
            '},'+
            'script:"'+
                'SetVar(Expl,Rand(GetSkillLvl(explosion) * 300));'+
                'ChangeTargetParam(HP,-GetVar(Expl));'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(Target take GetVar(Expl) damage!);'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(���� ������� GetVar(Expl) �����!);'+
        '"},'+
        'heroism:{'+
            'caption:{RU:"�������",ENG:"Heroism"},isActivated: true, '+
            'description:{'+
                'RU:"�������� �������� ��������� ����: �����, ������ � ���������� ������. ������ �� 0 �� 5 ���������� �� ������� ������. ��������� 20 ���� �� ������� ������.",'+
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
                'AddEvent(���� �������� �������� ����� � ������ �� GetVar(value));'+
        '"},'+
        'breakDEF:{'+
            'caption:{RU:"�������� ������",ENG:"Defence break"},isActivated: true, '+
            'description:{'+
                'RU:"������� �������� ������ ����. ������ �� 0 �� 10 ���������� �� ������� ������. ��������� 15 ���� �� ������� ������.",'+
                'ENG:"Reduces the value of target defence. The effect is from 0 to 10 multiplied by the skill level. Cost 15 mana per skill level."'+
            '},'+
            'script:"'+
                'SetVar(value,Rand(GetSkillLvl(breakDEF) * 10));'+
                'ChangeTargetParam(DEF,-GetVar(value));'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(Target defense reduced by GetVar(value));'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(������ ���� ������� �� GetVar(value));'+
        '"},'+
        'breakMDEF:{'+
            'caption:{RU:"�������� ���������� ������",ENG:"Magic defence break"},isActivated: true, '+
            'description:{'+
                'RU:"������� �������� ���������� ������ ����. ������ �� 0 �� 10 ���������� �� ������� ������. ��������� 15 ���� �� ������� ������.",'+
                'ENG:"Reduces the value of target magic defence. The effect is from 0 to 10 multiplied by the skill level. Cost 15 mana per skill level."'+
            '},'+
            'script:"'+
                'SetVar(value,Rand(GetSkillLvl(breakMDEF) * 10));'+
                'ChangeTargetParam(MDEF,-GetVar(value));'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(Target magic defense reduced by GetVar(value));'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(���������� ������ ���� ������� �� GetVar(value));'+
        '"},'+
        'breakATK:{'+
            'caption:{RU:"������",ENG:"Injury"},isActivated: true, '+
            'description:{'+
                'RU:"������� ����� ����. ������ �� 0 �� 5 ���������� �� ������� ������. ��������� 30 ���� �� ������� ������.",'+
                'ENG:"Reduces target attack. The effect is from 0 to 5 multiplied by the skill level. Cost of 30 mana per skill level."'+
            '},'+
            'script:"'+
                'SetVar(value,Rand(GetSkillLvl(breakATK) * 5));'+
                'ChangeTargetParam(ATK,-GetVar(value));'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(Target attack reduced by GetVar(value));'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(����� ���� ������� �� GetVar(value));'+
        '"},'+
        'leakMP:{'+
            'caption:{RU:"������ ����",ENG:"Mana leak"},isActivated: true, '+
            'description:{'+
                'RU:"�������� � ���� ����, �� �� ������ ���������� ����������. ����� �������� �������� ����� ����������. ������ �� 0 �� 30 ���������� �� ������� ������. ��������� 10 ���� �� �������.",'+
                'ENG:"It takes away mana from the target, but not more than the available amount. The player receives half of this amount. The effect is from 0 to 30 multiplied by the skill level. Cost 10 mana per level."'+
            '},'+
            'script:"'+
                'SetVar(leak,Rand(GetSkillLvl(leakMP) * 30));'+  // ������� �������� ������� �����
                'SetVar(monsterMP,GetTargetAttr(MP));'+           // ������� ���� � �������

                'IF(GetVar(leak) >= GetVar(monsterMP), 3);'+        // ���� �������� ������, ��� ����
                'SetVar(leak, GetVar(monsterMP) / 2);'+          // ���������� ������� = �������� �� ����������
                'ChangeTargetParam(MP,-GetVar(monsterMP));'+     // �������� � ������� ���
                'ChangePlayerParam(MP,GetVar(leak));'+             // ����� �������� ����

                'IF(GetVar(leak) < GetVar(monsterMP), 4);'+        // ���� �������� ������ ��� ����
                'SetVar(monsterMP, GetVar(leak));'+                // ������ ����� ������ � ������ ������
                'SetVar(leak, GetVar(leak) / 2);'+               // ����� ������� �������� �� ����������
                'ChangeTargetParam(MP,-GetVar(monsterMP));'+     // ������ ������
                'ChangePlayerParam(MP,GetVar(leak));'+             // ����� ��������

                'If(GetLang() = ENG, 2);'+
                'AddEvent(Target lost GetVar(monsterMP) mana);'+   // ������ ������
                'AddEvent(Player got GetVar(leak) mana);'+
                'If(GetLang() = RU, 2);'+
                'AddEvent(���� �������� GetVar(monsterMP) ����);'+   // ������ ������
                'AddEvent(����� ������� GetVar(leak) ����);'+
        '"},'+
        'vampireStrike:{'+
            'caption:{RU:"���� �������",ENG:"Strike if vampire"},isActivated: true, '+
            'description:{'+
                'RU:"�������� � ���� ��������, �� �� ������ ���������� ����������. ����� �������� �������� ����� ����������. ������ �� 0 �� 20 ���������� �� ������� ������. ��������� 10 ���� �� �������.",'+
                'ENG:"It takes away health from the target, but not more than the available amount. The player receives half of this amount. The effect is from 0 to 20 multiplied by the skill level. Cost 10 mana per level."'+
            '},'+
            'script:"'+
                'SetVar(leak,Rand(GetSkillLvl(vampireStrike) * 20));'+  // ������� �������� ������� �����
                'SetVar(monsterHP,GetTargetAttr(HP));'+           // ������� ���� � �������

                'IF(GetVar(leak) >= GetVar(monsterHP), 3);'+        // ���� �������� ������, ��� ����
                'SetVar(leak, GetVar(monsterHP) / 2);'+          // ���������� ������� = �������� �� ����������
                'ChangeTargetParam(HP,-GetVar(monsterHP));'+     // �������� � ������� ���
                'ChangePlayerParam(HP,GetVar(leak));'+             // ����� �������� ����

                'IF(GetVar(leak) < GetVar(monsterHP), 4);'+        // ���� �������� ������ ��� ����
                'SetVar(monsterHP, GetVar(leak));'+                // ������ ����� ������ � ������ ������
                'SetVar(leak, GetVar(leak) / 2);'+               // ����� ������� �������� �� ����������
                'ChangeTargetParam(HP,-GetVar(monsterHP));'+     // ������ ������
                'ChangePlayerParam(HP,GetVar(leak));'+             // ����� ��������

                'If(GetLang() = ENG, 2);'+
                'AddEvent(Target lost GetVar(monsterHP) health);'+   // ������ ������
                'AddEvent(Player got GetVar(leak) health);'+
                'If(GetLang() = RU, 2);'+
                'AddEvent(���� �������� GetVar(monsterHP) ��������);'+   // ������ ������
                'AddEvent(����� ������� GetVar(leak) ��������);'+
        '"},'+
        'metabolism:{'+
            'caption:{RU:"����������",ENG:"Metabolism"},isActivated: true, '+
            'description:{'+
                'RU:"�������� �������� ���� ������� �����������. ������ �� 0 �� 5 ���������� �� ������� ������. ��������� 10 ���� �� �������.",'+
                'ENG:"Temporarily increases the strength of the regeneration effect. The effect is from 0 to 5 multiplied by the skill level. Cost 10 mana per level."'+
            '},'+
            'script:"'+
                'SetVar(value,Rand(GetSkillLvl(metabolism) * 5) + 10);'+
                'SetTargetBuff(REG,GetVar(value));'+
                'If(GetLang() = ENG, 1);'+
                'AddEvent(Target speed up regeneration by GetVar(value));'+
                'If(GetLang() = RU, 1);'+
                'AddEvent(����������� ���� ��������� �� GetVar(value));'+
        '"}'+
    '},'+



    /// isAllow - �������� �� ��� �������������
    /// lvl - ������� ������� �����������
    'tools:{'+
        'shovel:{'+
            'caption: {RU:"������",ENG:"Shovel"},'+
            'desc: {RU:"��������� ������� ���������� �����",ENG:"Allows you to clear trash faster."},'+
            'script: "SetVar(SHOVEL_LVL, GetVar(SHOVEL_LVL) + 1);"'+
        '},'+
        'pick:{'+
            'caption: {RU:"�����",ENG:"Pick"},'+
            'desc: {RU:"��������� ������� ��������� ������.",ENG:"Allows you to quickly disassemble blockage."},'+
            'script: "SetVar(PICK_LVL, GetVar(PICK_LVL) + 1);"'+
        '},'+
        'axe:{'+
            'caption: {RU:"�����",ENG:"Axe"},'+
            'desc: {RU:"��������� ������� ��������� �����.",ENG:"Allows you to break boxes faster."},'+
            'script: "SetVar(AXE_LVL, GetVar(AXE_LVL) + 1);"'+
        '},'+
        'lockpick:{'+
            'caption: {RU:"�������",ENG:"Lockpick"},'+
            'desc: {RU:"��������� ������� ��������� �������.",ENG:"Allows you to open chests faster."},'+
            'script: "SetVar(KEY_LVL, GetVar(KEY_LVL) + 1);"'+
        '},'+
        'sword:{'+
            'caption: {RU:"���",ENG:"Sword"},'+
            'desc: {RU:"����������� ����������� ���� �� �� ���� ������� �����.",ENG:"Increases minimum damage but not higher than the current attack."},'+
            'script: "SetVar(SWORD_LVL, GetVar(SWORD_LVL) + 1);"'+
        '},'+
        'lifeAmulet:{'+
            'caption: {RU:"������ ��������",ENG:"Amulet of Health"},'+
            'desc: {RU:"��� ����������� ��������� +100 �������� �� �������.",ENG:"Adds +100 HP per level upon respawn."},'+
            'script: "SetVar(LIFEAMULET_LVL, GetVar(LIFEAMULET_LVL) + 1);"'+
        '},'+
        'timeSand:{'+
            'caption: {RU:"����� �������",ENG:"Sand of Time"},'+
            'desc: {RU:"�������� ������������ �� 3% �� �������.",ENG:"Speeds up Auto Actions by 3% per level."},'+
            'script: "SetVar(TIMESAND_LVL, [GetVar(TIMESAND_LVL) + 3]);"'+
        '},'+
        'leggings:{'+
            'caption: {RU:"������",ENG:"Leggings"},'+
            'desc: {RU:"����������� ���� �������� ������� ������� ���� ������ � �.�. �� 3% �� �������.",ENG:"Increases the chance to avoid the effect of traps rats spiders etc. 3% per level."},'+
            'script: "SetVar(LEGGINGS_LVL, GetVar(LEGGINGS_LVL) + 3);"'+
        '},'+
        'wisdom:{'+
            'caption: {RU:"����� ��������",ENG:"Circle of Wisdom"},'+
            'desc: {RU:"��������� ����� � ��������� ������� �������� ����� ����.",ENG:"Clarifies thoughts and allows you to find new ideas faster."},'+
            'script: "SetVar(WISDOM_LVL, GetVar(WISDOM_LVL) + 1);"'+
        '},'+
        'resist:{'+
            'caption: {RU:"������ �������������",ENG:"Ring of resistance"},'+
            'desc: {RU:"����������� �� 2% �� ������� ���� ������������� �������, ��������� ��������� ���������.",ENG:"Increases by 2% per level the chance to block effects that reduce character parameters."},'+
            'script: "SetVar(RESIST_LVL, GetVar(RESIST_LVL) + 2);"'+
        '},'+
        'expStone:{'+
            'caption: {RU:"������ �����",ENG:"Experience stone"},'+
            'desc: {RU:"�� 1 �� ������� ����������� ���������� ����.",ENG:"Increases experience gained by 1 per level."},'+
            'script: "SetVar(EXP_LVL, GetVar(EXP_LVL) + 2);"'+
        '}'+
    '},'+


    /// ������ ����� �� �������
    'targets:['+
        '{level: 1,script:"'+
             'ChangePlayerItemCount(Gold, 100000);'+
             'AddEvent(..................);'+

             'AddEvent(    �������� 100 000 ������);'+
             'AddEvent( );'+
             'AddEvent(\"���!\");'+
             'AddEvent(\"���� ������������� �������� ������� ��������� ������ ���������� ������� � ��������� ��� ��������� �������� �� ���� �������.\");'+
             'AddEvent(\"����������, �� ������ ������, ����������� ��������� � ����� �������.\");'+
             'AddEvent(\"��������� ��� ��������� ��������, �� ��� � �� ����� ��� ������. �� ����� ������ �� ���� ���� �� ����.\");'+
             'AddEvent( );'+
             'AddEvent(\"��� �� ������ �����. ������ ����� ������ �� ����. ����, ��� ������ �� ���� � ����� � ������ �� �������, '+
                 '�� ��� ���� ���������� �������. ������� ��� ��� �������. � ��� �� �� ����������� � �����, �����: ����� ����� �����! ������ �� � ����� ������� �� ����, �� � ����� ���������� ����� �����. �����, ��� ����!\");'+
             'AddEvent( );'+
             'AddEvent(\"� ������ ����� ������� �� � ������ ���������� �����:\");'+
             'AddEvent(\"����������� ��� ����� �������������� ��������� ��������� ������� � ������������ � ���� ��������.\");'+
             'AddEvent(\"���� �����������. ������ ������ ������ �� ������. � ������� ���� ������ ��������� �������� ������ � ���������, ������� ������� �����.\");'+
             'AddEvent(\"������� �����������, �� ���������, ��� ���������� � �����-�� ������� ������ ���������, ���������� ��������� ������.\");'+
             'AddEvent(\"� ������ �������, ������ ��������� �� �������� ������.\");'+
             'AddEvent(\"�� ���������� ����� � ��������� �� �������� ����.\");'+

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
             'AddEvent(    �������� GetVar(gold) ������);'+
             'AddEvent(    �������� ����� ��������!);'+
             'AddEvent( );'+
             'AddEvent(\"������� ��� ������� �������� �� ����!\");'+
             'AddEvent(\"���������. ����� �����, ����� ������ ������? ��� � ����� �����?\");'+
             'AddEvent( );'+
             'AddEvent(\"�, ����! � ������� ���� ������� � ����� ����� �����! ���� ����������� ������ �������! ���� �� ������ �� ��, ��� �� ����������, ������� ����������� ����� ��� �� ����� �������� � ������ �����... �, ����!..\");'+
             'AddEvent( );'+
             'AddEvent(\"������ � �������� ������� ������� �� ������, ��������� ������� ������� ������ � ������������� � ��������� �� �� ������! � ����, ��� �� �������� ���� ��������� ����, ����������� ������� �������.\");'+
             'AddEvent( );'+
             'AddEvent(\"������ ������ �������� ���� ����� ���� � �����, ����� �� ����������� ������. �� ���� ����� ���� �� �������� ��� ����� � ������ ��� �������.\");'+
             'AddEvent( );'+
             'AddEvent(\"��� ��, � ������� ����� ��������� ������ ������:\");'+
             'AddEvent(\"� ������ ������� ����� ������� ������� ������� ������.\");'+

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
             'AddEvent(�������� GetVar(count) ����� AutoAction);'+
             'AddEvent(� ������ ������� ����� ������� ������� ������� �����.);'+

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
             'AddEvent(�������� GetVar(iName)!);'+
             'If(GetLang() = ENG, 1);'+
             'AddEvent(Gained GetVar(iName)!);'+

             'SetVar(iName, GetRandItemName());'+
             'ChangePlayerItemCount(GetVar(iName), 1);'+
             'If(GetLang() = RU, 1);'+
             'AddEvent(�������� GetVar(iName)!);'+
             'If(GetLang() = ENG, 1);'+
             'AddEvent(Gained GetVar(iName)!);'+

             'SetVar(iName, GetRandItemName());'+
             'ChangePlayerItemCount(GetVar(iName), 1);'+
             'If(GetLang() = RU, 1);'+
             'AddEvent(�������� GetVar(iName)!);'+
             'If(GetLang() = ENG, 1);'+
             'AddEvent(Gained GetVar(iName)!);'+

             'SetVar(iName, GetRandItemName());'+
             'ChangePlayerItemCount(GetVar(iName), 1);'+
             'If(GetLang() = RU, 1);'+
             'AddEvent(�������� GetVar(iName)!);'+
             'If(GetLang() = ENG, 1);'+
             'AddEvent(Gained GetVar(iName)!);'+

             'SetVar(iName, GetRandItemName());'+
             'ChangePlayerItemCount(GetVar(iName), 1);'+
             'If(GetLang() = RU, 1);'+
             'AddEvent(�������� GetVar(iName)!);'+
             'If(GetLang() = ENG, 1);'+
             'AddEvent(Gained GetVar(iName)!);'+

             'AddEvent( );'+

             'If(GetLang() = RU, 1);'+
             'AddEvent(�������� �����! ����� ��������� �� � ������� ����...);'+
             'If(GetLang() = ENG, 1);'+
             'AddEvent(You have found a huge chest! The lock does not give in the first time ...);'+

             'AddEvent(..................);'+
             'SetNextTarget();'
        +'"},'+
        '{level: 5,script:"'+
             'SetBreak(Tower);'+

             'SetCreature('+
                 '{RUS:������ ������, ENG:DARK MASTER},'+
                 '{HP:9999, ATK:100, DEF:0, MAXHP:9999, MP:0, MDEF:0, REG:0},'+
                 '{SpiritBless:1}, );'+

             'AddEvent(..................);'+

             'IF(GetLang() = ENG, 3);'+
             'AddEvent(\" - YOU WILL NOT PASS!\");' +
             'AddEvent(\" - What are you doing in my Tower, insignificance!?\");' +
             'SetCreatureScript(OnDeath,\"AddEvent(..................);AddEvent(- You defeated ME!? Can not be! Who are You?!);AddEvent(..................);AddEvent( );AddEvent(    Player got Sword artifact!);AllowTool(Sword);SetNextTarget();\");'+

             'IF(GetLang() = RU, 3);'+
             'AddEvent(\" - �� �� ��������!\");' +
             'AddEvent(\" - ��� �� ������� � ���� �����, �����������!?\");' +
             'SetCreatureScript(OnDeath,\"SetBreak(Tower);AddEvent(..................);AddEvent(- �� ������� ����!? �� ����� ����! ��� �� �����!?);AddEvent(..................);AddEvent( );AddEvent(    ����� ������� �������� ���!);AllowTool(Sword);SetNextTarget();\");'+

             'AddEvent(..................);'
        +'"},'+
        '{level: 7,script:"'+
             'SetBreak(Tower);'+

             'SetCreature('+
                 '{RUS:������ ������, ENG:DARK MASTER},'+
                 '{HP:99999, ATK:1000, DEF:0, MAXHP:99999, MP:0, MDEF:0, REG:0},'+
                 '{SpiritBless:1}, );'+

             'AddEvent(..................);'+

             'IF(GetLang() = ENG, 3);'+
             'SetVar(DarkMaster,ANGRY DARK MASTER);'+
             'AddEvent(\" - This is our last meeting, stranger! You will not leave my Tower!\");' +
             'SetCreatureScript(OnDeath,\"AddEvent(..................);AddEvent(- You defeated ME!? Can not be! Who are You?!);AddEvent(..................);SetNextTarget();\");'+

             'IF(GetLang() = RU, 3);'+
             'SetVar(DarkMaster,���� ������ ������);'+
             'AddEvent(\" - ��� ���� ��������� �������, �����! �� �� ������� �� ���� �����!\");' +
             'SetCreatureScript(OnDeath,\"AddEvent(..................);AddEvent(- �� ������� ����!? �� ����� ����! ��� �� �����!?);AddEvent(..................);SetNextTarget();\");'+

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
             'AddEvent(\" - �� �������� � ��� �����, ������� ��������, ��������� �������. �� ��� �� ����� ����� �����!?\");' +
             'AddEvent(\" - ��� ������ ����� ���� ��������� �������!\");' +
             'SetCreatureScript(OnDeath,\"AddEvent(..................);AddEvent(- �� ������� ����!? �� ����� ����! ��� �� �����!?);AddEvent(..................);SetNextTarget();\");'+

             'SetCreature('+
                 '{RUS:������ ������, ENG:DARK MASTER},'+
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
             'AddEvent(!!! ���������� !!!);' +
             'AddEvent(!!! �� ������ ���� !!!);' +
             'AddEvent(..................);'+

             'CurrentLevel(1);InitCreatures();'
        +'"}'+
    '],'+



    /// �����������
    'thinks:{'+
    '},'+



    /// ����� ��� ��������
    'names:{'+
        'count: 40,'+
        'first:['+
            '{RU:"��������",ENG:"Stoned"},{RU:"�������",ENG:"Strong"},{RU:"��������",ENG:"Brave"},{RU:"��������",ENG:"Northern"},{RU:"����������",ENG:"Doomed"},'+
            '{RU:"�������",ENG:"Local"},{RU:"��������",ENG:"Insidious"},{RU:"������������",ENG:"Great"},{RU:"������������",ENG:"Deadly"},{RU:"������",ENG:"Accurate"},'+
            '{RU:"��������",ENG:"Hungry"},{RU:"�������",ENG:"Heavy"},{RU:"������",ENG:"Sleepy"},{RU:"������",ENG:"Holy"},{RU:"�����",ENG:"Bold"},'+
            '{RU:"�������",ENG:"Gas"},{RU:"��������",ENG:"Beautiful"},{RU:"�����������",ENG:"Similar"},{RU:"�����������",ENG:"Ugly"},{RU:"����������",ENG:"Glassy"},'+
            '{RU:"������",ENG:"Warm"},{RU:"�����������",ENG:"Modern"},{RU:"�����",ENG:"Narrow"},{RU:"����������",ENG:"Unpleasant"},{RU:"�������",ENG:"Dead"},'+
            '{RU:"��������",ENG:"Finite"},{RU:"��������",ENG:"Main"},{RU:"���������",ENG:"Possible"},{RU:"��������",ENG:"Evening"},{RU:"������������",ENG:"Physical"},'+
            '{RU:"����������",ENG:"Previous"},{RU:"��������",ENG:"Cold"},{RU:"�������",ENG:"Convenient"},{RU:"�����������",ENG:"Efficient"},{RU:"��������",ENG:"Genuine"},'+
            '{RU:"�������",ENG:"Good"},{RU:"����������",ENG:"Monstrous"},{RU:"�������",ENG:"Green"},{RU:"�����",ENG:"Any"},{RU:"������",ENG:"Prominent"}'+
        '],'+
        'middle:['+
            '{RU:"����",ENG:"Freak"},{RU:"�����",ENG:"Major"},{RU:"��������",ENG:"Seeker"},{RU:"������",ENG:"Dweller"},{RU:"���������",ENG:"Crusher"},'+
            '{RU:"������",ENG:"Wall"},{RU:"�����",ENG:"Mattress"},{RU:"�������",ENG:"Minister"},{RU:"������",ENG:"Greedy"},{RU:"�����",ENG:"Army"},'+
            '{RU:"��������",ENG:"Drinker"},{RU:"���������",ENG:"Result"},{RU:"������",ENG:"Peptide"},{RU:"������",ENG:"Soldier"},{RU:"����������",ENG:"Cutter"},'+
            '{RU:"������",ENG:"Air"},{RU:"������",ENG:"Kawaii"},{RU:"����",ENG:"Bird"},{RU:"������",ENG:"Winner"},{RU:"�������������",ENG:"Follower"},'+
            '{RU:"�����",ENG:"Tail"},{RU:"�������",ENG:"Gift"},{RU:"�������",ENG:"Bag"},{RU:"�����������",ENG:"System"},{RU:"����",ENG:"Tank"},'+
            '{RU:"������",ENG:"Crisis"},{RU:"������",ENG:"Mass"},{RU:"�����������",ENG:"Dream"},{RU:"�������",ENG:"Future"},{RU:"��������",ENG:"Fate"},'+
            '{RU:"������",ENG:"Suit"},{RU:"�����������",ENG:"Doom"},{RU:"�����",ENG:"Word"},{RU:"����������",ENG:"Power"},{RU:"�����������",ENG:"Relative"},'+
            '{RU:"�������",ENG:"Machine"},{RU:"����",ENG:"Brain"},{RU:"����",ENG:"Horror"},{RU:"���",ENG:"Smoke"},{RU:"������",ENG:"Steel"}'+
        '],'+
        'last:['+
            '{RU:"�����������",ENG:"of Hospital"},{RU:"�������������",ENG:"of Betrayal"},{RU:"of Hell",ENG:"of Hell"},{RU:"����������",ENG:"of Bliss"},'+
            '{RU:"���� �����",ENG:"of Worlds"},{RU:"�������������",ENG:"of Misunderstanding"},{RU:"����������",ENG:"of Dungeons"},{RU:"�������������",ENG:"of Infinity"},'+
            '{RU:"�����",ENG:"of Forest"},{RU:"���������",ENG:"of Wealth"},{RU:"�������",ENG:"of Madness"},{RU:"������",ENG:"of Poverty"},'+
            '{RU:"����",ENG:"of Mistery"},{RU:"���������",ENG:"of Holiday"},{RU:"�������������",ENG:"of Hopeless"},{RU:"������",ENG:"of Despondency"},'+
            '{RU:"��������",ENG:"of Heroism"},{RU:"�����",ENG:"of Luck"},{RU:"���������",ENG:"of Deceit"},{RU:"�������",ENG:"of Replay"},'+
            '{RU:"��������",ENG:"of Agreement"},{RU:"������",ENG:"of Weapon"},{RU:"Crisis",ENG:"of �������"},{RU:"�����",ENG:"of Spring"},'+
            '{RU:"������",ENG:"of Heart"},{RU:"����",ENG:"of Body"},{RU:"�������",ENG:"of Girlfriend"},{RU:"�������",ENG:"of Childhood"},'+
            '{RU:"��������",ENG:"of Conscious"},{RU:"������������",ENG:"of Memory"},{RU:"���������",ENG:"of Support"},{RU:"������",ENG:"of Stars"},'+
            '{RU:"����",ENG:"of Essence"},{RU:"�����",ENG:"of Scene"},{RU:"��������",ENG:"of Doubt"},{RU:"�����",ENG:"of Risk"},'+
            '{RU:"����������",ENG:"of Reality"},{RU:"������",ENG:"of Guard"},{RU:"��������",ENG:"of Murders"},{RU:"����",ENG:"of Path"}'+
        ']'+
    '},'+

    '}';


var
    DIR_DATA :string;


implementation

initialization
    DIR_DATA := ExtractFilePath( paramstr(0) ) + FOLDER_DATA;

end.



















