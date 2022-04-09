unit uIDownloadObserver;

interface

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


implementation

end.
