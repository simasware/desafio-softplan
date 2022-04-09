unit uFTPDownload;

interface
  uses
    System.Classes, System.SysUtils, uIDownload, uResourceMessages,
    uIDownloadObserver;

type
  TFTPDownload = class(TInterfacedObject, IDownload)
    public
      function downloadArquivo(aURL: string; aDiretorioDestino: string): boolean;
      procedure adicionarObserver(observer: IDownloadObserver);
      procedure removerObserver(observer: IDownloadObserver);
      procedure notificar;
      procedure pararDownload;
      function downloadEmExecucao():boolean;
      procedure SetEvento(const aEvento: TNotificacaoDownload);
      function GetEvento: TNotificacaoDownload;
  end;
implementation

{ TFTPDownload }

procedure TFTPDownload.adicionarObserver(observer: IDownloadObserver);
begin
  raise Exception.Create(ePremiumFeature);
end;

function TFTPDownload.downloadArquivo(aURL, aDiretorioDestino: string): boolean;
begin
  raise Exception.Create(ePremiumFeature);
end;

function TFTPDownload.downloadEmExecucao: boolean;
begin
  result := false;
end;

function TFTPDownload.GetEvento: TNotificacaoDownload;
begin
  //
end;

procedure TFTPDownload.notificar;
begin
  raise Exception.Create(ePremiumFeature);
end;

procedure TFTPDownload.pararDownload;
begin
  raise Exception.Create(ePremiumFeature);
end;

procedure TFTPDownload.removerObserver(observer: IDownloadObserver);
begin
  raise Exception.Create(ePremiumFeature);
end;

procedure TFTPDownload.SetEvento(const aEvento: TNotificacaoDownload);
begin
  //
end;

end.
