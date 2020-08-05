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
        Loot     : string;
        OnAttack : string;
    end;

    TItem = record
        name: string;
        cost: integer;
        script: string;
    end;
var
    name1 : array [0..9] of string = (
        '��������','��������','����������','��������','������������','��������','������','�����','��������','�����������');
    name2 : array [0..9] of string = (
        '����','��������','������','�����','������','��������','������','����������','������','������');
    name3 : array [0..9] of string = (
        '�����������','���','���� �����','����������','�����','�������','����','�������������','��������','���������');

    loot: array [0..49] of string = (
        ('wood'),('wood'),('wood'),('wood'),('wood'),('wood'),('wood'),('wood'),('wood'),('wood'),            // 10
        ('stone'),('stone'),('stone'),('stone'),('stone'),('stone'),('stone'),('stone'),('stone'),('stone'),  // 10
        ('herbal'),('herbal'),('herbal'),('herbal'),('herbal'),('herbal'),('herbal'),('herbal'),              // 8
        ('wheat'),('wheat'),('wheat'),('wheat'),('wheat'),('wheat'),                                          // 6
        ('meat'),('meat'),('meat'),('meat'),                                                                  // 4
        ('blood'),('blood'),('blood'),                                                                        // 3
        ('bone'),('bone'),('bone'),                                                                           // 3
        ('skin'),('skin'),('skin'),                                                                           // 3
        ('ore'),('ore'),                                                                                      // 2
        ('essence')                                                                                           // 1
    );

    // ��������-����������. � �������� ����� ������ ������ ����
    items: array [0..11] of TItem = (
        (name:   'Gold';
         cost:   MaxInt;
         script: 'If({GetPlayerItemCount(Gold) > 9998}, 4);'+ // 1 ������ ���������� �� �������������
                                                              // ���� ������ ����������, ��������� ��������� 4 ������ �������,
                                                              // ����� ��� ����� ���������
                 'SetVar(iName, GetRandItemName());'+
                 'ChangePlayerItemCount(GetVar(iName), 1);'+
                 'ChangePlayerItemCount(Gold, -9999);'+
                 'AddEvent(Player get GetVar(iName)!);'
        ) // ������

       ,(name:   'RestoreHealth';
         cost:   1000;
         script: 'SetVar(IncHP,Rand({GetPlayerAttr(LVL) * 100}));'+
                 'ChangePlayerParam(HP,GetVar(IncHP));'+
                 'AddEvent(Player restore GetVar(IncHP) HP)'
        ) // ����� �������

       ,(name:   'RestoreMana';
         cost:   1000;
         script: 'SetVar(IncMP,Rand({GetPlayerAttr(LVL) * 20}));'+
                 'ChangePlayerParam(MP,GetVar(IncMP));'+
                 'AddEvent(Player restore GetVar(IncMP) MP)'
         ) // ����� �������������� ����

       ,(name:   'Explosion';
         cost:   10000;
         script: 'ChangeCreatureParam(HP,-1000)') // ����� ������

       ,(name:   'RegenHP';
         cost:   500;
         script: 'SetPlayerAuto(HP,1)'    ) // ����� ����������� ��������

       ,(name:   'RegenMP';
         cost:   500;
         script: 'SetPlayerAuto(MP,1)'    ) // ����� ����������� ����

       ,(name:   'AutoATK';
         cost:   10000;
         script: 'ChangeAutoATK(Rand({GetPlayerAttr(LVL) * 100}))'   ) // ����� �������������� �����

       ,(name:   'BuffATK';
         cost:   5000;
         script: 'SetPlayerBuff(ATK,100)' ) // ����� ���������� ��������� �����

       ,(name:   'BuffDEF';
         cost:   5000;
         script: 'SetPlayerBuff(ATK,100)' ) // ����� ���������� ��������� ������

       ,(name:   'PermanentATK';
         cost:   10000;
         script: 'ChangePlayerParam(ATK,1);'+
                 'AddEvent(Player get +1 ATK permanently!)'
        ) // ����� ����������� ��������� �����

       ,(name:   'PermanentDEF';
         cost:   10000;
         script: 'ChangePlayerParam(DEF,1);'+
                 'AddEvent(Player get +1 DEF permanently!)'
        ) // ����� ����������� ��������� ������

       ,(name:   'BuffEXP';
         cost:   3000;
         script: 'SetPlayerBuff(EXP,5)'   ) // ����� ���������� �������� �����
    );
implementation

end.
