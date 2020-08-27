unit uFloors;

interface

uses
    System.Generics.Collections, Math, superobject;

type
    TFloor = record
      Captured: boolean;  // освобожден ли этаж (успешно убита Тень Мастера)
      AltarCost: string;  // набор и количество ресурсов для активации алтаря и вызова Тени
      isExit: integer;    // 0 , -1 подземелье, 1 воздух
      Window: boolean;    // прорублен ли проход в стене
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

    // объекты
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

            // определяем тип объекта
            trash := floorObjects[Random(High(floorObjects))];

            obj := SO('{"name":"","params":{"size":"normal","status":"unknown"},"script":""}');

            /// мусорная куча
            if trash = 'Trash' then
            begin

               found := true;

               obj.I['params.HP'] := Random(levelNum*50) + 50;
               obj.O['name'] := SO('{"RU":"Мусор","ENG":"Garbage"}');

               obj.S['script'] :=
                   'SetVar(obj, GetRandResName());'+
                   'SetVar(count, ' + IntToStr(Random(levelNum*10)+1) +');'+
                   'SetPlayerRes(GetVar(obj), GetVar(count));' +
                   'IF({GetLang() = RU}, 1);'+
                   'AddFloorEvent(Игрок обнаружил GetVar(count) GetVar(obj)!);'+
                   'IF({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(Player found GetVar(count) GetVar(obj)!);'+
                   'AddFloorEvent( );';

               // в разных этажах прячем разные полезные предметы в мусоре
               // первый этаж - лопата для разгребания мусора
               if FirstTrash and (levelNum = 1)
               then
                   obj.S['script'] :=
                     'AllowMode(Tools, 1);' +
                     'AllowTool(Shovel);' +
                     'IF({GetLang() = RU}, 1);'+
                     'AddFloorEvent(!!! Игрок обнаружил Лопату !!!);'+
                     'IF({GetLang() = ENG}, 1);'+
                     'AddFloorEvent(!!! The player discovered the Shovel !!!);'+
                     'AddFloorEvent( );';

               // кирка для разгребания завалов
               if FirstTrash and (levelNum = 2)
               then
                   obj.S['script'] :=
                     'AllowMode(Tools, 1);' +
                     'AllowTool(Pick);' +
                     'IF({GetLang() = RU}, 1);'+
                     'AddFloorEvent(!!! Игрок обнаружил Кирку !!!);'+
                     'IF({GetLang() = ENG}, 1);'+
                     'AddFloorEvent(!!! The player discovered the Pick !!!);'+
                     'AddFloorEvent( );';

               // кирка для разгребания завалов
               if FirstTrash and (levelNum = 3)
               then
                   obj.S['script'] :=
                     'AllowMode(Tools, 1);' +
                     'AllowTool(Axe);' +
                     'IF({GetLang() = RU}, 1);'+
                     'AddFloorEvent(!!! Игрок обнаружил Топор !!!);'+
                     'IF({GetLang() = ENG}, 1);'+
                     'AddFloorEvent(!!! The player discovered the Axe !!!);'+
                     'AddFloorEvent( );';

               // кирка для разгребания завалов
               if FirstTrash and (levelNum = 4)
               then
                   obj.S['script'] :=
                     'AllowMode(Tools, 1);' +
                     'AllowTool(Key);' +
                     'IF({GetLang() = RU}, 1);'+
                     'AddFloorEvent(!!! Игрок обнаружил Отмычку !!!);'+
                     'IF({GetLang() = ENG}, 1);'+
                     'AddFloorEvent(!!! The player discovered the Lock pick !!!);'+
                     'AddFloorEvent( );';


               FirstTrash := false;
            end;

            /// ящик
            if trash = 'Box' then
            begin
               found := true;

               obj.I['params.HP'] := Random(levelNum*60) + 100;
               obj.O['name'] := SO('{"RU":"Ящик","ENG":"Box"}');

               obj.S['script'] :=
                   'SetVar(iName, GetRandItemName());'+
                   'ChangePlayerItemCount(GetVar(iName), 1);'+
                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(Игрок получил GetVar(iName)!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(Player got GetVar(iName)!);'+
                   'AddFloorEvent( );';

               FirstBox := false;
            end;


            /// тайник
            if trash = 'Cache' then
            begin
               found := true;

               obj.I['params.HP'] := Random(levelNum*70) + 150;
               obj.O['name'] := SO('{"RU":"Тайник","ENG":"Сache"}');

               obj.S['script'] :=
                   'SetVar(gold, Rand('+IntToStr(levelNum*10000+1)+'));'+
                   'ChangePlayerItemCount(Gold, GetVar(gold));'+

                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(Игрок получил GetVar(gold) золота!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(Player got GetVar(gold) Gold!);'+
                   'AddFloorEvent( );';


               if FirstChest and (levelNum = 2)
               then
                  obj.S['script'] :=
                     'AllowTool(LifeAmulet);'+

                     'If({GetLang() = RU}, 1);'+
                     'AddFloorEvent(!!! Игрок нашел Амулет Жизни !!!);'+
                     'If({GetLang() = ENG}, 1);'+
                     'AddFloorEvent(!!! The player found the Amulet of Life !!!);'+
                     'AddFloorEvent( );';

               FirstCache := false;
            end;

            /// сундук
            if trash = 'Chest' then
            begin
               found := true;

               obj.I['params.HP'] := Random(levelNum*80) + 200;
               obj.O['name'] := SO('{"RU":"Сундук","ENG":"Chest"}');

               obj.S['script'] :=
                   'SetVar(iName, GetRandItemName());'+
                   'SetVar(iCount, {Rand('+ IntToStr(levelNum) +') + 1});'+
                   'ChangePlayerItemCount(GetVar(iName), GetVar(iCount));'+

                   'SetVar(lName, GetRandResName());'+
                   'SetVar(lCount, ' + IntToStr(Random(levelNum*2)+1) +');'+
                   'SetPlayerRes(GetVar(lName), GetVar(lCount));' +

                   'SetVar(gold, Rand('+IntToStr(levelNum*1000+1)+'));'+
                   'ChangePlayerItemCount(Gold, GetVar(gold));'+

                   'If({GetLang() = RU}, 3);'+
                   'AddFloorEvent(Игрок получил GetVar(gold) золота!);'+
                   'AddFloorEvent(Игрок получил GetVar(lCount) GetVar(lName)!);'+
                   'AddFloorEvent(Игрок получил GetVar(iCount) GetVar(iName)!);'+
                   'If({GetLang() = ENG}, 3);'+
                   'AddFloorEvent(Player got GetVar(gold) Gold!);'+
                   'AddFloorEvent(Player got GetVar(lCount) GetVar(lName)!);'+
                   'AddFloorEvent(Player got GetVar(iCount) GetVar(iName)!);'+
                   'AddFloorEvent( );';


               if FirstChest and (levelNum = 5)
               then
                  obj.S['script'] :=
                     'AllowTool(TimeSand);'+

                     'If({GetLang() = RU}, 1);'+
                     'AddFloorEvent(!!! Игрок нашел Пески Времени !!!);'+
                     'If({GetLang() = ENG}, 1);'+
                     'AddFloorEvent(!!! The player found the Sands of Time !!!);'+
                     'AddFloorEvent( );';

               FirstChest := false;
            end;



            /// завал
            if trash = 'StoneBlockage' then
            begin
               found := true;

               obj.S['params.size'] := 'huge';
               obj.I['params.HP'] := Random(levelNum*250) + 1000;
               obj.O['name'] := SO('{"RU":"Каменный завал","ENG":"Stone blockage"}');

               obj.S['script'] :=
                    'SetVar(count, Rand('+IntToStr(levelNum*100+10)+'));'+
                    'SetPlayerRes(Stone, GetVar(count));' +
                    'If({GetLang() = RU}, 2);'+
                    'AddFloorEvent("Игрок получил GetVar(count) Stone!");'+
                    'AddFloorEvent("Наконец-то завал разобран...");'+
                    'If({GetLang() = ENG}, 2);'+
                    'AddFloorEvent("Player got GetVar(count) Stone!");'+
                    'AddFloorEvent("Finally, the blockage is dismantled ...");'+
                    'AddFloorEvent( );';


               if FirstStoneBlockage and (levelNum = 1) then
                 obj.S['script'] :=
                    'AllowTool(leggings);'+

                    'If({GetLang() = RU}, 1);'+
                    'AddFloorEvent(!!! Игрок нашел Поножи !!!);'+
                    'If({GetLang() = ENG}, 1);'+
                    'AddFloorEvent(!!! The player found the leggings !!!);'+
                    'AddFloorEvent( );';

                FirstStoneBlockage := false;
            end;

            /// завал
            if trash = 'WoodBlockage' then
            begin
               found := true;

               obj.S['params.size'] := 'huge';
               obj.I['params.HP'] := Random(levelNum*250) + 1000;
               obj.O['name'] := SO('{"RU":"Деревянный завал","ENG":"Wood blockage"}');

               obj.S['script'] :=
                    'SetVar(count, Rand('+IntToStr(levelNum*100+10)+'));'+
                    'SetPlayerRes(Wood, GetVar(count));' +
                    'If({GetLang() = RU}, 2);'+
                    'AddFloorEvent("Игрок получил GetVar(count) Wood!");'+
                    'AddFloorEvent("Наконец-то завал разобран...");'+
                    'If({GetLang() = ENG}, 2);'+
                    'AddFloorEvent("Player got GetVar(count) Wood!");'+
                    'AddFloorEvent("Finally, the blockage is dismantled ...");'+
                    'AddFloorEvent( );';
                FirstWoodBlockage := false;
            end;

            /// ловушка
            if trash = 'Trap' then
            begin
               found := true;

               obj.I['params.HP'] := 1;
               obj.O['name'] := SO('{"RU":"Ловушка","ENG":"Trap"}');

               case Random(3) of
                  0: param := 'ATK';
                  1: param := 'DEF';
                  2: param := 'MDEF';
               end;

               obj.S['script'] :=
                   'SetVar(val, Rand(100));'+

                   'IF({GetVar(val) > GetVar(LEGGINGS_LVL)}, 5);'+
                   'ChangePlayerParam('+param+', -1);'+
                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(Ловушка нанесла травму! Потеряно 1 '+param+'!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(The trap hurt! Lost 1 '+param+'!);'+

                   'IF({GetVar(val) <= GetVar(LEGGINGS_LVL)}, 4);'+
                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(Ловушка сработала но эффект был заблокирован Поножами!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(The trap was triggered but the effect was blocked by Leggins!);'+

                   'AddFloorEvent( );';
               FirstTrap := false;
            end;

            /// крыса
            if trash = 'Rat' then
            begin
               found := true;

               obj.I['params.HP'] := 1;
               obj.O['name'] := SO('{"RU":"Крыса","ENG":"Rat"}');

               obj.S['script'] :=
                   'SetVar(val, Rand(100));'+

                   'IF({GetVar(val) > GetVar(LEGGINGS_LVL)}, 6);'+
                   'SetVar(dmg, Rand('+IntToStr(levelNum*25+20)+'));'+
                   'ChangePlayerParam(HP, -GetVar(dmg));'+
                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(Из кучи мусора выскочила крыса и укусила вас на GetVar(dmg) HP!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(A rat jumped out of a pile of garbage and bit you for GetVar(dmg) HP!);'+

                   'IF({GetVar(val) <= GetVar(LEGGINGS_LVL)}, 4);'+
                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(Из кучи мусора выскочила крыса но не смогла прокусить Поножи!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(A rat jumped out of a pile of garbage but could not bite through the Leggings!);'+

                   'AddFloorEvent( );';
               FirstRat := false;
            end;

            /// паук
            if trash = 'Spider' then
            begin
               found := true;

               obj.I['params.HP'] := 1;
               obj.S['name'] := '{"RU":"Паук","ENG":"Spider"}';

               obj.S['script'] :=
                   'SetVar(val, Rand(100));'+

                   'IF({GetVar(val) > GetVar(LEGGINGS_LVL)}, 5);'+
                   'SetPlayerAutoBuff(HP, -Rand('+IntToStr(levelNum*100)+'));'+
                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(Ядовитый паук укусил вас!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(The poisonous spider bit you!);'+

                   'IF({GetVar(val) <= GetVar(LEGGINGS_LVL)}, 4);'+
                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(Ядовитый паук пытался укусить вас но Поножи спасли от яда!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(Poisonous spider tried to bite you but Leggings saved you from poison!);'+

                   'AddFloorEvent( );';
               FirstSpider := false;
            end;

            if not found then
            found := found;

            obj.I['params.key'] := levelNum * 1000 + j;

            // добавляем объект в общий массив.
            // ключ - сочетание текущего этажа и индекса текущего объекта
            Data.AddObject(IntToStr(levelNum * 1000 + j), obj);
        end;


    // признак захвата этажа
        arrFloors[levelNum].Captured := false;

    // признак возможности выхода
        if levelNum < exitFloor then arrFloors[levelNum].isExit := -1;
        if levelNum > exitFloor then arrFloors[levelNum].isExit := 1;
        if levelNum = exitFloor then arrFloors[levelNum].isExit := 0;

    // признак наличия окна
        arrFloors[levelNum].Window := false;
    end;
end;

initialization

//    Init;

end.
