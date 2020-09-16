unit uThinkMode;

interface

uses FMX.TabControl;

type
    TThink = class
        page: TTabItem;
        tcModes: TTabControl;
        procedure SetActive;  // ��������� ������ (������������ ������������ �� ������� �����)
        procedure SetUnactive;  // ��������� ������ (������������ ������������ �� ������� �����)
    end;

var
    Think : TThink;

implementation

{ TTower }

procedure TThink.SetActive;
begin
    tcModes.ActiveTab := page;
end;

procedure TThink.SetUnactive;
begin

end;

initialization
    Think := TThink.Create;

finalization
    Think.Free;

end.
