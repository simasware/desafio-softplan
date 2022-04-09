unit uIDownloadObserver;

interface
  uses
    System.Classes, System.SysUtils, VCL.StdCtrls, Vcl.ComCtrls;

type
  TProgressoDownload = record
    percentualDownload: double;
    tamanhoArquivo: double;
    totalBaixado: double;
  end;

type
  IDownloadObserver = interface
    procedure atualizarProgresso(progressoDownload: TProgressoDownload);
end;

type
  IObservavel = interface
    procedure adicionarObserver(observer: IDownloadObserver);
    procedure removerObserver(observer: IDownloadObserver);
    procedure notificar;
end;

type
  TDownloadMemoObserver = class(TInterfacedObject, IDownloadObserver)
    private
      FMemoDownload: TMemo;
    public
      procedure atualizarProgresso(progressoDownload: TProgressoDownload);
      property MemoDownload: TMemo read FMemoDownload write FMemoDownload;
  end;

type
  TDownloadProgressObserver = class(TInterfacedObject, IDownloadObserver)
    private
      FProgressBar: TProgressBar;
    public
      procedure atualizarProgresso(progressoDownload: TProgressoDownload);
      property ProgressBar: TProgressBar read FProgressBar write FProgressBar;
  end;


implementation

{ TDownloadProgressBarObserver }

procedure TDownloadMemoObserver.atualizarProgresso(
  progressoDownload: TProgressoDownload);
var
  statusDownload: TStrings;
begin
  if not Assigned(self.FMemoDownload) then
    exit;

  statusDownload := TStringList.Create;

  statusDownload.Add(format('Tamanho do arquivo: %2.f MB', [progressoDownload.tamanhoArquivo]));
  statusDownload.Add(format('Total baixado     : %2.f MB', [progressoDownload.totalBaixado]));
  statusDownload.Add(format('Percentual baixado: %2.f %%', [progressoDownload.percentualDownload]));
  self.FMemoDownload.Lines.text := statusDownload.Text;
  statusDownload.Free;
end;

{ TDownloadProgressObserver }

procedure TDownloadProgressObserver.atualizarProgresso(
  progressoDownload: TProgressoDownload);
begin
  if not Assigned(self.FProgressBar) then
    exit;

  if self.FProgressBar.Max = 0 then
    self.FProgressBar.Max := round(progressoDownload.tamanhoArquivo);
  self.ProgressBar.Position := round(progressoDownload.totalBaixado);
end;

end.
