unit uSSHDownload;

interface
  uses
    System.Classes, System.SysUtils, uIDownload, uResourceMessages,
    uIDownloadObserver;

type
  TSSHDownload = class(TInterfacedObject, IDownload)
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

procedure TSSHDownload.adicionarObserver(observer: IDownloadObserver);
begin
  raise Exception.Create(ePremiumFeature);
end;

function TSSHDownload.downloadArquivo(aURL, aDiretorioDestino: string): boolean;
begin
  raise Exception.Create(ePremiumFeature);
end;

function TSSHDownload.downloadEmExecucao: boolean;
begin
  result := false;
end;

function TSSHDownload.GetEvento: TNotificacaoDownload;
begin
  //
end;

procedure TSSHDownload.notificar;
begin
  raise Exception.Create(ePremiumFeature);
end;

procedure TSSHDownload.pararDownload;
begin
  raise Exception.Create(ePremiumFeature);
end;

procedure TSSHDownload.removerObserver(observer: IDownloadObserver);
begin
  raise Exception.Create(ePremiumFeature);
end;

procedure TSSHDownload.SetEvento(const aEvento: TNotificacaoDownload);
begin
  //
end;

end.
