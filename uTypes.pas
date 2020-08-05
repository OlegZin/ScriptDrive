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
        Params   : string;
        Items    : string;
        Loot     : string;
        OnAttack : string;
    end;

    TItem = record
        name: string;
        cost: integer;
        script: string;
    end;
var
    name1 : array [0..9] of string = (
        'Упоротый','Отважный','Обреченный','Коварный','Смертоносный','Голодный','Сонный','Лысый','Красивый','Безобразный');
    name2 : array [0..9] of string = (
        'Удод','Искатель','Крашер','Тюфяк','Скрудж','Полторун','Пептид','Отсекатель','НяшМяш','Крутыш');
    name3 : array [0..9] of string = (
        'Поликлиники','Ада','Иных миров','Подземелий','Лесов','Безумия','Тайн','Безнадежности','Героизма','Коварства');

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

    // предметы-расходники. в механике имеют разные уровни силы
    items: array [0..11] of TItem = (
        (name:   'Gold';
         cost:   MaxInt;
         script: 'If({GetPlayerItemCount(Gold) > 9998}, 4);'+ // 1 золото отнимается за использование
                                                              // если золота достаточно, выполняем следующие 4 строки скрипта,
                                                              // иначе они будут пропущены
                 'SetVar(iName, GetRandItemName());'+
                 'ChangePlayerItemCount(GetVar(iName), 1);'+
                 'ChangePlayerItemCount(Gold, -9999);'+
                 'AddEvent(Player get GetVar(iName)!);'
        ) // золото

       ,(name:   'RestoreHealth';
         cost:   1000;
         script: 'SetVar(IncHP,Rand({GetPlayerAttr(LVL) * 100}));'+
                 'ChangePlayerParam(HP,GetVar(IncHP));'+
                 'AddEvent(Player restore GetVar(IncHP) HP)'
        ) // зелье лечения

       ,(name:   'RestoreMana';
         cost:   1000;
         script: 'SetVar(IncMP,Rand({GetPlayerAttr(LVL) * 20}));'+
                 'ChangePlayerParam(MP,GetVar(IncMP));'+
                 'AddEvent(Player restore GetVar(IncMP) MP)'
         ) // зелье восстановления маны

       ,(name:   'Explosion';
         cost:   10000;
         script: 'ChangeCreatureParam(HP,-1000)') // зелье взрыва

       ,(name:   'RegenHP';
         cost:   500;
         script: 'SetPlayerAuto(HP,1)'    ) // зелье регенерации здоровья

       ,(name:   'RegenMP';
         cost:   500;
         script: 'SetPlayerAuto(MP,1)'    ) // зелье регенерации маны

       ,(name:   'AutoATK';
         cost:   10000;
         script: 'ChangeAutoATK(Rand({GetPlayerAttr(LVL) * 100}))'   ) // зелье автоматической атаки

       ,(name:   'BuffATK';
         cost:   5000;
         script: 'SetPlayerBuff(ATK,100)' ) // зелье временного повышения атаки

       ,(name:   'BuffDEF';
         cost:   5000;
         script: 'SetPlayerBuff(ATK,100)' ) // зелье временного повышения защиты

       ,(name:   'PermanentATK';
         cost:   10000;
         script: 'ChangePlayerParam(ATK,1);'+
                 'AddEvent(Player get +1 ATK permanently!)'
        ) // зелье постоянного повышения атаки

       ,(name:   'PermanentDEF';
         cost:   10000;
         script: 'ChangePlayerParam(DEF,1);'+
                 'AddEvent(Player get +1 DEF permanently!)'
        ) // зелье постоянного повышения защиты

       ,(name:   'BuffEXP';
         cost:   3000;
         script: 'SetPlayerBuff(EXP,5)'   ) // зелье временного прироста опыта
    );
implementation

end.
