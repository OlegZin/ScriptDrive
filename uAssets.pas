unit uAssets;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList, Vcl.Imaging.GIFImg;

type
  TfAssets = class(TForm)
    Monster1: TImage;
    Monster2: TImage;
    Monster3: TImage;
    Monster4: TImage;
    Monster5: TImage;
    Monster6: TImage;
    Monster7: TImage;
    Monster8: TImage;
    Monster9: TImage;
    Monster10: TImage;
    Monster11: TImage;
    Monster12: TImage;
    Monster13: TImage;
    Monster14: TImage;
    Monster15: TImage;
    Monster16: TImage;
    Monster17: TImage;
    Monster18: TImage;
    Monster19: TImage;
    Monster20: TImage;
    Monster21: TImage;
    Monster22: TImage;
    Monster23: TImage;
    Monster24: TImage;
    Monster25: TImage;
    Monster26: TImage;
    Monster27: TImage;
    Monster28: TImage;
    Monster29: TImage;
    Monster30: TImage;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MonsterCount : Integer;
  end;

var
  fAssets: TfAssets;

implementation

{$R *.dfm}

procedure TfAssets.FormCreate(Sender: TObject);
var
    i : integer;
begin
    MonsterCount := 0;
    for I := 0 to self.ControlCount-1 do
      if Pos('Monster', self.Controls[i].Name) > 0 then Inc(MonsterCount);
end;

end.
