unit uResourceMessages;

interface

resourcestring
  ePremiumFeature = 'Ops, esta funcionalidade ainda n�o est� dispon�vel! Voc� pode o fazer implementando a interface IDownload ;)';
  eDownloadConcluido = 'Download conclu�do com sucesso!';
  eDownloadAbortado = 'Download abortado por comando do usu�rio';
  eDownloadErro = 'Erro ao efetuar o download.';
  eDownloadErroHTTP = '%d - %s';


const
  TDownloadStatus: TArray<String> = ['Iniciado', 'Finalizado', 'Abortado', 'Erro'];

implementation

end.
