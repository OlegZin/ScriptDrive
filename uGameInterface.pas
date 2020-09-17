unit uGameInterface;

interface

uses
    Generics.Collections, FMX.Controls, superobject, FMX.StdCtrls;

type

    TGameInterface = class
    private
        Controls: TDictionary<String, TControl>;
    public
        procedure LinkControl(key: string; control: TControl);
        procedure Update(data: ISuperObject);
    end;

var
    GameInterface : TGameInterface;

implementation



{ TGameInterface }

procedure TGameInterface.LinkControl(key: string; control: TControl);
begin
    Controls.Add(key, control);
end;

procedure TGameInterface.Update(data: ISuperObject);
var
    item: TPair<String, TControl>;
begin
    /// ключи компонент совпадают с именами полей data
    ///  потому простым перебором распихиваем значения в лейблы
    for item in Controls do
      if   Assigned(data[item.key])
      then (item.Value as TLabel).Text := data.S[item.key];

    /// обновляем прогресс набора опыта для уровня
    Controls['rectEXP'].Width := Controls['rectBGEXP'].Width * ( data.I['EXP'] / data.I['NeedExp'] );
end;

initialization
    GameInterface := TGameInterface.Create;
    GameInterface.Controls := TDictionary<String, TControl>.Create;

finalization
    GameInterface.Free;

end.
