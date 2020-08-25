unit uData;

interface

uses
    uTypes, uScriptDrive, uThinkModeData, uFloors, uTargets, uTools, superobject,
    System.SysUtils, Generics.Collections, Vcl.Dialogs, Classes, Math, StrUtils;

const
    /// �������� ���� �����
    O_PARAMS    = 'params';    /// ������ ����������
    O_SKILLS    = 'skills';    /// ������ ������
    O_ITEMS     = 'items';     /// ������ ���������
    O_BUFFS     = 'buffs';     /// ������ ������
    O_AUTOBUFFS = 'autobuffs'; /// ������ ����������
    O_LOOT      = 'loot';      /// ������ ��������
    O_EVENTS    = 'events';    /// ������ �������

    S_NAME      = 'name';      /// ��� ��������
type

    TData = class
    private
//        Player : ISuperObject;
//        Creature: ISuperObject;

        Target: ISuperObject;
            // ������� ��������� ����. ������������ ���
            // �������, ������� �� ����������� � ����������� �������.
            // ��� �������� ��������� ����� ������� ��� ��������

        Variables: TDictionary<String,String>;
            // ����� ���������� ���������� ��� ��������

        Objects: TDictionary<String,ISuperObject>;
            //

        CurrLevel: integer;        // ������� ���������� �������
        CurrStep: integer;        // ������� ���������� ��� �� �������
        MaxStep: integer;        // ����� ����� �� ������ �������

        CurrTargetIndex: integer;  // ���������� ������� ������� �����

        CurrLang: integer;         // ������� ����

        EventText: string;  // ��������� ��������� ��� ������ Tower
        ThinkEvent: string; // ��������� ��������� ��� ������ Think
        FloorEvent: string; // ��������� ��������� ��� ������ Floor

        Breaks: String;  /// ����� ������ � ������� �������, ��� ������� ��������� �������
        ///    ���������� ���������� ������������
        ///    ��������, ��������� ���� Tower, ��������� ��������� ������� ����

        AllowModes: ISuperObject;
        /// �������� ����������� ����� ������ � ������� ��������� ������ ������� ������������
        /// ������������ ����������� ��� ������������ ������� � ��� ��� ���� ������������.
        /// �������, ������ ����������� ����� ������� ��������, ��� ����� �������������� ���
        /// �� ���������. ��������, ���������� � �������� ��������� �������� � ������.

        AutoATKCount: integer;

    public


        constructor Create;
        destructor Destroy;

        function GetAutoATK: string;
        procedure SetAutoATK(count: variant);
        procedure ChangeAutoATK(delta: variant);

        procedure PlayerAttack;   // ������� ������ ��������� ������� ����
        procedure CreatureAttack; // ������� ������� ���������

        procedure DoDamageToCreature(input: string); // ��������� ����� �������� ��������
        procedure DoDamageToPlayer(input: string); // ��������� ����� ������

        function GetCurrCreatureInfo: string;
        function GetPlayerInfo: string;
        function GetPlayerBuffs: string;
        function GetPlayerItems: string;
        function GetPlayerLoot: string;

        function GetPlayerAttr(name: string): string;
        function GetMonsterAttr(name: string): string;
        function GeAttr(creature: TCreature; name: string): string;

        function GetCurrTarget: string;
        procedure SetPlayerBuff(name, count: variant);
        // ���������� ������ � Player.Buffs

        procedure SetPlayerAutoBuff(name, count: variant);
        // ���������� ������ � Player.Buffs

        procedure SetPlayerScript(event, scr: string);
        procedure SetCreatureScript(event, scr: string);

        procedure InitGame;
        procedure InitPlayer;
        procedure InitCreatures;
        procedure InitItemsCraftCost;

        function CurrentStep: string;
        function StepCount: string;

        procedure CheckStatus;  // �������� �������� ������� � ������� ������� ������
        procedure CurrentLevel(input: variant);
        function GetCurrentLevel: string;

        procedure SetNextTarget;

        function GetEvents: string;

        procedure LevelUpPlayer;
        function AllowLevelUp: string;
        // �������� �� ������������� �������� ����� ��� �������� ������

        function NeedExp(lvl: variant): string;
        // ���������� ���������� ����� ��� �������� ������

        function ChangePlayerParam(name, delta: variant): string;
        // ����� ��������� ��������� ������
        function ChangeCreatureParam(name, delta: variant): string;

        procedure AddEvent(text: string);
        procedure UseItem(name: string);
        procedure UseSkill(name: string);
        procedure UpSkill(name: string);

        procedure SetVar(name, value: string);
        function GetVar(name: string): string;

        procedure ChangePlayerItemCount(name, delta: variant);
        function GetPlayerItemCount(name: variant):string;
        function GetItemCount(list, name: string): string;
        /// ��������� ���������� � ��������� ������

        procedure SetPlayerRes(name, count: variant);

        function GetRandItemName: string;
        function GetRandResName: string;

        function ProcessAuto: string;
        // ���������� ��� ����������� ������������, �������� �����������

        function GetAllowModes: string;
        procedure AllowMode(name, value: variant);
        // ��������� � ������ ��������� ������ ������������ �����

        procedure SetCreature(name, params: string; items: string = ''; loot: string = '');

        procedure SetLang(lang: string);
        function GetLang: string;
        function GetInLang(text: string; lang: string = ''): string;
                             /// �������� ������������� ������ � ����������
                             /// � ������� ��� ��������� �����

        function GetSkillLvl(name: string): string;
        function GetPlayerSkills: string;

        procedure SetBreak(name: string);  // ����� ������� ��������� ������������ ��� ��������� �������
        function GetBreaks: string; // ��������� ������ ����� ������� ���������� � �� �������



        function GetThinks: string;
        procedure ProcessThinks(caption, delta: variant);
        procedure AddThinkEvent(text: string);
        function GetThinkEvents: string;
        procedure OpenThink(name: string);

        function GetGameScripts: string;

        function GetTrashCount: string; // ���������� ������ �� ������� �����
        function GetTrashIDs: string;
        function ProcessFloorObject(id: variant): string;
        function GetFloorEvents: string;
        procedure AddFloorEvent(text: string);
        function GetFloorObjectSize(id: variant): string;


        procedure AllowTool(name: string);
        function GetAllowTool(name: string): string;
        function GetToolsList: string;
        function GetToolAttr(capt, attr: string): string;
        procedure ToolUpgrade(capt: string);
        function NeedToolUpgrade(capt: string): string;

        function GetAutoSpeed: string;
        function Draw(var obj: ISuperObject; name: string; count: variant): integer;

    private
        parser: TStringList;
        Script : TScriptDrive;

        function ChangeParamValue(creature: ISuperObject; param: string; delta: integer): string;

        function GetEventScript(creature: ISuperObject; name: string): string;

        function GetResByName(name: string): TRes;

        procedure Loot(var target, source: ISuperObject; name: string);

    end;

Var
    Data : TData;

implementation

{ TData }

{PUBLIC // Script allow}

procedure TData.InitGame;
begin
    Script.Exec('SetVar('+SHOVEL_LVL+    ', 1);');
    Script.Exec('SetVar('+PICK_LVL+      ', 1);');
    Script.Exec('SetVar('+AXE_LVL+       ', 1);');
    Script.Exec('SetVar('+KEY_LVL+       ', 1);');
    Script.Exec('SetVar('+SWORD_LVL+     ', 0);');
    Script.Exec('SetVar('+TIMESAND_LVL+  ', 40);');
    Script.Exec('SetVar('+LIFEAMULET_LVL+', 0);');
    Script.Exec('SetVar('+LEGGINGS_LVL+  ', 0);');

    InitItemsCraftCost;
end;


procedure TData.InitPlayer;
/// ������������� ��������� ��������� ������
var
    i: integer;
    skl : ISuperObject;
    Player: ISuperObject;
begin

    /// ����� ������ ����� �� �������, ���������, ���������� ��� ��� � ������ ����
    skl := SO();
    Player := SO();

    for I := 0 to High(skills) do
          skl.I[skills[i].name] := 0;

    Player.O[O_PARAMS]    := SO('{"LVL":1, "HP":100, "MP":20, "ATK":5, "DEF":0, "REG":1, "EXP":0}');
    Player.O[O_SKILLS]    := skl;
    Player.O[O_ITEMS]     := SO('{"Gold":100000}');
    Player.O[O_BUFFS]     := SO();
    Player.O[O_AUTOBUFFS] := SO();
    Player.O[O_LOOT]      := SO();
    Player.O[O_EVENTS]    := SO('{"OnAttack":"DoDamageToCreature(GetPlayerAttr(ATK));"}');

    Objects.Add('Player', Player);
    Player := nil;

end;


function TData.GeAttr(creature: TCreature; name: string): string;
var
    param: TStringList;
begin

    param := TStringList.Create;
    param.CommaText := creature.Params;

    if   param.IndexOfName(name) <> -1
    then result := param.Values[name]
    else result := '0';

    param.Free;
end;

function TData.GetAllowModes: string;
begin
    result := AllowModes.AsJSon();
end;

function TData.GetAllowTool(name: string): string;
var
    i : integer;
begin
    result := 'false';

    for I := 0 to High(arrTools) do
    if AnsiUpperCase(arrTools[i].name) = AnsiUpperCase(name) then
    begin
        if arrTools[i].isAllow
        then result := 'true';
    end;
end;

function TData.GetAutoATK: string;
begin
    result := IntToStr(AutoATKCount);
end;

function TData.GetAutoSpeed: string;
begin
    result := IntToStr(1000 - StrToInt(Data.GetVar('TIMESAND_LVL')) * 20);
end;

function TData.GetBreaks: string;
begin
    result := Breaks;
    Breaks := '';
end;

function TData.GetCurrCreatureInfo: string;
begin
    result := Objects['Creature'][S_NAME].AsString + ': ' + Objects['Creature'][O_PARAMS].AsString;
end;

function TData.GetCurrentLevel: string;
begin
    result := IntToStr(CurrLevel);
end;

function TData.GetCurrTarget: string;
begin
    result := IntToStr(targets[CurrTargetIndex].level);
end;

function TData.GetEvents: string;
begin
    result := EventText;
    EventText := '';
end;

function TData.GetEventScript(creature: ISuperObject; name: string): string;
begin
    result := '';

    if Assigned(creature.O[ O_EVENTS + '.' + name ])
    then result := creature.O[ O_EVENTS + '.' + name ].AsString;
end;

function TData.GetFloorEvents: string;
begin
    result := FloorEvent;
    FloorEvent := '';
end;

function TData.GetFloorObjectSize(id: variant): string;
var
    elem: TTrash;
begin
    result := '';
    if arrFloors[CurrLevel].Trash.TryGetValue(id, elem) then
    result := elem.size;
end;

function TData.GetGameScripts: string;
var
    i: integer;
begin
    result := '===== ITEMS =====' + sLineBreak + sLineBreak;

    for I := 0 to High(items) do
    begin
        result := result + '['+items[i].name+']' + sLineBreak;
        result := result + 'Craft: ' + ifthen( items[i].isCraftAllow, items[i].craft, '?????') + sLineBreak;
        result := result + items[i].script + sLineBreak;
        result := result + sLineBreak;
    end;

    result := result + '===== SKILLS =====' + sLineBreak + sLineBreak;

    for I := 0 to High(skills) do
    begin
        result := result + '['+skills[i].name+']' + sLineBreak;
        result := result + skills[i].script + sLineBreak;
        result := result + sLineBreak;
    end;
end;

function TData.GetPlayerAttr(name: string): string;
begin
    result := Objects['Player'].O[ O_PARAMS + '.' + name ].AsString;
end;

function TData.GetPlayerBuffs: string;
begin
    result := Objects['Player'].O[ O_AUTOBUFFS ].AsString;
end;

function TData.GetPlayerInfo: string;
var
    resultList: string;
    tmp : ISuperObject;
    item : TSuperAvlEntry;
begin
    resultList := '';

    tmp := Objects['Player'].O[ O_PARAMS ].Clone;

    for item in Objects['Player'].O[ O_BUFFS ].AsObject do
    if item.Value.AsInteger <> 0 then
        tmp.S[item.Name] := tmp.S[item.Name] + '[' + item.Value.AsString + ']';

    result := tmp.AsJSon();
end;

function TData.GetPlayerItemCount(name: variant): string;
begin
    result := Objects['Player'].O[ O_ITEMS + '.' + name].AsString;
end;

function TData.GetInLang(text: string; lang: string = ''): string;
var
    multiLang: ISuperObject;
begin
    result := '';
    if lang = '' then lang := GetLang;

    multiLang := SO(text);
    if Assigned(multiLang) then result := multiLang[lang].AsString;
end;

function TData.GetItemCount(list, name: string): string;
begin
    result := '0';

    parser.CommaText := list;
    if   parser.IndexOfName(name) <> -1
    then result := parser.Values[name];
end;

function TData.GetLang: string;
begin
    result := 'ENG';

    if CurrLang = 0 then result := 'ENG';
    if CurrLang = 1 then result := 'RU';
end;

function TData.GetMonsterAttr(name: string): string;
begin
    result := Objects['Creature'].O[ O_PARAMS + '.' + name].AsString;
end;

function TData.GetPlayerItems: string;
begin
    result := Objects['Player'].O[ O_ITEMS ].AsJSon();
end;

function TData.GetPlayerLoot: string;
begin
    result := Objects['Player'].O[ O_LOOT ].AsJSon();
end;

function TData.GetPlayerSkills: string;
begin
    result := Objects['Player'].O[ O_SKILLS ].AsJSon();
end;

function TData.GetRandItemName: string;
begin
    result := items[Random(Length(items))].name;
end;

function TData.GetRandResName: string;
var
    i: integer;
    val: integer;
begin
    /// ��� ������ ��������� �������� ����� ���� �������� ��������
    if resSummRarity = 0 then
    for i := 0 to High(arrRes) do
        resSummRarity := resSummRarity + arrRes[i].rarity;

    /// �������� ��������� �����, ����������� �� ���� �� ��������
    val := Random( resSummRarity + 1);

    /// ���������� ������� � �������� ���� �� ���. � ������ ��������!
    for i := 0 to High(arrRes) do
    begin
        val := val - arrRes[i].rarity;
        if val <= 0 then
        begin
            result := arrRes[i].name;
            break;
        end;
    end;

    result := GetInLang(result);
end;

function TData.GetResByName(name: string): TRes;
var
    i: integer;
begin
    for i := 0 to High(arrRes) do
    if Pos(name, arrRes[i].name) > 0 then
        result := arrRes[i];
end;

function TData.GetSkillLvl(name: string): string;
begin
    result := Objects['Player'].O[ O_SKILLS + '.' + name].AsString;
end;

function TData.GetThinkEvents: string;
begin
    result := ThinkEvent;
    ThinkEvent := '';
end;

procedure TData.OpenThink(name: string);
var
    i : integer;
begin
    for I := 0 to High(arrThinks) do
    if arrThinks[i].Name = name
    then arrThinks[i].enable := 1;
end;

function TData.GetThinks: string;
var
    i : integer;
    comma, caption: string;
    pars: TStringList;
begin
    comma := '';

    pars := TStringList.Create;
    pars.StrictDelimiter := true;

    for I := 0 to High(arrThinks) do
    begin
        /// ���� ������� �������� � ��� �� ����������
        if ( arrThinks[i].enable = 1 ) and ( arrThinks[i].exp > 0 )then
        begin
            pars.CommaText := arrThinks[i].caption;
            caption := pars.Values[GetLang];
            result := result + comma + StringReplace(caption, '"', '', [rfReplaceAll]) +
                ' (' + IntToStr(arrThinks[i].exp) + ')';
            comma := ',';
        end;
    end;

    pars.Free;
end;

function TData.GetToolAttr(capt, attr: string): string;
var
    i : integer;
    index : integer;
    pars: TStringList;
begin

    index := -1;
    result := '';
    pars := TStringList.Create;
    pars.StrictDelimiter := true;

    for I := 0 to High(arrTools) do
    if   Pos(AnsiUpperCase(capt), AnsiUpperCase(arrTools[i].caption)) > 0
    then index := i;

    if index = -1 then exit;

    if attr = 'lvl' then
       result := IntToStr(arrTools[index].lvl);

    if attr = 'caption' then
    begin
        pars.CommaText := arrTools[index].caption;
        result := pars.Values[GetLang];
    end;

    if attr = 'desc' then
    begin
        pars.CommaText := arrTools[index].desc;
        result := pars.Values[GetLang];
    end;

    if attr = 'script' then
       result := arrTools[index].script;

    pars.free;
end;

procedure TData.ToolUpgrade(capt: string);
var
    i : integer;
    index : integer;
begin

    index := -1;

    for I := 0 to High(arrTools) do
    if   Pos(AnsiUpperCase(capt), AnsiUpperCase(arrTools[i].caption)) > 0
    then index := i;

    if index = -1 then exit;

    arrTools[index].lvl := arrTools[index].lvl + 1;

    Script.Exec(arrTools[index].script);

    ChangePlayerItemCount('Gold', '-'+NeedToolUpgrade(capt));
end;

function TData.GetToolsList: string;
/// �������� ������ ��������� ������������
var
    pars: TStringList;
    i : integer;
    comma : string;
begin
    pars := TStringList.Create;
    pars.StrictDelimiter := true;

    comma := '';

    for I := 0 to High(arrTools) do
    if arrTools[i].isAllow then
    begin
        pars.CommaText := arrTools[i].caption;
        result := result + comma + pars.Values[GetLang];
        comma := ',';
    end;

    pars.Free;
end;

function TData.GetTrashCount: string;
begin
    result := IntToStr( arrFloors[CurrLevel].Trash.Count );
end;

function TData.GetTrashIDs: string;
var
   i: integer;
   keys: TArray<integer>;
begin
    keys := arrFloors[CurrLevel].Trash.Keys.ToArray;

    for I := 0 to High(keys) do
        result := result + IntToStr(keys[i]) + ',';
end;

procedure TData.InitCreatures;
// ������������ ����
var
    i, count, lootCount: integer;
    _items, _loot: string;
    tmp: ISuperObject;
begin

    if CurrStep < MaxStep then
    begin
        /// ������
        _items := Format('{"%s":%d}', [items[I_GOLD].name, Random( CurrLevel*2 ) + CurrLevel]);

        /// ������� (���� �� ���� ���)
        lootCount := Random(CurrLevel div 2);
        if   lootCount > 0
        then _loot := Format('{"%s":%d}', [GetRandResName, lootCount]);

        SetCreature(
            Format('%s %s %s', [
                name1[Random(Length(name1))][CurrLang],
                name2[Random(Length(name2))][CurrLang],
                name3[Random(Length(name3))][CurrLang]
            ]),
            Format('{"HP":%d, "ATK":%d, "DEF":%d}', [
                Random( CurrLevel*10 ) + CurrLevel*5,
                Random( CurrLevel*5 )  + CurrLevel*2,
                Random( CurrLevel*2 )
            ]),
            _items,
            _loot
        );

    end;

    /// ���� ������!
    if CurrStep = MaxStep then
    begin

        // ���� �� ��������� ��������
        if Random(2) > 0
        then _items := Format('{"%s":%d, "%s":%d}', [
                items[I_GOLD].name, Random( CurrLevel*5 ) + CurrLevel*2,
                items[Random(Length(items))].name, 1
            ])
        else _items := Format('{"%s":%d}', [
                items[I_GOLD].name, Random( CurrLevel*5 ) + CurrLevel*2
            ]);


        ///  ���� ������ �� ���� ����� ��������
        ///  �� ��������� ���� �������� ��������, ��� ����� �������������� � ���� ������ ������
        ///  ��������� lootCount
        tmp := SO();
        lootCount := Random( 4 );
        for I := 0 to lootCount do
            tmp.I[ O_LOOT + '.' + GetRandResName] := Random( CurrLevel ) + 1;


        SetCreature(
            Format('[BOSS] %s %s %s', [
                name1[Random(Length(name1))][CurrLang],
                name2[Random(Length(name2))][CurrLang],
                name3[Random(Length(name3))][CurrLang]
            ]),
            Format('{"HP":%d, "ATK":%d, "DEF":%d}', [
                Random( CurrLevel*50 ) + CurrLevel*30,
                Random( CurrLevel*25 )  + CurrLevel*10,
                Random( CurrLevel*6 )
            ]),
            _items,
            tmp.O[ O_LOOT ].AsJSon()
        );
    end;
end;



procedure TData.LevelUpPlayer;
/// �������� ������ ������
var
    CurrLvl: integer;
    DEF: integer;
begin
    CurrLvl := Objects['Player'].O[ O_PARAMS + '.LVL' ].AsInteger;
    DEF := Objects['Player'].O[ O_PARAMS + '.DEF' ].AsInteger;

    ChangeParamValue( Objects['Player'],  'HP', CurrLvl * 100);
    ChangeParamValue( Objects['Player'],  'MP', CurrLvl * 20);
    ChangeParamValue( Objects['Player'], 'ATK', CurrLvl );
    ChangeParamValue( Objects['Player'], 'DEF', 1 );
    ChangeParamValue( Objects['Player'], 'EXP', -StrToIntDef( NeedExp(CurrLvl), 0));
    ChangeParamValue( Objects['Player'], 'LVL', 1);

    AddEvent(phrases[PHRASE_LEVEL_UP][CurrLang]);
end;



procedure TData.Loot(var target, source: ISuperObject; name: string);
var
    item: TSuperObjectIter;
    count: integer;
begin
    if not assigned(Source.O[name]) then exit;

    if ObjectFindFirst(source[name], item) then
    repeat

        if assigned (target.O[name + '.' + item.key])
        then count := target.I[name + '.' + item.key]
        else count := 0;

        target.I[name + '.' + item.key] := count + item.val.AsInteger;
        AddEvent(Format(phrases[PHRASE_GET_LOOT][CurrLang], [item.val.AsString, item.key]));

    until not ObjectFindNext(item);
    ObjectFindClose(item);
end;

procedure TData.PlayerAttack;
// ������� ��������� ��������� ������� ����
// ��������� ������ OnAttack
var
    scr: string; // ����� �������
begin
    scr := GetEventScript( Objects['Player'], 'OnAttack' );
    if scr <> '' then
        Script.Exec( scr );
end;

function TData.ProcessAuto: string;
var
    count, regen : integer;
//    item : TSuperAvlEntry;
    item: TSuperObjectIter;
    Player: ISuperObject;
begin
    result := '';

    Player := Objects['Player'];

    if not Assigned(Player.O[ O_AUTOBUFFS ]) then exit;

    // ������� ���� ������
    // ������� ��������
    regen := Player.O[ O_PARAMS + '.REG'].AsInteger;

    // �������� ��������
    if   Assigned(Player.O[ O_BUFFS + '.REG']) and (Player.O[ O_BUFFS + '.REG' ].AsInteger <> 0)
    then regen := regen + Draw(Player, O_BUFFS + '.REG', 1);

    if ObjectFindFirst(Player.O[ O_AUTOBUFFS ], item) then
    repeat

        // ��������� �������� ������ � ��������, �������� ���������� ��������� �����
        count := Draw( Player, O_AUTOBUFFS+'.'+item.key, regen );

        // � ������, ����� ����� ������������� (������ ���, ��������)
        // ������ ���� ������, ����� ������� � ������
        if Player.O[ O_AUTOBUFFS + '.' + item.key].AsInteger < 0
        then regen := -regen;

        /// ���� ����� ��� �������
        if count <> 0 then
        begin
            // ������ �������� ������ � ������ �������, ��� ��������� ����
            ChangeParamValue( Player, item.key, regen );
            result := '+';
        end;

    until not ObjectFindNext(item);
    ObjectFindClose(item);

    Objects['Player'] := Player;
    Player := nil;

    ///  ���� ���� ���������, ��������� ������ ����. ��������, ����� ��� �������� ��� ��������
    ///  � ��� ����� ��������
    if result <> '' then CheckStatus;
end;


function TData.ProcessFloorObject(id: variant): string;
/// ������� ���������� � ������� � ���� ������� - ��������� ������
var
    item: TTrash;
    pars: TStringList;
    capt: string;
    delta: integer;
begin
    // ������ ������������ �������� ���������(������) ������ � ���������� ������
    result := '';

    if not arrFloors[CurrLevel].Trash.TryGetValue(id, item) then exit;

    pars := TStringList.Create;
    pars.StrictDelimiter := true;

    /// �������� �������� ������ �� ������ �� �����
    item := arrFloors[CurrLevel].Trash[Integer(id)];

    delta := 1;

    // ���� ������ ����� - ������ ���� ������ � �������� ������������
    if arrFloors[CurrLevel].Trash[Integer(id)].name = 'Trash'
    then
        delta := StrToIntDef(Script.Exec('GetVar('+SHOVEL_LVL+');'), 1);

    // ���� ������ ����� - ������ ���� ������ � �������� ������������
    if (arrFloors[CurrLevel].Trash[Integer(id)].name = 'StoneBlockage') or
       (arrFloors[CurrLevel].Trash[Integer(id)].name = 'WoodBlockage')
    then
        delta := StrToIntDef(Script.Exec('GetVar('+PICK_LVL+');'), 1);

    // ���� ������ ���� - ����� ���� ������ � �������� ������������
    if arrFloors[CurrLevel].Trash[Integer(id)].name = 'Box'
    then
        delta := StrToIntDef(Script.Exec('GetVar('+AXE_LVL+');'), 1);

    // ���� ������ ������ - ������� ���� ������ � �������� ��������
    if arrFloors[CurrLevel].Trash[Integer(id)].name = 'Chest'
    then
        delta := StrToIntDef(Script.Exec('GetVar('+KEY_LVL+');'), 1);

    item.count := item.count - delta;

    if item.count > 0 then
    begin
        arrFloors[CurrLevel].Trash[Integer(id)] := item;

        pars.CommaText := item.caption;
        capt := pars.Values[GetLang];
        result := pars.Values[GetLang] + ' (' + IntToStr(item.count) + ')';

    end else
    begin
        Script.Exec(item.script);
        arrFloors[CurrLevel].Trash.Remove(id);
    end;

    pars.Free;
end;

procedure TData.ProcessThinks(caption, delta: variant);
var
    i, exp : integer;
begin

    for I := 0 to High(arrThinks) do
    begin
        if pos(caption, arrThinks[i].caption) > 0 then
        begin
            arrThinks[i].exp := arrThinks[i].exp + delta;
            arrThinks[i].exp := Max(0, arrThinks[i].exp);

            if   arrThinks[i].exp = 0
            then Script.Exec(arrThinks[i].script);

            break;
        end;
    end;

end;

procedure TData.CreatureAttack;
// ������� ������� ��������� ������
// ��������� ������ OnAttack
var
    scr: string; // ����� �������
begin
    scr := GetEventScript( Objects['Creature'], 'OnAttack' );
    if scr <> '' then Script.Exec( scr );
end;


procedure TData.DoDamageToCreature(input: string);
// ��������� ����� �������� ��������
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

    Player := Objects['Player'];
    Creature := Objects['Creature'];

    ATKbuff := Draw( Player, O_BUFFS + '.ATK', 1 );

    PlayerATK   := Random( StrToIntDef(input, 0) + ATKbuff );

    /// ��������� ������ ����, �� �� ���� ������������ �����
    bustedBySword := Min(StrToIntDef(Variables[SWORD_LVL], 0), Player.I[ O_PARAMS + '.ATK' ]);
    PlayerATK   := Max(bustedBySword, PlayerATK);

    if Assigned(Creature.O[ O_PARAMS + '.HP'])
    then CreatureHP  := Creature.I[ O_PARAMS + '.HP']
    else CreatureHP  := 0;

    if Assigned(Creature.O[ O_PARAMS + '.DEF'])
    then CreatureDEF := Creature.I[ O_PARAMS + '.DEF']
    else CreatureDEF := 0;

    BLOCK := Round(PlayerATK * ((CreatureDEF / 10) / 100));  // 1 DEF = -0.1% dmg
    DMG := PlayerATK - BLOCK;  // 1 DEF = -0.1% dmg

    CreatureHP  := CreatureHP - DMG;

    Creature.I[ O_PARAMS + '.HP' ] := CreatureHP;

    if BLOCK > 0
    then AddEvent(Format(phrases[PHRASE_PLAYER_STRIKE_BLOCK][CurrLang], [DMG, BLOCK]))
    else AddEvent(Format(phrases[PHRASE_PLAYER_STRIKE][CurrLang], [DMG]));

    Objects['Player'] := Player;
    Player := nil;

    Objects['Creature'] := Creature;
    Creature := nil;
end;

procedure TData.DoDamageToPlayer(input: string);
// ��������� ����� ������
var
    PlayerHP: integer;
    PlayerDEF: integer;
    CreatureATK: integer;
    DMG, BLOCK : integer;
    DEFbuff: integer;
    ATKbuff: integer;

    Player: ISuperObject;
    Creature : ISuperObject;
begin

    Player := Objects['Player'];
    Creature := Objects['Creature'];

    ATKbuff := Draw( Creature, O_BUFFS+'.ATK',1 );

    DEFbuff := Draw( Player, O_BUFFS+'.DEF', 1 );

    CreatureATK := Random( StrToIntDef(input, 0) + ATKbuff );

    if Assigned(Player.O[ O_PARAMS + '.HP'])
    then PlayerHP  := Player.I[ O_PARAMS + '.HP']
    else PlayerHP  := 0;

    if Assigned(Player.O[ O_PARAMS + '.DEF'])
    then PlayerDEF  := Player.I[ O_PARAMS + '.DEF'] + DEFbuff
    else PlayerDEF  := DEFbuff;

    BLOCK := Round(CreatureATK * (( PlayerDEF/10 ) / 100));
    DMG := CreatureATK - BLOCK;  // 1 DEF = -0.1% dmg

    PlayerHP  := PlayerHP - DMG;

    Player.I[ O_PARAMS + '.HP'] := PlayerHP;

    if BLOCK > 0
    then AddEvent(Format(phrases[PHRASE_MONSTER_STRIKE_BLOCK][CurrLang], [DMG, BLOCK]))
    else AddEvent(Format(phrases[PHRASE_MONSTER_STRIKE][CurrLang], [DMG]));

    Objects['Player'] := Player;
    Player := nil;

    Objects['Creature'] := Creature;
    Creature := nil;
end;

function TData.CurrentStep: string;
// ������� ��������
begin
    result := IntToStr(CurrStep);
end;

function TData.StepCount: string;
// ����� ���������� ��������
begin
    result := IntToStr(MaxStep);
end;


procedure TData.CurrentLevel(input: variant);
// ������� ������� �����/���������
begin
    CurrLevel := input;
    CurrStep := 1;
    MaxStep := CurrLevel * 5;

    if CurrLevel = 1 then AddEvent(phrases[PHRASE_DUNGEON_ENTER][CurrLang]);
end;


{PRIVATE}

procedure TData.SetAutoATK(count: variant);
begin
    AutoATKCount := count;
end;

procedure TData.SetBreak(name: string);
begin
    /// ���� ���� ��� ���� - ������
    if Pos(name, Breaks) <> 0 then exit;

    if Length(Breaks) > 0
    then Breaks := Breaks + ',' + name
    else Breaks := name;
end;

procedure TData.SetCreature(name, params: string; items: string = ''; loot: string = '');
var
    Creature: ISuperObject;
begin
    if not Objects.TryGetValue('Creature', Creature)
    then Objects.Add('Creature', SO());

    Creature := Objects['Creature'];

    Creature.O[ O_PARAMS ] := SO(params);
    Creature.S[ S_NAME ]   := name;
    Creature.O[ O_ITEMS ]  := SO(items);
    Creature.O[ O_LOOT ]   := SO(loot);
    Creature.O[ O_EVENTS ] := SO('{"OnAttack":"DoDamageToPlayer(GetMonsterAttr(ATK));"}');

    Objects['Creature'] := Creature;
end;

procedure TData.SetCreatureScript(event, scr: string);
begin
    Objects['Creature'].O[ O_EVENTS ] := SO('{"'+event+'":"'+scr+'"}');
end;

procedure TData.AddFloorEvent(text: string);
begin
    if Trim(FloorEvent) <> ''
    then FloorEvent := text + ifthen(FloorEvent <> '', sLineBreak, '') + FloorEvent
    else FloorEvent := text;
end;

procedure TData.AddThinkEvent(text: string);
begin
    ThinkEvent := text + ifthen(ThinkEvent <> '', sLineBreak, '') + ThinkEvent;
end;

procedure TData.SetLang(lang: string);
begin
    CurrLang := 0;

    if UpperCase(lang) = 'ENG' then CurrLang := 0;
    if UpperCase(lang) = 'RU' then CurrLang := 1;
end;

procedure TData.SetNextTarget;
begin
    /// ��������� � ���������, ���� ����
    if CurrTargetIndex < High(targets)
    then Inc(CurrTargetIndex);
end;

procedure TData.SetPlayerAutoBuff(name, count: variant);
begin
    Objects['Player'].I[ O_AUTOBUFFS + '.' + name ] := Objects['Player'].I[ O_AUTOBUFFS + '.' + name ] + count;
end;

procedure TData.SetPlayerBuff(name, count: variant);
begin
    Objects['Player'].I[ O_BUFFS + '.' + name ] := Objects['Player'].I[ O_BUFFS + '.' + name ] + count;
end;

procedure TData.SetPlayerRes(name, count: variant);
begin
    Objects['Player'].I[ O_LOOT + '.' + name ] := Objects['Player'].I[ O_LOOT + '.' + name ] + count;
end;

procedure TData.SetPlayerScript(event, scr: string);
begin
    Objects['Player'].S[ O_EVENTS + '.' + event] := scr;
end;

procedure TData.SetVar(name, value: string);
begin
    Variables.AddOrSetValue(Trim(name), Trim(value));
end;

function TData.GetVar(name: string): string;
begin
    Variables.TryGetValue(name, result);
end;

procedure TData.UpSkill(name: string);
var
    i: integer;
    lvl, cost: integer;
begin
    for I := 0 to High(skills) do
    if skills[i].name = name then
    begin
        // �������� ������� ������� ����� � ��������� �� ��������� �����
        lvl := StrToIntDef(GetSkillLvl(name), 0);
        cost := StrToInt(NeedExp(lvl));

        // ���� � ������ ������� ���� - ���������
        if StrToIntDef( GetPlayerAttr('EXP'), 0) >= cost then
        begin

            Objects['Player'].I[ O_SKILLS + '.' + name ] := Objects['Player'].I[ O_SKILLS + '.' + name ] + 1;

            ChangePlayerParam('EXP', IntToStr(-cost));

            AddEvent(Format(phrases[PHRASE_SKILL_UP][CurrLang], [name, lvl+1]));
        end else
            AddEvent(Format(phrases[PHRASE_SKILL_OVERUP][CurrLang], [name, cost]));
    end;
end;

procedure TData.UseItem(name: string);
var
    count: integer;
    i: integer;
begin

    if not Assigned(Objects['Player'].O[ O_ITEMS + '.' + name ]) or (Objects['Player'].I[ O_ITEMS + '.' + name ] <= 0) then exit;

    /// ��������� (��������� ����������� ������ �������)
    for I := 0 to High(items) do
        if items[i].name = name then
        Script.Exec( items[i].script );

    ChangePlayerItemCount(name, -1);
end;

procedure TData.UseSkill(name: string);
var
    i: integer;
    lvl, cost: integer;
begin
    for I := 0 to High(skills) do
    if skills[i].name = name then
    begin
        // �������� ������� ������� ����� � ��������� �� ��������� �����
        lvl := StrToIntDef(GetSkillLvl(name), 0);
        cost := skills[i].cost * lvl;

        // ���� � ������ ������� ���� - ���������
        if StrToIntDef( GetPlayerAttr('MP'), 0) >= cost then
        begin
            Script.Exec( skills[i].script );
            ChangePlayerParam('MP', IntToStr(-cost));
        end else
            AddEvent(Format(phrases[PHRASE_SKILL_OVERCOST][CurrLang], [name, cost]));
    end;
end;

procedure TData.ChangePlayerItemCount(name, delta: variant);
begin
//    if not Assigned( Player.O[ O_ITEMS + '.' + name ]) or ( Player.I[ O_ITEMS + '.' + name ] <= 0 ) then exit;

    Objects['Player'].I[ O_ITEMS + '.' + name ] := Objects['Player'].I[ O_ITEMS + '.' + name ] + delta;

    if Objects['Player'].I[ O_ITEMS + '.' + name ] <= 0 then Objects['Player'].Delete( O_ITEMS + '.' + name);
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
    exp := Objects['Player'].I[ O_PARAMS + '.EXP' ];
    need := StrToInt(NeedExp( Objects['Player'].I[ O_PARAMS + '.LVL' ] ));
    result := ifthen( exp >= need, '!', '');
end;

procedure TData.AllowMode(name, value: variant);
begin
    AllowModes.I[name] := value;
end;

procedure TData.AllowTool(name: string);
var
    i : integer;
begin
    for I := 0 to High(arrTools) do
    if AnsiUpperCase(arrTools[i].name) = AnsiUpperCase(name) then
    begin
        arrTools[i].isAllow := true;
        AllowMode('Tools', 1);
    end;
end;

function TData.NeedExp(lvl: variant): string;
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

function TData.NeedToolUpgrade(capt: string): string;
begin
    result := IntToStr(StrToInt(NeedExp(GetToolAttr(capt,'lvl'))) * 100);
end;

procedure TData.ChangeAutoATK(delta: variant);
begin
    AutoATKCount := AutoATKCount + delta;
end;

function TData.ChangeCreatureParam(name, delta: variant): string;
begin
    result := ChangeParamValue(Objects['Creature'], name, delta);
end;

function TData.ChangeParamValue(creature: ISuperObject; param: string; delta: integer): string;
var
    val: integer;
begin
    if Assigned(creature.O[ O_PARAMS + '.' + param ])
    then val := creature.O[ O_PARAMS + '.' + param ].AsInteger
    else val := 0;

    val := val + delta;

    /// ���������� �������� ������������ ���������
    if val < 0
    then result := IntToStr(delta + val)
    else result := IntToStr(delta);

    creature.I[ O_PARAMS + '.' + param ] := val;
end;


function TData.ChangePlayerParam(name, delta: variant): string;
// ����� ��������� ��������� ������ �� ��������
begin
    result := ChangeParamValue(Objects['Player'], name, delta);
end;

procedure TData.CheckStatus;
// ����� ��������� ��������� �������� ������� ������
var
    HP, EXPbuff: integer;
    playerLVL : integer;

    Player: ISuperObject;
    Creature: ISuperObject;
begin

    Player := Objects['Player'];
    Creature := Objects['Creature'];

    // �������� ��������� ������
    if Player.I[ O_PARAMS + '.HP' ] <= 0 then
    begin
        AddEvent(phrases[PHRASE_KILLED_BY][CurrLang]+ Creature.S[ S_NAME ] +'!');

        // ������������ �� ������ �������
        CurrentLevel(1);
        // ������� ��������
        InitCreatures();

        // ����� ������
        HP := Player.I[ O_PARAMS + '.LVL' ] * 100 + StrToIntDef(Variables[LIFEAMULET_LVL],0) * 100;
        Player.I[ O_PARAMS + '.HP' ] := HP;
        /// ������� ������ ������� �����

        Objects['Player'] := Player;
        Player := nil;
        //        exit;
    end;

    // �������� ��������� �������� �������
    if Creature.I[ O_PARAMS + '.HP' ] <= 0 then
    begin

        // ��������� ���������� ������
        Script.Exec( GetEventScript(Creature, 'OnDeath') );

        // ����� �������� ����
        // �������, ���� �� ���� �� ����
        EXPbuff := Draw( Player, O_BUFFS+'.EXP', 1 );

        ChangeParamValue(Player, 'EXP', CurrLevel + EXPbuff);

        if EXPbuff = 0
        then AddEvent(Format(phrases[PHRASE_MONSTER_KILLED][CurrLang],[Creature.S[S_NAME], IntToStr(CurrLevel)]))
        else AddEvent(Format(phrases[PHRASE_MONSTER_KILLED][CurrLang],[Creature.S[S_NAME], IntToStr(CurrLevel) + ' [+'+IntToStr(EXPbuff)+']']));

        // ����� �������� �������� � ���
        Loot(Player, Creature, O_ITEMS);

        Loot(Player, Creature, O_LOOT);

        Objects['Player'] := Player;
        Player := nil;

        // ��������� �� ����������� ��������
        if   AllowLevelUp <> ''
        then LevelUpPlayer;

        // ��������� � ���������� �������
        Inc(CurrStep);
        InitCreatures();
    end;


    // �������� �� ��������� ������
    if CurrStep > MaxStep then
    begin
        // ��������� �� ����� ������� ����������
        inc(CurrLevel);
        CurrentLevel(CurrLevel);
        // ������� ����� ����� ��������
        InitCreatures();
        AddEvent(Format(phrases[PHRASE_TO_NEXT_FLOOR][CurrLang], [CurrLevel]));
    end;

    // �������� �� ���������� ����
    if CurrLevel >= targets[CurrTargetIndex].level then
    begin
        /// ��������� ������ ���������� ����
        Script.Exec( targets[CurrTargetIndex].script );

        /// ������� �� ��������� ���� ������ ��� ������ ������� ����,
        /// ��������� ��� ����� ����� ������������ ���������� �������
    end;

    Player := nil;
    Creature := nil;

end;


procedure TData.InitItemsCraftCost;
/// ������� ������� ���������. � ������ ���� - ������
/// ������������� �� �������� ��������� � ��������
var
    i
   ,cost    // �������� ���������� ��������� �������� � ��������
   ,part     // �������� ��������� ��������� �������� ������������� ����������
   ,resCount // ���������� ���������� �������
            : integer;
    craft   // ������ ����������� �������
   ,resName
   ,comma
            : string;
    res : TRes;
begin

    for I := 0 to High(items) do
    begin
        if items[i].cost = 0 then Continue;

        /// �������� ����� ���������
        cost := items[i].cost;

        craft := '';
        comma := '';

        /// ���� �� ����������� ��� ���������
        while cost > 0 do
        begin

            part := Random(items[i].cost+1);  // �������� �����, ������� ����� ������������

            part := Min(part, cost);           // �������������, ���� ������ ������������ ������ �������

            resName := GetRandResName;
                                               // �������� ��� ���������� ������� (������������� ������!)

            res := GetResByName(resName);      // �������� ������ �������

            resCount := part div res.cost;
            resCount := Max(1, resCount);      // ���� ������� �� �������, ����������� ���� �������

            craft := craft + comma + resName + '=' + IntToStr(resCount);
            comma := ',';

            cost := cost - part;               // ��������� ��������������� �����
        end;

        items[i].craft := craft;

    end;

end;

function TData.Draw(var obj: ISuperObject; name: string; count: variant): integer;
begin
    result := 0;
    if not Assigned(obj.O[name]) then exit;

    result := obj.I[name];

    if obj.I[name] < 0 then
    obj.I[name] := obj.I[name] + count;

    if obj.I[name] > 0 then
    obj.I[name] := obj.I[name] - count;
end;



constructor TData.Create;
begin
   inherited;
   CurrStep := 1;
   CurrLevel := -1;
   Script := TScriptDrive.Create;
   parser := TStringList.Create;
   Variables := TDictionary<String,String>.Create();
   Objects := TDictionary<String,ISuperObject>.Create();

   CurrTargetIndex := 0;
   CurrLang := 1;

   AllowModes := SO();
end;

destructor TData.Destroy;
begin
    Objects.Free;
    Variables.Free;
    parser.Free;
    Script.Free;
    inherited;
end;





initialization
   Data := TData.Create;


finalization
   Data.Free;

end.
