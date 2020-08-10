unit uModel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uScriptDrive, Vcl.StdCtrls, Vcl.ExtCtrls, StrUtils,
  Vcl.ComCtrls, Vcl.Menus;

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
    Label1: TLabel;
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
    mmiAuto: TMenuItem;
    mmiTowerAuto: TMenuItem;
    mmiThinkAuto: TMenuItem;
    mThinkLog: TMemo;
    lbThinkList: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure bResetTowerClick(Sender: TObject);
    procedure log(text: string);
    procedure FormShow(Sender: TObject);
    procedure bAttackClick(Sender: TObject);
    procedure UpdateInterface;
    procedure bLvlUpClick(Sender: TObject);
    procedure tAutoAttackTimer(Sender: TObject);
    procedure bUseItemClick(Sender: TObject);
    procedure mmiEngClick(Sender: TObject);
    procedure mmiRusClick(Sender: TObject);
    procedure bSkillUseClick(Sender: TObject);
    procedure bUpSkillClick(Sender: TObject);
    procedure cbAutoAttackClick(Sender: TObject);
    procedure mmiTowerAutoClick(Sender: TObject);
    procedure cbAutoThinkClick(Sender: TObject);
    procedure mmiThinkAutoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CurrLang: string;
    procedure SetLang(lang: string);
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses
    uData;

var
    oldPlayerItems
   ,oldPlayerLoot
   ,oldPlayerSkills
   ,AllowModes
            : string;
    topFloor: integer;

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


procedure TForm3.cbAutoAttackClick(Sender: TObject);
begin
    mmiTowerAuto.Checked := cbAutoAttack.Checked;
end;

procedure TForm3.cbAutoThinkClick(Sender: TObject);
begin
   mmiThinkAuto.Checked := cbAutoThink.Checked;
end;

procedure TForm3.bAttackClick(Sender: TObject);
begin
    Script.Exec('PlayerAttack();CreatureAttack();CheckStatus();');
    UpdateInterface;
end;

procedure TForm3.FormShow(Sender: TObject);
begin
    mLog.Lines.Clear;

    Script.Exec('SetLang(RU)');
    SetLang('RU');

    Script.Exec('AllowMode(Think, 1)');

    pcGame.ActivePageIndex := pTower.TabIndex;

    Script.Exec('InitPlayer();CurrentLevel(1);InitCreatures();SetAutoATK(1000);');

    UpdateInterface;

end;

procedure TForm3.tAutoAttackTimer(Sender: TObject);
begin

    if   Script.Exec('ProcessAuto()') <> ''
    then UpdateInterface;

    if cbAutoAttack.Checked then
    begin
        Script.Exec('ChangeAutoATK(-1)');
        bAttack.Click;
    end;

end;

procedure TForm3.UpdateInterface;
var
    itemItem, itemSkill: integer;
    AutoCount: integer;
    tmp, exp, lvl, selItem, selSkill, reg, breaks: string;
    floor, step: integer;
    pars: TstringList;
    i: Integer;
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
    // ������ �� ��������� ������������ ���������
    pars.CommaText := AllowModes;
    // ����������� �����������
    pThink.TabVisible := pars.IndexOfName( 'Think' ) <> -1;
    // ����������� ������
    pCraft.TabVisible := pars.IndexOfName( 'Craft' ) <> -1;


    breaks := Script.Exec('GetBreaks()');
    if pos('Tower', breaks) > 0 then
    begin
        mmiTowerAuto.Checked := false;
        cbAutoAttack.Checked := false;
    end;
    if pos('Think', breaks) > 0 then
    begin
        mmiThinkAuto.Checked := false;
        cbAutoThink.Checked := false;
    end;


    // ���� �� �������� / �������� �����
    floor := StrToIntDef(Script.Exec('GetCurrentLevel()'), 0);
    step := StrToIntDef(Script.Exec('CurrentStep()'), 0);
    if floor * 1000000 + step > topFloor then
       topFloor := floor * 1000000 + step;

    if CurrLang = 'ENG' then
    begin
      lStep.Caption    := 'Floor: ' + IntToStr(floor) + ', ' + IntToStr(step) + '/' + Script.Exec('StepCount()');
      ltopStep.Caption := 'Top: ' + IntToStr(topFloor div 1000000) + ', ' + IntToStr(topFloor mod 1000000);

      lTarget.Caption := 'Target: ' + Script.Exec('GetCurrTarget()') + ' floor';
    end;

    if CurrLang = 'RU' then
    begin
      lStep.Caption    := '����: ' + IntToStr(floor) + ', ' + IntToStr(step) + '/' + Script.Exec('StepCount()');
      ltopStep.Caption := '������: ' + IntToStr(topFloor div 1000000) + ', ' + IntToStr(topFloor mod 1000000);

      lTarget.Caption := '����: ' + Script.Exec('GetCurrTarget()') + ' ����';
    end;

    // ���� ������������
    lCreatureInfo.Caption := ReplaceStr( Script.Exec('GetCurrCreatureInfo()'), ',', '  ' );



    // ���� �� ������
    tmp := Script.Exec('GetPlayerInfo()');
    pars.CommaText := tmp;

    exp := pars.Values[ 'EXP' ];
    pars.Delete( pars.IndexOfName('EXP') );

    lvl := pars.Values[ 'LVL' ];
    pars.Delete( pars.IndexOfName('LVL') );

    lPlayerInfo.Caption := ReplaceStr( pars.CommaText, ',', '  ' );

    // ���� �� �������� ����� ������
    if CurrLang = 'ENG' then
        lNeedExp.Caption := 'Lvl: ' + lvl + ', ' + exp + '/' + Script.Exec('NeedExp(GetPlayerAttr(LVL))') + ' EXP';

    if CurrLang = 'RU' then
        lNeedExp.Caption := '��.: ' + lvl + ', ' + exp + '/' + Script.Exec('NeedExp(GetPlayerAttr(LVL))') + ' EXP';

    // ������� ���������� ����
    reg := Script.Exec('GetPlayerBuffs()');
    if CurrLang = 'ENG' then
        lBuffs.Caption := 'Regen: ' + reg;
    if CurrLang = 'RU' then
        lBuffs.Caption := '�����.: ' + reg;


    // ������ ���������
    tmp := Script.Exec('GetPlayerItems()');
    if (tmp <> oldPlayerItems) or (oldPlayerItems = '') then
    begin
        cbItem.Items.CommaText := tmp;
        oldPlayerItems := tmp;
    end;


    // ������ ����������
    tmp := Script.Exec('GetPlayerSkills()');
    if (tmp <> oldPlayerSkills) or (oldPlayerSkills = '') then
    begin
        cbSkills.Items.CommaText := tmp;
        oldPlayerSkills := tmp;
    end;


    // ������ ��������
    tmp := Script.Exec('GetPlayerLoot()');
    if (tmp <> oldPlayerLoot) or (oldPlayerLoot = '') then
    begin
        lbLoot.Items.CommaText := tmp;
        oldPlayerLoot := tmp;
    end;



    /// ���������� ��������
    AutoCount := StrToIntDef(Script.Exec('GetAutoATK()'), 0);

    if AutoCount <= 0 then
    begin
        cbAutoAttack.Checked := false;
        mmiTowerAuto.Checked := false;
        mmiThinkAuto.Checked := false;
    end;
    cbAutoAttack.Enabled := AutoCount > 0;
    mmiTowerAuto.Enabled := AutoCount > 0;
    mmiThinkAuto.Enabled := AutoCount > 0;

    if CurrLang = 'ENG' then
        mmiAuto.Caption := 'AutoAction: ' + IntToStr(AutoCount);
    if CurrLang = 'RU' then
        mmiAuto.Caption := '������������: ' + IntToStr(AutoCount);



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

procedure TForm3.mmiThinkAutoClick(Sender: TObject);
begin
   mmiThinkAuto.Checked := not mmiThinkAuto.Checked;
   cbAutoThink.Checked := mmiThinkAuto.Checked;
end;

procedure TForm3.mmiTowerAutoClick(Sender: TObject);
begin
    mmiTowerAuto.Checked := not mmiTowerAuto.Checked;
    cbAutoAttack.Checked := mmiTowerAuto.Checked;
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

        mmiTowerAuto.Caption := '�����';
        mmiThinkAuto.Caption := '��������';
        pTower.Caption := '�����';
        pThink.Caption := '��������';

        bResetTower.Caption := '����������';
        bUseItem.Caption := '���.!';
        bSkillUse.Caption := '���.!';
        bUpSkill.Caption := '��.!';
    end;

    if CurrLang = 'ENG' then
    begin
        mmiLang.Caption := '����';

        mmiEng.Caption := '����������';
        mmiEng.Checked := true;

        mmiRus.Caption := '�������';

        mmiTowerAuto.Caption := 'Tower';
        mmiThinkAuto.Caption := 'Think';

        pTower.Caption := 'Tower';
        pThink.Caption := 'Think';

        bResetTower.Caption := 'Restart';
        bUseItem.Caption := 'Use!';
        bSkillUse.Caption := 'Use!';
        bUpSkill.Caption := 'Up!';
    end;

end;

procedure TForm3.FormCreate(Sender: TObject);
begin
    Script := TScriptDrive.Create;
    Script.SetClass(TData, Data);
end;

end.
