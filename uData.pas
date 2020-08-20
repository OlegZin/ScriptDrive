unit uData;

interface

uses
    uTypes, uScriptDrive, uThinkModeData, uFloors, uTargets, uTools, superobject,
    System.SysUtils, Generics.Collections, Vcl.Dialogs, Classes, Math, StrUtils;

type

    TData = class
    private
        Player : ISuperObject;
        Creature: ISuperObject;
        Variables: TDictionary<String,String>;

        CurrLevel: integer;        // текущий проходимый уровень
        CurrStep: integer;        // текущий проходимый шаг на уровень
        MaxStep: integer;        // всего шагов на уровне уровень

        CurrTargetIndex: integer;  // актуальный элемент массива целей

        CurrLang: integer;         // текущий язык

        EventText: string;  // текстовые сообщения для режима Tower
        ThinkEvent: string; // текстовые сообщения для режима Think
        FloorEvent: string; // текстовые сообщения для режима Floor

        Breaks: String;  /// набор флагов с именами режимов, для которых произошли события
        ///    требкующие прерывания автодействий
        ///    например, выставлен флаг Tower, поскольку достигнут целевой этаж

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

        procedure InitGame;
        procedure InitPlayer;
        procedure InitCreatures;
        procedure InitItemsCraftCost;

        function CurrentStep: string;
        function StepCount: string;

        procedure CheckStatus;  // проверка игрового сатауса и отыгрыш игровой логики
        procedure CurrentLevel(input: variant);
        function GetCurrentLevel: string;

        procedure SetNextTarget;

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

        procedure SetPlayerRes(name, count: variant);

        function GetRandItemName: string;
        function GetRandResName: string;

        function ProcessAuto: string;
        // вызывается для процессинга автоэффектов, например автобонусов

        function GetAllowModes: string;
        procedure AllowMode(name, value: variant);
        // добавляет в массив доступных игроку возможностей новую

        procedure SetCreature(name, params: string; items: string = ''; loot: string = '');

        procedure SetLang(lang: string);
        function GetLang: string;
        function GetInLang(text: string; lang: string = ''): string;
                             /// получает мультиязычную строку и возвращает
                             /// в текущем или указанном языке

        function GetSkillLvl(name: string): string;
        function GetPlayerSkills: string;

        procedure SetBreak(name: string);  // флаги события остановки автодействий для различных режимов
        function GetBreaks: string; // получение списка флаго текущих прерываний и их очистка



        function GetThinks: string;
        procedure ProcessThinks(caption, delta: variant);
        procedure AddThinkEvent(text: string);
        function GetThinkEvents: string;
        procedure OpenThink(name: string);

        function GetGameScripts: string;

        function GetTrashCount: string; // количество мусора на текущем этаже
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
        function Draw(obj: ISuperObject; count: variant): integer;

    private
        parser: TStringList;
        Script : TScriptDrive;

        function ChangeParamValue(creature: ISuperObject; param: string; delta: integer): string;

        procedure SetPlayer(name, params, skills: string; items: string = ''; loot: string = '');

        function GetEventScript(creature: ISuperObject; name: string): string;
        procedure SetEventScript(creature: TCreature; name, script: string);
        procedure AddEventScript(creature: TCreature; name, script: string);
        procedure RemoveEventScript(creature: TCreature; name, script: string);

        function GetResByName(name: string): TRes;
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

procedure TData.InitGame;
begin
    Script.Exec('SetVar('+SHOVEL_LVL+    ', 1);');
    Script.Exec('SetVar('+PICK_LVL+      ', 1);');
    Script.Exec('SetVar('+AXE_LVL+       ', 1);');
    Script.Exec('SetVar('+KEY_LVL+       ', 1);');
    Script.Exec('SetVar('+SWORD_LVL+     ', 0);');
    Script.Exec('SetVar('+TIMESAND_LVL+  ', 0);');
    Script.Exec('SetVar('+LIFEAMULET_LVL+', 0);');
    Script.Exec('SetVar('+LEGGINGS_LVL+  ', 0);');

    InitItemsCraftCost;
end;


procedure TData.InitPlayer;
/// устанавливаем стартовые параметры игрока
var
    i: integer;
    skl : ISuperObject;
begin

    /// имена скилов берем из массива, поскольку, изначалоно все они у игрока есть
    skl := SO();

    for I := 0 to High(skills) do
          skl.I[skills[i].name] := 0;

    Player.O['params'] := SO('{"LVL":1, "HP":100, "MP":20, "ATK":5, "DEF":0, "REG":1, "EXP":0}');
    Player.O['skills'] := skl;
    Player.O['items'] := SO('{"Gold":100000}');
    Player.O['buffs'] := SO();
    Player.O['autoBuffs'] := SO();
    Player.O['loot'] := SO();
    Player.O['events'] := SO('{"OnAttack":"DoDamageToCreature(GetPlayerAttr(ATK));"}');

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
    result := AllowModes;
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
    result := Creature['name'].AsString + ': ' + Creature['params'].AsString;
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

    if Assigned(creature.O['events.'+name])
    then result := creature.O['events.'+name].AsString;
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
    result := Player.O['params.'+name].AsString;
end;

function TData.GetPlayerBuffs: string;
begin
    result := Player.O['AutoBuffs'].AsString;
end;

function TData.GetPlayerInfo: string;
var
    resultList: string;
    tmp : ISuperObject;
    item : TSuperAvlEntry;
begin
    resultList := '';

    tmp := Player.O['params'];

    for item in Player.O['buffs'].AsObject do
        tmp.S[item.Name] := tmp.S[item.Name] + '[' + item.Value.AsString + ']';

    result := tmp.AsJSon();
end;

function TData.GetPlayerItemCount(name: variant): string;
begin
    result := Player.O['items.'+name].AsString;
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
    result := Creature.O['params.'+name].AsString;
end;

function TData.GetPlayerItems: string;
begin
    result := Player.O['items'].AsJSon();
end;

function TData.GetPlayerLoot: string;
begin
    result := Player.O['loot'].AsJSon();
end;

function TData.GetPlayerSkills: string;
begin
    result := Player.O['skills'].AsJSon();
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
    /// при первом обращении получаем сумму всей редкости ресурсов
    if resSummRarity = 0 then
    for i := 0 to High(arrRes) do
        resSummRarity := resSummRarity + arrRes[i].rarity;

    /// получаем случайное число, указывающее на один из ресурсов
    val := Random( resSummRarity + 1);

    /// перебираем ресурсы и получаем один из них. с учетом редкости!
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
    result := Player.O['skills.'+name].AsString;
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
        /// если эдемент доступен и еще не исследован
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
/// получаем список доступных инструментов
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
// формирование пула
var
    i, count, lootCount: integer;
    itm, lt: string;
begin

        if CurrStep < MaxStep then
        begin
            /// золото
            Inventory.Clear;
            Inventory.SetItemCount( items[I_GOLD].name, Random( CurrLevel*2 ) + CurrLevel );
            itm := Inventory.Get;

            /// ресурсы (шанс на один вид)
            lootCount := 1;//Random(CurrLevel div 2);
            if lootCount > 0 then
            begin
                Inventory.Clear;
                Inventory.SetItemCount( GetRandResName, lootCount );
                lt := Inventory.Get;
            end;

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
            // золото
            Inventory.Clear;
            Inventory.SetItemCount( items[I_GOLD].name, Random( CurrLevel*5 ) + CurrLevel*2 );
            // возможно, один предмет
            if Random(1) > 0 Then Inventory.SetItemCount( items[Random(Length(items))].name, 1 );
            itm := Inventory.Get;

            /// ресурсы (шанс на два вида)
            Inventory.Clear;

            lootCount := Random( Random( CurrLevel ) );
            if lootCount > 0
            then Inventory.SetItemCount( GetRandResName, lootCount );

            lootCount := Random( Random( CurrLevel ) );
            if lootCount > 0
            then Inventory.SetItemCount( GetRandResName, lootCount );

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



procedure TData.LevelUpPlayer;
/// поднятие уровня игрока
var
    CurrLvl: integer;
    DEF: integer;
begin
    CurrLvl := Player.O['params.LVL'].AsInteger;
    DEF := Player.O['params.DEF'].AsInteger;

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
    count, regen : integer;
    item : TSuperAvlEntry;
begin
    result := '';

    if Player.O['AutoBuffs'].AsArray.Length = 0 then exit;

    // считаем силу регена
    // базовый параметр
    regen := Player.O['params.REG'].AsInteger;

    // бонусное значение
    if   Assigned(Player.O['buffs.REG']) and (Player.O['buffs.REG'].AsInteger <> 0)
    then regen := regen + Draw(Player.O['buffs.REG'], 1);

    ///
    for item in Player.O['AutoBuffs'].AsObject do
    begin
        // списываем значение регена с автобафа, получаем фактически списанное число
        count := Draw( Player.O['AutoBuffs.'+item.Name], regen );

        // в случае, когда реген отрицательный (эффект яда, например)
        // меняем знак регена, чтобы списать с игрока
        if Player.O['AutoBuffs.'+item.Name].AsInteger < 0
        then regen := -regen;

        /// если реген еще остался
        if count <> 0 then
        begin
            // меняем параметр игрока и делаем отметку, что изменения есть
            ChangeParamValue( Player, item.Name, regen );
            result := '+';
        end;
    end;

    ///  если были изменения, проверяем статус игры. например, игрок мог потерять все здоровье
    ///  и это нужно обыграть
    if result <> '' then CheckStatus;
end;


function TData.ProcessFloorObject(id: variant): string;
/// снимаем количество с объекта и если нулевое - исполняем скрипр
var
    item: TTrash;
    pars: TStringList;
    capt: string;
    delta: integer;
begin
    // пустое возвращаемое значение уничтожит(скроет) объект в интерфейсе уровня
    result := '';

    if not arrFloors[CurrLevel].Trash.TryGetValue(id, item) then exit;

    pars := TStringList.Create;
    pars.StrictDelimiter := true;

    /// получаем короткую ссылку на объект на этаже
    item := arrFloors[CurrLevel].Trash[Integer(id)];

    delta := 1;

    // если объект мусор - лопата дает эффект к скорости раскапывания
    if arrFloors[CurrLevel].Trash[Integer(id)].name = 'Trash'
    then
        delta := StrToIntDef(Script.Exec('GetVar('+SHOVEL_LVL+');'), 1);

    // если объект мусор - лопата дает эффект к скорости раскапывания
    if (arrFloors[CurrLevel].Trash[Integer(id)].name = 'StoneBlockage') or
       (arrFloors[CurrLevel].Trash[Integer(id)].name = 'WoodBlockage')
    then
        delta := StrToIntDef(Script.Exec('GetVar('+PICK_LVL+');'), 1);

    // если объект ящик - топор дает эффект к скорости разламывания
    if arrFloors[CurrLevel].Trash[Integer(id)].name = 'Box'
    then
        delta := StrToIntDef(Script.Exec('GetVar('+AXE_LVL+');'), 1);

    // если объект сундку - отмычки дают эффект к скорости открытия
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
//    scr := GetEventScript( Creature, 'OnAttack' );
    if scr <> '' then Script.Exec( scr );
end;


procedure TData.DoDamageToCreature(input: string);
// нанесение урона текущему существу
var
    CreatureHP: integer;
    CreatureDEF: integer;
    PlayerATK: integer;
    DMG, BLOCK : integer;
    ATKbuff: integer;
    bustedBySword: integer;
begin

    ATKbuff := Draw( Player.O['buffs.ATK'], 1 );

    PlayerATK   := Random( StrToIntDef(input, 0) + ATKbuff );

    /// применяем эффект Меча, но не выше максимальной атаки
    bustedBySword := Min(StrToIntDef(Variables[SWORD_LVL], 0), Player.O['params.ATK'].AsInteger);
    PlayerATK   := Max(bustedBySword, PlayerATK);

    CreatureHP  := Creature.O['params.HP'].AsInteger;
    CreatureDEF := Creature.O['params.DEF'].AsInteger;

    BLOCK := Round(PlayerATK * ((CreatureDEF / 10) / 100));  // 1 DEF = -0.1% dmg
    DMG := PlayerATK - BLOCK;  // 1 DEF = -0.1% dmg

    CreatureHP  := CreatureHP - DMG;

    Creature.I['param.HP'] := CreatureHP;

    if BLOCK > 0
    then AddEvent(Format(phrases[PHRASE_PLAYER_STRIKE_BLOCK][CurrLang], [DMG, BLOCK]))
    else AddEvent(Format(phrases[PHRASE_PLAYER_STRIKE][CurrLang], [DMG]))
end;

procedure TData.DoDamageToPlayer(input: string);
// нанесение урона игроку
var
    PlayerHP: integer;
    PlayerDEF: integer;
    CreatureATK: integer;
    DMG, BLOCK : integer;
    DEFbuff: integer;
    ATKbuff: integer;
begin

    ATKbuff := Draw( Creature.O['buffs.ATK'], 1 );

    DEFbuff := Draw( Player.O['buffs.DEF'], 1 );

    CreatureATK := Random( StrToIntDef(input, 0) + ATKbuff );
    PlayerHP  := Player.O['param.HP'].AsInteger;
    PlayerDEF  := Player.O['param.DEF'].AsInteger +  + DEFbuff;

    BLOCK := Round(CreatureATK * (( PlayerDEF/10 ) / 100));
    DMG := CreatureATK - BLOCK;  // 1 DEF = -0.1% dmg

    PlayerHP  := PlayerHP - DMG;

    Player.I['param.HP'] := PlayerHP;

    if BLOCK > 0
    then AddEvent(Format(phrases[PHRASE_MONSTER_STRIKE_BLOCK][CurrLang], [DMG, BLOCK]))
    else AddEvent(Format(phrases[PHRASE_MONSTER_STRIKE][CurrLang], [DMG]));
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

procedure TData.SetBreak(name: string);
begin
    /// если флаг уже есть - выходи
    if Pos(name, Breaks) <> 0 then exit;

    if Length(Breaks) > 0
    then Breaks := Breaks + ',' + name
    else Breaks := name;
end;

procedure TData.SetCreature(name, params: string; items: string = ''; loot: string = '');
begin
    Creature.O['params'] := SO(params);
    Creature.S['name'] := name;
    Creature.O['items'] := SO(items);
    Creature.O['loot'] := SO(loot);
    Creature.O['events'] := SO('{"OnAttack":"DoDamageToPlayer(GetMonsterAttr(ATK));"}');
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
    /// переходим к следующей, если есть
    if CurrTargetIndex < High(targets)
    then Inc(CurrTargetIndex);
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

procedure TData.SetPlayerRes(name, count: variant);
begin
    Inventory.Fill(Player.Loot);
    Inventory.ChangeItemCount(name, count);
    Player.Loot := Inventory.Get;
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
    result := ChangeParamValue(Creature, name, delta);
end;

function TData.ChangeParamValue(creature: ISuperObject; param: string; delta: integer): string;
var
    val: integer;
begin
    val := creature.O['params.'+param].AsInteger;
    val := val + delta;

    /// возвращаем величену фактического изменения
    if val < 0
    then result := IntToStr(delta + val)
    else result := IntToStr(delta);

    creature.O['params.'+param].AsInteger := val;
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
        SetParamValue(Player, 'HP', IntToStr(playerLVL * 100 + StrToIntDef(Variables[LIFEAMULET_LVL],0) * 100));
        /// включая эффект амулета жизни
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

        /// переход на следующую цель задает сам скрипт текущей цели,
        /// поскольку для этого может понадобиться выполнение условий
    end;
end;


procedure TData.InitItemsCraftCost;
/// генерим рецепты предметов. в каждой игре - разные
/// отталкиваемся от условной стоимости в ресурсах
var
    i
   ,cost    // условная остаточная стоимость предмета в ресурсах
   ,part     // условная суммарная стоимость текущего генерируемого компонента
   ,resCount // количество требуемого ресурса
            : integer;
    craft   // строка собираемого рецепта
   ,resName
   ,comma
            : string;
    res : TRes;
begin

    for I := 0 to High(items) do
    begin
        if items[i].cost = 0 then Continue;

        /// получаем общую стоимость
        cost := items[i].cost;

        craft := '';
        comma := '';

        /// пока не распределна вся стоимость
        while cost > 0 do
        begin

            part := Random(items[i].cost+1);  // получаем кусок, который нужно распределить

            part := Min(part, cost);           // выравниваемся, если выпало распределить больше остатка

            resName := GetRandResName;
                                               // получаем имя случайного ресурса (мультиязычная строка!)

            res := GetResByName(resName);      // получаем данные ресурса

            resCount := part div res.cost;
            resCount := Max(1, resCount);      // если остатак не хватает, прописывает одну единицу

            craft := craft + comma + resName + '=' + IntToStr(resCount);
            comma := ',';

            cost := cost - part;               // списываем израсходованную часть
        end;

        items[i].craft := craft;

    end;

end;

function TData.Draw(obj: ISuperObject; count: variant): integer;
begin
    result := 0;
    if not Assigned(obj) then exit;

    result := obj.AsInteger;

    if obj.AsInteger < 0 then
    obj.AsInteger := obj.AsInteger + count;

    if obj.AsInteger > 0 then
    obj.AsInteger := obj.AsInteger - count;
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

   Player := SO();
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

//    has := Max( 0, has + count ); // применяем изменение, но результат не ниже ноля
    has := has + count;
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
        Data.AddEvent(Format(phrases[PHRASE_GET_LOOT][Data.CurrLang],[loot.Values[ loot.Names[i] ], loot.Names[i]]))
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
