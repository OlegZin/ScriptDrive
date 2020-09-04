unit uModel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uScriptDrive, Vcl.StdCtrls, Vcl.ExtCtrls, StrUtils,
  Vcl.ComCtrls, Vcl.Menus, Vcl.Buttons, math, superobject, Vcl.Imaging.pngimage,
  Vcl.Imaging.jpeg;

type
  TForm3 = class(TForm)
    mLog: TMemo;
    lCreatureInfo: TLabel;
    cbItem: TComboBox;
    bUseItem: TButton;
    cbSkills: TComboBox;
    bSkillUse: TButton;
    cbAutoAttack: TCheckBox;
    tAutoAttack: TTimer;
    pcGame: TPageControl;
    pTower: TTabSheet;
    pCraft: TTabSheet;
    lbLoot: TListBox;
    bUpSkill: TButton;
    MainMenu1: TMainMenu;
    mmiLang: TMenuItem;
    mmiEng: TMenuItem;
    mmiRus: TMenuItem;
    pThink: TTabSheet;
    cbAutoThink: TCheckBox;
    mThinkLog: TMemo;
    lbThinkList: TListBox;
    pSecrets: TTabSheet;
    mSecrets: TMemo;
    pFloors: TTabSheet;
    pcCraft: TPageControl;
    pPotionsResearch: TTabSheet;
    cbPotionSelect: TComboBox;
    bPotionResearch: TButton;
    Panel2: TPanel;
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
    pnlFloor: TPanel;
    Panel1: TPanel;
    pTools: TTabSheet;
    lbTools: TListBox;
    lToolName: TLabel;
    lToolDesc: TLabel;
    bToolUpgrade: TButton;
    lToolUpCost: TLabel;
    cbTarget: TComboBox;
    Panel3: TPanel;
    Splitter1: TSplitter;
    Panel4: TPanel;
    Panel5: TPanel;
    iMonster: TImage;
    pMonsterHPBG: TPanel;
    pMonsterHP: TPanel;
    flpMonsterParams: TFlowPanel;
    pmATK: TPanel;
    Image1: TImage;
    lMonsterATK: TLabel;
    pmDEF: TPanel;
    Image2: TImage;
    lMonsterDEF: TLabel;
    pmMDEF: TPanel;
    Image3: TImage;
    lMonsterMDEF: TLabel;
    pmREG: TPanel;
    Image4: TImage;
    lMonsterREG: TLabel;
    Panel11: TPanel;
    Image6: TImage;
    lMonsterMP: TLabel;
    Image8: TImage;
    lResetTower: TLabel;
    Image7: TImage;
    lAttack: TLabel;
    Image9: TImage;
    pFloor: TPanel;
    Image10: TImage;
    pTarget: TPanel;
    pFloorProgressBG: TPanel;
    pFloorProgress: TPanel;
    Image11: TImage;
    Panel15: TPanel;
    Panel16: TPanel;
    Image18: TImage;
    lPlayerMP: TLabel;
    Panel17: TPanel;
    Image19: TImage;
    lPlayerHP: TLabel;
    Panel18: TPanel;
    Image20: TImage;
    lPlayerREG: TLabel;
    Panel19: TPanel;
    Image21: TImage;
    lPlayerMDEF: TLabel;
    Panel20: TPanel;
    Image22: TImage;
    lPlayerDEF: TLabel;
    Panel21: TPanel;
    Image23: TImage;
    lPlayerATK: TLabel;
    Panel7: TPanel;
    Image12: TImage;
    lLvl: TLabel;
    pEXPBG: TPanel;
    pEXP: TPanel;
    Panel6: TPanel;
    Image5: TImage;
    lAutoActions: TLabel;
    Panel8: TPanel;
    Image13: TImage;
    lThink: TLabel;
    Image14: TImage;
    Image15: TImage;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel12: TPanel;
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
    procedure Attack;
    procedure Think;
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


uses uData, uAssets;

const
    UNKNOWN_BUTTON = '??????';

var
    oldPlayerItems
   ,oldPlayerLoot
   ,oldPlayerSkills
   ,AllowModes
   ,SelectedTool
   ,LastMonsterName  /// имя последнего активного монстра, применяется для отслеживания
   ///  необходимости смены картинки при появлении нового
            : string;
//    topFloor
    CurrFloor  //fmsec текущий этаж
   ,LastFloor  // последний этаж для которого отстраивался режим Этаж
   ,NeedToToolUp
            : integer;
    LastFloorObject   /// последняя кнопка объекта с которой взаимодействовали на этаже
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

    Script.Exec('AllowMode(Craft, 1)');
    Script.Exec('AllowMode(PotionResearch, 1)');
    Script.Exec('AllowMode(ResResearch, 1)');
}

    pcGame.ActivePageIndex := pTower.TabIndex;

    Script.Exec('InitGame();InitPlayer();CurrentLevel(1);InitCreatures();SetAutoATK(10000);CheckStatus();');

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

    /// заполняем список доступных инструментов
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

    if Script.Exec('GetLang()') = 'RU' then lToolUpCost.Caption := 'Цена: ' + IntToStr(NeedToToolUp) + ' золота';
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
/// выводим в окошке скрипты всех предметов и скилов
var
    s: string;
begin
    s := Data.GetGameScripts;
    s := StringReplace(s, ';', ';'+sLineBreak, [rfReplaceAll]);
    mSecrets.Text := s;
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

    // если обдцмывание завершено - сбрасываем флаги автомыслей, чтобы не утекали автодействия
    if cbAutoThink.Checked and (lbThinkList.ItemIndex = -1) then
    begin
        cbAutoThink.Checked := false;
    end;

    // блокируем выбор автомыслей, если тема не выбрана
    cbAutoThink.Enabled := lbThinkList.ItemIndex <> -1;

    log := Script.Exec('GetThinkEvents();');
    if log <> '' then mThinkLog.Text := log + sLineBreak + mThinkLog.Text;
end;

procedure TForm3.bThinkClick(Sender: TObject);
begin
    Think;
end;

procedure TForm3.Think;
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

    obj: ISuperObject;
    json : string;
begin

    if pcGame.ActivePage <> pFloors then exit;

    /// при переключении на башню цель - монстр
    if pcGame.ActivePage = pTower then Data.SetTarget('Creature');

    // останавливаем автоатаки
    cbAutoAttack.Checked := false;

    // перестраиваем этаж, только если ранее был отстроен другой этаж
    if CurrFloor <> LastFloor then
    begin
        /// запоминаем текущий этаж как последний отстроенный
        LastFloor := CurrFloor;

        /// грохаем все компоненты-объекты на этаже
        for i := pnlFloor.ControlCount-1 downto 0 do
        if pnlFloor.Controls[i] is TButton
        then pnlFloor.Controls[i].Free;

        LastFloorObject := nil;

        /// получаем первый объект этажа
        json := Data.GetFirstFloorObject(IntToStr(CurrFloor));

        /// если есть хотя бы один объект - генерим интерфейс
        while json <> '' do
        begin
            obj := SO(json);

            size := obj.S['params.size'];

            b := TButton.Create(self);
            b.Parent := pnlFloor;

            if (size = 'normal') or (size = '') then
            begin
                b.Height := Round(pFloors.ClientHeight / 10);
                b.Width := Min(Max(Round(pFloors.ClientWidth / 10), 150), 100);
            end;
            if (size = 'huge') or (size = '') then
            begin
                b.Height := Round(pFloors.ClientHeight / 2);
                b.Width := Round(pFloors.ClientWidth / 2);
                b.BringToFront;
            end;

            b.Caption := UNKNOWN_BUTTON;
            b.Tag := obj.I['params.key'];
            b.Left := Random(pFloors.ClientWidth - b.Width);
            b.top := Random(pFloors.ClientHeight - b.Height);
            b.Font.Style := [];
            b.OnClick := OnClickFloorButton;

            json := Data.GetNextFloorObject;
        end;

        /// при нулевом количестве мусора отстраиваем другой интерфейс.
        /// это может быть расковыривание стены или активация алтаря
        /// (если открыты такие режимы)
        if trash = 0 then
        begin

        end;

    end;

    Log(Script.Exec('GetFloorEvents();'));

end;

procedure TForm3.OnClickFloorButton(Sender: TObject);
var
    btn: TButton;
begin
    btn := sender as TButton;

    if LastFloorObject <> btn then
    begin
        // устанавливаем цель
        Data.SetTarget(IntTostr(btn.tag));
        cbTarget.Items.CommaText := Data.GetTargetList;
        cbTarget.ItemIndex := cbTarget.Items.Count -1;

        if Assigned(LastFloorObject) then (LastFloorObject as TButton).Font.Style := [];
        (btn as TButton).Font.Style := [fsBold];

        LastFloorObject := btn;
        exit;
    end;

    /// отрабатываем скрипт по id кнопки
    btn.Caption := Script.Exec('ProcessFloorObject('+IntTostr(btn.tag)+');CheckStatus();');

    /// пустой результат скрипта означает, что кнопка свое отработала - убираем
    if btn.Caption = '' then btn.Visible := false;

    /// если уделена последняя кнопка - пробуем перестроить интерфейс
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
    /// если скилл не выбран - выходим
    if cbSkills.ItemIndex = -1 then exit;

    /// применяем скилл
    Script.Exec('UseSkill('+Copy(cbSkills.Text, 0, Pos('=', cbSkills.Text)-1)+');');

    /// если мы сейчас на экране башни - монстр отвечает атакой
    if pcGame.ActivePage = pTower then
      Script.Exec('CreatureAttack();');

    /// если сейчас на экране этажа - обновляем текст активного объекта
    if pcGame.ActivePage = pFloors then
        if Assigned(LastFloorObject) then
            LastFloorObject.Caption := Script.Exec('ProcessFloorObject('+IntTostr(LastFloorObject.tag)+');');

    Script.Exec('CheckStatus();');

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
    Attack;
end;

procedure TForm3.Attack;
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
        Attack;
    end;

    if cbAutoThink.Checked then
    begin
        Script.Exec('ChangeAutoATK(-1)');
        Think;
    end;
end;

procedure TForm3.UpdateInterface;
var
    itemItem, itemSkill, itemTarget: integer;
    AutoCount: integer;
    tmp, exp, lvl, selItem, selSkill, reg, breaks, tmpname: string;
    step: integer;
    pars: TstringList;
    i: Integer;
    item : TSuperAvlEntry;
    bmp : TBitMap;
begin
    pars := TStringList.Create;

    if cbItem.ItemIndex <> -1
    then selItem := Copy(cbItem.Text,0,pos('=',cbItem.Text)-1)
    else selItem := '';

    if cbSkills.ItemIndex <> -1
    then selSkill := Copy(cbSkills.Text,0,pos('=',cbSkills.Text)-1)
    else selSkill := '';


    /// при переключении на башню цель - монстр
    if pcGame.ActivePage = pTower then Data.SetTarget('Creature');

    itemTarget := cbTarget.ItemIndex;
    cbTarget.Items.StrictDelimiter := true;
    cbTarget.Items.CommaText := Data.GetTargetList;

    if cbTarget.Items.Count-1 <= itemTarget
    then cbTarget.ItemIndex := itemTarget
    else cbTarget.ItemIndex := 0;


    // получение текущих доступных режимов
    AllowModes := Script.Exec('GetAllowModes()');
    // доступность думательной
    pThink.TabVisible := Pos( 'Think', AllowModes ) > 0;
    // доступность крафта
    pCraft.TabVisible := Pos( 'Craft', AllowModes ) > 0;
    pResourceResearch.TabVisible := Pos( 'ResResearch', AllowModes ) > 0;
    pPotionsResearch.TabVisible := Pos( 'PotionResearch', AllowModes ) > 0;
    // доступность просмотра секретов
    pSecrets.TabVisible := Pos( 'Secrets', AllowModes ) > 0;
    // доступность крафта
    pFloors.TabVisible := Pos( 'Floors', AllowModes ) > 0;
    // доступность инструментов
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


    // инфа по текущему / топовому этажу
    CurrFloor := StrToIntDef(Data.GetCurrentLevel, 0);

    pTarget.Caption    := Data.GetCurrTarget;
    pFloor.Caption     := IntToStr(CurrFloor);

    pFloorProgress.Width := Round((StrToInt(Data.CurrentStep) / StrToInt(Data.StepCount)) * pFloorProgressBG.Width);

    if CurrLang = 'ENG' then pFloors.Caption := 'Floor: ' + IntToStr(CurrFloor);
    if CurrLang = 'RU' then pFloors.Caption := 'Этаж: ' + IntToStr(CurrFloor);


    // инфа попротивнику
    tmpname := Script.Exec('GetCurrCreatureName();');
    if LastMonsterName <> tmpname then
    begin
        /// запоминаем имя нового монстра
        lCreatureInfo.Caption := tmpname;
        LastMonsterName := tmpname;
        /// подставляем картинку

        tmp := 'Monster'+IntToStr(Random(fAssets.MonsterCount)+1);
        iMonster.Picture.Assign( (fAssets.FindComponent( tmp ) as TImage).Picture );
    end;

    /// инфа по параметрам противника
    sobj := SO(Data.GetCurrCreatureParams);
    /// текущее значение и полоска здоровья
    pMonsterHP.Caption := sobj.S['HP'];
    pMonsterHP.Width := Round((sobj.I['HP'] / sobj.I['MAXHP']) * pMonsterHPBG.Width);

    /// инфа по параметрам
    for item in sobj.AsObject do
        (self.FindComponent( 'lMonster' + item.Name ) as TLabel).Caption := item.Value.AsString;


    // инфа по игроку
    sobj := SO( Data.GetPlayerInfo );

    // инфа по уровню и опыту
    lLvl.Caption := sobj.S['LVL'];
    // полоска опыта
    pEXP.Width := Round((sobj.I['EXP'] / StrToInt(Script.Exec('NeedExp(GetPlayerAttr(LVL))'))) * pEXPBG.Width);

    /// инфа по параметрам
    for item in sobj.AsObject do
        (self.FindComponent( 'lPlayer' + item.Name ) as TLabel).Caption := item.Value.AsString;


    /// инфа по баффам (приписываем к зачениям)
    sobj := SO( Data.GetPlayerBuffs );
    for item in sobj.AsObject do
    if item.Value.AsInteger <> 0 then
        (self.FindComponent( 'lPlayer' + item.Name ) as TLabel).Caption :=
        (self.FindComponent( 'lPlayer' + item.Name ) as TLabel).Caption +
        ' [' + item.Value.AsString + ']';

    /// инфа по АВТОбаффам (приписываем к зачениям)
    sobj := SO( Data.GetPlayerAutoBuffs );
    for item in sobj.AsObject do
    if item.Value.AsInteger <> 0 then
        (self.FindComponent( 'lPlayer' + item.Name ) as TLabel).Caption :=
        (self.FindComponent( 'lPlayer' + item.Name ) as TLabel).Caption +
        ' (' + item.Value.AsString + ')';


    // список предметов
    tmp := Script.Exec('GetPlayerItems()');
    if (tmp <> oldPlayerItems) or (oldPlayerItems = '') then
    begin
        sobj := SO( tmp );

        cbItem.Items.Clear;
        for item in sobj.AsObject do
            cbItem.Items.Add(Item.Name + '=' + Item.Value.AsString);

        oldPlayerItems := tmp;
    end;


    // список заклинаний
    tmp := Script.Exec('GetPlayerSkills()');
    if (tmp <> oldPlayerSkills) or (oldPlayerSkills = '') then
    begin
        sobj := SO( tmp );

        cbSkills.Items.Clear;
        for item in sobj.AsObject do
            cbSkills.Items.Add(Item.Name + '=' + Item.Value.AsString);

        oldPlayerSkills := tmp;
    end;



    // список ресурсов
    tmp := Script.Exec('GetPlayerLoot()');
    if (tmp <> oldPlayerLoot) or (oldPlayerLoot = '') then
    begin
        sobj := SO( tmp );

        lbLoot.Items.Clear;
        for item in sobj.AsObject do
            lbLoot.Items.Add( Item.Name + '=' + Item.Value.AsString );

        oldPlayerLoot := tmp;
    end;




    /// количество автоатак
    AutoCount := StrToIntDef(Script.Exec('GetAutoATK()'), 0);

    if AutoCount <= 0 then
    begin
        cbAutoAttack.Checked := false;
        cbAutoThink.Checked := false;
    end;
    cbAutoAttack.Enabled := AutoCount > 0;
    cbAutoThink.Enabled := AutoCount > 0;

    lAutoActions.Caption := IntToStr(AutoCount);


    /// скорость автоатак
    tAutoAttack.Interval := StrToInt(Data.GetAutoSpeed);

    /// отображение событий в логе
    log(Script.Exec('GetEvents()'));

    /// восстанавливаем элемент в списке
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
    mLog.Text := Copy(mLog.Text, 0, 3000);
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

        pTower.Caption := 'Башня';
        pThink.Caption := 'Раздумья';
        pSecrets.Caption := 'Секреты';
        pCraft.Caption := 'Ремесло';
        pFloors.Caption := 'Этаж: ' + IntToStr(CurrFloor);
        pTools.Caption := 'Артефакты';

        lResetTower.Caption := 'Перезапуск';
        lAttack.Caption := 'Атака';
        bUseItem.Caption := 'Исп.!';
        bSkillUse.Caption := 'Исп.!';
        bUpSkill.Caption := 'Ап.!';

        lThink.Caption := 'Думать...';
        bToolUpgrade.Caption := 'Улучшить!';
    end;

    if CurrLang = 'ENG' then
    begin
        mmiLang.Caption := 'Язык';

        mmiEng.Caption := 'Английский';
        mmiEng.Checked := true;

        mmiRus.Caption := 'Русский';


        pTower.Caption := 'Tower';
        pThink.Caption := 'Think';
        pSecrets.Caption := 'Secrets';
        pCraft.Caption := 'Craft';
        pFloors.Caption := 'Floor: ' + IntToStr(CurrFloor);
        pTools.Caption := 'Artifacts';

        lResetTower.Caption := 'Restart';
        lAttack.Caption := 'Attack';
        bUseItem.Caption := 'Use!';
        bSkillUse.Caption := 'Use!';
        bUpSkill.Caption := 'Up!';

        lThink.Caption := 'Think...';
        bToolUpgrade.Caption := 'Upgrade!';
    end;

end;

procedure TForm3.FormCreate(Sender: TObject);
begin
    Script := TScriptDrive.Create;
    Script.SetClass(TData, Data);
end;

end.
