unit uFloor;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts,
  superobject;

type
  TfFloor = class(TForm)
    layFloor: TLayout;
    Rectangle4: TRectangle;
    Rectangle1: TRectangle;
    Image1: TImage;
    lCurrFloor: TLabel;
    Image65: TImage;
    lAttackPool: TLabel;
    Rectangle8: TRectangle;
    iAuto: TImage;
    pointRightTop: TSelectionPoint;
    pointLeftTop: TSelectionPoint;
    pointLeftBottom: TSelectionPoint;
    pointRightBottom: TSelectionPoint;
  private
    { Private declarations }
    data : ISuperObject;
  public
    { Public declarations }
    procedure Update(indata: ISuperObject);
  end;

var
  fFloor: TfFloor;

implementation

{$R *.fmx}

{ TfFloor }

procedure TfFloor.Update(indata: ISuperObject);
begin

end;

end.
