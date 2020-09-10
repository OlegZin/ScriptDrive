unit uThinkMode;

interface

type
    TThink = class
        procedure SetActive;  // активация режима (пользователь переключился на вкладку Башни)
        procedure SetUnactive;  // активация режима (пользователь переключился на вкладку Башни)
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
