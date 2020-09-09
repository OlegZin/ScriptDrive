unit uTowerMode;

interface

type
    TTower = class
    end;

var
    Tower : TTower;

implementation

initialization
    Tower := TTower.Create;

finalization
    Tower.Free;

end.
