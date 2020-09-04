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
        name: string;     // ���������� ���
        isAllow: boolean; // ������ �� ���������� ��� ������ � ���������� ������������
        lvl : integer;    // ������� �������
        caption: string;  // ������������� ������������ ��� ����������
        desc: string;     // ������������� �������� ��� ����������
        script: string;   // ������ �� �������
    end;

var
    arrTools : array[0..10] of TTool = (
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
       desc: 'RU=�������� ������������ �� 3% �� �������,ENG=Speeds up Auto Actions by 3% per level';
       script: 'SetVar('+TIMESAND_LVL+', [GetVar('+TIMESAND_LVL+') + 3]);'),

      (name: 'leggings';
       isAllow: false;
       lvl: 0;
       caption: 'RU=������,ENG=Leggings';
       desc: 'RU=����������� ���� �������� ������� ������� ���� ������ � �.�. �� 3% �� �������,ENG=Increases the chance to avoid the effect of traps rats spiders etc. 3% per level';
       script: 'SetVar('+LEGGINGS_LVL+', [GetVar('+LEGGINGS_LVL+') + 3]);'),

      (name: 'wisdom';
       isAllow: false;
       lvl: 1;
       caption: 'RU="����� ��������",ENG="Circle of Wisdom"';
       desc: 'RU=��������� ����� � ��������� ������� �������� ����� ����, ENG=Clarifies thoughts and allows you to find new ideas faster';
       script: 'SetVar('+WISDOM_LVL+', [GetVar('+WISDOM_LVL+') + 1]);'),

      (name: 'resist';
       isAllow: false;
       lvl: 0;
       caption: 'RU="������ �������������",ENG="Ring of resistance"';
       desc: 'RU=����������� �� 2% �� ������� ���� ������������� �������, ��������� ��������� ���������, ENG=Increases by 2% per level the chance to block effects that reduce character parameters';
       script: 'SetVar('+RESIST_LVL+', [GetVar('+RESIST_LVL+') + 2]);'),

      (name: 'exp';
       isAllow: false;
       lvl: 0;
       caption: 'RU="������ �����",ENG="Experience stone"';
       desc: 'RU=�� 1 �� ������� ����������� ���������� ����, ENG=Increases experience gained by 1 per level';
       script: 'SetVar('+EXP_LVL+', [GetVar('+EXP_LVL+') + 2]);')
      );

implementation

end.
