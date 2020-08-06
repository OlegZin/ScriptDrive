unit uModel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uScriptDrive, Vcl.StdCtrls, Vcl.ExtCtrls, StrUtils,
  Vcl.ComCtrls, Vcl.Menus;

type
  TForm3 = class(TForm)
    Button1: TButton;
    mLog: TMemo;
    bAttack: TButton;
    lPlayerInfo: TLabel;
    lStep: TLabel;
    lCreatureInfo: TLabel;
    cbItem: TComboBox;
    bUseItem: TButton;
    cbSkill: TComboBox;
    bSkillUse: TButton;
    lNeedExp: TLabel;
    cbAutoAttack: TCheckBox;
    tAutoAttack: TTimer;
    lAutoCount: TLabel;
    pcGame: TPageControl;
    pTower: TTabSheet;
    pCraft: TTabSheet;
    lbLoot: TListBox;
    Label1: TLabel;
    Button2: TButton;
    lTopStep: TLabel;
    lTarget: TLabel;
    lBuffs: TLabel;
    MainMenu1: TMainMenu;
    mmiLang: TMenuItem;
    mmiEng: TMenuItem;
    mmiRus: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure log(text: string);
    procedure FormShow(Sender: TObject);
    procedure bAttackClick(Sender: TObject);
    procedure UpdateInterface;
    procedure bLvlUpClick(Sender: TObject);
    procedure tAutoAttackTimer(Sender: TObject);
    procedure bUseItemClick(Sender: TObject);
    procedure mmiEngClick(Sender: TObject);
    procedure mmiRusClick(Sender: TObject);
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
   ,AllowModes
            : string;
    topFloor: integer;

procedure TForm3.bUseItemClick(Sender: TObject);
begin
    if cbItem.ItemIndex = -1 then exit;
    Script.Exec('UseItem('+Copy(cbItem.Text, 0, Pos('=', cbItem.Text)-1)+')');
    UpdateInterface;
end;

procedure TForm3.bLvlUpClick(Sender: TObject);
begin
    Script.Exec('LevelUpPlayer()');
    UpdateInterface;
end;

procedure TForm3.Button1Click(Sender: TObject);
var i: integer;
begin
    Script.Exec('CurrentLevel(1);InitCreatures();');
    UpdateInterface;

    log('Enter into Dungeon...');
end;


procedure TForm3.bAttackClick(Sender: TObject);
begin
    Script.Exec('PlayerAttack();CreatureAttack();CheckStatus();');
    UpdateInterface;
end;

procedure TForm3.FormShow(Sender: TObject);
begin
    mLog.Lines.Clear;

    pcGame.ActivePageIndex := pTower.TabIndex;

    Script.Exec('InitPlayer();CurrentLevel(1);InitCreatures();SetAutoATK(1000);');
    UpdateInterface;

    SetLang( Script.Exec('GetLang()') );

    log('Enter into Dungeon...');
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
    item: integer;
    AutoCount: integer;
    tmp, exp, lvl: string;
    floor, step: integer;
    pars: TstringList;
begin
    pars := TStringList.Create;
    item := cbItem.ItemIndex;



    // получение текущих доступных режимов
    AllowModes := Script.Exec('GetAllowModes()');
    // исход€ из доступных модифицируем интерфейс
    pars.CommaText := AllowModes;
    // доступность крафта
    pCraft.TabVisible := pars.IndexOfName( 'Craft' ) <> -1;



    // инфа по текущему / топовому этажу
    floor := StrToIntDef(Script.Exec('GetCurrentLevel()'), 0);
    step := StrToIntDef(Script.Exec('CurrentCreature()'), 0);
    if floor * 1000000 + step > topFloor then
       topFloor := floor * 1000000 + step;

    lStep.Caption    := 'Floor: ' + IntToStr(floor) + ', ' + IntToStr(step) + '/' + Script.Exec('CreaturesCount()');
    ltopStep.Caption := 'Top: ' + IntToStr(topFloor div 1000000) + ', ' + IntToStr(topFloor mod 1000000);

    lTarget.Caption := 'Target: ' + Script.Exec('GetCurrTarget()') + ' floor';

    // инфа попротивнику
    lCreatureInfo.Caption := ReplaceStr( Script.Exec('GetCurrCreatureInfo()'), ',', '  ' );



    // инфа по игроку
    tmp := Script.Exec('GetPlayerInfo()');
    pars.CommaText := tmp;

    exp := pars.Values[ 'EXP' ];
    pars.Delete( pars.IndexOfName('EXP') );

    lvl := pars.Values[ 'LVL' ];
    pars.Delete( pars.IndexOfName('LVL') );

    lPlayerInfo.Caption := ReplaceStr( pars.CommaText, ',', '  ' );

    // инфа по текущему опыту игрока
    lNeedExp.Caption := 'Lvl: ' + lvl + ', ' + exp + '/' + Script.Exec('NeedExp()') + ' EXP';

    // текущие наложенные бафы
    lBuffs.Caption := 'Regen: ' + Script.Exec('GetPlayerBuffs()');

    // список предметов
    tmp := Script.Exec('GetPlayerItems()');
    if (tmp <> oldPlayerItems) or (oldPlayerItems = '') then
    begin
        cbItem.Items.CommaText := tmp;
        oldPlayerItems := tmp;
    end;


    // список ресурсов
    tmp := Script.Exec('GetPlayerLoot()');
    if (tmp <> oldPlayerLoot) or (oldPlayerLoot = '') then
    begin
        lbLoot.Items.CommaText := tmp;
        oldPlayerLoot := tmp;
    end;



    /// количество автоатак
    AutoCount := StrToIntDef(Script.Exec('GetAutoATK()'), 0);
    lAutoCount.Caption := 'Auto: ' + IntToStr(AutoCount);

    if AutoCount <= 0 then
    begin
        cbAutoAttack.Checked := false;
        cbAutoAttack.Enabled := false;
    end else
        cbAutoAttack.Enabled := true;


    /// отображение событий в логе
    log(Script.Exec('GetEvents()'));

    /// восстанавливаем элемент в списке
    if   cbItem.Items.Count-1 >= item
    then cbItem.ItemIndex := item;

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
end;

procedure TForm3.mmiRusClick(Sender: TObject);
begin
    Script.Exec('SetLang(RU)');
    SetLang('RU');
end;

procedure TForm3.SetLang(lang: string);
begin
    if CurrLang = lang
    then exit
    else CurrLang := lang;

    if CurrLang = 'RU' then
    begin
        mmiLang.Caption := 'язык';

        mmiEng.Caption := 'јнгл.';

        mmiRus.Caption := '–ус.';
        mmiRus.Checked := true;


    end;

    if CurrLang = 'ENG' then
    begin
        mmiLang.Caption := 'Lang.';

        mmiEng.Caption := 'Eng.';
        mmiEng.Checked := true;

        mmiRus.Caption := 'Rus.';


    end;

end;

procedure TForm3.FormCreate(Sender: TObject);
begin
    Script := TScriptDrive.Create;
    Script.SetClass(TData, Data);
end;

end.
