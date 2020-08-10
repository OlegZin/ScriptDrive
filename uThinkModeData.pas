unit uThinkModeData;

interface

function GetActualList(level: variant): string;
/// метод шерстит дерево мыслей выдавая те, которые доступны по указанному уровню и
/// предки которых(если есть) уже обдуманы (exp = 0) в виде строки

implementation

var

/// n(ame) - отображается в интерфейсе и используется скриптами
/// o(pen) - доступно ли для обдумывания (попадает ли в список в интерфейсе)
/// exp - при exp=0 элемент не отображается в интерфейсе и выполняется скрипт
/// script - скрипт при завершении обдумывания (при exp=0)
thinks : array [0..9] of string =(
    'n=WhoIAm,RU=Кто я?,ENG=Who am I?,exp=100,script="'+
        'AddThinkEvent()'+
    '"',
    'n=WhereIAm,RU=Где я?,ENG=Where I am?,exp=100,script=""',
    'n=,RU=,ENG=,exp=,script=""',
    'n=,RU=,ENG=,exp=,script=""',
    'n=,RU=,ENG=,exp=,script=""',
    'n=,RU=,ENG=,exp=,script=""',
    'n=,RU=,ENG=,exp=,script=""',
    'n=,RU=,ENG=,exp=,script=""',
    'n=,RU=,ENG=,exp=,script=""',
    'n=,RU=,ENG=,exp=,script=""'
);


function GetActualList(level: variant): string;
begin

end;

end.
