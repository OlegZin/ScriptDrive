object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Stupid roguelike: Torture tower 0.1 (techno demo)'
  ClientHeight = 223
  ClientWidth = 602
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pcGame: TPageControl
    Left = 0
    Top = 0
    Width = 602
    Height = 223
    ActivePage = pThink
    Align = alClient
    TabOrder = 0
    OnChange = pcGameChange
    object pTower: TTabSheet
      Caption = 'Tower'
      DesignSize = (
        594
        195)
      object lCreatureInfo: TLabel
        Left = 166
        Top = 68
        Width = 65
        Height = 13
        Caption = 'lCreatureInfo'
      end
      object lNeedExp: TLabel
        Left = 166
        Top = 37
        Width = 18
        Height = 13
        Caption = 'lLVL'
      end
      object lPlayerInfo: TLabel
        Left = 166
        Top = 53
        Width = 52
        Height = 13
        Caption = 'lPlayerInfo'
      end
      object lStep: TLabel
        Left = 3
        Top = 38
        Width = 24
        Height = 13
        Caption = 'lStep'
      end
      object lTopStep: TLabel
        Left = 3
        Top = 53
        Width = 42
        Height = 13
        Caption = 'lTopStep'
      end
      object lTarget: TLabel
        Left = 3
        Top = 68
        Width = 34
        Height = 13
        Caption = 'lTarget'
      end
      object lBuffs: TLabel
        Left = 390
        Top = 37
        Width = 27
        Height = 13
        Caption = 'lBuffs'
      end
      object bAttack: TButton
        Left = 92
        Top = 8
        Width = 54
        Height = 25
        Caption = '      ATK  '
        TabOrder = 0
        OnClick = bAttackClick
      end
      object bUseItem: TButton
        Left = 333
        Top = 9
        Width = 33
        Height = 23
        Caption = 'Use!'
        TabOrder = 1
        OnClick = bUseItemClick
      end
      object bSkillUse: TButton
        Left = 521
        Top = 9
        Width = 33
        Height = 23
        Caption = 'Use!'
        TabOrder = 2
        OnClick = bSkillUseClick
      end
      object bResetTower: TButton
        Left = 2
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Reset Tower'
        TabOrder = 3
        OnClick = bResetTowerClick
      end
      object cbAutoAttack: TCheckBox
        Left = 96
        Top = 14
        Width = 13
        Height = 13
        TabOrder = 4
        OnClick = cbAutoAttackClick
      end
      object cbItem: TComboBox
        Left = 165
        Top = 10
        Width = 168
        Height = 21
        Style = csDropDownList
        Sorted = True
        TabOrder = 5
      end
      object cbSkills: TComboBox
        Left = 390
        Top = 10
        Width = 131
        Height = 21
        Style = csDropDownList
        Sorted = True
        TabOrder = 6
      end
      object mLog: TMemo
        Left = 2
        Top = 87
        Width = 587
        Height = 105
        Anchors = [akLeft, akTop, akRight, akBottom]
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 7
      end
      object bUpSkill: TButton
        Left = 553
        Top = 9
        Width = 33
        Height = 23
        Caption = 'Up!'
        TabOrder = 8
        OnClick = bUpSkillClick
      end
    end
    object pThink: TTabSheet
      Caption = 'Think'
      ImageIndex = 2
      DesignSize = (
        594
        195)
      object bThink: TButton
        Left = 3
        Top = 3
        Width = 207
        Height = 25
        Caption = 'Think...'
        TabOrder = 0
        OnClick = bThinkClick
      end
      object cbAutoThink: TCheckBox
        Left = 10
        Top = 9
        Width = 13
        Height = 13
        TabOrder = 1
        OnClick = cbAutoThinkClick
      end
      object mThinkLog: TMemo
        Left = 216
        Top = 3
        Width = 375
        Height = 189
        Anchors = [akLeft, akTop, akRight, akBottom]
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 2
      end
      object lbThinkList: TListBox
        Left = 3
        Top = 34
        Width = 207
        Height = 158
        Anchors = [akLeft, akTop, akBottom]
        ItemHeight = 13
        TabOrder = 3
      end
    end
    object pCraft: TTabSheet
      Caption = 'Craft'
      ImageIndex = 1
      DesignSize = (
        594
        195)
      object Label1: TLabel
        Left = 6
        Top = 7
        Width = 50
        Height = 13
        Caption = 'Resources'
      end
      object lbLoot: TListBox
        Left = 3
        Top = 22
        Width = 134
        Height = 168
        Anchors = [akLeft, akTop, akBottom]
        ItemHeight = 13
        TabOrder = 0
      end
    end
  end
  object tAutoAttack: TTimer
    Interval = 100
    OnTimer = tAutoAttackTimer
    Left = 96
    Top = 176
  end
  object MainMenu1: TMainMenu
    Left = 28
    Top = 176
    object mmiLang: TMenuItem
      Caption = 'Lang'
      object mmiEng: TMenuItem
        Caption = 'Eng'
        Checked = True
        RadioItem = True
        OnClick = mmiEngClick
      end
      object mmiRus: TMenuItem
        Caption = 'Rus'
        RadioItem = True
        OnClick = mmiRusClick
      end
    end
    object mmiAuto: TMenuItem
      Caption = 'Auto: 1000'
      object mmiTowerAuto: TMenuItem
        Caption = 'Tower'
        OnClick = mmiTowerAutoClick
      end
      object mmiThinkAuto: TMenuItem
        Caption = 'Think'
        OnClick = mmiThinkAutoClick
      end
    end
  end
end
