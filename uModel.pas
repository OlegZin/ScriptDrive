unit uModel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uScriptDrive, Vcl.StdCtrls, Vcl.ExtCtrls, StrUtils,
  Vcl.ComCtrls, Vcl.Menus, Vcl.Buttons, math, superobject;

type
  TForm3 = class(TForm)
    bResetTower: TButton;
    mLog: TMemo;
    bAttack: TButton;
    lPlayerInfo: TLabel;
    lStep: TLabel;
    lCreatureInfo: TLabel;
    cbItem: TComboBox;
    bUseItem: TButton;
    cbSkills: TComboBox;
    bSkillUse: TButton;
    lNeedExp: TLabel;
    cbAutoAttack: TCheckBox;
    tAutoAttack: TTimer;
    pcGame: TPageControl;
    pTower: TTabSheet;
    pCraft: TTabSheet;
    lbLoot: TListBox;
    bUpSkill: TButton;
    lTopStep: TLabel;
    lTarget: TLabel;
    lBuffs: TLabel;
    MainMenu1: TMainMenu;
    mmiLang: TMenuItem;
    mmiEng: TMenuItem;
    mmiRus: TMenuItem;
    pThink: TTabSheet;
    bThink: TButton;
    cbAutoThink: TCheckBox;
    mThinkLog: TMemo;
    lbThinkList: TListBox;
    ComboBox1: TComboBox;
    pSecrets: TTabSheet;
    mSecrets: TMemo;
    pFloors: TTabSheet;
    pcCraft: TPageControl;
    pPotionsResearch: TTabSheet;
    cbPotionSelect: TComboBox;
    bPotionResearch: TButton;
    Panel2: TPanel;
    Memo1: TMemo;
    pResourceResearch: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    cbPotionPart1: TComboBox;
    cbPotionPart1Count: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    Label5: TLabel;
    ComboBox5: TComboBox;
    ComboBox6: TComboBox;
    Label6: TLabel;
    ComboBox7: TComboBox;
    ComboBox8: TComboBox;
    Label8: TLabel;
    Label9: TLabel;
    ComboBox9: TComboBox;
    Button1: TButton;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    SpeedButton1: TSpeedButton;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    mFloorLog: TMemo;
    pnlFloor: TPanel;
    Panel1: TPanel;
    mmiAuto: TLabel;
    pTools: TTabSheet;
    lbTools: TListBox;
    lToolName: TLabel;
    lToolDesc: TLabel;
    bToolUpgrade: TButton;
    lToolUpCost: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure bResetTowerClick(Sender: TObject);
    procedure log(text: string);
    procedure FormShow(Sender: TObject);
    procedure bAttackClick(Sender: TObject);
    procedure bLvlUpClick(Sender: TObject);
    procedure tAutoAttackTimer(Sender: TObject);
    procedure bUseItemClick(Sender: TObject);
    procedure mmiEngClick(Sender: TObject);
    procedure mmiRusClick(Sender: TObject);
    procedure bSkillUseClick(Sender: TObject);
    procedure bUpSkillClick(Sender: TObject);
    procedure pcGameChange(Sender: TObject);
    procedure bThinkClick(Sender: TObject);
    procedure lbThinkListClick(Sender: TObject);
    procedure OnClickFloorButton(Sender: TObject);
    procedure lbToolsClick(Sender: TObject);
    procedure bToolUpgradeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CurrLang: string;
    procedure SetLang(lang: string);
    procedure updateThinkInterface;
    procedure UpdateInterface;
    procedure updateSecretsInterface;
    procedure UpdateFloorInterface;
    procedure UpdateToolInterface;
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}


uses uData;

const
    UNKNOWN_BUTTON = '??????';

var
    oldPlayerItems
   ,oldPlayerLoot
   ,oldPlayerSkills
   ,AllowModes
   ,SelectedTool
            : string;
    topFloor
   ,CurrFloor  // ������� ����
   ,LastFloor  // ��������� ���� ��� �������� ������������ ����� ����
   ,NeedToToolUp
            : integer;
    LastFloorObject
            : TButton;
    sobj : ISuperObject;




procedure TForm3.FormShow(Sender: TObject);
begin
    sobj := SO();

    mLog.Lines.Clear;

    Script.Exec('SetLang(ENG)');
    SetLang('ENG');
{
    Script.Exec('AllowMode(Think, 1)');
    Script.Exec('AllowMode(Secrets, 1)');
    Script.Exec('AllowMode(Craft, 1)');
    Script.Exec('AllowMode(Floors, 1)');
    Script.Exec('AllowMode(Tools, 1)');
    Script.Exec('AllowTool(Shovel)');
    Script.Exec('AllowTool(Pick)');
    Script.Exec('AllowTool(Axe)');
    Script.Exec('AllowTool(Key)');
    Script.Exec('AllowTool(Sword)');
    Script.Exec('AllowTool(LifeAmulet)');
    Script.Exec('AllowTool(TimeSand)');
    Script.Exec('AllowTool(Leggings)');
}
    Script.Exec('AllowMode(Craft, 1)');

    pcGame.ActivePageIndex := pTower.TabIndex;

    Script.Exec('InitGame();InitPlayer();CurrentLevel(1);InitCreatures();SetAutoATK(1000);');

    UpdateInterface;

end;


procedure TForm3.pcGameChange(Sender: TObject);
begin
    UpdateInterface;
end;





procedure TForm3.UpdateToolInterface;
var
    i: integer;
    capt : string;
    currGold : integer;

begin
    if pcGame.ActivePage <> pTools then exit;

    /// ��������� ������ ��������� ������������
    lbTools.Items.CommaText := Script.Exec('GetToolsList()');

    for I := 0 to lbTools.Items.Count-1 do
    if lbTools.Items[i] = SelectedTool then
    lbTools.ItemIndex := i;


    if lbTools.ItemIndex = -1 then
    if lbTools.Items.Count > 0 then
    begin
        lbTools.ItemIndex := 0;
        SelectedTool := lbTools.Items[0];
    end else
        exit;

    capt := lbTools.Items[lbTools.ItemIndex];
    lToolName.Caption := capt + ' ('+ Script.Exec('GetToolAttr('+capt+',lvl)')+')';
    lToolDesc.Caption := Script.Exec('GetToolAttr('+capt+',desc)');

    NeedToToolUp := StrToInt(Script.Exec('NeedToolUpgrade('+capt+')'));
    currGold := StrToIntDef(Script.Exec('GetPlayerItemCount(Gold)'), 0);

    if Script.Exec('GetLang()') = 'RU' then lToolUpCost.Caption := '����: ' + IntToStr(NeedToToolUp) + ' ������';
    if Script.Exec('GetLang()') = 'ENG' then lToolUpCost.Caption := 'Cost: ' + IntToStr(NeedToToolUp) + ' Gold';

    bToolUpgrade.Enabled := currGold >= NeedToToolUp;
end;

procedure TForm3.lbToolsClick(Sender: TObject);
begin
    if lbTools.ItemIndex = -1 then exit;

    SelectedTool := lbTools.Items[lbTools.ItemIndex];

    UpdateToolInterface;
end;

procedure TForm3.bToolUpgradeClick(Sender: TObject);
var
    capt : string;
begin
    if lbTools.ItemIndex = -1 then exit;

    Data.ToolUpgrade(SelectedTool);

    UpdateInterface;
end;






procedure TForm3.updateSecretsInterface;
/// ������� � ������ ������� ���� ��������� � ������
var
    s: string;
begin
    if mSecrets.Text = '' then
    begin
        s := Data.GetGameScripts;
        s := StringReplace(s, ';', ';'+sLineBreak, [rfReplaceAll]);
        mSecrets.Text := s;
    end;
end;




procedure TForm3.updateThinkInterface;
var
    log: string;
    i: integer;
    capt: string;
begin

    if pcGame.ActivePage <> pThink then exit;

    if lbThinkList.ItemIndex <> -1 then
    capt := copy(
       lbThinkList.Items[lbThinkList.ItemIndex],
       0,
       pos(' (', lbThinkList.Items[lbThinkList.ItemIndex])-2
    ) else capt := '';


    lbThinkList.Items.StrictDelimiter := true;
    lbThinkList.Items.CommaText := Script.Exec('GetThinks();');

    if capt <> '' then
    for I := 0 to lbThinkList.Count-1 do
    if   pos(capt, lbThinkList.Items[i]) > 0
    then lbThinkList.ItemIndex := i;

    // ���� ����������� ��������� - ���������� ����� ����������, ����� �� ������� ������������
    if cbAutoThink.Checked and (lbThinkList.ItemIndex = -1) then
    begin
        cbAutoThink.Checked := false;
    end;

    // ��������� ����� ����������, ���� ���� �� �������
    cbAutoThink.Enabled := lbThinkList.ItemIndex <> -1;

    log := Script.Exec('GetThinkEvents();');
    if log <> '' then mThinkLog.Text := log + sLineBreak + mThinkLog.Text;
end;

procedure TForm3.bThinkClick(Sender: TObject);
var
    capt: string;
begin
    if lbThinkList.ItemIndex = -1 then exit;
    capt := Copy( lbThinkList.Items[lbThinkList.ItemIndex], 0, pos(' (', lbThinkList.Items[lbThinkList.ItemIndex])-2 );
    Script.Exec('ProcessThinks('+capt+', -1)');
    updateThinkInterface;
    UpdateInterface;
end;

procedure TForm3.lbThinkListClick(Sender: TObject);
begin
    cbAutoThink.Enabled := lbThinkList.ItemIndex <> -1;
end;









procedure TForm3.UpdateFloorInterface;
var
    trash: integer;
    i: Integer;
    b: TButton;
    event, size: string;
    pars: TStringList;
begin

    if pcGame.ActivePage <> pFloors then exit;

    // ������������� ���������
    cbAutoAttack.Checked := false;

    if CurrFloor <> LastFloor then
    begin

        pars := TStringList.Create;

        LastFloor := CurrFloor;

        for i := pnlFloor.ControlCount-1 downto 0 do
            pnlFloor.Controls[i].Free;

        trash := StrToIntDef( Data.GetTrashCount,0 );
        pars.CommaText := Data.GetTrashIDs;

        for i := 0 to trash-1 do
        begin
            size := Script.Exec('GetFloorObjectSize('+pars[i]+')');

            b := TButton.Create(self);
            b.Parent := pnlFloor;

            if (size = 'normal') or (size = '') then
            begin
                b.Height := Round(pFloors.ClientHeight / 10);
                b.Width := Round(Max(pFloors.ClientWidth / 10, 80));
            end;
            if (size = 'huge') or (size = '') then
            begin
                b.Height := Round(pFloors.ClientHeight / 2);
                b.Width := Round(pFloors.ClientWidth / 2);
                b.BringToFront;
            end;

            b.Caption := UNKNOWN_BUTTON;
            b.Tag := StrToInt(pars[i]);
            b.Left := Random(pFloors.ClientWidth - b.Width);
            b.top := Random(pFloors.ClientHeight - b.Height - mFloorLog.Height);
            b.OnClick := OnClickFloorButton;
        end;

        /// ��� ������� ���������� ������ ����������� ������ ���������.
        /// ��� ����� ���� �������������� ����� ��� ��������� ������
        /// (���� ������� ����� ������)
        if trash = 0 then
        begin

        end;

        pars.Free;
    end;

    event := Script.Exec('GetFloorEvents();');
    if event <> '' then
    if   Trim(mFloorLog.Text) <> ''
    then mFloorLog.Text := event + sLineBreak + mFloorLog.Text
    else mFloorLog.Text := event;

end;

procedure TForm3.OnClickFloorButton(Sender: TObject);
var
    btn: TButton;
begin
    btn := sender as TButton;

    if LastFloorObject <> btn then
    begin
        LastFloorObject := btn;
        exit;
    end;

    /// ������������ ������ �� id ������
    btn.Caption := Script.Exec('ProcessFloorObject('+IntTostr(btn.tag)+');CheckStatus();');

    /// ������ ��������� ������� ��������, ��� ������ ���� ���������� - �������
    if btn.Caption = '' then btn.Visible := false;

    /// ���� ������� ��������� ������ - ������� ����������� ���������
    UpdateInterface;
    UpdateFloorInterface;
end;




procedure TForm3.bUpSkillClick(Sender: TObject);
begin
    if cbSkills.ItemIndex = -1 then exit;
    Script.Exec('UpSkill('+Copy(cbSkills.Text, 0, Pos('=', cbSkills.Text)-1)+')CreatureAttack();CheckStatus();');
    UpdateInterface;
end;

procedure TForm3.bUseItemClick(Sender: TObject);
begin
    if cbItem.ItemIndex = -1 then exit;
    Script.Exec('UseItem('+Copy(cbItem.Text, 0, Pos('=', cbItem.Text)-1)+');CreatureAttack();CheckStatus();');
    UpdateInterface;
end;

procedure TForm3.bLvlUpClick(Sender: TObject);
begin
    Script.Exec('LevelUpPlayer()');
    UpdateInterface;
end;

procedure TForm3.bSkillUseClick(Sender: TObject);
begin
    if cbSkills.ItemIndex = -1 then exit;
    Script.Exec('UseSkill('+Copy(cbSkills.Text, 0, Pos('=', cbSkills.Text)-1)+');CreatureAttack();CheckStatus();');
    UpdateInterface;
end;


procedure TForm3.bResetTowerClick(Sender: TObject);
var i: integer;
begin
    Script.Exec('CurrentLevel(1);InitCreatures();');
    UpdateInterface;
end;


procedure TForm3.bAttackClick(Sender: TObject);
begin
    Script.Exec('PlayerAttack();CreatureAttack();CheckStatus();');
    UpdateInterface;
end;


procedure TForm3.tAutoAttackTimer(Sender: TObject);
begin

    if   Script.Exec('ProcessAuto()') <> '' then UpdateInterface;

    if cbAutoAttack.Checked then
    begin
        Script.Exec('ChangeAutoATK(-1)');
        bAttack.Click;
    end;

    if cbAutoThink.Checked then
    begin
        Script.Exec('ChangeAutoATK(-1)');
        bThink.Click;
    end;
end;

procedure TForm3.UpdateInterface;
var
    itemItem, itemSkill: integer;
    AutoCount: integer;
    tmp, exp, lvl, selItem, selSkill, reg, breaks: string;
    step: integer;
    pars: TstringList;
    i: Integer;
    item : TSuperAvlEntry;
begin
    pars := TStringList.Create;

    if cbItem.ItemIndex <> -1
    then selItem := Copy(cbItem.Text,0,pos('=',cbItem.Text)-1)
    else selItem := '';

    if cbSkills.ItemIndex <> -1
    then selSkill := Copy(cbSkills.Text,0,pos('=',cbSkills.Text)-1)
    else selSkill := '';


    // ��������� ������� ��������� �������
    AllowModes := Script.Exec('GetAllowModes()');
    // ����������� �����������
    pThink.TabVisible := Pos( 'Think', AllowModes ) > 0;
    // ����������� ������
    pCraft.TabVisible := Pos( 'Craft', AllowModes ) > 0;
    pResourceResearch.TabVisible := Pos( 'ResResearch', AllowModes ) > 0;
    pPotionsResearch.TabVisible := Pos( 'PotionResearch', AllowModes ) > 0;
    // ����������� ��������� ��������
    pSecrets.TabVisible := Pos( 'Secrets', AllowModes ) > 0;
    // ����������� ������
    pFloors.TabVisible := Pos( 'Floors', AllowModes ) > 0;
    // ����������� ������������
    pTools.TabVisible := Pos( 'Tools', AllowModes ) > 0;

    breaks := Script.Exec('GetBreaks()');
    if pos('Tower', breaks) > 0 then
    begin
        cbAutoAttack.Checked := false;
    end;
    if pos('Think', breaks) > 0 then
    begin
        cbAutoThink.Checked := false;
    end;


    // ���� �� �������� / �������� �����
    CurrFloor := StrToIntDef(Script.Exec('GetCurrentLevel()'), 0);
    step := StrToIntDef(Script.Exec('CurrentStep()'), 0);
    if CurrFloor * 1000000 + step > topFloor then
       topFloor := CurrFloor * 1000000 + step;

    if CurrLang = 'ENG' then
    begin
      lStep.Caption    := 'Floor: ' + IntToStr(CurrFloor) + ', ' + IntToStr(step) + '/' + Script.Exec('StepCount()');
      ltopStep.Caption := 'Top: ' + IntToStr(topFloor div 1000000) + ', ' + IntToStr(topFloor mod 1000000);

      lTarget.Caption := 'Target: ' + Script.Exec('GetCurrTarget()') + ' floor';

      pFloors.Caption := 'Floor: ' + IntToStr(CurrFloor);
    end;

    if CurrLang = 'RU' then
    begin
      lStep.Caption    := '����: ' + IntToStr(CurrFloor) + ', ' + IntToStr(step) + '/' + Script.Exec('StepCount()');
      ltopStep.Caption := '������: ' + IntToStr(topFloor div 1000000) + ', ' + IntToStr(topFloor mod 1000000);

      lTarget.Caption := '����: ' + Script.Exec('GetCurrTarget()') + ' ����';

      pFloors.Caption := '����: ' + IntToStr(CurrFloor);
    end;

    // ���� ������������
    lCreatureInfo.Caption := ReplaceStr( Script.Exec('GetCurrCreatureInfo()'), ',', '  ' );


    // ���� �� ������
    sobj := SO( Script.Exec('GetPlayerInfo()') );

    exp := sobj.S['EXP'];
    sobj.Delete('EXP');

    lvl := sobj.S['LVL'];
    sobj.Delete('LVL');

    lPlayerInfo.Caption := '';
    for item in sobj.AsObject do
        lPlayerInfo.Caption := lPlayerInfo.Caption + item.Name + ': ' + item.Value.AsString + ' ';

    // ���� �� �������� ����� ������
    if CurrLang = 'ENG' then
        lNeedExp.Caption := 'Lvl: ' + lvl + ', ' + exp + '/' + Script.Exec('NeedExp(GetPlayerAttr(LVL))') + ' EXP';

    if CurrLang = 'RU' then
        lNeedExp.Caption := '��.: ' + lvl + ', ' + exp + '/' + Script.Exec('NeedExp(GetPlayerAttr(LVL))') + ' EXP';

    // ������� ���������� ����
    if CurrLang = 'ENG' then lBuffs.Caption := 'Regen: ';
    if CurrLang = 'RU' then lBuffs.Caption := '�����.: ';

    lBuffs.Caption := '';
    sobj := SO( Script.Exec('GetPlayerBuffs()') );
    for item in sobj.AsObject do
        lBuffs.Caption := lBuffs.Caption + item.Name + ': ' + item.Value.AsString;


    // ������ ���������
    tmp := Script.Exec('GetPlayerItems()');
    if (tmp <> oldPlayerItems) or (oldPlayerItems = '') then
    begin
        sobj := SO( tmp );

        cbItem.Items.Clear;
        for item in sobj.AsObject do
            cbItem.Items.Add(Item.Name + '=' + Item.Value.AsString);

        oldPlayerItems := tmp;
    end;


    // ������ ����������
    tmp := Script.Exec('GetPlayerSkills()');
    if (tmp <> oldPlayerSkills) or (oldPlayerSkills = '') then
    begin
        sobj := SO( tmp );

        cbSkills.Items.Clear;
        for item in sobj.AsObject do
            cbSkills.Items.Add(Item.Name + '=' + Item.Value.AsString);

        oldPlayerSkills := tmp;
    end;



    // ������ ��������
    tmp := Script.Exec('GetPlayerLoot()');
    if (tmp <> oldPlayerLoot) or (oldPlayerLoot = '') then
    begin
        sobj := SO( tmp );

        lbLoot.Items.Clear;
        for item in sobj.AsObject do
            lbLoot.Items.Add( Item.Name + '=' + Item.Value.AsString );

        oldPlayerLoot := tmp;
    end;




    /// ���������� ��������
    AutoCount := StrToIntDef(Script.Exec('GetAutoATK()'), 0);

    if AutoCount <= 0 then
    begin
        cbAutoAttack.Checked := false;
        cbAutoThink.Checked := false;
    end;
    cbAutoAttack.Enabled := AutoCount > 0;
    cbAutoThink.Enabled := AutoCount > 0;

    if CurrLang = 'ENG' then
        mmiAuto.Caption := 'AutoAction: ' + IntToStr(AutoCount);
    if CurrLang = 'RU' then
        mmiAuto.Caption := '������������: ' + IntToStr(AutoCount);

    /// �������� ��������
    tAutoAttack.Interval := StrToInt(Data.GetAutoSpeed);

    /// ����������� ������� � ����
    log(Script.Exec('GetEvents()'));

    /// ��������������� ������� � ������
    if selItem <> '' then
    for i := 0 to cbItem.Items.Count-1 do
    if Pos(selItem, cbItem.Items[i]) = 1 then
    begin
        cbItem.ItemIndex := i;
        break;
    end;

    if selSkill <> '' then
    for i := 0 to cbSkills.Items.Count-1 do
    if Pos(selSkill, cbSkills.Items[i]) = 1 then
    begin
        cbSkills.ItemIndex := i;
        break;
    end;

    pars.Free;

    updateThinkInterface;
    UpdateSecretsInterface;
    UpdateFloorInterface;
    UpdateToolInterface;
end;

procedure TForm3.log(text: string);
begin
    if text <> '' then
    mLog.Text := text + sLineBreak + mLog.Text;
    mLog.Text := Copy(mLog.Text, 0, 1000);
end;

procedure TForm3.mmiEngClick(Sender: TObject);
begin
    Script.Exec('SetLang(ENG)');
    SetLang('ENG');
    UpdateInterface;
end;

procedure TForm3.mmiRusClick(Sender: TObject);
begin
    Script.Exec('SetLang(RU)');
    SetLang('RU');
    UpdateInterface;
end;

procedure TForm3.SetLang(lang: string);
begin
    if CurrLang = lang
    then exit
    else CurrLang := lang;

    if CurrLang = 'RU' then
    begin
        mmiLang.Caption := 'Language';

        mmiEng.Caption := 'English';

        mmiRus.Caption := 'Russian';
        mmiRus.Checked := true;

        pTower.Caption := '�����';
        pThink.Caption := '��������';
        pSecrets.Caption := '�������';
        pCraft.Caption := '�������';
        pFloors.Caption := '����: ' + IntToStr(CurrFloor);
        pTools.Caption := '���������';

        bResetTower.Caption := '����������';
        bUseItem.Caption := '���.!';
        bSkillUse.Caption := '���.!';
        bUpSkill.Caption := '��.!';

        bThink.Caption := '������...';
        bToolUpgrade.Caption := '��������!';
    end;

    if CurrLang = 'ENG' then
    begin
        mmiLang.Caption := '����';

        mmiEng.Caption := '����������';
        mmiEng.Checked := true;

        mmiRus.Caption := '�������';


        pTower.Caption := 'Tower';
        pThink.Caption := 'Think';
        pSecrets.Caption := 'Secrets';
        pCraft.Caption := 'Craft';
        pFloors.Caption := 'Floor: ' + IntToStr(CurrFloor);
        pTools.Caption := 'Artifacts';

        bResetTower.Caption := 'Restart';
        bUseItem.Caption := 'Use!';
        bSkillUse.Caption := 'Use!';
        bUpSkill.Caption := 'Up!';

        bThink.Caption := 'Think...';
        bToolUpgrade.Caption := 'Upgrade!';
    end;

end;

procedure TForm3.FormCreate(Sender: TObject);
begin
    Script := TScriptDrive.Create;
    Script.SetClass(TData, Data);
end;

end.
