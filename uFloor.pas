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
    /// ������������ ��������� �������,
    /// ������� ���������� ���������� ������ �����

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

    /// �� ������ ������� ������ � �������� �����
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
/// ������� ������
/// { floor: X,                // ����� �����
///   count: Y,                // ���������� �������� �� �����
///   Z: {                     // id ������� �� �����
//      'name: "",'+           // ��� �������. �� �� - ��� ������� � FloorAtlas
//      'params: {HP: 0, count:0 },'+
//      'effects: [],'+        // ������������ ������ ��� �����������. ���� ���, ����� ���������
//      'id: Z,'+              // ��������� ������ id
///   }
/// }
var
    i, objNumber :integer;
    inelem, elem: ISuperObject;


    lineStep  // ���������� ��� ����������� �������� �� "������" ������������ �������.
              // ������� ���� ��������� � ����������� Y ��������� pointLeftTop ��� pointRightTop.
              // ������� ���� ��������� � ����������� Y ��������� pointLeftBottom ��� pointRightBottom.
              // ������ ������ ��������� �� ��������� �����. � ������ ����������
              // �������� �������� ������� �� ���������� Y ����� �������.
              // ������� �� ���������� �������� �� �����.
   ,sideStep  // ���������� ������ �� ���������� X ����� pointLeftTop � pointLeftBottom, ��� pointRightTop � pointRightBottom.
              // ������� �� ���������� �������� �� �����. ������������ ��� �����������
              // ���������� ������ ����� ������������ ������� �� ���������� �����
   ,percent   // ������� �������� � ���������� ������� � ��������� �� 1 �� 0.5
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

    /// ���� ���� ��������, ����� �������������
    if (Assigned(data) and (data.I['floor'] <> indata.I['floor'])) or
       not Assigned(data) then
    begin
        /// ���������� ��� ������
        data := nil;

        selectedObj := nil;

        /// ������� ��� ������� �� �����
        for I := layObjects.ControlsCount-1 downto 0 do
           layObjects.Controls[i].Free;

        /// ������ �������� ���������� �������� � ������
        lincs.Clear;
    end;

    /// ��� ������ ������� ������, ��������� ������� ������ ��� ��������
    /// � ������������ - ������� � ����������� ��������
    ///
    /// ����� � ���, ��� ��������� �������� ����� �� �������� ����� � ��������,
    /// ����� ��������� ���������� ���������� ��������
    /// ��������� ���� ����� � FMX, �� ����������� ������ ��������� ���������
    /// �� ��� Z �������� BringToFront �  SendToBack
    ///
    /// ��� ��������������, �������������� �������� �� "������� ����" � ��������
    /// ���������� 4 ������� TSelectionPoint �� �����, ��� ����, ��� ����� �������
    /// ������� ������������ ������ �� 0.5 �� ��������� �������� � 0.5 �� ����������
    if not Assigned(data) then
    begin
        data := indata;

        lineStep := ABS((pointLeftBottom.Position.Y - pointLeftTop.Position.Y)) / data.I['count'];
        sideStep := ABS((pointLeftTop.Position.X - pointLeftBottom.Position.X)) / data.I['count'];

        objNumber := 0;

        for elem in data do
        if Assigned(elem.O['name']) and (elem.S['name'] <> '') then
        begin
            /// �������� ������ �� ������ � ����������� � ���� ��� �����������
            shablon := fFloorAtlas.GetShablonByName( elem.S['name'] ).Clone( layObjects ) as TLayout;
            shablon.parent := layObjects;
            shablon.Align := TAlignLayout.Scale;
            shablon.OnClick := OnClick;

            /// ��������� ������ � �������
            lincs.Add( shablon, elem );

            /// ��������� �������� � ����������
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

            /// ����������������
            shablon.Position.Y := pointLeftTop.Position.Y - (shablon.Height * percent ) + objNumber * lineStep;
            shablon.Position.X := Random(
                Round(pointRightTop.Position.X - pointLeftTop.Position.X + sideStep * 2 * objNumber - ( shablon.Width * percent ))) +
                /// ������ ������� "�����" �� ������� ������ �������
                pointLeftTop.Position.X - sideStep * objNumber;
                /// ���� �������� �� ���� �� ���������� ������ ������� �����

            inc(objNumber);
        end;
    end else

    /// ��� �������� ������ ��������� �� �������� � ���� ��������.
    /// ����� �� �������/��������� �������, ������ �� ���
    begin
        /// ���������� ��� �������� ������� ������ � ������������ �
        /// ���������� � �������� ����������
        /// ������� �� ����, ��� �������� ��������� ����� ���� ������ ������
        /// ������, ����� ������������� �� ���������� ������
        for elem in data do
        if Assigned(elem.O['name']) and (elem.S['name'] <> '') then
            /// �������� �� ������� �� �����, ��������, ���� � ����������� ��������
        begin
            /// ���� ������ ������������� ��� ������ � ������� id
            shablon := GetObjByID(elem.I['id']);

            /// ���������� �������� � ����� - ������� ����, ��� ����� ������� ������ ������������� � ����������
            if not Assigned( indata.O[elem.S['id']] ) then
            if Assigned(shablon) then shablon.Free;

            /// ���� ������� ������������
            if Assigned( indata.O[elem.S['id']] ) then
            begin
                /// � ������ ������
                if Assigned(shablon) then
                for I := 0 to shablon.ComponentCount-1 do

                /// ��������� ���������� ����� � �������
                if (shablon.Components[i].Tag = DIGIT_OBJECT) or
                   (shablon.Components[i].Tag = FACE_DIGIT_OBJECT)
                then
                   (shablon.Components[i] as TLabel).Text := indata.S[elem.S['id']+'.params.HP'];
            end;
        end;

        /// ��������� ����� ������ ��� ������������
        data := indata;
    end;

    /// ���������� ����� �������� �����
    lCurrFloor.Text := data.S['floor'];
    lFloorPool.Text := data.S['pool'];

    /// ���������� � �������� ������ ������������
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
