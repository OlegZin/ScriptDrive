unit uGameDrive;

interface

uses
    uScriptDrive, superobject, uConst,
    System.SysUtils, Generics.Collections, Classes, Math, StrUtils, ShellAPI,
    uThinkMode, uGameInterface, uLog, uTower;

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
        procedure SetImage(index: integer = -1);

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

        procedure Collect(name: string; objects: ISuperObject);
           // ���������� � ��������� ������ ������� ���� ���� ���������
           // ������ objects

        procedure PlayEvent(name: string); /// ���������� �������� ����, ����������� � ���������� �������.
                                           /// ��������, "onAttack"

/// ������ � ���������. ������������� �� ������� ����!
        procedure AddEffect(name, value: variant); /// ������ �� ���� ��������� ������
        function GetEffect(name: string): string;
        procedure ChangeEffect(name, value: variant);
        procedure RemoveEffect(name: string);

/// ������ � ������
        function GetLang: string;          // ������� ����� � ������ �������� ����� ENG|RU
        procedure SetLang(lang: string);   // ������� ����� � ������ �������� ����� ENG|RU

/// ������ � �������
        procedure SetCurrFloor(val: variant); // ���������� ������� ����
        function CurrFloor: variant;       // ������� ����

        procedure SetCurrStep(val: variant);  // ��������� ������� ���
        function CurrStep: string;        // ������� ���
        function MaxStep: string;         // ������������ ��� ��� �������� �����

/// ������ � ����������
        function GetRandItemName: string;          // ���������� ��� ���������� ��������
        procedure SetCurrItem(name: string);   // ������������� ������� ��������� ������� �� ��� �����

/// ������ � ���������
        function GetRandResName: string;   // ��������� ����������� ����� ���������� ������� � ������ ��������

/// ������ � ������ �� ������.
        function GetCurrTarget: string;
        procedure SetCurrTarget(val: string);
        procedure SetNextTarget;

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

/// ������������ ��������� ����� ��������
        procedure AllowMode(name: string);

{
        function GetArtLvl(name: string): string;  // ���������� ������� ��������� �� ��� ����������� �����
        procedure AllowTool(name: string);
        procedure OpenThink(name: string);
}

/// �������� ������� ������
        procedure PlayerAttack;  /// ���������� �������� ����� ������ � ������� � �����
        procedure UseCurrItem;   /// ������������� �������� ���������� ��������

    private
        Script : TScriptDrive;

        function GetLoot: ISuperObject;
        function GetItems: ISuperObject;

        procedure InitItemsCraftCost; /// ��������� ��������� ��������� � ��������. ��������� ����� ��������� � ������ ����, �������� �������
        procedure InitFloorObjects;   /// ��������� ��������� �� ������
        function GetRandObjName: string; /// ��������� ������, ������� ����� ���������� �� �����, � ������ �������� � ���������� ����������
        function NeedExp(lvl: variant): string;

        procedure ProcessAttack;     /// �������� ��� PlayerMakeAttack, ����������� ������ ������������ ��� ���������� ����
        procedure PlayerMakeAttack;  /// ���������������� ���������� ����� �� ����� ���������

        function CompactDigit(val: variant): string;
    end;

Var
    GameDrive : TGameDrive;

implementation

{ TData }


procedure TGameDrive.CheckStatus;
/// �������� �������� ������� ������ �� �������� ��������� �������� ��������
var
    HP, LVL : integer;
    loot, items: ISuperObject;
begin
    l('-> CheckStatus');

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
        PlayEvent('onDeath');

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
        PlayEvent('onDeath');

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

    /// ��������� ���������� ���� (�������� �����). ���� ��� - ��������� ������
    l('-> CheckStatus: ��������� ���������� ���� (�������� �����)');
    if   GameData.S['state.CurrFloor'] = GameData.S['state.CurrTargetFloor'] then
    begin
        l('-> CheckStatus: ���� ����������, ��������� ������ ��� CurrTargetFloor: '+GameData.S['state.CurrTargetFloor']);
        Script.Exec(GameData.S['targetFloor.'+GameData.S['state.CurrTargetFloor'] + '.script']);
    end;

    // �������� �� ��������� ������
    l('-> CheckStatus: �������� �� ��������� ������');
    if StrToInt(CurrStep) > StrToInt(MaxStep) then
    begin

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

    /// ���� ���� � �������
    if val div 1000 > 9 then
    begin
        result := IntToStr(val div 1000);

        if val mod 1000 > 100 then result := result + ',' + IntToStr((val mod 1000) div 100);

        result := result + '�';
    end;
end;

function TGameDrive.NewGame(level: integer; lang: string): string;
var
    i : integer;
    name: string;
begin
    l('-> NewGame');

    result := '';

    GameData := SO(GAME_DATA);  // �������� ��������� ������
    uLog.Log.Clear;

    SetLang(lang);

//    GameData.I['state.player.params.'+PRM_NEEDEXP] := 1;
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

    /// �������������� �������
    CreateRegularMonster;

    /// ��������� ��������� ������� ��������
    CheckStatus;

    /// ��������� ���������
    SetModeToUpdate(INT_ALL);
    UpdateInterface;
end;



function TGameDrive.SaveGame: string;
begin
    l('-> SaveGame');

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

procedure TGameDrive.SetNextTarget;
/// ����� ����������� ������� ���� �� ��������� ������� ������� targetFloor
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

    /// � ����������� �� ����, ����� ��������� ������ ����� ����������
    if pos('player', Target) > 0
    then InterfModes := InterfModes or INT_MAIN
    else InterfModes := InterfModes or INT_TOWER;

    old := GameData.I[Target + 'params.' + name];
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


        /// ������� ��������� ������� �� ������
        data.O['effects'] := GameData.O['state.player.effects'].Clone;
        for elem in data.O['effects'] do
        elem.S['value'] := CompactDigit(elem.S['value']); /// �������� ����� ���� �������������


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
            objName := GetRandObjName;  /// �������� ���������� ������

            index := floor * 1000 + objCurr; /// ��������� ���������� ������

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
     result := '0';

     if assigned( GameData.O[Target+'effects.'+name] ) then
     begin
         result := GameData.S[Target+'effects.'+name+'.value'];
         SetVar('LastVlue', result);
     end;
end;

procedure TGameDrive.ChangeEffect(name, value: variant);
begin
     /// ������������ ������� �������� ������� �� ����
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
    l('-> GetRandItemName');

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

    GameData.I[Target + 'params.' + name] :=
        GameData.I[Target + 'params.' + name] + StrToIntDef(delta, 0);

    /// ����� ��������� � ���, ���� �� "�����" �����
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

     /// ���������� ����, ��� ����� �������� �������� ����� ����������
     SetModeToUpdate(INT_MAIN);
end;

procedure TGameDrive.BreakAuto(name: string);
begin
     name := LowerCase(name);

     GameData.B['state.modes.'+name+'.auto'] := false;  // ������������� ������������
     GameData.I['state.modes.'+name+'.pool'] := 0;      // ���������� ����������� ������� ������

     if name = 'tower' then SetModeToUpdate(INT_TOWER);
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

procedure TGameDrive.PlayerAttack;
begin
    l('-> PlayerAttack');

    ChangePool('Tower', 1);

    UpdateInterface;
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
    PlayerATK := StrToInt(GetParam('ATK'));
    PlayerDEF := StrToInt(GetParam('DEF'));;
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



procedure TGameDrive.PlayEvent(name: string);
begin
///
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

//        if GetPool('Tower') = 0 then uLog.Log.Phrase('attack_pool_empty', GetLang, []);
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
