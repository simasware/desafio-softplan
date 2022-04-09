unit uIDownload;

interface
  uses
    System.Classes, uIDownloadObserver, System.SysUtils;

type
  TStatusDownload = (tsIniciado, tsFinalizado, tsAbortado, tsErro);

type
  TDownloadInfo = class
    private
      FStatusDownload: TStatusDownload;
      FDataInicio: TDateTime;
      FDataFim: TDateTime;
      FCaminhoArquivo: TFileName;
    public
      constructor Create;
      property StatusDownload: TStatusDownload read FStatusDownload write FStatusDownload;
      property DataInicio: TDateTime read FDataInicio;
      property DataFim: TDateTime read FDataFim write FDataFim;
      property CaminhoArquivo: TFileName read FCaminhoArquivo write FCaminhoArquivo;
      function tempoDecorrido: TDateTime;
  end;

type
  TNotificacaoDownload = procedure(Sender: TObject;
    const statusDownload: TDownloadInfo;
    const mensagemRetorno: string) of object;

type
IDownload = interface(IObservavel)
  function downloadArquivo(aURL: string; aDiretorioDestino: string):boolean;
  procedure pararDownload;
  function downloadEmExecucao():boolean;
  procedure SetEvento(const aEvento: TNotificacaoDownload);
  function GetEvento: TNotificacaoDownload;
  property OnNotificacaoDownload: TNotificacaoDownload read getEvento write setEvento;
end;

implementation

{ TDownloadInfo }

constructor TDownloadInfo.Create;
begin
  self.FDataInicio := now();
  self.FStatusDownload := tsIniciado;
end;

function TDownloadInfo.tempoDecorrido: TDateTime;
begin
  result := self.FDataFim - self.FDataInicio;
end;

end.
