unit uTowerMode;

interface

type
    TTower = class
        procedure SetActive;  // ��������� ������ (������������ ������������ �� ������� �����)
        procedure SetUnactive;  // ��������� ������ (������������ ������������ �� ������� �����)
    end;

var
    Tower : TTower;

implementation

{ TTower }

procedure TTower.SetActive;
begin

end;

procedure TTower.SetUnactive;
begin

end;

initialization
    Tower := TTower.Create;

finalization
    Tower.Free;

end.
