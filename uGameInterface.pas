unit uGameInterface;

interface

uses
    Generics.Collections, FMX.Controls, superobject, FMX.StdCtrls;

type

    TGameInterface = class
    private
        selected: TControl;

        Controls: TDictionary<String, TControl>;
        procedure TabClick(Sender: TObject);
        procedure TabMouseEnter(Sender: TObject);
        procedure TabMouseLeave(Sender: TObject);
    public
        procedure LinkControl(key: string; control: TControl);
        procedure Update(data: ISuperObject);
        procedure Init;
        procedure SetMode(name: string);
    end;

var
    GameInterface : TGameInterface;

implementation

uses
    uGameDrive;

{ TGameInterface }

procedure TGameInterface.Init;
begin
    SetMode('Tower');
end;

procedure TGameInterface.LinkControl(key: string; control: TControl);
begin
    Controls.Add(key, control);

    if Pos('tab', key) > 0 then
    begin
        control.OnMouseEnter := TabMouseEnter;
        control.OnMouseLeave := TabMouseLeave;
        control.OnClick      := TabClick;
        control.Opacity := 0.5;
    end;

end;

procedure TGameInterface.SetMode(name: string);
var
    item: TPair<String, TControl>;
begin
    for item in Controls do
    begin
      if   pos('tab', item.key) > 0 then
      if item.Value.Name <> name
      then item.Value.Opacity := 0.5
      else begin
          item.Value.Opacity := 1;
          selected := item.Value;
      end;
    end;
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
    Controls['rectEXP'].Width := Controls['rectBGEXP'].Width * ( data.I['EXP'] / data.I['NEEDEXP'] );
end;

procedure TGameInterface.TabClick(Sender: TObject);
begin
    GameDrive.SetMode((Sender as TControl).Name);
    SetMode((Sender as TControl).Name);
end;

procedure TGameInterface.TabMouseEnter(Sender: TObject);
begin
    if   sender <> selected
    then (sender as TControl).Opacity := 0.8;
end;

procedure TGameInterface.TabMouseLeave(Sender: TObject);
begin
    if   sender <> selected
    then (sender as TControl).Opacity := 0.5;
end;

initialization
    GameInterface := TGameInterface.Create;
    GameInterface.Controls := TDictionary<String, TControl>.Create;

finalization
    GameInterface.Free;

end.
