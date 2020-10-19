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

    /// ����� ����������� ����
    PHRASES_LIST =
    '{'+
        'level_up:{'+
            'kind:"normal",'+
            'RU:"������� ����� �������!",'+
            'ENG:"Player is level up!"},'+
        'killed_by:{'+
            'kind:"danger",'+
            'RU:"����� ����...", '+
            'ENG:"Player is killed..."},'+
        'monster_killed:{'+
            'kind:"normal",'+
            'RU:"������ %s ����! �������� %s exp", '+
           'ENG:"Monster %s is killed! Got %s exp"},'+
        'next_floor:{'+
            'kind:"normal",'+
            'RU:"����������� �� %d ���� �����...", '+
           'ENG:"Go up %d Tower floor..."},'+
        'skill_overcost:{'+
            'kind:"danger",'+
            'RU:"������������� %s ����� %d MP!", '+
           'ENG:"Using of %s is cost %d MP!"},'+
        'skill_up:{'+
            'kind:"normal",'+
            'RU:"������ %s �������� �� %d ������!", '+
           'ENG:"Skill %s is up to %d level!"},'+
        'skill_overup:{'+
            'kind:"danger",'+
            'RU:"��������� ������ %s ����� %d exp", '+
           'ENG:"Level up skill %s is cost %d exp!"},'+
        'player_strike:{'+
            'kind:"fight",'+
            'RU:"����� ����� %d �����", '+
           'ENG:"Player strike for %d DMG"},'+
        'monster_strike:{'+
            'kind:"fight",'+
            'RU:"������ ����� %d �����", '+
           'ENG:"Monster strike for %d DMG"},'+
        'player_strike_block:{'+
            'kind:"fight",'+
            'RU:"����� ����� %d ����� ( ������������� %d )", '+
           'ENG:"Player strike for %d DMG ( %d is blocked )"},'+
        'monster_strike_block:{'+
            'kind:"fight",'+
            'RU:"������ ����� %d ����� ( ������������� %d )", '+
           'ENG:"Monster strike for %d DMG ( %d is blocked )"},'+
        'get_loot:{'+
            'kind:"normal",'+
            'RU:"�������� %s %s", '+
           'ENG:"Got %s %s"},'+
    '},';
type
    TLog = class
    private
        lines : TList<string>;
            /// ��� ������ ����, ����� ������, ��� lastText, ������� ��������� �����������,
            /// �� �� ����� linesCount


        lastKind   /// ��� ��������� ���������� ������ � ���. ������ �� CSS ���������
       ,lastText   /// ����� ��������� ���������� ������ � ���. ������������ ��� �������� ������, ������� � �������
                : string;

        Doc : TDocCreater;

        phrases: ISuperObject;
        function BuildLine: string;   // �� ������� ������ � ���� ������ ������ ��� ���� � HTML �������
        function BuildLog: string;    // ��������� ������ HTML �������� ����
    public
        wbLog : TWebBrowser;
        linesCount: integer;
            /// ������������ ���������� ��������� � ����, ��� ���������� ��������
            /// ����� ������ �� ������� ����� �������

        procedure GenerateImages;          // ����������� �������� � Base64 ������ ��� CSS �����
        procedure Clear;
        procedure Phrase(name, lang: string; params: array of TVarRec);
        procedure Add(kind,text: string);  // �������� ����� ������ � ����������� ���������� ����
        procedure Append(text: string);   // ��������� ����� � ����� ����� ������ ������
        procedure Prepend(text: string);   // ��������� ����� � ������ ����� ������ ������
        procedure Replace(text: string);  // �������� ����� � ����� ������ ������
        procedure Update;                 // ���������� ����������� wbLog

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

