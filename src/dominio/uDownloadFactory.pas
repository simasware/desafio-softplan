unit uDownloadFactory;

interface
uses
  System.Classes, uIDownload, uHTTPDownload, uFTPDownload, uSSHDownload;

type
  TTipoDownload = (tdHTTP, tdFTP, tdSSH);

type
  IFactoryMethod = interface
    function novoDownload(tipoDownload: TTipoDownload): IDownload;
  end;

type
  TDownloadFactory = class(TInterfacedObject, IFactoryMethod)
    function novoDownload(tipoDownload: TTipoDownload): IDownload;
  end;

implementation


{ TDownloadFactory }

function TDownloadFactory.novoDownload(tipoDownload: TTipoDownload): IDownload;
begin
  case tipoDownload of
    tdHTTP: result := THTTPDownload.Create;
    tdFTP: result := TFTPDownload.Create;
    tdSSH: result := TSSHDownload.Create;
    else
      result := THTTPDownload.Create;
  end;
end;

end.
