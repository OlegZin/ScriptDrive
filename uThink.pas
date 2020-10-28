unit uThink;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Ani, FMX.Controls.Presentation, FMX.StdCtrls,
  superobject;

type
  TfThink = class(TForm)
    layThink: TLayout;
    Rectangle10: TRectangle;
    Image1: TImage;
    Rectangle12: TRectangle;
    iAuto: TImage;
    Image65: TImage;
    lAttackPool: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    laySticks: TLayout;
  private
    { Private declarations }
    data: ISuperobject;
  public
    { Public declarations }
    procedure Update(_data: ISuperObject);
  end;

var
  fThink: TfThink;

implementation

{$R *.fmx}

uses uAtlas;

{ TfThink }

procedure TfThink.Update(_data: ISuperObject);
var
    item:ISuperObject;
    i : integer;
    obj : TControl;
begin

    for I := laySticks.ControlsCount-1 downto 0 do
    laySticks.Controls[i].Free;

    for item in _data.O['thinks'] do
    begin
        obj := fAtlas.ThinkShablon.Clone( laySticks ) as TControl;
        obj.Parent := laySticks;

        /// если данные по этому объекту приходят впервые, заполняем локальные данные положения
        if not assigned(data) or not assigned(data.O['thinks.'+item.S['name']]) then
        begin
          _data.I['thinks.'+item.S['name']+'.x'] := Random( Round(laySticks.Width - obj.Width) );
          _data.I['thinks.'+item.S['name']+'.y'] := Random( Round(laySticks.Height - obj.Height) );
          _data.I['thinks.'+item.S['name']+'.rotation'] := Random( 30 ) - 15;

          obj.Position.X := _data.I['thinks.'+item.S['name']+'.x'];
          obj.Position.Y := _data.I['thinks.'+item.S['name']+'.y'];
          (obj as TRectangle).RotationAngle := _data.I['thinks.'+item.S['name']+'.rotation'];
        end else
        begin
          obj.Position.X := data.I['thinks.'+item.S['name']+'.x'];
          obj.Position.Y := data.I['thinks.'+item.S['name']+'.y'];
          (obj as TRectangle).RotationAngle := data.I['thinks.'+item.S['name']+'.rotation'];
        end;


    end;

    data := _data;
end;

end.
