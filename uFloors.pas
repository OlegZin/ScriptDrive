unit uFloors;

interface

uses
    System.Generics.Collections;

type
    TTrash = record
       caption: string;  /// что будет показано до момента окончания Count
       count : integer;  /// количество тапов до срабатывания script
       script: string;   /// эффект объекта в момент исследования
    end;


    TFloor = record
      Trash: TDictionary<integer,TTrash>;      // количество и типы оставшихся объектов для режима Этаж
      Captured: boolean;  // освобожден ли этаж (успешно убита Тень Мастера)
      AltarCost: string;  // набор и количество ресурсов для активации алтаря и вызова Тени
      isExit: integer;    // 0 , -1 подземелье, 1 воздух
      Window: boolean;    // прорублен ли проход в стене
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

    // объекты
        trashCount := Random(i*2)+5;

        for j := 0 to trashCount-1 do
        begin

            // определяем тип объекта
            trash := floorObjects[Random(High(floorObjects))];

            /// мусорная куча
            if trash = 'Trash' then
            begin
               elem.count := Random(i*50) + 50;

               elem.caption := 'RU=Мусор ENG=Garbage';

               elem.script :=
                   'SetVar(obj, '+loot[Random(Length(loot))]+');'+
                   'SetVar(count, ' + IntToStr(Random(i)+1) +');'+
                   'SetPlayerRes(GetVar(obj), GetVar(count));' +
                   'IF({GetLang() = RU}, 1);'+
                   'AddFloorEvent(Игрок обнаружил GetVar(count) GetVar(obj)!);'+
                   'IF({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(Player found GetVar(count) GetVar(obj)!);'
            end;

            /// малый сундук
            if trash = 'SmallChest' then
            begin
               elem.count := Random(i*50) + 100;

               elem.caption := 'RU=Ларец ENG=Box';

               elem.script :=
                   'SetVar(iName, GetRandItemName());'+
                   'ChangePlayerItemCount(GetVar(iName), 1);'+
                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(Игрок получил GetVar(iName)!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(Player got GetVar(iName)!);'
            end;


            /// большой сундук
            if trash = 'BidChest' then
            begin
               elem.count := Random(i*50) + 150;

               elem.caption := 'RU=Сундук ENG=Chest';

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
               elem.count := Random(i*50) + 200;

               elem.caption := 'RU=Тайник ENG=Сache';

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
               elem.count := 0;

               elem.caption := 'RU=Крыса ENG=Rat';

               elem.script :=
                   'SetVar(dmg, Rand('+IntToStr(i*50+50)+'));'+
                   'ChangePlayerParam(HP, -GetVar(dmg));'+

                   'If({GetLang() = RU}, 1);'+
                   'AddFloorEvent(Из кучи мусора выскочила крыса и укусила вас на GetVar(dmg) HP!);'+
                   'If({GetLang() = ENG}, 1);'+
                   'AddFloorEvent(A rat jumped out of a pile of garbage and bit you for GetVar(dmg) HP!);'+
                   'AddFloorEvent( );'
            end;

            arrFloors[i].Trash.Add(j, elem);

        end;

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
