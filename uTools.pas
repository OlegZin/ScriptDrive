unit uTools;

interface

const
    SHOVEL_LVL = 'SHOVEL_LVL';
    PICK_LVL = 'PICK_LVL';

type
    TTool = record
        name: string;     // внутреннее имя
        isAllow: boolean; // открыт ли инструмент для показа в интерфейсе инструментов
        lvl : integer;    // текущий уровень
        caption: string;  // мультиязфчное наименование для интерфейса
        desc: string;     // мультиязычное описание для интерфейса
        script: string;   // скрипт на левелап
    end;

var
    arrTools : array[0..1] of TTool = (
      (name: 'shovel';
       isAllow: false;
       lvl: 1;
       caption: 'RU=Лопата,ENG=Shovel';
       desc: 'RU="Позволяет быстрее разгребать мусор",ENG="Allows you to clear trash faster"';
       script: 'SetVar('+SHOVEL_LVL+', {GetVar('+SHOVEL_LVL+') + 1});'),

      (name: 'pick';
       isAllow: false;
       lvl: 1;
       caption: 'RU=Кирка,ENG=Pick';
       desc: 'RU="Позволяет быстрее разбирать завалы",ENG="Allows you to quickly disassemble rubble"';
       script: 'SetVar('+PICK_LVL+', {GetVar('+PICK_LVL+') + 1});')
    );

implementation

end.
