unit uLog;

interface

uses
    FMX.WebBrowser, Generics.Collections;

type
    TLog = class
        wbLog : TWebBrowser;
        lines : TList<string>;
        linesCount: integer;
            /// ������������ ���������� ��������� � ����, ��� ���������� ��������
            /// ����� ������ �� ������� ����� �������
        procedure Clear;
        procedure Add(text: string);  // �������� ����� ������
        procedure Append(text: string);   // ��������� ����� � ����� ������ ������
        procedure Replace(text: string);  // �������� ����� � ����� ������ ������
        procedure Get(text: string);  // �������� ����� ����� ������ ������
        procedure Update;                 // ���������� ����������� wbLog
    end;

var
    Log : TLog;

implementation

{ TLog }

procedure TLog.Add(text: string);
begin

end;

procedure TLog.Append(text: string);
begin

end;

procedure TLog.Clear;
begin
    wbLog.LoadFromStrings('', '');
end;

procedure TLog.Get(text: string);
begin

end;

procedure TLog.Replace(text: string);
begin

end;

procedure TLog.Update;
begin

end;

initialization
    Log := TLog.Create;
    Log.lines := TList<string>.Create;

finalization
    Log.lines.Free;
    Log.Free;

end.
