unit uThinkModeData;

interface

var

thinks: string;

/// n(ame) - внутреннее имя, используется скриптами
/// RU - имя для интерфейса на русском
/// ENG - имя для интерфейса на английском
/// exp - при exp=0 элемент не отображается в интерфейсе и выполняется скрипт
/// script - скрипт при завершении обдумывания (при exp=0)
arrThinks : array [0..9] of string =(
    'n=WhoIAm,RU=Кто я?,ENG=Who am I?,exp=100,script="'+
        'IF({GetLang() = RU}, 10);'+
        'AddThinkEvent();'+
        'IF({GetLang() = ENG)}, 10);'+
        'AddThinkEvent();'+
    '"',
    'n=WhereIAm,RU=Где я?,ENG=Where I am?,exp=100,script="'+
        'IF({GetLang() = RU}, 10);'+
        'AddThinkEvent();'+
        'IF({GetLang() = ENG)}, 10);'+
        'AddThinkEvent();'+
    '"',
    'n=,RU=,ENG=,exp=,script=""',
    'n=,RU=,ENG=,exp=,script=""',
    'n=,RU=,ENG=,exp=,script=""',
    'n=,RU=,ENG=,exp=,script=""',
    'n=,RU=,ENG=,exp=,script=""',
    'n=,RU=,ENG=,exp=,script=""',
    'n=,RU=,ENG=,exp=,script=""',
    'n=,RU=,ENG=,exp=,script=""'
);

implementation

end.
