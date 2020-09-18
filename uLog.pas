unit uLog;

interface

uses
    FMX.WebBrowser, Generics.Collections, SysUtils, StrUtils,
    uDocCreater, uConst;

const
    LOG_LINE = '<div class=%s>%s</div>';

    EMPTY_HTML =
        '<html>'+
          '<head>'+
            '<meta http-equiv=Content-Type content="text/html; charset=windows-1251">'+
            '<style>'+
              'body{margin:0;padding:10px;border:0;}'+
              '.danger{color:red;}'+
              '.note{'+
                'padding:20px;margin:20px;'+
                'font-weight:bold;'+
                'line-height:150%;'+
                'background-image:url("data:image/jpeg;base64,#IMAGE_NOTE_BG#")'+
              '}'+
            '</style>'+
          '</head>'+
        '<body onload="window.scrollTo(0,1000)">'+
          '#CONTENT#'+
        '</body>'+
        '</html>';
type
    TLog = class
        wbLog : TWebBrowser;
        lines : TList<string>;
            /// все записи лога, более старые, чем lastText, которая выводится динамически,
            /// но не более linesCount

        linesCount: integer;
            /// максимальное количество сообщений в чате, при привышении которого
            /// самые старые из которых будут удалены

        lastKind   /// тип последней добавленой записи в лог. влияет на CSS офомление
       ,lastText   /// текст последней добавленой записи в лог. используется для операций замены, склейки и прочего
                : string;

        Doc : TDocCreater;

        procedure GenerateImages;          // кодирование карионок в Base64 строки для CSS фонов
        procedure Clear;
        procedure Add(kind,text: string);  // добавить новую строку с оформлением указанного типа
        procedure Append(text: string);   // приклеить текст к концу самой свежей строки
        procedure Prepend(text: string);   // приклеить текст к началу самой свежей строки
        procedure Replace(text: string);  // заменить текст к самой свежей строке
        procedure Update;                 // обновление содержимого wbLog

        function BuildLine: string;   // по текущим тексту и типу строим запись для лога в HTML формате
        function BuildLog: string;    // формирует полный HTML документ лога
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

finalization
    Log.Doc.Free;
    Log.lines.Free;
    Log.Free;

end.

