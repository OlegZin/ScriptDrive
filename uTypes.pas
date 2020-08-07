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

type

    TCreature = class
        Name     : string;  // уникальное имя
        Params   : string;  // базовые параметры: уровень, здоровье, мана, атака и т.п.
        Buffs    : string;  // баффы к чему угодно имя_бафа=количество_использований
        AutoBuffs: string;  // автобаффы к чему угодно имя_бафа=количество_использований
        Items    : string;  // расходные предметы для использования
        Loot     : string;  // расходные материалы для крафта
        Skills   : string;  // активируемые за ману скилы/заклинания
        OnAttack : string;  // скрипт на атаку по монстру
    end;

    TItem = record
        name: string;
        cost: integer;
        script: string;
    end;

    TTarget = record
        level: integer;
        script: string;
    end;
var
    name1 : array [0..9] of string = (
        'Упоротый','Отважный','Обреченный','Коварный','Смертоносный','Голодный','Сонный','Лысый','Красивый','Безобразный');
    name2 : array [0..9] of string = (
        'Удод','Искатель','Крашер','Тюфяк','Скрудж','Полторун','Пептид','Отсекатель','НяшМяш','Крутыш');
    name3 : array [0..9] of string = (
        'Поликлиники','Ада','Иных миров','Подземелий','Лесов','Безумия','Тайн','Безнадежности','Героизма','Коварства');

    // расходники для крафта. количество упоминаний регулирует шанс выпадения
    loot: array [0..49] of string = (
        ('wood'),('wood'),('wood'),('wood'),('wood'),('wood'),('wood'),('wood'),('wood'),('wood'),            // 10
        ('stone'),('stone'),('stone'),('stone'),('stone'),('stone'),('stone'),('stone'),('stone'),('stone'),  // 10
        ('herbal'),('herbal'),('herbal'),('herbal'),('herbal'),('herbal'),('herbal'),('herbal'),              // 8
        ('wheat'),('wheat'),('wheat'),('wheat'),('wheat'),('wheat'),                                          // 6
        ('meat'),('meat'),('meat'),('meat'),                                                                  // 4
        ('blood'),('blood'),('blood'),                                                                        // 3
        ('bone'),('bone'),('bone'),                                                                           // 3
        ('skin'),('skin'),('skin'),                                                                           // 3
        ('ore'),('ore'),                                                                                      // 2
        ('essence')                                                                                           // 1
    );

    /// массив изменения состояний игры при достижения опредлеленных уровней.
    /// сердце игры, ради которого мутилась фишка со скриптами
    targets: array [0..3,0..1] of TTarget = (
        ((level: 2;
         script:
             'AddEvent(.);'+
             'AddEvent(Player get 5 AutoATK items);'+
             'AddEvent(Good job! Keep going!);'+
             'AddEvent(.);'+
             'ChangePlayerItemCount(AutoATK, 5);'
        ),
        (level: 2;
         script:
             'AddEvent(.);'+
             'AddEvent(Игрок получил 5 зелий AutoATK);'+
             'AddEvent(- Отличная работа! Держи `краба`!);'+
             'AddEvent(.);'+
             'ChangePlayerItemCount(AutoATK, 5);'
        ))

       ,((level: 6;
         script:
             'AddEvent(.);'+
             'AddEvent(!!! Allow item crafting now !!!);'+
             'AddEvent(.);'+
             'AllowMode(Craft, 1);'
        )
       ,(level: 6;
         script:
             'AddEvent(.);'+
             'AddEvent(!!! Доступен режим крафта предметов !!!);'+
             'AddEvent(.);'+
             'AllowMode(Craft, 1);'
        ))

       ,((level: 11;
         script:
             'AddEvent(.);'+
             'AddEvent(Use `Reset Tower` button to avoid enemy);' +
             'AddEvent(.);'+
             'AddEvent(YOU WILL NOT PASS !!!);' +
             'AddEvent(What are you doing in my Tower insignificance!?);' +
             'AddEvent(.);'+
             'DropCreatures();'+
             'SetCreature(DARK MASTER,HP=999999999 ATK=1,,spirit=1)'
        )
       ,(level: 11;
         script:
             'AddEvent(.);'+
             'AddEvent(-> Используйте кнопку `Reset Tower` чтобы избежать врага);' +
             'AddEvent(.);'+
             'AddEvent(ТЫ НЕ ПРОЙДЕШЬ !!!);' +
             'AddEvent(Что ты делаешь в моей Башне ничтожество!?);' +
             'DropCreatures();'+
             'SetCreature(DARK MASTER,HP=99999 ATK=1,,spirit=1)'
        ))

       ,((level: maxint;
         script:
             'AddEvent(!!! INCREDIBLE !!!);' +
             'AddEvent(!!! YOU WIN THE GAME !!!);' +
             'CurrentLevel(1);InitCreatures();'
        )
       ,(level: maxint;
         script:
             'AddEvent(!!! НЕВЕРОЯТНО !!!);' +
             'AddEvent(!!! ТЫ ПРОШЕЛ ИГРУ !!!);' +
             'CurrentLevel(1);InitCreatures();'
        ))
    );

    // предметы-расходники. в механике имеют разные уровни силы
    items: array [0..14] of TItem = (
        (name:   'Gold';
         cost:    MaxInt;
         script:

                 'If({GetPlayerItemCount(Gold) < 10000}, 2);'+                     // если золота не достаточно
                 'AddEvent(Player do not have enougth Gold! [Cost 10 000 Gold]);'+ // ругаемся и
                 'ChangePlayerItemCount(Gold, 1);'+                                // компенсируем расход 1 золота за неудачное использование

                 'If({GetPlayerItemCount(Gold) > 9999}, 4);'+   // если золота достаточно
                 'SetVar(iName, GetRandItemName());'+           // получаем имя случайного предмета
                 'ChangePlayerItemCount(GetVar(iName), 1);'+    // добавляем единицу в инвентарь
                 'ChangePlayerItemCount(Gold, -9999);'+         // списываем деньги с учетом того, что 1 спишется за использование золота как предмета
                 'AddEvent(Player get GetVar(iName)!);'         // радуем игрока приобретением
        ) // золото

       ,(name:   'RestoreHealth';
         cost:    1000;
         script: 'SetVar(IncHP,Rand({GetPlayerAttr(LVL) * 100}));'+
                 'ChangePlayerParam(HP,GetVar(IncHP));'+
                 'AddEvent(Player restore GetVar(IncHP) HP)'
        ) // зелье лечения

       ,(name:   'RestoreMana';
         cost:    1000;
         script: 'SetVar(IncMP,Rand({GetPlayerAttr(LVL) * 20}));'+
                 'ChangePlayerParam(MP,GetVar(IncMP));'+
                 'AddEvent(Player restore GetVar(IncMP) MP)'
         ) // зелье восстановления маны

       ,(name:   'PermanentATK';
         cost:    10000;
         script: 'ChangePlayerParam(ATK,1);'+
                 'AddEvent(Player get +1 ATK permanently!)'
        ) // зелье постоянного повышения атаки

       ,(name:   'PermanentDEF';
         cost:    10000;
         script: 'ChangePlayerParam(DEF,1);'+
                 'AddEvent(Player get +1 DEF permanently!)'
        ) // зелье постоянного повышения защиты

       ,(name:   'PermanentMDEF';
         cost:    10000;
         script: 'ChangePlayerParam(MDEF,1);'+
                 'AddEvent(Player get +1 MDEF permanently!)'
        ) // зелье постоянного повышения магической защиты

       ,(name:   'EXP';
         cost:    1000;
         script: 'SetVar(EXP,Rand({GetPlayerAttr(LVL) * 100}));'+
                 'ChangePlayerParam(EXP,GetVar(EXP));'+
                 'AddEvent(Player get +GetVar(EXP) EXP!)'
        ) // зелье разового получения опыта
{
       ,(name:   'REG';
         cost:    10000;
         script: 'ChangePlayerParam(REG,1);'+
                 'AddEvent(Player get +1 Regen permanently!)'
        ) // зелье постоянного повышения магической защиты
}


       ,(name:   'RegenHP';
         cost:    500;
         script: 'SetPlayerAutoBuff(HP,Rand({GetPlayerAttr(LVL) * 500}))'
        ) // зелье регенерации здоровья

       ,(name:   'RegenMP';
         cost:    500;
         script: 'SetPlayerAutoBuff(MP,Rand({GetPlayerAttr(LVL) * 50}))'
        ) // зелье регенерации маны



       ,(name:   'BuffATK';
         cost:    5000;
         script: 'SetPlayerBuff(ATK,{Rand(GetPlayerAttr(LVL)) + 1})'
        ) // зелье временного повышения атаки

       ,(name:   'BuffDEF';
         cost:    5000;
         script: 'SetPlayerBuff(DEF,{Rand(GetPlayerAttr(LVL)) + 1})'
        ) // зелье временного повышения защиты

       ,(name:   'BuffMDEF';
         cost:    3000;
         script: 'SetPlayerBuff(MDEF,{Rand(GetPlayerAttr(LVL)) + 1})'
        ) // зелье временного прироста опыта

       ,(name:   'BuffEXP';
         cost:    3000;
         script: 'SetPlayerBuff(EXP,{Rand(GetPlayerAttr(LVL)) + 1})'
        ) // зелье временного прироста опыта

       ,(name:   'BuffREG';
         cost:    3000;
         script: 'SetPlayerBuff(REG,{Rand(GetPlayerAttr(LVL)) + 1})'
        ) // зелье временного прироста опыта



       ,(name:   'AutoATK';
         cost:   10000;
         script: 'ChangeAutoATK(Rand(Min({GetPlayerAttr(LVL) * 100}, 1000)))'
        ) // зелье автоматической атаки
    );


    /// активируемые способности монстра/игрока
    /// при этом cost - стоимость за один уровень скила. если скил 7 уровня, то и cost*7
    skills : array [0..8] of TItem = (
        (name:   'Healing';
         cost:    10;
         script: 'SetVar(IncHP,Rand({GetSkillLvl(Healing) * 50}));'+
                 'ChangePlayerParam(HP,GetVar(IncHP));'+
                 'AddEvent(Player restore GetVar(IncHP) HP)'
        )

       ,(name:   'Explosion';
         cost:    50;
         script:
                 'SetVar(Expl,Rand({GetSkillLvl(Explosion) * 300}));'+
                 'AddEvent(Monster take GetVar(Expl) damage from Explosion!);'+
                 'ChangeCreatureParam(HP,-GetVar(Expl));'
        )

       ,(name:   'Heroism';
         cost:    20;
         script:
                 'SetVar(value,Rand({GetSkillLvl(Heroism) * 10}));'+
                 'AddEvent(Player gets all stats buff by GetVar(value)!);'+
                 'SetPlayerBuff(ATK,GetVar(value));'+
                 'SetPlayerBuff(DEF,GetVar(value));'+
                 'SetPlayerBuff(MDEF,GetVar(value));'
        )

       ,(name:   'BreakDEF';
         cost:    15;
         script:
                 'SetVar(value,Rand({GetSkillLvl(BreakDEF) * 10}));'+
                 'AddEvent(Monsters defense is reduced by GetVar(value)!);'+
                 'ChangeCreatureParam(DEF,-GetVar(value));'
        )

       ,(name:   'BreakMDEF';
         cost:    15;
         script:
                 'SetVar(value,Rand({GetSkillLvl(BreakMDEF) * 10}));'+
                 'AddEvent(Monsters magic defense is reduced by GetVar(value)!);'+
                 'ChangeCreatureParam(MDEF,-GetVar(value));'
        )

       ,(name:   'BreakATK';
         cost:    30;
         script:
                 'SetVar(value,Rand({GetSkillLvl(BreakATK) * 20}));'+
                 'AddEvent(Monsters attack reduced by GetVar(value)!);'+
                 'ChangeCreatureParam(ATK,-GetVar(value));'
        )

       ,(name:   'LeakMP';
         cost:    10;
         script:
                 'SetVar(leak,Rand({GetSkillLvl(LeakMP) * 30}));'+  // сколько пытается забрать навык
                 'SetVar(monsterMP,GetMonsterAttr(MP));'+           // сколько есть у монстра

                 'IF({GetVar(leak) >= GetVar(monsterMP)}, 3);'+        // если забираем больше, чем есть
                 'SetVar(leak, {GetVar(monsterMP) / 2});'+          // получаемое игроком = половина от возможного
                 'ChangeCreatureParam(MP,-GetVar(monsterMP));'+     // забираем у монстра все
                 'ChangePlayerParam(MP,GetVar(leak));'+             // игрок получает свое

                 'IF(GetVar(leak) < GetVar(monsterMP), 4);'+        // если забираем меньше чем есть
                 'SetVar(monsterMP, GetVar(leak));'+                // монстр будет терять в полном объеме
                 'SetVar(leak, {GetVar(leak) / 2});'+               // игрок получит половину от требуемого
                 'ChangeCreatureParam(MP,-GetVar(monsterMP));'+     // монстр теряет
                 'ChangePlayerParam(MP,GetVar(leak));'+             // игрок получает

                 'AddEvent(Monsters lost GetVar(monsterMP) MP);'+   // радуем игрока
                 'AddEvent(Player gets GetVar(leak) MP!);'
        )

       ,(name:   'VampireStrike';
         cost:    10;
         script:
                 'SetVar(leak,Rand({GetSkillLvl(VampireStrike) * 20}));'+  // сколько пытается забрать навык
                 'SetVar(monsterHP,GetMonsterAttr(HP));'+           // сколько есть у монстра

                 'IF({GetVar(leak) >= GetVar(monsterHP)}, 3);'+        // если забираем больше, чем есть
                 'SetVar(leak, {GetVar(monsterHP) / 2});'+          // получаемое игроком = половина от возможного
                 'ChangeCreatureParam(HP,-GetVar(monsterHP));'+     // забираем у монстра все
                 'ChangePlayerParam(HP,GetVar(leak));'+             // игрок получает свое

                 'IF(GetVar(leak) < GetVar(monsterHP), 4);'+        // если забираем меньше чем есть
                 'SetVar(monsterHP, GetVar(leak));'+                // монстр будет терять в полном объеме
                 'SetVar(leak, {GetVar(leak) / 2});'+               // игрок получит половину от требуемого
                 'ChangeCreatureParam(HP,-GetVar(monsterHP));'+     // монстр теряет
                 'ChangePlayerParam(HP,GetVar(leak));'+             // игрок получает

                 'AddEvent(Monsters lost GetVar(monsterHP) HP);'+   // радуем игрока
                 'AddEvent(Player gets GetVar(leak) HP!);'
        )

       ,(name:   'Metabolism';
         cost:    50;
         script:
                 'SetVar(value,{Rand(GetSkillLvl(Metabolism) * 5) + 10});'+
                 'SetPlayerBuff(REG,GetVar(value));'+
                 'AddEvent(Player speed up regen by GetVar(value)!);'
        )
    );

    phrases: array [0..9,0..1] of string = (
    (('-> Player is level up!'),
     ('-> Игрок получиль новый уровень!')),

    (('Player killed by '),
     ('Игрок убит монстром ')),

    (('Enter into Tower...'),
     ('Входим в башню...')),

    (('Monster %s is killed! Get %s exp'),
     ('Монстр %s убит! Получено %s exp')),

    (('Go up %d Dungeon level...'),
     ('Поднимаемся на %d этаж Башни...')),

    (('Using of %s is cost %d MP!'),
     ('Использование %s стоит %d MP!')),

    (('Skill %s is up to %d level!'),
     ('Умение %s улучшено до %d уровня!')),

    (('Level up skill %s is cost %d exp!'),
     ('Улучшение навыка %s стоит %d exp')),

    ((''),('')),
    ((''),(''))
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
implementation

end.
