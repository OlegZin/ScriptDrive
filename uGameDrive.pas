unit uGameDrive;

interface

uses
    uScriptDrive, superobject, uConst,
    System.SysUtils, Generics.Collections, Classes, Math, StrUtils,
    uThinkMode, uGameInterface, uLog, uTower;

type

    TGameDrive = class
    private
        GameData: ISuperObject; /// все статичные данные игры.

        Target: string;  /// путь до текущего выбранного объекта в структуре GameState
            // текущая выбранная цель. используется для
            // методов, которые не применяются к конкретному объекту.
            // что позволит сократить набор методов для скриптов

    public

        constructor Create;
        destructor Destroy;

        function NewGame(level: integer; lang: string): string;
        function LoadGame( lang: string ): string;
        function SaveGame: string;

        procedure CheckStatus;

        function GetLang: string;          // возврат стрки с именем текущего языка ENG|RU
        procedure SetLang(lang: string);   // возврат стрки с именем текущего языка ENG|RU
        function GetRandResName: string;   // получение внутреннего имени случайного ресурса с учетом редкости
        function GetCurrFloor: string;     // текущий этаж

        function GetRandItemName: string;          // внутреннее имя случайного предмета
        procedure ChangePlayerItemCount(name, delta: variant);
        function NeedExp(lvl: variant): string;
{
        function GetArtLvl(name: string): string;  // возвращает уровень артефакта по его внутреннему имени
        procedure AllowMode(name: string);
        procedure AllowTool(name: string);
        procedure OpenThink(name: string);
}
        procedure SetNextTarget;

        procedure UpdateInterface;
        procedure SetActiveMode(name: string);

        /// работа с логом
        procedure Log(kind, text: string);

        //// обработчики событий
        procedure onPlayerAttack;
    private
        Script : TScriptDrive;

        procedure InitItemsCraftCost; /// генерация стоимости предметов в ресурсах. стоимость будет различной в каждой игре, сохраняя интригу
        procedure InitFloorObjects;   /// генерация предметов на этажах
        function GetRandObjName: string;

        function GetInLang(text: string; lang: string = ''): string; /// получение строки в текущем языке из мультиязычной строки
    end;

Var
    GameDrive : TGameDrive;

implementation

{ TData }

{PUBLIC // Script allow}

procedure TGameDrive.CheckStatus;
/// пересчет игрового статуса исходя из текущего состояния игроовых объектов
begin
    /// проверяем достижение цели (целевого этажа). если так - выполняем скрипт
    if   'floor' + GameData.S['state.CurrFloor'] = GameData.S['state.CurrTarget']
    then Script.Exec(GameData.S['targetFloor.'+GameData.S['state.CurrTarget'] + '.script']);
end;


function TGameDrive.NewGame(level: integer; lang: string): string;
var
    i : integer;
    name: string;
begin
    result := '';
    InitItemsCraftCost;         // генерация рецептов предметов
    InitFloorObjects;           // генерация объектов на этажах

    GameData.S['state.Lang'] := lang;

    GameData.I['state.player.params.NeedExp'] := StrToInt(NeedExp(1));

    /// генерим первоначальные ресурсы, исходя из уровня игры
    /// автодействия
    GameData.I['state.player.params.AutoAction'] := 500 + 500 * level;

    /// генерим предметы
    for i := 1 to level do
    begin
        name := GetRandItemName;
        ChangePlayerItemCount(name, level);
    end;

    /// золото
    ChangePlayerItemCount('gold', 100000 + 10000 * level);

    /// проверяем состояние игровых объектов
    GameDrive.CheckStatus;

    GameDrive.UpdateInterface;
end;

procedure TGameDrive.onPlayerAttack;
begin

end;

function TGameDrive.SaveGame: string;
begin
    GameData.O['state'].SaveTo(
        DIR_DATA + FILE_GAME_DATA
//       ,false // не использовать красивое форматирование
//       ,false  // не преобразовывать русские буквы в эскейп последовательности
    );

    /// "красивая" версия для тестового контроля
    GameData.O['state'].SaveTo(
        DIR_DATA + FILE_GAME_DATA_TEST
       ,true // не использовать красивое форматирование
//       ,false  // не преобразовывать русские буквы в эскейп последовательности
    );
end;

function TGameDrive.LoadGame( lang: string ): string;
/// загрузка состояния игры
var
    state: ISuperObject;
begin
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
    GameDrive.CheckStatus;

    GameDrive.UpdateInterface;
end;

procedure TGameDrive.Log(kind, text: string);
begin
    uLog.Log.Add(kind, text);
end;

function TGameDrive.GetLang: string;
begin
    result := GameData.S['state.Lang'];
end;

procedure TGameDrive.SetLang(lang: string);
begin
    GameData.S['state.Lang'] := lang;
end;




procedure TGameDrive.SetNextTarget;
/// метод переключает текущую цель на следующий элемент массива targetFloor
begin
    GameData.S['state.CurrTarget'] :=
        GameData.S['targetFloor.'+GameData.S['state.CurrTarget']+'.next'];
end;

procedure TGameDrive.UpdateInterface;
/// обновяем состояние окна активного режима
begin
    GameInterface.Update( GameData.O['state.player.params']);
//    fTower.Update( '{params:'+GameData.O['state.creature.params'].AsJSon+'},' );
    uLog.Log.Update;
end;

procedure TGameDrive.SetActiveMode(name: string);
begin
{    Tower.SetUnactive;
    Think.SetUnactive;

    if name = 'Tower' then Tower.SetActive;
    if name = 'Think' then Think.SetActive;
}
end;

{ PRIVATE METHODS }



procedure TGameDrive.InitFloorObjects;
var
    floor, objCount, objCurr, index: integer;
    objName: string;
    obj: ISuperObject;
begin
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

function TGameDrive.GetCurrFloor: string;
begin
    result := GameData.S['state.CurrFloor'];
end;

function TGameDrive.GetInLang(text: string; lang: string = ''): string;
var
    multiLang: ISuperObject;
begin
    result := '';
    if lang = '' then lang := GetLang;

    multiLang := SO(text);
    if Assigned(multiLang) then result := multiLang[lang].AsString;
end;


function TGameDrive.GetRandObjName: string;
var
    val: integer;
    item: ISuperObject;
begin
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

procedure TGameDrive.InitItemsCraftCost;
/// генерим рецепты предметов. в каждой игре - разные
/// отталкиваемся от условной стоимости в ресурсах
var
    i
   ,cost     // условная остаточная стоимость предмета в ресурсах
   ,part     // условная суммарная стоимость текущего генерируемого компонента
   ,resCount // количество требуемого ресурса
            : integer;
    resName
            : string;
    item,   /// текущий рассматриваемый предмет
    craft   /// складывающаяся стоимость
            : ISuperObject;
begin

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


procedure TGameDrive.ChangePlayerItemCount(name, delta: variant);
/// изменяем количество указанного предмета на указанную дельту (в + или - ),
/// но не ниже нуля.
begin
    GameData.I['state.items.'+name+'.count'] := Max(GameData.I['state.items.'+name+'.count'] + delta, 0);
end;


function TGameDrive.NeedExp(lvl: variant): string;
var
    prev, cost, buff, // переменные для вычисления стоимости
    i: integer;
begin

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

destructor TGameDrive.Destroy;
begin
    Script.Free;
    inherited;
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
