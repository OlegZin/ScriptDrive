unit uThinkModeData;

interface

function GetActualList(level: variant): string;
/// ����� ������� ������ ������ ������� ��, ������� �������� �� ���������� ������ �
/// ������ �������(���� ����) ��� �������� (exp = 0) � ���� ������

implementation

var

/// n(ame) - ������������ � ���������� � ������������ ���������
/// o(pen) - �������� �� ��� ����������� (�������� �� � ������ � ����������)
/// exp - ��� exp=0 ������� �� ������������ � ���������� � ����������� ������
/// script - ������ ��� ���������� ����������� (��� exp=0)
thinks : array [0..9] of string =(
    'n=WhoIAm,RU=��� �?,ENG=Who am I?,exp=100,script="'+
        'AddThinkEvent()'+
    '"',
    'n=WhereIAm,RU=��� �?,ENG=Where I am?,exp=100,script=""',
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
