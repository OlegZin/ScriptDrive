unit uFloorAtlas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts;

type
  TfFloorAtlas = class(TForm)
    locker1: TLayout;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Rectangle1: TRectangle;
    Label2: TLabel;
    armor1: TLayout;
    Image3: TImage;
    Image4: TImage;
    Label3: TLabel;
    Rectangle2: TRectangle;
    Label4: TLabel;
    locker2: TLayout;
    Image5: TImage;
    Image6: TImage;
    Label5: TLabel;
    Rectangle3: TRectangle;
    Label6: TLabel;
    boxes: TLayout;
    Image7: TImage;
    Image8: TImage;
    Label7: TLabel;
    Rectangle4: TRectangle;
    Label8: TLabel;
    candle: TLayout;
    Image9: TImage;
    Image10: TImage;
    Label9: TLabel;
    Rectangle5: TRectangle;
    Label10: TLabel;
    table2: TLayout;
    Image11: TImage;
    Image12: TImage;
    Label11: TLabel;
    Rectangle6: TRectangle;
    Label12: TLabel;
    armor2: TLayout;
    Image13: TImage;
    Image14: TImage;
    Label13: TLabel;
    Rectangle7: TRectangle;
    Label14: TLabel;
    table3: TLayout;
    Image15: TImage;
    Image16: TImage;
    Label15: TLabel;
    Rectangle8: TRectangle;
    Label16: TLabel;
    table1: TLayout;
    Image17: TImage;
    Image18: TImage;
    Label17: TLabel;
    Rectangle9: TRectangle;
    Label18: TLabel;
    chair3: TLayout;
    Image19: TImage;
    Image20: TImage;
    Label19: TLabel;
    Rectangle10: TRectangle;
    Label20: TLabel;
    chest3: TLayout;
    Image21: TImage;
    Image22: TImage;
    Label21: TLabel;
    Rectangle11: TRectangle;
    Label22: TLabel;
    chest2: TLayout;
    Image23: TImage;
    Image24: TImage;
    Label23: TLabel;
    Rectangle12: TRectangle;
    Label24: TLabel;
    locker6: TLayout;
    Image25: TImage;
    Image26: TImage;
    Label25: TLabel;
    Rectangle13: TRectangle;
    Label26: TLabel;
    chair2: TLayout;
    Image27: TImage;
    Image28: TImage;
    Label27: TLabel;
    Rectangle14: TRectangle;
    Label28: TLabel;
    chair1: TLayout;
    Image29: TImage;
    Image30: TImage;
    Label29: TLabel;
    Rectangle15: TRectangle;
    Label30: TLabel;
    locker3: TLayout;
    Image31: TImage;
    Image32: TImage;
    Label31: TLabel;
    Rectangle16: TRectangle;
    Label32: TLabel;
    locker5: TLayout;
    Image33: TImage;
    Image34: TImage;
    Label33: TLabel;
    Rectangle17: TRectangle;
    Label34: TLabel;
    locker4: TLayout;
    Image35: TImage;
    Image36: TImage;
    Label35: TLabel;
    Rectangle18: TRectangle;
    Label36: TLabel;
    locker7: TLayout;
    Image37: TImage;
    Image38: TImage;
    Label37: TLabel;
    Rectangle19: TRectangle;
    Label38: TLabel;
    chair8: TLayout;
    Image39: TImage;
    Image40: TImage;
    Label39: TLabel;
    Rectangle20: TRectangle;
    Label40: TLabel;
    chest1: TLayout;
    Image41: TImage;
    Image42: TImage;
    Label41: TLabel;
    Rectangle21: TRectangle;
    Label42: TLabel;
    chair7: TLayout;
    Image43: TImage;
    Image44: TImage;
    Label43: TLabel;
    Rectangle22: TRectangle;
    Label44: TLabel;
    chair6: TLayout;
    Image45: TImage;
    Image46: TImage;
    Label45: TLabel;
    Rectangle23: TRectangle;
    Label46: TLabel;
    chair5: TLayout;
    Image47: TImage;
    Image48: TImage;
    Label47: TLabel;
    Rectangle24: TRectangle;
    Label48: TLabel;
    chair4: TLayout;
    Image49: TImage;
    Image50: TImage;
    Label49: TLabel;
    Rectangle25: TRectangle;
    Label50: TLabel;
    vase5: TLayout;
    Image51: TImage;
    Image52: TImage;
    Label51: TLabel;
    Rectangle26: TRectangle;
    Label52: TLabel;
    vase4: TLayout;
    Image53: TImage;
    Image54: TImage;
    Label53: TLabel;
    Rectangle27: TRectangle;
    Label54: TLabel;
    vase2: TLayout;
    Image55: TImage;
    Image56: TImage;
    Label55: TLabel;
    Rectangle28: TRectangle;
    Label56: TLabel;
    vase3: TLayout;
    Image57: TImage;
    Image58: TImage;
    Label57: TLabel;
    Rectangle29: TRectangle;
    Label58: TLabel;
    vase1: TLayout;
    Image59: TImage;
    Image60: TImage;
    Label59: TLabel;
    Rectangle30: TRectangle;
    Label60: TLabel;
    cassette: TLayout;
    Image61: TImage;
    Image62: TImage;
    Label61: TLabel;
    Rectangle31: TRectangle;
    Label62: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    function GetShablonByName(name: string): TLayout;
  end;

var
  fFloorAtlas: TfFloorAtlas;

implementation

{$R *.fmx}

function TfFloorAtlas.GetShablonByName(name: string): TLayout;
var
    i: integer;
begin
    for I := 0 to ComponentCount-1 do
    if UpperCase(Components[i].Name) = UpperCase(name) then
    result := Components[i];
end;

end.
