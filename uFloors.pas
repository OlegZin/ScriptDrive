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
        'Trash', 'Trash','Trash','Trash','Trash','Trash','Trash','Trash','Trash','Trash',
        'Rat',   'Rat',  'Rat',  'Rat',  'Rat',
        'Box',   'Box',  'Box',
        'Spider','Spider',
        'Trap',  'Trap',
        'Chest', 'Chest',
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
    levelNum, j, exitFloor, trashCount : integer;
    trash, param: string;
    elem: TTrash;
    found

   ,FirstTrash
   ,FirstRat
   ,FirstBox
   ,FirstSpider
   ,FirstTrap
   ,FirstChest
   ,FirstStoneBlockage
   ,FirstWoodBlockage
   ,FirstCache
       : boolean;
begin
    exitFloor := Random(High(arrFloors))+1;

    for levelNum := Low(arrFloors) to High(arrFloors) do
    begin

        arrFloors[levelNum].Trash := TDictionary<Integer,TTrash>.Create();

    // �������
        trashCount := Max(Random(levelNum*10), 50);

        FirstTrash          := true;
        FirstBox            := true;
        FirstChest          := true;
        FirstStoneBlockage  := true;
        FirstWoodBlockage   := true;
        FirstCache          := true;
        FirstRat            := true;
        FirstSpider         := true;
        FirstTrap           := true;

        for j := 0 to trashCount-1 do
        begin

            found := false;

            // ���������� ��� �������
            trash := floorObjects[Random(High(floorObjects))];

            elem.size := 'normal';

            /// �������� ����
            if trash = 'Trash' then
            begin

               found := true;

               elem.count := Random(levelNum*50) + 50;

               elem.caption := 'RU=�����,ENG=Garbage';

               // � ������ ������ ������ ������ �������� �������� � ������
               // ������ ���� - ������ ��� ����������� ������
               if FirstTrash and (levelNum = 1) then
               begin
               elem.script :=
                   'AllowMode(Tools, 1);' +
                   'AllowTool(Shovel);' +
                   'IF({GetLang() = RU}, 1);'+
                   'AddFloorEvent(!!! ����� ��������� ������ !!!);'+
                   'IF({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(!!! The player discovered the Shovel !!!);'+
                    'AddFloorEvent( );'
               end
               else

               // ����� ��� ����������� �������
               if FirstTrash and (levelNum = 2) then
               begin
               elem.script :=
                   'AllowMode(Tools, 1);' +
                   'AllowTool(Pick);' +
                   'IF({GetLang() = RU}, 1);'+
                   'AddFloorEvent(!!! ����� ��������� ����� !!!);'+
                   'IF({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(!!! The player discovered the Pick !!!);'+
                    'AddFloorEvent( );'
               end
               else

               // ����� ��� ����������� �������
               if FirstTrash and (levelNum = 3) then
               begin
               elem.script :=
                   'AllowMode(Tools, 1);' +
                   'AllowTool(Axe);' +
                   'IF({GetLang() = RU}, 1);'+
                   'AddFloorEvent(!!! ����� ��������� ����� !!!);'+
                   'IF({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(!!! The player discovered the Axe !!!);'+
                    'AddFloorEvent( );'
               end
               else

               // ����� ��� ����������� �������
               if FirstTrash and (levelNum = 4) then
               begin
               elem.script :=
                   'AllowMode(Tools, 1);' +
                   'AllowTool(Key);' +
                   'IF({GetLang() = RU}, 1);'+
                   'AddFloorEvent(!!! ����� ��������� ������� !!!);'+
                   'IF({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(!!! The player discovered the Lock pick !!!);'+
                   'AddFloorEvent( );'
               end
               else

               elem.script :=
                   'SetVar(obj, '+loot[Random(Length(loot))]+');'+
                   'SetVar(count, ' + IntToStr(Random(levelNum)+1) +');'+
                   'SetPlayerRes(GetVar(obj), GetVar(count));' +
                   'IF({GetLang() = RU}, 1);'+
                   'AddFloorEvent(����� ��������� GetVar(count) GetVar(obj)!);'+
                   'IF({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(Player found GetVar(count) GetVar(obj)!);'+
                   'AddFloorEvent( );';

               FirstTrash := false;
            end;

            /// ����
            if trash = 'Box' then
            begin
               found := true;

               elem.count := Random(levelNum*60) + 100;

               elem.caption := 'RU=����,ENG=Box';

               elem.script :=
                   'SetVar(iName, GetRandItemName());'+
                   'ChangePlayerItemCount(GetVar(iName), 1);'+
                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(����� ������� GetVar(iName)!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(Player got GetVar(iName)!);'+
                   'AddFloorEvent( );';
               FirstBox := false;
            end;


            /// ������
            if trash = 'Cache' then
            begin
               found := true;

               elem.count := Random(levelNum*70) + 150;

               elem.caption := 'RU=������,ENG=�ache';

               if FirstChest and (levelNum = 2) then
               elem.script :=
                   'AllowTool(LifeAmulet);'+

                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(!!! ����� ����� ������ ����� !!!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(!!! The player found the Amulet of Life !!!);'+
                   'AddFloorEvent( );'
               else

               elem.script :=
                   'SetVar(gold, Rand('+IntToStr(levelNum*10000+1)+'));'+
                   'ChangePlayerItemCount(Gold, GetVar(gold));'+

                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(����� ������� GetVar(gold) ������!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(Player got GetVar(gold) Gold!);'+
                   'AddFloorEvent( );';
               FirstCache := false;
            end;

            /// ������
            if trash = 'Chest' then
            begin
               found := true;

               elem.count := Random(levelNum*80) + 200;

               elem.caption := 'RU=������,ENG=Chest';

               if True then

               if FirstChest and (levelNum = 5) then
               elem.script :=
                   'AllowTool(TimeSand);'+

                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(!!! ����� ����� ����� ������� !!!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(!!! The player found the Sands of Time !!!);'+
                   'AddFloorEvent( );'
               else

               elem.script :=
                   'SetVar(iName, GetRandItemName());'+
                   'SetVar(iCount, {Rand('+ IntToStr(levelNum) +') + 1});'+
                   'ChangePlayerItemCount(GetVar(iName), GetVar(iCount));'+

                   'SetVar(lName, '+loot[Random(Length(loot))]+');'+
                   'SetVar(lCount, ' + IntToStr(Random(levelNum*2)+1) +');'+
                   'SetPlayerRes(GetVar(lName), GetVar(lCount));' +

                   'SetVar(gold, Rand('+IntToStr(levelNum*1000+1)+'));'+
                   'ChangePlayerItemCount(Gold, GetVar(gold));'+

                   'If({GetLang() = RU}, 3);'+
                   'AddFloorEvent(����� ������� GetVar(gold) ������!);'+
                   'AddFloorEvent(����� ������� GetVar(lCount) GetVar(lName)!);'+
                   'AddFloorEvent(����� ������� GetVar(iCount) GetVar(iName)!);'+
                   'If({GetLang() = ENG}, 3);'+
                   'AddFloorEvent(Player got GetVar(gold) Gold!);'+
                   'AddFloorEvent(Player got GetVar(lCount) GetVar(lName)!);'+
                   'AddFloorEvent(Player got GetVar(iCount) GetVar(iName)!);'+
                   'AddFloorEvent( );';
               FirstChest := false;
            end;



            /// �����
            if trash = 'StoneBlockage' then
            begin
               found := true;

                elem.size := 'huge';
                elem.count := Random(levelNum*250) + 1000;

                elem.caption := 'RU=�������� �����,ENG=Stone blockage';

                if FirstStoneBlockage and (levelNum = 1) then
                elem.script :=
                    'AllowTool(leggings);'+

                    'If({GetLang() = RU}, 1);'+
                    'AddFloorEvent(!!! ����� ����� ������ !!!);'+
                    'If({GetLang() = ENG}, 1);'+
                    'AddFloorEvent(!!! The player found the leggings !!!);'+
                    'AddFloorEvent( );'
                else

                elem.script :=
                    'SetVar(count, Rand('+IntToStr(levelNum*100+10)+'));'+
                    'SetPlayerRes(Stone, GetVar(count));' +
                    'If({GetLang() = RU}, 2);'+
                    'AddFloorEvent("����� ������� GetVar(count) Stone!");'+
                    'AddFloorEvent("�������-�� ����� ��������...");'+
                    'If({GetLang() = ENG}, 2);'+
                    'AddFloorEvent("Player got GetVar(count) Stone!");'+
                    'AddFloorEvent("Finally, the blockage is dismantled ...");'+
                    'AddFloorEvent( );';
                FirstStoneBlockage := false;
            end;

            /// �����
            if trash = 'WoodBlockage' then
            begin
               found := true;

                elem.size := 'huge';
                elem.count := Random(levelNum*250) + 1000;

                elem.caption := 'RU=���������� �����,ENG=Wood blockage';

                elem.script :=
                    'SetVar(count, Rand('+IntToStr(levelNum*100+10)+'));'+
                    'SetPlayerRes(Wood, GetVar(count));' +
                    'If({GetLang() = RU}, 2);'+
                    'AddFloorEvent("����� ������� GetVar(count) Wood!");'+
                    'AddFloorEvent("�������-�� ����� ��������...");'+
                    'If({GetLang() = ENG}, 2);'+
                    'AddFloorEvent("Player got GetVar(count) Wood!");'+
                    'AddFloorEvent("Finally, the blockage is dismantled ...");'+
                    'AddFloorEvent( );';
                FirstWoodBlockage := false;
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
                   'SetVar(val, Rand(100));'+

                   'IF({GetVar(val) > GetVar(LEGGINGS_LVL)}, 5);'+
                   'ChangePlayerParam('+param+', -1);'+
                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(������� ������� ������! �������� 1 '+param+'!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(The trap hurt! Lost 1 '+param+'!);'+

                   'IF({GetVar(val) <= GetVar(LEGGINGS_LVL)}, 4);'+
                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(������� ��������� �� ������ ��� ������������ ��������!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(The trap was triggered but the effect was blocked by Leggins!);'+

                   'AddFloorEvent( );';
               FirstTrap := false;
            end;

            /// �����
            if trash = 'Rat' then
            begin
               found := true;

               elem.count := 0;

               elem.caption := 'RU=�����,ENG=Rat';

               elem.script :=
                   'SetVar(val, Rand(100));'+

                   'IF({GetVar(val) > GetVar(LEGGINGS_LVL)}, 6);'+
                   'SetVar(dmg, Rand('+IntToStr(levelNum*25+20)+'));'+
                   'ChangePlayerParam(HP, -GetVar(dmg));'+
                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(�� ���� ������ ��������� ����� � ������� ��� �� GetVar(dmg) HP!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(A rat jumped out of a pile of garbage and bit you for GetVar(dmg) HP!);'+

                   'IF({GetVar(val) <= GetVar(LEGGINGS_LVL)}, 4);'+
                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(�� ���� ������ ��������� ����� �� �� ������ ��������� ������!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(A rat jumped out of a pile of garbage but could not bite through the Leggings!);'+

                   'AddFloorEvent( );';
               FirstRat := false;
            end;

            /// ����
            if trash = 'Spider' then
            begin
               found := true;

               elem.count := 0;

               elem.caption := 'RU=����,ENG=Spider';

               elem.script :=
                   'SetVar(val, Rand(100));'+

                   'IF({GetVar(val) > GetVar(LEGGINGS_LVL)}, 5);'+
                   'SetPlayerAutoBuff(HP, -Rand('+IntToStr(levelNum*100)+'));'+
                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(�������� ���� ������ ���!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(The poisonous spider bit you!);'+

                   'IF({GetVar(val) <= GetVar(LEGGINGS_LVL)}, 4);'+
                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(�������� ���� ������� ������� ��� �� ������ ������ �� ���!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(Poisonous spider tried to bite you but Leggings saved you from poison!);'+

                   'AddFloorEvent( );';
               FirstSpider := false;
            end;

            if not found then
            found := found;

            elem.name := trash;

            arrFloors[levelNum].Trash.Add(j, elem);

        end;

        // "������" ������� (������� ������ ��������)
        arrFloors[levelNum].Trash.TrimExcess;

    // ������� ������� �����
        arrFloors[levelNum].Captured := false;

    // ������� ����������� ������
        if levelNum < exitFloor then arrFloors[levelNum].isExit := -1;
        if levelNum > exitFloor then arrFloors[levelNum].isExit := 1;
        if levelNum = exitFloor then arrFloors[levelNum].isExit := 0;

    // ������� ������� ����
        arrFloors[levelNum].Window := false;
    end;
end;

initialization

    Init;

end.
