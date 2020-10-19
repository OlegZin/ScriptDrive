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
              '.danger{color:red;}'+
              '.fight{color:gray;}'+
              '.note{'+
                'padding:20px;margin:20px;'+
                'font-weight:bold;'+
                'line-height:150%;'+
                'background-image:url("data:image/jpeg;base64,#IMAGE_NOTE_BG#")'+
              '}'+
            '</style>'+
          '</head>'+
        '<body onload="window.scrollTo(0,100000)">'+
          '#CONTENT#'+
        '</body>'+
        '</html>';

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
            'RU:"Монстр %s убит! Получено %s exp", '+
           'ENG:"Monster %s is killed! Got %s exp"},'+
        'next_floor:{'+
            'kind:"normal",'+
            'RU:"Поднимаемся на %d этаж Башни...", '+
           'ENG:"Go up %d Tower floor..."},'+
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
            'RU:"Игрок нанес %d урона", '+
           'ENG:"Player strike for %d DMG"},'+
        'monster_strike:{'+
            'kind:"fight",'+
            'RU:"Монстр нанес %d урона", '+
           'ENG:"Monster strike for %d DMG"},'+
        'player_strike_block:{'+
            'kind:"fight",'+
            'RU:"Игрок нанес %d урона ( заблокировано %d )", '+
           'ENG:"Player strike for %d DMG ( %d is blocked )"},'+
        'monster_strike_block:{'+
            'kind:"fight",'+
            'RU:"Монстр нанес %d урона ( заблокировано %d )", '+
           'ENG:"Monster strike for %d DMG ( %d is blocked )"},'+
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
    : string;



procedure TLog.Add(kind, text: string);
begin
    /// пишем последнее сообщение в "архив"
    if  (lastKind <> '') and (lastText <> '')
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
end;

procedure TLog.Phrase(name, lang: string; params: array of TVarRec);
var
    text : string;
begin
    if not Assigned( phrases.O[name]) then exit;
    text := Format(phrases.S[name+'.'+lang], params);
    Add(phrases.S[name+'.kind'], text);
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

