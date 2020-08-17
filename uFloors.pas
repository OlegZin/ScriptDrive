unit uFloors;

interface

uses
    System.Generics.Collections, Math;

type
    TTrash = record
       name: string;     /// ���������� ���
       caption: string;  /// ��� ����� �������� �� ������� ��������� Count
       count : integer;  /// ���������� ����� �� ������������ script
       script: string;   /// ������ ������� � ������ ������������
       size: string;     /// �������� ������ ������� � ������ ������. ������ �� �����
       /// ��������� ������ �������� ��� �������� �������
    end;


    TFloor = record
      Trash: TDictionary<integer,TTrash>;      // ���������� � ���� ���������� �������� ��� ������ ����
      Captured: boolean;  // ���������� �� ���� (������� ����� ���� �������)
      AltarCost: string;  // ����� � ���������� �������� ��� ��������� ������ � ������ ����
      isExit: integer;    // 0 , -1 ����������, 1 ������
      Window: boolean;    // ��������� �� ������ � �����
    end;

var
    arrFloors: array [1..13] of TFloor;

    floorObjects: array [0..28] of string = (
        'Trash','Trash','Trash','Trash','Trash','Trash','Trash','Trash','Trash','Trash',
        'Rat',  'Rat',  'Rat',  'Rat',  'Rat',
        'SmallChest', 'SmallChest', 'SmallChest',
        'Spider',     'Spider',
        'Trap',       'Trap',
        'BigChest',   'BigChest',
        'Cache',
        'StoneBlockage', 'StoneBlockage',
        'WoodBlockage', 'WoodBlockage'
    );

implementation

uses SysUtils, uTypes;

var
    Events: string;

procedure Init;
var
    i, j, exitFloor, trashCount : integer;
    trash, param: string;
    elem: TTrash;
    found: boolean;
begin
    exitFloor := Random(High(arrFloors))+1;

    for I := Low(arrFloors) to High(arrFloors) do
    begin

        arrFloors[i].Trash := TDictionary<Integer,TTrash>.Create();

    // �������
        trashCount := Max(Random(i*10), 50);

        for j := 0 to trashCount-1 do
        begin

            found := false;
            // ���������� ��� �������
            trash := floorObjects[Random(High(floorObjects))];


            if (j = 0) and (i = 1) then trash := 'Trash';
            if (j = 0) and (i = 3) then trash := 'Trash';

            elem.size := 'normal';


            /// �������� ����
            if trash = 'Trash' then
            begin

               found := true;

               elem.count := Random(i*50) + 50;

               elem.caption := 'RU=�����,ENG=Garbage';

               // � ������ ������ ������ ������ �������� �������� � ������
               // ������ ���� - ������ ��� ����������� ������
               if (j = 0) and (i = 1) then
               begin
               elem.script :=
                   'AllowMode(Tools, 1);' +
                   'AllowTool(Shovel);' +
                   'IF({GetLang() = RU}, 2);'+
                   'AddFloorEvent(������ ������ � ������ ����������!);'+
                   'AddFloorEvent(����� ��������� ������!);'+
                   'IF({GetLang() = ENG}, 2);'+
                   'AddFloorEvent(Access to the Tools mode is open!);'+
                   'AddFloorEvent(The player discovered the Shovel!);'+
                    'AddFloorEvent( );'
               end
               else

               // ����� ��� ����������� �������
               if (j = 0) and (i = 3) then
               begin
               elem.script :=
                   'AllowMode(Tools, 1);' +
                   'AllowTool(Pick);' +
                   'IF({GetLang() = RU}, 2);'+
                   'AddFloorEvent(������ ������ � ������ ����������!);'+
                   'AddFloorEvent(����� ��������� �����!);'+
                   'IF({GetLang() = ENG}, 2);'+
                   'AddFloorEvent(Access to the Tools mode is open!);'+
                   'AddFloorEvent(The player discovered the Pick!);'+
                    'AddFloorEvent( );'
               end
               else

               elem.script :=
                   'SetVar(obj, '+loot[Random(Length(loot))]+');'+
                   'SetVar(count, ' + IntToStr(Random(i)+1) +');'+
                   'SetPlayerRes(GetVar(obj), GetVar(count));' +
                   'IF({GetLang() = RU}, 1);'+
                   'AddFloorEvent(����� ��������� GetVar(count) GetVar(obj)!);'+
                   'IF({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(Player found GetVar(count) GetVar(obj)!);'+
                    'AddFloorEvent( );'
            end;

            /// ����� ������
            if trash = 'SmallChest' then
            begin
               found := true;

               elem.count := Random(i*50) + 100;

               elem.caption := 'RU=�����,ENG=Box';

               elem.script :=
                   'SetVar(iName, GetRandItemName());'+
                   'ChangePlayerItemCount(GetVar(iName), 1);'+
                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(����� ������� GetVar(iName)!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(Player got GetVar(iName)!);'+
                    'AddFloorEvent( );'
            end;


            /// ������� ������
            if trash = 'BigChest' then
            begin
               found := true;

               elem.count := Random(i*50) + 150;

               elem.caption := 'RU=������,ENG=Chest';

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
               found := true;

               elem.count := Random(i*50) + 200;

               elem.caption := 'RU=������,ENG=�ache';

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
               found := true;

               elem.count := 0;

               elem.caption := 'RU=�����,ENG=Rat';

               elem.script :=
                   'SetVar(dmg, Rand('+IntToStr(i*50+50)+'));'+
                   'ChangePlayerParam(HP, -GetVar(dmg));'+

                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(�� ���� ������ ��������� ����� � ������� ��� �� GetVar(dmg) HP!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(A rat jumped out of a pile of garbage and bit you for GetVar(dmg) HP!);'+
                   'AddFloorEvent( );'
            end;

            /// �����
            if trash = 'StoneBlockage' then
            begin
               found := true;

                elem.size := 'huge';
                elem.count := Random(i*100) + 1000;

                elem.caption := 'RU="�������� �����",ENG="Stone blockage"';

                elem.script :=
                    'SetVar(count, Rand('+IntToStr(i*100+10)+'));'+
                    'SetPlayerRes(Stone, GetVar(count));' +
                    'If({GetLang() = RU}, 2);'+
                    'AddFloorEvent("����� ������� GetVar(count) Stone!");'+
                    'AddFloorEvent("�������-�� ����� ��������...");'+
                    'If({GetLang() = ENG}, 2);'+
                    'AddFloorEvent("Player got GetVar(count) Stone!");'+
                    'AddFloorEvent("Finally, the blockage is dismantled ...");'+
                    'AddFloorEvent( );'
            end;

            /// �����
            if trash = 'WoodBlockage' then
            begin
               found := true;

                elem.size := 'huge';
                elem.count := Random(i*100) + 1000;

                elem.caption := 'RU="���������� �����",ENG="Wood blockage"';

                elem.script :=
                    'SetVar(count, Rand('+IntToStr(i*100+10)+'));'+
                    'SetPlayerRes(Wood, GetVar(count));' +
                    'If({GetLang() = RU}, 2);'+
                    'AddFloorEvent("����� ������� GetVar(count) Wood!");'+
                    'AddFloorEvent("�������-�� ����� ��������...");'+
                    'If({GetLang() = ENG}, 2);'+
                    'AddFloorEvent("Player got GetVar(count) Wood!");'+
                    'AddFloorEvent("Finally, the blockage is dismantled ...");'+
                    'AddFloorEvent( );'
            end;

            /// �������
            if trash = 'Trap' then
            begin
               found := true;

               elem.count := 0;

               elem.caption := 'RU=�������,ENG=Trap';

               case Random(3) of
                  0: param := 'ATK';
                  1: param := 'DEF';
                  2: param := 'MDEF';
               end;

               elem.script :=
                   'ChangePlayerParam('+param+', -1);'+

                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(������� ������� ������! �������� 1 '+param+'!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(The trap hurt! Lost 1 '+param+'!);'+
                   'AddFloorEvent( );'
            end;

            /// ����
            if trash = 'Spider' then
            begin
               found := true;

               elem.count := 0;

               elem.caption := 'RU=����,ENG=Spider';

               elem.script :=
                   'SetPlayerAutoBuff(HP, -Rand('+IntToStr(i*100)+'));'+

                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(�������� ���� ������ ���!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(The poisonous spider bit you!);'+
                   'AddFloorEvent( );'
            end;

            if not found then
            found := found;

            elem.name := trash;

            arrFloors[i].Trash.Add(j, elem);

        end;

        // "������" ������� (������� ������ ��������)
        arrFloors[i].Trash.TrimExcess;

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
