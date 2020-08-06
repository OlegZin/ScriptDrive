object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Stupid roguelike: Torture tower 1.0'
  ClientHeight = 219
  ClientWidth = 686
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 686
    Height = 219
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 206
    object TabSheet1: TTabSheet
      Caption = 'Tower'
      ExplicitHeight = 178
      DesignSize = (
        678
        191)
      object lAutoCount: TLabel
        Left = 97
        Top = 34
        Width = 90
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'lAutoCount'
      end
      object lCreatureInfo: TLabel
        Left = 151
        Top = 80
        Width = 52
        Height = 13
        Caption = 'lPlayerInfo'
      end
      object lNeedExp: TLabel
        Left = 18
        Top = 61
        Width = 24
        Height = 13
        Caption = 'lStep'
      end
      object lPlayerInfo: TLabel
        Left = 151
        Top = 61
        Width = 52
        Height = 13
        Caption = 'lPlayerInfo'
      end
      object lStep: TLabel
        Left = 18
        Top = 80
        Width = 24
        Height = 13
        Caption = 'lStep'
      end
      object bAttack: TButton
        Left = 116
        Top = 8
        Width = 54
        Height = 25
        Caption = '      ATK  '
        TabOrder = 0
        OnClick = bAttackClick
      end
      object bUseItem: TButton
        Left = 377
        Top = 9
        Width = 33
        Height = 23
        Caption = 'Use!'
        TabOrder = 1
        OnClick = bUseItemClick
      end
      object bSkillUse: TButton
        Left = 583
        Top = 9
        Width = 33
        Height = 23
        Caption = 'Use!'
        TabOrder = 2
      end
      object Button1: TButton
        Left = 18
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Reset Tower'
        TabOrder = 3
        OnClick = Button1Click
      end
      object cbAutoAttack: TCheckBox
        Left = 120
        Top = 13
        Width = 13
        Height = 15
        TabOrder = 4
      end
      object cbItem: TComboBox
        Left = 200
        Top = 10
        Width = 177
        Height = 21
        Style = csDropDownList
        TabOrder = 5
      end
      object cbSkill: TComboBox
        Left = 416
        Top = 10
        Width = 167
        Height = 21
        Style = csDropDownList
        TabOrder = 6
      end
      object mLog: TMemo
        Left = 18
        Top = 120
        Width = 644
        Height = 68
        Anchors = [akLeft, akTop, akRight, akBottom]
        ReadOnly = True
        TabOrder = 7
      end
      object Button2: TButton
        Left = 415
        Top = 31
        Width = 201
        Height = 22
        Caption = 'Up! (0 EXP)'
        TabOrder = 8
      end
    end
    object Craft: TTabSheet
      Caption = 'Craft'
      ImageIndex = 1
      ExplicitHeight = 178
      DesignSize = (
        678
        191)
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
        Height = 164
        Anchors = [akLeft, akTop, akBottom]
        ItemHeight = 13
        TabOrder = 0
        ExplicitHeight = 151
      end
    end
  end
  object tAutoAttack: TTimer
    Interval = 100
    OnTimer = tAutoAttackTimer
    Left = 200
    Top = 64
  end
end
