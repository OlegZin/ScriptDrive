unit uGameInterface;

interface

uses
    Generics.Collections, FMX.Controls, superobject, FMX.StdCtrls, FMX.Objects, SysUtils;

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
        procedure OpenItemPanel(mode: boolean);
    end;

var
    GameInterface : TGameInterface;

implementation

uses
    uGameDrive, uConst, uAtlas;

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
        control.Opacity := 0.3;
    end;

end;

procedure TGameInterface.OpenItemPanel(mode: boolean);
begin

end;

procedure TGameInterface.SetMode(name: string);
var
    item: TPair<String, TControl>;
begin
    for item in Controls do
    begin
      if   pos('tab', item.key) > 0 then
      if item.Value.Name <> name
      then item.Value.Opacity := 0.3
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

    if assigned(data.O['isOpenItemPanel'])
    then Controls['ItemPanel'].Visible := data.B['isOpenItemPanel']
    else Controls['ItemPanel'].Visible := false;

    /// ключи компонент совпадают с именами полей data
    ///  потому простым перебором распихиваем значения в лейблы
    for item in Controls do
      if   Assigned(data.O['params.'+item.key])
      then (item.Value as TLabel).Text := data.S['params.'+item.key];

    /// обновляем прогресс набора опыта для уровня
    Controls['rectEXP'].Width := Controls['rectBGEXP'].Width * ( data.I['params.EXP'] / data.I['params.'+PRM_NEEDEXP] );

    /// выставляем видимость вкладок режима
    if Assigned(data.O['modes']) then
    begin
        Controls['tabTower'].Visible := Assigned(data.O['modes.tower.allow']) and data.B['modes.tower.allow'];
        Controls['tabFloor'].Visible := Assigned(data.O['modes.floor.allow']) and data.B['modes.floor.allow'];
        Controls['tabThink'].Visible := Assigned(data.O['modes.think.allow']) and data.B['modes.think.allow'];
        Controls['tabResearch'].Visible := Assigned(data.O['modes.research.allow']) and data.B['modes.research.allow'];
        Controls['tabCraft'].Visible := Assigned(data.O['modes.craft.allow']) and data.B['modes.craft.allow'];
    end;

    if data.S['CurrItem'] <> '' then
    begin
        (Controls['CurrItem'] as TImage).MultiResBitmap[0].Bitmap.Assign( fAtlas.GetBitmapByName('item_'+data.S['CurrItem']) );
        (Controls['CurrCountBG'] as TLabel).Visible:=true;
        (Controls['CurrCountBG'] as TLabel).Text := data.S['CurrCount'];
        (Controls['CurrCount'] as TLabel).Text := data.S['CurrCount'];
    end else
    begin
        (Controls['CurrItem'] as TImage).MultiResBitmap[0].Bitmap.Assign( nil );
        (Controls['CurrCountBG'] as TLabel).Visible:=false;
    end;

    (Controls['CurrCountBG'] as TLabel).Text := data.S['CurrCount'];
    (Controls['CurrCount'] as TLabel).Text := data.S['CurrCount'];
end;

procedure TGameInterface.TabClick(Sender: TObject);
begin
    GameDrive.SetMode((Sender as TControl).Name);
    SetMode((Sender as TControl).Name);
end;

procedure TGameInterface.TabMouseEnter(Sender: TObject);
begin
    if   sender <> selected
    then (sender as TControl).Opacity := 0.7;
end;

procedure TGameInterface.TabMouseLeave(Sender: TObject);
begin
    if   sender <> selected
    then (sender as TControl).Opacity := 0.3;
end;

initialization
    GameInterface := TGameInterface.Create;
    GameInterface.Controls := TDictionary<String, TControl>.Create;

finalization
    GameInterface.Free;

end.
