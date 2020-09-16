unit uTowerMode;

interface

uses FMX.TabControl;

type
    TTower = class
        page: TTabItem;
        tcModes: TTabControl;
        procedure SetActive;  // ��������� ������ (������������ ������������ �� ������� �����)
        procedure SetUnactive;  // ��������� ������ (������������ ������������ �� ������� �����)
    end;

var
    Tower : TTower;

implementation

{ TTower }

procedure TTower.SetActive;
begin
    tcModes.ActiveTab := page;
end;

procedure TTower.SetUnactive;
begin

end;

initialization
    Tower := TTower.Create;

finalization
    Tower.Free;

end.
