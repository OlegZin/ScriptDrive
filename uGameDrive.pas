unit uGameDrive;

interface

uses
    uScriptDrive, superobject, uConst,
    System.SysUtils, Generics.Collections, Classes, Math, StrUtils,
    uThinkMode, uGameInterface, uLog, uTower;

type

    TGameDrive = class
    private
        GameData: ISuperObject; /// ��� ��������� ������ ����.

        Target: string;  /// ���� �� �������� ���������� ������� � ��������� GameState
            // ������� ��������� ����. ������������ ���
            // �������, ������� �� ����������� � ����������� �������.
            // ��� �������� ��������� ����� ������� ��� ��������

    public

        constructor Create;
        destructor Destroy;

        function NewGame(level: integer; lang: string): string;
        function LoadGame( lang: string ): string;
        function SaveGame: string;

        procedure CheckStatus;

        function GetLang: string;          // ������� ����� � ������ �������� ����� ENG|RU
        procedure SetLang(lang: string);   // ������� ����� � ������ �������� ����� ENG|RU
        function GetRandResName: string;   // ��������� ����������� ����� ���������� ������� � ������ ��������
        function GetCurrFloor: string;     // ������� ����

        function GetRandItemName: string;          // ���������� ��� ���������� ��������
        procedure ChangePlayerItemCount(name, delta: variant);
        function NeedExp(lvl: variant): string;
{
        function GetArtLvl(name: string): string;  // ���������� ������� ��������� �� ��� ����������� �����
        procedure AllowMode(name: string);
        procedure AllowTool(name: string);
        procedure OpenThink(name: string);
}
        procedure SetNextTarget;

        procedure UpdateInterface;
        procedure SetActiveMode(name: string);

        /// ������ � �����
        procedure Log(kind, text: string);

        //// ����������� �������
        procedure onPlayerAttack;
    private
        Script : TScriptDrive;

        procedure InitItemsCraftCost; /// ��������� ��������� ��������� � ��������. ��������� ����� ��������� � ������ ����, �������� �������
        procedure InitFloorObjects;   /// ��������� ��������� �� ������
        function GetRandObjName: string;

        function GetInLang(text: string; lang: string = ''): string; /// ��������� ������ � ������� ����� �� ������������� ������
    end;

Var
    GameDrive : TGameDrive;

implementation

{ TData }

{PUBLIC // Script allow}

procedure TGameDrive.CheckStatus;
/// �������� �������� ������� ������ �� �������� ��������� �������� ��������
begin
    /// ��������� ���������� ���� (�������� �����). ���� ��� - ��������� ������
    if   'floor' + GameData.S['state.CurrFloor'] = GameData.S['state.CurrTarget']
    then Script.Exec(GameData.S['targetFloor.'+GameData.S['state.CurrTarget'] + '.script']);
end;


function TGameDrive.NewGame(level: integer; lang: string): string;
var
    i : integer;
    name: string;
begin
    result := '';
    InitItemsCraftCost;         // ��������� �������� ���������
    InitFloorObjects;           // ��������� �������� �� ������

    GameData.S['state.Lang'] := lang;

    GameData.I['state.player.params.NeedExp'] := StrToInt(NeedExp(1));

    /// ������� �������������� �������, ������ �� ������ ����
    /// ������������
    GameData.I['state.player.params.AutoAction'] := 500 + 500 * level;

    /// ������� ��������
    for i := 1 to level do
    begin
        name := GetRandItemName;
        ChangePlayerItemCount(name, level);
    end;

    /// ������
    ChangePlayerItemCount('gold', 100000 + 10000 * level);

    /// ��������� ��������� ������� ��������
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
//       ,false // �� ������������ �������� ��������������
//       ,false  // �� ��������������� ������� ����� � ������ ������������������
    );

    /// "��������" ������ ��� ��������� ��������
    GameData.O['state'].SaveTo(
        DIR_DATA + FILE_GAME_DATA_TEST
       ,true // �� ������������ �������� ��������������
//       ,false  // �� ��������������� ������� ����� � ������ ������������������
    );
end;

function TGameDrive.LoadGame( lang: string ): string;
/// �������� ��������� ����
var
    state: ISuperObject;
begin
    /// ��������� ������, ���� ���� ����������
    if DirectoryExists( DIR_DATA ) and FileExists( DIR_DATA + FILE_GAME_DATA ) then
    begin
        /// �������� ���������
        state := TSuperObject.ParseFile( DIR_DATA + FILE_GAME_DATA, false );

        /// ���� ������ ���������, ������ ����������
        if Assigned(state) then
        GameData.O['state'] := state;
    end;

    GameData.S['state.Lang'] := lang;

    /// ��������� ��������� ������� ��������
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
/// ����� ����������� ������� ���� �� ��������� ������� ������� targetFloor
begin
    GameData.S['state.CurrTarget'] :=
        GameData.S['targetFloor.'+GameData.S['state.CurrTarget']+'.next'];
end;

procedure TGameDrive.UpdateInterface;
/// �������� ��������� ���� ��������� ������
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
            objName := GetRandObjName;  /// �������� ���������� ������

            index := floor * 1000 + objCurr; /// ��������� ���������� ������

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

    /// ���������� �������, � ��������� ������ ��������� �� ����������
    for item in GameData.O['floorObjects'] do
    if item.I['allowCount'] <> 0 then
    begin
        val := val - item.I['rarity'];

        if val <= 0 then
        begin
            result := item.S['name'];
            item.I['allowCount'] := item.I['allowCount'] - 1; // ��������� ����������
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

    /// ���������� ������� � �������� ���� �� ���. � ������ ��������!
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
    /// �������� ��������� �����, ����������� �� ���� �� ��������
    val := Random( GameData.I['resRaritySumm'] + 1);

    /// ���������� ������� � �������� ���� �� ���. � ������ ��������!
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
/// ������� ������� ���������. � ������ ���� - ������
/// ������������� �� �������� ��������� � ��������
var
    i
   ,cost     // �������� ���������� ��������� �������� � ��������
   ,part     // �������� ��������� ��������� �������� ������������� ����������
   ,resCount // ���������� ���������� �������
            : integer;
    resName
            : string;
    item,   /// ������� ��������������� �������
    craft   /// �������������� ���������
            : ISuperObject;
begin

    for item in GameData.O['state.items'] do
    begin
        if item.I['cost'] = 0 then Continue;

        /// �������� ����� ���������
        cost := item.I['cost'];

        craft := SO();

        /// ���� �� ����������� ��� ���������
        while cost > 0 do
        begin

            part := Random(item.I['cost']+1);  // �������� �����, ������� ����� ������������

            part := Min(part, cost);           // �������������, ���� ������ ������������ ������ �������

            resName := GetRandResName;         // �������� ��������� ������

            resCount := part div GameData.I['resources.'+resName+'.cost'];
                                               // �������� ������� ������� ����� ����� �� ������� ���������
            resCount := Max(1, resCount);      // ���� ������� �� �������, ����������� ���� �������

            /// ��������� ������� � ������
            if Assigned( craft[resName] )
            then craft.I[resName] := craft.I[resName] + resCount
            else craft.I[resName] := resCount;

            cost := cost - part;               // ��������� ��������������� �����
        end;

        item.O['craft'] := craft;

    end;

end;


procedure TGameDrive.ChangePlayerItemCount(name, delta: variant);
/// �������� ���������� ���������� �������� �� ��������� ������ (� + ��� - ),
/// �� �� ���� ����.
begin
    GameData.I['state.items.'+name+'.count'] := Max(GameData.I['state.items.'+name+'.count'] + delta, 0);
end;


function TGameDrive.NeedExp(lvl: variant): string;
var
    prev, cost, buff, // ���������� ��� ���������� ���������
    i: integer;
begin

    prev := 0;
    cost := 10;

    /// �������� �������� � ������ �������� � ���� ��������� - ��� ��������� ��������
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
   GameDrive.GameData := SO(GAME_DATA);  // �������� ��������� ������

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
