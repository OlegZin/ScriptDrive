unit uData;

interface

uses
    uTypes, uScriptDrive,
    System.SysUtils, Generics.Collections, Vcl.Dialogs, Classes;

type

    TData = class
    public
        Player : TCreature;
        Creatures: TList<TCreature>;

        CurrCreature: integer;

        constructor Create;
        destructor Destroy;

        procedure PlayerAttack(input: string = '');   // ������� ������ ��������� ������� ����
        procedure CreatureAttack(input: string = ''); // ������� ������� ���������

        procedure DoDamageToCreature(input: string = ''); // ��������� ����� �������� ��������
        procedure DoDamageToPlayer(input: string = ''); // ��������� ����� ������

        function GetCurrCreatureInfo(input: string = ''): string;
        function GetPlayerInfo(input: string = ''): string;

        procedure InitPlayer(input: string = '');
        procedure InitCreatures(input: string = '');

        function CurrentCreature(input: string = ''): string;
        function CreaturesCount(input: string = ''): string;

        procedure CheckStatus(input: string = '');  // �������� �������� ������� � ������� ������� ������
    private
        parser: TStringList;
        Script : TScriptDrive;

        function FillVars(creature: TCreature; scr: string): string;

        function GetParamValue(creature: TCreature; param: string): string;
        procedure SetParamValue(creature: TCreature; param, value: string);
        procedure ChangeParamValue(creature: TCreature; param: string; delta: integer);

        procedure SetCreature(name, params: string);
        procedure SetPlayer(name, params: string);  // ����������� � ����� ������� �������� ��������� ��������/������
    end;

Var
    Data : TData;

implementation

{ TData }

{PUBLIC // Script allow}

function TData.GetCurrCreatureInfo(input: string): string;
begin
    result := Creatures[CurrCreature].Name + ' ' + Creatures[CurrCreature].Params;
end;

function TData.GetPlayerInfo(input: string): string;
begin
    result := Player.Name + ' ' + Player.Params;
end;

procedure TData.InitCreatures(input: string);
// ������������ ����
var
    i, count: integer;
begin

    count := StrToIntDef(input, 10);

    Creatures.Clear;
    for I := 0 to count-1 do
        SetCreature(
            Format('%s %s %s', [name1[Random(Length(name1))],name2[Random(Length(name2))],name3[Random(Length(name3))]]),
            Format('HP=%d, ATK=%d, DEF=%d', [Random(200)+10, Random(10)+1, Random(10)])
        );

    CurrCreature := 0;
end;

procedure TData.InitPlayer(input: string);
/// ������������� ��������� ��������� ������
begin
    SetPlayer( 'Player', 'LVL=1, HP=100, MP=20, ATK=10, DEF=0, EXP=0');
end;

procedure TData.PlayerAttack(input: string);
// ������� ��������� ��������� ������� ����
// ��������� ������ OnAttack
var
    scr: string; // ����� �������
begin
    scr := Player.OnAttack;
    scr := FillVars(Player, scr);
    Script.Exec( scr );
end;

procedure TData.CreatureAttack(input: string);
// ������� ������� ��������� ������
// ��������� ������ OnAttack
var
    scr: string; // ����� �������
begin
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

function TData.CurrentCreature(input: string): string;
// ������� ��������
begin
    result := IntToStr(CurrCreature+1);
end;

function TData.CreaturesCount(input: string): string;
// ����� ���������� ��������
begin
    result := IntToStr(Creatures.Count);
end;

{PRIVATE}

procedure TData.SetCreature(name, params: string);
var creature : TCreature;
begin
    creature := TCreature.Create;

    creature.Params:= params;
    creature.Name  := name;

    creature.OnAttack := 'DoDamageToPlayer({ATK})';

    Creatures.Add( creature );
end;

procedure TData.SetPlayer(name, params: string);
begin
    if not assigned(Player) then Player := TCreature.Create;

    Player.params := params;
    Player.Name   := name;

    Player.OnAttack := 'DoDamageToCreature({ATK})';
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


procedure TData.CheckStatus(input: string);
// ����� ��������� ��������� �������� ������� ������
var
    HP: integer;
begin
    // �������� ��������� �������� �������
    HP := StrToIntDef( GetParamValue( Creatures[CurrCreature], 'HP'), 0 );

    if HP <= 0 then
    begin
        // ����� �������� ����
        ChangeParamValue(Player, 'EXP', 1);

        // ��������� � ���������� �������
        Inc(CurrCreature);
    end;

    // �������� ��������� ������
    HP := StrToIntDef( GetParamValue( Player, 'HP'), 0 );

    if HP <= 0 then
    begin
        // ����� �������� ����
        ChangeParamValue(Player, 'EXP', 1);

        // ��������� � ���������� �������
        Inc(CurrCreature);
    end;

end;

constructor TData.Create;
begin
   inherited;
   Creatures := TList<TCreature>.Create();
   Script := TScriptDrive.Create;
   parser := TStringList.Create;
end;

destructor TData.Destroy;
begin
    parser.Free;
    Script.Free;
    Creatures.Free;
    inherited;
end;


initialization
   Data := TData.Create;

finalization
   Data.Free;

end.
