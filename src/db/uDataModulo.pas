unit uDataModulo;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TdmDadosDownloads = class(TDataModule)
    fdDownloadAPPDB: TFDConnection;
    tbLogDownload: TFDTable;
    tbLogDownloadstatusDescricao: TStringField;
    tbLogDownloadCODIGO: TFDAutoIncField;
    tbLogDownloadURL: TStringField;
    tbLogDownloadDATAINICIO: TDateTimeField;
    tbLogDownloadDATAFIM: TDateTimeField;
    tbLogDownloadSTATUSFINALIZACAO: TIntegerField;
    tbLogDownloadCAMINHOARQUIVO: TStringField;
    tbLogDownloadtempoDecorrido: TDateTimeField;
    procedure tbLogDownloadCalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmDadosDownloads: TdmDadosDownloads;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmDadosDownloads.DataModuleCreate(Sender: TObject);
begin
  fdDownloadAPPDB.Connected := true;
end;

procedure TdmDadosDownloads.tbLogDownloadCalcFields(DataSet: TDataSet);
begin
  case dataSet.FieldByName('STATUSFINALIZACAO').AsInteger of
    1: dataSet.FieldByName('statusDescricao').asString := 'Sucesso';
    2: dataSet.FieldByName('statusDescricao').asString := 'Abortado';
    3: dataSet.FieldByName('statusDescricao').asString := 'Falha';
  end;
  dataset.FieldByName('tempoDecorrido').AsDateTime :=
    dataSet.FieldByName('DATAFIM').AsDateTime -
    dataSet.FieldByName('DATAINICIO').AsDateTime;
end;

end.
