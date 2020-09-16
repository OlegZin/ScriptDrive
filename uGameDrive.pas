unit uGameDrive;

interface

uses
    uScriptDrive, superobject, uConst,
    System.SysUtils, Generics.Collections, Classes, Math, StrUtils;

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

        function NewGame(level: integer): string;
        function LoadGame(level: integer): string;

        procedure CheckStatus;

        function GetLang: string;   // возврат стрки с именем текущего языка ENG|RU
        function GetRandResName: string; /// получение внутреннего имени случайного ресурса с учетом редкости
        function GetCurrFloor: string;             // текущий этаж

        function GetRandomItemName: string;
        procedure ChangePlayerItemCount(name, delta: variant);
{
        function GetArtLvl(name: string): string;  // возвращает уровень артефакта по его внутреннему имени
        function GetRandItemName: string;          // внутреннее имя случайного предмета
        procedure AllowMode(name: string);
        procedure AllowTool(name: string);
        procedure OpenThink(name: string);
}
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

function TGameDrive.NewGame(level: integer): string;
var
    i : integer;
    name: string;
begin
    result := '';
    GameData := SO(GAME_DATA);  // загрузка дефолтных данных
    InitItemsCraftCost;         // генерация рецептов предметов
    InitFloorObjects;           // генерация объектов на этажах

    /// генерим первоначальные ресурсы, исходя из уровня игры
    /// автодействия
    GameData.I['state.AutoActions'] := 500 + 500 * level;

    /// предметы. на один меньше, чем уровень новой игры
    if level > 1 then
    for i := 1 to level -1 do
    begin
        name := GetRandomItemName;
    end;
end;

function TGameDrive.GetLang: string;
begin
    result := GameData.S['state.Lang'];
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

function TGameDrive.GetRandomItemName: string;
var
    count: integer;
begin
    count := GameData.O['items'].AsArray.Length;
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

        item.O['state.items.'+resName+'.craft'] := craft;

    end;

end;


procedure TGameDrive.ChangePlayerItemCount(name, delta: variant);
begin

end;

procedure TGameDrive.CheckStatus;
/// пересчет игрового статуса исходя из текущего состояния игроовых объектов
begin

end;

function TGameDrive.LoadGame(level: integer): string;
begin

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
