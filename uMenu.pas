unit uMenu;

interface

uses
    superobject,
    System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
    FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
    FMX.Controls.Presentation, FMX.Edit, FMX.ComboEdit, FMX.ComboTrackBar,
    FMX.StdCtrls, FMX.WebBrowser, FMX.TabControl, FMX.Objects, FMX.Layouts,
    Generics.Collections, Math, FMX.Ani;

type
    TSkillComponents = record

    end;

    TMenu = class
        bBuild
       ,iChest
       ,iChestBG
       ,layGold
       ,layConstruction
            : TControl;

        sklComponent: TDictionary<String, TControl>;

        data: ISuperObject;
        timer: TTimer;

        isChestCkicked
       ,isFirstUpdate
                : boolean;

        WorkKey: string;
            /// ���� �� ������� Objects, ������� � ������ ������ "������"

        procedure Init;

        procedure LinkSkillComponent(key: string; comp: TControl);
        procedure AddCoin;
        procedure UpdateInterface;

        procedure SaveData;
        procedure LoadData;
    private
        procedure ButtonMouseEnter(Sender: TObject);
        procedure ButtonMouseLeave(Sender: TObject);
        procedure ChestClick(Sender: TObject);
        procedure onTimer(Sender: TObject);
        procedure OnSkillUpClick(Sender: TObject);
        function GetTextHash(text: string): integer;
        procedure OnBuildClick(Sender: TObject);
        procedure OnLangClick(Sender: TObject);

        procedure UpdateLang;
    end;

var
    Menu : TMenu;

implementation

uses
    uMain, uConst;

procedure TMenu.UpdateInterface;
var
    item : TSuperAvlEntry;
    i, need: integer;
    Cnt: TControl;
    HasUnfinished: boolean;
        /// ���� ����� �������� ���� �������� �� ������� ���������������,
        /// ��� ������� ���������� ������� �������
    delay: real;
begin
    if not Assigned(data) then exit;

    HasUnfinished := false;

    if data.I['IntroOver'] = 0 then
    begin

    for item in data['Skills'].AsObject do
    begin
        ///  ������� �� ����� ������� �������
        ///  ��� ����� ��������� ��������� ����������� � ������� ����� �����
        ///  ������ NeedGold
        if  (data.I['Skills.' + item.name + '.Enabled'] = 0) and
            (data.I['Skills.Research.Level'] >= data.I['Skills.' + item.name + '.NeedResearch'] )
        then
            data.I['Skills.' + item.name + '.Enabled'] := 1;

        if sklComponent.TryGetValue(item.name, Cnt) then
        begin

            Cnt.Visible := data.I['Skills.' + item.name + '.Enabled'] <> 0;

            /// ����� �������� ������
            for I := 0 to Cnt.ControlsCount-1 do
            /// ���� ����� � �������� ��������
            if (Cnt.Controls[i] is TLabel) and
               (StrToIntDef((Cnt.Controls[i] as TLabel).Text, -1) > -1)
            then
                (Cnt.Controls[i] as TLabel).Text :=
                    data.S['Skills.' + item.name + '.Level'];

            /// �������� �� ����� ������ �������
            /// ��� ���� ���� �� ����� ���� ������� (���� ���� ��������� ������� - �������)
            need := Max((data.I['Skills.' + item.name + '.Level']) *
                    data.I['Skills.' + item.name + '.NeedGold'], data.I['Skills.' + item.name + '.NeedGold']);
            /// ���� ������ ������
            for I := 0 to Cnt.ControlsCount-1 do
            if (Cnt.Controls[i] is TRectangle) then
               (Cnt.Controls[i] as TRectangle).Visible :=
                   need <= data.I['Gold'];

        end;
    end;


    /// ������������� �������� ����������, ���� ��� � ������
    for item in data['Objects'].AsObject do
    begin

        /// ������ ���������� � ��������
        if (data.I['Objects.' + item.name + '.NeedResearch'] <= data.I['Skills.Research.Level']) and
           (data.I['Objects.' + item.name + '.Attempts'] >= data.I['Objects.' + item.name + '.FullAttempts']) and
           (WorkKey = item.Name)
        then
        begin
            if Pos('Tower', WorkKey ) > 0
            then data.I['NewLevel'] := data.I['NewLevel'] + 1;

            layConstruction.Visible := false;
            sklComponent[item.name].Visible := true;
            WorkKey := '';
            bBuild.Visible := false;

        end;

        /// ������ �� "����������" - ��������
        if (data.I['Objects.' + item.name + '.Attempts'] < data.I['Objects.' + item.name + '.FullAttempts']) then
        begin
            if sklComponent.TryGetValue(item.name, Cnt) then Cnt.Visible := false;
            HasUnfinished := true;
        end;

        /// ������ ��� "����������" � ��� �� ��������
        if (data.I['Objects.' + item.name + '.NeedResearch'] <= data.I['Skills.Research.Level']) and
           (data.I['Objects.' + item.name + '.Attempts'] < data.I['Objects.' + item.name + '.FullAttempts']) and
           ((WorkKey = '') or (WorkKey = item.Name))
        then
        begin
            /// ���������� ������ � ������� �������� ��� ����������� ������� ������ �������������
            WorkKey := item.Name;

            /// ���������� ������ ������������� � ������ ������� "��������������" �������
            if sklComponent.TryGetValue(item.name, Cnt) then
            begin
                layConstruction.Position.X := Cnt.Position.X + (Cnt.Width - layConstruction.Width) / 2;
                layConstruction.Position.Y := Cnt.Position.Y + (Cnt.Height - layConstruction.Height) / 2;
            end;

            /// ���������� ��������
            for I := 0 to layConstruction.ControlsCount-1 do
            if layConstruction.Controls[i] is TLayout then
            begin
                layConstruction.Controls[i].Controls[0].Width :=
                    (layConstruction.Controls[i].Width / data.I['Objects.' + item.name + '.FullAttempts']) * data.I['Objects.' + item.name + '.Attempts'];

                /// ���������� ������ �����������, ���� � ������ ������ ������� �������� �������
                if layConstruction.Controls[i].Controls[0].Width = 0
                then (layConstruction.Controls[i].Controls[1] as TRoundRect).Corners := [TCorner.TopLeft,TCorner.TopRight,TCorner.BottomLeft,TCorner.BottomRight]
                else (layConstruction.Controls[i].Controls[1] as TRoundRect).Corners := [TCorner.TopRight,TCorner.BottomRight];

            end;

            layConstruction.Visible := true;

            /// ���� ������ ���������� ��� ��������� (� ������ ������ ����������� �������)
            /// ���������� ������ ���������
            bBuild.Visible := data.I['Gold'] >= Max(data.I['Objects.' + item.name + '.BuildCost'] - data.I['Skills.BuildEconomy.Level'], 1);
        end;

    end;

    end; /// if data.I['IntroOver'] = 0

    /// ����� � ����� ������� ������
    for I := 0 to layGold.ControlsCount-1 do
    if (layGold.Controls[i] is TLabel)
    then (layGold.Controls[i] as TLabel).Text := data.S['Gold'];

    /// ���������� ����� � �������, ���� �� �������
    layGold.Visible := data.I['Gold'] > 0;

    /// ����������� �������������� ����� ������ �����
    if (data.I['Gold'] >= data.I['Skills.Research.NeedGold']) and
       (data.I['Skills.Research.Level'] = 0)
    then data.I['Skills.Research.Level'] := 1;

    /// ���������� ������� ����� ����
    if sklComponent.TryGetValue('MenuNew', Cnt) then
    ((Cnt.Controls[0]).Controls[1] as TLabel).Text := 'Level ' + data.S['NewLevel'];

    /// ���� ����������� ��� ������� - ��������� ���� ���������� �������
    if not HasUnfinished or (data.I['IntroOver'] = 1) then
    begin
        /// ����� � ���, ��� �������� ���� ����� ���� ��������� � ����� ������
        /// � ���� �� ������ ���� ����� ����� �������� - �����-���� ���������
        /// � ����� ������� ������ ������, �����, ���� � �������� � ����������
        /// ��������� �������� � �������
        if isFirstUpdate
        then delay := 0
        else delay := 2;

        data.I['IntroOver'] := 1;
        timer.Enabled := false;

        for item in data['Skills'].AsObject do
            sklComponent[item.name].AnimateFloat('Opacity', 0, delay, TAnimationType.&In, TInterpolationType.Linear);

        for item in data['Objects'].AsObject do
        begin
            if Pos('Logo', item.name ) > 0 then
                sklComponent[item.name].AnimateFloat('Position.X', sklComponent[item.name].Position.X - 50, delay, TAnimationType.&In, TInterpolationType.Linear);

            if Pos('Tower', item.name ) > 0 then
                sklComponent[item.name].AnimateFloat('Position.X', sklComponent[item.name].Position.X - 100, delay, TAnimationType.&In, TInterpolationType.Linear);

            if Pos('Menu', item.name ) > 0 then
                sklComponent[item.name].AnimateFloat('Position.X', sklComponent[item.name].Position.X - 200, delay, TAnimationType.&In, TInterpolationType.Linear);
        end;

        bBuild.Visible := false;
        iChest.Visible := false;
        iChestBG.Visible := false;
        layGold.Visible := false;
        layConstruction.Visible := false;
    end;

    isFirstUpdate := false;
end;

procedure TMenu.AddCoin;
begin
    data.I['Gold'] := data.I['Gold'] + data.I['Skills.MoneyEaring.Level'];
end;




procedure TMenu.onTimer(Sender: TObject);
var
    i : integer;
begin
    if isChestCkicked then
    begin
      fMain.iChestActive.Visible := false;
      fMain.iChestDef.Visible := true;
      isChestCkicked := false;
    end;

    if data.I['Skills.AutoMoney.Level'] > 0 then
    begin
      /// ���������
      data.I['Gold'] := data.I['Gold'] + data.I['Skills.AutoMoney.Level'];
      UpdateInterface;
    end;

end;




procedure TMenu.SaveData;
begin
    data.SaveTo( DIR_DATA + FILE_MENU_DATA );
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
    sklComponent['MenuNew'].OnMouseEnter    := ButtonMouseEnter;
    sklComponent['MenuResume'].OnMouseEnter := ButtonMouseEnter;
    sklComponent['MenuLang'].OnMouseEnter   := ButtonMouseEnter;
    sklComponent['MenuExit'].OnMouseEnter   := ButtonMouseEnter;

    sklComponent['MenuNew'].OnMouseLeave    := ButtonMouseLeave;
    sklComponent['MenuResume'].OnMouseLeave := ButtonMouseLeave;
    sklComponent['MenuLang'].OnMouseLeave   := ButtonMouseLeave;
    sklComponent['MenuExit'].OnMouseLeave   := ButtonMouseLeave;

    sklComponent['MenuLang'].OnClick        := OnLangClick;

    iChest.OnClick       := Menu.ChestClick;

    LoadData;

    Menu.timer := TTimer.Create(nil);
    Menu.timer.Interval := 100;
    Menu.timer.OnTimer := Menu.onTimer;

    WorkKey := '';

    layConstruction.Visible := false;

    bBuild.OnClick := OnBuildClick;
    bBuild.Visible := false;

    isFirstUpdate := true;

    UpdateInterface;
    UpdateLang;
end;

procedure TMenu.LinkSkillComponent(key: string; comp: TControl);
var
    i, hash: integer;
begin
    sklComponent.Add(key, comp);
    // ������ ���������� ����� �� ������ ��������
    for I := 0 to comp.ControlsCount-1 do
    if comp.Controls[i] is TRectangle then
    begin
         /// ������ ����������
         (comp.Controls[i] as TRectangle).OnClick := OnSkillUpClick;
         /// � ��� ����� "���" �����, ����� ��� ����� ����� ����� � ������ ������ ��� ���������
         hash := GetTextHash(key);
         (comp.Controls[i] as TRectangle).Tag := hash;
    end;

end;

procedure TMenu.LoadData;
///  �������� ������ �������� ��������� ����
///  ��� ������ ������� ���� ��������� ����������� � ����� �� ���������
begin
    if DirectoryExists( DIR_DATA ) and FileExists( DIR_DATA + FILE_MENU_DATA )
    then data := TSuperObject.ParseFile( DIR_DATA + FILE_MENU_DATA, false )
    else data := SO( MENU_DATA_DEF );
end;

procedure TMenu.OnBuildClick(Sender: TObject);
begin
    /// ��������� ������ �� �������
    data.I['Gold'] := data.I['Gold'] - data.I['Objects.' + WorkKey + '.BuildCost'];
    /// ��������� ���������� ����������� �������, � ������ ������
    data.I['Objects.' + WorkKey + '.Attempts'] := data.I['Objects.' + WorkKey + '.Attempts'] + 1 + data.I['Skills.BuildSpeed.Level'];

    UpdateInterface;
end;

procedure TMenu.OnLangClick(Sender: TObject);
begin
    if   data.S['Lang'] = 'ENG'
    then data.S['Lang'] := 'RU'
    else data.S['Lang'] := 'ENG';

    UpdateLang;
end;

procedure TMenu.UpdateLang;
var
    item : TSuperAvlEntry;
    Cnt : TControl;
    i: Integer;
begin
    for item in data['Skills'].AsObject do
    begin
        Cnt := nil;
        sklComponent.TryGetValue(item.Name, Cnt);
        if Assigned(Cnt) then
        begin
            /// �������� ������ � ������� �����
            for I := 0 to Cnt.ControlsCount-1 do
            /// ���� ����� � �������� ��������
            if (Cnt.Controls[i] is TLabel) and
               (StrToIntDef((Cnt.Controls[i] as TLabel).Text, -1) = -1)
            then
                (Cnt.Controls[i] as TLabel).Text :=
                    data.S['Skills.' + item.name + '.Name.'+data.S['Lang']];
        end;
    end;

    for item in data['Objects'].AsObject do
    if Pos('Menu', item.Name) > 0 then
    begin
        (sklComponent[item.Name].Controls[0] as TLabel).Text :=
            data.S['Objects.' + item.name + '.Name.'+data.S['Lang']];
    end;

end;

procedure TMenu.OnSkillUpClick(Sender: TObject);
/// ����������� ������� �����. ��� ����, �������� ���������� ������� �����������
/// ��������� ��� �� ����������
var
    item : TSuperAvlEntry;
    hash, tag: integer;
begin
    /// ���� ����, � �������� ��������� ������
    for item in data['Skills'].AsObject do
    begin
      hash := GetTextHash(item.name);
      tag := (Sender as TComponent).Tag;
      if hash = tag then
      begin
          /// ��������� ������
          data.I['Gold'] :=
              data.I['Gold'] -
                  Max(data.I['Skills.' + item.name + '.NeedGold'] * data.I['Skills.' + item.name + '.Level'],
                      data.I['Skills.' + item.name + '.NeedGold']
                  );

          /// ����������� �������
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
