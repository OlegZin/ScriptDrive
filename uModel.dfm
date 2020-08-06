object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Stupid roguelike: Torture tower 1.0'
  ClientHeight = 186
  ClientWidth = 597
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
    Width = 597
    Height = 186
    ActivePage = pTower
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 686
    ExplicitHeight = 219
    object pTower: TTabSheet
      Caption = 'Tower'
      ExplicitLeft = 8
      ExplicitTop = 28
      ExplicitWidth = 610
      ExplicitHeight = 191
      DesignSize = (
        589
        158)
      object lAutoCount: TLabel
        Left = 73
        Top = 38
        Width = 90
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'lAutoCount'
      end
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
      object Button1: TButton
        Left = 2
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Reset Tower'
        TabOrder = 3
        OnClick = Button1Click
      end
      object cbAutoAttack: TCheckBox
        Left = 96
        Top = 13
        Width = 13
        Height = 15
        TabOrder = 4
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
        Width = 582
        Height = 68
        Anchors = [akLeft, akTop, akRight, akBottom]
        ReadOnly = True
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
    object pCraft: TTabSheet
      Caption = 'Craft'
      ImageIndex = 1
      ExplicitWidth = 678
      ExplicitHeight = 191
      DesignSize = (
        589
        158)
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
        Height = 131
        Anchors = [akLeft, akTop, akBottom]
        ItemHeight = 13
        TabOrder = 0
        ExplicitHeight = 164
      end
    end
  end
  object tAutoAttack: TTimer
    Interval = 100
    OnTimer = tAutoAttackTimer
    Left = 16
    Top = 120
  end
  object MainMenu1: TMainMenu
    Left = 76
    Top = 120
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
  end
end
