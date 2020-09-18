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
            /// ��� ������ ����, ����� ������, ��� lastText, ������� ��������� �����������,
            /// �� �� ����� linesCount

        linesCount: integer;
            /// ������������ ���������� ��������� � ����, ��� ���������� ��������
            /// ����� ������ �� ������� ����� �������

        lastKind   /// ��� ��������� ���������� ������ � ���. ������ �� CSS ���������
       ,lastText   /// ����� ��������� ���������� ������ � ���. ������������ ��� �������� ������, ������� � �������
                : string;

        Doc : TDocCreater;

        procedure GenerateImages;          // ����������� �������� � Base64 ������ ��� CSS �����
        procedure Clear;
        procedure Add(kind,text: string);  // �������� ����� ������ � ����������� ���������� ����
        procedure Append(text: string);   // ��������� ����� � ����� ����� ������ ������
        procedure Prepend(text: string);   // ��������� ����� � ������ ����� ������ ������
        procedure Replace(text: string);  // �������� ����� � ����� ������ ������
        procedure Update;                 // ���������� ����������� wbLog

        function BuildLine: string;   // �� ������� ������ � ���� ������ ������ ��� ���� � HTML �������
        function BuildLog: string;    // ��������� ������ HTML �������� ����
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
    /// ����� ��������� ��������� � "�����"
    if  (lastKind <> '') and (lastText <> '')
    then lines.Add( BuildLine );

    /// �������� ����� ������ ���������, ���� ������� �� ��������
    if lines.Count > linesCount
    then lines.Delete(0);

    /// ��������� ���� �������� ������
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

