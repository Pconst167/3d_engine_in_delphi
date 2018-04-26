object fmain: Tfmain
  Left = 303
  Top = 200
  Width = 798
  Height = 570
  Caption = 'fmain'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 465
    Top = 0
    Width = 9
    Height = 357
    Align = alRight
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 357
    Width = 790
    Height = 148
    Align = alBottom
    Caption = 'v'
    TabOrder = 0
    object Label1: TLabel
      Left = 576
      Top = 16
      Width = 113
      Height = 13
      Caption = 'Distance Camera/Plane'
    end
    object Label2: TLabel
      Left = 576
      Top = 80
      Width = 70
      Height = 13
      Caption = 'Angle of Vision'
    end
    object Label3: TLabel
      Left = 736
      Top = 16
      Width = 31
      Height = 13
      Caption = 'Speed'
    end
    object Label4: TLabel
      Left = 736
      Top = 80
      Width = 105
      Height = 13
      Caption = 'Max Viewing Distance'
    end
    object Label7: TLabel
      Left = 192
      Top = 72
      Width = 3
      Height = 13
    end
    object LabeledEdit1: TLabeledEdit
      Left = 16
      Top = 40
      Width = 120
      Height = 21
      EditLabel.Width = 110
      EditLabel.Height = 13
      EditLabel.Caption = 'Camera Position Vector'
      ReadOnly = True
      TabOrder = 0
    end
    object LabeledEdit2: TLabeledEdit
      Left = 16
      Top = 88
      Width = 120
      Height = 21
      EditLabel.Width = 71
      EditLabel.Height = 13
      EditLabel.Caption = 'Camera Angles'
      TabOrder = 1
    end
    object LabeledEdit3: TLabeledEdit
      Left = 144
      Top = 40
      Width = 120
      Height = 21
      EditLabel.Width = 62
      EditLabel.Height = 13
      EditLabel.Caption = 'Vision Vector'
      TabOrder = 2
    end
    object LabeledEdit4: TLabeledEdit
      Left = 272
      Top = 40
      Width = 120
      Height = 21
      EditLabel.Width = 122
      EditLabel.Height = 13
      EditLabel.Caption = 'Projection Plane Normal 1'
      TabOrder = 3
    end
    object LabeledEdit5: TLabeledEdit
      Left = 272
      Top = 88
      Width = 120
      Height = 21
      EditLabel.Width = 122
      EditLabel.Height = 13
      EditLabel.Caption = 'Projection Plane Normal 2'
      TabOrder = 4
    end
    object CheckBox1: TCheckBox
      Left = 424
      Top = 40
      Width = 97
      Height = 17
      Caption = 'Use Mouse'
      TabOrder = 5
    end
    object TrackBar1: TTrackBar
      Left = 568
      Top = 32
      Width = 150
      Height = 45
      Max = 100
      Position = 50
      TabOrder = 6
    end
    object TrackBar2: TTrackBar
      Left = 728
      Top = 32
      Width = 150
      Height = 45
      Position = 3
      TabOrder = 7
    end
    object TrackBar3: TTrackBar
      Left = 568
      Top = 96
      Width = 150
      Height = 45
      Max = 360
      Position = 90
      TabOrder = 8
    end
    object TrackBar4: TTrackBar
      Left = 728
      Top = 96
      Width = 150
      Height = 45
      Max = 100000
      Position = 100000
      TabOrder = 9
    end
  end
  object GroupBox2: TGroupBox
    Left = 474
    Top = 0
    Width = 316
    Height = 357
    Align = alRight
    TabOrder = 1
    object GroupBox5: TGroupBox
      Left = 2
      Top = 15
      Width = 312
      Height = 340
      Align = alClient
      Caption = 'Map XY'
      TabOrder = 0
      object mapxy: TPaintBox
        Left = 2
        Top = 15
        Width = 308
        Height = 323
        Align = alClient
      end
    end
  end
  object GroupBox4: TGroupBox
    Left = 0
    Top = 0
    Width = 465
    Height = 357
    Align = alClient
    TabOrder = 2
    object fscreen: TPaintBox
      Left = 2
      Top = 15
      Width = 461
      Height = 340
      Align = alClient
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 505
    Width = 790
    Height = 19
    Panels = <
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 50
      end>
  end
  object MainMenu1: TMainMenu
    Left = 136
    Top = 56
    object File1: TMenuItem
      Caption = 'File'
      object Reset1: TMenuItem
        Caption = 'Reset'
      end
      object OpenMap1: TMenuItem
        Caption = 'Open Map'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object About1: TMenuItem
      Caption = 'About'
    end
  end
end
