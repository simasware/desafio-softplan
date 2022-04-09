unit uResourceMessages;

interface

resourcestring
  ePremiumFeature = 'Ops, esta funcionalidade ainda não está disponível! Você pode o fazer implementando a interface IDownload ;)';
  eDownloadConcluido = 'Download concluído com sucesso!';
  eDownloadAbortado = 'Download abortado por comando do usuário';
  eDownloadErro = 'Erro ao efetuar o download.';
  eDownloadErroHTTP = '%d - %s';


const
  TDownloadStatus: TArray<String> = ['Iniciado', 'Finalizado', 'Abortado', 'Erro'];

implementation

end.
