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

uses uFloorAtlas;

{ TfFloor }

procedure TfFloor.Update(indata: ISuperObject);
/// входные данные
/// { floor: X,                // номер этажа
///   count: Y,                // количество объектов на этаже
///   Z: {                     // id объекта на этаже
//      'name: "",'+           // тип объекта. он же - им€ объекта с FloorAtlas
//      'params: {HP: 0, count:0 },'+
//      'effects: [],'+        // персональный скрипт при уничтожении. если нет, будет отработан
//      'id: Z,'+              // сервисный повтор id
///   }
/// }
var
    i, objNumber :integer;
    elem: ISuperObject;

    lineStep  // переменна€ дл€ расстановки объектов по "планам" относительно зрител€.
              // дальний план совпадает с координатой Y компонент pointLeftTop или pointRightTop.
              // ближний план совпадает с координатой Y компонент pointLeftBottom или pointRightBottom.
              // каждый объект находитс€ на отдельном плане. и данна€ переменна€
              // содержит величину разницы по координате Y между планами.
              // зависит от количества объектов на этаже.
   ,sideStep  // переменна€ сдвига по координате X между pointLeftTop и pointLeftBottom, или pointRightTop и pointRightBottom.
              // зависит от количества объектов на этаже. используетс€ дл€ определени€
              // допустимой ширины линии расположени€ объекта на конкретном плане
            : real;

    shablon: TLayout;
begin

    if not Assigned( lincs ) then lincs := TDictionary<TLayout,ISuperobject>.Create;

    /// если этаж сменилс€, будем перестраивать
    if (Assigned(data) and (data.I['floor'] <> indata.I['floor'])) or
       not Assigned(data) then
    begin
        /// сбрасываем все данные
        data := nil;

        /// удал€ем все объекты на этаже
        for I := layObjects.ControlsCount-1 downto 0 do
           layObjects.Controls[i].Free;

        /// чистим прив€зки визуальных объектов к данным
        lincs.Clear;
    end;

    /// при пустых текущих данных, принимаем входные данные как исходные
    /// и обрабатываем - создаем и расставл€ем предметы
    ///
    /// фишка в том, что создавать предметы этажа от дальнего плана к ближнему,
    /// тогда получитс€ корректное перекрытие объектов
    /// поскольку есть кос€к в FMX, не позвол€ющий мен€ть положение компонент
    /// по оси Z методами BringToFront и  SendToBack
    ///
    /// дл€ реалистичности, местоположение объектов по "нижнему краю" в трапеции
    /// образуемых 4 точками TSelectionPoint на форме, при этом, чем сама€ дальн€€
    /// позици€ модифицирует объект на 0.5 от реального масштаба и 0.5 от затемнени€
    if not Assigned(data) then
    begin
        data := indata;

        lineStep := ABS((pointLeftBottom.Position.Y - pointLeftTop.Position.Y)) / data.I['count'];
        sideStep := ABS((pointLeftTop.Position.X - pointLeftBottom.Position.X)) / data.I['count'];

        objNumber := data.I['count'];

        for elem in data do
        begin
            /// копируем объект из атласа и прив€зываем к слою дл€ отображени€
            shablon := fFloorAtlas.GetShablonByName( elem.S['name'] ).Clone( layObjects );
            shablon.parent := layObjects;

            /// настройка масштаба и затемнени€
            /// самый
        end;
    end;
end;

end.
