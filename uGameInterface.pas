unit uGameInterface;

interface

uses
    Generics.Collections, FMX.Controls;

type

    TGameInterface = class
    private
        Controls: TDictionary<String, TControl>;
    public
        procedure LinkControl(key: string; comp: TControl);
    end;

var
    GameInterface : TGameInterface;

implementation



{ TGameInterface }

procedure TGameInterface.LinkControl(key: string; comp: TControl);
begin

end;

initialization
    GameInterface := TGameInterface.Create;
    GameInterface.Controls := TDictionary<String, TControl>.Create;

finalization
    GameInterface.Free;

end.
