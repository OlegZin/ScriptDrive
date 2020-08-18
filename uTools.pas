unit uTools;

interface

const
    SHOVEL_LVL = 'SHOVEL_LVL';
    PICK_LVL = 'PICK_LVL';

type
    TTool = record
        name: string;     // ���������� ���
        isAllow: boolean; // ������ �� ���������� ��� ������ � ���������� ������������
        lvl : integer;    // ������� �������
        caption: string;  // ������������� ������������ ��� ����������
        desc: string;     // ������������� �������� ��� ����������
        script: string;   // ������ �� �������
    end;

var
    arrTools : array[0..1] of TTool = (
      (name: 'shovel';
       isAllow: false;
       lvl: 1;
       caption: 'RU=������,ENG=Shovel';
       desc: 'RU="��������� ������� ���������� �����",ENG="Allows you to clear trash faster"';
       script: 'SetVar('+SHOVEL_LVL+', {GetVar('+SHOVEL_LVL+') + 1});'),

      (name: 'pick';
       isAllow: false;
       lvl: 1;
       caption: 'RU=�����,ENG=Pick';
       desc: 'RU="��������� ������� ��������� ������",ENG="Allows you to quickly disassemble rubble"';
       script: 'SetVar('+PICK_LVL+', {GetVar('+PICK_LVL+') + 1});')
    );

implementation

end.
