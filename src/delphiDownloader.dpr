program delphiDownloader;

uses
  Vcl.Forms,
  untPrincipal in 'untPrincipal.pas' {frmPrincipal},
  uIDownload in 'dominio\uIDownload.pas',
  uHTTPDownload in 'dominio\uHTTPDownload.pas',
  uIDownloadObserver in 'dominio\uIDownloadObserver.pas',
  uDownloadFactory in 'dominio\uDownloadFactory.pas',
  uFTPDownload in 'dominio\uFTPDownload.pas',
  uSSHDownload in 'dominio\uSSHDownload.pas',
  Vcl.Themes,
  Vcl.Styles,
  uResourceMessages in 'shared\uResourceMessages.pas',
  uThreadDownload in 'shared\uThreadDownload.pas',
  uDataModulo in 'db\uDataModulo.pas' {dmDadosDownloads: TDataModule},
  untHistoricoDownloads in 'untHistoricoDownloads.pas' {frmHistorico};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Delphi File Downloader - Fernando de Simas [2022]';
  Application.CreateForm(TdmDadosDownloads, dmDadosDownloads);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
