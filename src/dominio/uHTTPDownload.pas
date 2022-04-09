unit uHTTPDownload;

interface
  uses
    System.Classes, uIDownload, uIDownloadObserver, IdHTTP, idComponent,
    System.RegularExpressions, System.SysUtils, System.Net.HttpClient,
    System.Generics.Collections;

type
  THTTPDownload = class(TInterfacedObject, IDownload, IObservavel)
    private
      FDownloadAtivo: boolean;
      FTHTTPClient: THTTPClient;
      FObservers: TList<IDownloadObserver>;
      FProgressoDownload: TProgressoDownload;
      FEventoDownload: TNotificacaoDownload;
      FDownloadInfo: TDownloadInfo;
      procedure SetEvento(const aEvento: TNotificacaoDownload);
      function GetEvento: TNotificacaoDownload;
      procedure onReceiveDataEvent(const Sender: TObject; AContentLength: Int64; AReadCount: Int64; var AAbort: Boolean);
    public
      constructor Create;
      destructor Destroy;override;
      function downloadArquivo(aURL: string; aDiretorioDestino: string): boolean;
      procedure adicionarObserver(observer: IDownloadObserver);
      procedure removerObserver(observer: IDownloadObserver);
      procedure notificar;
      procedure pararDownload;
      function downloadEmExecucao():boolean;
  end;
implementation

{ THTTPDownload }

uses uResourceMessages;

procedure THTTPDownload.adicionarObserver(observer: IDownloadObserver);
begin
  self.FObservers.Add(observer);
end;

constructor THTTPDownload.Create;
begin
  FTHTTPClient := THTTPClient.Create;
  FDownloadInfo := TDownloadInfo.Create;
  FTHTTPClient.OnReceiveData := self.onReceiveDataEvent;
  FObservers := TList<IDownloadObserver>.Create;
  FProgressoDownload.percentualDownload := 0;
  FProgressoDownload.tamanhoArquivo := 0;
  FProgressoDownload.totalBaixado := 0;
  FDownloadAtivo := false;
end;

destructor THTTPDownload.Destroy;
var
  observer: IDownloadObserver;
begin
  self.FTHTTPClient.Free;
  self.FDownloadInfo.Free;
  inherited;
end;

function THTTPDownload.downloadArquivo(aURL: string; aDiretorioDestino: string): boolean;
var
  arquivoDownload: TStream;
  aNomeArquivo: string;
  aRetornoHTTP: IHTTPResponse;
begin
  result := false;
  aNomeArquivo := TRegex.match(aURL, '(?<=\/)[^\/\?#]+(?=[^\/]*$)').Value;
  self.FDownloadInfo.CaminhoArquivo := format('%s\%s', [aDiretorioDestino, aNomeArquivo]);
  arquivoDownload := TFileStream.Create(
    self.FDownloadInfo.CaminhoArquivo,
    fmCreate
  );
  try
    FDownloadAtivo := true;
    aRetornoHTTP := FTHTTPClient.Get(aURL, arquivoDownload);
    if aRetornoHTTP.StatusCode <> 200 then
    begin
      self.FDownloadInfo.StatusDownload := tsErro;
      self.FDownloadInfo.DataFim := now;
      self.FEventoDownload(self, self.FDownloadInfo, format(eDownloadErroHTTP,
      [aRetornoHTTP.StatusCode, aRetornoHTTP.StatusText]));
      self.FDownloadAtivo := false;
    end;
    result := true;
  except
    on E: Exception do
    begin
       arquivoDownload.Free;
       if Assigned(self.FEventoDownload) then
          self.FEventoDownload(Self, self.FDownloadInfo, eDownloadErro);
    end;
  end;

  arquivoDownload.Free;
end;

function THTTPDownload.downloadEmExecucao: boolean;
begin
  result := FDownloadAtivo;
end;

function THTTPDownload.GetEvento: TNotificacaoDownload;
begin
  result := self.FEventoDownload;
end;

procedure THTTPDownload.notificar;
var
  observer: IDownloadObserver;
begin
  for observer in self.FObservers do
  begin
    observer.atualizarProgresso(FProgressoDownload);
  end;
end;

procedure THTTPDownload.onReceiveDataEvent(const Sender: TObject;
  AContentLength, AReadCount: Int64; var AAbort: Boolean);
begin
  AAbort := not self.FDownloadAtivo;
  FProgressoDownload.tamanhoArquivo := (AContentLength / 1048576);
  FProgressoDownload.totalBaixado := AReadCount / 1048576;
  FProgressoDownload.percentualDownload := (AReadCount * 100) / AContentLength;
  if AReadCount = AContentLength then
  begin
    self.FDownloadAtivo := false;
    if Assigned(self.FEventoDownload) then
    begin
      self.FDownloadInfo.DataFim := now;
      self.FDownloadInfo.StatusDownload := tsFinalizado;
      self.FEventoDownload(Self, self.FDownloadInfo, eDownloadConcluido);
    end;
  end;
  self.notificar;
end;

procedure THTTPDownload.pararDownload;
begin
  self.FDownloadAtivo := false;
  if Assigned(self.FEventoDownload) then
  begin
    self.FDownloadInfo.DataFim := now;
    self.FDownloadInfo.StatusDownload := tsAbortado;
    self.FEventoDownload(Self, self.FDownloadInfo, eDownloadAbortado);
  end;
end;

procedure THTTPDownload.removerObserver(observer: IDownloadObserver);
begin
  self.FObservers.Remove(observer);
end;

procedure THTTPDownload.SetEvento(const aEvento: TNotificacaoDownload);
begin
  self.FEventoDownload := aEvento;
end;

end.
