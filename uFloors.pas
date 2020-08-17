unit uFloors;

interface

uses
    System.Generics.Collections, Math;

type
    TTrash = record
       name: string;     /// внутреннее имя
       caption: string;  /// что будет показано до момента окончания Count
       count : integer;  /// количество тапов до срабатывания script
       script: string;   /// эффект объекта в момент исследования
       size: string;     /// условный размер объекта в режиме этажей. исходя из этого
       /// создается кнопка большего или меньшего размера
    end;


    TFloor = record
      Trash: TDictionary<integer,TTrash>;      // количество и типы оставшихся объектов для режима Этаж
      Captured: boolean;  // освобожден ли этаж (успешно убита Тень Мастера)
      AltarCost: string;  // набор и количество ресурсов для активации алтаря и вызова Тени
      isExit: integer;    // 0 , -1 подземелье, 1 воздух
      Window: boolean;    // прорублен ли проход в стене
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

    // объекты
        trashCount := Max(Random(i*10), 50);

        for j := 0 to trashCount-1 do
        begin

            found := false;
            // определяем тип объекта
            trash := floorObjects[Random(High(floorObjects))];


            if (j = 0) and (i = 1) then trash := 'Trash';
            if (j = 0) and (i = 3) then trash := 'Trash';

            elem.size := 'normal';


            /// мусорная куча
            if trash = 'Trash' then
            begin

               found := true;

               elem.count := Random(i*50) + 50;

               elem.caption := 'RU=Мусор,ENG=Garbage';

               // в разных этажах прячем разные полезные предметы в мусоре
               // первый этаж - лопата для разгребания мусора
               if (j = 0) and (i = 1) then
               begin
               elem.script :=
                   'AllowMode(Tools, 1);' +
                   'AllowTool(Shovel);' +
                   'IF({GetLang() = RU}, 2);'+
                   'AddFloorEvent(Открыт доступ к режиму Инструмены!);'+
                   'AddFloorEvent(Игрок обнаружил Лопату!);'+
                   'IF({GetLang() = ENG}, 2);'+
                   'AddFloorEvent(Access to the Tools mode is open!);'+
                   'AddFloorEvent(The player discovered the Shovel!);'+
                    'AddFloorEvent( );'
               end
               else

               // кирка для разгребания завалов
               if (j = 0) and (i = 3) then
               begin
               elem.script :=
                   'AllowMode(Tools, 1);' +
                   'AllowTool(Pick);' +
                   'IF({GetLang() = RU}, 2);'+
                   'AddFloorEvent(Открыт доступ к режиму Инструмены!);'+
                   'AddFloorEvent(Игрок обнаружил Кирку!);'+
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
                   'AddFloorEvent(Игрок обнаружил GetVar(count) GetVar(obj)!);'+
                   'IF({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(Player found GetVar(count) GetVar(obj)!);'+
                    'AddFloorEvent( );'
            end;

            /// малый сундук
            if trash = 'SmallChest' then
            begin
               found := true;

               elem.count := Random(i*50) + 100;

               elem.caption := 'RU=Ларец,ENG=Box';

               elem.script :=
                   'SetVar(iName, GetRandItemName());'+
                   'ChangePlayerItemCount(GetVar(iName), 1);'+
                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(Игрок получил GetVar(iName)!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(Player got GetVar(iName)!);'+
                    'AddFloorEvent( );'
            end;


            /// большой сундук
            if trash = 'BigChest' then
            begin
               found := true;

               elem.count := Random(i*50) + 150;

               elem.caption := 'RU=Сундук,ENG=Chest';

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
                   'AddFloorEvent(Игрок получил GetVar(gold) золота!);'+
                   'AddFloorEvent(Игрок получил GetVar(lCount) GetVar(lName)!);'+
                   'AddFloorEvent(Игрок получил GetVar(iCount) GetVar(iName)!);'+
                   'If({GetLang() = ENG}, 3);'+
                   'AddFloorEvent(Player got GetVar(gold) Gold!);'+
                   'AddFloorEvent(Player got GetVar(lCount) GetVar(lName)!);'+
                   'AddFloorEvent(Player got GetVar(iCount) GetVar(iName)!);'+
                   'AddFloorEvent( );'
            end;

            /// тайник
            if trash = 'Cache' then
            begin
               found := true;

               elem.count := Random(i*50) + 200;

               elem.caption := 'RU=Тайник,ENG=Сache';

               elem.script :=
                   'SetVar(gold, Rand('+IntToStr(i*10000+1)+'));'+
                   'ChangePlayerItemCount(Gold, GetVar(gold));'+

                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(Игрок получил GetVar(gold) золота!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(Player got GetVar(gold) Gold!);'+
                   'AddFloorEvent( );'
            end;

            /// крыса
            if trash = 'Rat' then
            begin
               found := true;

               elem.count := 0;

               elem.caption := 'RU=Крыса,ENG=Rat';

               elem.script :=
                   'SetVar(dmg, Rand('+IntToStr(i*50+50)+'));'+
                   'ChangePlayerParam(HP, -GetVar(dmg));'+

                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(Из кучи мусора выскочила крыса и укусила вас на GetVar(dmg) HP!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(A rat jumped out of a pile of garbage and bit you for GetVar(dmg) HP!);'+
                   'AddFloorEvent( );'
            end;

            /// завал
            if trash = 'StoneBlockage' then
            begin
               found := true;

                elem.size := 'huge';
                elem.count := Random(i*100) + 1000;

                elem.caption := 'RU="Каменный завал",ENG="Stone blockage"';

                elem.script :=
                    'SetVar(count, Rand('+IntToStr(i*100+10)+'));'+
                    'SetPlayerRes(Stone, GetVar(count));' +
                    'If({GetLang() = RU}, 2);'+
                    'AddFloorEvent("Игрок получил GetVar(count) Stone!");'+
                    'AddFloorEvent("Наконец-то завал разобран...");'+
                    'If({GetLang() = ENG}, 2);'+
                    'AddFloorEvent("Player got GetVar(count) Stone!");'+
                    'AddFloorEvent("Finally, the blockage is dismantled ...");'+
                    'AddFloorEvent( );'
            end;

            /// завал
            if trash = 'WoodBlockage' then
            begin
               found := true;

                elem.size := 'huge';
                elem.count := Random(i*100) + 1000;

                elem.caption := 'RU="Деревянный завал",ENG="Wood blockage"';

                elem.script :=
                    'SetVar(count, Rand('+IntToStr(i*100+10)+'));'+
                    'SetPlayerRes(Wood, GetVar(count));' +
                    'If({GetLang() = RU}, 2);'+
                    'AddFloorEvent("Игрок получил GetVar(count) Wood!");'+
                    'AddFloorEvent("Наконец-то завал разобран...");'+
                    'If({GetLang() = ENG}, 2);'+
                    'AddFloorEvent("Player got GetVar(count) Wood!");'+
                    'AddFloorEvent("Finally, the blockage is dismantled ...");'+
                    'AddFloorEvent( );'
            end;

            /// ловушка
            if trash = 'Trap' then
            begin
               found := true;

               elem.count := 0;

               elem.caption := 'RU=Ловушка,ENG=Trap';

               case Random(3) of
                  0: param := 'ATK';
                  1: param := 'DEF';
                  2: param := 'MDEF';
               end;

               elem.script :=
                   'ChangePlayerParam('+param+', -1);'+

                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(Ловушка нанесла травму! Потеряно 1 '+param+'!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(The trap hurt! Lost 1 '+param+'!);'+
                   'AddFloorEvent( );'
            end;

            /// паук
            if trash = 'Spider' then
            begin
               found := true;

               elem.count := 0;

               elem.caption := 'RU=Паук,ENG=Spider';

               elem.script :=
                   'SetPlayerAutoBuff(HP, -Rand('+IntToStr(i*100)+'));'+

                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(Ядовитый паук укусил вас!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(The poisonous spider bit you!);'+
                   'AddFloorEvent( );'
            end;

            if not found then
            found := found;

            elem.name := trash;

            arrFloors[i].Trash.Add(j, elem);

        end;

        // "пакуем" словарь (убираем пустые элементы)
        arrFloors[i].Trash.TrimExcess;

    // признак захвата этажа
        arrFloors[i].Captured := false;

    // признак возможности выхода
        if i < exitFloor then arrFloors[i].isExit := -1;
        if i > exitFloor then arrFloors[i].isExit := 1;
        if i = exitFloor then arrFloors[i].isExit := 0;

    // признак наличия окна
        arrFloors[i].Window := false;
    end;
end;

initialization

    Init;

end.
