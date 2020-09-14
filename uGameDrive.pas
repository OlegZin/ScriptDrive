unit uGameDrive;

interface

uses
    uScriptDrive, superobject, uConst,
    System.SysUtils, Generics.Collections, Classes, Math, StrUtils;

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

        procedure NewGame;

        function GetLang: string;   // ������� ����� � ������ �������� ����� ENG|RU
        function GetRandResName: string; /// ��������� ����������� ����� ���������� ������� � ������ ��������
        function GetCurrFloor: string;             // ������� ����
{
        function GetArtLvl(name: string): string;  // ���������� ������� ��������� �� ��� ����������� �����
        function GetRandItemName: string;          // ���������� ��� ���������� ��������
        procedure AllowMode(name: string);
        procedure AllowTool(name: string);
        procedure OpenThink(name: string);
}
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

procedure TGameDrive.NewGame;
begin
    GameData := SO(GAME_DATA);  // �������� ��������� ������
    InitItemsCraftCost;         // ��������� �������� ���������
    InitFloorObjects;
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

        item.O['state.items.'+resName+'.craft'] := craft;

    end;

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
