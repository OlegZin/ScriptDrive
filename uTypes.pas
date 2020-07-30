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
        OnAttack : string;
    end;

    TItem = record
        name: string;
        script: string;
    end;
var
    name1 : array [0..9] of string = (
        'Упоротый','Отважный','Обреченный','Коварный','Смертоносный','Голодный','Сонный','Лысый','Красивый','Безобразный');
    name2 : array [0..9] of string = (
        'Удод','Искатель','Крашер','Тюфяк','Скрудж','Полторун','Пептид','Отсекатель','НяшМяш','Крутыш');
    name3 : array [0..9] of string = (
        'Поликлиники','Ада','Иных миров','Подземелий','Лесов','Безумия','Тайн','Безнадежности','Героизма','Коварства');

    // предметы-расходники. в механике имеют разные уровни силы
    items: array [0..11] of TItem = (
        (name: 'Gold';      script: 'GetItem            (''rand, 1'')'  ) // золото
       ,(name: 'Heal';      script: 'ChangePlayerParam  (''HP, 100'')'  ) // зелье лечения
       ,(name: 'Mana';      script: 'ChangePlayerParam  (''MP, 20'')'   ) // зелье восстановления маны
       ,(name: 'Explosion'; script: 'ChangeCreatureParam(''HP, -1000'')') // зелье взрыва
       ,(name: 'RegHP';     script: 'SetPlayerAuto      (''HP, 1'')'    ) // зелье регенерации здоровья
       ,(name: 'RegMP';     script: 'SetPlayerAuto      (''MP, 1'')'    ) // зелье регенерации маны
       ,(name: 'AutoATK';   script: 'SetPlayerAuto      (''ATK, 1'')'   ) // зелье автоматической атаки
       ,(name: 'ATK';       script: 'SetPlayerBuff      (''ATK, 100'')' ) // зелье временного повышения атаки
       ,(name: 'DEF';       script: 'SetPlayerBuff      (''ATK, 100'')' ) // зелье временного повышения защиты
       ,(name: 'PATK';      script: 'ChangePlayerParam  (''ATK, 1'')'   ) // зелье постоянного повышения атаки
       ,(name: 'PDEF';      script: 'ChangePlayerParam  (''DEF, 1'')'   ) // зелье постоянного повышения защиты
       ,(name: 'EXP';       script: 'SetPlayerBuff      (''EXP, 5'')'   ) // зелье временного прироста опыта
    );
implementation

end.
