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
    lFloorPool: TLabel;
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
    Timer: TTimer;
    procedure Rectangle8Click(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    { Private declarations }
    data : ISuperObject;
    lincs: TDictionary<TLayout,ISuperobject>;
    selectedObj : TLayout;

    procedure OnClick(sender: TObject);
  public
    { Public declarations }
    procedure Update(indata: ISuperObject);
  end;

var
  fFloor: TfFloor;

implementation

{$R *.fmx}

uses uFloorAtlas, uConst, uGameDrive;

{ TfFloor }

procedure TfFloor.OnClick(sender: TObject);
var
    i: integer;
begin
    /// переключение активного объекта,
    /// который отмечается видимостью числом хитов

    if Assigned( selectedObj ) then
    for I := 0 to selectedObj.ComponentCount-1 do
      if (selectedObj.Components[i].Tag = DIGIT_OBJECT) or
         (selectedObj.Components[i].Tag = FACE_DIGIT_OBJECT)then
         (selectedObj.Components[i] as TControl).Visible := false;

    selectedObj := sender as TLayout;

    for I := 0 to selectedObj.ComponentCount-1 do
      if (selectedObj.Components[i].Tag = DIGIT_OBJECT) or
         (selectedObj.Components[i].Tag = FACE_DIGIT_OBJECT)then
         (selectedObj.Components[i] as TControl).Visible := true;

    /// по линкам находим данные и вызываем метод
    GameDrive.PlayerFloor( lincs[selectedObj].S['id'] );
end;

procedure TfFloor.Rectangle8Click(Sender: TObject);
begin
    if data.B['auto']
    then GameDrive.BreakAuto('Floor')
    else GameDrive.RunAuto('Floor');
end;

procedure TfFloor.TimerTimer(Sender: TObject);
begin
    iAuto.RotationAngle := iAuto.RotationAngle + 1;
end;

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
    i, objNumber :integer;
    inelem, elem: ISuperObject;


    lineStep  // переменная для расстановки объектов по "планам" относительно зрителя.
              // дальний план совпадает с координатой Y компонент pointLeftTop или pointRightTop.
              // ближний план совпадает с координатой Y компонент pointLeftBottom или pointRightBottom.
              // каждый объект находится на отдельном плане. и данная переменная
              // содержит величину разницы по координате Y между планами.
              // зависит от количества объектов на этаже.
   ,sideStep  // переменная сдвига по координате X между pointLeftTop и pointLeftBottom, или pointRightTop и pointRightBottom.
              // зависит от количества объектов на этаже. используется для определения
              // допустимой ширины линии расположения объекта на конкретном плане
   ,percent   // процент масштаба и затемнения объекта в диапазоне от 1 до 0.5
            : real;

    shablon: TLayout;

    function GetObjByID(id : integer): TLayout;
    var
        pair: TPair<TLayout,ISuperobject>;
    begin
        for pair in lincs do
        if  pair.Value.I['id'] = id
        then result := pair.Key;
    end;

begin

    if not Assigned( lincs ) then lincs := TDictionary<TLayout,ISuperobject>.Create;

    /// если этаж сменился, будем перестраивать
    if (Assigned(data) and (data.I['floor'] <> indata.I['floor'])) or
       not Assigned(data) then
    begin
        /// сбрасываем все данные
        data := nil;

        selectedObj := nil;

        /// удаляем все объекты на этаже
        for I := layObjects.ControlsCount-1 downto 0 do
           layObjects.Controls[i].Free;

        /// чистим привязки визуальных объектов к данным
        lincs.Clear;
    end;

    /// при пустых текущих данных, принимаем входные данные как исходные
    /// и обрабатываем - создаем и расставляем предметы
    ///
    /// фишка в том, что создавать предметы этажа от дальнего плана к ближнему,
    /// тогда получится корректное перекрытие объектов
    /// поскольку есть косяк в FMX, не позволяющий менять положение компонент
    /// по оси Z методами BringToFront и  SendToBack
    ///
    /// для реалистичности, местоположение объектов по "нижнему краю" в трапеции
    /// образуемых 4 точками TSelectionPoint на форме, при этом, чем самая дальняя
    /// позиция модифицирует объект на 0.5 от реального масштаба и 0.5 от затемнения
    if not Assigned(data) then
    begin
        data := indata;

        lineStep := ABS((pointLeftBottom.Position.Y - pointLeftTop.Position.Y)) / data.I['count'];
        sideStep := ABS((pointLeftTop.Position.X - pointLeftBottom.Position.X)) / data.I['count'];

        objNumber := 0;

        for elem in data do
        if Assigned(elem.O['name']) and (elem.S['name'] <> '') then
        begin
            /// копируем объект из атласа и привязываем к слою для отображения
            shablon := fFloorAtlas.GetShablonByName( elem.S['name'] ).Clone( layObjects ) as TLayout;
            shablon.parent := layObjects;
            shablon.Align := TAlignLayout.Scale;
            shablon.OnClick := OnClick;

            /// связываем объект с данными
            lincs.Add( shablon, elem );

            /// настройка масштаба и затемнения
            percent := MIN_SIZE_PERCENT + objNumber * ((1 - MIN_SIZE_PERCENT) / data.I['count']);
            shablon.Scale.X := percent;
            shablon.Scale.Y := percent;

            for I := 0 to shablon.ComponentCount-1 do
            begin
              if shablon.Components[i].Tag = FACE_OBJECT then
              begin
                  (shablon.Components[i] as TControl).Opacity :=
                     MIN_DARK_PERCENT + objNumber * ((1 - MIN_DARK_PERCENT) / data.I['count']);
              end;

              if (shablon.Components[i].Tag = DIGIT_OBJECT) or
                 (shablon.Components[i].Tag = FACE_DIGIT_OBJECT)
              then
              begin
                  (shablon.Components[i] as TLabel).Text := elem.S['params.HP'];
                  (shablon.Components[i] as TControl).Visible := false;
              end;

              (shablon.Components[i] as TControl).HitTest := false;
            end;

            /// позиционирование
            shablon.Position.Y := pointLeftTop.Position.Y - (shablon.Height * percent ) + objNumber * lineStep;
            shablon.Position.X := Random(
                Round(pointRightTop.Position.X - pointLeftTop.Position.X + sideStep * 2 * objNumber - ( shablon.Width * percent ))) +
                /// ширина текущей "линии" за минусом ширины объекта
                pointLeftTop.Position.X - sideStep * objNumber;
                /// плюс смещение от нуля до координаты начала текущей линии

            inc(objNumber);
        end;
    end else

    /// при непустых данных пробегаем по объектам и ищем различия.
    /// нужно ли удалять/добавлять объекты, тексты на них
    begin
        /// перебираем все элементы входных данных и сопоставляем с
        /// имеющимися с прошлого обновления
        /// исходим из того, что входящих элементов может быть только меньше
        /// потому, будем отталкиваться от внутренних данных
        for elem in data do
        if Assigned(elem.O['name']) and (elem.S['name'] <> '') then
            /// отсекаем не объекты на этаже, например, поле с количеством объектов
        begin
            /// ищем объект представления для данных с текущим id
            shablon := GetObjByID(elem.I['id']);

            /// отсутствие элемента в новых - признак того, что нужно удалить объект представления в интерфейсе
            if not Assigned( indata.O[elem.S['id']] ) then
            if Assigned(shablon) then shablon.Free;

            /// если элемент присутствует
            if Assigned( indata.O[elem.S['id']] ) then
            begin
                /// и шаблон найден
                if Assigned(shablon) then
                for I := 0 to shablon.ComponentCount-1 do

                /// обновляем количество хитов в лейблах
                if (shablon.Components[i].Tag = DIGIT_OBJECT) or
                   (shablon.Components[i].Tag = FACE_DIGIT_OBJECT)
                then
                   (shablon.Components[i] as TLabel).Text := indata.S[elem.S['id']+'.params.HP'];
            end;
        end;

        /// сохраняем новые данные как обработанные
        data := indata;
    end;

    /// отображаем номер текущего этажа
    lCurrFloor.Text := data.S['floor'];
    lFloorPool.Text := data.S['pool'];

    /// активность и анимация кнопки автодействий
    if data.B['auto'] then
    begin
        iAuto.Opacity := 1;
        Timer.Enabled := true;
    end else
    begin
        iAuto.Opacity := 0.3;
        Timer.Enabled := false;
    end;

end;

end.
