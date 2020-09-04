unit uTypes;

interface

const
    // индексы предметов в массиве items
    I_GOLD    = 0;
    I_HEAL    = 1;
    I_MANA    = 2;
    I_EXPLO   = 3;
    I_REGHP   = 4;
    I_REGMP   = 5;
    I_AUTOATK = 6;
    I_ATK     = 7;
    I_DEF     = 8;
    I_PATK    = 9;
    I_PDEF    = 10;
    I_EXP     = 11;

const
    objShablon =
        '{"autobuffs":{},"params":{},"items":{},"events":{},"loot":{},"skills":{},"buffs":{}}';

type

    TCreature = class
        Name                // уникальное имя
       ,Params              // базовые параметры: уровень, здоровье, мана, атака и т.п.
       ,Buffs               // баффы к чему угодно имя_бафа=количество_использований
       ,AutoBuffs           // автобаффы к чему угодно имя_бафа=количество_использований
       ,Items               // расходные предметы для использования
       ,Loot                // расходные материалы для крафта
       ,Skills              // активируемые за ману скилы/заклинания

       ,Events              // скрипты на различные события в игре (боевые, глобальные и т.п.)
                 : string;
    end;

    TItem = record
        name: string;
        cost: integer;  // стоимость в мане или условная стоимость в ресурсах
        craft: string; // набор ресурсов для крафта
        isCraftAllow: boolean; // признак доступности для крафта
        isUseAllow: boolean; // признак доступности для использования
        script: string;
    end;

    TRes = record
        name: string;     // мультиязычное имя ресурса
        rarity: integer;  // редкость ресурса. чем меньше, тем реже. используется
                          // в механизме определения случайного ресурса,
                          // а так же при определении ценности
        cost: integer;    // условная ценность ресурса исходя из его rarity.
                          // = сумма rarity всех ресурсов деленная на rarity конкретного ресурса
    end;

var
    name1 : array [0..39,0..1] of string = (
        ('Stoned',      'Упоротый'),          ('Strong',     'Сильный'),
        ('Brave',       'Отважный'),          ('Northern',   'Северный'),
        ('Doomed',      'Обреченный'),        ('Local',      'Местный'),
        ('Insidious',   'Коварный'),          ('Great',      'Великолепный'),
        ('Deadly',      'Смертоносный'),      ('Accurate',   'Точный'),
        ('Hungry',      'Голодный'),          ('Heavy',      'Тяжелый'),
        ('Sleepy',      'Сонный'),            ('Holy',       'Святой'),
        ('Bold',        'Лысый'),             ('Gas',        'Газовый'),
        ('Beautiful',   'Красивый'),          ('Similar',    'Аналогичный'),
        ('Ugly',        'Безобразный'),       ('Glassy',     'Стеклянный'),

        ('Warm',        'Теплый'),            ('Modern',     'Современный'),
        ('Narrow',      'Узкий'),             ('Unpleasant', 'Неприятный'),
        ('Dead',        'Мертвый'),           ('Finite',     'Конечный'),
        ('Main',        'Основной'),          ('Possible',   'Возможный'),
        ('Evening',     'Вечерний'),          ('Physical',   'Материальный'),
        ('Previous',    'Предыдущий'),        ('Cold',       'Холодный'),
        ('Convenient',  'Удобный'),           ('Efficient',  'Эффективный'),
        ('Genuine',     'Истинный'),          ('Good',       'Хороший'),
        ('Monstrous',   'Чудовищный'),        ('Green',      'Зеленый'),
        ('Any',         'Любой'),             ('Prominent',  'Видный')
        );

    name2 : array [0..39,0..1] of string = (
        ('Freak',       'Урод'),              ('Major',      'Майор'),
        ('Seeker',      'Искатель'),          ('Dweller',    'Житель'),
        ('Crusher',     'Крашер'),            ('Wall',       'Барьер'),
        ('Mattress',    'Тюфяк'),             ('Minister',   'Министр'),
        ('Greedy',      'Жадина'),            ('Regiment',   'Полк'),
        ('Drinker',     'Выпивоха'),          ('Result',     'Результат'),
        ('Peptide',     'Пептид'),            ('Soldier',    'Солдат'),
        ('Cutter',      'Отсекатель'),        ('Air',        'Воздух'),
        ('Kawaii',      'НяшМяш'),            ('Bird',       'Птиц'),
        ('Winner',      'Крутыш'),            ('Follower',   'Последователь'),

        ('Tail',        'Хвост'),             ('Gift',       'Подарок'),
        ('Bag',         'Чемодан'),           ('System',     'Закрыватель'),
        ('Tank',        'Танк'),              ('Crisis',     'Кризис'),
        ('Mass',        'Массив'),            ('Dream',      'Разжигатель'),
        ('Future',      'Призрак'),           ('Fate',       'Фаталист'),
        ('Suit',        'Костюм'),            ('Doom',       'Разрушитель'),
        ('Word',        'Образ'),             ('Power',      'Властитель'),
        ('Relative',    'Родственник'),       ('Machine',    'Аппарат'),
        ('Brain',       'Мозг'),              ('Horror',     'Ужас'),
        ('Smoke',       'Дым'),               ('Steel',      'Металл')
        );

    name3 : array [0..39,0..1] of string = (
        ('of Hospital', 'Поликлиники'),       ('of Betrayal',         'Предательства'),
        ('of Hell',     'Ада'),               ('of Bliss',            'Блаженства'),
        ('of Worlds',   'Иных миров'),        ('of Misunderstanding', 'Недоразумения'),
        ('of Dungeons', 'Подземелий'),        ('of Infinity',         'Бесконечности'),
        ('of Forest',   'Лесов'),             ('of Wealth',           'Богатства'),
        ('of Madness',  'Безумия'),           ('of Poverty',          'Нищеты'),
        ('of Mistery',  'Тайн'),              ('of Holiday',          'Праздника'),
        ('of Hopeless', 'Безнадежности'),     ('of Despondency',      'Уныния'),
        ('of Heroism',  'Героизма'),          ('of Luck',             'Удачи'),
        ('of Deceit',   'Коварства'),         ('of Replay',           'Повтора'),

        ('of Agreement',  'Договора'),        ('of Weapon',    'Оружия'),
        ('of Crisis',     'Кризиса'),         ('of Spring',    'Весны'),
        ('of Heart',      'Сердца'),          ('of Body',      'Тела'),
        ('of Girlfriend', 'Подруги'),         ('of Childhood', 'Детства'),
        ('of Conscious',  'Сознания'),        ('of Memory',    'Воспоминаний'),
        ('of Support',    'Поддержки'),       ('of Stars',     'Звезды'),
        ('of Essence',    'Сути'),            ('of Scene',     'Сцены'),
        ('of Doubt',      'Сомнений'),        ('of Risk',      'Риска'),
        ('of Reality',    'Реальности'),      ('of Guard',     'Охраны'),
        ('of Murders',    'Убийства'),        ('of Path',      'Пути')
    );

    arrRes: array [0..9] of TRes = (
        (name:'{"RU":"Дерево","ENG":"Wood"}';      rarity: 10;  cost:  5),
        (name:'{"RU":"Камень","ENG":"Stone"}';     rarity: 10;  cost:  5),
        (name:'{"RU":"Трава","ENG":"Herbal"}';     rarity:  8;  cost:  6),
        (name:'{"RU":"Зерно","ENG":"Wheat"}';      rarity:  6;  cost:  8),
        (name:'{"RU":"Мясо","ENG":"Meat"}';        rarity:  4;  cost: 13),
        (name:'{"RU":"Кровь","ENG":"Blood"}';      rarity:  3;  cost: 17),
        (name:'{"RU":"Кость","ENG":"Bone"}';       rarity:  3;  cost: 17),
        (name:'{"RU":"Шкура","ENG":"Skin"}';       rarity:  3;  cost: 17),
        (name:'{"RU":"Руда","ENG":"Ore"}';         rarity:  2;  cost: 25),
        (name:'{"RU":"Эссенция","ENG":"Essence"}'; rarity:  1;  cost: 50)
    );
    resSummRarity: integer;

    // предметы-расходники. в механике имеют разные уровни силы
    items: array [0..14] of TItem = (
        (name:   'Gold';
         cost:    0;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script:
                 'SetTarget(Player);' +
                 'If([GetItemCount(Gold) < 10000], 5);'+       // если золота не достаточно
                 'If([GetLang() = RU], 1);'+                   // если золота не достаточно
                 'AddEvent(У игрока не достаточно золота! Требуется 10 000 золота);'+ // ругаемся и
                 'If([GetLang() = ENG], 1);'+                  // если золота не достаточно
                 'AddEvent(Player do not have enougth Gold! Cost 10 000 Gold);'+ // ругаемся и
                 'ChangeItemCount(Gold, 1);'+                  // компенсируем расход 1 золота за неудачное использование

                 'If([GetItemCount(Gold) > 9999], 7);'+         // если золота достаточно
                 'SetVar(iName, GetRandItemName());'+           // получаем имя случайного предмета
                 'ChangeItemCount(GetVar(iName), 1);'+          // добавляем единицу в инвентарь
                 'ChangeItemCount(Gold, -9999);'+               // списываем деньги с учетом того, что 1 спишется за использование золота как предмета
                 'If([GetLang() = RU], 1);'+                    // если золота не достаточно
                 'AddEvent(Игрок получил GetVar(iName)!);'+     // радуем игрока приобретением
                 'If([GetLang() = ENG], 1);'+                   // если золота не достаточно
                 'AddEvent(Player get GetVar(iName)!);'         // радуем игрока приобретением
        ) // золото

       ,(name:   'RestoreHealth';
         cost:    100;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'SetVar(IncHP,Rand([GetPlayerAttr(LVL) * 100]));'+
                 'ChangePlayerParam(HP,GetVar(IncHP));'+
                 'If([GetLang() = ENG], 1);'+
                 'AddEvent(Player restore GetVar(IncHP) HP);'+
                 'If([GetLang() = RU], 1);'+
                 'AddEvent(Игрок восстановил GetVar(IncHP) HP);'
        ) // зелье лечения

       ,(name:   'RestoreMana';
         cost:    250;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'SetVar(IncMP,Rand([GetPlayerAttr(LVL) * 20]));'+
                 'ChangePlayerParam(MP,GetVar(IncMP));'+
                 'If([GetLang() = ENG], 1);'+
                 'AddEvent(Player restore GetVar(IncMP) MP);'+
                 'If([GetLang() = RU], 1);'+
                 'AddEvent(Игрок восстановил GetVar(IncMP) MP);'
         ) // зелье восстановления маны

       ,(name:   'PermanentATK';
         cost:    200;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'ChangePlayerParam(ATK,1);'+
                 'If([GetLang() = ENG], 1);'+
                 'AddEvent(Player get +1 ATK permanently!);'+
                 'If([GetLang() = RU], 1);'+
                 'AddEvent(Игрок получил +1 ATK!);'
        ) // зелье постоянного повышения атаки

       ,(name:   'PermanentDEF';
         cost:    200;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'ChangePlayerParam(DEF,1);'+
                 'If([GetLang() = ENG], 1);'+                   // если золота не достаточно
                 'AddEvent(Player get +1 DEF permanently!);'+
                 'If([GetLang() = RU], 1);'+                    // если золота не достаточно
                 'AddEvent(Игрок получил +1 DEF!);'
        ) // зелье постоянного повышения защиты

       ,(name:   'PermanentMDEF';
         cost:    200;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'ChangePlayerParam(MDEF,1);'+
                 'If([GetLang() = ENG], 1);'+                   // если золота не достаточно
                 'AddEvent(Player get +1 MDEF permanently!);'+
                 'If([GetLang() = RU], 1);'+                    // если золота не достаточно
                 'AddEvent(Игрок получил +1 MDEF!);'
        ) // зелье постоянного повышения магической защиты

       ,(name:   'EXP';
         cost:    100;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'SetVar(EXP,Rand([GetPlayerAttr(LVL) * 100]));'+
                 'ChangePlayerParam(EXP,GetVar(EXP));'+
                 'If([GetLang() = ENG], 1);'+                   // если золота не достаточно
                 'AddEvent(Player get +GetVar(EXP) EXP!);'+
                 'If([GetLang() = RU], 1);'+                    // если золота не достаточно
                 'AddEvent(Игрок получил + GetVar(EXP) EXP!);'
        ) // зелье разового получения опыта
{
       ,(name:   'REG';
         cost:    10000;
         script: 'ChangePlayerParam(REG,1);'+
                 'AddEvent(Player get +1 Regen permanently!)'
        ) // зелье постоянного повышения магической защиты
}


       ,(name:   'RegenHP';
         cost:    300;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'SetPlayerAutoBuff(HP,Rand([GetPlayerAttr(LVL) * 500]));'
        ) // зелье регенерации здоровья

       ,(name:   'RegenMP';
         cost:    500;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'SetPlayerAutoBuff(MP,Rand([GetPlayerAttr(LVL) * 50]));'
        ) // зелье регенерации маны



       ,(name:   'BuffATK';
         cost:    100;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'SetPlayerBuff(ATK,[Rand(GetPlayerAttr(LVL)) + 1]);'
        ) // зелье временного повышения атаки

       ,(name:   'BuffDEF';
         cost:    100;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'SetPlayerBuff(DEF,[Rand(GetPlayerAttr(LVL)) + 1]);'
        ) // зелье временного повышения защиты

       ,(name:   'BuffMDEF';
         cost:    100;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'SetPlayerBuff(MDEF,[Rand(GetPlayerAttr(LVL)) + 1]);'
        ) // зелье временного прироста опыта

       ,(name:   'BuffEXP';
         cost:    100;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'SetPlayerBuff(EXP,[Rand(GetPlayerAttr(LVL)) + 1]);'
        ) // зелье временного прироста опыта

       ,(name:   'BuffREG';
         cost:    100;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'SetPlayerBuff(REG,[Rand([GetPlayerAttr(LVL) * 10]) + 10]);'
        ) // зелье временного прироста опыта



       ,(name:   'AutoAction';
         cost:    1000;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'ChangeAutoATK(Rand(Min([GetPlayerAttr(LVL) * 100], 2000)));'
        ) // зелье автоматической атаки
    );


    /// активируемые способности монстра/игрока
    /// при этом cost - стоимость за один уровень скила. если скил 7 уровня, то и cost*7
    skills : array [0..8] of TItem = (
        (name:   'Healing';
         cost:    10;
         script: 'SetVar(IncHP,Rand([GetSkillLvl(Healing) * 50]));'+
                 'ChangePlayerParam(HP,GetVar(IncHP));'+
                 'AddEvent(Player restore GetVar(IncHP) HP);'
        )

       ,(name:   'Explosion';
         cost:    50;
         script:
                 'SetVar(Expl,Rand([GetSkillLvl(Explosion) * 300]));'+
                 'AddEvent(Target take GetVar(Expl) damage from Explosion!);'+
                 'ChangeTargetParam(HP,-GetVar(Expl));'
        )

       ,(name:   'Heroism';
         cost:    20;
         script:
                 'SetVar(value,Rand([GetSkillLvl(Heroism) * 5]));'+
                 'AddEvent(Player gets all stats buff by GetVar(value)!);'+
                 'SetPlayerBuff(ATK,GetVar(value));'+
                 'SetPlayerBuff(DEF,GetVar(value));'+
                 'SetPlayerBuff(MDEF,GetVar(value));'
        )

       ,(name:   'BreakDEF';
         cost:    15;
         script:
                 'SetVar(value,Rand([GetSkillLvl(BreakDEF) * 10]));'+
                 'SetVar(monster, GetMonsterAttr(DEF));'+                  /// столько есть у монстра
                 'SetVar(value, MIN(GetVar(monster), GetVar(value)));'+    /// берем минмальное значение, чтобы не уйти в минус
                 'AddEvent(Monsters defense is reduced by GetVar(value)!);'+
                 'ChangeCreatureParam(DEF,-GetVar(value));'
        )

       ,(name:   'BreakMDEF';
         cost:    15;
         script:
                 'SetVar(value,Rand([GetSkillLvl(BreakMDEF) * 10]));'+
                 'SetVar(monster, GetMonsterAttr(MDEF));'+                  /// столько есть у монстра
                 'SetVar(value, MIN(GetVar(monster), GetVar(value)));'+    /// берем минмальное значение, чтобы не уйти в минус
                 'AddEvent(Monsters magic defense is reduced by GetVar(value)!);'+
                 'ChangeCreatureParam(MDEF,-GetVar(value));'
        )

       ,(name:   'BreakATK';
         cost:    30;
         script:
                 'SetVar(value,Rand([GetSkillLvl(BreakATK) * 5]));'+      /// столько хотим забрать
                 'SetVar(monster, GetMonsterAttr(ATK));'+                  /// столько есть у монстра
                 'SetVar(value, MIN(GetVar(monster), GetVar(value)));'+    /// берем минмальное значение, чтобы не уйти в минус
                 'AddEvent(Monsters attack reduced by GetVar(value)!);'+
                 'ChangeCreatureParam(ATK,-GetVar(value));'
        )

       ,(name:   'LeakMP';
         cost:    10;
         script:
                 'SetVar(leak,Rand([GetSkillLvl(LeakMP) * 30]));'+  // сколько пытается забрать навык
                 'SetVar(monsterMP,GetMonsterAttr(MP));'+           // сколько есть у монстра

                 'IF([GetVar(leak) >= GetVar(monsterMP)], 3);'+        // если забираем больше, чем есть
                 'SetVar(leak, [GetVar(monsterMP) / 2]);'+          // получаемое игроком = половина от возможного
                 'ChangeCreatureParam(MP,-GetVar(monsterMP));'+     // забираем у монстра все
                 'ChangePlayerParam(MP,GetVar(leak));'+             // игрок получает свое

                 'IF([GetVar(leak) < GetVar(monsterMP)], 4);'+        // если забираем меньше чем есть
                 'SetVar(monsterMP, GetVar(leak));'+                // монстр будет терять в полном объеме
                 'SetVar(leak, [GetVar(leak) / 2]);'+               // игрок получит половину от требуемого
                 'ChangeCreatureParam(MP,-GetVar(monsterMP));'+     // монстр теряет
                 'ChangePlayerParam(MP,GetVar(leak));'+             // игрок получает

                 'AddEvent(Monsters lost GetVar(monsterMP) MP);'+   // радуем игрока
                 'AddEvent(Player gets GetVar(leak) MP!);'
        )

       ,(name:   'VampireStrike';
         cost:    10;
         script:
                 'SetVar(leak,Rand([GetSkillLvl(VampireStrike) * 20]));'+  // сколько пытается забрать навык
                 'SetVar(monsterHP,GetMonsterAttr(HP));'+           // сколько есть у монстра

                 'IF([GetVar(leak) >= GetVar(monsterHP)], 3);'+        // если забираем больше, чем есть
                 'SetVar(leak, [GetVar(monsterHP) / 2]);'+          // получаемое игроком = половина от возможного
                 'ChangeCreatureParam(HP,-GetVar(monsterHP));'+     // забираем у монстра все
                 'ChangePlayerParam(HP,GetVar(leak));'+             // игрок получает свое

                 'IF([GetVar(leak) < GetVar(monsterHP)], 4);'+        // если забираем меньше чем есть
                 'SetVar(monsterHP, GetVar(leak));'+                // монстр будет терять в полном объеме
                 'SetVar(leak, [GetVar(leak) / 2]);'+               // игрок получит половину от требуемого
                 'ChangeCreatureParam(HP,-GetVar(monsterHP));'+     // монстр теряет
                 'ChangePlayerParam(HP,GetVar(leak));'+             // игрок получает

                 'AddEvent(Monsters lost GetVar(monsterHP) HP);'+   // радуем игрока
                 'AddEvent(Player gets GetVar(leak) HP!);'
        )

       ,(name:   'Metabolism';
         cost:    10;
         script:
                 'SetVar(value,[Rand([GetSkillLvl(Metabolism) * 5]) + 10]);'+
                 'SetPlayerBuff(REG,GetVar(value));'+
                 'AddEvent(Player speed up regen by GetVar(value)!);'
        )
    );

    phrases: array [0..12,0..1] of string = (
    (('-> Player is level up!'),
     ('-> Игрок получиль новый уровень!')),

    (('Player killed by '),
     ('Игрок убит монстром ')),

    (('Enter into Tower...'),
     ('Входим в башню...')),

    (('Monster %s is killed! Got %s exp'),
     ('Монстр %s убит! Получено %s exp')),

    (('Go up %d Tower floor...'),
     ('Поднимаемся на %d этаж Башни...')),

    (('Using of %s is cost %d MP!'),
     ('Использование %s стоит %d MP!')),

    (('Skill %s is up to %d level!'),
     ('Умение %s улучшено до %d уровня!')),

    (('Level up skill %s is cost %d exp!'),
     ('Улучшение навыка %s стоит %d exp')),

    (('Player strike for %d DMG'),
     ('Игрок нанес %d урона')),

    (('Monster strike for %d DMG'),
     ('Монстр нанес %d урона')),

    (('Player strike for %d DMG ( %d is blocked )'),
     ('Игрок нанес %d урона ( заблокировано %d )')),

    (('Monster strike for %d DMG ( %d is blocked )'),
     ('Монстр нанес %d урона ( заблокировано %d )')),

    (('Got %s %s'),
     ('Получено %s %s'))
    );
const
    PHRASE_LEVEL_UP       = 0;
    PHRASE_KILLED_BY      = 1;
    PHRASE_DUNGEON_ENTER  = 2;
    PHRASE_MONSTER_KILLED = 3;
    PHRASE_TO_NEXT_FLOOR  = 4;
    PHRASE_SKILL_OVERCOST = 5;
    PHRASE_SKILL_UP       = 6;
    PHRASE_SKILL_OVERUP   = 7;
    PHRASE_PLAYER_STRIKE  = 8;
    PHRASE_MONSTER_STRIKE = 9;
    PHRASE_PLAYER_STRIKE_BLOCK  = 10;
    PHRASE_MONSTER_STRIKE_BLOCK = 11;
    PHRASE_GET_LOOT             = 12;
implementation

end.
