unit uThinkMode;

interface

type
    TThink = class
        procedure SetActive;  // ��������� ������ (������������ ������������ �� ������� �����)
        procedure SetUnactive;  // ��������� ������ (������������ ������������ �� ������� �����)
    end;

var
    Think : TThink;

implementation

{ TTower }

procedure TThink.SetActive;
begin

end;

procedure TThink.SetUnactive;
begin

end;

initialization
    Think := TThink.Create;

finalization
    Think.Free;

end.
