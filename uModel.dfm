object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Stupid roguelike: Torture tower 1.0'
  ClientHeight = 202
  ClientWidth = 606
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    606
    202)
  PixelsPerInch = 96
  TextHeight = 13
  object lPlayerInfo: TLabel
    Left = 95
    Top = 45
    Width = 52
    Height = 13
    Caption = 'lPlayerInfo'
  end
  object lStep: TLabel
    Left = 18
    Top = 64
    Width = 24
    Height = 13
    Caption = 'lStep'
  end
  object lCreatureInfo: TLabel
    Left = 95
    Top = 64
    Width = 52
    Height = 13
    Caption = 'lPlayerInfo'
  end
  object lNeedExp: TLabel
    Left = 18
    Top = 45
    Width = 24
    Height = 13
    Caption = 'lStep'
  end
  object Button1: TButton
    Left = 48
    Top = 8
    Width = 41
    Height = 25
    Caption = 'NewG'
    TabOrder = 0
    OnClick = Button1Click
  end
  object mLog: TMemo
    Left = 16
    Top = 96
    Width = 572
    Height = 88
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    TabOrder = 1
  end
  object Button2: TButton
    Left = 16
    Top = 8
    Width = 26
    Height = 25
    Caption = 'X'
    TabOrder = 2
    OnClick = Button2Click
  end
  object bAttack: TButton
    Left = 107
    Top = 8
    Width = 54
    Height = 25
    Caption = '      ATK  '
    TabOrder = 3
    OnClick = bAttackClick
  end
  object cbItem: TComboBox
    Left = 176
    Top = 10
    Width = 177
    Height = 21
    Style = csDropDownList
    TabOrder = 4
  end
  object bItemUse: TButton
    Left = 353
    Top = 8
    Width = 33
    Height = 25
    Caption = 'Use!'
    TabOrder = 5
    OnClick = bItemUseClick
  end
  object cbSkill: TComboBox
    Left = 392
    Top = 10
    Width = 167
    Height = 21
    Style = csDropDownList
    TabOrder = 6
  end
  object bSkillUse: TButton
    Left = 559
    Top = 8
    Width = 33
    Height = 25
    Caption = 'Use!'
    TabOrder = 7
  end
  object cbAutoAttack: TCheckBox
    Left = 110
    Top = 13
    Width = 13
    Height = 15
    TabOrder = 8
  end
  object tAutoAttack: TTimer
    Interval = 100
    OnTimer = tAutoAttackTimer
    Left = 560
    Top = 40
  end
end
