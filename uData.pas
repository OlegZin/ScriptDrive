unit uData;

interface

uses
    uTypes, uScriptDrive,
    System.SysUtils, Generics.Collections, Vcl.Dialogs, Classes, Math, StrUtils;

type

    TData = class
    public
        Player : TCreature;
        Creatures: TList<TCreature>;
        Variables: TDictionary<String,String>;

        CurrCreature: integer;
        CurrLevel: integer;
        EventText: string;

        constructor Create;
        destructor Destroy;

        procedure PlayerAttack;   // ������� ������ ��������� ������� ����
        procedure CreatureAttack; // ������� ������� ���������

        procedure DoDamageToCreature(input: string); // ��������� ����� �������� ��������
        procedure DoDamageToPlayer(input: string); // ��������� ����� ������

        function GetCurrCreatureInfo: string;
        function GetPlayerInfo: string;
        function GetPlayerItems: string;
        function GetPlayerAttr(name: string): string;

        procedure InitPlayer;
        procedure InitCreatures;

        function CurrentCreature: string;
        function CreaturesCount: string;

        procedure CheckStatus;  // �������� �������� ������� � ������� ������� ������
        procedure CurrentLevel(input: string);
        function GetCurrentLevel: string;

        function GetEvents: string;

        procedure LevelUpPlayer;
        function AllowLevelUp: string;
        // �������� �� ������������� �������� ����� ��� �������� ������

        function NeedExp: string;
        // ���������� ���������� ����� ��� �������� ������

        procedure ChangePlayerParam(name, delta: string);
        // ����� ��������� ��������� ������

        procedure AddEvent(text: string);
        procedure UseItem(name: string);

        procedure SetVar(name, value: string);
        function GetVar(name: string): string;

        function Rand(max: string): string;
    private
        parser: TStringList;
        Script : TScriptDrive;

        function FillVars(creature: TCreature; scr: string): string;

        function GetParamValue(creature: TCreature; param: string): string;
        procedure SetParamValue(creature: TCreature; param, value: string);
        procedure ChangeParamValue(creature: TCreature; param: string; delta: integer);

        procedure SetCreature(name, params: string; items: string = '');
        procedure SetPlayer(name, params: string; items: string = '');  // ����������� � ����� ������� �������� ��������� ��������/������
    end;

    /// �����-�������� ��� ����������� � ���������� ���������
    TInventory = class
    private
        items: TStringList;   // ������ � ����������
    public
        constructor Create;
        destructor Destroy;

        procedure Fill(inv: string);
        procedure Clear;
        function Get: string;

        procedure SetItemCount(name: string; count: integer);
        // ������ ��������� ���������� ��������� � ���������
        // ��������� �������, ���� ����������� ��� �������� > 0
        // ������� �������, ��� �������� <= 0

        procedure ChangeItemCount(name: string; count: integer);
        // �������� ���������� �� ��������� ������ (+/-)
        // ��������� �������, ���� ����������� ��� ���������� ���������� > 0
        // ������� �������, ��� ���������� �������� <= 0

        procedure RemoveItem(name: string);
        // ������� ��� ������� � ��������� ������

        function GetItemCount(name: string): integer;
        // ���������� ���������� ��������� ���������, 0 = �����������

        procedure Loot(lootInv: string);
        // �������� ������ ��������� � ��������� ��� ��������� �������� � "����"
    end;

Var
    Data : TData;

implementation

{ TData }

var
   Inventory : TInventory;

{PUBLIC // Script allow}

function TData.GetCurrCreatureInfo: string;
begin
    if CurrCreature > Creatures.Count -1 then exit;

    result := Creatures[CurrCreature].Name + ' ' + Creatures[CurrCreature].Params;
end;

function TData.GetCurrentLevel: string;
begin
    result := IntToStr(CurrLevel);
end;

function TData.GetEvents: string;
begin
    result := EventText;
    EventText := '';
end;

function TData.GetPlayerAttr(name: string): string;
var
    param: TStringList;
begin
    param := TStringList.Create;
    param.CommaText := Player.Params;

    result := param.Values[name];

    param.Free;
end;

function TData.GetPlayerInfo: string;
begin
    result := Player.Name + ' ' + Player.Params;
end;

function TData.GetPlayerItems: string;
begin
    result := Player.Items;
end;

procedure TData.InitCreatures;
// ������������ ����
var
    i, count: integer;
begin

    count := CurrLevel * 5;

    Creatures.Clear;
    for I := 0 to count-1 do
    begin
        /// ������� ������
        if i <> count-1 then
        begin
            Inventory.Clear;
            Inventory.SetItemCount( items[I_GOLD].name, Random( CurrLevel*3 ) + CurrLevel );

            SetCreature(
                Format('%s %s %s', [name1[Random(Length(name1))],name2[Random(Length(name2))],name3[Random(Length(name3))]]),
                Format('HP=%d, ATK=%d, DEF=%d', [
                    Random( CurrLevel*10 ) + CurrLevel*5,
                    Random( CurrLevel*5 )  + CurrLevel*2,
                    Random( Min( CurrLevel*2, 95) )
                ]),
                Inventory.Get
            );

        end;

        /// ���� ������!
        if i = count-1 then
        begin
            Inventory.Clear;
            Inventory.SetItemCount( items[I_GOLD].name, Random( CurrLevel*5 ) + CurrLevel*2 );
            Inventory.SetItemCount( items[Random(Length(items))].name, 1 );

            SetCreature(
                Format('���� %s %s %s', [name1[Random(Length(name1))],name2[Random(Length(name2))],name3[Random(Length(name3))]]),
                Format('HP=%d, ATK=%d, DEF=%d', [
                    Random( CurrLevel*20 ) + CurrLevel*10,
                    Random( CurrLevel*5 )  + CurrLevel*5,
                    Random( Min( CurrLevel*6, 95 ) )
                ]),
                Inventory.Get
            );
        end;
    end;

    CurrCreature := 0;
end;

procedure TData.InitPlayer;
/// ������������� ��������� ��������� ������
begin
    SetPlayer( 'Player', 'LVL=1, HP=100, MP=20, ATK=5, DEF=0, EXP=0', 'RestoreHeal=1');
end;

procedure TData.LevelUpPlayer;
/// �������� ������ ������
var
    CurrLvl: integer;
    DEF: integer;
begin
    CurrLvl := StrToIntDef( GetParamValue( Player, 'LVL' ), 1);
    DEF := StrToIntDef( GetParamValue( Player, 'DEF' ), 1);

    if DEF < 75 then
    ChangeParamValue( Player, 'DEF', 1 );

    ChangeParamValue( Player,  'HP', CurrLvl * 100);
    ChangeParamValue( Player,  'MP', CurrLvl * 20);
    ChangeParamValue( Player, 'ATK', CurrLvl );
    ChangeParamValue( Player, 'EXP', -StrToIntDef( NeedExp, 0));
    ChangeParamValue( Player, 'LVL', 1);

    AddEvent('-> ����� ������� ����� �������!');
end;



procedure TData.PlayerAttack;
// ������� ��������� ��������� ������� ����
// ��������� ������ OnAttack
var
    scr: string; // ����� �������
begin
    scr := Player.OnAttack;
    scr := FillVars(Player, scr);
    Script.Exec( scr );
end;

function TData.Rand(max: string): string;
begin
    result := IntToStr(Random(StrToIntDef(max, 0)));
end;

procedure TData.CreatureAttack;
// ������� ������� ��������� ������
// ��������� ������ OnAttack
var
    scr: string; // ����� �������
begin
    if CurrCreature > Creatures.Count -1 then exit;

    scr := Creatures[CurrCreature].OnAttack;
    scr := FillVars(Creatures[CurrCreature], scr);
    Script.Exec( scr );
end;

procedure TData.DoDamageToCreature(input: string);
// ��������� ����� �������� ��������
var
    CreatureHP: integer;
    CreatureDEF: integer;
    PlayerATK: integer;
    DMG : integer;
begin
    if CurrCreature > Creatures.Count -1 then exit;

    PlayerATK   := StrToIntDef(input, 0);
    CreatureHP  := StrToIntDef( GetParamValue( Creatures[CurrCreature], 'HP'), 0 );
    CreatureDEF := StrToIntDef( GetParamValue( Creatures[CurrCreature], 'DEF'), 0 );

    DMG := Round(PlayerATK - PlayerATK * (CreatureDEF / 100));

    CreatureHP  := CreatureHP - DMG;

    SetParamValue( Creatures[CurrCreature], 'HP', IntToStr(CreatureHP) );
end;

procedure TData.DoDamageToPlayer(input: string);
// ��������� ����� ������
var
    PlayerHP: integer;
    PlayerDEF: integer;
    CreatureATK: integer;
    DMG : integer;
begin

    CreatureATK   := StrToIntDef(input, 0);
    PlayerHP  := StrToIntDef( GetParamValue( Player, 'HP'), 0 );
    PlayerDEF := StrToIntDef( GetParamValue( Player, 'DEF'), 0 );

    DMG := Round(CreatureATK - CreatureATK * (PlayerDEF / 100));

    PlayerHP  := PlayerHP - DMG;

    SetParamValue( Player, 'HP', IntToStr(PlayerHP) );
end;

function TData.CurrentCreature: string;
// ������� ��������
begin
    result := IntToStr(CurrCreature+1);
end;

function TData.CreaturesCount: string;
// ����� ���������� ��������
begin
    result := IntToStr(Creatures.Count);
end;

procedure TData.CurrentLevel(input: string);
// ������� ������� �����/���������
begin
    // ���� ������ �������� - ������, ����� �������� �������
    CurrLevel := StrToIntDef(input, CurrLevel);
end;


{PRIVATE}

procedure TData.SetCreature(name, params: string; items: string = '');
var creature : TCreature;
begin
    creature := TCreature.Create;

    creature.Params := params;
    creature.Name   := name;
    creature.Items  := items;

    creature.OnAttack := 'DoDamageToPlayer({ATK})';

    Creatures.Add( creature );
end;

procedure TData.SetPlayer(name, params: string; items: string = '');
begin
    if not assigned(Player) then Player := TCreature.Create;

    Player.params := params;
    Player.Name   := name;
    Player.Items  := items;

    Player.OnAttack := 'DoDamageToCreature({ATK})';
end;

procedure TData.SetVar(name, value: string);
begin
    Variables[name] := value;
end;

function TData.GetVar(name: string): string;
begin
    result := Variables[name];
end;

procedure TData.UseItem(name: string);
var
    count: integer;
    i: integer;
begin
    /// ����� ��������� ������
    parser.CommaText := player.Items;

    /// ���� �� ��� ������� ������?
    if pos(name, parser.CommaText) = 0 then exit;

    /// ���� �� ���� ����, ����� ���������?
    count := StrToIntDef(parser.Values[name], 0);
    if count <= 0 then exit;

    /// ��������� (��������� ����������� ������ �������)
    for I := 0 to High(items) do
        if items[i].name = name then
        Script.Exec( items[i].script );

    /// ��������� ������� �� ���������
    parser.CommaText := player.Items;
    parser.Values[name] := IntToStr(count - 1);

    /// ���� ��� ��������� - ������� ���������� �� ���������
    if parser.Values[name] = '0' then
    parser.Delete( parser.IndexOfName(name) );

    player.Items := parser.CommaText;
end;

function TData.FillVars(creature: TCreature; scr: string): string;
// ����������� � ����� ������� �������� ��������� ��������/������
var
    i: integer;
begin

    result := scr;

    parser.CommaText := creature.Params;
    // ����� ����������, ������ ����������� �� ��������� �� ������� � ������ ���
    // ������ ���� ����=��������
    // ��������� ��� ����� � �������� �� ���������� ����������
    for i := 0 to parser.Count-1 do
        result := StringReplace(result, '{'+Trim(parser.Names[i])+'}', Trim(parser.Values[parser.Names[i]]), [rfReplaceAll, rfIgnoreCase]);
end;

function TData.GetParamValue(creature: TCreature; param: string): string;
begin
    parser.CommaText := creature.Params;
    result := parser.Values[param];
end;

procedure TData.SetParamValue(creature: TCreature; param, value: string);
begin
    parser.CommaText := creature.Params;
    parser.Values[param] := value;
    creature.Params := parser.CommaText;
end;

procedure TData.AddEvent(text: string);
/// ��� ���������� ������� ������ ����������� � ������ ��� �����������
/// ����������� � ����������
begin
    EventText := text + ifthen(EventText <> '', sLineBreak, '') + EventText;
end;

function TData.AllowLevelUp: string;
var
    exp : integer;
    need: integer;
begin
    exp := StrToIntDef( GetParamValue( Player, 'EXP' ), 1);
    need := StrToIntDef( NeedExp, 99999);
    result := ifthen( exp >= need, '!', '');
end;

function TData.NeedExp: string;
var
    prev, cost, buff, // ���������� ��� ���������� ���������
    lvl,              // ������� ������� ������
    i: integer;
begin

    lvl := StrToIntDef( GetParamValue( Player, 'LVL' ), 1);

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

procedure TData.ChangeParamValue(creature: TCreature; param: string; delta: integer);
var
    val: integer;
begin
    parser.CommaText := creature.Params;
    val := StrToIntDef(parser.Values[param], 0);
    val := val + delta;
    parser.Values[param] := IntToStr(val);
    creature.Params := parser.CommaText;
end;


procedure TData.ChangePlayerParam(name, delta: string);
// ����� ��������� ��������� ������ �� ��������
begin
    ChangeParamValue(Player, name, StrToIntDef(delta, 0));
end;

procedure TData.CheckStatus;
// ����� ��������� ��������� �������� ������� ������
var
    HP: integer;
    playerLVL : integer;
begin
    // ��������� ��������
    if CurrCreature <= Creatures.Count then
    begin

        // �������� ��������� ������
        HP := StrToIntDef( GetParamValue( Player, 'HP'), 0 );

        if HP <= 0 then
        begin
            AddEvent('����� �������� �������� '+ Creatures[CurrCreature].Name +'!');
            AddEvent('������ � ����������...');

            // ������������ �� ������ �������
            CurrLevel := 1;
            // ������� ��������
            InitCreatures();
            CurrCreature := 0;

            // ����� ������
            playerLVL := StrToInt(GetParamValue( Player, 'LVL'));
            SetParamValue(Player, 'HP', IntToStr(playerLVL * 100));
            SetParamValue(Player, 'MP', IntToStr(playerLVL * 20));
            exit;
        end;

        // �������� ��������� �������� �������
        HP := StrToIntDef( GetParamValue( Creatures[CurrCreature], 'HP'), 0 );

        if HP <= 0 then
        begin
            AddEvent('������ '+ Creatures[CurrCreature].Name +' ��������! �������� ' + IntToStr(CurrLevel) + ' �����.');

            // ����� �������� ����
            ChangeParamValue(Player, 'EXP', CurrLevel);

            // ����� �������� ���
            Inventory.Fill( Player.Items );
            Inventory.Loot( Creatures[CurrCreature].Items );
            Player.Items := Inventory.Get;

            // ��������� �� ����������� ��������
            if   AllowLevelUp <> ''
            then LevelUpPlayer;

            // ��������� � ���������� �������
            Inc(CurrCreature);

        end;

    end;

    // �������� �� ��������� ������
    if CurrCreature > Creatures.Count -1 then
    begin
        // ��������� �� ����� ������� ����������
        inc(CurrLevel);
        // ������� ����� ����� ��������
        InitCreatures();
        CurrCreature := 0;
        AddEvent('��������� �� '+ IntToStr(CurrLevel) +' ������� ����������...');
    end;
end;

constructor TData.Create;
begin
   inherited;
   CurrCreature := 0;
   CurrLevel := 1;
   Creatures := TList<TCreature>.Create();
   Script := TScriptDrive.Create;
   parser := TStringList.Create;
   Variables := TDictionary<String,String>.Create();
end;

destructor TData.Destroy;
begin
    Variables.Free;
    parser.Free;
    Script.Free;
    Creatures.Free;
    inherited;
end;


{ TInventary }

procedure TInventory.ChangeItemCount(name: string; count: integer);
var
    has: integer;
begin

    // ���� ����� ������� ��� ����, �������� ������� ����������
    if Pos(name, items.CommaText) > 0
    then has := StrToIntDef(items.Values[name], 0)
    else has := 0;

    has := Max( 0, has + count ); // ��������� ���������, �� ��������� �� ���� ����
    items.Values[name] := IntToStr(has);

end;

function TInventory.Get: string;
begin
    result := items.CommaText;
end;

function TInventory.GetItemCount(name: string): integer;
begin
    result := 0;

    // ���� ������� ���� � ���������
    if   Pos(name, items.CommaText) > 0
    then result := StrToIntDef(items.Values[name], 0);
end;

procedure TInventory.Loot(lootInv: string);
// ���������� � ������� ������������� ��������� ���, ��� ���� � lootInv ���������
var
    loot: TStringList;
    i: integer;
begin
    if Trim(lootInv) = '' then exit;

    loot := TStringList.Create;
    loot.CommaText := lootInv;

    for I := 0 to loot.Count-1 do
    begin
        ChangeItemCount( loot.Names[i], StrToInt( loot.Values[ loot.Names[i] ]) );
        Data.AddEvent('��������: ' + loot.Values[ loot.Names[i] ] + ' '+ loot.Names[i]);
    end;

    loot.Free;
end;

procedure TInventory.RemoveItem(name: string);
begin
    items.Values[name] := '0';
end;

procedure TInventory.Clear;
begin
    items.CommaText := '';
end;

procedure TInventory.Fill(inv: string);
begin
    items.CommaText := inv;
end;

procedure TInventory.SetItemCount(name: string; count: integer);
begin
    items.Values[name] := IntToStr(count);
end;

constructor TInventory.Create;
begin
    inherited;
    items := TStringList.Create;
end;

destructor TInventory.Destroy;
begin
    items.Free;
    inherited;
end;



initialization
   Data := TData.Create;
   Inventory := TInventory.Create;


finalization
   Data.Free;
   Inventory.Free;

end.
