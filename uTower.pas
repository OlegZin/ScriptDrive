unit uTower;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  superobject, uConst, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation,
  FMX.StdCtrls;

type
  TfTower = class(TForm)
    layTower: TLayout;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    rectProgressBG: TRoundRect;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    rectProgress: TRoundRect;
    iFlag: TImage;
    labelHP: TLabel;
    Image3: TImage;
    labelREG: TLabel;
    Image7: TImage;
    labelMDEF: TLabel;
    Image6: TImage;
    labelDEF: TLabel;
    Image5: TImage;
    labelATK: TLabel;
    Image4: TImage;
    labelMP: TLabel;
    Image8: TImage;
    Rectangle3: TRectangle;
    Label3: TLabel;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    Image9: TImage;
    Rectangle6: TRectangle;
    Label4: TLabel;
    Image31: TImage;
    Image32: TImage;
    Layout1: TLayout;
    Image10: TImage;
    Image39: TImage;
    Image40: TImage;
    Image11: TImage;
    Image35: TImage;
    Image41: TImage;
    Image36: TImage;
    Layout2: TLayout;
    Rectangle7: TRectangle;
    Label5: TLabel;
    Layout3: TLayout;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    layPlayerSkills: TLayout;
    Rectangle12: TRectangle;
    Image49: TImage;
    Layout9: TLayout;
    Label11: TLabel;
    Rectangle8: TRectangle;
    Rectangle9: TRectangle;
    Layout4: TLayout;
    Image18: TImage;
    Image19: TImage;
    Image20: TImage;
    Image21: TImage;
    Image22: TImage;
    Image23: TImage;
    Layout5: TLayout;
    Label6: TLabel;
    Label7: TLabel;
    Image24: TImage;
    Rectangle10: TRectangle;
    Rectangle11: TRectangle;
    Layout6: TLayout;
    Image25: TImage;
    Image26: TImage;
    Image27: TImage;
    Image28: TImage;
    Image29: TImage;
    Image30: TImage;
    Layout7: TLayout;
    Label8: TLabel;
    Label9: TLabel;
    Image33: TImage;
    Rectangle13: TRectangle;
    Rectangle14: TRectangle;
    Layout8: TLayout;
    Image34: TImage;
    Image37: TImage;
    Image38: TImage;
    Image42: TImage;
    Image43: TImage;
    Image44: TImage;
    Layout10: TLayout;
    Label10: TLabel;
    Label12: TLabel;
    Image45: TImage;
    Rectangle15: TRectangle;
    Rectangle16: TRectangle;
    Layout11: TLayout;
    Image46: TImage;
    Image47: TImage;
    Image48: TImage;
    Image50: TImage;
    Image51: TImage;
    Image52: TImage;
    Layout12: TLayout;
    Label13: TLabel;
    Label14: TLabel;
    Image53: TImage;
    Rectangle17: TRectangle;
    Rectangle18: TRectangle;
    Layout13: TLayout;
    Image54: TImage;
    Image55: TImage;
    Image56: TImage;
    Image57: TImage;
    Image58: TImage;
    Image59: TImage;
    Layout14: TLayout;
    Label15: TLabel;
    Label16: TLabel;
    Image60: TImage;
    procedure Image9Click(Sender: TObject);
  private
    { Private declarations }
    data: ISuperObject;
  public

    procedure Update(data: ISuperObject);
  end;

var
  fTower: TfTower;

implementation

{$R *.fmx}

uses uGameDrive;

{ TfTower }

procedure TfTower.Image9Click(Sender: TObject);
begin
    GameDrive.PlayerAttack;
end;

procedure TfTower.Update(data: ISuperObject);
begin

end;

end.
