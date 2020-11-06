unit uGameInterface;

interface

uses
    Generics.Collections, FMX.Controls, superobject, FMX.StdCtrls, FMX.Objects, SysUtils, Math, FMX.Layouts, FMX.Types;

type

    TGameInterface = class
    private
        fdata: IsuperObject;

        selected: TControl;

        fPanelOpened: boolean; // показывать ли панель с предметами в инвентаре

        Controls: TDictionary<String, TControl>;
        HasItems: TDictionary<TControl, ISuperObject>;

        procedure TabClick(Sender: TObject);
        procedure TabMouseEnter(Sender: TObject);
        procedure TabMouseLeave(Sender: TObject);

        procedure onItemClick(sender: TObject);
        procedure onMouseEnter(sender: TObject);
        procedure onMouseLeave(sender: TObject);
    public
        Timer: TTimer;
        procedure LinkControl(key: string; control: TControl);
        procedure Update(data: ISuperObject);
        procedure Init;
        procedure SetMode(name: string);
        procedure OpenItemPanel;
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

procedure TGameInterface.onItemClick(sender: TObject);
var
    data: ISuperObject;
begin
    /// кликнутый предмет делаем выбранным
    if HasItems.TryGetValue(sender as TControl, data) then
    GameDrive.SetCurrItem(data.S['name']);
end;

procedure TGameInterface.onMouseEnter(sender: TObject);
var
    data: ISuperObject;
begin
    if HasItems.TryGetValue(sender as TControl, data) then
    begin
        (Controls['ItemCaption'] as TLabel).Text := data.S['caption'];
        (Controls['ItemDescription'] as TLabel).Text := data.S['description'];
    end;
end;

procedure TGameInterface.onMouseLeave(sender: TObject);
begin
    (Controls['ItemCaption'] as TLabel).Text := '';
    (Controls['ItemDescription'] as TLabel).Text := '';
end;

procedure TGameInterface.OpenItemPanel;
begin
    fPanelOpened := not fPanelOpened;

    Controls['ItemsPanel'].Visible := fPanelOpened;
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

    /// пр€чем все экранырежимов
    Controls['ScreenTower'].Parent := nil;
    Controls['ScreenThink'].Parent := nil;
    Controls['ScreenThinkWeb'].Visible := false;
      // небольшой баг не скрывает веббраузер, когда лайер на котором он находитс€ тер€ет Parent
      // что скрывает все остальные объекты
    Controls['ScreenFloor'].Parent := nil;

    /// показываем нужный
    if LowerCase(name) = 'tower' then Controls['ScreenTower'].Parent := Controls['Screen'];
    if LowerCase(name) = 'think' then begin
        Controls['ScreenThink'].Parent := Controls['Screen'];
        Controls['ScreenThinkWeb'].Visible := true;
    end;
    if LowerCase(name) = 'floor' then Controls['ScreenFloor'].Parent := Controls['Screen'];
end;

procedure TGameInterface.Update(data: ISuperObject);
var
    item: TPair<String, TControl>;
    elem: ISuperObject;
    obj: TControl;
    i, itemCount : integer;
    shift: real;
begin

    /// отображение и наполнение панели имеющихс€ предметов
    Controls['ItemsPanel'].Visible := fPanelOpened;

    Timer.Interval := data.I['game_speed'];

    /// обновл€ем панель предметов только если есть изменени€.
    /// иначе, возможны лаги кликов по предметам при активном регене в игре
    if not assigned(fdata.O['items']) or (fdata.O['items'].AsJSon <> data.O['items'].AsJSon) then
    begin

        (Controls['ItemCaption'] as TLabel).Text := '';
        (Controls['ItemDescription'] as TLabel).Text := '';

        /// чистим список предметов на панели инветар€
        for i := Controls['ItemsFlow'].ControlsCount-1 downto 0 do
        Controls['ItemsFlow'].Controls[i].Free;

        HasItems.Clear;

        itemCount := 0;
        if Assigned( data.O['items'] ) then
        for elem in data.O['items'] do
        begin
            Inc(itemCount); /// считаем общее количество предметов

            obj := fAtlas.ItemSlotShablon.Clone( Controls['ItemsFlow'] ) as TControl;
            obj.Parent := Controls['ItemsFlow'];
            obj.OnClick := onItemClick;
            obj.OnMouseEnter := onMouseEnter;
            obj.OnMouseLeave := onMouseLeave;

            HasItems.Add( obj, elem );

            for I := 0 to obj.ComponentCount-1 do
            begin
                if obj.Components[i] is Tlabel then (obj.Components[i] as Tlabel).Text := elem.S['count'];
                if obj.Components[i] is TImage then (obj.Components[i] as TImage).MultiResBitmap[0].Bitmap.Assign( fAtlas.GetBitmapByName('item_'+elem.S['name']) );
            end;
        end;


        /// настройка размеров панели предметов
        /// складываетс€ из внутренних отступов панели и суммы ширины/высоты €чеек
        Controls['ItemsPanel'].Width :=
            Controls['ItemsPanel'].Padding.Left + Controls['ItemsPanel'].Padding.Right +
            5 * (fAtlas.ItemSlotShablon.Width + (Controls['ItemsFlow'] as TFlowLayout).HorizontalGap)+
            20;
        Controls['ItemsPanel'].Height :=
            Controls['ItemsPanel'].Padding.Top + Controls['ItemsPanel'].Padding.Bottom +
            ((itemCount div 5) + ifthen(itemCount mod 5 > 0, 1, 0) ) * (fAtlas.ItemSlotShablon.Height + (Controls['ItemsFlow'] as TFlowLayout).VerticalGap)+
            Controls['ItemInfo'].Height +  /// учитываем высоту информационной панели
            20;

    end;

    /// ключи компонент совпадают с именами полей data
    ///  потому простым перебором распихиваем значени€ в лейблы
    for item in Controls do
      if   Assigned(data.O['params.'+item.key])
      then (item.Value as TLabel).Text := data.S['params.'+item.key];

    /// обновл€ем прогресс набора опыта дл€ уровн€
    Controls['rectEXP'].Width := Min(Controls['rectBGEXP'].Width * data.D['params.percent'], Controls['rectBGEXP'].Width);

    /// выставл€ем видимость вкладок режима
    if Assigned(data.O['modes']) then
    begin
        Controls['tabTower'].Visible := Assigned(data.O['modes.tower.allow']) and data.B['modes.tower.allow'];
        Controls['tabFloor'].Visible := Assigned(data.O['modes.floor.allow']) and data.B['modes.floor.allow'];
        Controls['tabThink'].Visible := Assigned(data.O['modes.think.allow']) and data.B['modes.think.allow'];
        Controls['tabResearch'].Visible := Assigned(data.O['modes.research.allow']) and data.B['modes.research.allow'];
        Controls['tabCraft'].Visible := Assigned(data.O['modes.craft.allow']) and data.B['modes.craft.allow'];
    end;

    /// показываем текущий выбранный предмет и доступное количество
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


    /// обновл€ем панель активных эффектов
    if not assigned(fdata.O['effects']) or (fdata.O['effects'].AsJSon <> data.O['effects'].AsJSon) then
    begin

        /// считаем общее количество текущих эффектов
        itemCount := 0;
        for elem in data.O['effects'] do
        Inc(itemCount);

        obj := fAtlas.ItemSlotShablon.Clone( Controls['EffectsPanel'] ) as TControl;
        if itemCount * (obj.height + 1) > Controls['EffectsPanel'].Height
        then shift := Controls['EffectsPanel'].Height / itemCount
        else shift := obj.height + 1;

        /// чистим список предметов на панели инветар€
        for i := Controls['EffectsPanel'].ControlsCount-1 downto 0 do
        Controls['EffectsPanel'].Controls[i].Free;

        itemCount := 0;
        for elem in data.O['effects'] do
        begin
            obj := fAtlas.ItemSlotShablon.Clone( Controls['EffectsPanel'] ) as TControl;
            obj.Parent := Controls['EffectsPanel'];
            obj.Position.X := 0;
            obj.Position.Y := itemCount * shift;
            obj.SendToBack;

            for I := 0 to obj.ComponentCount-1 do
            begin
                if obj.Components[i] is Tlabel then (obj.Components[i] as Tlabel).Text := elem.S['value'];
                if obj.Components[i] is TImage then (obj.Components[i] as TImage).MultiResBitmap[0].Bitmap.Assign( fAtlas.GetBitmapByName('effect_'+elem.S['name']) );
            end;

            Inc(itemCount);
        end;

    end;

    /// запоминаем текущие данные дл€ сравнени€ со следующим апдейтом
    fdata := data;
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
    GameInterface.HasItems := TDictionary<TControl, ISuperObject>.Create;
    GameInterface.fPanelOpened := false;
    GameInterface.fdata := SO();

finalization
    GameInterface.Free;

end.
