unit uFloor;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fFloor: TfFloor;

implementation

{$R *.fmx}

end.
