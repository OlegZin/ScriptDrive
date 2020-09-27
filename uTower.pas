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
    Rectangle8: TRectangle;
    Label6: TLabel;
    Layout4: TLayout;
    Image18: TImage;
    Image19: TImage;
    Image20: TImage;
    Image21: TImage;
    Image22: TImage;
    Image23: TImage;
    Rectangle9: TRectangle;
    Label7: TLabel;
    Layout5: TLayout;
    Image24: TImage;
    Image25: TImage;
    Image26: TImage;
    Image27: TImage;
    Image28: TImage;
    Image29: TImage;
    Rectangle10: TRectangle;
    Label8: TLabel;
    Layout6: TLayout;
    Image30: TImage;
    Image33: TImage;
    Image34: TImage;
    Image37: TImage;
    Image38: TImage;
    Image42: TImage;
    Rectangle11: TRectangle;
    Label9: TLabel;
    Layout7: TLayout;
    Image43: TImage;
    Image44: TImage;
    Image45: TImage;
    Image46: TImage;
    Image47: TImage;
    Image48: TImage;
    layPlayerSkills: TLayout;
  private
    { Private declarations }
  public
    { Public declarations }
    onAttack: TEvent;

    procedure Update(data: ISuperObject);
  end;

var
  fTower: TfTower;

implementation

{$R *.fmx}

{ TfTower }

procedure TfTower.Update(data: ISuperObject);
begin

end;

end.
