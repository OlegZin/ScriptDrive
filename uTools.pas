unit uTools;

interface

const
    SHOVEL_LVL     = 'SHOVEL_LVL';
    PICK_LVL       = 'PICK_LVL';
    AXE_LVL        = 'AXE_LVL';
    KEY_LVL        = 'KEY_LVL';
    SWORD_LVL      = 'SWORD_LVL';
    LIFEAMULET_LVL = 'LIFEAMULET_LVL';
    TIMESAND_LVL   = 'TIMESAND_LVL';
    LEGGINGS_LVL   = 'LEGGINGS_LVL';
    WISDOM_LVL     = 'WISDOM_LVL';
    RESIST_LVL     = 'RESIST_LVL';
    EXP_LVL        = 'EXP_LVL';

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
    arrTools : array[0..10] of TTool = (
      (name: 'shovel';
       isAllow: false;
       lvl: 1;
       caption: 'RU=Лопата,ENG=Shovel';
       desc: 'RU=Позволяет быстрее разгребать мусор,ENG=Allows you to clear trash faster';
       script: 'SetVar('+SHOVEL_LVL+', [GetVar('+SHOVEL_LVL+') + 1]);'),

      (name: 'pick';
       isAllow: false;
       lvl: 1;
       caption: 'RU=Кирка,ENG=Pick';
       desc: 'RU=Позволяет быстрее разбирать завалы,ENG=Allows you to quickly disassemble blockage';
       script: 'SetVar('+PICK_LVL+', [GetVar('+PICK_LVL+') + 1]);'),

      (name: 'axe';
       isAllow: false;
       lvl: 1;
       caption: 'RU=Топор,ENG=Axe';
       desc: 'RU=Позволяет быстрее разбивать ящики,ENG=Allows you to break boxes faster';
       script: 'SetVar('+AXE_LVL+', [GetVar('+AXE_LVL+') + 1]);'),

      (name: 'key';
       isAllow: false;
       lvl: 1;
       caption: 'RU=Отмычка,ENG="Lock pick"';
       desc: 'RU=Позволяет быстрее открывать сундуки,ENG=Allows you to open chests faster';
       script: 'SetVar('+KEY_LVL+', [GetVar('+KEY_LVL+') + 1]);'),

      (name: 'sword';
       isAllow: false;
       lvl: 0;
       caption: 'RU=Меч,ENG=Sword';
       desc: 'RU=Увеличивает минимальный урон но не выше текущей ATK,ENG=Increases minimum damage but not higher than the current ATK';
       script: 'SetVar('+SWORD_LVL+', [GetVar('+SWORD_LVL+') + 1]);'),

      (name: 'LifeAmulet';
       isAllow: false;
       lvl: 0;
       caption: 'RU="Амулет Здоровья",ENG="Amulet of Health"';
       desc: 'RU=При возрождении добавляет +100 здоровья за уровень,ENG=Adds +100 HP per level upon respawn';
       script: 'SetVar('+LIFEAMULET_LVL+', [GetVar('+LIFEAMULET_LVL+') + 1]);'),

      (name: 'TimeSand';
       isAllow: false;
       lvl: 0;
       caption: 'RU="Пески Времени",ENG="Sand of Time"';
       desc: 'RU=Ускоряет Автодействия на 3% за уровень,ENG=Speeds up Auto Actions by 3% per level';
       script: 'SetVar('+TIMESAND_LVL+', [GetVar('+TIMESAND_LVL+') + 3]);'),

      (name: 'leggings';
       isAllow: false;
       lvl: 0;
       caption: 'RU=Поножи,ENG=Leggings';
       desc: 'RU=Увеличивает шанс избежать эффекта ловушек крыс пауков и т.д. на 3% за уровень,ENG=Increases the chance to avoid the effect of traps rats spiders etc. 3% per level';
       script: 'SetVar('+LEGGINGS_LVL+', [GetVar('+LEGGINGS_LVL+') + 3]);'),

      (name: 'wisdom';
       isAllow: false;
       lvl: 1;
       caption: 'RU="Обруч Мудрости",ENG="Circle of Wisdom"';
       desc: 'RU=Проясняет мысли и позволяет быстрее находить новые идеи, ENG=Clarifies thoughts and allows you to find new ideas faster';
       script: 'SetVar('+WISDOM_LVL+', [GetVar('+WISDOM_LVL+') + 1]);'),

      (name: 'resist';
       isAllow: false;
       lvl: 0;
       caption: 'RU="Кольцо сопротивления",ENG="Ring of resistance"';
       desc: 'RU=Увеличивает на 2% за уровень шанс заблокировать эффекты, снижающие параметры персонажа, ENG=Increases by 2% per level the chance to block effects that reduce character parameters';
       script: 'SetVar('+RESIST_LVL+', [GetVar('+RESIST_LVL+') + 2]);'),

      (name: 'exp';
       isAllow: false;
       lvl: 0;
       caption: 'RU="Камень опыта",ENG="Experience stone"';
       desc: 'RU=На 1 за уровень увеличивает получаемый опыт, ENG=Increases experience gained by 1 per level';
       script: 'SetVar('+EXP_LVL+', [GetVar('+EXP_LVL+') + 2]);')
      );

implementation

end.
