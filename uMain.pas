unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit, FMX.ComboEdit, FMX.ComboTrackBar,
  FMX.StdCtrls, FMX.WebBrowser, FMX.TabControl, FMX.Objects, FMX.Layouts, IOUtils,
  FMX.Ani;

type
  TfMain = class(TForm)
    tabsGame: TTabControl;
    tabGame: TTabItem;
    tabMenu: TTabItem;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Rectangle3: TRectangle;
    layLogo: TLayout;
    Label5: TLabel;
    bNew: TRoundRect;
    lNewGame: TLabel;
    bResume: TRoundRect;
    lResumeGame: TLabel;
    bLang: TRoundRect;
    lLang: TLabel;
    bExit: TRoundRect;
    lExit: TLabel;
    Label11: TLabel;
    Layout1: TLayout;
    iChestDef: TImage;
    iChestActive: TImage;
    iGold: TImage;
    lGold: TLabel;
    layGold: TLayout;
    layChest: TLayout;
    Image1: TImage;
    Label6: TLabel;
    layMoneyEarning: TLayout;
    Label7: TLabel;
    Rectangle4: TRectangle;
    Label8: TLabel;
    layBuildSpeed: TLayout;
    Label9: TLabel;
    Label10: TLabel;
    Rectangle5: TRectangle;
    Label12: TLabel;
    layResearch: TLayout;
    Label16: TLabel;
    Label17: TLabel;
    Rectangle7: TRectangle;
    Label18: TLabel;
    layConstruction: TLayout;
    Layout7: TLayout;
    RoundRect1: TRoundRect;
    RoundRect2: TRoundRect;
    bBuild: TRectangle;
    Label19: TLabel;
    Layout8: TLayout;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    iTower1: TImage;
    Label23: TLabel;
    iTower2: TImage;
    iTower3: TImage;
    iTower4: TImage;
    FloatAnimation1: TFloatAnimation;
    layAutoMoney: TLayout;
    Label13: TLabel;
    Label14: TLabel;
    Rectangle6: TRectangle;
    Label15: TLabel;
    layPlayerPanel: TLayout;
    layMain: TLayout;
    wbLog: TWebBrowser;
    labelHP: TLabel;
    Image3: TImage;
    labelMP: TLabel;
    Image2: TImage;
    Image4: TImage;
    labelATK: TLabel;
    Image5: TImage;
    labelDEF: TLabel;
    Image6: TImage;
    labelMDEF: TLabel;
    Image7: TImage;
    labelREG: TLabel;
    Image8: TImage;
    labelLVL: TLabel;
    bMenu: TRectangle;
    rectBGEXP: TRectangle;
    rectEXP: TRectangle;
    labelEXP: TLabel;
    bTowerMode: TRectangle;
    Image9: TImage;
    bThinkMode: TRectangle;
    Image10: TImage;
    iAutoBG: TImage;
    labelAutoAction: TLabel;
    Layout2: TLayout;
    layScreen: TLayout;
    Splitter1: TSplitter;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure bExitClick(Sender: TObject);
    procedure bTowerModeMouseEnter(Sender: TObject);
    procedure bTowerModeMouseLeave(Sender: TObject);
    procedure bTowerModeClick(Sender: TObject);
    procedure bNewClick(Sender: TObject);
    procedure bResumeClick(Sender: TObject);
    procedure bThinkModeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bMenuClick(Sender: TObject);  private
    { Private declarations }
  public
    { Public declarations }
    procedure SaveData;
  end;

var
  fMain: TfMain;

implementation

{$R *.fmx}

uses
    uMenu, uConst, uLog, uThinkMode, uScriptDrive, uGameDrive, superobject,
    uGameInterface, uTower;

var
   Script : TScriptDrive;

procedure TfMain.FormShow(Sender: TObject);
begin

    /// создаем папку хранения данных (сейвы)
    if not DirectoryExists( DIR_DATA ) then
    if not CreateDir( DIR_DATA ) then
        ShowMessage('Can`t create data directory:'+ sLineBreak +
                     DIR_DATA + sLineBreak +
                    'Save game is not available!');


    /////////////////////////////////////////
    ///    настройка игрового меню
    /////////////////////////////////////////

    /// отдаем под управление кнопки и лого
    Menu.LinkSkillComponent( 'Logo', layLogo );
    Menu.LinkSkillComponent( 'MenuNew', bNew );
    Menu.LinkSkillComponent( 'MenuResume', bResume );
    Menu.LinkSkillComponent( 'MenuLang', bLang );
    Menu.LinkSkillComponent( 'MenuExit', bExit );

    /// отдаем "игрвые" объекты
    Menu.iChest := iChestDef;
    Menu.iChestBG := iChestActive;
    Menu.layGold := layGold;
    Menu.bBuild := bBuild;
    Menu.layConstruction := layConstruction;

    Menu.LinkSkillComponent( 'Research', layResearch );
    Menu.LinkSkillComponent( 'MoneyEaring', layMoneyEarning );
    Menu.LinkSkillComponent( 'BuildSpeed', layBuildSpeed );
    Menu.LinkSkillComponent( 'AutoMoney', layAutoMoney );
    Menu.LinkSkillComponent( 'Tower1', iTower1 );
    Menu.LinkSkillComponent( 'Tower2', iTower2 );
    Menu.LinkSkillComponent( 'Tower3', iTower3 );
    Menu.LinkSkillComponent( 'Tower4', iTower4 );

    Menu.Init;



    /////////////////////////////////////////
    ///    настройка основного интерфейса
    /////////////////////////////////////////
    GameInterface.LinkControl('AutoAction', labelAutoAction);
    GameInterface.LinkControl('LVL', labelLVL);
    GameInterface.LinkControl('EXP', labelEXP);
    GameInterface.LinkControl('rectEXP', rectEXP);
    GameInterface.LinkControl('rectBGEXP', rectBGEXP);
    GameInterface.LinkControl('HP', labelHP);
    GameInterface.LinkControl('MP', labelMP);
    GameInterface.LinkControl('ATK', labelATK);
    GameInterface.LinkControl('DEF', labelDEF);
    GameInterface.LinkControl('MDEF', labelMDEF);
    GameInterface.LinkControl('REG', labelREG);



    /////////////////////////////////////////
    ///    настройка лога
    /////////////////////////////////////////
    Log.wbLog := wbLog;
    Log.linesCount := 100;  /// максимум отображаемых строк в логе
    Log.GenerateImages;
    Log.Clear;



    /////////////////////////////////////////
    ///    настройка экрана башни
    /////////////////////////////////////////
    fTower.onAttack := GameDrive.onPlayerAttack;

    fTower.layTower.Parent := fMain.layScreen;


    /////////////////////////////////////////
    ///    настройка экрана размышлений
    /////////////////////////////////////////
//    Think.tcModes := tModes;
//    Think.page := tabThink;



    /////////////////////////////////////////
    ///    инициализация скриптового движка
    /////////////////////////////////////////
    Script := TScriptDrive.Create;
    Script.SetClass(TGameDrive, GameDrive);



    /////////////////////////////////////////
    ///    нинциализация игры
    /////////////////////////////////////////
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

//    pcGame.ActivePageIndex := pTower.TabIndex;


//    UpdateInterface;

    tabsGame.ActiveTab := tabMenu;
end;

procedure TfMain.bExitClick(Sender: TObject);
begin
    Close;
end;

procedure TfMain.bMenuClick(Sender: TObject);
begin
    SaveData;
    tabsGame.ActiveTab := tabMenu;
end;

procedure TfMain.bNewClick(Sender: TObject);
begin
    GameDrive.NewGame( Menu.NewLevel, Menu.Lang );
    GameDrive.SetActiveMode('Tower');
    tabsGame.ActiveTab := tabGame;
end;

procedure TfMain.bResumeClick(Sender: TObject);
begin
    GameDrive.LoadGame( Menu.Lang );
    GameDrive.SetActiveMode('Tower');
    tabsGame.ActiveTab := tabGame;
end;

procedure TfMain.bThinkModeClick(Sender: TObject);
begin
//    GameDrive.SetActiveMode('Think');
end;

procedure TfMain.bTowerModeClick(Sender: TObject);
begin
    GameDrive.SetActiveMode('Tower');
end;

procedure TfMain.bTowerModeMouseEnter(Sender: TObject);
begin
    (sender as TControl).Opacity := 1;
end;

procedure TfMain.bTowerModeMouseLeave(Sender: TObject);
begin
    (sender as TControl).Opacity := 0.25;
end;

procedure TfMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    SaveData;
end;


procedure TfMain.SaveData;
begin
    Menu.SaveData;
    GameDrive.SaveGame;
end;

end.
