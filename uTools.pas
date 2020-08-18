unit uTools;

interface

const
    SHOVEL_LVL = 'SHOVEL_LVL';
    PICK_LVL = 'PICK_LVL';
    AXE_LVL = 'AXE_LVL';
    KEY_LVL = 'KEY_LVL';

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
    arrTools : array[0..3] of TTool = (
      (name: 'shovel';
       isAllow: false;
       lvl: 1;
       caption: 'RU=������,ENG=Shovel';
       desc: 'RU=��������� ������� ���������� �����,ENG=Allows you to clear trash faster';
       script: 'SetVar('+SHOVEL_LVL+', {GetVar('+SHOVEL_LVL+') + 1});'),

      (name: 'pick';
       isAllow: false;
       lvl: 1;
       caption: 'RU=�����,ENG=Pick';
       desc: 'RU=��������� ������� ��������� ������,ENG=Allows you to quickly disassemble blockage';
       script: 'SetVar('+PICK_LVL+', {GetVar('+PICK_LVL+') + 1});'),

      (name: 'axe';
       isAllow: false;
       lvl: 1;
       caption: 'RU=�����,ENG=Axe';
       desc: 'RU=��������� ������� ��������� �����,ENG=Allows you to break boxes faster';
       script: 'SetVar('+AXE_LVL+', {GetVar('+AXE_LVL+') + 1});'),

      (name: 'key';
       isAllow: false;
       lvl: 1;
       caption: 'RU=�������,ENG="Lock pick"';
       desc: 'RU=��������� ������� ��������� �������,ENG=Allows you to open chests faster';
       script: 'SetVar('+KEY_LVL+', {GetVar('+KEY_LVL+') + 1});')
    );

implementation

end.
