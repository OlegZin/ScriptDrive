unit uAtlas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Memo,
  System.NetEncoding;

type
  TfAtlas = class(TForm)
    NOTE_BG: TImage;
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
