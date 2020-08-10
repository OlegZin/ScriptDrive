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
        Name                // ���������� ���
       ,Params              // ������� ���������: �������, ��������, ����, ����� � �.�.
       ,Buffs               // ����� � ���� ������ ���_����=����������_�������������
       ,AutoBuffs           // ��������� � ���� ������ ���_����=����������_�������������
       ,Items               // ��������� �������� ��� �������������
       ,Loot                // ��������� ��������� ��� ������
       ,Skills              // ������������ �� ���� �����/����������

       ,Events              // ������� �� ��������� ������� � ���� (������, ���������� � �.�.)
//       ,OnAttack            // ������ �� ����� �� �������
//       ,OnDeath             // ������ �� ������
                 : string;
    end;

    TItem = record
        name: string;
        cost: integer;
        script: string;
    end;

    TTarget = record
        level: integer;
        script: string;
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

    // ���������� ��� ������. ���������� ���������� ���������� ���� ���������
    loot: array [0..49] of string = (
        ('Wood'),('Wood'),('Wood'),('Wood'),('Wood'),('Wood'),('Wood'),('Wood'),('Wood'),('Wood'),            // 10
        ('Stone'),('Stone'),('Stone'),('Stone'),('Stone'),('Stone'),('Stone'),('Stone'),('Stone'),('Stone'),  // 10
        ('Herbal'),('Herbal'),('Herbal'),('Herbal'),('Herbal'),('Herbal'),('Herbal'),('Herbal'),              // 8
        ('Wheat'),('Wheat'),('Wheat'),('Wheat'),('Wheat'),('Wheat'),                                          // 6
        ('Meat'),('Meat'),('Meat'),('Meat'),                                                                  // 4
        ('Blood'),('Blood'),('Blood'),                                                                        // 3
        ('Bone'),('Bone'),('Bone'),                                                                           // 3
        ('Skin'),('Skin'),('Skin'),                                                                           // 3
        ('Ore'),('Ore'),                                                                                      // 2
        ('Essence')                                                                                           // 1
    );

    /// ������ ��������� ��������� ���� ��� ���������� ������������� �������.
    /// ������ ����, ���� �������� �������� ����� �� ���������
    targets: array [0..4] of TTarget = (
        (level: 2;
         script:
             'SetBreak(Tower);'+
             'AddEvent(..................);'+

             'IF({GetLang() = RU}, 2);'+
             'AddEvent(����� ������� 5 ����� AutoATK);'+
             'AddEvent(� ������ ������� ����� ������� ������� ������� �����.);'+

             'IF({GetLang() = ENG}, 2);'+
             'AddEvent(Player got 5 AutoATK items);'+
             'AddEvent(Some potions were found in a rusty chest between floors.);'+

             'AddEvent(..................);'+

             'ChangePlayerItemCount(AutoATK, 5);'
        ),

        (level: 3;
         script:
             'SetBreak(Tower);'+
             'SetVar(gold, Rand(10000));'+
             'AddEvent(..................);'+

             'IF({GetLang() = RU}, 4);'+
             'AddEvent(����� ������� GetVar(gold) ������);'+
             'AddEvent(" - ������ ������ �������� ���� ����� ���� � �����, ����� �� ����������� ������. �� ���� ����� ���� �� �������� ��� ����� � ������ ��� �������.");'+
             'AddEvent("��� ��, � ������� ����� ������ �������:");'+
             'AddEvent(� ������ ������� ����� ������� ������� ������� ������.);'+

             'IF({GetLang() = ENG}, 4);'+
             'AddEvent(Player got GetVar(gold) Gold);'+
             'AddEvent(" - The Dark Master guards his tower day and night, roaming the endless floors. No living soul can escape his wrath and the fury of his monsters.");'+
             'AddEvent("Also, there is a crumpled note in the chest:");'+
             'AddEvent(There was some gold in a rusty chest between floors.);'+

             'AddEvent(..................);'+

             'ChangePlayerItemCount(Gold, GetVar(gold));'
        )

       ,(level: 4;
         script:
             'SetBreak(Tower);'+
             'SetCreature(DARK MASTER,HP=9999 ATK=500,,Spirit=1);'+

             'AddEvent(..................);'+

             'IF({GetLang() = ENG}, 5);'+
             'AddEvent(Use `Restart` button to avoid enemy );' +
             'AddEvent(..................);'+
             'AddEvent(" - YOU WILL NOT PASS!");' +
             'AddEvent(" - What are you doing in my Tower, insignificance!?");' +
             'SetCreatureScript(OnDeath,"AddEvent(..................);AddEvent(- You defeated ME!? Can not be! Who are You?!);AddEvent(..................);");'+

             'IF({GetLang() = RU}, 5);'+
             'AddEvent("-> ����������� ������ `����������`, ����� �������� �����");' +
             'AddEvent(..................);'+
             'AddEvent(" - �� �� ��������!");' +
             'AddEvent(" - ��� �� ������� � ���� �����, �����������!?");' +
             'SetCreatureScript(OnDeath,"AddEvent(..................);AddEvent(- �� ������� ����!? �� ����� ����! ��� �� �����!?);AddEvent(..................);");'+

             'AddEvent(..................);'
        )

       ,(level: 7;
         script:
             'SetBreak(Tower);'+
             'AddEvent(..................);'+

             'IF({GetLang() = RU}, 3);'+
             'AddEvent(!!! �������� ����� ��������);'+
             'AddEvent(��� ������� ��� ������� �������� �� ����!);'+
             'AddEvent(���������! ��� ����� ����������!? ����� �����, ����� �������? ��� � ����� �����!?);'+

             'IF({GetLang() = ENG}, 3);'+
             'AddEvent(!!! �������� ����� ��������);'+
             'AddEvent(��� ������� ��� ������� �������� �� ����!);'+
             'AddEvent(���������! ��� ����� ����������!? ����� �����, ����� �������? ��� � ����� �����!?);'+

             'AddEvent(..................);'+

             'AllowMode(Think, 1);'
        )

       ,(level: maxint;
         script:
             'SetBreak(Tower);'+
             'IF({GetLang() = ENG}, 2);'+
             'AddEvent(!!! INCREDIBLE !!!);' +
             'AddEvent(!!! YOU PASS THE GAME !!!);' +

             'IF({GetLang() = RU}, 2);'+
             'AddEvent(!!! ���������� !!!);' +
             'AddEvent(!!! �� ������ ���� !!!);' +

             'CurrentLevel(1);InitCreatures();'
        )
    );

    // ��������-����������. � �������� ����� ������ ������ ����
    items: array [0..14] of TItem = (
        (name:   'Gold';
         cost:    MaxInt;
         script:

                 'If({GetPlayerItemCount(Gold) < 10000}, 5);'+                     // ���� ������ �� ����������
                 'If({GetLang() = RU}, 1);'+                     // ���� ������ �� ����������
                 'AddEvent(� ������ �� ���������� ������! [��������� 10 000 ������]);'+ // �������� �
                 'If({GetLang() = ENG}, 1);'+                     // ���� ������ �� ����������
                 'AddEvent(Player do not have enougth Gold! [Cost 10 000 Gold]);'+ // �������� �
                 'ChangePlayerItemCount(Gold, 1);'+                                // ������������ ������ 1 ������ �� ��������� �������������

                 'If({GetPlayerItemCount(Gold) > 9999}, 7);'+   // ���� ������ ����������
                 'SetVar(iName, GetRandItemName());'+           // �������� ��� ���������� ��������
                 'ChangePlayerItemCount(GetVar(iName), 1);'+    // ��������� ������� � ���������
                 'ChangePlayerItemCount(Gold, -9999);'+         // ��������� ������ � ������ ����, ��� 1 �������� �� ������������� ������ ��� ��������
                 'If({GetLang() = RU}, 1);'+                    // ���� ������ �� ����������
                 'AddEvent(����� ������� GetVar(iName)!);'+        // ������ ������ �������������
                 'If({GetLang() = ENG}, 1);'+                   // ���� ������ �� ����������
                 'AddEvent(Player get GetVar(iName)!);'         // ������ ������ �������������
        ) // ������

       ,(name:   'RestoreHealth';
         cost:    1000;
         script: 'SetVar(IncHP,Rand({GetPlayerAttr(LVL) * 100}));'+
                 'ChangePlayerParam(HP,GetVar(IncHP));'+
                 'If({GetLang() = ENG}, 1);'+                   // ���� ������ �� ����������
                 'AddEvent(Player restore GetVar(IncHP) HP)'+
                 'If({GetLang() = RU}, 1);'+                    // ���� ������ �� ����������
                 'AddEvent(����� ����������� GetVar(IncHP) HP)'
        ) // ����� �������

       ,(name:   'RestoreMana';
         cost:    1000;
         script: 'SetVar(IncMP,Rand({GetPlayerAttr(LVL) * 20}));'+
                 'ChangePlayerParam(MP,GetVar(IncMP));'+
                 'If({GetLang() = ENG}, 1);'+                   // ���� ������ �� ����������
                 'AddEvent(Player restore GetVar(IncMP) MP)'+
                 'If({GetLang() = RU}, 1);'+                    // ���� ������ �� ����������
                 'AddEvent(����� ����������� GetVar(IncMP) MP)'
         ) // ����� �������������� ����

       ,(name:   'PermanentATK';
         cost:    10000;
         script: 'ChangePlayerParam(ATK,1);'+
                 'If({GetLang() = ENG}, 1);'+                   // ���� ������ �� ����������
                 'AddEvent(Player get +1 ATK permanently!)'+
                 'If({GetLang() = RU}, 1);'+                    // ���� ������ �� ����������
                 'AddEvent(����� ������� +1 ATK!)'
        ) // ����� ����������� ��������� �����

       ,(name:   'PermanentDEF';
         cost:    10000;
         script: 'ChangePlayerParam(DEF,1);'+
                 'If({GetLang() = ENG}, 1);'+                   // ���� ������ �� ����������
                 'AddEvent(Player get +1 DEF permanently!)'+
                 'If({GetLang() = RU}, 1);'+                    // ���� ������ �� ����������
                 'AddEvent(����� ������� +1 DEF!)'
        ) // ����� ����������� ��������� ������

       ,(name:   'PermanentMDEF';
         cost:    10000;
         script: 'ChangePlayerParam(MDEF,1);'+
                 'If({GetLang() = ENG}, 1);'+                   // ���� ������ �� ����������
                 'AddEvent(Player get +1 MDEF permanently!)'+
                 'If({GetLang() = RU}, 1);'+                    // ���� ������ �� ����������
                 'AddEvent(����� ������� +1 MDEF!)'
        ) // ����� ����������� ��������� ���������� ������

       ,(name:   'EXP';
         cost:    1000;
         script: 'SetVar(EXP,Rand({GetPlayerAttr(LVL) * 100}));'+
                 'ChangePlayerParam(EXP,GetVar(EXP));'+
                 'If({GetLang() = ENG}, 1);'+                   // ���� ������ �� ����������
                 'AddEvent(Player get +GetVar(EXP) EXP!)'+
                 'If({GetLang() = RU}, 1);'+                    // ���� ������ �� ����������
                 'AddEvent(����� ������� + GetVar(EXP) EXP!)'
        ) // ����� �������� ��������� �����
{
       ,(name:   'REG';
         cost:    10000;
         script: 'ChangePlayerParam(REG,1);'+
                 'AddEvent(Player get +1 Regen permanently!)'
        ) // ����� ����������� ��������� ���������� ������
}


       ,(name:   'RegenHP';
         cost:    500;
         script: 'SetPlayerAutoBuff(HP,Rand({GetPlayerAttr(LVL) * 500}))'
        ) // ����� ����������� ��������

       ,(name:   'RegenMP';
         cost:    500;
         script: 'SetPlayerAutoBuff(MP,Rand({GetPlayerAttr(LVL) * 50}))'
        ) // ����� ����������� ����



       ,(name:   'BuffATK';
         cost:    5000;
         script: 'SetPlayerBuff(ATK,{Rand(GetPlayerAttr(LVL)) + 1})'
        ) // ����� ���������� ��������� �����

       ,(name:   'BuffDEF';
         cost:    5000;
         script: 'SetPlayerBuff(DEF,{Rand(GetPlayerAttr(LVL)) + 1})'
        ) // ����� ���������� ��������� ������

       ,(name:   'BuffMDEF';
         cost:    3000;
         script: 'SetPlayerBuff(MDEF,{Rand(GetPlayerAttr(LVL)) + 1})'
        ) // ����� ���������� �������� �����

       ,(name:   'BuffEXP';
         cost:    3000;
         script: 'SetPlayerBuff(EXP,{Rand(GetPlayerAttr(LVL)) + 1})'
        ) // ����� ���������� �������� �����

       ,(name:   'BuffREG';
         cost:    3000;
         script: 'SetPlayerBuff(REG,{Rand({GetPlayerAttr(LVL) * 10}) + 10})'
        ) // ����� ���������� �������� �����



       ,(name:   'AutoATK';
         cost:   10000;
         script: 'ChangeAutoATK(Rand(Min({GetPlayerAttr(LVL) * 100}, 1000)))'
        ) // ����� �������������� �����
    );


    /// ������������ ����������� �������/������
    /// ��� ���� cost - ��������� �� ���� ������� �����. ���� ���� 7 ������, �� � cost*7
    skills : array [0..8] of TItem = (
        (name:   'Healing';
         cost:    10;
         script: 'SetVar(IncHP,Rand({GetSkillLvl(Healing) * 50}));'+
                 'ChangePlayerParam(HP,GetVar(IncHP));'+
                 'AddEvent(Player restore GetVar(IncHP) HP)'
        )

       ,(name:   'Explosion';
         cost:    50;
         script:
                 'SetVar(Expl,Rand({GetSkillLvl(Explosion) * 300}));'+
                 'AddEvent(Monster take GetVar(Expl) damage from Explosion!);'+
                 'ChangeCreatureParam(HP,-GetVar(Expl));'
        )

       ,(name:   'Heroism';
         cost:    20;
         script:
                 'SetVar(value,Rand({GetSkillLvl(Heroism) * 10}));'+
                 'AddEvent(Player gets all stats buff by GetVar(value)!);'+
                 'SetPlayerBuff(ATK,GetVar(value));'+
                 'SetPlayerBuff(DEF,GetVar(value));'+
                 'SetPlayerBuff(MDEF,GetVar(value));'
        )

       ,(name:   'BreakDEF';
         cost:    15;
         script:
                 'SetVar(value,Rand({GetSkillLvl(BreakDEF) * 10}));'+
                 'SetVar(monster, GetMonsterAttr(DEF));'+                  /// ������� ���� � �������
                 'SetVar(value, MIN(GetVar(monster), GetVar(value)));'+    /// ����� ���������� ��������, ����� �� ���� � �����
                 'AddEvent(Monsters defense is reduced by GetVar(value)!);'+
                 'ChangeCreatureParam(DEF,-GetVar(value));'
        )

       ,(name:   'BreakMDEF';
         cost:    15;
         script:
                 'SetVar(value,Rand({GetSkillLvl(BreakMDEF) * 10}));'+
                 'SetVar(monster, GetMonsterAttr(MDEF));'+                  /// ������� ���� � �������
                 'SetVar(value, MIN(GetVar(monster), GetVar(value)));'+    /// ����� ���������� ��������, ����� �� ���� � �����
                 'AddEvent(Monsters magic defense is reduced by GetVar(value)!);'+
                 'ChangeCreatureParam(MDEF,-GetVar(value));'
        )

       ,(name:   'BreakATK';
         cost:    30;
         script:
                 'SetVar(value,Rand({GetSkillLvl(BreakATK) * 5}));'+      /// ������� ����� �������
                 'SetVar(monster, GetMonsterAttr(ATK));'+                  /// ������� ���� � �������
                 'SetVar(value, MIN(GetVar(monster), GetVar(value)));'+    /// ����� ���������� ��������, ����� �� ���� � �����
                 'AddEvent(Monsters attack reduced by GetVar(value)!);'+
                 'ChangeCreatureParam(ATK,-GetVar(value));'
        )

       ,(name:   'LeakMP';
         cost:    10;
         script:
                 'SetVar(leak,Rand({GetSkillLvl(LeakMP) * 30}));'+  // ������� �������� ������� �����
                 'SetVar(monsterMP,GetMonsterAttr(MP));'+           // ������� ���� � �������

                 'IF({GetVar(leak) >= GetVar(monsterMP)}, 3);'+        // ���� �������� ������, ��� ����
                 'SetVar(leak, {GetVar(monsterMP) / 2});'+          // ���������� ������� = �������� �� ����������
                 'ChangeCreatureParam(MP,-GetVar(monsterMP));'+     // �������� � ������� ���
                 'ChangePlayerParam(MP,GetVar(leak));'+             // ����� �������� ����

                 'IF(GetVar(leak) < GetVar(monsterMP), 4);'+        // ���� �������� ������ ��� ����
                 'SetVar(monsterMP, GetVar(leak));'+                // ������ ����� ������ � ������ ������
                 'SetVar(leak, {GetVar(leak) / 2});'+               // ����� ������� �������� �� ����������
                 'ChangeCreatureParam(MP,-GetVar(monsterMP));'+     // ������ ������
                 'ChangePlayerParam(MP,GetVar(leak));'+             // ����� ��������

                 'AddEvent(Monsters lost GetVar(monsterMP) MP);'+   // ������ ������
                 'AddEvent(Player gets GetVar(leak) MP!);'
        )

       ,(name:   'VampireStrike';
         cost:    10;
         script:
                 'SetVar(leak,Rand({GetSkillLvl(VampireStrike) * 20}));'+  // ������� �������� ������� �����
                 'SetVar(monsterHP,GetMonsterAttr(HP));'+           // ������� ���� � �������

                 'IF({GetVar(leak) >= GetVar(monsterHP)}, 3);'+        // ���� �������� ������, ��� ����
                 'SetVar(leak, {GetVar(monsterHP) / 2});'+          // ���������� ������� = �������� �� ����������
                 'ChangeCreatureParam(HP,-GetVar(monsterHP));'+     // �������� � ������� ���
                 'ChangePlayerParam(HP,GetVar(leak));'+             // ����� �������� ����

                 'IF(GetVar(leak) < GetVar(monsterHP), 4);'+        // ���� �������� ������ ��� ����
                 'SetVar(monsterHP, GetVar(leak));'+                // ������ ����� ������ � ������ ������
                 'SetVar(leak, {GetVar(leak) / 2});'+               // ����� ������� �������� �� ����������
                 'ChangeCreatureParam(HP,-GetVar(monsterHP));'+     // ������ ������
                 'ChangePlayerParam(HP,GetVar(leak));'+             // ����� ��������

                 'AddEvent(Monsters lost GetVar(monsterHP) HP);'+   // ������ ������
                 'AddEvent(Player gets GetVar(leak) HP!);'
        )

       ,(name:   'Metabolism';
         cost:    10;
         script:
                 'SetVar(value,{Rand({GetSkillLvl(Metabolism) * 5}) + 10});'+
                 'SetPlayerBuff(REG,GetVar(value));'+
                 'AddEvent(Player speed up regen by GetVar(value)!);'
        )
    );

    phrases: array [0..9,0..1] of string = (
    (('-> Player is level up!'),
     ('-> ����� �������� ����� �������!')),

    (('Player killed by '),
     ('����� ���� �������� ')),

    (('Enter into Tower...'),
     ('������ � �����...')),

    (('Monster %s is killed! Get %s exp'),
     ('������ %s ����! �������� %s exp')),

    (('Go up %d Dungeon level...'),
     ('����������� �� %d ���� �����...')),

    (('Using of %s is cost %d MP!'),
     ('������������� %s ����� %d MP!')),

    (('Skill %s is up to %d level!'),
     ('������ %s �������� �� %d ������!')),

    (('Level up skill %s is cost %d exp!'),
     ('��������� ������ %s ����� %d exp')),

    (('Player strike by %d DMG'),
     ('����� ����� %d �����')),

    (('Monster strike by %d DMG'),
     ('������ ����� %d �����'))
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

implementation

end.
