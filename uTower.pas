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
