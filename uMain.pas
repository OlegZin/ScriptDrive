unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit, FMX.ComboEdit, FMX.ComboTrackBar,
  FMX.StdCtrls, FMX.WebBrowser, FMX.TabControl, FMX.Objects, FMX.Layouts;

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
    Layout2: TLayout;
    Label7: TLabel;
    Rectangle4: TRectangle;
    Label8: TLabel;
    Layout3: TLayout;
    Label9: TLabel;
    Label10: TLabel;
    Rectangle5: TRectangle;
    Label12: TLabel;
    Layout4: TLayout;
    Label13: TLabel;
    Label14: TLabel;
    Rectangle6: TRectangle;
    Label15: TLabel;
    Layout5: TLayout;
    Label16: TLabel;
    Label17: TLabel;
    Rectangle7: TRectangle;
    Label18: TLabel;
    Layout6: TLayout;
    Layout7: TLayout;
    RoundRect1: TRoundRect;
    RoundRect2: TRoundRect;
    bBuild: TRectangle;
    Label19: TLabel;
    Layout8: TLayout;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Layout9: TLayout;
    Label23: TLabel;
    Label24: TLabel;
    Rectangle8: TRectangle;
    Label25: TLabel;
    procedure bExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
    uMenu;

procedure TfMain.bExitClick(Sender: TObject);
begin
    Close;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
    Menu.bNew := bNew;
    Menu.lNew := lNewGame;

    Menu.bResume := bResume;
    Menu.lResume := lResumeGame;

    Menu.bLang := bLang;
    Menu.lLang := lLang;

    Menu.bExit := bExit;
    Menu.lExit := lExit;

    Menu.layLogo := layLogo;
    Menu.iChest := iChestDef;

    Menu.Init;
end;

end.
