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

const
    objShablon =
        '{"autobuffs":{},"params":{},"items":{},"events":{},"loot":{},"skills":{},"buffs":{}}';

type

    TCreature = class
        Name                // ���������� ���
       ,Params              // ������� ���������: �������, ��������, ����, ����� � �.�.
       ,Buffs               // ����� � ���� ������ ���_����=����������_�������������
       ,AutoBuffs           // ��������� � ���� ������ ���_����=����������_�������������
       ,Items               // ��������� �������� ��� �������������
       ,Loot                // ��������� ��������� ��� ������
       ,Skills              // ������������ �� ���� �����/����������

       ,Events              // ������� �� ��������� ������� � ���� (������, ���������� � �.�.)
                 : string;
    end;

    TItem = record
        name: string;
        cost: integer;  // ��������� � ���� ��� �������� ��������� � ��������
        craft: string; // ����� �������� ��� ������
        isCraftAllow: boolean; // ������� ����������� ��� ������
        isUseAllow: boolean; // ������� ����������� ��� �������������
        script: string;
    end;

    TRes = record
        name: string;     // ������������� ��� �������
        rarity: integer;  // �������� �������. ��� ������, ��� ����. ������������
                          // � ��������� ����������� ���������� �������,
                          // � ��� �� ��� ����������� ��������
        cost: integer;    // �������� �������� ������� ������ �� ��� rarity.
                          // = ����� rarity ���� �������� �������� �� rarity ����������� �������
    end;

var
    name1 : array [0..39,0..1] of string = (
        ('Stoned',      '��������'),          ('Strong',     '�������'),
        ('Brave',       '��������'),          ('Northern',   '��������'),
        ('Doomed',      '����������'),        ('Local',      '�������'),
        ('Insidious',   '��������'),          ('Great',      '������������'),
        ('Deadly',      '������������'),      ('Accurate',   '������'),
        ('Hungry',      '��������'),          ('Heavy',      '�������'),
        ('Sleepy',      '������'),            ('Holy',       '������'),
        ('Bold',        '�����'),             ('Gas',        '�������'),
        ('Beautiful',   '��������'),          ('Similar',    '�����������'),
        ('Ugly',        '�����������'),       ('Glassy',     '����������'),

        ('Warm',        '������'),            ('Modern',     '�����������'),
        ('Narrow',      '�����'),             ('Unpleasant', '����������'),
        ('Dead',        '�������'),           ('Finite',     '��������'),
        ('Main',        '��������'),          ('Possible',   '���������'),
        ('Evening',     '��������'),          ('Physical',   '������������'),
        ('Previous',    '����������'),        ('Cold',       '��������'),
        ('Convenient',  '�������'),           ('Efficient',  '�����������'),
        ('Genuine',     '��������'),          ('Good',       '�������'),
        ('Monstrous',   '����������'),        ('Green',      '�������'),
        ('Any',         '�����'),             ('Prominent',  '������')
        );

    name2 : array [0..39,0..1] of string = (
        ('Freak',       '����'),              ('Major',      '�����'),
        ('Seeker',      '��������'),          ('Dweller',    '������'),
        ('Crusher',     '������'),            ('Wall',       '������'),
        ('Mattress',    '�����'),             ('Minister',   '�������'),
        ('Greedy',      '������'),            ('Regiment',   '����'),
        ('Drinker',     '��������'),          ('Result',     '���������'),
        ('Peptide',     '������'),            ('Soldier',    '������'),
        ('Cutter',      '����������'),        ('Air',        '������'),
        ('Kawaii',      '������'),            ('Bird',       '����'),
        ('Winner',      '������'),            ('Follower',   '�������������'),

        ('Tail',        '�����'),             ('Gift',       '�������'),
        ('Bag',         '�������'),           ('System',     '�����������'),
        ('Tank',        '����'),              ('Crisis',     '������'),
        ('Mass',        '������'),            ('Dream',      '�����������'),
        ('Future',      '�������'),           ('Fate',       '��������'),
        ('Suit',        '������'),            ('Doom',       '�����������'),
        ('Word',        '�����'),             ('Power',      '����������'),
        ('Relative',    '�����������'),       ('Machine',    '�������'),
        ('Brain',       '����'),              ('Horror',     '����'),
        ('Smoke',       '���'),               ('Steel',      '������')
        );

    name3 : array [0..39,0..1] of string = (
        ('of Hospital', '�����������'),       ('of Betrayal',         '�������������'),
        ('of Hell',     '���'),               ('of Bliss',            '����������'),
        ('of Worlds',   '���� �����'),        ('of Misunderstanding', '�������������'),
        ('of Dungeons', '����������'),        ('of Infinity',         '�������������'),
        ('of Forest',   '�����'),             ('of Wealth',           '���������'),
        ('of Madness',  '�������'),           ('of Poverty',          '������'),
        ('of Mistery',  '����'),              ('of Holiday',          '���������'),
        ('of Hopeless', '�������������'),     ('of Despondency',      '������'),
        ('of Heroism',  '��������'),          ('of Luck',             '�����'),
        ('of Deceit',   '���������'),         ('of Replay',           '�������'),

        ('of Agreement',  '��������'),        ('of Weapon',    '������'),
        ('of Crisis',     '�������'),         ('of Spring',    '�����'),
        ('of Heart',      '������'),          ('of Body',      '����'),
        ('of Girlfriend', '�������'),         ('of Childhood', '�������'),
        ('of Conscious',  '��������'),        ('of Memory',    '������������'),
        ('of Support',    '���������'),       ('of Stars',     '������'),
        ('of Essence',    '����'),            ('of Scene',     '�����'),
        ('of Doubt',      '��������'),        ('of Risk',      '�����'),
        ('of Reality',    '����������'),      ('of Guard',     '������'),
        ('of Murders',    '��������'),        ('of Path',      '����')
    );

    arrRes: array [0..9] of TRes = (
        (name:'{"RU":"������","ENG":"Wood"}';      rarity: 10;  cost:  5),
        (name:'{"RU":"������","ENG":"Stone"}';     rarity: 10;  cost:  5),
        (name:'{"RU":"�����","ENG":"Herbal"}';     rarity:  8;  cost:  6),
        (name:'{"RU":"�����","ENG":"Wheat"}';      rarity:  6;  cost:  8),
        (name:'{"RU":"����","ENG":"Meat"}';        rarity:  4;  cost: 13),
        (name:'{"RU":"�����","ENG":"Blood"}';      rarity:  3;  cost: 17),
        (name:'{"RU":"�����","ENG":"Bone"}';       rarity:  3;  cost: 17),
        (name:'{"RU":"�����","ENG":"Skin"}';       rarity:  3;  cost: 17),
        (name:'{"RU":"����","ENG":"Ore"}';         rarity:  2;  cost: 25),
        (name:'{"RU":"��������","ENG":"Essence"}'; rarity:  1;  cost: 50)
    );
    resSummRarity: integer;

    // ��������-����������. � �������� ����� ������ ������ ����
    items: array [0..14] of TItem = (
        (name:   'Gold';
         cost:    0;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script:
                 'SetTarget(Player);' +
                 'If([GetItemCount(Gold) < 10000], 5);'+       // ���� ������ �� ����������
                 'If([GetLang() = RU], 1);'+                   // ���� ������ �� ����������
                 'AddEvent(� ������ �� ���������� ������! ��������� 10 000 ������);'+ // �������� �
                 'If([GetLang() = ENG], 1);'+                  // ���� ������ �� ����������
                 'AddEvent(Player do not have enougth Gold! Cost 10 000 Gold);'+ // �������� �
                 'ChangeItemCount(Gold, 1);'+                  // ������������ ������ 1 ������ �� ��������� �������������

                 'If([GetItemCount(Gold) > 9999], 7);'+         // ���� ������ ����������
                 'SetVar(iName, GetRandItemName());'+           // �������� ��� ���������� ��������
                 'ChangeItemCount(GetVar(iName), 1);'+          // ��������� ������� � ���������
                 'ChangeItemCount(Gold, -9999);'+               // ��������� ������ � ������ ����, ��� 1 �������� �� ������������� ������ ��� ��������
                 'If([GetLang() = RU], 1);'+                    // ���� ������ �� ����������
                 'AddEvent(����� ������� GetVar(iName)!);'+     // ������ ������ �������������
                 'If([GetLang() = ENG], 1);'+                   // ���� ������ �� ����������
                 'AddEvent(Player get GetVar(iName)!);'         // ������ ������ �������������
        ) // ������

       ,(name:   'RestoreHealth';
         cost:    100;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'SetVar(IncHP,Rand([GetPlayerAttr(LVL) * 100]));'+
                 'ChangePlayerParam(HP,GetVar(IncHP));'+
                 'If([GetLang() = ENG], 1);'+
                 'AddEvent(Player restore GetVar(IncHP) HP);'+
                 'If([GetLang() = RU], 1);'+
                 'AddEvent(����� ����������� GetVar(IncHP) HP);'
        ) // ����� �������

       ,(name:   'RestoreMana';
         cost:    250;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'SetVar(IncMP,Rand([GetPlayerAttr(LVL) * 20]));'+
                 'ChangePlayerParam(MP,GetVar(IncMP));'+
                 'If([GetLang() = ENG], 1);'+
                 'AddEvent(Player restore GetVar(IncMP) MP);'+
                 'If([GetLang() = RU], 1);'+
                 'AddEvent(����� ����������� GetVar(IncMP) MP);'
         ) // ����� �������������� ����

       ,(name:   'PermanentATK';
         cost:    200;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'ChangePlayerParam(ATK,1);'+
                 'If([GetLang() = ENG], 1);'+
                 'AddEvent(Player get +1 ATK permanently!);'+
                 'If([GetLang() = RU], 1);'+
                 'AddEvent(����� ������� +1 ATK!);'
        ) // ����� ����������� ��������� �����

       ,(name:   'PermanentDEF';
         cost:    200;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'ChangePlayerParam(DEF,1);'+
                 'If([GetLang() = ENG], 1);'+                   // ���� ������ �� ����������
                 'AddEvent(Player get +1 DEF permanently!);'+
                 'If([GetLang() = RU], 1);'+                    // ���� ������ �� ����������
                 'AddEvent(����� ������� +1 DEF!);'
        ) // ����� ����������� ��������� ������

       ,(name:   'PermanentMDEF';
         cost:    200;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'ChangePlayerParam(MDEF,1);'+
                 'If([GetLang() = ENG], 1);'+                   // ���� ������ �� ����������
                 'AddEvent(Player get +1 MDEF permanently!);'+
                 'If([GetLang() = RU], 1);'+                    // ���� ������ �� ����������
                 'AddEvent(����� ������� +1 MDEF!);'
        ) // ����� ����������� ��������� ���������� ������

       ,(name:   'EXP';
         cost:    100;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'SetVar(EXP,Rand([GetPlayerAttr(LVL) * 100]));'+
                 'ChangePlayerParam(EXP,GetVar(EXP));'+
                 'If([GetLang() = ENG], 1);'+                   // ���� ������ �� ����������
                 'AddEvent(Player get +GetVar(EXP) EXP!);'+
                 'If([GetLang() = RU], 1);'+                    // ���� ������ �� ����������
                 'AddEvent(����� ������� + GetVar(EXP) EXP!);'
        ) // ����� �������� ��������� �����
{
       ,(name:   'REG';
         cost:    10000;
         script: 'ChangePlayerParam(REG,1);'+
                 'AddEvent(Player get +1 Regen permanently!)'
        ) // ����� ����������� ��������� ���������� ������
}


       ,(name:   'RegenHP';
         cost:    300;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'SetPlayerAutoBuff(HP,Rand([GetPlayerAttr(LVL) * 500]));'
        ) // ����� ����������� ��������

       ,(name:   'RegenMP';
         cost:    500;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'SetPlayerAutoBuff(MP,Rand([GetPlayerAttr(LVL) * 50]));'
        ) // ����� ����������� ����



       ,(name:   'BuffATK';
         cost:    100;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'SetPlayerBuff(ATK,[Rand(GetPlayerAttr(LVL)) + 1]);'
        ) // ����� ���������� ��������� �����

       ,(name:   'BuffDEF';
         cost:    100;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'SetPlayerBuff(DEF,[Rand(GetPlayerAttr(LVL)) + 1]);'
        ) // ����� ���������� ��������� ������

       ,(name:   'BuffMDEF';
         cost:    100;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'SetPlayerBuff(MDEF,[Rand(GetPlayerAttr(LVL)) + 1]);'
        ) // ����� ���������� �������� �����

       ,(name:   'BuffEXP';
         cost:    100;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'SetPlayerBuff(EXP,[Rand(GetPlayerAttr(LVL)) + 1]);'
        ) // ����� ���������� �������� �����

       ,(name:   'BuffREG';
         cost:    100;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'SetPlayerBuff(REG,[Rand([GetPlayerAttr(LVL) * 10]) + 10]);'
        ) // ����� ���������� �������� �����



       ,(name:   'AutoAction';
         cost:    1000;
         craft:    '';
         isCraftAllow: false;
         isUseAllow: true;
         script: 'ChangeAutoATK(Rand(Min([GetPlayerAttr(LVL) * 100], 2000)));'
        ) // ����� �������������� �����
    );


    /// ������������ ����������� �������/������
    /// ��� ���� cost - ��������� �� ���� ������� �����. ���� ���� 7 ������, �� � cost*7
    skills : array [0..8] of TItem = (
        (name:   'Healing';
         cost:    10;
         script: 'SetVar(IncHP,Rand([GetSkillLvl(Healing) * 50]));'+
                 'ChangePlayerParam(HP,GetVar(IncHP));'+
                 'AddEvent(Player restore GetVar(IncHP) HP);'
        )

       ,(name:   'Explosion';
         cost:    50;
         script:
                 'SetVar(Expl,Rand([GetSkillLvl(Explosion) * 300]));'+
                 'AddEvent(Target take GetVar(Expl) damage from Explosion!);'+
                 'ChangeTargetParam(HP,-GetVar(Expl));'
        )

       ,(name:   'Heroism';
         cost:    20;
         script:
                 'SetVar(value,Rand([GetSkillLvl(Heroism) * 5]));'+
                 'AddEvent(Player gets all stats buff by GetVar(value)!);'+
                 'SetPlayerBuff(ATK,GetVar(value));'+
                 'SetPlayerBuff(DEF,GetVar(value));'+
                 'SetPlayerBuff(MDEF,GetVar(value));'
        )

       ,(name:   'BreakDEF';
         cost:    15;
         script:
                 'SetVar(value,Rand([GetSkillLvl(BreakDEF) * 10]));'+
                 'SetVar(monster, GetMonsterAttr(DEF));'+                  /// ������� ���� � �������
                 'SetVar(value, MIN(GetVar(monster), GetVar(value)));'+    /// ����� ���������� ��������, ����� �� ���� � �����
                 'AddEvent(Monsters defense is reduced by GetVar(value)!);'+
                 'ChangeCreatureParam(DEF,-GetVar(value));'
        )

       ,(name:   'BreakMDEF';
         cost:    15;
         script:
                 'SetVar(value,Rand([GetSkillLvl(BreakMDEF) * 10]));'+
                 'SetVar(monster, GetMonsterAttr(MDEF));'+                  /// ������� ���� � �������
                 'SetVar(value, MIN(GetVar(monster), GetVar(value)));'+    /// ����� ���������� ��������, ����� �� ���� � �����
                 'AddEvent(Monsters magic defense is reduced by GetVar(value)!);'+
                 'ChangeCreatureParam(MDEF,-GetVar(value));'
        )

       ,(name:   'BreakATK';
         cost:    30;
         script:
                 'SetVar(value,Rand([GetSkillLvl(BreakATK) * 5]));'+      /// ������� ����� �������
                 'SetVar(monster, GetMonsterAttr(ATK));'+                  /// ������� ���� � �������
                 'SetVar(value, MIN(GetVar(monster), GetVar(value)));'+    /// ����� ���������� ��������, ����� �� ���� � �����
                 'AddEvent(Monsters attack reduced by GetVar(value)!);'+
                 'ChangeCreatureParam(ATK,-GetVar(value));'
        )

       ,(name:   'LeakMP';
         cost:    10;
         script:
                 'SetVar(leak,Rand([GetSkillLvl(LeakMP) * 30]));'+  // ������� �������� ������� �����
                 'SetVar(monsterMP,GetMonsterAttr(MP));'+           // ������� ���� � �������

                 'IF([GetVar(leak) >= GetVar(monsterMP)], 3);'+        // ���� �������� ������, ��� ����
                 'SetVar(leak, [GetVar(monsterMP) / 2]);'+          // ���������� ������� = �������� �� ����������
                 'ChangeCreatureParam(MP,-GetVar(monsterMP));'+     // �������� � ������� ���
                 'ChangePlayerParam(MP,GetVar(leak));'+             // ����� �������� ����

                 'IF([GetVar(leak) < GetVar(monsterMP)], 4);'+        // ���� �������� ������ ��� ����
                 'SetVar(monsterMP, GetVar(leak));'+                // ������ ����� ������ � ������ ������
                 'SetVar(leak, [GetVar(leak) / 2]);'+               // ����� ������� �������� �� ����������
                 'ChangeCreatureParam(MP,-GetVar(monsterMP));'+     // ������ ������
                 'ChangePlayerParam(MP,GetVar(leak));'+             // ����� ��������

                 'AddEvent(Monsters lost GetVar(monsterMP) MP);'+   // ������ ������
                 'AddEvent(Player gets GetVar(leak) MP!);'
        )

       ,(name:   'VampireStrike';
         cost:    10;
         script:
                 'SetVar(leak,Rand([GetSkillLvl(VampireStrike) * 20]));'+  // ������� �������� ������� �����
                 'SetVar(monsterHP,GetMonsterAttr(HP));'+           // ������� ���� � �������

                 'IF([GetVar(leak) >= GetVar(monsterHP)], 3);'+        // ���� �������� ������, ��� ����
                 'SetVar(leak, [GetVar(monsterHP) / 2]);'+          // ���������� ������� = �������� �� ����������
                 'ChangeCreatureParam(HP,-GetVar(monsterHP));'+     // �������� � ������� ���
                 'ChangePlayerParam(HP,GetVar(leak));'+             // ����� �������� ����

                 'IF([GetVar(leak) < GetVar(monsterHP)], 4);'+        // ���� �������� ������ ��� ����
                 'SetVar(monsterHP, GetVar(leak));'+                // ������ ����� ������ � ������ ������
                 'SetVar(leak, [GetVar(leak) / 2]);'+               // ����� ������� �������� �� ����������
                 'ChangeCreatureParam(HP,-GetVar(monsterHP));'+     // ������ ������
                 'ChangePlayerParam(HP,GetVar(leak));'+             // ����� ��������

                 'AddEvent(Monsters lost GetVar(monsterHP) HP);'+   // ������ ������
                 'AddEvent(Player gets GetVar(leak) HP!);'
        )

       ,(name:   'Metabolism';
         cost:    10;
         script:
                 'SetVar(value,[Rand([GetSkillLvl(Metabolism) * 5]) + 10]);'+
                 'SetPlayerBuff(REG,GetVar(value));'+
                 'AddEvent(Player speed up regen by GetVar(value)!);'
        )
    );

    phrases: array [0..12,0..1] of string = (
    (('-> Player is level up!'),
     ('-> ����� �������� ����� �������!')),

    (('Player killed by '),
     ('����� ���� �������� ')),

    (('Enter into Tower...'),
     ('������ � �����...')),

    (('Monster %s is killed! Got %s exp'),
     ('������ %s ����! �������� %s exp')),

    (('Go up %d Tower floor...'),
     ('����������� �� %d ���� �����...')),

    (('Using of %s is cost %d MP!'),
     ('������������� %s ����� %d MP!')),

    (('Skill %s is up to %d level!'),
     ('������ %s �������� �� %d ������!')),

    (('Level up skill %s is cost %d exp!'),
     ('��������� ������ %s ����� %d exp')),

    (('Player strike for %d DMG'),
     ('����� ����� %d �����')),

    (('Monster strike for %d DMG'),
     ('������ ����� %d �����')),

    (('Player strike for %d DMG ( %d is blocked )'),
     ('����� ����� %d ����� ( ������������� %d )')),

    (('Monster strike for %d DMG ( %d is blocked )'),
     ('������ ����� %d ����� ( ������������� %d )')),

    (('Got %s %s'),
     ('�������� %s %s'))
    );
const
    PHRASE_LEVEL_UP       = 0;
    PHRASE_KILLED_BY      = 1;
    PHRASE_DUNGEON_ENTER  = 2;
    PHRASE_MONSTER_KILLED = 3;
    PHRASE_TO_NEXT_FLOOR  = 4;
    PHRASE_SKILL_OVERCOST = 5;
    PHRASE_SKILL_UP       = 6;
    PHRASE_SKILL_OVERUP   = 7;
    PHRASE_PLAYER_STRIKE  = 8;
    PHRASE_MONSTER_STRIKE = 9;
    PHRASE_PLAYER_STRIKE_BLOCK  = 10;
    PHRASE_MONSTER_STRIKE_BLOCK = 11;
    PHRASE_GET_LOOT             = 12;
implementation

end.
