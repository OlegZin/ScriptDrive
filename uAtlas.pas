unit uAtlas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Memo,
  System.NetEncoding;

type
  TfAtlas = class(TForm)
    NOTE_BG: TImage;
    Image15: TImage;
    Image30: TImage;
    Image29: TImage;
    Image28: TImage;
    Image27: TImage;
    Image26: TImage;
    Image25: TImage;
    Image24: TImage;
    Image23: TImage;
    Image22: TImage;
    Image21: TImage;
    Image20: TImage;
    Image19: TImage;
    Image18: TImage;
    Image17: TImage;
    Image16: TImage;
    Image14: TImage;
    Image13: TImage;
    Image12: TImage;
    Image11: TImage;
    Image10: TImage;
    Image9: TImage;
    Image8: TImage;
    Image7: TImage;
    Image6: TImage;
    Image5: TImage;
    Image4: TImage;
    Image3: TImage;
    Image2: TImage;
    Image1: TImage;
    Image32: TImage;
    Image31: TImage;
    Image33: TImage;
    Image34: TImage;
    Image35: TImage;
    Image36: TImage;
    Image37: TImage;
    Image38: TImage;
    Image39: TImage;
    Image40: TImage;
    Image41: TImage;
    Image42: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
    function EncodeToBase64(name: string): string;
  end;

var
  fAtlas: TfAtlas;

implementation

{$R *.fmx}

{ TfAtlas }

function TfAtlas.EncodeToBase64(name: string): string;
var
    memo : TMemo;
    LInput: TMemoryStream;
    LOutput: TMemoryStream;
    image: TImage;
    i: integer;
begin
    for I := 0 to self.ComponentCount-1 do
    if Components[i].Name = name then
      image := Components[i] as TImage;

    Memo := TMemo.Create(nil);

    LInput := TMemoryStream.Create;
    LOutput := TMemoryStream.Create;

    try
      image.MultiResBitmap[0].Bitmap.SaveToStream(LInput);
      LInput.Position := 0;
      TNetEncoding.Base64.Encode( LInput, LOutput );
      LOutput.Position := 0;
      Memo.Lines.LoadFromStream( LOutput );
    finally
      LInput.Free;
      LOutput.Free;
    end;

    result := Memo.Text;

    Memo.Free;
end;

end.
