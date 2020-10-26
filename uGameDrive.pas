unit uGameDrive;

interface

uses
    uScriptDrive, superobject, uConst,
    System.SysUtils, Generics.Collections, Classes, Math, StrUtils, ShellAPI,
    uThinkMode, uGameInterface, uLog, uTower;

type

    TGameDrive = class
    private
        GameData: ISuperObject; /// все статичные данные игры.

        Target: string;  /// путь до текущего выбранного объекта в структуре GameState
            // текущая выбранная цель. используется для
            // методов, которые не применяются к конкретному объекту.
            // что позволит сократить набор методов для скриптов

        InterfModes : integer;
            // набор флагов, показывающих какие части интерфейса обновлять при
            // вызове метода UpdateInterface

        doLog: boolean;
            // логировать ли действия программы в текстовый файл

        fSilentChange : boolean;
            // флаг "тихого" следующего изменения параметра, чтобы не засорять лог
    public

        constructor Create;
        destructor Destroy;

        /// работа с отладочным логированием
        procedure l_drop;
        procedure l_set(val: boolean);
        procedure l(text: string);

        function NewGame(level: integer; lang: string): string;
        function LoadGame( lang: string ): string; /// загрузка состояния игры
        function SaveGame: string;        /// сохранение текущего состояния игры
        procedure SaveTestData;           /// сохранение тек состояния игры в красивом файле
        procedure SetMode(name: string);           /// переключение на окно указанного режима

        procedure UpdateInterface;                  /// перерисовка состояния интерфейса
        procedure SetModeToUpdate(val: integer);
            /// модифицирует флаговую переменную, указывающую на то, какие части интерфейса нужно
            /// обновить при вызове метода UpdateInterface. значения флагов в наборе констант
            /// INT_XXX

        function AllowLevelUp: boolean;

/// ключевой метод
        procedure CheckStatus;             // проверка состояния игры и отработка событий
        procedure ProcessEffects;          // отыгрывает все автоматические эффекты на всех целях

// работа с целями и их параметрами, инвентарем и прочим
        procedure SetPlayerAsTarget;   /// установка игрока целью методов работы с параметрами и прочего
        procedure SetCreatureAsTarget; /// установка монстра целью методов работы с параметрами и прочего

        procedure ResetTargetState;    /// обнуляет параметры инвентарь и прочее
        procedure SetName(lang, name: string); // задает имя цели в указанном яцыке
        procedure SetImage(index: integer = -1);

        procedure ChangeItemCount(name, delta: variant);  // изменение количества предметов в инвентаре текущей цели
        procedure SetItemCount(name, value: variant);     // установка количества предметов в инвентаре текущей цели
        function  GetItemCount(name: string): string;     // получение количества предметов в инвентаре текущей цели

        procedure ChangeLootCount(name, delta: variant);  // изменение количества предметов в инвентаре текущей цели
        procedure SetLootCount(name, value: variant);     // установка количества предметов в инвентаре текущей цели

        procedure SilentChange;                      /// следующее изменение параметра не будет выводить автоматическое сообщение в лог
        procedure SetParam(name, value: variant);    /// устанавливаем значение укакзанного параметра
        procedure ChangeParam(name, delta: variant); /// изменене значения параметра на дельту
        function GetParam(name: string): string;    /// получение значение параметра

        procedure ChangePlayerParam(name, value: variant);
        procedure ChangePlayerItemCount(name, value: variant);

        procedure Collect(name: string; objects: ISuperObject);
           // добавление в указанный раздел текущей цели всех элементов
           // списка objects

        procedure PlayEvent(name: string); /// выполнение скриптов цели, привязанных к указанному событию.
                                           /// например, "onAttack"

/// работа с эффектами. ориентированы на текущую цель!
        procedure AddEffect(name, value: variant); /// вешает на цель временный эффект
        function GetEffect(name: string): string;
        procedure ChangeEffect(name, value: variant);
        procedure RemoveEffect(name: string);

/// работа с языком
        function GetLang: string;          // возврат стрки с именем текущего языка ENG|RU
        procedure SetLang(lang: string);   // возврат стрки с именем текущего языка ENG|RU

/// работа с этажами
        procedure SetCurrFloor(val: variant); // установить текущий этаж
        function CurrFloor: variant;       // текущий этаж

        procedure SetCurrStep(val: variant);  // устанвить текущий шаг
        function CurrStep: string;        // текущий шаг
        function MaxStep: string;         // максимальный шаг для текущего этажа

/// работа с предметами
        function GetRandItemName: string;          // внутреннее имя случайного предмета
        procedure SetCurrItem(name: string);   // устанавливает текущий выбранный предмет по его имени

/// работа с ресурсами
        function GetRandResName: string;   // получение внутреннего имени случайного ресурса с учетом редкости

/// работа с целями на этажах.
        function GetCurrTarget: string;
        procedure SetCurrTarget(val: string);
        procedure SetNextTarget;

/// работа с логом
        procedure Log(kind, text: string);   // добавляет строку указанного типа в лог игры. типы - имена css стилей из EMPTY_HTML из модуля uLog
        procedure LogAdd(text: string);      // приклеивает текст в конец текущей строки лога

/// работа с переменными
        procedure SetVar(name, value: variant);
        procedure ChangeVar(name, value: variant);
        function GetVar(name: string): string;

/// работа с монстрами
        procedure CreateRegularMonster;  // создание обычного проходного монстра на основе текущего этажа

/// методы работы с пулами действий (накопленных игроком локальных автоматических действий)
        procedure ChangePool(name, val: variant);             // добавляет атаку в пул
        function GetPool(name: string): integer;     // текущее количество атак в пуле

/// автодействия различных режимов
        procedure BreakAuto(name: string);  /// прерывает автодействия указанного режима
        procedure RunAuto(name: string);    /// запускает автодействия указанного режима
        function  GetAuto(name: string): boolean;    /// возвращает состояние указанного режима

/// разлокировка различных типов объектов
        procedure AllowMode(name: string);

{
        function GetArtLvl(name: string): string;  // возвращает уровень артефакта по его внутреннему имени
        procedure AllowTool(name: string);
        procedure OpenThink(name: string);
}

/// основные игровые методы
        procedure PlayerAttack;  /// проведение взаимной атаки игрока и монстра в башне
        procedure UseCurrItem;   /// использование текущего выбранного предмета

    private
        Script : TScriptDrive;

        function GetLoot: ISuperObject;
        function GetItems: ISuperObject;

        procedure InitItemsCraftCost; /// генерация стоимости предметов в ресурсах. стоимость будет различной в каждой игре, сохраняя интригу
        procedure InitFloorObjects;   /// генерация предметов на этажах
        function GetRandObjName: string; /// случайный объект, который может находиться на этаже, с учетом редкости и доступного количества
        function NeedExp(lvl: variant): string;

        procedure ProcessAttack;     /// оболочка для PlayerMakeAttack, учитываюшая расход автодействий или локального пула
        procedure PlayerMakeAttack;  /// непосредственное проведение атаки со всеми событиями

        function CompactDigit(val: variant): string;
    end;

Var
    GameDrive : TGameDrive;

implementation

{ TData }


procedure TGameDrive.CheckStatus;
/// пересчет игрового статуса исходя из текущего состояния игроовых объектов
var
    HP, LVL : integer;
    loot, items: ISuperObject;
begin
    l('-> CheckStatus');

    /// отыгрываем атоматические эффекты
    SetPlayerAsTarget;
    ProcessEffects;

    /// пытаемся проатаковать, если пул атак не нулевой
    l('-> CheckStatus: пытаемся проатаковать, если пул атак не нулевой');
    ProcessAttack;

    /// проверяем состояние игрока
    l('-> CheckStatus: проверяем состояние игрока');
    SetPlayerAsTarget;
    if StrToInt(GetParam('HP')) <= 0 then
    begin
        /// отрабатываем событие на гибель игрока
        l('-> CheckStatus: отрабатываем событие на гибель игрока');
        PlayEvent('onDeath');

        /// если после события хитов все еще мало - возраждаемся
        l('-> CheckStatus: если после события хитов все еще мало - возраждаемся');
        if StrToInt(GetParam('HP')) <= 0 then
        begin
            uLog.Log.Phrase('killed_by', GetLang, []);

            // возвращаемся на первый уровень
            l('-> CheckStatus: возвращаемся на первый уровень');
            SetCurrFloor(1);
            SetCurrStep(1);

            // генерим монстра
            l('-> CheckStatus: генерим монстра');
            CreateRegularMonster;

            // лечим игрока
            l('-> CheckStatus: лечим игрока');
            SetPlayerAsTarget;
            HP := StrToInt(GetParam('LVL')) * 100;
            SetParam('HP', HP);

            /// отыгрываем событие воскрешения
            l('-> CheckStatus: отыгрываем событие воскрешения');
            PlayEvent('onRestore');
        end;
    end;


    /// проверяем монстра
    l('-> CheckStatus: проверяем монстра');
    SetCreatureAsTarget;
    if StrToInt(GetParam('HP')) <= 0 then
    begin
        /// отрабатываем событие на гибель монстра
        l('-> CheckStatus: отрабатываем событие на гибель монстра');
        PlayEvent('onDeath');

        /// если после события хитов все еще мало - отрабатываем смерть монстра
        l('-> CheckStatus: если после события хитов все еще мало - отрабатываем смерть монстра');
        if StrToInt(GetParam('HP')) <= 0 then
        begin

            loot := GetLoot;
            items := GetItems;

            l('-> CheckStatus: пишем в чат, что монстр убит');
            uLog.Log.Phrase('monster_killed', GetLang, []);

            l('-> CheckStatus: добавляем игроку опыт');
            SetPlayerAsTarget;
            ChangeParam('EXP', CurrFloor);

            // игрок получает предметы и лут
            l('-> CheckStatus: игрок получает предметы и лут');
            Collect('loot', loot);
            Collect('items', items);

            // проверяем на возможность левелапа
            l('-> CheckStatus: проверяем на возможность левелапа');
            if AllowLevelUp then
            begin
                /// апаем игрока
                l('-> CheckStatus: апаем игрока');
                LVL := StrToInt(GetParam('LVL'));

                uLog.Log.Phrase('level_up', GetLang, []);

                ChangeParam( 'HP', LVL * 100);
                ChangeParam( 'MP', LVL * 20);
                ChangeParam( 'ATK', LVL );
                ChangeParam( 'DEF', 1 );

                SilentChange;
                ChangeParam( 'LVL', 1);

                SilentChange;
                ChangeParam( 'EXP', -StrToInt(GetParam(PRM_NEEDEXP)));

                SilentChange;
                ChangeParam( PRM_NEEDEXP, NeedExp(LVL+1));

                l('-> CheckStatus: отыгрываем события на левелап');
                PlayEvent('onLevelUp');

            end;

            // переходим к следующему монстру
            l('-> CheckStatus: переходим на следующий шаг');
            SetCurrStep( StrToInt(CurrStep) + 1 );

            l('-> CheckStatus: генерим нового монстра');
            CreateRegularMonster;
        end;
    end;

    /// проверяем достижение цели (целевого этажа). если так - выполняем скрипт
    l('-> CheckStatus: проверяем достижение цели (целевого этажа)');
    if   GameData.S['state.CurrFloor'] = GameData.S['state.CurrTargetFloor'] then
    begin
        l('-> CheckStatus: цель достигнута, выполняем скрипт для CurrTargetFloor: '+GameData.S['state.CurrTargetFloor']);
        Script.Exec(GameData.S['targetFloor.'+GameData.S['state.CurrTargetFloor'] + '.script']);
    end;

    // проверка на окончание уровня
    l('-> CheckStatus: проверка на окончание уровня');
    if StrToInt(CurrStep) > StrToInt(MaxStep) then
    begin

        // переходим на новый уровень подземелья
        l('-> CheckStatus: переходим на новый уровень подземелья');
        SetCurrFloor(CurrFloor + 1);
        SetCurrStep(1);

        // генерим новую пачку монстров
        l('-> CheckStatus: генерим нового монстра');
        CreateRegularMonster;

        l('-> CheckStatus: пишем в чат о переходе на следующий уровень');
        uLog.Log.Phrase('next_floor', GetLang, [CurrFloor]);
    end;


end;


procedure TGameDrive.Collect(name: string; objects: ISuperObject);
var
    obj: TSuperAvlEntry;
begin
    l('-> Collect');

    for obj in objects.AsObject do
    begin
        if name = 'items'
        then ChangeItemCount(obj.Name, obj.Value.AsInteger);

        if name = 'loot'
        then ChangeLootCount(obj.Name, obj.Value.AsInteger);
    end;
end;

function TGameDrive.CompactDigit(val: variant): string;
/// приводим обычное число к компактону текстовому виду. типа: 4300000 => 4,3кк
begin
    result := val;

    /// проверяем, работаем с числом или текстом
    try StrToInt(val);
    except exit;
    end;

    /// если речь о тысячах
    if val div 1000 > 9 then
    begin
        result := IntToStr(val div 1000);

        if val mod 1000 > 100 then result := result + ',' + IntToStr((val mod 1000) div 100);

        result := result + 'к';
    end;
end;

function TGameDrive.NewGame(level: integer; lang: string): string;
var
    i : integer;
    name: string;
begin
    l('-> NewGame');

    result := '';

    GameData := SO(GAME_DATA);  // загрузка дефолтных данных
    uLog.Log.Clear;

    SetLang(lang);

//    GameData.I['state.player.params.'+PRM_NEEDEXP] := 1;
    GameData.I['state.player.params.'+PRM_NEEDEXP] := StrToInt(NeedExp(1));
                                // считаем опыт необходимый для левелапа

    InitItemsCraftCost;         // генерация рецептов предметов
    InitFloorObjects;           // генерация объектов на этажах

    /// генерим первоначальные ресурсы, исходя из уровня игры
    SetPlayerAsTarget;

    /// автодействия
    SetParam('AutoAction', 500 + 500 * level);

    /// генерим предметы в инвентаре
    for i := 1 to level do
    begin
        name := GetRandItemName;
        ChangeItemCount(name, level);
    end;

    /// золото
    ChangeItemCount(ITEM_GOLD, 100000 + 10000 * level);

    /// инициализируем монстра
    CreateRegularMonster;

    /// проверяем состояние игровых объектов
    CheckStatus;

    /// обновляем интерфейс
    SetModeToUpdate(INT_ALL);
    UpdateInterface;
end;



function TGameDrive.SaveGame: string;
begin
    l('-> SaveGame');

    GameData.O['state'].SaveTo(
        DIR_DATA + FILE_GAME_DATA
//       ,false // не использовать красивое форматирование
//       ,false  // не преобразовывать русские буквы в эскейп последовательности
    );
end;


procedure TGameDrive.SaveTestData;
begin
    l('-> SaveTestData');

    /// "красивая" версия для тестового контроля
    GameData.O['state'].SaveTo(
        DIR_DATA + FILE_GAME_DATA_TEST
       ,true // не использовать красивое форматирование
       ,false  // не преобразовывать русские буквы в эскейп последовательности
    );

    ShellExecute(0,'open',PCHAR(DIR_DATA + FILE_GAME_DATA_TEST),nil,nil,5{SW_SHOW});
end;

function TGameDrive.LoadGame( lang: string ): string;
/// загрузка состояния игры
var
    state: ISuperObject;
begin
    l('-> LoadGame');

    /// подгрузка данных, если есть сохранение
    if DirectoryExists( DIR_DATA ) and FileExists( DIR_DATA + FILE_GAME_DATA ) then
    begin
        /// пытаемся загрузить
        state := TSuperObject.ParseFile( DIR_DATA + FILE_GAME_DATA, false );

        /// если данные корректны, объект существует
        if Assigned(state) then
        GameData.O['state'] := state;
    end;

    GameData.S['state.Lang'] := lang;

    /// проверяем состояние игровых объектов
    CheckStatus;

    SetModeToUpdate(INT_ALL);
    UpdateInterface;
end;

procedure TGameDrive.Log(kind, text: string);
begin
    l('-> Log('+text+')');
    uLog.Log.Add(kind, text);
end;

procedure TGameDrive.LogAdd(text: string);
begin
    l('-> LogAdd('+text+')');
    uLog.Log.Append(text);
end;

function TGameDrive.GetLang: string;
begin
    l('-> GetLang');
    result := GameData.S['state.Lang'];
end;

function TGameDrive.GetLoot: ISuperObject;
begin
    l('-> GetLoot');
    result := GameData.O[Target + 'loot'];
end;

function TGameDrive.MaxStep: string;
begin
    l('-> MaxStep');
    result := IntToStr(GameData.I['state.CurrFloor'] * STEPS_BY_FLOOR);
end;

function TGameDrive.GetParam(name: string): string;
begin
    l('-> GetParam('+name+')');
    result := GameData.S[Target + 'params.' + name];
    if result = '' then result := '0';
end;

function TGameDrive.GetPool(name: string): integer;
begin
    name := LowerCase(name);
    /// если для указанного игрового режима включены автодействия
    ///  пулом действий являются автодействия,
    ///  иначе - локальный пул
    if GetAuto(name)
    then result := GameData.I['state.player.params.AutoAction'] // прямое обращение, чтобы не переключать цель
    else result := GameData.I['state.modes.'+name+'.pool'];
end;


procedure TGameDrive.SetLang(lang: string);
begin
    l('-> SetLang');
    GameData.S['state.Lang'] := lang;
end;



procedure TGameDrive.SetMode(name: string);
begin
{    Tower.SetUnactive;
    Think.SetUnactive;

    if name = 'Tower' then Tower.SetActive;
    if name = 'Think' then Think.SetActive;
}
end;

procedure TGameDrive.SetModeToUpdate(val: integer);
begin
    l('-> SetModeToUpdate('+IntToStr(val)+')');
    InterfModes := InterfModes or val;
end;

procedure TGameDrive.SetName(lang, name: string);
begin
    l('-> SetName('+name+')');
    GameData.S[Target + 'name.'+ lang] := name;
end;

procedure TGameDrive.SetNextTarget;
/// метод переключает текущую цель на следующий элемент массива targetFloor
begin
    l('-> SetNextTarget');
    GameData.S['state.CurrTargetFloor'] :=
        GameData.S['targetFloor.'+GameData.S['state.CurrTargetFloor']+'.next'];
end;

procedure TGameDrive.SetParam(name, value: variant);
var
    old, change: integer;

begin
    l('-> SetParam('+name+','+String(value)+')');

    /// в зависимости от цели, нужно обновлять разные куски интерфейса
    if pos('player', Target) > 0
    then InterfModes := InterfModes or INT_MAIN
    else InterfModes := InterfModes or INT_TOWER;

    old := GameData.I[Target + 'params.' + name];
    GameData.I[Target + 'params.' + name] := value;

    /// пишем изменение в лог, если не "тихий" режим
    if (pos('player', Target) > 0) and not fSilentChange then
    begin
        change := value - old;
        uLog.Log.Phrase('change_param', GetLang, [name, ifthen(change >= 0, '+', '' ) + IntToStr(change), Integer(value)]);
    end;

    fSilentChange := false;
end;

procedure TGameDrive.SetPlayerAsTarget;
begin
    l('-> SetPlayerAsTarget');
    Target := 'state.player.';
end;

procedure TGameDrive.SetVar(name, value: variant);
begin
    l('-> SetVar('+name+','+String(value)+')');
    GameData.S['state.vars.'+name] := value;
end;

procedure TGameDrive.SilentChange;
begin
    fSilentChange := true;
end;

procedure TGameDrive.UpdateInterface;
/// обновяем состояние окна активного режима
var
    data, elem: ISuperobject;
    item: TSuperAvlEntry;
begin
    l('-> UpdateInterface('+IntToStr(InterfModes)+')');

    if InterfModes and INT_MAIN <> 0 then
    begin
        data := SO();

        data.O['params'] := SO();
        data.S['params.AutoAction'] := CompactDigit(GameData.I['state.player.params.AutoAction']);
        data.S['params.LVL'] := CompactDigit(GameData.I['state.player.params.LVL']);
        data.S['params.EXP'] := CompactDigit(GameData.I['state.player.params.EXP']);
        data.S['params.HP'] := CompactDigit(GameData.I['state.player.params.HP']);
        data.S['params.MP'] := CompactDigit(GameData.I['state.player.params.MP']);
        data.I['params.needexp'] := GameData.I['state.player.params.needexp'];


        /// текущие временные эффекты на игроке
        data.O['effects'] := GameData.O['state.player.effects'].Clone;
        for elem in data.O['effects'] do
        elem.S['value'] := CompactDigit(elem.S['value']); /// значения могут быть впечатляющими


        data.O['modes'] := GameData.O['state.modes'];      /// статус доступа к игровым режимам
        data.S['CurrItem'] := GameData.S['state.CurrItem'];  /// текущий выбранный для быстрого использования предмет

        // предметы в инвентаре
        data.O['items'] := SO();
        for item in GameData['state.player.items'].AsObject do
        begin
            data.S['items.'+item.Name+'.name'] := item.Name;
            data.S['items.'+item.Name+'.count'] := CompactDigit(item.Value.AsInteger);
            data.S['items.'+item.Name+'.caption'] := GameData.S['items.'+item.Name+'.caption.'+GetLang];
            data.S['items.'+item.Name+'.description'] := GameData.S['items.'+item.Name+'.description.'+GetLang];
        end;

        if data.S['CurrItem'] <> ''
        then data.S['CurrCount'] := CompactDigit( GameData.I['state.player.items.'+GameData.S['state.CurrItem']] )
        else data.S['CurrCount'] := '0';

        GameInterface.Update( data );
    end;

    if InterfModes and INT_TOWER <> 0 then
    begin
        data := SO();
        data.O['params']      := GameData.O['state.creature.params'];
        data.I['floor']       := GameData.I['state.CurrFloor'];
        data.I['step']        := GameData.I['state.CurrStep'];
        data.S['maxstep']     := MaxStep;
        data.I['targetfloor'] := GameData.I['state.CurrTargetFloor'];
        data.I['image']       := GameData.I['state.creature.image'];
        data.I['attackpool']  := GetPool('Tower');
        data.S['name']        := GameData.S['state.creature.name.'+GetLang];
        data.B['auto']        := GetAuto('Tower');
        fTower.Update( data );
    end;

    if InterfModes and INT_LOG <> 0
    then uLog.Log.Update;

    InterfModes := 0;
end;


procedure TGameDrive.UseCurrItem;
/// применяем текущий выбранный предмет в интерфейсе игрока
var
    name: string;
begin
    if GameData.S['state.CurrItem'] = '' then exit;

    name := GameData.S['state.CurrItem'];

    /// выполняем скрипт эффекта
    Script.Exec( GameData.S['items.'+name+'.script'] );

    /// уменьшаем количество у игрока
    SilentChange;
    ChangePlayerItemCount(name, -1);

    /// если пердметы кончились
    if GameData.I['state.player.items.'+name] <= 0
    then GameData.S['state.CurrItem'] := '';   // сбрасываем текущий выбранный

    SetModeToUpdate(INT_MAIN);      // говорим, что нужно обновить интерфейс игрока

//    CheckStatus;
    UpdateInterface;
end;

{ PRIVATE METHODS }



procedure TGameDrive.InitFloorObjects;
var
    floor, objCount, objCurr, index: integer;
    objName: string;
    obj: ISuperObject;
begin
    l('-> InitFloorObjects');

    for floor := 1 to 20 do
    begin
        objCount := Max(Random(floor*10), 50);
        for objCurr := 1 to objCount do
        begin
            objName := GetRandObjName;  /// получаем допустимый объект

            index := floor * 1000 + objCurr; /// вычисляем уникальный индекс

            obj := SO();
            obj.S['name'] := objName;
            obj.S['params.HP'] := Script.Exec( GameData.S['floorObjects.'+objName+'.hpCalc'] );

        end;
    end;
end;

function TGameDrive.CurrFloor: variant;
begin
    l('-> CurrFloor');

    result := GameData.S['state.CurrFloor'];
end;

function TGameDrive.CurrStep: string;
begin
    l('-> CurrStep');
    result := GameData.S['state.CurrStep'];
end;

function TGameDrive.GetAuto(name: string): boolean;
begin
    name := LowerCase(name);
    result := GameData.B['state.modes.'+name+'.auto'];
end;

function TGameDrive.GetCurrTarget: string;
begin
    result := GameData.S['targetFloor.'+GameData.S['state.CurrTargetFloor']+'.floor'];
end;


function TGameDrive.GetItemCount(name: string): string;
begin
    result := '0';

    if not assigned(GameData.O[Target + 'items.'+name]) then exit;

    result := GameData.S[Target + 'items.'+name];
end;

function TGameDrive.GetItems: ISuperObject;
begin
    l('-> GetItems');
    result := GameData.O[Target + 'items'];
end;

procedure TGameDrive.SetCreatureAsTarget;
begin
    l('-> SetCreatureAsTarget');
    Target := 'state.creature.';
end;

procedure TGameDrive.SetCurrFloor(val: variant);
begin
    l('-> SetCurrFloor('+String(val)+')');
    GameData.S['state.CurrFloor'] := val;
end;



procedure TGameDrive.SetCurrItem(name: string);
begin
    GameData.S['state.CurrItem'] := name;

    SetModeToUpdate( INT_MAIN );
    UpdateInterface;
end;

procedure TGameDrive.SetCurrStep(val: variant);
begin
    l('-> SetCurrStep('+String(val)+')');
    GameData.S['state.CurrStep'] := val;
end;

procedure TGameDrive.SetCurrTarget(val: string);
begin
    l('-> SetCurrTarget('+val+')');
    GameData.S['state.CurrTargetFloor'] := val;
end;



procedure TGameDrive.AddEffect(name, value: variant);
begin
    /// создаем или модифицируем текущее значение эффекта на цели
    if assigned( GameData.O[Target+'effects.'+name] )
    then
        GameData.I[Target+'effects.'+name+'.value'] := GameData.I[Target+'.effects.'+name+'.value'] + Integer(value)
    else
    begin
        GameData.S[Target+'effects.'+name+'.name'] := name;
        GameData.I[Target+'effects.'+name+'.value'] := Integer(value);
    end;

    SetModeToUpdate( INT_TOWER + INT_MAIN );
end;

function TGameDrive.GetEffect(name: string): string;
begin
     result := '0';

     if assigned( GameData.O[Target+'effects.'+name] ) then
     begin
         result := GameData.S[Target+'effects.'+name+'.value'];
         SetVar('LastVlue', result);
     end;
end;

procedure TGameDrive.ChangeEffect(name, value: variant);
begin
     /// модифицируем текущее значение эффекта на цели
     if assigned( GameData.O[Target+'effects.'+name] ) then
     begin
         GameData.I[Target+'effects.'+name+'.value'] := GameData.I[Target+'effects.'+name+'.value'] + Integer(value);
         SetModeToUpdate( INT_MAIN + INT_TOWER );
     end;
end;

procedure TGameDrive.RemoveEffect(name: string);
begin
     if assigned( GameData.O[Target+'effects.'+name] ) then
     begin
         GameData.Delete(Target+'effects.'+name);
         SetModeToUpdate( INT_MAIN + INT_TOWER );
     end;
end;







function TGameDrive.GetRandObjName: string;
var
    val: integer;
    item: ISuperObject;
begin
    l('-> GetRandObjName');

    val := Random( GameData.I['objRaritySumm'] + 1);

    /// перебираем объекты, и учитываем только доступные по количеству
    for item in GameData.O['floorObjects'] do
    if item.I['allowCount'] <> 0 then
    begin
        val := val - item.I['rarity'];

        if val <= 0 then
        begin
            result := item.S['name'];
            item.I['allowCount'] := item.I['allowCount'] - 1; // списываем количество
            break;
        end;
    end;
end;

function TGameDrive.GetRandItemName: string;
var
    count: integer;
    item: ISuperObject;
begin
    l('-> GetRandItemName');

    count := Random( GameData.I['itemsCount'] );

    /// перебираем ресурсы и получаем один из них. с учетом редкости!
    for item in GameData.O['items'] do
    begin
        if count = 0 then
        begin
            result := item.S['name'];
            exit;
        end;
        Dec(count);
    end;
end;

function TGameDrive.GetRandResName: string;
var
    val: integer;
    item: ISuperObject;
begin
    l('-> GetRandResName');

    /// получаем случайное число, указывающее на один из ресурсов
    val := Random( GameData.I['resRaritySumm'] + 1);

    /// перебираем ресурсы и получаем один из них. с учетом редкости!
    for item in GameData.O['resources'] do
    begin
        val := val - item.I['rarity'];
        if val <= 0 then
        begin
            result := item.S['name'];
            break;
        end;
    end;
end;

function TGameDrive.GetVar(name: string): string;
begin
    l('-> GetVar('+name+')');
    result := GameData.S['state.vars.'+name];
end;

procedure TGameDrive.InitItemsCraftCost;
/// генерим рецепты предметов. в каждой игре - разные
/// отталкиваемся от условной стоимости в ресурсах
var
    cost     // условная остаточная стоимость предмета в ресурсах
   ,part     // условная суммарная стоимость текущего генерируемого компонента
   ,resCount // количество требуемого ресурса
            : integer;
    resName
            : string;
    item,   /// текущий рассматриваемый предмет
    craft   /// складывающаяся стоимость
            : ISuperObject;
begin
    l('-> InitItemsCraftCost');

    for item in GameData.O['state.items'] do
    begin
        if item.I['cost'] = 0 then Continue;

        /// получаем общую стоимость
        cost := item.I['cost'];

        craft := SO();

        /// пока не распределна вся стоимость
        while cost > 0 do
        begin

            part := Random(item.I['cost']+1);  // получаем кусок, который нужно распределить

            part := Min(part, cost);           // выравниваемся, если выпало распределить больше остатка

            resName := GetRandResName;         // получаем случайный ресурс

            resCount := part div GameData.I['resources.'+resName+'.cost'];
                                               // выясняем сколько ресурса можно взять за остаток стоимости
            resCount := Max(1, resCount);      // если остатка не хватает, прописывает одну единицу

            /// добавляем ресурсы в рецепт
            if Assigned( craft[resName] )
            then craft.I[resName] := craft.I[resName] + resCount
            else craft.I[resName] := resCount;

            cost := cost - part;               // списываем израсходованную часть
        end;

        item.O['craft'] := craft;

    end;

end;


procedure TGameDrive.ChangeParam(name, delta: variant);
begin
    l('-> ChangeParam('+name+','+String(delta)+')');

    if pos('player', Target) > 0
    then InterfModes := InterfModes or INT_MAIN
    else InterfModes := InterfModes or INT_TOWER;

    GameData.I[Target + 'params.' + name] :=
        GameData.I[Target + 'params.' + name] + StrToIntDef(delta, 0);

    /// пишем изменение в лог, если не "тихий" режим
    if (pos('player', Target) > 0) and not fSilentChange
    then uLog.Log.Phrase('change_param', GetLang, [name, ifthen(delta >= 0, '+','') + String(delta), GameData.I[Target + 'params.' + name]]);

    fSilentChange := false;
end;

procedure TGameDrive.ChangePlayerItemCount(name, value: variant);
var
    trg: String;
begin
    trg := Target;

    SetPlayerAsTarget;
    ChangeItemCount(name, value);

    Target := trg;
end;

procedure TGameDrive.ChangePlayerParam(name, value: variant);
var
    trg: String;
begin
    trg := Target;

    SetPlayerAsTarget;
    ChangeParam(name, StrToInt(value));

    Target := trg;
end;

procedure TGameDrive.ChangePool(name, val: variant);
begin
    name := LowerCase(name);
    GameData.I['state.modes.'+name+'.pool'] := GameData.I['state.modes.'+name+'.pool'] + val;

    if name = 'tower' then SetModeToUpdate(INT_TOWER);
end;

procedure TGameDrive.ChangeVar(name, value: variant);
begin
    l('-> ChangeVar('+name+','+String(value)+')');
    GameData.I['state.vars.'+name] := GameData.I['state.vars.'+name] + Integer(value);
end;

function TGameDrive.AllowLevelUp: boolean;
begin
    l('-> AllowLevelUp');

    result := GameData.I[ Target + 'params.EXP' ] >= GameData.I[ Target + 'params.'+PRM_NEEDEXP ];
end;

procedure TGameDrive.AllowMode(name: string);
begin
     name := LowerCase(name);

     GameData.B['state.modes.'+name+'.allow'] := true;

     if name = 'think' then uLog.Log.Phrase('allow_think', GetLang, []);

     /// выставляем флаг, что нужно обновить основную часть интерфейса
     SetModeToUpdate(INT_MAIN);
end;

procedure TGameDrive.BreakAuto(name: string);
begin
     name := LowerCase(name);

     GameData.B['state.modes.'+name+'.auto'] := false;  // останавливаем автодействия
     GameData.I['state.modes.'+name+'.pool'] := 0;      // сбрасываем накликанное честным трудом

     if name = 'tower' then SetModeToUpdate(INT_TOWER);
end;

procedure TGameDrive.ChangeItemCount(name, delta: variant);
/// изменяем количество указанного предмета на указанную дельту (в + или - ),
var
    old : integer;
begin
    l('-> ChangeItemCount('+name+','+String(delta)+')');

    old := GameData.I[Target + 'items.' + name];
    GameData.I[Target + 'items.'+name] := GameData.I[Target + 'items.'+name] + delta;

    /// предметы с нулевым количеством - удаляем, чтобы не забивать интерфейс инвентаря
    if GameData.I[Target + 'items.'+name] = 0
    then GameData.Delete(Target + 'items.'+name);

    /// пишем изменение в лог, если не "тихий" режим
    if (pos('player', Target) > 0) and not fSilentChange
    then uLog.Log.Phrase( 'change_item',  GetLang, [
            name,                                             /// внутреннее имя для подстновки иконки
            GameData.S['items.'+name+'.caption.'+GetLang],    /// внешнее имя в текущем языке
            ifthen(delta >= 0, '+','') + String(delta),       /// строка с величиной изменения
            GameData.I[Target + 'items.' + name]              /// текущее количество
        ]);

    fSilentChange := false;
end;
procedure TGameDrive.SetImage(index: integer);
begin
    l('-> SetImage('+IntToStr(index)+')');

    if index < 0 then index := Random(MONSTER_IMAGE_COUNT) + 1;
    GameData.I[Target + 'image'] := index;
end;

procedure TGameDrive.SetItemCount(name, value: variant);
var
    change, old : integer;
begin
    l('-> SetItemCount('+name+','+String(value)+')');

    GameData.I[Target + 'items.'+name] := value;

    /// пишем изменение в лог, если не "тихий" режим
    if (pos('player', Target) > 0) and not fSilentChange then
    begin
        change := value - old;
        uLog.Log.Phrase('change_item', GetLang, [
            name,
            GameData.S['items.'+name+'.caption.'+GetLang],
            ifthen(change >= 0, '+', '' ) + IntToStr(change),
            Integer(value)
        ]);
    end;

    fSilentChange := false;
end;


procedure TGameDrive.SetLootCount(name, value: variant);
var
    change, old: integer;
begin
    l('-> SetLootCount('+name+','+String(value)+')');

    GameData.I[Target + 'loot.'+name] := value;

    /// пишем изменение в лог, если не "тихий" режим
    if (pos('player', Target) > 0) and not fSilentChange then
    begin
        change := value - old;
        uLog.Log.Phrase('change_loot', GetLang, [
            name,
            GameData.S['resources.'+name+'.caption.'+GetLang],
            ifthen(change >= 0, '+', '' ) + IntToStr(change),
            Integer(value)
        ]);
    end;

    fSilentChange := false;

end;
procedure TGameDrive.ChangeLootCount(name, delta: variant);
var
    old: integer;
begin
    l('-> ChangeLootCount('+name+','+String(delta)+')');

    old := GameData.I[Target + 'loot.' + name];
    GameData.I[Target + 'loot.'+name] := GameData.I[Target + 'loot.'+name] + delta;

    /// пишем изменение в лог, если не "тихий" режим
    if (pos('player', Target) > 0) and not fSilentChange
    then uLog.Log.Phrase( 'change_loot',  GetLang, [
            name,                                             /// внутреннее имя для подстновки иконки
            GameData.S['resources.'+name+'.caption.'+GetLang],    /// внешнее имя в текущем языке
            ifthen(delta >= 0, '+','') + String(delta),       /// строка с величиной изменения
            GameData.I[Target + 'loot.' + name]              /// текущее количество
        ]);

    fSilentChange := false;
end;



function TGameDrive.NeedExp(lvl: variant): string;
var
    prev, cost, buff, // переменные для вычисления стоимости
    i: integer;
begin
    l('-> NeedExp('+String(lvl)+')');

    prev := 0;
    cost := 10;

    /// получаем значение с нужным индексом в ряду фиббоначи - это стоимость левелапа
    for I := 0 to lvl do
    begin
        buff := cost;
        cost := cost + prev;
        prev := buff;
    end;

    result := IntToStr(cost);
end;


constructor TGameDrive.Create;
begin
   inherited;
   Script := TScriptDrive.Create;
end;

procedure TGameDrive.CreateRegularMonster;
// формирование пула
var
    i, count, lootCount: integer;
    _items, _loot: string;
    tmp: ISuperObject;
begin
    l('-> CreateRegularMonster');

    SetCreatureAsTarget;
    ResetTargetState;
    SetImage;

    if StrToInt(CurrStep) < StrToInt(MaxStep) then
    begin
        SetName('RU',
            GameData.S['names.first[' +IntToStr(Random( GameData.I['names.count'] ))+'].RU'] + ' ' +
            GameData.S['names.middle['+IntToStr(Random( GameData.I['names.count'] ))+'].RU'] + ' ' +
            GameData.S['names.last['  +IntToStr(Random( GameData.I['names.count'] ))+'].RU']
        );
        SetName('ENG',
            GameData.S['names.first[' +IntToStr(Random( GameData.I['names.count'] ))+'].ENG'] + ' ' +
            GameData.S['names.middle['+IntToStr(Random( GameData.I['names.count'] ))+'].ENG'] + ' ' +
            GameData.S['names.last['  +IntToStr(Random( GameData.I['names.count'] ))+'].ENG']
        );

        /// золото
        ChangeItemCount(ITEM_GOLD, Random( CurrFloor*2 ) + CurrFloor);

        /// ресурсы (шанс на один вид)
        lootCount := Random(CurrFloor div 2);
        for I := 1 to lootCount do
            ChangeLootCount( GetRandResName, Random( CurrFloor div 2 ) +1 );

        // параметры
        count := Random( CurrFloor*10 ) + CurrFloor*5;
        SetParam('HP',    count);
        SetParam('MAXHP', count);
        SetParam('ATK',   Random( CurrFloor*5 )  + CurrFloor*2);
        SetParam('DEF',   CurrFloor*2);
    end;

    if CurrStep = MaxStep then
    begin

        SetName('RU',
            'БОСС '+
            GameData.S['names.first[' +IntToStr(Random( GameData.I['names.count'] ))+'].RU'] + ' ' +
            GameData.S['names.middle['+IntToStr(Random( GameData.I['names.count'] ))+'].RU'] + ' ' +
            GameData.S['names.last['  +IntToStr(Random( GameData.I['names.count'] ))+'].RU']
        );
        SetName('ENG',
            'BOSS '+
            GameData.S['names.first[' +IntToStr(Random( GameData.I['names.count'] ))+'].ENG'] + ' ' +
            GameData.S['names.middle['+IntToStr(Random( GameData.I['names.count'] ))+'].ENG'] + ' ' +
            GameData.S['names.last['  +IntToStr(Random( GameData.I['names.count'] ))+'].ENG']
        );

        /// золото
        ChangeItemCount(ITEM_GOLD, Random( CurrFloor*5 ) + CurrFloor*2);

        // шанс на выпадение дополнительногь предмета
        if Random(2) > 0 then
        begin
//            Log('normal', 'Monster has an item!');
            ChangeItemCount(GetRandItemName, 1);
//            BreakAuto('Tower');
        end;

        /// ресурсы (шанс на три вида, но могут повторяться и будут складываться)
        lootCount := Random( CurrFloor );
        for I := 0 to lootCount do
            ChangeLootCount(GetRandResName, Random( CurrFloor ) + 1);

        // параметры
        count := Random( CurrFloor*50 ) + CurrFloor*30;
        SetParam('HP',    count);
        SetParam('MAXHP', count);
        SetParam('ATK',   Random( CurrFloor*25 )  + CurrFloor*10);
        SetParam('DEF',   CurrFloor*6);
    end;

end;

destructor TGameDrive.Destroy;
begin
    Script.Free;
    inherited;
end;

/// скриптовые команды

procedure TGameDrive.PlayerAttack;
begin
    l('-> PlayerAttack');

    ChangePool('Tower', 1);

    UpdateInterface;
end;

procedure TGameDrive.PlayerMakeAttack;
/// обработка взаимной атаки игрока и монстра в башне
/// алгоритм:
///     1. из текущих характеристик монстра и игрока инициализируются переменные боя:
///         mc_DMG - выкинутый монстром урон
///         mc_DEF - величина блока урона от игрока
///         mc_GEM - количество полученных монстром кристаллов

///         pl_DMG - вычисленный урон игрока по монстру
///         pl_DEF - величина блока урона от монстра
///         gm_RED - количество выпавших из монстра красных кристаллов
///         gm_WHT - количество выпавших из монстра белых кристаллов
///         gm_BLU - количество выпавших из монстра синих кристаллов
///         gm_GRN - количество выпавших из монстра зеленых кристаллов
///         gm_PRP - количество выпавших из монстра фиолетовых кристаллов
///         gm_YLW - количество выпавших из монстра желтых кристаллов
///     2. отыгрываются скрипты на событие onAttack у монстра и игрока, котрые могут модифицировать значения
///     3. применяем дамаг на игрока и монстра
var
    PlayerATK: integer;
    PlayerDEF: integer;

    CreatureATK: integer;
    CreatureDEF: integer;

    BLOCK, DMG : integer;
begin
    l('-> PlayerMakeAttack');

    /// установка переменных с параметрами боя
    SetPlayerAsTarget;
    PlayerATK := StrToInt(GetParam('ATK'));
    PlayerDEF := StrToInt(GetParam('DEF'));;
    SetVar('pl_DMG', Random(PlayerATK));
    SetVar('pl_DEF', PlayerDEF);

    SetCreatureAsTarget;
    CreatureATK := StrToInt(GetParam('ATK'));
    CreatureDEF := StrToInt(GetParam('DEF'));;
    SetVar('mc_DMG', Random(CreatureATK));
    SetVar('mc_DEF', CreatureDEF);



    /// выполняем все скрипты на атаку игрока
    SetPlayerAsTarget;
    PlayEvent('onAttack');

    /// выполняем все скрипты на атаку монстра
    SetCreatureAsTarget;
    PlayEvent('onAttack');



    /// реализуем атаку текущими значениями переменных

    /// считаем монстра
    SetCreatureAsTarget;

    /// снижаем урон от игрока блоком
    // 1 DEF = -0.1% dmg
    BLOCK := Round(StrToInt(GetVar('pl_DMG')) * ((StrToInt(GetVar('mc_DEF')) / 10) / 100));
    DMG := StrToInt(GetVar('pl_DMG'))- BLOCK;
    ChangeParam('HP', -DMG); /// списываем хиты

    /// пишем событие в лог
    if BLOCK > 0
    then uLog.Log.Phrase('player_strike_block', GetLang, [DMG, BLOCK])
    else uLog.Log.Phrase('player_strike', GetLang, [DMG]);


    /// считаем игрока
    SetPlayerAsTarget;

    /// снижаем урон от игрока блоком
    // 1 DEF = -0.1% dmg
    BLOCK := Round(StrToInt(GetVar('mc_DMG')) * ((StrToInt(GetVar('pl_DEF')) / 10) / 100));
    DMG := StrToInt(GetVar('mc_DMG'))- BLOCK;
    SilentChange;
    ChangeParam('HP', -DMG); /// списываем хиты

    uLog.Log.PhraseAppend('fight_swords', GetLang, []);

    /// пишем событие в лог
    if BLOCK > 0
    then uLog.Log.PhraseAppend('monster_strike_block', GetLang, [DMG, BLOCK])
    else uLog.Log.PhraseAppend('monster_strike', GetLang, [DMG]);

end;



procedure TGameDrive.PlayEvent(name: string);
begin
///
end;

procedure TGameDrive.ProcessAttack;
begin
    l('-> ProcessAttack');

    if GetPool('Tower') > 0 then  // если есть действия авто ли пула башни
    begin
        PlayerMakeAttack;  // проводим взаимную атаку монтра и игрока

        // если не установлен режим авто, будем снимать с локального пула
        if not GetAuto('Tower')
        then ChangePool('Tower', -1);

        // если установлен режим авто, будем снимать с автодействий
        if GetAuto('Tower') then
        begin
            SilentChange;
            ChangePlayerParam('AutoAction', -1);
        end;

//        if GetPool('Tower') = 0 then uLog.Log.Phrase('attack_pool_empty', GetLang, []);
    end;

end;

procedure TGameDrive.ProcessEffects;
var
    item, tmp: isuperobject;

begin
    if not assigned(GameData.O[Target+'effects']) then exit;

    /// для каждого висящего на игроке эффекта отыгрываем его auto скрипт, если прописан
    /// тонкость в том, что при выполнении автоскриптов некоторые эффекты могут самоудаляться как
    /// отработавшие и при попытке дальнейшего перебора GameData.O[Target+'effects'] вылетит
    /// аксес. потому мы делаем слепок перед перебором и спокойно его обрабатываем
    tmp := GameData.O[Target+'effects'].Clone;
    for item in tmp do
    begin
        if Assigned(item) then
            Script.Exec( GameData.S['effects.'+item.S['name']+'.script.auto'] );
    end;
end;

procedure TGameDrive.ResetTargetState;
var
    t: string;
begin
    l('-> ResetTargetState');

    t := Copy(Target, 1, Length(Target)-1);
    GameData.O[t] := SO(CREATURE_SHABLON);
end;


procedure TGameDrive.RunAuto(name: string);
begin
     name := LowerCase(name);
     GameData.B['state.modes.'+name+'.auto'] := true;

     if name = 'tower' then SetModeToUpdate(INT_TOWER);
end;


procedure TGameDrive.l(text: string);
var
    f: TextFile;
begin
    if not doLog then exit;


    AssignFile(f, ExtractFilePath( paramstr(0) ) + FILE_GAME_LOG);

    if not FileExists(ExtractFilePath( paramstr(0) ) + FILE_GAME_LOG)
    then Rewrite(f)
    else Append(f);

    WriteLn(f, text);
    CloseFile(f);
end;

procedure TGameDrive.l_drop;
begin
    if FileExists(ExtractFilePath( paramstr(0) ) + FILE_GAME_LOG)
    then DeleteFile( ExtractFilePath( paramstr(0) ) + FILE_GAME_LOG );
end;



procedure TGameDrive.l_set(val: boolean);
begin
    doLog := val;
end;

initialization
   GameDrive := TGameDrive.Create;
   GameDrive.GameData := SO(GAME_DATA);  // загрузка дефолтных данных

finalization
   GameDrive.Free;

{
function TData.GetTrashIDs: string;
var
   i: integer;
   keys: TArray<integer>;
begin
    keys := arrFloors[CurrLevel].Trash.Keys.ToArray;

    for I := 0 to High(keys) do
        result := result + IntToStr(keys[i]) + ',';
end;
}


end.
