unit uTowerMode;

interface

uses FMX.TabControl;

type
    TTower = class
        page: TTabItem;
        tcModes: TTabControl;
        procedure SetActive;  // активация режима (пользователь переключился на вкладку Башни)
        procedure SetUnactive;  // активация режима (пользователь переключился на вкладку Башни)
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
