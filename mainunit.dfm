object mainform: Tmainform
  Left = 462
  Top = 126
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Counter Strike Monitor - Main'
  ClientHeight = 499
  ClientWidth = 668
  Color = 4479052
  Font.Charset = DEFAULT_CHARSET
  Font.Color = 10529429
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnMouseDown = FormMouseDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 668
    Height = 499
    Align = alClient
    Color = 4479052
    TabOrder = 0
    DesignSize = (
      668
      499)
    object Label5: TLabel
      Left = 340
      Top = 36
      Width = 45
      Height = 13
      Caption = 'Favorites'
    end
    object Label6: TLabel
      Left = 25
      Top = 151
      Width = 73
      Height = 13
      Caption = 'Highlight maps:'
    end
    object lb: TListBox
      Left = 340
      Top = 55
      Width = 307
      Height = 424
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelKind = bkFlat
      BorderStyle = bsNone
      Color = 3622462
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10529429
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 0
      OnDblClick = lbDblClick
    end
    object Panel2: TPanel
      Left = 25
      Top = 35
      Width = 291
      Height = 106
      Color = 4479052
      TabOrder = 1
      object Label1: TLabel
        Left = 15
        Top = 15
        Width = 75
        Height = 13
        Caption = 'Host name / IP:'
      end
      object Label2: TLabel
        Left = 190
        Top = 15
        Width = 24
        Height = 13
        Caption = 'Port:'
      end
      object Label3: TLabel
        Left = 15
        Top = 55
        Width = 86
        Height = 13
        Caption = 'Checking interval:'
      end
      object Label4: TLabel
        Left = 65
        Top = 75
        Width = 13
        Height = 13
        Caption = 'ms'
      end
      object sb1: TSpeedButton
        Left = 210
        Top = 70
        Width = 71
        Height = 22
        Caption = 'Go'
        Flat = True
        OnClick = goClick
      end
      object host: TEdit
        Left = 15
        Top = 30
        Width = 166
        Height = 21
        BevelInner = bvSpace
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = 3622462
        TabOrder = 0
        Text = 'flower.sth.sze.hu'
      end
      object port: TEdit
        Left = 190
        Top = 30
        Width = 91
        Height = 21
        BevelInner = bvSpace
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = 3622462
        TabOrder = 1
        Text = '27015'
      end
      object int: TEdit
        Left = 15
        Top = 70
        Width = 46
        Height = 21
        BevelInner = bvSpace
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = 3622462
        TabOrder = 2
        Text = '2000'
      end
    end
    object Panel3: TPanel
      Left = 641
      Top = 5
      Width = 21
      Height = 21
      Anchors = [akTop, akRight]
      Caption = 'r'
      Color = 4479052
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10529429
      Font.Height = -13
      Font.Name = 'Webdings'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = Panel3Click
      OnMouseDown = Panel3MouseDown
      OnMouseUp = Panel3MouseUp
    end
    object Panel4: TPanel
      Left = 616
      Top = 5
      Width = 21
      Height = 21
      Anchors = [akTop, akRight]
      Caption = '_'
      Color = 4479052
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10529429
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = goClick
      OnMouseDown = Panel3MouseDown
      OnMouseUp = Panel3MouseUp
    end
    object Panel5: TPanel
      Left = 5
      Top = 5
      Width = 281
      Height = 21
      BevelOuter = bvNone
      Color = 4479052
      TabOrder = 4
      OnMouseDown = Panel5MouseDown
      OnMouseMove = Panel5MouseMove
      OnMouseUp = Panel5MouseUp
      object topic: TLabel
        Left = 5
        Top = 1
        Width = 129
        Height = 16
        Caption = 'Counter Strike Monitor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnMouseDown = Panel5MouseDown
        OnMouseMove = Panel5MouseMove
        OnMouseUp = Panel5MouseUp
      end
    end
    object mmaps: TMemo
      Left = 25
      Top = 175
      Width = 291
      Height = 305
      Anchors = [akLeft, akTop, akBottom]
      BevelKind = bkFlat
      BorderStyle = bsNone
      Color = 3622462
      Lines.Strings = (
        'de_aztec'
        'de_cpl_fire'
        'cs_italy'
        'scoutzknivez'
        'de_nuke')
      TabOrder = 5
    end
  end
  object tt: TTextTrayIcon
    CycleInterval = 0
    Hint = '-'
    Icon.Data = {
      0000010001001010040000000000280100001600000028000000100000002000
      0000010004000000000080000000000000000000000000000000000000000000
      000000008000008000000080800080000000800080008080000080808000C0C0
      C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF008888
      8888888888888888888888888888888888888888888880000008880000088880
      0888800888008880088880088800888008888008880088800888800888008880
      0888800000088880088880088888800008888800888888800888888000088888
      8888888888888888888888888888888888888888888888888888888888880000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000}
    IconVisible = True
    IconIndex = 0
    PopupMenu = pm
    MinimizeToTray = True
    OnDblClick = ttClick
    Text = '16'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    Border = False
    Options.OffsetX = 0
    Options.OffsetY = 0
    Options.LineDistance = 0
    Left = 400
    Top = 5
  end
  object t: TTimer
    Enabled = False
    OnTimer = timertick
    Left = 340
    Top = 5
  end
  object pm: TPopupMenu
    Left = 370
    Top = 5
  end
end
