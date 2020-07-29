object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 398
  ClientWidth = 600
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
    600
    398)
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
    Left = 16
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
    Caption = 'N G'
    TabOrder = 0
    OnClick = Button1Click
  end
  object mLog: TMemo
    Left = 16
    Top = 64
    Width = 566
    Height = 316
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
  object Button3: TButton
    Left = 176
    Top = 8
    Width = 41
    Height = 25
    Caption = 'ATK'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 95
    Top = 8
    Width = 41
    Height = 25
    Caption = 'DNG'
    TabOrder = 4
    OnClick = Button4Click
  end
end
