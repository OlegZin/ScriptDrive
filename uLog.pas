unit uLog;

interface

uses
    FMX.WebBrowser, Generics.Collections, SysUtils, StrUtils,
    uDocCreater, uConst, superobject;

const
    LOG_LINE = '<div class=%s>%s</div>';

    MESS_NORMAL = 'normal';
    MESS_DANGER = 'danger';
    MESS_NOTE   = 'note';
    MESS_FIGHT  = 'fight';

    EMPTY_HTML =
        '<html>'+
          '<head>'+
            '<meta http-equiv=Content-Type content="text/html; charset=windows-1251">'+
            '<style>'+
              'body{margin:0;padding:10px;border:0;}'+
              'body{ scrollbar-base-color: #fff; scrollbar-track-color: #fff; }'+
              '.think{font-style: italic;}'+
              '.danger{color:red; font-weight: bold;}'+
              '.fight{color:gray;}'+
              '.note{'+
                'padding:20px;margin:20px;'+
                'font-weight:bold;'+
                'line-height:150%;'+
                'background-image:url("data:image/jpeg;base64,#IMAGE_NOTE_BG#")'+
              '}'+

              '.fight{padding:5px;}'+

              '.change_param,.change_item, .change_loot{'+
                'padding:5px; '+
                'padding-left:20px; '+
                'font-weight:bold;'+
                'line-height:150%;'+
              '}'+
              '.change_param{ background-color: #fff8dc; }'+
              '.change_item{ background-color: #f0f8ff; }'+
              '.change_loot{ background-color: #f5f5dc; }'+
              '.allow{'+
                  'padding:20px;'+
                  'background-color: #adff2f;}'+

              '.lvl_up{'+
                'padding-left: 70px;'+
                'display: block;'+
                'height: 50px;'+
                'background:url("data:image/jpeg;base64,#IMAGE_LEVEL#") no-repeat;'+
                'text-weight: bold;'+
                'color: red;'+
                'font-size: 150%;'+
                'background-color: #fff8dc;'+
              '}'+
              '.lvl_up .text{'+
                'position: relative;'+
                'top: 50%;'+
                'transform: translateY(-50%);'+
              '}'+

              '.icon{'+
                'display: inline;'+
                'height: 20px;'+
                'width: 20px;}'+

              '.gold, .icon_gold{background:url("data:image/jpeg;base64,#ICON_GOLD#");}'+
              '.ATK,.icon_sword{background:url("data:image/jpeg;base64,#ICON_SWORD#");}'+
              '.DEF,.icon_shield{background:url("data:image/jpeg;base64,#ICON_SHIELD#");}'+
              '.MDEF,.icon_blueshield{background:url("data:image/jpeg;base64,#ICON_BLUESHIELD#");}'+
              '.HP,.icon_heart{background:url("data:image/jpeg;base64,#ICON_HEART#");}'+
              '.MP,.icon_mana{background:url("data:image/jpeg;base64,#ICON_MANA#");}'+
              '.AutoAction,.icon_auto{background:url("data:image/jpeg;base64,#ICON_AUTO#");}'+
              '.LVL,.icon_level{background:url("data:image/jpeg;base64,#ICON_LEVEL#");}'+
              '.EXP,.icon_exp{background:url("data:image/jpeg;base64,#ICON_EXP#");}'+
              '.icon_fight{background:url("data:image/jpeg;base64,#ICON_FIGHT#");}'+
              '.icon_unlock{background:url("data:image/jpeg;base64,#ICON_UNLOCK#");}'+
              '.icon_monster{background:url("data:image/jpeg;base64,#ICON_MONSTER#");}'+
              '.icon_knight{background:url("data:image/jpeg;base64,#ICON_KNIGHT#");}'+
              '.icon_brain{background:url("data:image/jpeg;base64,#ICON_BRAIN#");}'+

              '.wood,.stone,.herbal,.wheat,.meat,.blood,.bone,.skin,.ore,.essence,'+
              '.potionAuto,.buffREG,.buffEXP,.buffMDEF,.buffDEF,.buffATK,.regenMP,'+
              '.regenHP,.potionexp,.PermanentMDEF,.permanentDEF,.permanentATK,'+
              '.restoreMana,.restoreHealth,'+
              '.icon_chest{background:url("data:image/jpeg;base64,#ICON_CHEST#");}'+
            '</style>'+
          '</head>'+
        '<body onload="window.scrollTo(0,10000)">'+
          '#CONTENT#'+
        '</body>'+
        '</html>';

    ///
    ICON_TEMPLATE = '<div class="%s"></div>';

    /// набор стандартных фраз
    PHRASES_LIST =
    '{'+
        'level_up:{'+
            'kind:"lvl_up",'+
            'RU:"<div class=text>НОВЫЙ УРОВЕНЬ!</div>",'+
           'ENG:"<div class=text>LEVEL UP!</div>"},'+
        'killed_by:{'+
            'kind:"danger",'+
            'RU:"Игрок побежден...", '+
            'ENG:"Player defeated..."},'+
        'monster_killed:{'+
            'kind:"normal",'+
            'RU:"Монстр побежден!", '+
           'ENG:"Monster defeated!"},'+
        'next_floor:{'+
            'kind:"normal",'+
            'RU:"Поднимаемся на %s этаж...", '+
           'ENG:"Go up %s floor..."},'+
        'skill_overcost:{'+
            'kind:"danger",'+
            'RU:"Использование %s стоит %d ICON_MANA!", '+
           'ENG:"Using of %s is cost %d ICON_MANA!"},'+
        'skill_up:{'+
            'kind:"normal",'+
            'RU:"Умение %s улучшено до %d уровня!", '+
           'ENG:"Skill %s is up to %d level!"},'+
        'skill_overup:{'+
            'kind:"danger",'+
            'RU:"Улучшение умения %s стоит %d ICON_EXP", '+
           'ENG:"Level up skill %s is cost %d ICON_EXP!"},'+
        'player_strike:{'+
            'kind:"fight",'+
            'RU:"ICON_MONSTER&emsp;-%d", '+
           'ENG:"ICON_MONSTER&emsp;-%d"},'+
        'monster_strike:{'+
            'kind:"fight",'+
            'RU:"-%d&emsp;ICON_KNIGHT", '+
           'ENG:"-%d&emsp;ICON_KNIGHT"},'+
        'player_strike_block:{'+
            'kind:"fight",'+
            'RU:"ICON_MONSTER&emsp;-%d ( %dICON_SHIELD )", '+
           'ENG:"ICON_MONSTER&emsp;-%d ( %dICON_SHIELD )"},'+
        'monster_strike_block:{'+
            'kind:"fight",'+
            'RU:"-%d ( %dICON_SHIELD )&emsp;ICON_KNIGHT", '+
           'ENG:"-%d ( %dICON_SHIELD )&emsp;ICON_KNIGHT"},'+
        'fight_swords:{'+
            'kind:"fight",'+
            'RU:"&emsp;ICON_FIGHT&emsp;", '+
           'ENG:"&emsp;ICON_FIGHT&emsp;"},'+
        'attack_pool_empty:{'+
            'kind:"normal",'+
            'RU:"Стек атак пуст...", '+
           'ENG:"Attack pool is empty..."},'+
        'change_param:{'+
            'kind:"change_param",'+
            'RU:"<div class=\"icon %s\"></div>&emsp;%s&emsp;( =%d )", '+
           'ENG:"<div class=\"icon %s\"></div>&emsp;%s&emsp;( =%d )"},'+
        'change_item:{'+
            'kind:"change_item",'+
            'RU:"<div class=\"icon %s\"></div>&emsp;%s&emsp;%s&emsp;( =%d )", '+
           'ENG:"<div class=\"icon %s\"></div>&emsp;%s&emsp;%s&emsp;( =%d )"},'+
        'change_loot:{'+
            'kind:"change_loot",'+
            'RU:"<div class=\"icon %s\"></div>&emsp;%s&emsp;%s&emsp;( =%d )", '+
           'ENG:"<div class=\"icon %s\"></div>&emsp;%s&emsp;%s&emsp;( =%d )"},'+
        'allow_think:{'+
            'kind:"allow",'+
            'RU:"<div class=\"icon icon_unlock\"></div>&emsp;Доступен режим <b>Раздумий</b>!", '+
           'ENG:"<div class=\"icon icon_unlock\"></div>&emsp;<b>Think</b> mode available!"},'+
    '},';

type
    TLog = class
    private
        lines : TList<string>;
            /// все записи лога, более старые, чем lastText, которая выводится динамически,
            /// но не более linesCount


        lastKind   /// тип последней добавленой записи в лог. влияет на CSS офомление
       ,lastText   /// текст последней добавленой записи в лог. используется для операций замены, склейки и прочего
                : string;

        Doc : TDocCreater;

        phrases: ISuperObject;
        function BuildLine: string;   // по текущим тексту и типу строим запись для лога в HTML формате
        function BuildLog: string;    // формирует полный HTML документ лога
    public
        wbLog : TWebBrowser;
        linesCount: integer;
            /// максимальное количество сообщений в чате, при привышении которого
            /// самые старые из которых будут удалены

        procedure GenerateImages;          // кодирование карионок в Base64 строки для CSS фонов
        procedure Clear;
        procedure Phrase(name, lang: string; params: array of TVarRec);
        procedure PhraseAppend(name, lang: string; params: array of TVarRec);
        procedure Add(kind,text: string);  // добавить новую строку с оформлением указанного типа
        procedure Append(text: string);   // приклеить текст к концу самой свежей строки
        procedure Prepend(text: string);   // приклеить текст к началу самой свежей строки
        procedure Replace(text: string);  // заменить текст к самой свежей строке
        procedure Update;                 // обновление содержимого wbLog
    end;

var
    Log : TLog;

implementation

{ TLog }

uses
    uAtlas, uGameDrive;

var
    IMAGE_NOTE_BG
   ,IMAGE_LEVEL

   ,ICON_GOLD
   ,ICON_SWORD
   ,ICON_SHIELD
   ,ICON_BLUESHIELD
   ,ICON_HEART
   ,ICON_MANA
   ,ICON_AUTO
   ,ICON_LEVEL
   ,ICON_EXP
   ,ICON_FIGHT
   ,ICON_CHEST
   ,ICON_UNLOCK
   ,ICON_MONSTER
   ,ICON_KNIGHT
   ,ICON_BRAIN
    : string;



procedure TLog.Add(kind, text: string);
begin
    /// пишем последнее сообщение в "архив"
    if  (lastKind <> '')
    then lines.Add( BuildLine );

    /// обрезаем самое старое сообщение, если вылазит за маскимум
    if lines.Count > linesCount
    then lines.Delete(0);

    /// обновляем инфу активной строки
    lastKind := kind;
    lastText := text;

    GameDrive.SetModeToUpdate(INT_LOG);
end;

procedure TLog.Append(text: string);
begin
    lastText := lastText + text;
end;

function TLog.BuildLine: string;
begin
    result := Format(LOG_LINE, [lastKind, lastText]);
end;

function TLog.BuildLog: string;
var
    i : integer;
begin
    Doc.Template.html := EMPTY_HTML;
    for i := 0 to lines.Count -1 do
       Doc.AddHTML(lines[i]);

    Doc.AddHTML( BuildLine );

    Doc.SetValue('IMAGE_NOTE_BG', IMAGE_NOTE_BG);
    Doc.SetValue('IMAGE_LEVEL', IMAGE_LEVEL);

    Doc.SetValue('ICON_GOLD', ICON_GOLD);
    Doc.SetValue('ICON_SWORD', ICON_SWORD);
    Doc.SetValue('ICON_SHIELD', ICON_SHIELD);
    Doc.SetValue('ICON_BLUESHIELD', ICON_BLUESHIELD);
    Doc.SetValue('ICON_HEART', ICON_HEART);
    Doc.SetValue('ICON_MANA', ICON_MANA);
    Doc.SetValue('ICON_AUTO', ICON_AUTO);
    Doc.SetValue('ICON_LEVEL', ICON_LEVEL);
    Doc.SetValue('ICON_EXP', ICON_EXP);
    Doc.SetValue('ICON_FIGHT', ICON_FIGHT);
    Doc.SetValue('ICON_CHEST', ICON_CHEST);
    Doc.SetValue('ICON_UNLOCK', ICON_UNLOCK);
    Doc.SetValue('ICON_MONSTER', ICON_MONSTER);
    Doc.SetValue('ICON_KNIGHT', ICON_KNIGHT);
    Doc.SetValue('ICON_BRAIN', ICON_BRAIN);

    Doc.SetValue('ICON_GOLD', Format(ICON_TEMPLATE, ['icon icon_gold']), false);
    Doc.SetValue('ICON_SWORD', Format(ICON_TEMPLATE, ['icon icon_sword']), false);
    Doc.SetValue('ICON_SHIELD', Format(ICON_TEMPLATE, ['icon icon_shield']), false);
    Doc.SetValue('ICON_BLUESHIELD', Format(ICON_TEMPLATE, ['icon icon_blueshield']), false);
    Doc.SetValue('ICON_HEART', Format(ICON_TEMPLATE, ['icon icon_heart']), false);
    Doc.SetValue('ICON_MANA', Format(ICON_TEMPLATE, ['icon icon_mana']), false);
    Doc.SetValue('ICON_AUTO', Format(ICON_TEMPLATE, ['icon icon_auto']), false);
    Doc.SetValue('ICON_LEVEL', Format(ICON_TEMPLATE, ['icon icon_level']), false);
    Doc.SetValue('ICON_EXP', Format(ICON_TEMPLATE, ['icon icon_exp']), false);
    Doc.SetValue('ICON_FIGHT', Format(ICON_TEMPLATE, ['icon icon_fight']), false);
    Doc.SetValue('ICON_CHEST', Format(ICON_TEMPLATE, ['icon icon_chest']), false);
    Doc.SetValue('ICON_UNLOCK', Format(ICON_TEMPLATE, ['icon icon_unlock']), false);
    Doc.SetValue('ICON_MONSTER', Format(ICON_TEMPLATE, ['icon icon_monster']), false);
    Doc.SetValue('ICON_KNIGHT', Format(ICON_TEMPLATE, ['icon icon_knight']), false);
    Doc.SetValue('ICON_BRAIN', Format(ICON_TEMPLATE, ['icon icon_brain']), false);

    Doc.ClearMarks;

    result := Doc.Template.html;
end;

procedure TLog.Clear;
begin
    lastKind := '';
    lastText := '';
    wbLog.LoadFromStrings('', '');
end;

procedure TLog.GenerateImages;
begin
    if IMAGE_NOTE_BG = '' then IMAGE_NOTE_BG :=  fAtlas.EncodeToBase64('NOTE_BG');
    if IMAGE_LEVEL = '' then IMAGE_LEVEL :=  fAtlas.EncodeToBase64('IMAGE_LEVEL');

    if ICON_GOLD = '' then ICON_GOLD :=  fAtlas.EncodeToBase64('ICON_GOLD');
    if ICON_SWORD = '' then ICON_SWORD :=  fAtlas.EncodeToBase64('ICON_SWORD');
    if ICON_SHIELD = '' then ICON_SHIELD :=  fAtlas.EncodeToBase64('ICON_SHIELD');
    if ICON_BLUESHIELD = '' then ICON_BLUESHIELD :=  fAtlas.EncodeToBase64('ICON_BLUESHIELD');
    if ICON_HEART = '' then ICON_HEART :=  fAtlas.EncodeToBase64('ICON_HEART');
    if ICON_MANA = '' then ICON_MANA :=  fAtlas.EncodeToBase64('ICON_MANA');
    if ICON_AUTO = '' then ICON_AUTO :=  fAtlas.EncodeToBase64('ICON_AUTO');
    if ICON_LEVEL = '' then ICON_LEVEL :=  fAtlas.EncodeToBase64('ICON_LEVEL');
    if ICON_EXP = '' then ICON_EXP :=  fAtlas.EncodeToBase64('ICON_EXP');
    if ICON_FIGHT = '' then ICON_FIGHT :=  fAtlas.EncodeToBase64('ICON_FIGHT');
    if ICON_CHEST = '' then ICON_CHEST :=  fAtlas.EncodeToBase64('ICON_CHEST');
    if ICON_UNLOCK = '' then ICON_UNLOCK :=  fAtlas.EncodeToBase64('ICON_UNLOCK');
    if ICON_MONSTER = '' then ICON_MONSTER :=  fAtlas.EncodeToBase64('ICON_MONSTER');
    if ICON_KNIGHT = '' then ICON_KNIGHT :=  fAtlas.EncodeToBase64('ICON_KNIGHT');
    if ICON_BRAIN = '' then ICON_BRAIN :=  fAtlas.EncodeToBase64('ICON_BRAIN');
end;

procedure TLog.Phrase(name, lang: string; params: array of TVarRec);
var
    text : string;
begin
    if not Assigned( phrases.O[name]) then exit;
    text := Format(phrases.S[name+'.'+lang], params);
    Add(phrases.S[name+'.kind'], text);
end;

procedure TLog.PhraseAppend(name, lang: string; params: array of TVarRec);
var
    text : string;
begin
    if not Assigned( phrases.O[name]) then exit;
    text := Format(phrases.S[name+'.'+lang], params);
    Append(text);
end;

procedure TLog.Prepend(text: string);
begin
    lastText := text + lastText;
end;

procedure TLog.Replace(text: string);
begin
    lastText := text;
end;

procedure TLog.Update;
begin
    wbLog.LoadFromStrings( BuildLog, '');
end;

initialization
    Log := TLog.Create;
    Log.lines := TList<string>.Create;
    Log.Doc := TDocCreater.Create;
    Log.phrases := SO(PHRASES_LIST);

finalization
    Log.Doc.Free;
    Log.lines.Free;
    Log.Free;

end.

