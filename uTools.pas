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
    arrTools : array[0..7] of TTool = (
      (name: 'shovel';
       isAllow: false;
       lvl: 1;
       caption: 'RU=������,ENG=Shovel';
       desc: 'RU=��������� ������� ���������� �����,ENG=Allows you to clear trash faster';
       script: 'SetVar('+SHOVEL_LVL+', [GetVar('+SHOVEL_LVL+') + 1]);'),

      (name: 'pick';
       isAllow: false;
       lvl: 1;
       caption: 'RU=�����,ENG=Pick';
       desc: 'RU=��������� ������� ��������� ������,ENG=Allows you to quickly disassemble blockage';
       script: 'SetVar('+PICK_LVL+', [GetVar('+PICK_LVL+') + 1]);'),

      (name: 'axe';
       isAllow: false;
       lvl: 1;
       caption: 'RU=�����,ENG=Axe';
       desc: 'RU=��������� ������� ��������� �����,ENG=Allows you to break boxes faster';
       script: 'SetVar('+AXE_LVL+', [GetVar('+AXE_LVL+') + 1]);'),

      (name: 'key';
       isAllow: false;
       lvl: 1;
       caption: 'RU=�������,ENG="Lock pick"';
       desc: 'RU=��������� ������� ��������� �������,ENG=Allows you to open chests faster';
       script: 'SetVar('+KEY_LVL+', [GetVar('+KEY_LVL+') + 1]);'),

      (name: 'sword';
       isAllow: false;
       lvl: 0;
       caption: 'RU=���,ENG=Sword';
       desc: 'RU=����������� ����������� ���� �� �� ���� ������� ATK,ENG=Increases minimum damage but not higher than the current ATK';
       script: 'SetVar('+SWORD_LVL+', [GetVar('+SWORD_LVL+') + 1]);'),

      (name: 'LifeAmulet';
       isAllow: false;
       lvl: 0;
       caption: 'RU="������ ��������",ENG="Amulet of Health"';
       desc: 'RU=��� ����������� ��������� +100 �������� �� �������,ENG=Adds +100 HP per level upon respawn';
       script: 'SetVar('+LIFEAMULET_LVL+', [GetVar('+LIFEAMULET_LVL+') + 1]);'),

      (name: 'TimeSand';
       isAllow: false;
       lvl: 0;
       caption: 'RU="����� �������",ENG="Sand of Time"';
       desc: 'RU=�������� ������������ �� 2% �� �������,ENG=Speeds up Auto Actions by 2% per level';
       script: 'SetVar('+TIMESAND_LVL+', [GetVar('+TIMESAND_LVL+') + 2]);'),

      (name: 'leggings';
       isAllow: false;
       lvl: 0;
       caption: 'RU=������,ENG=Leggings';
       desc: 'RU=����������� ���� �������� ������� ������� ���� ������ � �.�. �� 2% �� �������,ENG=Increases the chance to avoid the effect of traps rats spiders etc. 2% per level';
       script: 'SetVar('+LEGGINGS_LVL+', [GetVar('+LEGGINGS_LVL+') + 2]);')
    );

implementation

end.
