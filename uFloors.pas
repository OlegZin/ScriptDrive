unit uFloors;

interface

uses
    System.Generics.Collections;

type
    TTrash = record
       caption: string;  /// ��� ����� �������� �� ������� ��������� Count
       count : integer;  /// ���������� ����� �� ������������ script
       script: string;   /// ������ ������� � ������ ������������
    end;


    TFloor = record
      Trash: TDictionary<integer,TTrash>;      // ���������� � ���� ���������� �������� ��� ������ ����
      Captured: boolean;  // ���������� �� ���� (������� ����� ���� �������)
      AltarCost: string;  // ����� � ���������� �������� ��� ��������� ������ � ������ ����
      isExit: integer;    // 0 , -1 ����������, 1 ������
      Window: boolean;    // ��������� �� ������ � �����
    end;

var
    arrFloors: array [1..10] of TFloor;

    floorObjects: array [0..27] of string = (
        'Trash','Trash','Trash','Trash','Trash','Trash','Trash','Trash','Trash','Trash',
        'Rat',  'Rat',  'Rat',  'Rat',  'Rat',  'Rat',  'Rat',  'Rat',
        'SmallChest', 'SmallChest', 'SmallChest', 'SmallChest', 'SmallChest',
//        'Spider',     'Spider',     'Spider',     'Spider',     'Spider',
//        'Trap',       'Trap',       'Trap',       'Trap',
        'BigChest',   'BigChest',   'BigChest',
        'Cache',      'Cache'
    );

implementation

uses SysUtils, uTypes;

var
    Events: string;

procedure Init;
var
    i, j, exitFloor, trashCount : integer;
    trash: string;
    elem: TTrash;
begin
    exitFloor := Random(High(arrFloors))+1;

    for I := Low(arrFloors) to High(arrFloors) do
    begin

        arrFloors[i].Trash := TDictionary<Integer,TTrash>.Create();

    // �������
        trashCount := Random(i*2)+5;

        for j := 0 to trashCount-1 do
        begin

            // ���������� ��� �������
            trash := floorObjects[Random(High(floorObjects))];

            /// �������� ����
            if trash = 'Trash' then
            begin
               elem.count := Random(i*50) + 50;

               elem.caption := 'RU=����� ENG=Garbage';

               elem.script :=
                   'SetVar(obj, '+loot[Random(Length(loot))]+');'+
                   'SetVar(count, ' + IntToStr(Random(i)+1) +');'+
                   'SetPlayerRes(GetVar(obj), GetVar(count));' +
                   'IF({GetLang() = RU}, 1);'+
                   'AddFloorEvent(����� ��������� GetVar(count) GetVar(obj)!);'+
                   'IF({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(Player found GetVar(count) GetVar(obj)!);'
            end;

            /// ����� ������
            if trash = 'SmallChest' then
            begin
               elem.count := Random(i*50) + 100;

               elem.caption := 'RU=����� ENG=Box';

               elem.script :=
                   'SetVar(iName, GetRandItemName());'+
                   'ChangePlayerItemCount(GetVar(iName), 1);'+
                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(����� ������� GetVar(iName)!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(Player got GetVar(iName)!);'
            end;


            /// ������� ������
            if trash = 'BidChest' then
            begin
               elem.count := Random(i*50) + 150;

               elem.caption := 'RU=������ ENG=Chest';

               elem.script :=
                   'SetVar(iName, GetRandItemName());'+
                   'SetVar(iCount, {Rand('+ IntToStr(i) +') + 1});'+
                   'ChangePlayerItemCount(GetVar(iName), GetVar(iCount));'+

                   'SetVar(lName, '+loot[Random(Length(loot))]+');'+
                   'SetVar(lCount, ' + IntToStr(Random(i*2)+1) +');'+
                   'SetPlayerRes(GetVar(lName), GetVar(lCount));' +

                   'SetVar(gold, Rand('+IntToStr(i*1000+1)+'));'+
                   'ChangePlayerItemCount(Gold, GetVar(gold));'+

                   'If({GetLang() = RU}, 3);'+
                   'AddFloorEvent(����� ������� GetVar(gold) ������!);'+
                   'AddFloorEvent(����� ������� GetVar(lCount) GetVar(lName)!);'+
                   'AddFloorEvent(����� ������� GetVar(iCount) GetVar(iName)!);'+
                   'If({GetLang() = ENG}, 3);'+
                   'AddFloorEvent(Player got GetVar(gold) Gold!);'+
                   'AddFloorEvent(Player got GetVar(lCount) GetVar(lName)!);'+
                   'AddFloorEvent(Player got GetVar(iCount) GetVar(iName)!);'+
                   'AddFloorEvent( );'
            end;

            /// ������
            if trash = 'Cache' then
            begin
               elem.count := Random(i*50) + 200;

               elem.caption := 'RU=������ ENG=�ache';

               elem.script :=
                   'SetVar(gold, Rand('+IntToStr(i*10000+1)+'));'+
                   'ChangePlayerItemCount(Gold, GetVar(gold));'+

                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(����� ������� GetVar(gold) ������!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(Player got GetVar(gold) Gold!);'+
                   'AddFloorEvent( );'
            end;

            /// �����
            if trash = 'Rat' then
            begin
               elem.count := 0;

               elem.caption := 'RU=����� ENG=Rat';

               elem.script :=
                   'SetVar(dmg, Rand('+IntToStr(i*50+50)+'));'+
                   'ChangePlayerParam(HP, -GetVar(dmg));'+

                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(�� ���� ������ ��������� ����� � ������� ��� �� GetVar(dmg) HP!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(A rat jumped out of a pile of garbage and bit you for GetVar(dmg) HP!);'+
                   'AddFloorEvent( );'
            end;

            arrFloors[i].Trash.Add(j, elem);

        end;

    // ������� ������� �����
        arrFloors[i].Captured := false;

    // ������� ����������� ������
        if i < exitFloor then arrFloors[i].isExit := -1;
        if i > exitFloor then arrFloors[i].isExit := 1;
        if i = exitFloor then arrFloors[i].isExit := 0;

    // ������� ������� ����
        arrFloors[i].Window := false;
    end;
end;

initialization

    Init;

end.
