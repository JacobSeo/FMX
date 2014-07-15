program MobileSamples;



uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  MainForm in 'MainForm.pas' {Form1},
  CommonInterface in 'Libararies\CommonInterface.pas',
  BlankFrame in 'Frames\BlankFrame.pas' {fmBlank: TFrame},
  SettingFrame in 'Frames\SettingFrame.pas' {fmSetting: TFrame},
  Environment in 'Libararies\Environment.pas',
  SearchFrame in 'Frames\SearchFrame.pas' {fmSearch: TFrame},
  ConnectFrame in 'Frames\ConnectFrame.pas' {fmConnect: TFrame},
  WelcomeFrame in 'Frames\WelcomeFrame.pas' {Frame1: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
