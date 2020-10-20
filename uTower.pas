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
    lTargetFloor: TLabel;
    lCurrFloor: TLabel;
    ProgressBG: TRoundRect;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Progress: TRoundRect;
    HP: TLabel;
    Image3: TImage;
    REG: TLabel;
    Image7: TImage;
    MDEF: TLabel;
    Image6: TImage;
    DEF: TLabel;
    Image5: TImage;
    ATK: TLabel;
    Image4: TImage;
    MP: TLabel;
    Image8: TImage;
    Rectangle3: TRectangle;
    lCurrStep: TLabel;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    Monster: TImage;
    procedure MonsterClick(Sender: TObject);
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

uses uGameDrive, uAtlas;

{ TfTower }

procedure TfTower.MonsterClick(Sender: TObject);
begin
    GameDrive.PlayerAttack;
end;

procedure TfTower.Update(data: ISuperObject);
begin
    if not Assigned(data) then exit;

    lCurrFloor.Text := data.S['floor'];
    lCurrStep.Text := data.S['step'];
    lTargetFloor.Text := data.S['targetfloor'];

    Progress.Width := (data.I['step'] / data.I['maxstep']) * ProgressBG.Width;

    HP.Text   := data.S['params.HP'];
    MP.Text   := data.S['params.MP'];
    ATK.Text  := data.S['params.ATK'];
    DEF.Text  := data.S['params.DEF'];
    MDEF.Text := data.S['params.MDEF'];
    REG.Text  := data.S['params.REG'];
    Monster.MultiResBitmap[0].Bitmap.Assign(  fAtlas.GetBitmap(data.I['image']) );
end;

end.
