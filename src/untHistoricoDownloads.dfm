object frmHistorico: TfrmHistorico
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Hist'#243'rico de Downloads'
  ClientHeight = 447
  ClientWidth = 782
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 782
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitLeft = 216
    ExplicitTop = 104
    ExplicitWidth = 185
    DesignSize = (
      782
      41)
    object Label1: TLabel
      Left = 537
      Top = 6
      Width = 228
      Height = 23
      Alignment = taRightJustify
      Anchors = [akTop]
      Caption = 'Hist'#243'rico de Downloads'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 406
    Width = 782
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitLeft = 320
    ExplicitTop = 144
    ExplicitWidth = 185
    object Button1: TButton
      Left = 690
      Top = 9
      Width = 75
      Height = 25
      Caption = '&Fechar'
      ModalResult = 8
      TabOrder = 0
    end
  end
  object gridHistorico: TDBCtrlGrid
    Left = 0
    Top = 41
    Width = 782
    Height = 365
    Align = alClient
    AllowDelete = False
    AllowInsert = False
    DataSource = dsHistoricoDownload
    PanelHeight = 121
    PanelWidth = 765
    TabOrder = 2
    SelectedColor = clWhite
    ExplicitTop = 44
    object Label2: TLabel
      Left = 19
      Top = 8
      Width = 25
      Height = 13
      Caption = 'URL:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText1: TDBText
      Left = 19
      Top = 27
      Width = 558
      Height = 17
      DataField = 'URL'
      DataSource = dsHistoricoDownload
    end
    object Label3: TLabel
      Left = 19
      Top = 82
      Width = 61
      Height = 13
      Caption = 'Data In'#237'cio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText2: TDBText
      Left = 19
      Top = 101
      Width = 121
      Height = 17
      DataField = 'DATAINICIO'
      DataSource = dsHistoricoDownload
    end
    object Label4: TLabel
      Left = 146
      Top = 82
      Width = 50
      Height = 13
      Caption = 'Data Fim'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText3: TDBText
      Left = 146
      Top = 101
      Width = 121
      Height = 17
      DataField = 'DATAFIM'
      DataSource = dsHistoricoDownload
    end
    object Label5: TLabel
      Left = 19
      Top = 42
      Width = 113
      Height = 13
      Caption = 'Caminho do Arquivo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText4: TDBText
      Left = 19
      Top = 62
      Width = 391
      Height = 17
      DataField = 'CAMINHOARQUIVO'
      DataSource = dsHistoricoDownload
    end
    object Label6: TLabel
      Left = 627
      Top = 8
      Width = 37
      Height = 13
      Caption = 'Status'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText5: TDBText
      Left = 627
      Top = 27
      Width = 121
      Height = 17
      DataField = 'statusDescricao'
      DataSource = dsHistoricoDownload
    end
    object Label7: TLabel
      Left = 273
      Top = 82
      Width = 97
      Height = 13
      Caption = 'Tempo Decorrido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText6: TDBText
      Left = 273
      Top = 101
      Width = 121
      Height = 17
      DataField = 'tempoDecorrido'
      DataSource = dsHistoricoDownload
    end
  end
  object dsHistoricoDownload: TDataSource
    DataSet = dmDadosDownloads.tbLogDownload
    Left = 16
    Top = 352
  end
end
