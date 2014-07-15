unit ConnectFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, CommonInterface, FMX.Objects, FMX.Layouts, FMX.Memo, FMX.Ani;

type
  TfmConnect = class(TFrame, IFrameView, IConnectFeature)
    Layout1: TLayout;
    edtHost: TEdit;
    edtPort: TEdit;
    Layout2: TLayout;
    SpeedButton2: TSpeedButton;
    Image3: TImage;
    edtMessage: TEdit;
    Memo1: TMemo;
    Rectangle1: TRectangle;
    Text1: TText;
    FloatAnimation1: TFloatAnimation;
    Layout3: TLayout;
    imgConnected: TImage;
    imgDisconnect: TImage;
    procedure FloatAnimation1Finish(Sender: TObject);
  private
    FConnected: Boolean;
    { Private declarations }


    procedure CreateFrame;
    procedure DestroyFrame;
    procedure ShowFrame;
    procedure HideFrame;

    function IsProcessBackButton: Boolean;

    procedure PauseWork;
    procedure ResumeWork;

    procedure Connect(Sender: TObject);
    procedure SetConnected(const Value: Boolean);
  public
    { Public declarations }
    property Connected: Boolean read FConnected write SetConnected;
  end;

implementation

uses
  System.StrUtils;

{$R *.fmx}

{ TFrame1 }

procedure TfmConnect.CreateFrame;
begin
  Rectangle1.Opacity := 0;
  Rectangle1.Visible := False;
  imgConnected.Visible := False;
  imgDisconnect.Visible := True;
end;

procedure TfmConnect.DestroyFrame;
begin

end;

procedure TfmConnect.FloatAnimation1Finish(Sender: TObject);
begin
  Rectangle1.Opacity := 0;
  Rectangle1.Visible := False;
end;

procedure TfmConnect.SetConnected(const Value: Boolean);
begin
  FConnected := Value;

  if Value then Text1.Text := 'Connected'
  else          Text1.Text := 'Disconnected';

  Rectangle1.Opacity := 0;
  Rectangle1.Visible := True;
  FloatAnimation1.Start;

  imgConnected.Visible := Value;
  imgDisconnect.Visible := not Value;
  edtHost.Enabled := not Value;
  edtPort.Enabled := not Value;
end;

procedure TfmConnect.ShowFrame;
begin

end;

procedure TfmConnect.HideFrame;
begin

end;

function TfmConnect.IsProcessBackButton: Boolean;
begin
  Result := False;
end;

procedure TfmConnect.PauseWork;
begin

end;

procedure TfmConnect.ResumeWork;
begin

end;

procedure TfmConnect.Connect(Sender: TObject);
begin
  Connected := not Connected;

  if Sender is TSpeedButton then
    (Sender as TSpeedButton).Text := IfThen(Connected, '해제', '접속');
end;

initialization
  RegisterClass(TfmConnect);

finalization


end.
