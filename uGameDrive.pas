unit uGameDrive;

interface

uses
    uScriptDrive, superobject, uConst,
    System.SysUtils, Generics.Collections, Classes, Math, StrUtils, ShellAPI,
    uGameInterface, uLog, uTower, uThink, PhrasesDB, uFloor, uFloorTargetsDB;

type

    TGameDrive = class
    private
        GameData: ISuperObject; /// ��� ��������� ������ ����.

        Target: string;  /// ���� �� �������� ���������� ������� � ��������� GameState
            // ������� ��������� ����. ������������ ���
            // �������, ������� �� ����������� � ����������� �������.
            // ��� �������� ��������� ����� ������� ��� ��������

        InterfModes : integer;
            // ����� ������, ������������ ����� ����� ���������� ��������� ���
            // ������ ������ UpdateInterface

        doLog: boolean;
            // ���������� �� �������� ��������� � ��������� ����

        fSilentChange : boolean;
            // ���� "������" ���������� ��������� ���������, ����� �� �������� ���
    public

        constructor Create;
        destructor Destroy;

        /// ������ � ���������� ������������
        procedure l_drop;
        procedure l_set(val: boolean);
        procedure l(text: string);

        function NewGame(level: integer; lang: string): string;
        function LoadGame( lang: string ): string; /// �������� ��������� ����
        function SaveGame: string;        /// ���������� �������� ��������� ����
        procedure SaveTestData;           /// ���������� ��� ��������� ���� � �������� �����
        procedure SetMode(name: string);           /// ������������ �� ���� ���������� ������

        procedure UpdateInterface;                  /// ����������� ��������� ����������
        procedure SetModeToUpdate(val: integer);
            /// ������������ �������� ����������, ����������� �� ��, ����� ����� ���������� �����
            /// �������� ��� ������ ������ UpdateInterface. �������� ������ � ������ ��������
            /// INT_XXX

        function AllowLevelUp: boolean;

/// �������� �����
        procedure CheckStatus;             // �������� ��������� ���� � ��������� �������
        procedure ProcessEffects;          // ���������� ��� �������������� ������� �� ���� �����

// ������ � ������ � �� �����������, ���������� � ������
        procedure SetPlayerAsTarget;   /// ��������� ������ ����� ������� ������ � ����������� � �������
        procedure SetCreatureAsTarget; /// ��������� ������� ����� ������� ������ � ����������� � �������

        procedure ResetTargetState;    /// �������� ��������� ��������� � ������
        procedure SetName(lang, name: string); // ������ ��� ���� � ��������� �����
        procedure SetImage(index: variant);

        procedure ChangeItemCount(name, delta: variant);  // ��������� ���������� ��������� � ��������� ������� ����
        procedure SetItemCount(name, value: variant);     // ��������� ���������� ��������� � ��������� ������� ����
        function  GetItemCount(name: string): string;     // ��������� ���������� ��������� � ��������� ������� ����

        procedure ChangeLootCount(name, delta: variant);  // ��������� ���������� ��������� � ��������� ������� ����
        procedure SetLootCount(name, value: variant);     // ��������� ���������� ��������� � ��������� ������� ����

        procedure SilentChange;                      /// ��������� ��������� ��������� �� ����� �������� �������������� ��������� � ���
        procedure SetParam(name, value: variant);    /// ������������� �������� ����������� ���������
        procedure ChangeParam(name, delta: variant); /// �������� �������� ��������� �� ������
        function GetParam(name: string): string;    /// ��������� �������� ���������

        procedure ChangePlayerParam(name, value: variant);
        procedure ChangePlayerItemCount(name, value: variant);
        procedure ChangePlayerLootCount(name, delta: variant);  // ��������� ���������� ��������� � ��������� ������� ����

        procedure Collect(name: string; objects: ISuperObject);
           // ���������� � ��������� ������ ������� ���� ���� ���������
           // ������ objects

        procedure SetEvent(event, script: string);
        procedure PlayEvent(event: string); /// ���������� �������� ����, ����������� � ���������� �������.
                                           /// ��������, "onAttack"

/// ������ � ���������. ������������� �� ������� ����!
        procedure AddEffect(name, value: variant); /// ������ �� ���� ��������� ������
        function GetEffect(name: string): string;
        procedure ChangeEffect(name, value: variant);
        procedure RemoveEffect(name: string);

/// ������ � ������
        function GetLang: string;          // ������� ����� � ������ �������� ����� ENG|RU
        procedure SetLang(lang: string);   // ������� ����� � ������ �������� ����� ENG|RU

/// ������ � �������������
        procedure AllowThink(name: string); // �������� ������ � ������ ��������
        procedure PlayerThink(name: string); /// ���������� ��� ��������� ������� �������� ����� � ���������� ���� ������
        procedure OpenThink(name: string); /// ���������� ��� ��������� ������� �������� ����� ��� ����������� � ��������
        procedure SelectKind(name: string); /// ����� ������������� ���� ����, ��� ����� ������� ������ "�������������" ��� ���������� ����, ������ �������� ������� "�����"

/// ������ � �������
        procedure SetCurrFloor(val: variant); // ���������� ������� ����
        function CurrFloor: variant;       // ������� ����

        procedure SetCurrStep(val: variant);  // ��������� ������� ���
        function CurrStep: string;        // ������� ���
        function MaxStep: string;         // ������������ ��� ��� �������� �����

        procedure PlayerFloor( id: string );

/// ������ � ������ �� ������.
        function GetCurrTarget: string;
        procedure SetCurrTarget(val: string);

/// ������ � ����������
        function GetRandItemName: string;          // ���������� ��� ���������� ��������
        procedure SetCurrItem(name: string);   // ������������� ������� ��������� ������� �� ��� �����

/// ������ � ���������
        function GetRandResName: string;   // ��������� ����������� ����� ���������� ������� � ������ ��������


/// ������ � �����
        procedure Log(kind, text: string);   // ��������� ������ ���������� ���� � ��� ����. ���� - ����� css ������ �� EMPTY_HTML �� ������ uLog
        procedure LogAdd(text: string);      // ����������� ����� � ����� ������� ������ ����

/// ������ � �����������
        procedure SetVar(name, value: variant);
        procedure ChangeVar(name, value: variant);
        function GetVar(name: string): string;

/// ������ � ���������
        procedure CreateRegularMonster;  // �������� �������� ���������� ������� �� ������ �������� �����

/// ������ ������ � ������ �������� (����������� ������� ��������� �������������� ��������)
        procedure ChangePool(name, val: variant);             // ��������� ����� � ���
        function GetPool(name: string): integer;     // ������� ���������� ���� � ����

/// ������������ ��������� �������
        procedure BreakAuto(name: string);  /// ��������� ������������ ���������� ������
        procedure RunAuto(name: string);    /// ��������� ������������ ���������� ������
        function  GetAuto(name: string): boolean;    /// ���������� ��������� ���������� ������

/// ������������� ��������� ����� ��������
        procedure AllowMode(name: string);

/// ������ � �������������
        procedure AllowTool(name: string);
        function GetToolLvl(name: string): string;  // ���������� ������� ����������� �� ��� ����������� �����

/// �������� ������� ������
        procedure PlayerAttack;  /// ���������� �������� ����� ������ � ������� � �����
        procedure UseCurrItem;   /// ������������� �������� ���������� ��������

///
        function Phrase(name: string): string;

/// ������ � ��������������
        procedure CheckMemory;  /// ��������� �������� � ����������� �� �������� ��������

    private
        Script : TScriptDrive;

        function GetLoot: ISuperObject;
        function GetItems: ISuperObject;

        procedure InitItemsCraftCost; /// ��������� ��������� ��������� � ��������. ��������� ����� ��������� � ������ ����, �������� �������
        procedure InitFloorObjects;   /// ��������� ��������� �� ������

/// ������ � ��������� ������
        function GetRandFloorObjectName: string; // ��� ��������� �������
        function InitFloorObject( name: string ):IsuperObject;

        function NeedExp(lvl: variant): string;

        procedure ProcessAttack;     /// �������� ��� PlayerMakeAttack, ����������� ������ ������������ ��� ���������� ����
        procedure PlayerMakeAttack;  /// ���������������� ���������� ����� �� ����� ���������

        procedure ProcessThink;      /// ��������� �������� ������ ��� ������ � CheckStatus, ��������� ������������ ��� ���
        function PlayerMakeThink: boolean;   /// ���������������� ���������� ����� �� ����� ���������

        procedure ProcessFloor;      /// ��������� �������� ������ ��� ������ � CheckStatus, ��������� ������������ ��� ���
        function PlayerMakeFloor: boolean;   /// ���������������� ���������� ����� �� ����� ���������

        function CompactDigit(val: variant): string;
            /// ����������� ����� � ������ ������������ ���� � ���������� "�"(������) ��� "m"(��������)

        //// ������ ��������� � ���������, �������������� ���������� ������� ���� ���� ��� ��� ����� �� ����,
        ///  � �� ��� ������ ����. ��������� ������� ����� ���� ������������ � �� ������ ������� ���� �����
        procedure SetFloorScriptExecuted(val: boolean);
        function GetFloorScriptExecuted: boolean;
    end;

Var
    GameDrive : TGameDrive;

implementation

{ TData }


procedure TGameDrive.CheckMemory;
begin
    SetPlayerAsTarget;
    Script.Exec( GameData.S['memories.' + GetParam('MEMORY') ] );
end;

procedure TGameDrive.CheckStatus;
/// �������� �������� ������� ������ �� �������� ��������� �������� ��������
var
    HP, LVL : integer;
    loot, items: ISuperObject;
begin
    l('-> CheckStatus');

    ProcessThink;
    ProcessFloor;

    /// ���������� ������������� �������
    SetPlayerAsTarget;
    ProcessEffects;

    /// �������� ������������, ���� ��� ���� �� �������
    l('-> CheckStatus: �������� ������������, ���� ��� ���� �� �������');
    ProcessAttack;

    /// ��������� ��������� ������
    l('-> CheckStatus: ��������� ��������� ������');
    SetPlayerAsTarget;
    if StrToInt(GetParam('HP')) <= 0 then
    begin
        /// ������������ ������� �� ������ ������
        l('-> CheckStatus: ������������ ������� �� ������ ������');
        PlayEvent('OnDeath');

        /// ���� ����� ������� ����� ��� ��� ���� - ������������
        l('-> CheckStatus: ���� ����� ������� ����� ��� ��� ���� - ������������');
        if StrToInt(GetParam('HP')) <= 0 then
        begin
            uLog.Log.Phrase('killed_by', GetLang, []);

            // ������������ �� ������ �������
            l('-> CheckStatus: ������������ �� ������ �������');
            SetCurrFloor(1);
            SetCurrStep(1);

            // ������� �������
            l('-> CheckStatus: ������� �������');
            CreateRegularMonster;

            // ����� ������
            l('-> CheckStatus: ����� ������');
            SetPlayerAsTarget;
            HP := StrToInt(GetParam('LVL')) * 100;
            SetParam('HP', HP);

            /// ���������� ������� �����������
            l('-> CheckStatus: ���������� ������� �����������');
            PlayEvent('onRestore');
        end;
    end;


    /// ��������� �������
    l('-> CheckStatus: ��������� �������');
    SetCreatureAsTarget;
    if StrToInt(GetParam('HP')) <= 0 then
    begin
        /// ������������ ������� �� ������ �������
        l('-> CheckStatus: ������������ ������� �� ������ �������');
        PlayEvent('OnDeath');

        /// ���� ����� ������� ����� ��� ��� ���� - ������������ ������ �������
        l('-> CheckStatus: ���� ����� ������� ����� ��� ��� ���� - ������������ ������ �������');
        if StrToInt(GetParam('HP')) <= 0 then
        begin

            loot := GetLoot;
            items := GetItems;

            l('-> CheckStatus: ����� � ���, ��� ������ ����');
            uLog.Log.Phrase('monster_killed', GetLang, []);

            l('-> CheckStatus: ��������� ������ ����');
            SetPlayerAsTarget;
            ChangeParam('EXP', CurrFloor);

            // ����� �������� �������� � ���
            l('-> CheckStatus: ����� �������� �������� � ���');
            Collect('loot', loot);
            Collect('items', items);

            // ��������� �� ����������� ��������
            l('-> CheckStatus: ��������� �� ����������� ��������');
            if AllowLevelUp then
            begin
                /// ����� ������
                l('-> CheckStatus: ����� ������');
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

                l('-> CheckStatus: ���������� ������� �� �������');
                PlayEvent('onLevelUp');

            end;

            // ��������� � ���������� �������
            l('-> CheckStatus: ��������� �� ��������� ���');
            SetCurrStep( StrToInt(CurrStep) + 1 );

            l('-> CheckStatus: ������� ������ �������');
            CreateRegularMonster;
        end;
    end;


    // �������� �� ��������� ������
    l('-> CheckStatus: �������� �� ��������� ������');
    if StrToInt(CurrStep) > StrToInt(MaxStep) then
    begin
        SetFloorScriptExecuted(false);

        // ��������� �� ����� ������� ����������
        l('-> CheckStatus: ��������� �� ����� ������� ����������');
        SetCurrFloor(CurrFloor + 1);
        SetCurrStep(1);

        // ������� ����� ����� ��������
        l('-> CheckStatus: ������� ������ �������');
        CreateRegularMonster;

        l('-> CheckStatus: ����� � ��� � �������� �� ��������� �������');
        uLog.Log.Phrase('next_floor', GetLang, [CurrFloor]);
    end;


    /// ��������� ���������� ���� (�������� �����). ���� ��� - ��������� ������
//    l('-> CheckStatus: ��������� ���������� ���� (�������� �����)');
//    if   GameData.S['state.CurrFloor'] = GameData.S['state.CurrTargetFloor'] then
    begin
        l('-> CheckStatus: ���� ����������, ��������� ������ ��� CurrTargetFloor: '+GameData.S['state.CurrTargetFloor']);
        if not GetFloorScriptExecuted then
        begin
            Script.Exec( FloorTargets.S[GameData.S['state.CurrFloor']] );
            SetFloorScriptExecuted(true);
        end;
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
/// �������� ������� ����� � ���������� ���������� ����. ����: 4300000 => 4,3��
begin
    result := val;

    /// ���������, �������� � ������ ��� �������
    try StrToInt(val);
    except exit;
    end;

    /// ���� ���� � ����� ������ 10 �����
    if val div 1000 > 9 then
    begin
        result := IntToStr(val div 1000);

        if val mod 1000 > 100 then result := result + ',' + IntToStr((val mod 1000) div 100);

        result := result + '�';
    end;

    /// ���� ���� � �������
    if val > 1000000 then
    begin
        result := IntToStr(val div 1000000);

        if val mod 1000000 >= 100000 then result := result + ',' + IntToStr((val mod 1000000) div 100000);

        result := result + 'm';
    end;

end;

function TGameDrive.NewGame(level: integer; lang: string): string;
var
    i : integer;
    name: string;
begin
    l('-> NewGame');

    level := min(level, 5);  /// �������� �������

    result := '';

    GameData := SO(GAME_DATA);  // �������� ��������� ������
    uLog.Log.Clear;

    SetLang(lang);

    GameData.I['state.player.params.'+PRM_NEEDEXP] := StrToInt(NeedExp(1));
                                // ������� ���� ����������� ��� ��������

    InitItemsCraftCost;         // ��������� �������� ���������
    InitFloorObjects;           // ��������� �������� �� ������

    /// ������� �������������� �������, ������ �� ������ ����
    SetPlayerAsTarget;

    /// ������������
    SetParam('AutoAction', 500 + 500 * level);

    /// ������� �������� � ���������
    for i := 1 to level do
    begin
        name := GetRandItemName;
        ChangeItemCount(name, level);
    end;

    /// ������
    ChangeItemCount(ITEM_GOLD, 100000 + 10000 * level);
    ChangeItemCount(ITEM_SPEED_BUFF, 10 * level);

    /// �������������� �������
    CreateRegularMonster;

    /// ��������� ��������� ������� ��������
    CheckStatus;

    /// ��������� ���������
    SetModeToUpdate(INT_ALL);
    UpdateInterface;
end;



procedure TGameDrive.OpenThink(name: string);
begin
    GameData.S['state.CurrBookThink'] := name;
    GameData.s['state.CurrThinkKind'] := ''; /// ���������� ���, ����� �� ���������� ������ ������
    SetModeToUpdate( INT_THINK );
end;

function TGameDrive.SaveGame: string;
begin
    l('-> SaveGame');

    if Assigned( GameData ) then
    GameData.O['state'].SaveTo(
        DIR_DATA + FILE_GAME_DATA
//       ,false // �� ������������ �������� ��������������
//       ,false  // �� ��������������� ������� ����� � ������ ������������������
    );
end;


procedure TGameDrive.SaveTestData;
begin
    l('-> SaveTestData');

    /// "��������" ������ ��� ��������� ��������
    GameData.O['state'].SaveTo(
        DIR_DATA + FILE_GAME_DATA_TEST
       ,true // �� ������������ �������� ��������������
       ,false  // �� ��������������� ������� ����� � ������ ������������������
    );

    ShellExecute(0,'open',PCHAR(DIR_DATA + FILE_GAME_DATA_TEST),nil,nil,5{SW_SHOW});
end;

function TGameDrive.LoadGame( lang: string ): string;
/// �������� ��������� ����
var
    state: ISuperObject;
begin
    l('-> LoadGame');

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
    /// ���� ��� ���������� �������� ������ �������� ������������
    ///  ����� �������� �������� ������������,
    ///  ����� - ��������� ���
    if GetAuto(name)
    then result := GameData.I['state.player.params.AutoAction'] // ������ ���������, ����� �� ����������� ����
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

procedure TGameDrive.SetParam(name, value: variant);
var
    old, change: integer;

begin
    l('-> SetParam('+name+','+String(value)+')');

    /// � ����������� �� ����, ����� ��������� ������ ����� ����������
    if pos('player', Target) > 0
    then InterfModes := InterfModes or INT_MAIN
    else InterfModes := InterfModes or INT_TOWER;

    old := GameData.I[Target + 'params.' + name];

    /// ������������ ������ ��������
    if name = 'EXP' then value := Integer(value) + StrToInt(GetEffect('PlayerEXPBuff'));

    GameData.I[Target + 'params.' + name] := value;

    /// ����� ��������� � ���, ���� �� "�����" �����
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


procedure TGameDrive.SetEvent(event, script: string);
begin
    GameData.S[Target+'events.'+event] := script;
end;

procedure TGameDrive.PlayEvent(event: string);
var
    tmp: string;
    /// ��� ���������� ������� ���� ����� ����������
begin
    tmp := Target;

    if event = 'OnDeath' then
        Script.Exec( GameData.S[Target+'events.'+event]);

    Target := tmp;
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
/// �������� ��������� ���� ��������� ������
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
        data.D['params.percent'] := GameData.I['state.player.params.EXP'] / GameData.I['state.player.params.needexp'];

        /// ������� ��������� ������� �� ������
        data.O['effects'] := GameData.O['state.player.effects'].Clone;
        for elem in data.O['effects'] do
        elem.S['value'] := CompactDigit(elem.S['value']); /// �������� ����� ���� �������������

        GetEffect('buffSPEED'); // ������ ������� ��������, ����� ��������� ������� �������� � ����������� ����������
        data.S['game_speed'] := GetVar('GAME_SPEED');

        data.O['modes'] := GameData.O['state.modes'];      /// ������ ������� � ������� �������
        data.S['CurrItem'] := GameData.S['state.CurrItem'];  /// ������� ��������� ��� �������� ������������� �������

        // �������� � ���������
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
        data.O['params']      := GameData.O['state.creature.params'].Clone;

        for item in data.O['params'].AsObject do
        data.S['params.'+item.Name] := CompactDigit( data.I['params.'+item.Name] );

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

    /// ���������� ������ ��������
    if InterfModes and INT_THINK <> 0 then
    begin
        data := SO();

        //  ������� �������� �����
        data.S['CurrThink'] := GameData.S['state.CurrThink'];
        data.I['pool'] := GetPool('Think');
        data.B['auto'] := GetAuto('Think');

        /// �������� ������� ��������� �����
        if GameData.S['state.CurrBookThink'] <> '' then
        begin
            data.S['body'] := '<h2>'+GameData.S['thinks.' + GameData.S['state.CurrBookThink'] + '.caption.'+GetLang]+'</h2>';
            data.S['body'] := data.S['body'] + GameData.S['thinks.' + GameData.S['state.CurrBookThink'] + '.body.'+GetLang];
        end
        else data.S['body'] := GameData.S['thinks.defaultbody.'+GetLang];


        /// ���� ����� ������� ������ ���
        if GameData.S['state.CurrThinkKind'] <> '' then
        begin
            data.S['body'] := '';
            for item in GameData.O['state.thinks'].AsObject do
            ///  ���� ����������� ����� ����������� ���������� ����
            if ( item.Value.AsInteger = 0 ) and
            /// ��������� ������ �� ��� � �����
               ( LowerCase(GameData.S['thinks.'+item.Name+'.kind']) = LowerCase(GameData.S['state.CurrThinkKind'])) then
               data.S['body'] := data.S['body'] + '<a href="script:OpenThink('+item.Name+');">'+ GameData.S['thinks.'+item.Name+'.caption.'+GetLang] +'</a></br>';
        end;


        /// ��������� ������ ����� ����������������� ��� ����������� ��������
        data.O['kinds'] := SO();
        for item in GameData.O['state.thinks'].AsObject do
        /// ���� ����������� ���������(������� =0)
        if item.Value.AsInteger=0 then
        /// ��������� �������� � �������������� � ������� ������ ����� ����
        data.I['kinds.'+ GameData.S['thinks.'+item.Name+'.kind']] := data.I['kinds.'+ GameData.S['thinks.'+item.Name+'.kind']] + 1;


        data.O['thinks'] := SO();

        /// ������ �� ���� �������� ������
        for item in GameData['state.thinks'].AsObject do
        /// ���� �� ����������� ��� �� ���������
        if item.Value.AsInteger > 0 then
        begin
            data.S['thinks.' + item.Name + '.name']    := item.Name;
            data.S['thinks.' + item.Name + '.compact_value']   := CompactDigit( item.Value.AsInteger );
            data.I['thinks.' + item.Name + '.value']   := item.Value.AsInteger;
            data.I['thinks.' + item.Name + '.max']     := GameData.I['thinks.'+item.Name+'.cost'];
            data.S['thinks.' + item.Name + '.kind']    := GameData.S['thinks.'+item.Name+'.kind'];
            data.S['thinks.' + item.Name + '.caption'] := GameData.S['thinks.'+item.Name+'.caption.'+GetLang];
        end;
        fThink.Update( data );
    end;

    /// ���������� ������ �����
    if InterfModes and INT_FLOOR <> 0 then
    begin
        data := SO();


        data := GameData.O['state.floors.' + CurrFloor].Clone;   /// �������� ������ �������� �����

        data.I['floor'] := CurrFloor;                        /// ���������� ����� �������� �����
        data.I['pool'] := GetPool('Floor');
        data.B['auto'] := GetAuto('Floor');

        fFloor.Update(data);
    end;

    if InterfModes and INT_LOG <> 0
    then uLog.Log.Update;

    InterfModes := 0;
end;


procedure TGameDrive.UseCurrItem;
/// ��������� ������� ��������� ������� � ���������� ������
var
    name: string;
begin
    if GameData.S['state.CurrItem'] = '' then exit;

    name := GameData.S['state.CurrItem'];

    /// ��������� ������ �������
    Script.Exec( GameData.S['items.'+name+'.script'] );

    /// ��������� ���������� � ������
    SilentChange;
    ChangePlayerItemCount(name, -1);

    /// ���� �������� ���������
    if GameData.I['state.player.items.'+name] <= 0
    then GameData.S['state.CurrItem'] := '';   // ���������� ������� ���������

    SetModeToUpdate(INT_MAIN);      // �������, ��� ����� �������� ��������� ������

//    CheckStatus;
    UpdateInterface;
end;

{ PRIVATE METHODS }

function TGameDrive.InitFloorObject( name: string ):IsuperObject;
begin
    result := SO();
    result.S['name'] := GameData.S['floorObjects.'+name+'.name'];
    result.O['params'] := GameData.O['floorObjects.'+name+'.params'].Clone;
    result.O['effects'] := GameData.O['floorObjects.'+name+'.effects'].Clone;
    result.S['params.HP'] := Script.Exec( GameData.S['floorObjects.'+name+'.hpCalc'] );
end;

procedure TGameDrive.InitFloorObjects;
/// ����� ������� ������ ����� �������� �� ��� �����.
/// ��� ����������, ����� ��������� ��������� ��� ��������� �������.
/// ������ ���������:
//          1:{                               // ����� �����
//            1:{                             // id ������� �� �����
//              'name: "",'+                  // ��� �������, ��� �� ������������ ����� ������� �� FloorAtlas
//              'params: {HP: 0, count:0 },'+ // ���������. ����� ���� ����� �� ����� ��� � ��������
//                                            // ��������� ����� ���� ����� ������������ � ��������
//              'effects: [],'+               // ����� ��������� �������� ��� �����������.
//              'id: 1,'+                     // ��������� ������ id �������
//            },
//          },
var
    floor, objCount, objCurr: integer;
    flr, objName: string;
    obj, tmpObj: ISuperObject;

    function CreateObj( index: integer ): ISuperObject;
    begin
        /// ��������������
        obj.O[flr+'.'+IntToStr(index)] := InitFloorObject( GetRandFloorObjectName );
        obj.I[flr+'.'+IntToStr(index)+'.id'] := index;

        result := obj.O[flr+'.'+IntToStr(index)];
    end;

begin
    l('-> InitFloorObjects');

    obj := SO();

    for floor := 1 to 10 do
    begin

        // ������� ������ �����
        flr := IntToStr(floor);
        obj.O[flr] := SO();

        objCount := Min(Random(floor*5)+10, 50);

        obj.I[flr+'.count'] := objCount;

        /// ���������� ����������� �������
        for objCurr := 1 to objCount do
            CreateObj( objCurr );

        /// ���������� ������ �������
        if floor = 1 then
        begin
            /// ������ � ��������
            tmpObj := CreateObj( objCount + 1 );
            tmpObj.I['params.count'] := 1;
            tmpObj.O['effects'] := SA(['Leggings']);
            obj.I[flr+'.count'] := objCount + 1;
        end;

    end;

    GameData.O['state.floors'] := obj.Clone;
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

function TGameDrive.GetToolLvl(name: string): string;
begin
    result := '0';

    if   GameData.B['state.tools.'+LowerCase(name)+'.isAllow']
    then result := GameData.S['state.tools.'+LowerCase(name)+'.lvl'];
end;

function TGameDrive.GetAuto(name: string): boolean;
begin
    name := LowerCase(name);
    result := GameData.B['state.modes.'+name+'.auto'];
end;

function TGameDrive.GetCurrTarget: string;
begin
    result := FloorTargets.S[GameData.S['state.CurrTargetFloor']+'.floor'];
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

procedure TGameDrive.SelectKind(name: string);
begin
    GameData.S['state.CurrThinkKind'] := name;
    SetModeToUpdate( INT_THINK );
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

    SetModeToUpdate(INT_TOWER + INT_FLOOR);
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



procedure TGameDrive.SetFloorScriptExecuted(val: boolean);
begin
    GameData.B['state.FloorScriptExecuted'] := val;
end;

procedure TGameDrive.AddEffect(name, value: variant);
begin
    name := LowerCase(name);
    /// ������� ��� ������������ ������� �������� ������� �� ����
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
     name := LowerCase(name);

     result := '0';

     if assigned( GameData.O[Target+'effects.'+name] ) then
     begin
         result := GameData.S[Target+'effects.'+name+'.value'];
         SetVar('LastValue', result);

         /// ����� ������� �������� ���������� ��������������� ������
         if Assigned( GameData.O['effects.'+name+'.script.use'] ) then
            Script.Exec( GameData.S['effects.'+name+'.script.use'] );
     end;

end;

function TGameDrive.GetFloorScriptExecuted: boolean;
begin
    result := GameData.B['state.FloorScriptExecuted']
end;

procedure TGameDrive.ChangeEffect(name, value: variant);
begin
     name := LowerCase(name);

     /// ������������ ������� �������� ������� �� ����
     if assigned( GameData.O[Target+'effects.'+name] ) then
     begin
         GameData.I[Target+'effects.'+name+'.value'] := GameData.I[Target+'effects.'+name+'.value'] + Integer(value);
         SetModeToUpdate( INT_MAIN + INT_TOWER );
     end;
end;

procedure TGameDrive.RemoveEffect(name: string);
begin
     name := LowerCase(name);

     if assigned( GameData.O[Target+'effects.'+name] ) then
     begin
         GameData.Delete(Target+'effects.'+name);
         SetModeToUpdate( INT_MAIN + INT_TOWER );
     end;
end;








function TGameDrive.GetRandItemName: string;
var
    count: integer;
    item: ISuperObject;
begin
    l('-> GetRandItemName');
    result := '';

    repeat

      count := Random( GameData.I['itemsCount'] );

      /// ���������� ������� � �������� ���� �� ���. � ������ ��������!
      for item in GameData.O['items'] do
      begin
          /// ���� ����� ���� ������ - ��������
          if (count = 0) and item.B['drop'] then result := item.S['name'];

          Dec(count);
      end;

    until result <> '';
end;

function TGameDrive.GetRandResName: string;
var
    val: integer;
    item: ISuperObject;
begin
    l('-> GetRandResName');

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

function TGameDrive.GetRandFloorObjectName: string;
var
    count: integer;
    item: ISuperObject;
begin

    count := Random( GameData.I['floorObjectCount'] );

    /// ���������� ������� � �������� ���� �� ���. � ������ ��������!
    for item in GameData.O['floorObjects'] do
    begin
        if count = 0 then
        begin
            result := item.S['name'];
            exit;
        end;
        Dec(count);
    end;
end;

function TGameDrive.GetVar(name: string): string;
begin
    l('-> GetVar('+name+')');
    result := GameData.S['state.vars.'+name];
end;

procedure TGameDrive.InitItemsCraftCost;
/// ������� ������� ���������. � ������ ���� - ������
/// ������������� �� �������� ��������� � ��������
var
    cost     // �������� ���������� ��������� �������� � ��������
   ,part     // �������� ��������� ��������� �������� ������������� ����������
   ,resCount // ���������� ���������� �������
            : integer;
    resName
            : string;
    item,   /// ������� ��������������� �������
    craft   /// �������������� ���������
            : ISuperObject;
begin
    l('-> InitItemsCraftCost');

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


procedure TGameDrive.ChangeParam(name, delta: variant);
begin
    l('-> ChangeParam('+name+','+String(delta)+')');

    if pos('player', Target) > 0
    then InterfModes := InterfModes or INT_MAIN
    else InterfModes := InterfModes or INT_TOWER;

    /// ������������ ������ ��������
    if name = 'EXP' then delta := Integer(delta) + StrToInt(GetEffect('PlayerEXPBuff'));

    /// ������ �������� ���������������� �������
    GameData.I[Target + 'params.' + name] :=
        GameData.I[Target + 'params.' + name] + StrToIntDef(delta, 0);

    /// ����� ��������� � ���, ���� �� "�����" �����
    if (pos('player', Target) > 0) and not fSilentChange
    then uLog.Log.Phrase('change_param', GetLang, [name, ifthen(delta >= 0, '+','') + String(delta), GameData.I[Target + 'params.' + name]]);

    // ���������� ���� ������ ���������
    fSilentChange := false;
end;

procedure TGameDrive.ChangePlayerItemCount(name, value: variant);
/// ��������� ���������� ���������
var
    trg: String;
begin
    trg := Target;

    SetPlayerAsTarget;
    ChangeItemCount(name, value);

    Target := trg;
end;

procedure TGameDrive.ChangePlayerLootCount(name, delta: variant);
var
    trg: String;
begin
    trg := Target;

    SetPlayerAsTarget;
    ChangeLootCount(name, delta);

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
    if name = 'think' then SetModeToUpdate(INT_THINK);
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

     // �������, ���� ����� ��� ��������
     if GameData.B['state.modes.'+name+'.allow'] then exit;

     GameData.B['state.modes.'+name+'.allow'] := true;

     if name = 'think' then
     begin
         uLog.Log.Phrase('allow_think', GetLang, []);
         SetModeToUpdate(INT_THINK);
     end;

     if name = 'floor' then
     begin
         uLog.Log.Phrase('allow_floor', GetLang, []);
         SetModeToUpdate(INT_FLOOR);
     end;

     if name = 'tools' then
     begin
         uLog.Log.Phrase('allow_tools', GetLang, []);
         SetModeToUpdate(INT_TOOLS);
     end;

     /// ���������� ����, ��� ����� �������� �������� ����� ����������
     SetModeToUpdate(INT_MAIN);
end;

procedure TGameDrive.AllowThink(name: string);
begin

    if assigned( GameData.O['state.thinks.'+name] ) then exit;

    /// ��������� ������ �  ��������.
    GameData.I['state.thinks.'+name] := GameData.I['thinks.'+name+'.cost'];

    /// ��������� �� �������� ��������
    uLog.Log.Phrase('open_think', GetLang, [ GameData.S['thinks.' + name + '.caption.' + GetLang ]]);

    SetModeToUpdate( INT_THINK );
end;

procedure TGameDrive.AllowTool(name: string);
begin
    name := LowerCase(name);

    /// ���������� �����������
    if not Assigned( GameData.O['state.tools.'+name]) then exit;
    /// ���������� ��� ��������
    if GameData.B['state.tools.'+name+'.isAllow'] then exit;

    AllowMode('Tools');

    GameData.B['state.tools.'+name+'.isAllow'] := true;
    uLog.Log.Phrase('tool_allowed', GetLang, [ GameData.S['tools.'+name+'.caption.'+GetLang] ]);
end;

procedure TGameDrive.BreakAuto(name: string);
begin
     name := LowerCase(name);

     GameData.B['state.modes.'+name+'.auto'] := false;  // ������������� ������������
     GameData.I['state.modes.'+name+'.pool'] := 0;      // ���������� ����������� ������� ������

     if name = 'tower' then SetModeToUpdate(INT_TOWER);
     if name = 'think' then SetModeToUpdate(INT_THINK);
     if name = 'floor' then SetModeToUpdate(INT_FLOOR);
end;

procedure TGameDrive.ChangeItemCount(name, delta: variant);
/// �������� ���������� ���������� �������� �� ��������� ������ (� + ��� - ),
var
    old : integer;
begin
    l('-> ChangeItemCount('+name+','+String(delta)+')');

    old := GameData.I[Target + 'items.' + name];
    GameData.I[Target + 'items.'+name] := GameData.I[Target + 'items.'+name] + delta;

    /// �������� � ������� ����������� - �������, ����� �� �������� ��������� ���������
    if GameData.I[Target + 'items.'+name] = 0
    then GameData.Delete(Target + 'items.'+name);

    /// ����� ��������� � ���, ���� �� "�����" �����
    if (pos('player', Target) > 0) and not fSilentChange
    then uLog.Log.Phrase( 'change_item',  GetLang, [
            name,                                             /// ���������� ��� ��� ���������� ������
            GameData.S['items.'+name+'.caption.'+GetLang],    /// ������� ��� � ������� �����
            ifthen(delta >= 0, '+','') + String(delta),       /// ������ � ��������� ���������
            GameData.I[Target + 'items.' + name]              /// ������� ����������
        ]);

    fSilentChange := false;
end;
procedure TGameDrive.SetImage(index: variant);
begin
    l('-> SetImage('+String(index)+')');

    if String(index) = '' then index := Random(MONSTER_IMAGE_COUNT) + 1;
    GameData.I[Target + 'image'] := index;
end;

procedure TGameDrive.SetItemCount(name, value: variant);
var
    change, old : integer;
begin
    l('-> SetItemCount('+name+','+String(value)+')');

    GameData.I[Target + 'items.'+name] := value;

    /// ����� ��������� � ���, ���� �� "�����" �����
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

    /// ����� ��������� � ���, ���� �� "�����" �����
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

    /// ����� ��������� � ���, ���� �� "�����" �����
    if (pos('player', Target) > 0) and not fSilentChange
    then uLog.Log.Phrase( 'change_loot',  GetLang, [
            name,                                             /// ���������� ��� ��� ���������� ������
            GameData.S['resources.'+name+'.caption.'+GetLang],    /// ������� ��� � ������� �����
            ifthen(delta >= 0, '+','') + String(delta),       /// ������ � ��������� ���������
            GameData.I[Target + 'loot.' + name]              /// ������� ����������
        ]);

    fSilentChange := false;
end;



function TGameDrive.NeedExp(lvl: variant): string;
var
    prev, cost, buff, // ���������� ��� ���������� ���������
    i: integer;
begin
    l('-> NeedExp('+String(lvl)+')');

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

procedure TGameDrive.CreateRegularMonster;
// ������������ ����
var
    i, count, lootCount: integer;
    _items, _loot: string;
    tmp: ISuperObject;
begin
    l('-> CreateRegularMonster');

    SetCreatureAsTarget;
    ResetTargetState;
    SetImage('');

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

        /// ������
        ChangeItemCount(ITEM_GOLD, Random( CurrFloor*2 ) + CurrFloor);

        /// ������� (���� �� ���� ���)
        lootCount := Random(CurrFloor div 2);
        for I := 1 to lootCount do
            ChangeLootCount( GetRandResName, Random( CurrFloor div 2 ) +1 );

        // ���������
        count := Random( CurrFloor*10 ) + CurrFloor*5;
        SetParam('HP',    count);
        SetParam('MAXHP', count);
        SetParam('ATK',   Random( CurrFloor*5 )  + CurrFloor*2);
        SetParam('DEF',   CurrFloor*2);
    end;

    if CurrStep = MaxStep then
    begin

        SetName('RU',
            '���� '+
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

        /// ������
        ChangeItemCount(ITEM_GOLD, Random( CurrFloor*5 ) + CurrFloor*2);

        // ���� �� ��������� ��������������� ��������
        if Random(2) > 0 then
        begin
//            Log('normal', 'Monster has an item!');
            ChangeItemCount(GetRandItemName, 1);
//            BreakAuto('Tower');
        end;

        /// ������� (���� �� ��� ����, �� ����� ����������� � ����� ������������)
        lootCount := Random( CurrFloor );
        for I := 0 to lootCount do
            ChangeLootCount(GetRandResName, Random( CurrFloor ) + 1);

        // ���������
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

/// ���������� �������

function TGameDrive.Phrase(name: string): string;
begin
    result := GetPhrase(name,GetLang);
end;

procedure TGameDrive.PlayerAttack;
begin
    l('-> PlayerAttack');

    ChangePool('Tower', 1);

    UpdateInterface;
end;

procedure TGameDrive.PlayerFloor(id: string);
begin
    ChangePool('floor', 1);                // ��������� ������� � ���
    GameData.S['state.CurrFloorObject'] := id;
                                           // ���������� ���� � id ����������� �������
    SetModeToUpdate( INT_FLOOR );
end;

function TGameDrive.PlayerMakeFloor: boolean;   /// ���������������� ���������� ����� �� ����� ���������
var
    delta, i, index: integer;
    obj: ISuperObject;
    scriptName: string;
begin
    result := false;

    /// ���� ��� �������� ���������� �� ����� ������� - �������
    if GameData.S['state.CurrFloorObject'] = '' then exit;

    delta := -1;
    obj := GameData.O['state.floors.' + CurrFloor + '.' + GameData.S['state.CurrFloorObject']];

    /// ������ �� ������
    if not Assigned(obj) then exit;

    ///����� ������������ ������ ������ �� ���� �������, ������� � ������ ����������

    /// ��������� ����
    obj.I['params.HP'] := obj.I['params.HP'] + delta;

    /// ���� ��� ���� �����
    if obj.I['params.HP'] <= 0 then
    begin
        /// ���������� �������
        for i := 1 to obj.I['params.count'] do
        begin
            index := Random(obj.A['effects'].Length);               // ������ ���������� �������
            scriptName := obj.S['effects['+IntToStr(index)+']'];    // ��� ���������� �������
            Script.Exec( GameData.S['floorScripts.'+scriptName] );  // ���������� ������� �������
        end;

        /// ������� ������ � �����
        GameData.Delete('state.floors.' + CurrFloor + '.' + GameData.S['state.CurrFloorObject']);

        GameData.S['state.CurrFloorObject'] := '';

        /// ��������� ����� ���������� �������� �����
        GameData.I['state.floors.' + CurrFloor + '.count'] :=
            GameData.I['state.floors.' + CurrFloor + '.count'] - 1;
    end;

    SetModeToUpdate( INT_FLOOR );

    result := true;
end;

procedure TGameDrive.PlayerMakeAttack;
/// ��������� �������� ����� ������ � ������� � �����
/// ��������:
///     1. �� ������� ������������� ������� � ������ ���������������� ���������� ���:
///         mc_DMG - ��������� �������� ����
///         mc_DEF - �������� ����� ����� �� ������
///         mc_GEM - ���������� ���������� �������� ����������

///         pl_DMG - ����������� ���� ������ �� �������
///         pl_DEF - �������� ����� ����� �� �������
///         gm_RED - ���������� �������� �� ������� ������� ����������
///         gm_WHT - ���������� �������� �� ������� ����� ����������
///         gm_BLU - ���������� �������� �� ������� ����� ����������
///         gm_GRN - ���������� �������� �� ������� ������� ����������
///         gm_PRP - ���������� �������� �� ������� ���������� ����������
///         gm_YLW - ���������� �������� �� ������� ������ ����������
///     2. ������������ ������� �� ������� onAttack � ������� � ������, ������ ����� �������������� ��������
///     3. ��������� ����� �� ������ � �������
var
    PlayerATK: integer;
    PlayerDEF: integer;

    CreatureATK: integer;
    CreatureDEF: integer;

    BLOCK, DMG : integer;
begin
    l('-> PlayerMakeAttack');

    /// ��������� ���������� � ����������� ���
    SetPlayerAsTarget;
    PlayerATK := StrToInt(GetParam('ATK')) + StrToInt(GetEffect('PlayerATKBuff'));
    PlayerDEF := StrToInt(GetParam('DEF')) + StrToInt(GetEffect('PlayerDEFBuff'));;
    SetVar('pl_DMG', Random(PlayerATK));
    SetVar('pl_DEF', PlayerDEF);

    SetCreatureAsTarget;
    CreatureATK := StrToInt(GetParam('ATK'));
    CreatureDEF := StrToInt(GetParam('DEF'));;
    SetVar('mc_DMG', Random(CreatureATK));
    SetVar('mc_DEF', CreatureDEF);



    /// ��������� ��� ������� �� ����� ������
    SetPlayerAsTarget;
    PlayEvent('onAttack');

    /// ��������� ��� ������� �� ����� �������
    SetCreatureAsTarget;
    PlayEvent('onAttack');



    /// ��������� ����� �������� ���������� ����������

    /// ������� �������
    SetCreatureAsTarget;

    /// ������� ���� �� ������ ������
    // 1 DEF = -0.1% dmg
    BLOCK := Round(StrToInt(GetVar('pl_DMG')) * ((StrToInt(GetVar('mc_DEF')) / 10) / 100));
    DMG := StrToInt(GetVar('pl_DMG'))- BLOCK;
    ChangeParam('HP', -DMG); /// ��������� ����

    /// ����� ������� � ���
    if BLOCK > 0
    then uLog.Log.Phrase('player_strike_block', GetLang, [DMG, BLOCK])
    else uLog.Log.Phrase('player_strike', GetLang, [DMG]);


    /// ������� ������
    SetPlayerAsTarget;

    /// ������� ���� �� ������ ������
    // 1 DEF = -0.1% dmg
    BLOCK := Round(StrToInt(GetVar('mc_DMG')) * ((StrToInt(GetVar('pl_DEF')) / 10) / 100));
    DMG := StrToInt(GetVar('mc_DMG'))- BLOCK;
    SilentChange;
    ChangeParam('HP', -DMG); /// ��������� ����

    uLog.Log.PhraseAppend('fight_swords', GetLang, []);

    /// ����� ������� � ���
    if BLOCK > 0
    then uLog.Log.PhraseAppend('monster_strike_block', GetLang, [DMG, BLOCK])
    else uLog.Log.PhraseAppend('monster_strike', GetLang, [DMG]);

end;



function TGameDrive.PlayerMakeThink: boolean;
var
    change : integer;
begin
    result := false;

    if GameData.S['state.CurrThink'] <> '' then
    begin
        result := true;

        /// ��������� ��������, �������� ���� ������� ������� � ���������, �� �� ����� ����
        SetPlayerAsTarget;
        change := StrToInt(GetParam('MIND'));// + GetEffect('');

        GameData.I['state.thinks.' + GameData.S['state.CurrThink'] ] :=
            Max( GameData.I['state.thinks.' + GameData.S['state.CurrThink'] ] - change, 0);

        /// ���� ����������� ���������
        if GameData.I['state.thinks.' + GameData.S['state.CurrThink'] ] = 0 then
        begin
            /// ����� � ���������� ������ ���������� ��������� ��� ���������� �����������
            uLog.Log.Phrase('ready_think', GetLang, [ GameData.S['thinks.' + GameData.S['state.CurrThink'] + '.caption.' + GetLang ]]);

            /// ������� ��������� � �����
            OpenThink( GameData.S['state.CurrThink'] );

            /// ��������� ����������� ������
            Script.Exec( GameData.S['thinks.' + GameData.S['state.CurrThink'] + '.script'] );

            /// �������� ������� �����
            GameData.S['state.CurrThink'] := '';
        end;
    end;
end;


procedure TGameDrive.ProcessAttack;
begin
    l('-> ProcessAttack');

    if GetPool('Tower') > 0 then  // ���� ���� �������� ���� �� ���� �����
    begin
        PlayerMakeAttack;  // �������� �������� ����� ������ � ������

        // ���� �� ���������� ����� ����, ����� ������� � ���������� ����
        if not GetAuto('Tower')
        then ChangePool('Tower', -1);

        // ���� ���������� ����� ����, ����� ������� � ������������
        if GetAuto('Tower') then
        begin
            SilentChange;
            ChangePlayerParam('AutoAction', -1);
        end;

    end;

end;

procedure TGameDrive.ProcessEffects;
var
    item, tmp: isuperobject;

begin
    if not assigned(GameData.O[Target+'effects']) then exit;

    /// ��� ������� �������� �� ������ ������� ���������� ��� auto ������, ���� ��������
    /// �������� � ���, ��� ��� ���������� ������������ ��������� ������� ����� ������������� ���
    /// ������������ � ��� ������� ����������� �������� GameData.O[Target+'effects'] �������
    /// �����. ������ �� ������ ������ ����� ��������� � �������� ��� ������������
    tmp := GameData.O[Target+'effects'].Clone;
    for item in tmp do
    begin
        if Assigned(item) then
            Script.Exec( GameData.S['effects.'+LowerCase(item.S['name'])+'.script.auto'] );
    end;
end;

procedure TGameDrive.ProcessFloor;
begin
    if GetPool('Floor') > 0 then  // ���� ���� �������� ���� �� ���� ��������
    if PlayerMakeFloor then       // ���� ���� � ��� �������� � ��� ���������� (�������� ���������)
    begin
        SetModeToUpdate( INT_FLOOR );

        if not GetAuto('Floor')
        then
            ChangePool('Floor', -1)   // ���� �� ���������� ����� ����, ����� ������� � ���������� ����
        else                          // ���� ���������� ����� ����, ����� ������� � ������������
        begin
            SilentChange;
            ChangePlayerParam('AutoAction', -1);
        end;
    end;
end;

procedure TGameDrive.ProcessThink;
begin
    if GetPool('Think') > 0 then  // ���� ���� �������� ���� �� ���� ��������
    if PlayerMakeThink then       // ���� ���� � ��� �������� � ��� ���������� (�������� ���������)
    begin
        SetModeToUpdate( INT_THINK );

        if not GetAuto('Think')
        then
            ChangePool('Think', -1)   // ���� �� ���������� ����� ����, ����� ������� � ���������� ����
        else                          // ���� ���������� ����� ����, ����� ������� � ������������
        begin
            SilentChange;
            ChangePlayerParam('AutoAction', -1);
        end;
    end;
end;

procedure TGameDrive.PlayerThink(name: string);
begin
    ChangePool('think', 1);                // �������� ����� � ���
    GameData.S['state.CurrThink'] := name; // ���������� � ��� ������ � ������ ������
//    UpdateInterface;
    SetModeToUpdate( INT_THINK );
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
     if name = 'think' then SetModeToUpdate(INT_THINK);
     if name = 'floor' then SetModeToUpdate(INT_FLOOR);
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
