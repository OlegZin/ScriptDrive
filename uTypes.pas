unit uTypes;

interface

const
    // ������� ��������� � ������� items
    I_GOLD    = 0;
    I_HEAL    = 1;
    I_MANA    = 2;
    I_EXPLO   = 3;
    I_REGHP   = 4;
    I_REGMP   = 5;
    I_AUTOATK = 6;
    I_ATK     = 7;
    I_DEF     = 8;
    I_PATK    = 9;
    I_PDEF    = 10;
    I_EXP     = 11;

type

    TCreature = class
        Name     : string;  // ���������� ���
        Params   : string;
        Items    : string;
        OnAttack : string;
    end;

    TItem = record
        name: string;
        script: string;
    end;
var
    name1 : array [0..9] of string = (
        '��������','��������','����������','��������','������������','��������','������','�����','��������','�����������');
    name2 : array [0..9] of string = (
        '����','��������','������','�����','������','��������','������','����������','������','������');
    name3 : array [0..9] of string = (
        '�����������','���','���� �����','����������','�����','�������','����','�������������','��������','���������');

    // ��������-����������. � �������� ����� ������ ������ ����
    items: array [0..11] of TItem = (
        (name:   'Gold';
         script: 'GetItem(rand, 1)'  ) // ������

       ,(name:   'RestoreHeal';
         script: 'SetVar(IncHP,Rand({GetPlayerAttr(LVL) * 100}));'+
                 'ChangePlayerParam(HP,GetVar(IncHP));'+
                 'AddEvent(Player +GetVar(IncHP) HP)'
        ) // ����� �������

       ,(name:   'RestoreMana';
         script: 'ChangePlayerParam(MP,20);'+
                 'AddEvent(Player +20 MP)'   ) // ����� �������������� ����

       ,(name:   'Explosion';
         script: 'ChangeCreatureParam(HP,-1000)') // ����� ������

       ,(name:   'RegenHP';
         script: 'SetPlayerAuto(HP,1)'    ) // ����� ����������� ��������

       ,(name:   'RegenMP';
         script: 'SetPlayerAuto(MP,1)'    ) // ����� ����������� ����

       ,(name:   'AutoATK';
         script: 'SetPlayerAuto(ATK,1)'   ) // ����� �������������� �����

       ,(name:   'BuffATK';
         script: 'SetPlayerBuff(ATK,100)' ) // ����� ���������� ��������� �����

       ,(name:   'BuffDEF';
         script: 'SetPlayerBuff(ATK,100)' ) // ����� ���������� ��������� ������

       ,(name:   'PermanentATK';
         script: 'ChangePlayerParam(ATK,1)'   ) // ����� ����������� ��������� �����

       ,(name:   'PermanentDEF';
         script: 'ChangePlayerParam(DEF,1)'   ) // ����� ����������� ��������� ������

       ,(name:   'BuffEXP';
         script: 'SetPlayerBuff(EXP,5)'   ) // ����� ���������� �������� �����
    );
implementation

end.
