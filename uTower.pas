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
    Image65: TImage;
    lAttackPool: TLabel;
    iAuto: TImage;
    Rectangle8: TRectangle;
    lName: TLabel;
    procedure MonsterClick(Sender: TObject);
    procedure Rectangle8Click(Sender: TObject);
  private
    { Private declarations }
    data: ISuperObject;

    lastImage : integer;
  public

    procedure Update(_data: ISuperObject);
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

procedure TfTower.Rectangle8Click(Sender: TObject);
begin
    if data.B['auto']
    then GameDrive.BreakAuto('Tower')
    else GameDrive.RunAuto('Tower');
end;

procedure TfTower.Update(_data: ISuperObject);
var
    w: real;
begin
    data := _data;

    self.BeginUpdate;

    if not Assigned(data) then exit;

    if data.B['auto']
    then iAuto.Opacity := 1
    else iAuto.Opacity := 0.3;


    if   lName.Text <> data.S['name']
    then lName.Text := data.S['name'];

    if   lCurrFloor.Text <> data.S['floor']
    then lCurrFloor.Text := data.S['floor'];

    if   lCurrStep.Text <> data.S['step']
    then lCurrStep.Text := data.S['step'];

    if   lTargetFloor.Text <> data.S['targetfloor']
    then lTargetFloor.Text := data.S['targetfloor'];

    if   lAttackPool.Text <> data.S['attackpool']
    then lAttackPool.Text := data.S['attackpool'];

    w := (data.I['step'] / data.I['maxstep']) * ProgressBG.Width;
    if   w <> Progress.Width
    then Progress.Width := w;

    if   HP.Text <> data.S['params.HP']
    then HP.Text := data.S['params.HP'];

    if   MP.Text <> data.S['params.MP']
    then MP.Text := data.S['params.MP'];

    if   ATK.Text <> data.S['params.ATK']
    then ATK.Text := data.S['params.ATK'];

    if   DEF.Text <> data.S['params.DEF']
    then DEF.Text := data.S['params.DEF'];

    if   MDEF.Text <> data.S['params.MDEF']
    then MDEF.Text := data.S['params.MDEF'];

    if lastImage <> data.I['image'] then
    begin
        Monster.MultiResBitmap[0].Bitmap.Assign(  fAtlas.GetBitmap(data.I['image']) );
        lastImage := data.I['image'];
    end;

    self.EndUpdate;
end;

end.
