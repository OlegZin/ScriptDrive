unit uFloor;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts,
  superobject, Generics.Collections;

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
    layObjects: TLayout;
    SKAF2: TLayout;
    Image5: TImage;
    Image6: TImage;
    Label5: TLabel;
    Rectangle3: TRectangle;
    Label6: TLabel;
    Layout7: TLayout;
    Image23: TImage;
    Image24: TImage;
    Layout1: TLayout;
    Image11: TImage;
    Image12: TImage;
    KNIGHT1: TLayout;
    Image3: TImage;
    Image4: TImage;
  private
    { Private declarations }
    data : ISuperObject;
    lincs: TDictionary<TLayout,ISuperobject>;
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
/// входные данные
/// { floor: X,                // номер этажа
///   count: Y,                // количество объектов на этаже
///   Z: {                     // id объекта на этаже
//      'name: "",'+           // тип объекта. он же - имя объекта с FloorAtlas
//      'params: {HP: 0, count:0 },'+
//      'effects: [],'+        // персональный скрипт при уничтожении. если нет, будет отработан
//      'id: Z,'+              // сервисный повтор id
///   }
/// }
var
    i :integer;
begin

    if not Assigned( lincs ) then lincs := TDictionary<TLayout,ISuperobject>.Create;

    /// если этаж сменился, будем перестраивать
    if (Assigned(data) and (data.I['floor'] <> indata.I['floor'])) or
       not Assigned(data) then
    begin
        /// сбрасываем все данные
        data := nil;

        /// удаляем все объекты на этаже
        for I := layObjects.ControlsCount-1 downto 0 do
           layObjects.Controls[i].Free;

        /// чистим привязки визуальных объектов к данным
        lincs.Clear;
    end;


    if not Assigned(data) then
    begin
    end;
end;

end.
