unit uFloors;

interface

uses
    System.Generics.Collections, Math, superobject;

type
    TFloor = record
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

procedure Init;

implementation

uses SysUtils, uTypes, uData;

var
    Events: string;

procedure Init;
var
    levelNum, j, exitFloor, trashCount : integer;
    trash, param: string;

    obj: ISuperObject;

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

//        arrFloors[levelNum].Trash := TDictionary<Integer,TTrash>.Create();

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

            obj := SO('{"name":"","params":{"size":"normal","status":"unknown"},"script":""}');

            /// �������� ����
            if trash = 'Trash' then
            begin

               found := true;

               obj.I['params.HP'] := Random(levelNum*50) + 50;
               obj.O['name'] := SO('{"RU":"�����","ENG":"Garbage"}');

               obj.S['script'] :=
                   'SetVar(obj, GetRandResName());'+
                   'SetVar(count, ' + IntToStr(Random(levelNum*10)+1) +');'+
                   'SetPlayerRes(GetVar(obj), GetVar(count));' +
                   'IF([GetLang() = RU], 1);'+
                   'AddEvent(����� ��������� GetVar(count) GetVar(obj)!);'+
                   'IF([GetLang() = ENG], 1);'+
                   'AddEvent(Player found GetVar(count) GetVar(obj)!);'+
                   'AddEvent( );';

               // � ������ ������ ������ ������ �������� �������� � ������
               // ������ ���� - ������ ��� ����������� ������
               if FirstTrash and (levelNum = 1)
               then
                   obj.S['script'] :=
                     'AllowMode(Tools, 1);' +
                     'AllowTool(Shovel);' +
                     'IF([GetLang() = RU], 1);'+
                     'AddEvent(!!! ����� ��������� ������ !!!);'+
                     'IF([GetLang() = ENG], 1);'+
                     'AddEvent(!!! The player discovered the Shovel !!!);'+
                     'AddEvent( );';

               // ����� ��� ����������� �������
               if FirstTrash and (levelNum = 2)
               then
                   obj.S['script'] :=
                     'AllowMode(Tools, 1);' +
                     'AllowTool(Pick);' +
                     'IF([GetLang() = RU], 1);'+
                     'AddEvent(!!! ����� ��������� ����� !!!);'+
                     'IF([GetLang() = ENG], 1);'+
                     'AddEvent(!!! The player discovered the Pick !!!);'+
                     'AddEvent( );';

               // ����� ��� ����������� �������
               if FirstTrash and (levelNum = 3)
               then
                   obj.S['script'] :=
                     'AllowMode(Tools, 1);' +
                     'AllowTool(Axe);' +
                     'IF([GetLang() = RU]}, 1);'+
                     'AddEvent(!!! ����� ��������� ����� !!!);'+
                     'IF([GetLang() = ENG], 1);'+
                     'AddEvent(!!! The player discovered the Axe !!!);'+
                     'AddEvent( );';

               // ����� ��� ����������� �������
               if FirstTrash and (levelNum = 4)
               then
                   obj.S['script'] :=
                     'AllowMode(Tools, 1);' +
                     'AllowTool(Key);' +
                     'IF([GetLang() = RU], 1);'+
                     'AddEvent(!!! ����� ��������� ������� !!!);'+
                     'IF([GetLang() = ENG], 1);'+
                     'AddEvent(!!! The player discovered the Lock pick !!!);'+
                     'AddEvent( );';

               // �������
               if FirstTrash and (levelNum = 5)
               then
                   obj.S['script'] :=
                     'OpenThink(Diary);'+
                     'IF([GetLang() = RU], 2);'+
                     'AddEvent("������, �� ����������, �������� ���������� ��� ������������...");'+
                     'AddEvent(!!! ����� ��������� ������� !!!);'+
                     'IF([GetLang() = ENG], 2);'+
                     'AddEvent("It looks like it is encrypted, we will have to work on decryption ...");'+
                     'AddEvent(!!! The player discovered the Diary !!!);'+
                     'AddEvent( );';

               FirstTrash := false;
            end;

            /// ����
            if trash = 'Box' then
            begin
               found := true;

               obj.I['params.HP'] := Random(levelNum*60) + 100;
               obj.O['name'] := SO('{"RU":"����","ENG":"Box"}');

               obj.S['script'] :=
                   'SetVar(iName, GetRandItemName());'+
                   'ChangePlayerItemCount(GetVar(iName), 1);'+
                   'If([GetLang() = RU], 1);'+
                   'AddEvent(����� ������� GetVar(iName)!);'+
                   'If([GetLang() = ENG], 1);'+
                   'AddEvent(Player got GetVar(iName)!);'+
                   'AddEvent( );';

               FirstBox := false;
            end;


            /// ������
            if trash = 'Cache' then
            begin
               found := true;

               obj.I['params.HP'] := Random(levelNum*70) + 150;
               obj.O['name'] := SO('{"RU":"������","ENG":"�ache"}');

               obj.S['script'] :=
                   'SetVar(gold, Rand('+IntToStr(levelNum*10000+1)+'));'+
                   'ChangePlayerItemCount(Gold, GetVar(gold));'+

                   'If([GetLang() = RU], 1);'+
                   'AddEvent(����� ������� GetVar(gold) ������!);'+
                   'If([GetLang() = ENG], 1);'+
                   'AddEvent(Player got GetVar(gold) Gold!);'+
                   'AddEvent( );';


               if FirstChest and (levelNum = 2)
               then
                  obj.S['script'] :=
                     'AllowTool(LifeAmulet);'+

                     'If([GetLang() = RU], 1);'+
                     'AddEvent(!!! ����� ����� ������ ����� !!!);'+
                     'If([GetLang() = ENG], 1);'+
                     'AddEvent(!!! The player found the Amulet of Life !!!);'+
                     'AddEvent( );';

               FirstCache := false;
            end;

            /// ������
            if trash = 'Chest' then
            begin
               found := true;

               obj.I['params.HP'] := Random(levelNum*80) + 200;
               obj.O['name'] := SO('{"RU":"������","ENG":"Chest"}');

               obj.S['script'] :=
                   'SetVar(iName, GetRandItemName());'+
                   'SetVar(iCount, [Rand('+ IntToStr(levelNum) +') + 1]);'+
                   'ChangePlayerItemCount(GetVar(iName), GetVar(iCount));'+

                   'SetVar(lName, GetRandResName());'+
                   'SetVar(lCount, ' + IntToStr(Random(levelNum*2)+1) +');'+
                   'SetPlayerRes(GetVar(lName), GetVar(lCount));' +

                   'SetVar(gold, Rand('+IntToStr(levelNum*1000+1)+'));'+
                   'ChangePlayerItemCount(Gold, GetVar(gold));'+

                   'If([GetLang() = RU], 3);'+
                   'AddEvent(����� ������� GetVar(gold) ������!);'+
                   'AddEvent(����� ������� GetVar(lCount) GetVar(lName)!);'+
                   'AddEvent(����� ������� GetVar(iCount) GetVar(iName)!);'+
                   'If([GetLang() = ENG], 3);'+
                   'AddEvent(Player got GetVar(gold) Gold!);'+
                   'AddEvent(Player got GetVar(lCount) GetVar(lName)!);'+
                   'AddEvent(Player got GetVar(iCount) GetVar(iName)!);'+
                   'AddEvent( );';


               if FirstChest and (levelNum = 5)
               then
                  obj.S['script'] :=
                     'AllowTool(TimeSand);'+

                     'If([GetLang() = RU], 1);'+
                     'AddEvent(!!! ����� ����� ����� ������� !!!);'+
                     'If([GetLang() = ENG], 1);'+
                     'AddEvent(!!! The player found the Sands of Time !!!);'+
                     'AddEvent( );';

               FirstChest := false;
            end;



            /// �����
            if trash = 'StoneBlockage' then
            begin
               found := true;

               obj.S['params.size'] := 'huge';
               obj.I['params.HP'] := Random(levelNum*250) + 1000;
               obj.O['name'] := SO('{"RU":"�������� �����","ENG":"Stone blockage"}');

               obj.S['script'] :=
                    'SetVar(count, Rand('+IntToStr(levelNum*100+10)+'));'+
                    'SetPlayerRes(Stone, GetVar(count));' +
                    'If([GetLang() = RU], 2);'+
                    'AddEvent("����� ������� GetVar(count) Stone!");'+
                    'AddEvent("�������-�� ����� ��������...");'+
                    'If([GetLang() = ENG], 2);'+
                    'AddEvent("Player got GetVar(count) Stone!");'+
                    'AddEvent("Finally, the blockage is dismantled ...");'+
                    'AddEvent( );';


               if FirstStoneBlockage and (levelNum = 1) then
                 obj.S['script'] :=
                    'AllowTool(leggings);'+

                    'If([GetLang() = RU], 1);'+
                    'AddEvent(!!! ����� ����� ������ !!!);'+
                    'If([GetLang() = ENG], 1);'+
                    'AddEvent(!!! The player found the leggings !!!);'+
                    'AddEvent( );';

                FirstStoneBlockage := false;
            end;

            /// �����
            if trash = 'WoodBlockage' then
            begin
               found := true;

               obj.S['params.size'] := 'huge';
               obj.I['params.HP'] := Random(levelNum*250) + 1000;
               obj.O['name'] := SO('{"RU":"���������� �����","ENG":"Wood blockage"}');

               obj.S['script'] :=
                    'SetVar(count, Rand('+IntToStr(levelNum*100+10)+'));'+
                    'SetPlayerRes(Wood, GetVar(count));' +
                    'If([GetLang() = RU], 2);'+
                    'AddEvent("����� ������� GetVar(count) Wood!");'+
                    'AddEvent("�������-�� ����� ��������...");'+
                    'If([GetLang() = ENG], 2);'+
                    'AddEvent("Player got GetVar(count) Wood!");'+
                    'AddEvent("Finally, the blockage is dismantled ...");'+
                    'AddEvent( );';
                FirstWoodBlockage := false;
            end;

            /// �������
            if trash = 'Trap' then
            begin
               found := true;

               obj.I['params.HP'] := 1;
               obj.O['name'] := SO('{"RU":"�������","ENG":"Trap"}');

               case Random(3) of
                  0: param := 'ATK';
                  1: param := 'DEF';
                  2: param := 'MDEF';
               end;

               obj.S['script'] :=
                   'SetVar(val, Rand(100));'+

                   'IF([GetVar(val) > GetVar(LEGGINGS_LVL)], 5);'+
                   'ChangePlayerParam('+param+', -1);'+
                   'If([GetLang() = RU], 1);'+
                   'AddEvent(������� ������� ������! �������� 1 '+param+'!);'+
                   'If([GetLang() = ENG], 1);'+
                   'AddEvent(The trap hurt! Lost 1 '+param+'!);'+

                   'IF([GetVar(val) <= GetVar(LEGGINGS_LVL)], 4);'+
                   'If([GetLang() = RU], 1);'+
                   'AddEvent(������� ��������� �� ������ ��� ������������ ��������!);'+
                   'If([GetLang() = ENG], 1);'+
                   'AddEvent(The trap was triggered but the effect was blocked by Leggins!);'+

                   'AddFloorEvent( );';
               FirstTrap := false;
            end;

            /// �����
            if trash = 'Rat' then
            begin
               found := true;

               obj.I['params.HP'] := 1;
               obj.O['name'] := SO('{"RU":"�����","ENG":"Rat"}');

               obj.S['script'] :=
                   'SetVar(val, Rand(100));'+

                   'IF([GetVar(val) > GetVar(LEGGINGS_LVL)], 6);'+
                   'SetVar(dmg, Rand('+IntToStr(levelNum*25+20)+'));'+
                   'ChangePlayerParam(HP, -GetVar(dmg));'+
                   'If([GetLang() = RU], 1);'+
                   'AddEvent(�� ���� ������ ��������� ����� � ������� ��� �� GetVar(dmg) HP!);'+
                   'If([GetLang() = ENG], 1);'+
                   'AddEvent(A rat jumped out of a pile of garbage and bit you for GetVar(dmg) HP!);'+

                   'IF([GetVar(val) <= GetVar(LEGGINGS_LVL)], 4);'+
                   'If([GetLang() = RU], 1);'+
                   'AddEvent(�� ���� ������ ��������� ����� �� �� ������ ��������� ������!);'+
                   'If([GetLang() = ENG], 1);'+
                   'AddEvent(A rat jumped out of a pile of garbage but could not bite through the Leggings!);'+

                   'AddFloorEvent( );';
               FirstRat := false;
            end;

            /// ����
            if trash = 'Spider' then
            begin
               found := true;

               obj.I['params.HP'] := 1;
               obj.S['name'] := '{"RU":"����","ENG":"Spider"}';

               obj.S['script'] :=
                   'SetVar(val, Rand(100));'+

                   'IF([GetVar(val) > GetVar(LEGGINGS_LVL)], 5);'+
                   'SetPlayerAutoBuff(HP, -Rand('+IntToStr(levelNum*100)+'));'+
                   'If([GetLang() = RU], 1);'+
                   'AddEvent(�������� ���� ������ ���!);'+
                   'If([GetLang() = ENG], 1);'+
                   'AddEvent(The poisonous spider bit you!);'+

                   'IF([GetVar(val) <= GetVar(LEGGINGS_LVL)], 4);'+
                   'If([GetLang() = RU], 1);'+
                   'AddEvent(�������� ���� ������� ������� ��� �� ������ ������ �� ���!);'+
                   'If([GetLang() = ENG], 1);'+
                   'AddEvent(Poisonous spider tried to bite you but Leggings saved you from poison!);'+

                   'AddFloorEvent( );';
               FirstSpider := false;
            end;

            if not found then
            found := found;

            obj.I['params.key'] := levelNum * 1000 + j;

            // ��������� ������ � ����� ������.
            // ���� - ��������� �������� ����� � ������� �������� �������
            Data.AddObject(IntToStr(levelNum * 1000 + j), obj);
        end;


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

//    Init;

end.
