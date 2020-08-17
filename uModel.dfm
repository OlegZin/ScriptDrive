object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Stupid roguelike: Torture Tower v0.2'
  ClientHeight = 302
  ClientWidth = 641
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label7: TLabel
    Left = 22
    Top = 51
    Width = 39
    Height = 13
    Caption = 'InWork:'
  end
  object pcGame: TPageControl
    Left = 0
    Top = 0
    Width = 641
    Height = 302
    ActivePage = pFloors
    Align = alClient
    TabOrder = 0
    OnChange = pcGameChange
    object pTower: TTabSheet
      Caption = 'Tower'
      ExplicitWidth = 594
      ExplicitHeight = 192
      DesignSize = (
        633
        274)
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
        Width = 626
        Height = 184
        Anchors = [akLeft, akTop, akRight, akBottom]
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 7
        ExplicitWidth = 587
        ExplicitHeight = 102
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
      ExplicitWidth = 594
      ExplicitHeight = 192
      DesignSize = (
        633
        274)
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
      end
      object mThinkLog: TMemo
        Left = 216
        Top = 3
        Width = 414
        Height = 268
        Anchors = [akLeft, akTop, akRight, akBottom]
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 2
        ExplicitWidth = 375
        ExplicitHeight = 186
      end
      object lbThinkList: TListBox
        Left = 3
        Top = 56
        Width = 207
        Height = 215
        Anchors = [akLeft, akTop, akBottom]
        ItemHeight = 13
        TabOrder = 3
        OnClick = lbThinkListClick
        ExplicitHeight = 133
      end
      object ComboBox1: TComboBox
        Left = 3
        Top = 31
        Width = 207
        Height = 21
        Style = csDropDownList
        Enabled = False
        Sorted = True
        TabOrder = 4
      end
    end
    object pFloors: TTabSheet
      Caption = 'Floor: 1'
      ImageIndex = 4
      ExplicitWidth = 594
      ExplicitHeight = 192
      object mFloorLog: TMemo
        Left = 0
        Top = 216
        Width = 633
        Height = 58
        Align = alBottom
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object pnlFloor: TPanel
        Left = 0
        Top = 0
        Width = 633
        Height = 216
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitLeft = 296
        ExplicitTop = 80
        ExplicitWidth = 185
        ExplicitHeight = 41
      end
    end
    object pCraft: TTabSheet
      Caption = 'Craft'
      ImageIndex = 1
      ExplicitLeft = 8
      ExplicitTop = 28
      ExplicitWidth = 594
      ExplicitHeight = 192
      object lbLoot: TListBox
        Left = 0
        Top = 0
        Width = 137
        Height = 274
        Align = alLeft
        ItemHeight = 13
        TabOrder = 0
        ExplicitTop = 25
        ExplicitHeight = 265
      end
      object Panel2: TPanel
        Left = 137
        Top = 0
        Width = 496
        Height = 274
        Align = alClient
        Caption = 'Panel2'
        TabOrder = 1
        ExplicitLeft = 40
        ExplicitTop = 56
        ExplicitWidth = 185
        ExplicitHeight = 89
        object pcCraft: TPageControl
          Left = 1
          Top = 1
          Width = 494
          Height = 200
          ActivePage = pResourceResearch
          Align = alClient
          TabOrder = 0
          object pCraftPotions: TTabSheet
            Caption = 'Potions Research'
            ExplicitLeft = 5
            ExplicitTop = 22
            ExplicitWidth = 447
            ExplicitHeight = 163
            object Label1: TLabel
              Left = 36
              Top = 54
              Width = 39
              Height = 13
              Caption = 'InWork:'
            end
            object Label2: TLabel
              Left = 82
              Top = 54
              Width = 36
              Height = 13
              Caption = 'Potion'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label3: TLabel
              Left = 21
              Top = 93
              Width = 12
              Height = 13
              Caption = '1)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label4: TLabel
              Left = 250
              Top = 130
              Width = 12
              Height = 13
              Caption = '4)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label5: TLabel
              Left = 20
              Top = 130
              Width = 12
              Height = 13
              Caption = '2)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label6: TLabel
              Left = 250
              Top = 93
              Width = 12
              Height = 13
              Caption = '3)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label8: TLabel
              Left = 266
              Top = 54
              Width = 46
              Height = 13
              Caption = 'Progress:'
            end
            object Label9: TLabel
              Left = 322
              Top = 54
              Width = 47
              Height = 13
              Caption = '0 / 1000'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object cbPotionSelect: TComboBox
              Left = 35
              Top = 20
              Width = 193
              Height = 21
              Style = csDropDownList
              TabOrder = 0
            end
            object bPotionResearch: TButton
              Left = 305
              Top = 18
              Width = 145
              Height = 25
              Caption = 'Research'
              TabOrder = 1
            end
            object cbPotionPart1: TComboBox
              Left = 37
              Top = 89
              Width = 129
              Height = 21
              Style = csDropDownList
              TabOrder = 2
            end
            object cbPotionPart1Count: TComboBox
              Left = 172
              Top = 89
              Width = 50
              Height = 21
              Style = csDropDownList
              TabOrder = 3
              Items.Strings = (
                '1'
                '2'
                '3'
                '4'
                '5'
                '6'
                '7'
                '8'
                '9'
                '10')
            end
            object ComboBox3: TComboBox
              Left = 266
              Top = 126
              Width = 129
              Height = 21
              Style = csDropDownList
              TabOrder = 4
            end
            object ComboBox4: TComboBox
              Left = 401
              Top = 126
              Width = 50
              Height = 21
              Style = csDropDownList
              TabOrder = 5
              Items.Strings = (
                '1'
                '2'
                '3'
                '4'
                '5'
                '6'
                '7'
                '8'
                '9'
                '10')
            end
            object ComboBox5: TComboBox
              Left = 36
              Top = 126
              Width = 129
              Height = 21
              Style = csDropDownList
              TabOrder = 6
            end
            object ComboBox6: TComboBox
              Left = 171
              Top = 126
              Width = 50
              Height = 21
              Style = csDropDownList
              TabOrder = 7
              Items.Strings = (
                '1'
                '2'
                '3'
                '4'
                '5'
                '6'
                '7'
                '8'
                '9'
                '10')
            end
            object ComboBox7: TComboBox
              Left = 266
              Top = 89
              Width = 129
              Height = 21
              Style = csDropDownList
              TabOrder = 8
            end
            object ComboBox8: TComboBox
              Left = 401
              Top = 89
              Width = 50
              Height = 21
              Style = csDropDownList
              TabOrder = 9
              Items.Strings = (
                '1'
                '2'
                '3'
                '4'
                '5'
                '6'
                '7'
                '8'
                '9'
                '10')
            end
          end
          object pResourceResearch: TTabSheet
            Caption = 'Resource Research'
            ImageIndex = 1
            ExplicitWidth = 447
            ExplicitHeight = 163
            object Label10: TLabel
              Left = 36
              Top = 54
              Width = 39
              Height = 13
              Caption = 'InWork:'
            end
            object Label11: TLabel
              Left = 82
              Top = 54
              Width = 36
              Height = 13
              Caption = 'Potion'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label12: TLabel
              Left = 338
              Top = 54
              Width = 46
              Height = 13
              Caption = 'Progress:'
            end
            object Label13: TLabel
              Left = 394
              Top = 54
              Width = 47
              Height = 13
              Caption = '0 / 1000'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label14: TLabel
              Left = 224
              Top = 54
              Width = 34
              Height = 13
              Caption = '100%'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label15: TLabel
              Left = 175
              Top = 54
              Width = 40
              Height = 13
              Caption = 'Chanse:'
            end
            object SpeedButton1: TSpeedButton
              Left = 266
              Top = 51
              Width = 20
              Height = 19
              Caption = '+'
            end
            object Label16: TLabel
              Left = 38
              Top = 96
              Width = 42
              Height = 13
              Caption = 'Effect 1'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label17: TLabel
              Left = 38
              Top = 118
              Width = 42
              Height = 13
              Caption = 'Effect 1'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label18: TLabel
              Left = 38
              Top = 140
              Width = 42
              Height = 13
              Caption = 'Effect 1'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label19: TLabel
              Left = 237
              Top = 96
              Width = 42
              Height = 13
              Caption = 'Effect 1'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label20: TLabel
              Left = 237
              Top = 118
              Width = 42
              Height = 13
              Caption = 'Effect 1'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label21: TLabel
              Left = 237
              Top = 140
              Width = 42
              Height = 13
              Caption = 'Effect 1'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object ComboBox9: TComboBox
              Left = 35
              Top = 20
              Width = 193
              Height = 21
              Style = csDropDownList
              TabOrder = 0
            end
            object Button1: TButton
              Left = 305
              Top = 18
              Width = 145
              Height = 25
              Caption = 'Research'
              TabOrder = 1
            end
          end
        end
        object Memo1: TMemo
          Left = 1
          Top = 201
          Width = 494
          Height = 72
          Align = alBottom
          Lines.Strings = (
            'Memo1')
          ReadOnly = True
          TabOrder = 1
          ExplicitTop = 192
          ExplicitWidth = 439
        end
      end
    end
    object pSecrets: TTabSheet
      Caption = 'Secrets'
      ImageIndex = 3
      ExplicitWidth = 594
      ExplicitHeight = 192
      object mSecrets: TMemo
        Left = 0
        Top = 0
        Width = 633
        Height = 274
        Align = alClient
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
        ExplicitWidth = 594
        ExplicitHeight = 192
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
    end
  end
end
