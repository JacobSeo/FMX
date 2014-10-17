program ProjectsFFrames;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  PhotoFrame in 'Frmaes\PhotoFrame.pas' {frPhoto: TFrame},
  WebBrowserFrame in 'Frmaes\WebBrowserFrame.pas' {frWebBrowser: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
