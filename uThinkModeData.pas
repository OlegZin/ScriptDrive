unit uThinkModeData;

interface

var

thinks: string;

/// n(ame) - ���������� ���, ������������ ���������
/// RU - ��� ��� ���������� �� �������
/// ENG - ��� ��� ���������� �� ����������
/// exp - ��� exp=0 ������� �� ������������ � ���������� � ����������� ������
/// script - ������ ��� ���������� ����������� (��� exp=0)
arrThinks : array [0..9] of string =(
    'n=WhoIAm,RU=��� �?,ENG=Who am I?,exp=100,script="'+
        'IF({GetLang() = RU}, 10);'+
        'AddThinkEvent();'+
        'IF({GetLang() = ENG)}, 10);'+
        'AddThinkEvent();'+
    '"',
    'n=WhereIAm,RU=��� �?,ENG=Where I am?,exp=100,script="'+
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
