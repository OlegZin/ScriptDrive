object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Stupid roguelike: Torture tower 1.0'
  ClientHeight = 233
  ClientWidth = 744
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
    744
    233)
  PixelsPerInch = 96
  TextHeight = 13
  object lPlayerInfo: TLabel
    Left = 119
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
  object lCreatureInfo: TLabel
    Left = 119
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
  object lAutoCount: TLabel
    Left = 80
    Top = 34
    Width = 90
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'lAutoCount'
  end
  object Button1: TButton
    Left = 18
    Top = 8
    Width = 63
    Height = 25
    Caption = 'NewGame'
    TabOrder = 0
    OnClick = Button1Click
  end
  object mLog: TMemo
    Left = 16
    Top = 112
    Width = 576
    Height = 103
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    TabOrder = 1
  end
  object bAttack: TButton
    Left = 99
    Top = 8
    Width = 54
    Height = 25
    Caption = '      ATK  '
    TabOrder = 2
    OnClick = bAttackClick
  end
  object cbItem: TComboBox
    Left = 176
    Top = 10
    Width = 177
    Height = 21
    Style = csDropDownList
    TabOrder = 3
  end
  object bItemUse: TButton
    Left = 353
    Top = 8
    Width = 33
    Height = 25
    Caption = 'Use!'
    TabOrder = 4
    OnClick = bItemUseClick
  end
  object cbSkill: TComboBox
    Left = 392
    Top = 10
    Width = 167
    Height = 21
    Style = csDropDownList
    TabOrder = 5
  end
  object bSkillUse: TButton
    Left = 559
    Top = 8
    Width = 33
    Height = 25
    Caption = 'Use!'
    TabOrder = 6
  end
  object cbAutoAttack: TCheckBox
    Left = 103
    Top = 13
    Width = 13
    Height = 15
    TabOrder = 7
  end
  object lbLoot: TListBox
    Left = 598
    Top = 8
    Width = 138
    Height = 207
    ItemHeight = 13
    TabOrder = 8
  end
  object tAutoAttack: TTimer
    Interval = 100
    OnTimer = tAutoAttackTimer
    Left = 560
    Top = 40
  end
end
