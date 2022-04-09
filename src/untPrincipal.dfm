object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'DFD - Delphi File Downloader [Fernando de Simas]'
  ClientHeight = 289
  ClientWidth = 564
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  DesignSize = (
    564
    289)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 16
    Top = 16
    Width = 531
    Height = 161
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    DesignSize = (
      531
      161)
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 23
      Height = 13
      Caption = 'URL:'
    end
    object Label2: TLabel
      Left = 16
      Top = 54
      Width = 99
      Height = 13
      Caption = 'Diret'#243'rio de Destino:'
    end
    object Label3: TLabel
      Left = 428
      Top = 8
      Width = 85
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Tipo de Download'
    end
    object editDownloadURL: TEdit
      Left = 16
      Top = 27
      Width = 405
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object btnDownload: TButton
      Left = 16
      Top = 100
      Width = 99
      Height = 25
      Action = actIniciarDownload
      Anchors = [akTop]
      Default = True
      TabOrder = 1
    end
    object edtCaminhoDownload: TEdit
      Left = 16
      Top = 73
      Width = 497
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      ReadOnly = True
      TabOrder = 2
    end
    object btnAlterarDiretorio: TButton
      Left = 376
      Top = 100
      Width = 141
      Height = 25
      Action = actAlterarDiretorioDownload
      Anchors = [akTop, akRight]
      TabOrder = 3
    end
    object cbTipoDownload: TComboBox
      Left = 427
      Top = 27
      Width = 90
      Height = 21
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ItemIndex = 0
      TabOrder = 4
      Text = 'HTTP'
      Items.Strings = (
        'HTTP'
        'FTP'
        'SSH')
    end
    object btnPararDownload: TButton
      Left = 121
      Top = 100
      Width = 101
      Height = 25
      Action = actPararDownload
      TabOrder = 5
    end
    object pgDownloadArquivo: TProgressBar
      Left = 16
      Top = 131
      Width = 497
      Height = 17
      Max = 0
      TabOrder = 6
    end
    object btnHistorico: TButton
      Left = 280
      Top = 100
      Width = 90
      Height = 25
      Action = actHistoricoDownload
      TabOrder = 7
    end
  end
  object memProgressoDownload: TMemo
    Left = 25
    Top = 191
    Width = 522
    Height = 88
    DoubleBuffered = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = []
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 1
  end
  object actDownload: TActionList
    Left = 496
    Top = 216
    object actIniciarDownload: TAction
      Caption = 'Iniciar Download'
      OnExecute = actIniciarDownloadExecute
      OnUpdate = actAlterarDiretorioDownloadUpdate
    end
    object actPararDownload: TAction
      Caption = 'Parar Download'
      OnExecute = actPararDownloadExecute
      OnUpdate = actPararDownloadUpdate
    end
    object actHistoricoDownload: TAction
      Caption = 'Hist'#243'rico'
      OnExecute = actHistoricoDownloadExecute
      OnUpdate = actAlterarDiretorioDownloadUpdate
    end
    object actAlterarDiretorioDownload: TAction
      Caption = 'Alterar Diretorio de Destino'
      OnExecute = actAlterarDiretorioDownloadExecute
      OnUpdate = actAlterarDiretorioDownloadUpdate
    end
  end
end
