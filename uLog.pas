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
              '.icon_gold,.icon_sword,.icon_shield,.icon_blueshield,'+
              '.icon_heart,.icon_mana,.icon_auto,.icon_level,.icon_exp'+
              '.icon_fight,.icon_chest,.icon_unlock'+
              '{'+
                'display: inline;'+
                'height: 20px;'+
                'width: 20px;}'+
              '.icon_gold{background:url("data:image/jpeg;base64,#IMAGE_GOLD#");}'+
              '.icon_sword{background:url("data:image/jpeg;base64,#IMAGE_SWORD#");}'+
              '.icon_shield{background:url("data:image/jpeg;base64,#IMAGE_SHIELD#");}'+
              '.icon_blueshield{background:url("data:image/jpeg;base64,#IMAGE_BLUESHIELD#");}'+
              '.icon_heart{background:url("data:image/jpeg;base64,#IMAGE_HEART#");}'+
              '.icon_mana{background:url("data:image/jpeg;base64,#IMAGE_MANA#");}'+
              '.icon_auto{background:url("data:image/jpeg;base64,#IMAGE_AUTO#");}'+
              '.icon_level{background:url("data:image/jpeg;base64,#IMAGE_LEVEL#");}'+
              '.icon_exp{background:url("data:image/jpeg;base64,#IMAGE_EXP#");}'+
              '.icon_fight{background:url("data:image/jpeg;base64,#IMAGE_FIGHT#");}'+
              '.icon_chest{background:url("data:image/jpeg;base64,#IMAGE_CHEST#");}'+
              '.icon_unlock{background:url("data:image/jpeg;base64,#IMAGE_UNLOCK#");}'+
            '</style>'+
          '</head>'+
        '<body onload="window.scrollTo(0,100000)">'+
          '#CONTENT#'+
        '</body>'+
        '</html>';

    ///
    ICON_TEMPLATE = '<div class=icon_%s></div>';

    /// набор стандартных фраз
    PHRASES_LIST =
    '{'+
        'level_up:{'+
            'kind:"normal",'+
            'RU:"Получен новый уровень!",'+
            'ENG:"Player is level up!"},'+
        'killed_by:{'+
            'kind:"danger",'+
            'RU:"Игрок убит...", '+
            'ENG:"Player is killed..."},'+
        'monster_killed:{'+
            'kind:"normal",'+
            'RU:"Монстр убит!", '+
           'ENG:"Monster is killed!"},'+
        'next_floor:{'+
            'kind:"normal",'+
            'RU:"Поднимаемся на %s этаж Башни...", '+
           'ENG:"Go up %s Tower floor..."},'+
        'skill_overcost:{'+
            'kind:"danger",'+
            'RU:"Использование %s стоит %d MP!", '+
           'ENG:"Using of %s is cost %d MP!"},'+
        'skill_up:{'+
            'kind:"normal",'+
            'RU:"Умение %s улучшено до %d уровня!", '+
           'ENG:"Skill %s is up to %d level!"},'+
        'skill_overup:{'+
            'kind:"danger",'+
            'RU:"Улучшение умения %s стоит %d exp", '+
           'ENG:"Level up skill %s is cost %d exp!"},'+
        'player_strike:{'+
            'kind:"fight",'+
            'RU:"Монстр -%dICON_HEART", '+
           'ENG:"Monster -%dICON_HEART"},'+
        'monster_strike:{'+
            'kind:"fight",'+
            'RU:"-%dICON_HEART Игрок", '+
           'ENG:"-%dICON_HEART Player"},'+
        'player_strike_block:{'+
            'kind:"fight",'+
            'RU:"Монстр -%dICON_HEART ( %dICON_SHIELD )", '+
           'ENG:"Monster -%dICON_HEART ( %dICON_SHIELD )"},'+
        'monster_strike_block:{'+
            'kind:"fight",'+
            'RU:"-%dICON_HEART ( %dICON_SHIELD ) Игрок", '+
           'ENG:"-%dICON_HEART ( %dICON_SHIELD ) Player"},'+
        'get_loot:{'+
            'kind:"normal",'+
            'RU:"Получено %s %s", '+
           'ENG:"Got %s %s"},'+
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
    uAtlas;

var
    IMAGE_NOTE_BG
   ,IMAGE_GOLD
   ,IMAGE_SWORD
   ,IMAGE_SHIELD
   ,IMAGE_BLUESHIELD
   ,IMAGE_HEART
   ,IMAGE_MANA
   ,IMAGE_AUTO
   ,IMAGE_LEVEL
   ,IMAGE_EXP
   ,IMAGE_FIGHT
   ,IMAGE_CHEST
   ,IMAGE_UNLOCK
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
    Doc.SetValue('IMAGE_GOLD', IMAGE_GOLD);
    Doc.SetValue('IMAGE_SWORD', IMAGE_SWORD);
    Doc.SetValue('IMAGE_SHIELD', IMAGE_SHIELD);
    Doc.SetValue('IMAGE_BLUESHIELD', IMAGE_BLUESHIELD);
    Doc.SetValue('IMAGE_HEART', IMAGE_HEART);
    Doc.SetValue('IMAGE_MANA', IMAGE_MANA);
    Doc.SetValue('IMAGE_AUTO', IMAGE_AUTO);
    Doc.SetValue('IMAGE_LEVEL', IMAGE_LEVEL);
    Doc.SetValue('IMAGE_EXP', IMAGE_EXP);
    Doc.SetValue('IMAGE_FIGHT', IMAGE_FIGHT);
    Doc.SetValue('IMAGE_CHEST', IMAGE_CHEST);
    Doc.SetValue('IMAGE_UNLOCK', IMAGE_UNLOCK);

    Doc.SetValue('ICON_GOLD', Format(ICON_TEMPLATE, ['gold']), false);
    Doc.SetValue('ICON_SWORD', Format(ICON_TEMPLATE, ['sword']), false);
    Doc.SetValue('ICON_SHIELD', Format(ICON_TEMPLATE, ['shield']), false);
    Doc.SetValue('ICON_BLUESHIELD', Format(ICON_TEMPLATE, ['blueshield']), false);
    Doc.SetValue('ICON_HEART', Format(ICON_TEMPLATE, ['heart']), false);
    Doc.SetValue('ICON_MANA', Format(ICON_TEMPLATE, ['mana']), false);
    Doc.SetValue('ICON_AUTO', Format(ICON_TEMPLATE, ['auto']), false);
    Doc.SetValue('ICON_LEVEL', Format(ICON_TEMPLATE, ['level']), false);
    Doc.SetValue('ICON_EXP', Format(ICON_TEMPLATE, ['exp']), false);
    Doc.SetValue('ICON_FIGHT', Format(ICON_TEMPLATE, ['fight']), false);
    Doc.SetValue('ICON_CHEST', Format(ICON_TEMPLATE, ['chest']), false);
    Doc.SetValue('ICON_UNLOCK', Format(ICON_TEMPLATE, ['unlock']), false);

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
    if IMAGE_GOLD = '' then IMAGE_GOLD :=  fAtlas.EncodeToBase64('ICON_GOLD');
    if IMAGE_SWORD = '' then IMAGE_SWORD :=  fAtlas.EncodeToBase64('ICON_SWORD');
    if IMAGE_SHIELD = '' then IMAGE_SHIELD :=  fAtlas.EncodeToBase64('ICON_SHIELD');
    if IMAGE_BLUESHIELD = '' then IMAGE_BLUESHIELD :=  fAtlas.EncodeToBase64('ICON_BLUESHIELD');
    if IMAGE_HEART = '' then IMAGE_HEART :=  fAtlas.EncodeToBase64('ICON_HEART');
    if IMAGE_MANA = '' then IMAGE_MANA :=  fAtlas.EncodeToBase64('ICON_MANA');
    if IMAGE_AUTO = '' then IMAGE_AUTO :=  fAtlas.EncodeToBase64('ICON_AUTO');
    if IMAGE_LEVEL = '' then IMAGE_LEVEL :=  fAtlas.EncodeToBase64('ICON_LEVEL');
    if IMAGE_EXP = '' then IMAGE_EXP :=  fAtlas.EncodeToBase64('ICON_EXP');
    if IMAGE_FIGHT = '' then IMAGE_FIGHT :=  fAtlas.EncodeToBase64('ICON_FIGHT');
    if IMAGE_CHEST = '' then IMAGE_CHEST :=  fAtlas.EncodeToBase64('ICON_CHEST');
    if IMAGE_UNLOCK = '' then IMAGE_UNLOCK :=  fAtlas.EncodeToBase64('ICON_UNLOCK');
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

