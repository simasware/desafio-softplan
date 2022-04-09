object dmDadosDownloads: TdmDadosDownloads
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 332
  Width = 464
  object fdDownloadAPPDB: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\fernando.simas\Documents\Embarcadero\Studio\Pr' +
        'ojects\fileDownload\bin\downloadApp.db'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 48
    Top = 24
  end
  object tbLogDownload: TFDTable
    OnCalcFields = tbLogDownloadCalcFields
    IndexFieldNames = 'CODIGO:D'
    Connection = fdDownloadAPPDB
    TableName = 'LOGDOWNLOAD'
    Left = 48
    Top = 96
    object tbLogDownloadCODIGO: TFDAutoIncField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object tbLogDownloadURL: TStringField
      FieldName = 'URL'
      Origin = 'URL'
      Required = True
      Size = 600
    end
    object tbLogDownloadDATAINICIO: TDateTimeField
      FieldName = 'DATAINICIO'
      Origin = 'DATAINICIO'
      Required = True
      DisplayFormat = 'DD/MM/YYYY HH:NN:SS'
    end
    object tbLogDownloadDATAFIM: TDateTimeField
      FieldName = 'DATAFIM'
      Origin = 'DATAFIM'
      DisplayFormat = 'DD/MM/YYYY HH:NN:SS'
    end
    object tbLogDownloadSTATUSFINALIZACAO: TIntegerField
      FieldName = 'STATUSFINALIZACAO'
      Origin = 'STATUSFINALIZACAO'
    end
    object tbLogDownloadCAMINHOARQUIVO: TStringField
      FieldName = 'CAMINHOARQUIVO'
      Origin = 'CAMINHOARQUIVO'
      Size = 666
    end
    object tbLogDownloadstatusDescricao: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'statusDescricao'
      Size = 30
    end
    object tbLogDownloadtempoDecorrido: TDateTimeField
      FieldKind = fkInternalCalc
      FieldName = 'tempoDecorrido'
      DisplayFormat = 'HH:NN:SS'
    end
  end
end
