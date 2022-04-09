unit untMainTest;

interface

uses
  DUnitX.TestFramework, uIDownload, uHTTPDownload, System.SysUtils, Vcl.Forms;

type
  [TestFixture]
  TMyTestObject = class
  private
    FHTTPDownload: IDownload;
    testDirectory: string;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [TestCase('TestComSucesso','https://www.sqlite.org/2022/sqlite-tools-win32-x86-3380200.zip')]
    procedure TestDownloadHTTPSucesso(const aURL: string);
    [TestCase('TestComErro','http://mirror.mrjester.net/ubuntu/release/18.04.4/ubuntu-18.04.4-desktop-amd64.iso')]
    procedure TestDownloadHTTPErro(const aURL: string);
  end;

implementation

procedure TMyTestObject.Setup;
begin
  self.FHTTPDownload := THTTPDownload.Create;
  testDirectory := IncludeTrailingPathDelimiter(
    ExtractFilePath(application.ExeName)
  ) + 'downloadDir';
  CreateDir(testDirectory);
end;

procedure TMyTestObject.TearDown;
begin
 // RmDir(self.testDirectory);
end;

procedure TMyTestObject.TestDownloadHTTPErro(const aURL: string);
var
  retornoDownload: boolean;
begin
  retornoDownload := self.FHTTPDownload.downloadArquivo(aURL, self.testDirectory);
  Assert.AreEqual(retornoDownload, false);
end;

procedure TMyTestObject.TestDownloadHTTPSucesso(const aURL: string);
var
  retornoDownload: boolean;
begin
  retornoDownload := self.FHTTPDownload.downloadArquivo(aURL, self.testDirectory);
  Assert.AreEqual(retornoDownload, true);
end;

initialization
  TDUnitX.RegisterTestFixture(TMyTestObject);

end.
