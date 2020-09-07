unit uMenu;

interface

uses
    superobject,
    System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
    FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
    FMX.Controls.Presentation, FMX.Edit, FMX.ComboEdit, FMX.ComboTrackBar,
    FMX.StdCtrls, FMX.WebBrowser, FMX.TabControl, FMX.Objects, FMX.Layouts,
    Generics.Collections, Math;

const
    def =
    '{Gold:0, '+
     'Skills: {'+
         'Research:     {Enabled:0, Level:0, NeedGold:10,  NeedResearch:1 },'+
         'MoneyEaring:  {Enabled:0, Level:1, NeedGold:20,  NeedResearch:5 },'+
         'BuildSpeed:   {Enabled:0, Level:1, NeedGold:100, NeedResearch:10},'+
         'BuildEconomy: {Enabled:0, Level:0, NeedGold:500, NeedResearch:15},'+
         'OwnTower:     {Enabled:0, Level:1, NeedGold:1000,NeedResearch:20}'+
    '},'+
     'Objects: {'+
         'Logo:   {NeedResearch:3,  BuildCost:5,  Attempts:0, FullAttempts:10 },'+
         'Exit:   {NeedResearch:6,  BuildCost:10, Attempts:0, FullAttempts:20 },'+
         'Lang:   {NeedResearch:9,  BuildCost:20, Attempts:0, FullAttempts:30 },'+
         'Resume: {NeedResearch:13, BuildCost:30, Attempts:0, FullAttempts:40 },'+
         'New:    {NeedResearch:17, BuildCost:50, Attempts:0, FullAttempts:50 }'+
    '}}';
    /// состояние меню при первом запуске

type
    TSkillComponents = record

    end;

    TMenu = class
        bBuild
       ,iChest
       ,layGold
       ,layConstruction
            : TControl;

        sklComponent: TDictionary<String, TControl>;

        data: ISuperObject;
        timer: TTimer;

        isChestCkicked
                : boolean;

        WorkKey: string;
            /// ключ из объекта Objects, который в данный момент "строим"

        procedure Init;

        procedure LinkSkillComponent(key: string; comp: TControl);
        procedure AddCoin;
        procedure UpdateInterface;
    private
        procedure ButtonMouseEnter(Sender: TObject);
        procedure ButtonMouseLeave(Sender: TObject);
        procedure ChestClick(Sender: TObject);
        procedure onTimer(Sender: TObject);
        procedure OnSkillUpClick(Sender: TObject);
        function GetTextHash(text: string): integer;
        procedure OnBuildClick(Sender: TObject);
    end;

var
    Menu : TMenu;

implementation

uses
    uMain;

procedure TMenu.UpdateInterface;
var
    item : TSuperAvlEntry;
    i, need: integer;
begin
    (layGold.Controls[1] as TLabel).Text := data.S['Gold'];
    layGold.Visible := data.I['Gold'] > 0;

    /// отслеживаем первоначальный показ навыка науки
    if (data.I['Gold'] >= data.I['Skills.Research.NeedGold']) and
       (data.I['Skills.Research.Level'] = 0)
    then data.I['Skills.Research.Level'] := 1;


    for item in data['Skills'].AsObject do
    begin
        ///  прверка на показ скрытых навыков
        ///  для этого требуется состояние неоткрытого и текущее колво денег
        ///  равное NeedGold
        if  (data.I['Skills.' + item.name + '.Enabled'] = 0) and
            (data.I['Skills.Research.Level'] >= data.I['Skills.' + item.name + '.NeedResearch'] )
        then
            data.I['Skills.' + item.name + '.Enabled'] := 1;

        sklComponent[item.name].Visible := data.I['Skills.' + item.name + '.Enabled'] <> 0;

        /// показ текущего уровня
        for I := 0 to sklComponent[item.name].ControlsCount-1 do
        /// ищем лабел с числовым значеним
        if (sklComponent[item.name].Controls[i] is TLabel) and
           (StrToIntDef((sklComponent[item.name].Controls[i] as TLabel).Text, -1) > -1)
        then
            (sklComponent[item.name].Controls[i] as TLabel).Text :=
                data.S['Skills.' + item.name + '.Level'];

        /// проверка на показ кнопки апдейта
        need := (data.I['Skills.' + item.name + '.Level']) *
                data.I['Skills.' + item.name + '.NeedGold'];
        /// ищем объект кнопки
        for I := 0 to sklComponent[item.name].ControlsCount-1 do
        if (sklComponent[item.name].Controls[i] is TRectangle) then
           (sklComponent[item.name].Controls[i] as TRectangle).Visible :=
               need <= data.I['Gold'];

    end;


    /// рассматриваем элементы интерфейса, если нет в работе
//    if WorkKey = '' then
    for item in data['Objects'].AsObject do
    begin

        /// объект не "исследован" - скрываем
        if (data.I['Objects.' + item.name + '.NeedResearch'] > data.I['Skills.Research.Level']) and
           (data.I['Objects.' + item.name + '.Attempts'] < data.I['Objects.' + item.name + '.FullAttempts'])
        then
            sklComponent[item.name].Visible := false;

        /// объект исследован и завершен
        if (data.I['Objects.' + item.name + '.NeedResearch'] <= data.I['Skills.Research.Level']) and
           (data.I['Objects.' + item.name + '.Attempts'] >= data.I['Objects.' + item.name + '.FullAttempts'])
        then
        begin
            layConstruction.Visible := false;
            sklComponent[item.name].Visible := true;
        end;

        /// объект уже "исследован" и еще не завершен
        if (data.I['Objects.' + item.name + '.NeedResearch'] <= data.I['Skills.Research.Level']) and
           (data.I['Objects.' + item.name + '.Attempts'] < data.I['Objects.' + item.name + '.FullAttempts'])
        then
        begin
            /// запоминаем объект с которым работаем для обработчика события кнопки строительства
            WorkKey := item.Name;

            /// показываем значок строительства в центре позиции "отстраиваемого" объекта
            layConstruction.Position.X :=
                 sklComponent[item.name].Position.X + (sklComponent[item.name].Width - layConstruction.Width) / 2;
            layConstruction.Position.Y :=
                 sklComponent[item.name].Position.Y + (sklComponent[item.name].Height - layConstruction.Height) / 2;

            /// выставляем прогресс
            for I := 0 to layConstruction.ControlsCount-1 do
            if layConstruction.Controls[i] is TLayout then
            begin
                layConstruction.Controls[i].Controls[0].Width :=
                    (layConstruction.Controls[i].Width / data.I['Objects.' + item.name + '.FullAttempts']) * data.I['Objects.' + item.name + '.Attempts'];

                /// выставляем полное закругление, если в данный момент нулевой прогресс стройки
                if layConstruction.Controls[i].Controls[0].Width = 0
                then (layConstruction.Controls[i].Controls[1] as TRoundRect).Corners := [TCorner.TopLeft,TCorner.TopRight,TCorner.BottomLeft,TCorner.BottomRight]
                else (layConstruction.Controls[i].Controls[1] as TRoundRect).Corners := [TCorner.TopRight,TCorner.BottomRight];

            end;

            layConstruction.Visible := true;

            /// если золота достаточно для постройки (с учетом бонуса удешевления стройки)
            /// показываем кнопку постройки
            bBuild.Visible := data.I['Gold'] >= Max(data.I['Objects.' + item.name + '.BuildCost'] - data.I['Skills.BuildEconomy.Level'], 1);
        end;

    end;

end;

procedure TMenu.AddCoin;
begin
    data.I['Gold'] := data.I['Gold'] + data.I['Skills.MoneyEaring.Level'];
end;




procedure TMenu.onTimer(Sender: TObject);
begin
    if isChestCkicked then
    begin
      fMain.iChestActive.Visible := false;
      fMain.iChestDef.Visible := true;
      isChestCkicked := false;
    end;
end;




procedure TMenu.ChestClick(Sender: TObject);
begin
    (Sender as TImage).Visible := false;
    fMain.iChestActive.Visible := true;
    isChestCkicked := true;

    AddCoin;
    UpdateInterface;
end;

function TMenu.GetTextHash(text: string): integer;
var
    j : integer;
begin
    result := 0;
    for j := 1 to Length(text) do
        result := result + Integer(text[j]);
end;

procedure TMenu.Init;
begin
    sklComponent['New'].OnMouseEnter    := ButtonMouseEnter;
    sklComponent['Resume'].OnMouseEnter := ButtonMouseEnter;
    sklComponent['Lang'].OnMouseEnter   := ButtonMouseEnter;
    sklComponent['Exit'].OnMouseEnter   := ButtonMouseEnter;

    sklComponent['New'].OnMouseLeave    := ButtonMouseLeave;
    sklComponent['Resume'].OnMouseLeave := ButtonMouseLeave;
    sklComponent['Lang'].OnMouseLeave   := ButtonMouseLeave;
    sklComponent['Exit'].OnMouseLeave   := ButtonMouseLeave;

    iChest.OnClick       := Menu.ChestClick;

    data := SO(def);

    Menu.timer := TTimer.Create(nil);
    Menu.timer.Interval := 100;
    Menu.timer.OnTimer := Menu.onTimer;

    WorkKey := '';

    layConstruction.Visible := false;

    bBuild.OnClick := OnBuildClick;
    bBuild.Visible := false;

    UpdateInterface;
end;

procedure TMenu.LinkSkillComponent(key: string; comp: TControl);
var
    i, hash: integer;
begin
    sklComponent.Add(key, comp);
    // вешаем обработчик клика на кнопку апгрейда
    for I := 0 to comp.ControlsCount-1 do
    if comp.Controls[i] is TRectangle then
    begin
         /// вешаем обработчик
         (comp.Controls[i] as TRectangle).OnClick := OnSkillUpClick;
         /// в тэг пишем "хэш" ключа, чтобы при клике потом найти к какому навыку это относится
         hash := GetTextHash(key);
         (comp.Controls[i] as TRectangle).Tag := hash;
    end;

end;

procedure TMenu.OnBuildClick(Sender: TObject);
begin
    /// списываем золото за апгрейд
    data.I['Gold'] := data.I['Gold'] - Max(data.I['Objects.' + WorkKey + '.BuildCost'] - data.I['Skills.BuildEconomy.Level'], 1);
    /// уменьшаем количество необходимых попыток, с учетом бонуса
    data.I['Objects.' + WorkKey + '.Attempts'] := data.I['Objects.' + WorkKey + '.Attempts'] + 1 + data.I['Skills.BuildSpeed.Level'];

    UpdateInterface;
end;

procedure TMenu.OnSkillUpClick(Sender: TObject);
/// увеличиваем уроаень скила. при этом, проверка выполнения условий возможности
/// улучшения нас не интересуют
var
    item : TSuperAvlEntry;
    hash, tag: integer;
begin
    /// ищем скил, к которомк привязана кнопка
    for item in data['Skills'].AsObject do
    begin
      hash := GetTextHash(item.name);
      tag := (Sender as TComponent).Tag;
      if hash = tag then
      begin
          /// списываем золото
          data.I['Gold'] :=
              data.I['Gold'] -
                  data.I['Skills.' + item.name + '.NeedGold'] * data.I['Skills.' + item.name + '.Level'];

          /// увеличиваем уровень
          data.I['Skills.' + item.name + '.Level'] :=
              data.I['Skills.' + item.name + '.Level'] + 1;

          UpdateInterface;
      end;
    end;
end;

procedure TMenu.ButtonMouseEnter(Sender: TObject);
begin
    (sender as TRoundRect).Fill.Color := $FF2D4A69;
    ((sender as TRoundRect).Children.Items[0] as TLabel).TextSettings.FontColor := TAlphaColorRec.Lightsteelblue;
end;

procedure TMenu.ButtonMouseLeave(Sender: TObject);
begin
    (sender as TRoundRect).Fill.Color := TAlphaColorRec.Lightsteelblue;
    ((sender as TRoundRect).Children.Items[0] as TLabel).TextSettings.FontColor := $FF2D4A69;
end;

initialization

    Menu := TMenu.Create;
    Menu.sklComponent := TDictionary<String,TControl>.Create();

finalization

    Menu.sklComponent.Free;
    Menu.timer.Free;
    Menu.Free;
end.
