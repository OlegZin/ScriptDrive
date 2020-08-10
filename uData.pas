unit uData;

interface

uses
    uTypes, uScriptDrive,
    System.SysUtils, Generics.Collections, Vcl.Dialogs, Classes, Math, StrUtils;

type

    TData = class
    private
        Player : TCreature;
        Creature: TCreature;
        Variables: TDictionary<String,String>;

        CurrLevel: integer;        // текущий проходимый уровень
        CurrStep: integer;        // текущий проходимый шаг на уровень
        MaxStep: integer;        // всего шагов на уровне уровень

        CurrTargetIndex: integer;  // актуальный элемент массива целей

        CurrLang: integer;         // текущий язык

        EventText: string;

        AllowModes: string;
        /// основной управляющий игрой массив с флагами доступных игроку игровых возможностей
        /// используется повсеместно для определелния доступа к тем или иным возможностям.
        /// перичем, каждая возможность имеет уровень развития, что может использоваться для
        /// ее настройки. Например, количество и крутизна доступных рецептов в крафте.

        AutoATKCount: integer;
    public


        constructor Create;
        destructor Destroy;

        function GetAutoATK: string;
        procedure SetAutoATK(count: variant);
        procedure ChangeAutoATK(delta: variant);

        procedure PlayerAttack;   // команда игроку атаковать текущую цель
        procedure CreatureAttack; // команда монстру атаковать

        procedure DoDamageToCreature(input: string); // нанесение урона текущему существу
        procedure DoDamageToPlayer(input: string); // нанесение урона игроку

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
        // добавление бонуса в Player.Buffs

        procedure SetPlayerAutoBuff(name, count: variant);
        // добавление бонуса в Player.Buffs

        procedure SetPlayerScript(event, scr: string);
        procedure SetCreatureScript(event, scr: string);

        procedure InitPlayer;
        procedure InitCreatures;

        function CurrentStep: string;
        function StepCount: string;

        procedure CheckStatus;  // проверка игрового сатауса и отыгрыш игровой логики
        procedure CurrentLevel(input: variant);
        function GetCurrentLevel: string;

        function GetEvents: string;

        procedure LevelUpPlayer;
        function AllowLevelUp: string;
        // проверка на достаточность текущего опыта для поднятия уровня

        function NeedExp(lvl: variant): string;
        // возвращает количество опыта для поднятия уровня

        function ChangePlayerParam(name, delta: variant): string;
        // метод изменения параметра игрока
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
        /// получение количества в указанном списке

        function GetRandItemName: string;

        function ProcessAuto: string;
        // вызывается для процессинга автоэффектов, например автобонусов

        function GetAllowModes: string;
        procedure AllowMode(name, value: variant);
        // добавляет в массив доступных игроку возможностей новую

        procedure SetCreature(name, params: string; items: string = ''; loot: string = '');

        procedure SetLang(lang: string);
        function GetLang: string;

        function GetSkillLvl(name: string): string;
        function GetPlayerSkills: string;
    private
        parser: TStringList;
        Script : TScriptDrive;

        function GetParamValue(creature: TCreature; param: string): string;
        procedure SetParamValue(creature: TCreature; param, value: string);
        function ChangeParamValue(creature: TCreature; param: string; delta: integer): string;

        procedure SetPlayer(name, params, skills: string; items: string = ''; loot: string = '');

        function GetEventScript(creature: TCreature; name: string): string;
        procedure SetEventScript(creature: TCreature; name, script: string);
        procedure AddEventScript(creature: TCreature; name, script: string);
        procedure RemoveEventScript(creature: TCreature; name, script: string);
    end;

    /// класс-менеджер для манипуляций с содержимым инвентаря
    TInventory = class
    private
        items: TStringList;   // строка с содержимым
    public
        constructor Create;
        destructor Destroy;

        procedure Fill(inv: string);
        procedure Clear;
        function Get: string;
        function Draw(name, count: variant): integer;
        /// возвращает текущее значение указанного элемента и списывает с него count

        procedure SetItemCount(name: string; count: integer);
        // задает указанное количество пердметов в инвентаре
        // добавляет предмет, если отсутствует при значении > 0
        // удаляет предмет, при значении <= 0

        procedure ChangeItemCount(name: string; count: integer);
        // изменяет количество на указанную дельту (+/-)
        // добавляет предмет, если отсутствует при полученном количестве > 0
        // удаляет предмет, при полученном значении <= 0

        procedure RemoveItem(name: string);
        // удаляет все объекты с указанным именем

        function GetItemCount(name: string): integer;
        // возвращает количество имеющихся предметов, 0 = отсутствуют

        procedure Loot(lootInv: string);
        // получает строку инвентаря и добавляет все найденные предметы в "свой"
    end;

Var
    Data : TData;

implementation

{ TData }

var
   Inventory : TInventory;

{PUBLIC // Script allow}

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
    result := AllowModes;
end;

function TData.GetAutoATK: string;
begin
    result := IntToStr(AutoATKCount);
end;

function TData.GetCurrCreatureInfo: string;
begin
    result := Creature.Name + ': ' + Creature.Params;
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

function TData.GetEventScript(creature: TCreature; name: string): string;
var
    pars: TStringList;
begin
    result := '';

    pars := TStringList.Create;
    pars.CommaText := creature.Events;
    if pars.IndexOfName(name) <> -1 then
        result := pars.Values[name];

    pars.Free;
end;

function TData.GetPlayerAttr(name: string): string;
begin
    result := GeAttr(Player, name);
end;

function TData.GetPlayerBuffs: string;
begin
    result := Player.AutoBuffs;
end;

function TData.GetPlayerInfo: string;
var
    count: string;
    i: integer;
    resultList: string;
    parser: TStringList;
begin
    resultList := '';

    parser := TStringList.Create;
    parser.CommaText := Player.Params;

    for i := 0 to parser.Count-1 do
    begin
        count := GetItemCount( Player.Buffs, parser.Names[i]);
        if count <> '0'
        then resultList := resultList + parser[i] + '[' + count + '],'
        else resultList := resultList + parser[i] + ',';
    end;

    parser.Free;

    result := Player.Name + ' ' + resultList;

end;

function TData.GetPlayerItemCount(name: variant): string;
begin
    result := '0';

    parser.CommaText := Player.Items;
    if   parser.IndexOfName(name) <> -1
    then result := parser.Values[name];
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
    result := GeAttr(Creature, name);
end;

function TData.GetPlayerItems: string;
begin
    result := Player.Items;
end;

function TData.GetPlayerLoot: string;
begin
    result := Player.Loot;
end;

function TData.GetPlayerSkills: string;
begin
    result := Player.Skills;
end;

function TData.GetRandItemName: string;
begin
    result := items[Random(Length(items))].name;
end;

function TData.GetSkillLvl(name: string): string;
begin
    result := '0';
    parser.CommaText := Player.Skills;
    if parser.IndexOfName(name) <> -1 then
       result := parser.Values[name];
end;

procedure TData.InitCreatures;
// формирование пула
var
    i, count: integer;
    itm, lt: string;
begin

        if CurrStep < MaxStep then
        begin
            Inventory.Clear;
            Inventory.SetItemCount( items[I_GOLD].name, Random( CurrLevel*2 ) + CurrLevel );
            itm := Inventory.Get;

            Inventory.Clear;
            Inventory.SetItemCount( loot[Random(Length(loot))], 1 );
            lt := Inventory.Get;

            SetCreature(
                Format('%s %s %s', [
                    name1[Random(Length(name1))][CurrLang],
                    name2[Random(Length(name2))][CurrLang],
                    name3[Random(Length(name3))][CurrLang]
                ]),
                Format('HP=%d, ATK=%d, DEF=%d', [
                    Random( CurrLevel*10 ) + CurrLevel*5,
                    Random( CurrLevel*5 )  + CurrLevel*2,
                    Random( CurrLevel*2 )
                ]),
                itm,
                lt
            );

        end;

        /// босс уровня!
        if CurrStep = MaxStep then
        begin
            Inventory.Clear;
            Inventory.SetItemCount( items[I_GOLD].name, Random( CurrLevel*5 ) + CurrLevel*2 );
            Inventory.SetItemCount( items[Random(Length(items))].name, 1 );
            itm := Inventory.Get;

            Inventory.Clear;
            Inventory.SetItemCount( loot[Random(Length(loot))], Random( CurrLevel ) + 1 );
            Inventory.SetItemCount( loot[Random(Length(loot))], Random( CurrLevel ) + 1 );
            lt := Inventory.Get;

            SetCreature(
                Format('[BOSS] %s %s %s', [
                    name1[Random(Length(name1))][CurrLang],
                    name2[Random(Length(name2))][CurrLang],
                    name3[Random(Length(name3))][CurrLang]
                ]),
                Format('HP=%d, ATK=%d, DEF=%d', [
                    Random( CurrLevel*50 ) + CurrLevel*30,
                    Random( CurrLevel*25 )  + CurrLevel*10,
                    Random( CurrLevel*6 )
                ]),
                itm,
                lt
            );
        end;



end;

procedure TData.InitPlayer;
/// устанавливаем стартовые параметры игрока
var
    i: integer;
    s, comma: string;
begin

    /// имена скилов берем из массива, поскольку, изначалоно все они у игрока есть
    comma := '';
    for I := 0 to High(skills) do
    begin
          s := s + comma + skills[i].name + '=0';
          comma := ' ';
    end;

    SetPlayer( 'Player', 'LVL=1, HP=100, MP=20, ATK=5, DEF=0, REG=1, EXP=0', s, 'Gold=100000');
end;

procedure TData.LevelUpPlayer;
/// поднятие уровня игрока
var
    CurrLvl: integer;
    DEF: integer;
begin
    CurrLvl := StrToIntDef( GetParamValue( Player, 'LVL' ), 1);
    DEF := StrToIntDef( GetParamValue( Player, 'DEF' ), 1);

    ChangeParamValue( Player,  'HP', CurrLvl * 100);
    ChangeParamValue( Player,  'MP', CurrLvl * 20);
    ChangeParamValue( Player, 'ATK', CurrLvl );
    ChangeParamValue( Player, 'DEF', 1 );
    ChangeParamValue( Player, 'EXP', -StrToIntDef( NeedExp(CurrLvl), 0));
    ChangeParamValue( Player, 'LVL', 1);

    AddEvent(phrases[PHRASE_LEVEL_UP][CurrLang]);
end;



procedure TData.PlayerAttack;
// команда персонажу атаковать текущую цель
// выполняем скрипт OnAttack
var
    scr: string; // текст скрипта
begin
    scr := GetEventScript( Player, 'OnAttack' );
    if scr <> '' then
        Script.Exec( scr );
end;

function TData.ProcessAuto: string;
var
    i, count, regen : integer;
    prs: TStringList;
begin
    result := '';

    if Player.AutoBuffs = '' then exit;


    prs := TStringList.Create;
    prs.CommaText := Player.AutoBuffs;


    // считаем силу регена
    // базовый параметр
    regen := StrToInt(GetPlayerAttr('REG'));
    // бонусное значение
    Inventory.Fill( Player.Buffs );
    regen := regen + Inventory.Draw('REG', 1);
    Player.Buffs := Inventory.Get;

    /// берем запасы регенерируемых параметров
    Inventory.Fill( Player.AutoBuffs );

    for I := 0 to prs.Count-1 do
    begin
        count := Inventory.Draw( prs.Names[i], regen );
        if count <> 0 then
        begin
            ChangeParamValue( Player, prs.Names[i], regen );
            result := '+';
        end;
    end;

    Player.AutoBuffs := Inventory.Get;

    prs.Free;
end;


procedure TData.RemoveEventScript(creature: TCreature; name, script: string);
/// удаление из скрипта указанного куска
begin
    creature.Events := StringReplace( creature.Events, script, '', [] );
end;

procedure TData.CreatureAttack;
// команда монстру атаковать игрока
// выполняем скрипт OnAttack
var
    scr: string; // текст скрипта
begin
    scr := GetEventScript( Creature, 'OnAttack' );
    if scr <> '' then Script.Exec( scr );
end;

procedure TData.DoDamageToCreature(input: string);
// нанесение урона текущему существу
var
    CreatureHP: integer;
    CreatureDEF: integer;
    PlayerATK: integer;
    DMG : integer;
    ATKbuff: integer;
begin

    Inventory.Fill( Player.Buffs );
    ATKbuff := Inventory.Draw( 'ATK', 1 );
    Player.Buffs := Inventory.Get;

    PlayerATK   := StrToIntDef(input, 0) + ATKbuff;
    CreatureHP  := StrToIntDef( GetParamValue( Creature, 'HP'), 0 );
    CreatureDEF := StrToIntDef( GetParamValue( Creature, 'DEF'), 0 );

//    CreatureDEF := Min(99, CreatureDEF);  // всегда проходит 1% урона

    DMG := Round(PlayerATK - PlayerATK * ((CreatureDEF / 10) / 100));  // 1 DEF = -0.1% dmg

    CreatureHP  := CreatureHP - DMG;

    SetParamValue( Creature, 'HP', IntToStr(CreatureHP) );
end;

procedure TData.DoDamageToPlayer(input: string);
// нанесение урона игроку
var
    PlayerHP: integer;
    PlayerDEF: integer;
    CreatureATK: integer;
    DMG : integer;
    DEFbuff: integer;
begin

    Inventory.Fill( Player.Buffs );
    DEFbuff := Inventory.Draw( 'DEF', 1 );
    Player.Buffs := Inventory.Get;

    CreatureATK := StrToIntDef(input, 0);
    PlayerHP  := StrToIntDef( GetParamValue( Player, 'HP'), 0 );
    PlayerDEF := StrToIntDef( GetParamValue( Player, 'DEF'), 0 ) + DEFbuff;

//    PlayerDEF := Min(99, PlayerDEF);  // всегда проходит 1% урона

    DMG := Round(CreatureATK - CreatureATK * (( PlayerDEF/10 ) / 100));  // 1 DEF = -0.1% dmg

    PlayerHP  := PlayerHP - DMG;

    SetParamValue( Player, 'HP', IntToStr(PlayerHP) );
end;

function TData.CurrentStep: string;
// текущий активный
begin
    result := IntToStr(CurrStep);
end;

function TData.StepCount: string;
// общее количество монстров
begin
    result := IntToStr(MaxStep);
end;

procedure TData.CurrentLevel(input: variant);
// текущий уровень показ/изменение
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

procedure TData.SetCreature(name, params: string; items: string = ''; loot: string = '');
begin
    Creature.Params := params;
    Creature.Name   := name;
    Creature.Items  := items;
    Creature.Loot   := loot;

    Creature.Events := '';
    SetEventScript( Creature, 'OnAttack', 'DoDamageToPlayer(GetMonsterAttr(ATK));');
end;

procedure TData.SetCreatureScript(event, scr: string);
begin
    SetEventScript(Creature, event, scr);
end;

procedure TData.SetEventScript(creature: TCreature; name, script: string);
var
    pars: TStringList;
begin
    pars := TStringList.Create;
    pars.CommaText := creature.Events;

    pars.Values[name] := script;
    creature.Events := pars.CommaText;

    pars.Free;
end;

procedure TData.AddEventScript(creature: TCreature; name, script: string);
var
    pars: TStringList;
begin
    pars := TStringList.Create;
    pars.CommaText := creature.Events;

    /// поскольку на одно событие скрипт может собираться из различных источников (разовых временных и постоянных эффектов)
    /// то новый скрипт дописываем к текущей строке
    pars.Values[name] := pars.Values[name] + script;
    creature.Events := pars.CommaText;

    pars.Free;
end;

procedure TData.SetLang(lang: string);
begin
    CurrLang := 0;

    if UpperCase(lang) = 'ENG' then CurrLang := 0;
    if UpperCase(lang) = 'RU' then CurrLang := 1;
end;

procedure TData.SetPlayer(name, params, skills: string; items: string = ''; loot: string = '');
begin
    if not assigned(Player) then Player := TCreature.Create;

    Player.params := params;
    Player.Skills := skills;
    Player.Name   := name;
    Player.Items  := items;
    Player.Loot   := loot;

    SetEventScript(Player, 'OnAttack', 'DoDamageToCreature(GetPlayerAttr(ATK))')
end;

procedure TData.SetPlayerAutoBuff(name, count: variant);
begin
    Inventory.Fill(Player.AutoBuffs);
    Inventory.ChangeItemCount(name, count);
    Player.AutoBuffs := Inventory.Get;
end;

procedure TData.SetPlayerBuff(name, count: variant);
begin
    Inventory.Fill(Player.Buffs);
    Inventory.ChangeItemCount(name, count);
    Player.Buffs := Inventory.Get;
end;

procedure TData.SetPlayerScript(event, scr: string);
begin
    SetEventScript(Player, event, scr);
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
        // получаем текущий уровень скила и помножаем на стоимость скила
        lvl := StrToIntDef(GetSkillLvl(name), 0);
        cost := StrToInt(NeedExp(lvl));

        // если у игрока хватает маны - выполняем
        if StrToIntDef( GetPlayerAttr('EXP'), 0) >= cost then
        begin

            Inventory.Fill(Player.Skills);
            Inventory.ChangeItemCount(name, 1);
            Player.Skills := Inventory.Get;

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
    /// берем инвентарь игрока
    parser.CommaText := player.Items;

    /// есть ли там искомый объект?
    if pos(name, parser.CommaText) = 0 then exit;

    /// есть ли хоть один, чтобы применить?
    count := StrToIntDef(parser.Values[name], 0);
    if count <= 0 then exit;

    /// применяем (выполняем прописанный скрипт эффекта)
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
        // получаем текущий уровень скила и помножаем на стоимость скила
        lvl := StrToIntDef(GetSkillLvl(name), 0);
        cost := skills[i].cost * lvl;

        // если у игрока хватает маны - выполняем
        if StrToIntDef( GetPlayerAttr('MP'), 0) >= cost then
        begin
            Script.Exec( skills[i].script );
            ChangePlayerParam('MP', IntToStr(-cost));
        end else
            AddEvent(Format(phrases[PHRASE_SKILL_OVERCOST][CurrLang], [name, cost]));
    end;
end;

procedure TData.ChangePlayerItemCount(name, delta: variant);
var
    curr: integer;
begin

    /// списываем единицу из инвентаря
    parser.CommaText := player.Items;

    if parser.IndexOfName(name) <> -1 then
    begin
        curr := StrToInt(parser.Values[name]);
        curr := curr + delta
    end else
        curr := delta;

    /// если все кончилось - убираем упоминание из инвентаря
    if (curr <= 0) and (parser.IndexOfName(name) <> -1) then parser.Delete( parser.IndexOfName(name) );
    if (curr > 0) then parser.Values[name] := IntToStr(curr);

    player.Items := parser.CommaText;
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
/// при добавлении события свежее добавляется в начало для корректного
/// отображения в интерфейсе
begin
    EventText := text + ifthen(EventText <> '', sLineBreak, '') + EventText;
end;

function TData.AllowLevelUp: string;
var
    exp : integer;
    need: integer;
begin
    exp := StrToIntDef( GetParamValue( Player, 'EXP' ), 1);
    need := StrToIntDef( NeedExp(GetParamValue( Player, 'LVL' )), 99999);
    result := ifthen( exp >= need, '!', '');
end;

procedure TData.AllowMode(name, value: variant);
begin
    Inventory.Fill( AllowModes );
    Inventory.SetItemCount( name, value );
    AllowModes := Inventory.Get;
end;

function TData.NeedExp(lvl: variant): string;
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

procedure TData.ChangeAutoATK(delta: variant);
begin
    AutoATKCount := AutoATKCount + delta;
end;

function TData.ChangeCreatureParam(name, delta: variant): string;
begin
    result := ChangeParamValue(Creature, name, delta);
end;

function TData.ChangeParamValue(creature: TCreature; param: string; delta: integer): string;
var
    val: integer;
begin
    parser.CommaText := creature.Params;
    val := StrToIntDef(parser.Values[param], 0);
    val := val + delta;

    /// возвращаем величену фактического изменения
    if val < 0
    then result := IntToStr(delta + val)
    else result := IntToStr(delta);

    parser.Values[param] := IntToStr(val);
    creature.Params := parser.CommaText;
end;


function TData.ChangePlayerParam(name, delta: variant): string;
// метод изменения параметра игрока из скриптов
begin
    result := ChangeParamValue(Player, name, delta);
end;

procedure TData.CheckStatus;
// метод отработки состояния объектов игровой логики
var
    HP, EXPbuff: integer;
    playerLVL : integer;
begin

    // проверка состояния игрока
    HP := StrToIntDef( GetParamValue( Player, 'HP'), 0 );

    if HP <= 0 then
    begin
        AddEvent(phrases[PHRASE_KILLED_BY][CurrLang]+ Creature.Name +'!');

        // возвращаемся на первый уровень
        CurrentLevel(1);
        // генерим монстров
        InitCreatures();

        // лечим игрока
        playerLVL := StrToInt(GetParamValue( Player, 'LVL'));
        SetParamValue(Player, 'HP', IntToStr(playerLVL * 100));
        exit;
    end;

    // проверка состояния текущего монстра
    HP := StrToIntDef( GetParamValue( Creature, 'HP'), 0 );

    if HP <= 0 then
    begin

        // выполняем посмертный скрипт
        Script.Exec( GetEventScript(Creature, 'OnDeath') );

        // игрок получает опыт
        Inventory.Fill( Player.Buffs );
        EXPbuff := Inventory.Draw( 'EXP', 1 );
        Player.Buffs := Inventory.Get;

        ChangeParamValue(Player, 'EXP', CurrLevel + EXPbuff);

        if EXPbuff = 0
        then AddEvent(Format(phrases[PHRASE_MONSTER_KILLED][CurrLang],[Creature.Name, IntToStr(CurrLevel)]))
        else AddEvent(Format(phrases[PHRASE_MONSTER_KILLED][CurrLang],[Creature.Name, IntToStr(CurrLevel) + ' [+'+IntToStr(EXPbuff)+']']));

        // игрок получает предметы и лут
        Inventory.Fill( Player.Items );
        Inventory.Loot( Creature.Items );
        Player.Items := Inventory.Get;

        Inventory.Fill( Player.Loot );
        Inventory.Loot( Creature.Loot );
        Player.Loot := Inventory.Get;

        // проверяем на возможность левелапа
        if   AllowLevelUp <> ''
        then LevelUpPlayer;

        // переходим к следующему монстру
        Inc(CurrStep);
        InitCreatures();
    end;


    // проверка на окончание уровня
    if CurrStep > MaxStep then
    begin
        // переходим на новый уровень подземелья
        inc(CurrLevel);
        CurrentLevel(CurrLevel);
        // генерим новую пачку монстров
        InitCreatures();
        AddEvent(Format(phrases[PHRASE_TO_NEXT_FLOOR][CurrLang], [CurrLevel]));
    end;

    // проверка на достижение цели
    if CurrLevel >= targets[CurrTargetIndex].level then
    begin
        /// выполняем скрипт достижения цели
        Script.Exec( targets[CurrTargetIndex].script );

        /// переходим к следующей, если есть
        if CurrTargetIndex < High(targets)
        then Inc(CurrTargetIndex);
    end;
end;

constructor TData.Create;
begin
   inherited;
   CurrStep := 1;
   CurrLevel := -1;
   Creature := TCreature.Create;
   Script := TScriptDrive.Create;
   parser := TStringList.Create;
   Variables := TDictionary<String,String>.Create();

   CurrTargetIndex := 0;
   CurrLang := 1;
end;

destructor TData.Destroy;
begin
    Variables.Free;
    parser.Free;
    Script.Free;
    Creature.Free;
    inherited;
end;


{ TInventary }

procedure TInventory.ChangeItemCount(name: string; count: integer);
var
    has: integer;
begin

    // если такой предмет уже есть, получаем текущее количество
    if Pos(name, items.CommaText) > 0
    then has := StrToIntDef(items.Values[name], 0)
    else has := 0;

    has := Max( 0, has + count ); // применяем изменение, но результат не ниже ноля
    items.Values[name] := IntToStr(has);

end;

function TInventory.Get: string;
begin
    result := items.CommaText;
end;

function TInventory.GetItemCount(name: string): integer;
begin
    result := 0;

    // если предмет есть в инвентаре
    if   Pos(name, items.CommaText) > 0
    then result := StrToIntDef(items.Values[name], 0);
end;

procedure TInventory.Loot(lootInv: string);
// добавление в текущий установленный инвентарь все, что есть в lootInv инвентаре
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
        Data.AddEvent('Get ' + loot.Values[ loot.Names[i] ] + ' '+ loot.Names[i]);
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

function TInventory.Draw(name, count: variant): integer;
begin
    result := 0;
    if items.IndexOfName(name) = -1 then exit;

    result := StrToIntDef( items.Values[name], 0 );

    if (result - count) > 0
    then items.Values[name] := IntToStr(result - count)
    else items.Delete( items.IndexOfName(name) );
end;

initialization
   Data := TData.Create;
   Inventory := TInventory.Create;


finalization
   Data.Free;
   Inventory.Free;

end.
