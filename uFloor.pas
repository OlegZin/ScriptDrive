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
    elem: ISuperObject;

    lineStep  // ���������� ��� ����������� �������� �� "������" ������������ �������.
              // ������� ���� ��������� � ����������� Y ��������� pointLeftTop ��� pointRightTop.
              // ������� ���� ��������� � ����������� Y ��������� pointLeftBottom ��� pointRightBottom.
              // ������ ������ ��������� �� ��������� �����. � ������ ����������
              // �������� �������� ������� �� ���������� Y ����� �������.
              // ������� �� ���������� �������� �� �����.
   ,sideStep  // ���������� ������ �� ���������� X ����� pointLeftTop � pointLeftBottom, ��� pointRightTop � pointRightBottom.
              // ������� �� ���������� �������� �� �����. ������������ ��� �����������
              // ���������� ������ ����� ������������ ������� �� ���������� �����
            : real;

    shablon: TLayout;
begin

    if not Assigned( lincs ) then lincs := TDictionary<TLayout,ISuperobject>.Create;

    /// ���� ���� ��������, ����� �������������
    if (Assigned(data) and (data.I['floor'] <> indata.I['floor'])) or
       not Assigned(data) then
    begin
        /// ���������� ��� ������
        data := nil;

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

        objNumber := data.I['count'];

        for elem in data do
        begin
            /// �������� ������ �� ������ � ����������� � ���� ��� �����������
            shablon := fFloorAtlas.GetShablonByName( elem.S['name'] ).Clone( layObjects );
            shablon.parent := layObjects;

            /// ��������� �������� � ����������
            /// �����
        end;
    end;
end;

end.
