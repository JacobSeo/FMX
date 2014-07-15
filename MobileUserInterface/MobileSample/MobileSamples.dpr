program MobileSamples;



uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  MainForm in 'MainForm.pas' {Form1},
  BlankFrame in 'Frames\BlankFrame.pas' {fmBlank: TFrame},
  SettingFrame in 'Frames\SettingFrame.pas' {fmSetting: TFrame},
  SearchFrame in 'Frames\SearchFrame.pas' {fmSearch: TFrame},
  ConnectFrame in 'Frames\ConnectFrame.pas' {fmConnect: TFrame},
  WelcomeFrame in 'Frames\WelcomeFrame.pas' {Frame1: TFrame},
  CommonInterface in 'Libraries\CommonInterface.pas',
  Environment in 'Libraries\Environment.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
