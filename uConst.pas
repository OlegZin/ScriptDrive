unit uConst;

interface

uses SysUtils;

const
    FILE_MENU_DATA = '\menu.dat';

    /// ��������� ���� ��� ������ �������
    MENU_DATA_DEF =
    '{Gold:0, '+
     'Lang:ENG, '+
     'NewLevel:1, '+
     'IntroOver:0, '+
     'Skills: {'+
         'Research:     {Name:{ENG:"Research",RU:"������������"},Enabled:0, Level:0, NeedGold:10,  NeedResearch:1 },'+
         'MoneyEaring:  {Name:{ENG:"Money Earing",RU:"�����"},Enabled:0, Level:1, NeedGold:20,  NeedResearch:5 },'+
         'BuildSpeed:   {Name:{ENG:"Build Speed",RU:"�������������"},Enabled:0, Level:1, NeedGold:50,  NeedResearch:10},'+
         'AutoMoney:    {Name:{ENG:"Auto Money",RU:"���������"},Enabled:0, Level:0, NeedGold:500, NeedResearch:15}'+
    '},'+
     'Objects: {'+
         'Logo:       {NeedResearch:3,  BuildCost:5,  Attempts:0, FullAttempts:10 },'+
         'MenuExit:   {Name:{ENG:"EXIT",RU:"�����"}, '+
                      'NeedResearch:6,  BuildCost:10, Attempts:0, FullAttempts:20 },'+
         'MenuLang:   {Name:{ENG:"LANGUAGE",RU:"����"},'+
                      'NeedResearch:9,  BuildCost:20, Attempts:0, FullAttempts:50 },'+
         'MenuResume: {Name:{ENG:"RESUME",RU:"����������"},'+
                      'NeedResearch:11, BuildCost:30, Attempts:0, FullAttempts:100 },'+
         'MenuNew:    {Name:{ENG:"NEW GAME",RU:"����� ����"},'+
                      'NeedResearch:14, BuildCost:50, Attempts:0, FullAttempts:150 },'+
         'Tower1: {NeedResearch:17, BuildCost:100, Attempts:0, FullAttempts:100 },'+
         'Tower2: {NeedResearch:20, BuildCost:150, Attempts:0, FullAttempts:150 },'+
         'Tower3: {NeedResearch:23, BuildCost:200, Attempts:0, FullAttempts:200 },'+
         'Tower4: {NeedResearch:26, BuildCost:250, Attempts:0, FullAttempts:250 }'+
    '}}';


    GAME_DATA =
    '{'+
    'player: {'+
        'params: {LVL:1, HP:100, MP:20, ATK:5, DEF:0, MDEF:0, REG:1, EXP:0},'+
        'events: {OnAttack:"DoDamageToCreature(GetPlayerAttr(ATK));"},'+
    '},'+



    /// rarity - �������� �������. ��� ������, ��� ���� �����������
    /// cost - ��������� ������� ������� � ������
    ///        ��������� �� �������: cost = FULL / rarity, ��� FULL = ����� rarity ���� ��������
    /// count - ���������� ������� � ������
    'resRaritySumm: 50,'+
    'resources:{'+
        'wood:   {caption:{RU:"������",ENG:"Wood"},      rarity: 10,  cost:  5, count: 0},'+
        'stone:  {caption:{RU:"������",ENG:"Stone"},     rarity: 10,  cost:  5, count: 0},'+
        'herbal: {caption:{RU:"�����",ENG:"Herbal"},     rarity:  8,  cost:  6, count: 0},'+
        'wheat:  {caption:{RU:"�����",ENG:"Wheat"},      rarity:  6,  cost:  8, count: 0},'+
        'meat:   {caption:{RU:"����",ENG:"Meat"},        rarity:  4,  cost: 13, count: 0},'+
        'blood:  {caption:{RU:"�����",ENG:"Blood"},      rarity:  3,  cost: 17, count: 0},'+
        'bone:   {caption:{RU:"�����",ENG:"Bone"},       rarity:  3,  cost: 17, count: 0},'+
        'skin:   {caption:{RU:"�����",ENG:"Skin"},       rarity:  3,  cost: 17, count: 0},'+
        'ore:    {caption:{RU:"����",ENG:"Ore"},         rarity:  2,  cost: 25, count: 0},'+
        'essence:{caption:{RU:"��������",ENG:"Essence"}, rarity:  1,  cost: 50, count: 0}'+
    '},'+



    /// cost - ��������� ������� � ������
    /// craft - ����� �������� ��� ������. �������� ��������� ��� ������ ����
    /// isCraftAllow - �������� �� ��� ������
    /// isUseAllow - �������� �� ��� �������������
    'items:{'+
        'gold:{ caption: {RU:"������", ENG:"Gold"}, cost: 0, craft: "", isCraftAllow: false, isUseAllow: true,'+
            'description:{'+
                'RU:"����������� ������� ������. �� 10 000 ����� ����� �������� ��������� �������. �������� �����?",'+
                'ENG:"Full-weight gold coins. For 10,000 coins, you can get a random item. Lets try our luck?"'+
            '},'+
            'script:"'+
                'SetTarget(Player);' +
                'If([GetItemCount(Gold) < 10000], 5);'+
                'If([GetLang() = RU], 1);'+
                'AddEvent(�� ���������� ������!);'+
                'If([GetLang() = ENG], 1);'+
                'AddEvent(You do not have enougth Gold!);'+
                'ChangeItemCount(Gold, 1);'+

                'If([GetItemCount(Gold) > 9999], 7);'+
                'SetVar(iName, GetRandItemName());'+
                'ChangeItemCount(GetVar(iName), 1);'+
                'ChangeItemCount(Gold, -9999);'+
                'If([GetLang() = RU], 1);'+
                'AddEvent(�������� GetVar(iName)!);'+
                'If([GetLang() = ENG], 1);'+
                'AddEvent(Gained GetVar(iName)!);'+
        '"},'+
        'restoreHealth:{ caption: {RU:"����� ��������", ENG:"Potion of health"}, cost: 100, craft: "", isCraftAllow: false, isUseAllow: true,'+
            'description:{'+
                'RU:"��������� ��������� ��������. ���������� ��������: �� ���� �� 100 ����������� �� ������� ������� ������.",'+
                'ENG:"Instantly adds health. The amount is random: from zero to 100 multiplied by the players current level."'+
            '},'+
            'script:"'+
                'SetVar(IncHP,Rand([GetPlayerAttr(LVL) * 100]));'+
                'ChangePlayerParam(HP,GetVar(IncHP));'+
                'If([GetLang() = ENG], 1);'+
                'AddEvent(Gained GetVar(IncHP) health);'+
                'If([GetLang() = RU], 1);'+
                'AddEvent(�������� GetVar(IncHP) ��������);'+
        '"},'+
        'restoreMana:{ caption: {RU:"����� ����", ENG:"Potion of mana"}, cost: 250, craft: "", isCraftAllow: false, isUseAllow: true,'+
            'description:{'+
                'RU:"��������� ��������� ����. ���������� ��������: �� ���� �� 50 ����������� �� ������� ������� ������.",'+
                'ENG:"Instantly adds mana. The amount is random: from zero to 50 multiplied by the players current level."'+
            '},'+
            'script:"'+
                'SetVar(IncMP,Rand([GetPlayerAttr(LVL) * 50]));'+
                'ChangePlayerParam(MP,GetVar(IncMP));'+
                'If([GetLang() = ENG], 1);'+
                'AddEvent(Gained GetVar(IncMP) mana);'+
                'If([GetLang() = RU], 1);'+
                'AddEvent(�������� GetVar(IncMP) ����);'+
        '"},'+
        'permanentATK:{ caption: {RU:"����� �����", ENG:"Potion of attack"}, cost: 200, craft: "", isCraftAllow: false, isUseAllow: true,'+
            'description:{'+
                'RU:"�������� ��������� �����. ���������� ������.",'+
                'ENG:"Increases attack potential. Permanent effect."'+
            '},'+
            'script:"'+
                'ChangePlayerParam(ATK,1);'+
                'If([GetLang() = ENG], 1);'+
                'AddEvent(Gained +1 attack!);'+
                'If([GetLang() = RU], 1);'+
                'AddEvent(�������� +1 � �����!);'+
        '"},'+
        'permanentDEF:{ caption: {RU:"����� ������", ENG:"Potion of defence"}, cost: 200, craft: "", isCraftAllow: false, isUseAllow: true,'+
            'description:{'+
                'RU:"�������� ���������� ������. ���������� ������.",'+
                'ENG:"Increases physical protection. Permanent effect."'+
            '},'+
            'script:"'+
                'ChangePlayerParam(DEF,1);'+
                'If([GetLang() = ENG], 1);'+
                'AddEvent(Gained +1 defence!);'+
                'If([GetLang() = RU], 1);'+
                'AddEvent(�������� +1 � ������!);'+
        '"},'+
        'PermanentMDEF:{ caption: {RU:"����� ���������� ������", ENG:"Potion of magic defence"}, cost: 200, craft: "", isCraftAllow: false, isUseAllow: true,'+
            'description:{'+
                'RU:"�������� ������ �� ����� � �������������� �����������. ���������� ������.",'+
                'ENG:"Increases protection against magic and energetic influences. Permanent effect."'+
            '},'+
            'script:"'+
                'ChangePlayerParam(MDEF,1);'+
                'If([GetLang() = ENG], 1);'+
                'AddEvent(Gained +1 magic defence!);'+
                'If([GetLang() = RU], 1);'+
                'AddEvent(�������� +1 ���������� ������!);'+
        '"},'+
        'exp:{ caption: {RU:"����� �����", ENG:"Potion of experience"}, cost: 100, craft: "", isCraftAllow: false, isUseAllow: true,'+
            'description:{'+
                'RU:"��������� ���� ���������� ����. ���������� �� 0 �� 100 ���������� �� ������� ������� ������.",'+
                'ENG:"Gives you a free experience instantly. A number between 0 and 100 multiplied by the players current level."'+
            '},'+
            'script:"'+
                'SetVar(EXP,Rand([GetPlayerAttr(LVL) * 100]));'+
                'ChangePlayerParam(EXP,GetVar(EXP));'+
                'If([GetLang() = ENG], 1);'+
                'AddEvent(Gained GetVar(EXP) experience!);'+
                'If([GetLang() = RU], 1);'+
                'AddEvent(�������� GetVar(EXP) �����!);'+
        '"},'+
        'regenHP:{ caption: {RU:"���� ��������", ENG:"Ointment of health"}, cost: 300, craft: "", isCraftAllow: false, isUseAllow: true,'+
            'description:{'+
                'RU:"���������� ��������������� ��������. ��������� �������������� �� 0 �� 500 ���������� �� ������� ������� ������.",'+
                'ENG:"Restores health over time. Recovery potential from 0 to 500 multiplied by the players current level."'+
            '},'+
            'script:"SetPlayerAutoBuff(HP,Rand([GetPlayerAttr(LVL) * 500]));'+
        '"},'+
        'regenMP:{ caption: {RU:"���� �������", ENG:"Ointment of mana"}, cost: 500, craft: "", isCraftAllow: false, isUseAllow: true,'+
            'description:{'+
                'RU:"���������� ��������������� ����. ��������� �������������� �� 0 �� 500 ���������� �� ������� ������� ������.",'+
                'ENG:"Restores mana over time. Recovery potential from 0 to 500 multiplied by the players current level."'+
            '},'+
            'script:"SetPlayerAutoBuff(MP,Rand([GetPlayerAttr(LVL) * 50]));'+
        '"},'+
        'buffATK:{ caption: {RU:"������� �����", ENG:"Powder of attack"}, cost: 100, craft: "", isCraftAllow: false, isUseAllow: true,'+
            'description:{'+
                'RU:"�������� �������� ��������� �����. ��������� ����� ������ ����� ������.",'+
                'ENG:"Temporarily increases attack potential. Decreases after each player attack."'+
            '},'+
            'script:"SetPlayerBuff(ATK,[Rand(GetPlayerAttr(LVL)) + 1]);'+
        '"},'+
        'buffDEF:{ caption: {RU:"������� ������", ENG:"Powder of defence"}, cost: 100, craft: "", isCraftAllow: false, isUseAllow: true,'+
            'description:{'+
                'RU:"�������� �������� ��������� ������. ��������� ����� ������ ����� �� ������.",'+
                'ENG:"Temporarily increases attack potential. Decreases after each attack on the player."'+
            '},'+
            'script:"SetPlayerBuff(DEF,[Rand(GetPlayerAttr(LVL)) + 1]);'+
        '"},'+
        'buffMDEF:{ caption: {RU:"������� ���������� ������", ENG:"Powder of magic defence"}, cost: 100, craft: "", isCraftAllow: false, isUseAllow: true,'+
            'description:{'+
                'RU:"�������� �������� ��������� ���������� ������. ��������� ����� ������� ����������� ��� ��������������� ����������� �� ������.",'+
                'ENG:"Temporarily increases the potential of magic protection. Decreases after each magical or energy impact on the player."'+
            '},'+
            'script:"SetPlayerBuff(MDEF,[Rand(GetPlayerAttr(LVL)) + 1]);'+
        '"},'+
        'buffEXP:{ caption: {RU:"������� �����", ENG:"Powder of experience"}, cost: 100, craft: "", isCraftAllow: false, isUseAllow: true,'+
            'description:{'+
                'RU:"�������� �������� ��������� ��������� �����. ��������� ����� ������� ��������� ����� �������.",'+
                'ENG:"Temporarily increases the potential for gaining experience. Decreased after each player gains experience."'+
            '},'+
            'script:"SetPlayerBuff(EXP,[Rand(GetPlayerAttr(LVL)) + 1]);'+
        '"},'+
        'buffREG:{ caption: {RU:"������� �����������", ENG:"Powder of regeneration"}, cost: 100, craft: "", isCraftAllow: false, isUseAllow: true,'+
            'description:{'+
                'RU:"�������� �������� ���� ������� �����������. ��������� ����� ������ �����������.",'+
                'ENG:"Temporarily increases the strength of the regeneration effect. Decreases after each regeneration."'+
            '},'+
            'script:"SetPlayerBuff(REG,[Rand([GetPlayerAttr(LVL) * 10]) + 10]);'+
        '"},'+
        'autoAction:{ caption: {RU:"����� ������������", ENG:"Potion of autoactions"}, cost: 1000, craft: "", isCraftAllow: false, isUseAllow: true,'+
            'description:{'+
                'RU:"��������� ������������. ������ �� 0 �� 100 ���������� �� ������� ������, �� �� ������ 2000.",'+
                'ENG:"Adds auto-actions. The effect is from 0 to 100 multiplied by the players level, but not more than 2000."'+
            '},'+
            'script:"ChangeAutoATK(Rand(Min([GetPlayerAttr(LVL) * 100], 2000)));'+
        '"}'+
    '},'+


    /// cost - ��������� ��������� � ���� �� ������� �����
    /// lvl - ��������� ��������� � ���� �� ������� �����
    /// isActivated - ������������ ��� ��������� �����
    /// isEnabled - �������� �� ��� ������������� (����� �� ������������ � ������ ���������)
    'skills:{'+
        'healing:{caption:{RU:"�������",ENG:"Healing"}, lvl: 0; cost: 10, isActivated: true, isEnabled: true,'+
            'description:{'+
                'RU:"��������������� �������� ����. ������ �� 0 �� 50 ���������� �� ������� ������. ��������� 20 ���� �� ������� ������.",'+
                'ENG:"Restores the targets health. The effect is from 0 to 50 multiplied by the skill level. Cost 20 mana per skill level."'+
            '},'+
            'script:"'+
                'SetVar(IncHP,Rand([GetSkillLvl(healing) * 50]));'+
                'ChangeTargetParam(HP,GetVar(IncHP));'+
                'If([GetLang() = ENG], 1);'+
                'AddEvent(�arget gets GetVar(IncHP) health);'+
                'If([GetLang() = RU], 1);'+
                'AddEvent(���� ������� GetVar(IncHP) ��������);'+
        '"},'+
        'explosion:{caption:{RU:"�����",ENG:"Explosion"}, lvl: 0; cost: 50, isActivated: true, isEnabled: true,'+
            'description:{'+
                'RU:"������� ���� ���������� ����. ������ �� 0 �� 300 ���������� �� ������� ������. ��������� 50 ���� �� ������� ������.",'+
                'ENG:"Deals magic damage to the target. The effect is from 0 to 300 multiplied by the skill level. Cost 50 mana per skill level."'+
            '},'+
            'script:"'+
                'SetVar(Expl,Rand([GetSkillLvl(explosion) * 300]));'+
                'ChangeTargetParam(HP,-GetVar(Expl));'+
                'If([GetLang() = ENG], 1);'+
                'AddEvent(Target take GetVar(Expl) damage!);'+
                'If([GetLang() = RU], 1);'+
                'AddEvent(���� ������� GetVar(Expl) �����!);'+
        '"},'+
        'heroism:{caption:{RU:"�������",ENG:"Heroism"}, lvl: 0; cost: 20, isActivated: true, isEnabled: true,'+
            'description:{'+
                'RU:"�������� �������� ��������� ����: �����, ������ � ���������� ������. ������ �� 0 �� 5 ���������� �� ������� ������. ��������� 20 ���� �� ������� ������.",'+
                'ENG:"Temporarily increases the parameters of the target: attack, defence and magic defence. The effect is from 0 to 5 multiplied by the skill level. Cost 20 mana per skill level."'+
            '},'+
            'script:"'+
                'SetVar(value,Rand([GetSkillLvl(heroism) * 5]));'+
                'SetTargetBuff(ATK,GetVar(value));'+
                'SetTargetBuff(DEF,GetVar(value));'+
                'SetTargetBuff(MDEF,GetVar(value));'+
                'If([GetLang() = ENG], 1);'+
                'AddEvent(Target has received an attack and defence boost of GetVar(value));'+
                'If([GetLang() = RU], 1);'+
                'AddEvent(���� �������� �������� ����� � ������ �� GetVar(value));'+
        '"},'+
        'breakDEF:{caption:{RU:"�������� ������",ENG:"Defence break"}, lvl: 0; cost: 15, isActivated: true, isEnabled: true,'+
            'description:{'+
                'RU:"������� �������� ������ ����. ������ �� 0 �� 10 ���������� �� ������� ������. ��������� 15 ���� �� ������� ������.",'+
                'ENG:"Reduces the value of target defence. The effect is from 0 to 10 multiplied by the skill level. Cost 15 mana per skill level."'+
            '},'+
            'script:"'+
                'SetVar(value,Rand([GetSkillLvl(breakDEF) * 10]));'+
                'ChangeTargetParam(DEF,-GetVar(value));'+
                'If([GetLang() = ENG], 1);'+
                'AddEvent(Target defense reduced by GetVar(value));'+
                'If([GetLang() = RU], 1);'+
                'AddEvent(������ ���� ������� �� GetVar(value));'+
        '"},'+
        'breakMDEF:{caption:{RU:"�������� ���������� ������",ENG:"Magic defence break"}, lvl: 0; cost: 15, isActivated: true, isEnabled: true,'+
            'description:{'+
                'RU:"������� �������� ���������� ������ ����. ������ �� 0 �� 10 ���������� �� ������� ������. ��������� 15 ���� �� ������� ������.",'+
                'ENG:"Reduces the value of target magic defence. The effect is from 0 to 10 multiplied by the skill level. Cost 15 mana per skill level."'+
            '},'+
            'script:"'+
                'SetVar(value,Rand([GetSkillLvl(breakMDEF) * 10]));'+
                'ChangeTargetParam(MDEF,-GetVar(value));'+
                'If([GetLang() = ENG], 1);'+
                'AddEvent(Target magic defense reduced by GetVar(value));'+
                'If([GetLang() = RU], 1);'+
                'AddEvent(���������� ������ ���� ������� �� GetVar(value));'+
        '"},'+
        'breakATK:{caption:{RU:"������",ENG:"Injury"}, lvl: 0; cost: 30, isActivated: true, isEnabled: true,'+
            'description:{'+
                'RU:"������� ����� ����. ������ �� 0 �� 5 ���������� �� ������� ������. ��������� 30 ���� �� ������� ������.",'+
                'ENG:"Reduces target attack. The effect is from 0 to 5 multiplied by the skill level. Cost of 30 mana per skill level."'+
            '},'+
            'script:"'+
                'SetVar(value,Rand([GetSkillLvl(breakATK) * 5]));'+
                'ChangeTargetParam(ATK,-GetVar(value));'+
                'If([GetLang() = ENG], 1);'+
                'AddEvent(Target attack reduced by GetVar(value));'+
                'If([GetLang() = RU], 1);'+
                'AddEvent(����� ���� ������� �� GetVar(value));'+
        '"},'+
        'leakMP:{caption:{RU:"������ ����",ENG:"Mana leak"}, lvl: 0; cost: 10, isActivated: true, isEnabled: true,'+
            'description:{'+
                'RU:"�������� � ���� ����, �� �� ������ ���������� ����������. ����� �������� �������� ����� ����������. ������ �� 0 �� 30 ���������� �� ������� ������. ��������� 10 ���� �� �������.",'+
                'ENG:"It takes away mana from the target, but not more than the available amount. The player receives half of this amount. The effect is from 0 to 30 multiplied by the skill level. Cost 10 mana per level."'+
            '},'+
            'script:"'+
                'SetVar(leak,Rand([GetSkillLvl(leakMP) * 30]));'+  // ������� �������� ������� �����
                'SetVar(monsterMP,GetTargetAttr(MP));'+           // ������� ���� � �������

                'IF([GetVar(leak) >= GetVar(monsterMP)], 3);'+        // ���� �������� ������, ��� ����
                'SetVar(leak, [GetVar(monsterMP) / 2]);'+          // ���������� ������� = �������� �� ����������
                'ChangeTargetParam(MP,-GetVar(monsterMP));'+     // �������� � ������� ���
                'ChangePlayerParam(MP,GetVar(leak));'+             // ����� �������� ����

                'IF([GetVar(leak) < GetVar(monsterMP)], 4);'+        // ���� �������� ������ ��� ����
                'SetVar(monsterMP, GetVar(leak));'+                // ������ ����� ������ � ������ ������
                'SetVar(leak, [GetVar(leak) / 2]);'+               // ����� ������� �������� �� ����������
                'ChangeTargetParam(MP,-GetVar(monsterMP));'+     // ������ ������
                'ChangePlayerParam(MP,GetVar(leak));'+             // ����� ��������

                'If([GetLang() = ENG], 2);'+
                'AddEvent(Target lost GetVar(monsterMP) mana);'+   // ������ ������
                'AddEvent(Player got GetVar(leak) mana);'+
                'If([GetLang() = RU], 2);'+
                'AddEvent(���� �������� GetVar(monsterMP) ����);'+   // ������ ������
                'AddEvent(����� ������� GetVar(leak) ����);'+
        '"},'+
        'vampireStrike:{caption:{RU:"",ENG:""}, lvl: 0; cost: 10, isActivated: true, isEnabled: true,'+
            'description:{'+
                'RU:"�������� � ���� ��������, �� �� ������ ���������� ����������. ����� �������� �������� ����� ����������. ������ �� 0 �� 20 ���������� �� ������� ������. ��������� 10 ���� �� �������.",'+
                'ENG:"It takes away health from the target, but not more than the available amount. The player receives half of this amount. The effect is from 0 to 20 multiplied by the skill level. Cost 10 mana per level."'+
            '},'+
            'script:"'+
                'SetVar(leak,Rand([GetSkillLvl(vampireStrike) * 20]));'+  // ������� �������� ������� �����
                'SetVar(monsterHP,GetTargetAttr(HP));'+           // ������� ���� � �������

                'IF([GetVar(leak) >= GetVar(monsterHP)], 3);'+        // ���� �������� ������, ��� ����
                'SetVar(leak, [GetVar(monsterHP) / 2]);'+          // ���������� ������� = �������� �� ����������
                'ChangeTargetParam(HP,-GetVar(monsterHP));'+     // �������� � ������� ���
                'ChangePlayerParam(HP,GetVar(leak));'+             // ����� �������� ����

                'IF([GetVar(leak) < GetVar(monsterHP)], 4);'+        // ���� �������� ������ ��� ����
                'SetVar(monsterHP, GetVar(leak));'+                // ������ ����� ������ � ������ ������
                'SetVar(leak, [GetVar(leak) / 2]);'+               // ����� ������� �������� �� ����������
                'ChangeTargetParam(HP,-GetVar(monsterHP));'+     // ������ ������
                'ChangePlayerParam(HP,GetVar(leak));'+             // ����� ��������

                'If([GetLang() = ENG], 2);'+
                'AddEvent(Target lost GetVar(monsterHP) health);'+   // ������ ������
                'AddEvent(Player got GetVar(leak) health);'+
                'If([GetLang() = RU], 2);'+
                'AddEvent(���� �������� GetVar(monsterHP) ��������);'+   // ������ ������
                'AddEvent(����� ������� GetVar(leak) ��������);'+
        '"},'+
        'metabolism:{caption:{RU:"����������",ENG:"Metabolism"}, lvl: 0; cost: 10, isActivated: true, isEnabled: true,'+
            'description:{'+
                'RU:"�������� �������� ���� ������� �����������. ������ �� 0 �� 5 ���������� �� ������� ������. ��������� 10 ���� �� �������.",'+
                'ENG:"Temporarily increases the strength of the regeneration effect. The effect is from 0 to 5 multiplied by the skill level. Cost 10 mana per level."'+
            '},'+
            'script:"'+
                'SetVar(value,[Rand([GetSkillLvl(metabolism) * 5]) + 10]);'+
                'SetTargetBuff(REG,GetVar(value));'+
                'If([GetLang() = ENG], 1);'+
                'AddEvent(Target speed up regeneration by GetVar(value));'+
                'If([GetLang() = RU], 1);'+
                'AddEvent(����������� ���� ��������� �� GetVar(value));'+
        '"},'+
    '},'+



    /// isAllow - �������� �� ��� �������������
    /// lvl - ������� ������� �����������
    'Tools:{'+
        'shovel:{'+
            'isAllow: false,'+
            'lvl: 1,'+
            'caption: {RU:"������",ENG:"Shovel"},'+
            'desc: {RU:"��������� ������� ���������� �����",ENG:"Allows you to clear trash faster."},'+
            'script: "SetVar(SHOVEL_LVL, [GetVar(SHOVEL_LVL) + 1]);"'+
        '},'+
        'pick:{'+
            'isAllow: false,'+
            'lvl: 1,'+
            'caption: {RU:"�����",ENG:"Pick"},'+
            'desc: {RU:"��������� ������� ��������� ������.",ENG:"Allows you to quickly disassemble blockage."},'+
            'script: "SetVar(PICK_LVL, [GetVar(PICK_LVL) + 1]);"'+
        '},'+
        'axe:{'+
            'isAllow: false,'+
            'lvl: 1,'+
            'caption: {RU:"�����",ENG:"Axe"},'+
            'desc: {RU:"��������� ������� ��������� �����.",ENG:"Allows you to break boxes faster."},'+
            'script: "SetVar(AXE_LVL, [GetVar(AXE_LVL) + 1]);"'+
        '},'+
        'lockpick:{'+
            'isAllow: false,'+
            'lvl: 1,'+
            'caption: {RU:"�������",ENG:"Lockpick"},'+
            'desc: {RU:"��������� ������� ��������� �������.",ENG:"Allows you to open chests faster."},'+
            'script: "SetVar(KEY_LVL, [GetVar(KEY_LVL) + 1]);"'+
        '},'+
        'sword:{'+
            'isAllow: false,'+
            'lvl: 0,'+
            'caption: {RU:"���",ENG:"Sword"},'+
            'desc: {RU:"����������� ����������� ���� �� �� ���� ������� �����.",ENG:"Increases minimum damage but not higher than the current attack."},'+
            'script: "SetVar(SWORD_LVL, [GetVar(SWORD_LVL) + 1]);"'+
        '},'+
        'lifeAmulet:{'+
            'isAllow: false,'+
            'lvl: 0,'+
            'caption: {RU:"������ ��������",ENG:"Amulet of Health"},'+
            'desc: {RU:"��� ����������� ��������� +100 �������� �� �������.",ENG:"Adds +100 HP per level upon respawn."},'+
            'script: "SetVar(LIFEAMULET_LVL, [GetVar(LIFEAMULET_LVL) + 1]);"'+
        '},'+
        'timeSand:{'+
            'isAllow: false,'+
            'lvl: 0,'+
            'caption: {RU:"����� �������",ENG:"Sand of Time"},'+
            'desc: {RU:"�������� ������������ �� 3% �� �������.",ENG:"Speeds up Auto Actions by 3% per level."},'+
            'script: "SetVar(TIMESAND_LVL, [GetVar(TIMESAND_LVL) + 3]);"'+
        '},'+
        'leggings:{'+
            'isAllow: false,'+
            'lvl: 0,'+
            'caption: {RU:"������",ENG:"Leggings"},'+
            'desc: {RU:"����������� ���� �������� ������� ������� ���� ������ � �.�. �� 3% �� �������.",ENG:"Increases the chance to avoid the effect of traps rats spiders etc. 3% per level."},'+
            'script: "SetVar(LEGGINGS_LVL, [GetVar(LEGGINGS_LVL) + 3]);"'+
        '},'+
        'wisdom:{'+
            'isAllow: false,'+
            'lvl: 1,'+
            'caption: {RU:"����� ��������",ENG:"Circle of Wisdom"},'+
            'desc: {RU:"��������� ����� � ��������� ������� �������� ����� ����.",ENG:"Clarifies thoughts and allows you to find new ideas faster."},'+
            'script: "SetVar(WISDOM_LVL, [GetVar(WISDOM_LVL) + 1]);"'+
        '},'+
        'resist:{'+
            'isAllow: false,'+
            'lvl: 0,'+
            'caption: {RU:"������ �������������",ENG:"Ring of resistance"},'+
            'desc: {RU:"����������� �� 2% �� ������� ���� ������������� �������, ��������� ��������� ���������.",ENG:"Increases by 2% per level the chance to block effects that reduce character parameters."},'+
            'script: "SetVar(RESIST_LVL, [GetVar(RESIST_LVL) + 2]);"'+
        '},'+
        'expStone:{'+
            'isAllow: false,'+
            'lvl: 0,'+
            'caption: {RU:"������ �����",ENG:"Experience stone"},'+
            'desc: {RU:"�� 1 �� ������� ����������� ���������� ����.",ENG:"Increases experience gained by 1 per level."},'+
            'script: "SetVar(EXP_LVL, [GetVar(EXP_LVL) + 2]);"'+
        '},'+
    '},'+



    /// ����� ��� ��������
    'names:{'+
        'count: 40,'+
        'first:['+
            '{RU:"��������",ENG:"Stoned"},{RU:"�������",ENG:"Strong"},{RU:"��������",ENG:"Brave"},{RU:"��������",ENG:"Northern"},{RU:"����������",ENG:"Doomed"},'+
            '{RU:"�������",ENG:"Local"},{RU:"��������",ENG:"Insidious"},{RU:"������������",ENG:"Great"},{RU:"������������",ENG:"Deadly"},{RU:"������",ENG:"Accurate"},'+
            '{RU:"��������",ENG:"Hungry"},{RU:"�������",ENG:"Heavy"},{RU:"������",ENG:"Sleepy"},{RU:"������",ENG:"Holy"},{RU:"�����",ENG:"Bold"},'+
            '{RU:"�������",ENG:"Gas"},{RU:"��������",ENG:"Beautiful"},{RU:"�����������",ENG:"Similar"},{RU:"�����������",ENG:"Ugly"},{RU:"����������",ENG:"Glassy"},'+
            '{RU:"������",ENG:"Warm"},{RU:"�����������",ENG:"Modern"},{RU:"�����",ENG:"Narrow"},{RU:"����������",ENG:"Unpleasant"},{RU:"�������",ENG:"Dead"},'+
            '{RU:"��������",ENG:"Finite"},{RU:"��������",ENG:"Main"},{RU:"���������",ENG:"Possible"},{RU:"��������",ENG:"Evening"},{RU:"������������",ENG:"Physical"},'+
            '{RU:"����������",ENG:"Previous"},{RU:"��������",ENG:"Cold"},{RU:"�������",ENG:"Convenient"},{RU:"�����������",ENG:"Efficient"},{RU:"��������",ENG:"Genuine"},'+
            '{RU:"�������",ENG:"Good"},{RU:"����������",ENG:"Monstrous"},{RU:"�������",ENG:"Green"},{RU:"�����",ENG:"Any"},{RU:"������",ENG:"Prominent"}'+
        '],'+
        'middle:['+
            '{RU:"����",ENG:"Freak"},{RU:"�����",ENG:"Major"},{RU:"��������",ENG:"Seeker"},{RU:"������",ENG:"Dweller"},{RU:"���������",ENG:"Crusher"},'+
            '{RU:"������",ENG:"Wall"},{RU:"�����",ENG:"Mattress"},{RU:"�������",ENG:"Minister"},{RU:"������",ENG:"Greedy"},{RU:"�����",ENG:"Army"},'+
            '{RU:"��������",ENG:"Drinker"},{RU:"���������",ENG:"Result"},{RU:"������",ENG:"Peptide"},{RU:"������",ENG:"Soldier"},{RU:"����������",ENG:"Cutter"},'+
            '{RU:"������",ENG:"Air"},{RU:"������",ENG:"Kawaii"},{RU:"����",ENG:"Bird"},{RU:"������",ENG:"Winner"},{RU:"�������������",ENG:"Follower"},'+
            '{RU:"�����",ENG:"Tail"},{RU:"�������",ENG:"Gift"},{RU:"�������",ENG:"Bag"},{RU:"�����������",ENG:"System"},{RU:"����",ENG:"Tank"},'+
            '{RU:"������",ENG:"Crisis"},{RU:"������",ENG:"Mass"},{RU:"�����������",ENG:"Dream"},{RU:"�������",ENG:"Future"},{RU:"��������",ENG:"Fate"},'+
            '{RU:"������",ENG:"Suit"},{RU:"�����������",ENG:"Doom"},{RU:"�����",ENG:"Word"},{RU:"����������",ENG:"Power"},{RU:"�����������",ENG:"Relative"},'+
            '{RU:"�������",ENG:"Machine"},{RU:"����",ENG:"Brain"},{RU:"����",ENG:"Horror"},{RU:"���",ENG:"Smoke"},{RU:"������",ENG:"Steel"}'+
        '],'+
        'last:['+
            '{RU:"�����������",ENG:"of Hospital"},{RU:"�������������",ENG:"of Betrayal"},{RU:"of Hell",ENG:"of Hell"},{RU:"����������",ENG:"of Bliss"},'+
            '{RU:"���� �����",ENG:"of Worlds"},{RU:"�������������",ENG:"of Misunderstanding"},{RU:"����������",ENG:"of Dungeons"},{RU:"�������������",ENG:"of Infinity"},'+
            '{RU:"�����",ENG:"of Forest"},{RU:"���������",ENG:"of Wealth"},{RU:"�������",ENG:"of Madness"},{RU:"������",ENG:"of Poverty"},'+
            '{RU:"����",ENG:"of Mistery"},{RU:"���������",ENG:"of Holiday"},{RU:"�������������",ENG:"of Hopeless"},{RU:"������",ENG:"of Despondency"},'+
            '{RU:"��������",ENG:"of Heroism"},{RU:"�����",ENG:"of Luck"},{RU:"���������",ENG:"of Deceit"},{RU:"�������",ENG:"of Replay"},'+
            '{RU:"��������",ENG:"of Agreement"},{RU:"������",ENG:"of Weapon"},{RU:"Crisis",ENG:"of �������"},{RU:"�����",ENG:"of Spring"},'+
            '{RU:"������",ENG:"of Heart"},{RU:"����",ENG:"of Body"},{RU:"�������",ENG:"of Girlfriend"},{RU:"�������",ENG:"of Childhood"},'+
            '{RU:"��������",ENG:"of Conscious"},{RU:"������������",ENG:"of Memory"},{RU:"���������",ENG:"of Support"},{RU:"������",ENG:"of Stars"},'+
            '{RU:"����",ENG:"of Essence"},{RU:"�����",ENG:"of Scene"},{RU:"��������",ENG:"of Doubt"},{RU:"�����",ENG:"of Risk"},'+
            '{RU:"����������",ENG:"of Reality"},{RU:"������",ENG:"of Guard"},{RU:"��������",ENG:"of Murders"},{RU:"����",ENG:"of Path"}'+
        ']'+
    '},'+
    '}';


var
    DIR_DATA :string;


implementation

initialization
    DIR_DATA := ExtractFilePath( paramstr(0) ) + 'DATA';

end.
