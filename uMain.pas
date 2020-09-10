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
    TabControl1: TTabControl;
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
    layScreen: TLayout;
    tModes: TTabControl;
    tabTower: TTabItem;
    wbLog: TWebBrowser;
    Label24: TLabel;
    Image3: TImage;
    Label25: TLabel;
    Image2: TImage;
    Image4: TImage;
    Label26: TLabel;
    Image5: TImage;
    Label27: TLabel;
    Image6: TImage;
    Label28: TLabel;
    Image7: TImage;
    Label29: TLabel;
    Image8: TImage;
    Label30: TLabel;
    bMenu: TRectangle;
    rExpBG: TRectangle;
    rExp: TRectangle;
    lExp: TLabel;
    bTowerMode: TRectangle;
    Image9: TImage;
    bThinkMode: TRectangle;
    Image10: TImage;
    iPlayer: TImage;
    iAutoBG: TImage;
    Label31: TLabel;
    iPlayerBG: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure bExitClick(Sender: TObject);
    procedure bTowerModeMouseEnter(Sender: TObject);
    procedure bTowerModeMouseLeave(Sender: TObject);
    procedure iPlayerMouseEnter(Sender: TObject);
    procedure iPlayerMouseLeave(Sender: TObject);
    procedure bTowerModeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.fmx}

uses
    uMenu, uConst, uTowerMode, uLog, uThinkMode;

procedure TfMain.FormCreate(Sender: TObject);
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
    ///    настройка экрана башни
    /////////////////////////////////////////

    Log.wbLog := wbLog;

    /////////////////////////////////////////
    ///    настройка экрана башни
    /////////////////////////////////////////

end;

procedure TfMain.bExitClick(Sender: TObject);
begin
    Close;
end;

procedure TfMain.bTowerModeClick(Sender: TObject);
begin
    tModes.ActiveTab := tabTower;
    Tower.SetActive;
    Think.SetUnactive;
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
    Menu.SaveData;
end;


procedure TfMain.iPlayerMouseEnter(Sender: TObject);
begin
    iPlayerBG.Opacity := 0;
    iPlayer.Opacity := 1;
end;

procedure TfMain.iPlayerMouseLeave(Sender: TObject);
begin
    iPlayerBG.Opacity := 0.5;
    iPlayer.Opacity := 0;
end;

end.
