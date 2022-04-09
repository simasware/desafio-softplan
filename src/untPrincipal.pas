unit untPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.FileCtrl,
  Vcl.ComCtrls, uDownloadFactory, uIDownloadObserver, uIDownload,
  System.Threading, System.Actions, Vcl.ActnList;

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

type
  TfrmPrincipal = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    editDownloadURL: TEdit;
    btnDownload: TButton;
    Label2: TLabel;
    edtCaminhoDownload: TEdit;
    btnAlterarDiretorio: TButton;
    cbTipoDownload: TComboBox;
    Label3: TLabel;
    memProgressoDownload: TMemo;
    btnPararDownload: TButton;
    pgDownloadArquivo: TProgressBar;
    btnHistorico: TButton;
    actDownload: TActionList;
    actIniciarDownload: TAction;
    actPararDownload: TAction;
    actHistoricoDownload: TAction;
    actAlterarDiretorioDownload: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure NotifyDownload(Sender: TObject;
    const statusDownload: TDownloadInfo;
    const mensagemRetorno: string);
    procedure actAlterarDiretorioDownloadUpdate(Sender: TObject);
    procedure actPararDownloadUpdate(Sender: TObject);
    procedure actIniciarDownloadExecute(Sender: TObject);
    procedure actPararDownloadExecute(Sender: TObject);
    procedure actHistoricoDownloadExecute(Sender: TObject);
    procedure actAlterarDiretorioDownloadExecute(Sender: TObject);
  private
    { Private declarations }
    FThreadDownload: TThread;
    FDownloadObserver: TDownloadMemoObserver;
    FDownloadProgress: TDownloadProgressObserver;
    fileDownload: IDownload;
    downloadFactory: TDownloadFactory;
    procedure onThreadTerminated(Sender: TObject);
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses untHistoricoDownloads, uDataModulo;

procedure TfrmPrincipal.actAlterarDiretorioDownloadExecute(Sender: TObject);
var
  diretorioSelecionado: string;
begin
  SelectDirectory('Selecionar diretório', '', diretorioSelecionado);
  edtCaminhoDownload.Text := diretorioSelecionado;
end;

procedure TfrmPrincipal.actAlterarDiretorioDownloadUpdate(Sender: TObject);
begin
  if Assigned(self.FThreadDownload) then
    TAction(Sender).Enabled := self.FThreadDownload.Finished;
end;

procedure TfrmPrincipal.actHistoricoDownloadExecute(Sender: TObject);
begin
  application.CreateForm(TfrmHistorico, frmHistorico);
  try
    frmHistorico.ShowModal;
  finally
    frmHistorico.Free;
  end;
end;

procedure TfrmPrincipal.actIniciarDownloadExecute(Sender: TObject);
begin
  if editDownloadURL.Text = '' then
    raise Exception.Create('Você deve informar uma URL para download!');

  FThreadDownload := TThread.CreateAnonymousThread(
    procedure
    begin
      fileDownload := downloadFactory.novoDownload(TTipoDownload(cbTipoDownload.ItemIndex));
      fileDownload.adicionarObserver(FDownloadObserver);
      fileDownload.adicionarObserver(FDownloadProgress);
      fileDownload.OnNotificacaoDownload := self.NotifyDownload;
      fileDownload.downloadArquivo(editDownloadURL.Text, edtCaminhoDownload.Text);
    end
  );
  FThreadDownload.OnTerminate := self.onThreadTerminated;
  FThreadDownload.Start;
end;

procedure TfrmPrincipal.actPararDownloadExecute(Sender: TObject);
begin
  fileDownload.pararDownload;
end;

procedure TfrmPrincipal.actPararDownloadUpdate(Sender: TObject);
begin
  if Assigned(self.FThreadDownload) then
    TAction(Sender).Enabled := self.FThreadDownload.Started
  else
    TAction(Sender).Enabled := false;
end;

procedure TfrmPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if assigned(fileDownload) then
  begin
    if fileDownload.downloadEmExecucao then
    begin
      self.FThreadDownload.Terminate;
      canClose := application.MessageBox(
        'Existe um download em andamento. Deseja fechar?',
        'Finalizar aplicação',
        MB_ICONQUESTION+MB_YESNO) = mrYes;
    end;
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  edtCaminhoDownload.Text := IncludeTrailingPathDelimiter(
    GetEnvironmentVariable('USERPROFILE')) + 'Downloads';
  downloadFactory := TDownloadFactory.Create;
  FDownloadObserver := TDownloadMemoObserver.Create;
  FDownloadObserver.MemoDownload := memProgressoDownload;
  FDownloadProgress := TDownloadProgressObserver.Create;
  FDownloadProgress.ProgressBar := pgDownloadArquivo;
end;

procedure TfrmPrincipal.NotifyDownload(Sender: TObject;
  const statusDownload: TDownloadInfo; const mensagemRetorno: string);
begin
  with dmDadosDownloads do
  begin
    tbLogDownload.active := true;
    tbLogDownload.InsertRecord(
      [
        nil,
        editDownloadURL.Text,
        statusDownload.DataInicio,
        statusDownload.DataFim,
        Integer(statusDownload.StatusDownload),
        statusDownload.CaminhoArquivo
      ]
    );
  end;
  if statusDownload.StatusDownload in [tsAbortado, tsErro] then
    DeleteFile(statusDownload.CaminhoArquivo);
  Application.MessageBox(PWideChar(mensagemRetorno), 'Download', MB_ICONINFORMATION);
  self.FThreadDownload.Terminate;
end;

procedure TfrmPrincipal.onThreadTerminated(Sender: TObject);
begin
  if TThread(Sender).FatalException <> nil then
  begin
    Application.MessageBox(
      PWideChar('Ocorreu o seguinte erro ao efetuar o download: ' + #13 +
        TThread(Sender).FatalException.ToString
      ), 'Falha ao efetuar download', MB_ICONERROR
    );
  end;

end;

{ TDownloadProgressBarObserver }

procedure TDownloadMemoObserver.atualizarProgresso(
  progressoDownload: TProgressoDownload);
var
  statusDownload: TStrings;
begin
  statusDownload := TStringList.Create;

  statusDownload.Add(format('Tamanho do arquivo: %2.f MB', [progressoDownload.tamanhoArquivo]));
  statusDownload.Add(format('Total baixado     : %2.f MB', [progressoDownload.totalBaixado]));
  statusDownload.Add(format('Percentual baixado: %2.f %%', [progressoDownload.percentualDownload]));
  self.FMemoDownload.Lines.text := statusDownload.Text;
  statusDownload.Free;
  application.ProcessMessages;
end;

{ TDownloadProgressObserver }

procedure TDownloadProgressObserver.atualizarProgresso(
  progressoDownload: TProgressoDownload);
begin
  if self.FProgressBar.Max = 0 then
    self.FProgressBar.Max := round(progressoDownload.tamanhoArquivo);
  self.ProgressBar.Position := round(progressoDownload.totalBaixado);
end;

end.
