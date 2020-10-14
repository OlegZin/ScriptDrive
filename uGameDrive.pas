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
        function LoadGame( lang: string ): string; /// �������� ��������� ����
        function SaveGame: string;        /// ���������� �������� ��������� ����
        procedure UpdateInterface;        /// ����������� ��������� ����������
        procedure SetMode(name: string);  /// ������������ �� ���� ���������� ������


/// �������� �����
        procedure CheckStatus;             // �������� ��������� ���� � ��������� �������

// ������ � ������ � �� �����������, ���������� � ������
        procedure SetPlayerAsTarget;   /// ��������� ������ ����� ������� ������ � ����������� � �������
        procedure SetCreatureAsTarget; /// ��������� ������� ����� ������� ������ � ����������� � �������

        procedure SetParam(name, value: string);    /// ������������� �������� ����������� ���������
        procedure ChangeParam(name, delta: string); /// �������� �������� ��������� �� ������
        function GetParam(name: string): string;    /// ��������� �������� ���������

        procedure PlayEvent(name: string); /// ���������� �������� ����, ����������� � ���������� �������.
                                           /// ��������, "onAttack"

/// ������ � ������
        function GetLang: string;          // ������� ����� � ������ �������� ����� ENG|RU
        procedure SetLang(lang: string);   // ������� ����� � ������ �������� ����� ENG|RU

/// ������ � �������
        procedure SetCurrFloor(val: string); // ���������� ������� ����
        function GetCurrFloor: string;       // ������� ����

        procedure SetCurrStep(val: string);  // ��������� ������� ���
        function GetCurrStep: string;        // ������� ���
        function GetMaxStep: string;         // ������������ ��� ��� �������� �����

/// ������ � ����������
        function GetRandItemName: string;          // ���������� ��� ���������� ��������
        procedure ChangePlayerItemCount(name, delta: variant);

/// ������ � ���������
        function GetRandResName: string;   // ��������� ����������� ����� ���������� ������� � ������ ��������

/// ������ � ������ �� ������.
/// ��� ������ ����� �� ������� ���� ����������� �������� ������.
        function GetCurrTarget: string;
        procedure SetNextTarget;

/// ������ � �����
        procedure Log(kind, text: string);

/// ������ � �����������
        procedure SetVar(name, value: string);
        function GetVar(name: string): string;

/// �������� ������� ������
        procedure PlayerMakeAttack; /// ��������� ���� �������� ����� ������ � �������� ������� � �����
                                    /// � ���������� ������� � ����������� �� ��� ��������

{
        function GetArtLvl(name: string): string;  // ���������� ������� ��������� �� ��� ����������� �����
        procedure AllowMode(name: string);
        procedure AllowTool(name: string);
        procedure OpenThink(name: string);
}

    private
        Script : TScriptDrive;

        procedure InitItemsCraftCost; /// ��������� ��������� ��������� � ��������. ��������� ����� ��������� � ������ ����, �������� �������
        procedure InitFloorObjects;   /// ��������� ��������� �� ������
        function GetRandObjName: string; /// ��������� ������, ������� ����� ���������� �� �����, � ������ �������� � ���������� ����������
        function NeedExp(lvl: variant): string;

        function GetInLang(text: string; lang: string = ''): string;
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

function TGameDrive.GetMaxStep: string;
begin
    result := IntToStr(GameData.I['state.CurrFloor'] * STEPS_BY_FLOOR);
end;

function TGameDrive.GetParam(name: string): string;
begin
    result := GameData.S[Target + 'params.' + name];
end;

procedure TGameDrive.SetLang(lang: string);
begin
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

procedure TGameDrive.SetNextTarget;
/// ����� ����������� ������� ���� �� ��������� ������� ������� targetFloor
begin
    GameData.S['state.CurrTargetFloor'] :=
        GameData.S['targetFloor.'+GameData.S['state.CurrTargetFloor']+'.next'];
end;

procedure TGameDrive.SetParam(name, value: string);
begin
    GameData.S[Target + 'params.' + name] := value;
end;

procedure TGameDrive.SetPlayerAsTarget;
begin
    Target := 'state.player.';
end;

procedure TGameDrive.SetVar(name, value: string);
begin
    GameData.S['state.vars.'+name] := value;
end;

procedure TGameDrive.UpdateInterface;
/// �������� ��������� ���� ��������� ������
begin
    GameInterface.Update( GameData.O['state.player.params']);
//    fTower.Update( '{params:'+GameData.O['state.creature.params'].AsJSon+'},' );
    uLog.Log.Update;
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

function TGameDrive.GetCurrStep: string;
begin
    result := GameData.S['state.CurrStep'];
end;

function TGameDrive.GetCurrTarget: string;
begin
    result := GameData.S['targetFloor.'+GameData.S['state.CurrTargetFloor']+'.floor'];
end;

procedure TGameDrive.SetCreatureAsTarget;
begin
    Target := 'state.creature.';
end;

procedure TGameDrive.SetCurrFloor(val: string);
begin
    GameData.S['state.CurrFloor'] := val;
end;



procedure TGameDrive.SetCurrStep(val: string);
begin
    GameData.S['state.CurrStep'] := val;
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

function TGameDrive.GetVar(name: string): string;
begin
    result := GameData.S['state.vars.'+name];
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


procedure TGameDrive.ChangeParam(name, delta: string);
begin
    GameData.D[Target + 'params.' + name] :=
        GameData.D[Target + 'params.' + name] + StrToFloatDef(delta, 0);
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

/// ���������� �������

procedure TGameDrive.PlayerMakeAttack;
/// ��������� �������� ����� ������ � ������� � �����
/// ��������:
///     1. �� ������� ������������� ������� � ������ ���������������� ���������� ���:
///         mc_DMG - ��������� �������� ����
///         mc_BLK - ����������� �������� ����� ����� �� ������
///         mc_GEM - ���������� ���������� �������� ����������
///         pl_DMG - ����������� ���� ������ �� �������
///         pl_BLK - ����������� �������� ����� ����� �� �������
///         gm_RED - ���������� �������� �� ������� ������� ����������
///         gm_WHT - ���������� �������� �� ������� ����� ����������
///         gm_BLU - ���������� �������� �� ������� ����� ����������
///         gm_GRN - ���������� �������� �� ������� ������� ����������
///         gm_PRP - ���������� �������� �� ������� ���������� ����������
///         gm_YLW - ���������� �������� �� ������� ������ ����������
///     2. ������������ ������� �� ������� onAttack � ������� � ������, ������ ����� �������������� ��������
///     3. ������������ ������ ���������� ���������� ������ � �������
///     4. �� ��������� ������� ��������� ������ � �������:
///           4.1 ���������������� ����������:
///               prm_Action - ��� ������� � ������ �������� ����������. � ������ ������ "onAttack"
///                            ����� �������������� ��� ��������� ���������,
///                            �������� ������� ���� �� �����, �� �������� �� �����
///               prm_Name - ��� ����������� ���������, �������� HP
///               prm_Delta - �����/������� �������� ��������, ����� ���� ��� � ����, ��� � � �����
///           4.2 ������������ ������� onParamChange
///           4.3 �������� prm_Name �������������� �������� �������� �������� prm_Delta
///     5. ���������� ����� �������� ������� ����.
///        ��������, ����� ��� ������� ����������� ���� ������� ��� ��������� ���.
///     6. ���������� ����� ���������� ����������
var
    CreatureHP: integer;
    CreatureDEF: integer;
    PlayerATK: integer;
    DMG, BLOCK : integer;
    ATKbuff: integer;
    bustedBySword: integer;

    Player: ISuperObject;
    Creature: ISuperObject;
begin

    ///
end;



procedure TGameDrive.PlayEvent(name: string);
begin
///
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
