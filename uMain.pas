unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit, FMX.ComboEdit, FMX.ComboTrackBar,
  FMX.StdCtrls, FMX.WebBrowser, FMX.TabControl, FMX.Objects, FMX.Layouts, IOUtils;

type
  TfMain = class(TForm)
    WebBrowser1: TWebBrowser;
    Splitter1: TSplitter;
    TabControl1: TTabControl;
    tabGame: TTabItem;
    Rectangle2: TRectangle;
    Rectangle1: TRectangle;
    TabControl2: TTabControl;
    TabItem2: TTabItem;
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
    layBuildEconomy: TLayout;
    Label13: TLabel;
    Label14: TLabel;
    Rectangle6: TRectangle;
    Label15: TLabel;
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
    procedure bExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
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
    uMenu, uConst;

procedure TfMain.bExitClick(Sender: TObject);
begin
    Close;
end;

procedure TfMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    Menu.SaveData;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
    /// создаем папку хранения данных (сейвы)
    if not DirectoryExists( DIR_DATA ) then
    if not CreateDir( DIR_DATA ) then
        ShowMessage('Can`t create data directory:'+ sLineBreak +
                     DIR_DATA + sLineBreak +
                    'Save game is not available!');

    /// отдаем под управление кнопки и лого
    Menu.LinkSkillComponent( 'Logo', layLogo );
    Menu.LinkSkillComponent( 'New', bNew );
    Menu.LinkSkillComponent( 'Resume', bResume );
    Menu.LinkSkillComponent( 'Lang', bLang );
    Menu.LinkSkillComponent( 'Exit', bExit );

    /// отдаем "игрвые" объекты
    Menu.iChest := iChestDef;
    Menu.layGold := layGold;
    Menu.bBuild := bBuild;
    Menu.layConstruction := layConstruction;

    Menu.LinkSkillComponent( 'Research', layResearch  );
    Menu.LinkSkillComponent( 'MoneyEaring', layMoneyEarning  );
    Menu.LinkSkillComponent( 'BuildSpeed', layBuildSpeed  );
    Menu.LinkSkillComponent( 'BuildEconomy', layBuildEconomy  );
    Menu.LinkSkillComponent( 'Tower1', iTower1  );

    Menu.Init;
end;

end.
