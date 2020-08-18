unit uTools;

interface

const
    SHOVEL_LVL = 'SHOVEL_LVL';
    PICK_LVL = 'PICK_LVL';
    AXE_LVL = 'AXE_LVL';
    KEY_LVL = 'KEY_LVL';

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
    arrTools : array[0..3] of TTool = (
      (name: 'shovel';
       isAllow: false;
       lvl: 1;
       caption: 'RU=Лопата,ENG=Shovel';
       desc: 'RU=Позволяет быстрее разгребать мусор,ENG=Allows you to clear trash faster';
       script: 'SetVar('+SHOVEL_LVL+', {GetVar('+SHOVEL_LVL+') + 1});'),

      (name: 'pick';
       isAllow: false;
       lvl: 1;
       caption: 'RU=Кирка,ENG=Pick';
       desc: 'RU=Позволяет быстрее разбирать завалы,ENG=Allows you to quickly disassemble blockage';
       script: 'SetVar('+PICK_LVL+', {GetVar('+PICK_LVL+') + 1});'),

      (name: 'axe';
       isAllow: false;
       lvl: 1;
       caption: 'RU=Топор,ENG=Axe';
       desc: 'RU=Позволяет быстрее разбивать ящики,ENG=Allows you to break boxes faster';
       script: 'SetVar('+AXE_LVL+', {GetVar('+AXE_LVL+') + 1});'),

      (name: 'key';
       isAllow: false;
       lvl: 1;
       caption: 'RU=Отмычка,ENG="Lock pick"';
       desc: 'RU=Позволяет быстрее открывать сундуки,ENG=Allows you to open chests faster';
       script: 'SetVar('+KEY_LVL+', {GetVar('+KEY_LVL+') + 1});')
    );

implementation

end.
