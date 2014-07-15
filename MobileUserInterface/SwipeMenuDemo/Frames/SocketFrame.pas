unit SocketFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, FMX.Layouts,
  FMX.Memo, FMX.Edit, FMX.Objects, CommonInterface;

type
  TWorkThread = class(TThread)
  private
    FClient: TIdTcpClient;
    FOnReadData: TNotifyEvent;
    FRecvData: string;

    procedure DoRecvData;
  protected
    procedure Execute; override;
  public
    constructor Create(AClient: TIdTcpClient);

    property RecvData: string read FRecvData;
    property OnReadData: TNotifyEvent read FOnReadData write FOnReadData;
  end;

  TfmSocket = class(TFrame, IFrameInf, IConnectFeature)
    Layout1: TLayout;
    Image1: TImage;
    edtHost: TEdit;
    edtPort: TEdit;
    Layout2: TLayout;
    SpeedButton2: TSpeedButton;
    edtMessage: TEdit;
    Memo1: TMemo;
    IdTCPClient1: TIdTCPClient;
    Image3: TImage;
    procedure SpeedButton2Click(Sender: TObject);
    procedure IdTCPClient1Disconnected(Sender: TObject);
    procedure IdTCPClient1Connected(Sender: TObject);
  private
    { Private declarations }
    FWorkThread: TWorkThread;

    procedure RecvData(Sender: TObject);

    { IFrameInf }
    procedure InitFrame;  // Frame 생성 시 호출
    procedure ShowFrame;  // Frame 보여지는 경우 호출
    procedure HideFrame;  // Frame 감쳐지는 경우 호출

    procedure PauseWork;  // 메뉴를 표시하는 경우 작업 멈춤
    procedure ResumeWork; // 메뉴를 감추는 경우 작업 재진행

    { IConnectFeature }
    procedure Connect;
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses
  Environment;

procedure TfmSocket.Connect;
begin
  IdTCPClient1.Host := edtHost.Text;
  IdTCPClient1.Port := StrToIntDef(edtPort.Text, 8090);
  IdTCPClient1.Connect;
  Env.SockHost := edtHost.Text;
  Env.SockPort := edtPort.Text.ToInteger;

  FWorkThread := TWorkThread.Create(IdTCPClient1);
  FWorkThread.OnReadData := RecvData;
end;

procedure TfmSocket.HideFrame;
begin
  IdTCPClient1.Disconnect;
end;

procedure TfmSocket.IdTCPClient1Connected(Sender: TObject);
begin
  Memo1.Lines.Add('Connected');
end;

procedure TfmSocket.IdTCPClient1Disconnected(Sender: TObject);
begin
  Memo1.Lines.Add('Disconnected');
end;

procedure TfmSocket.InitFrame;
begin
  edtHost.Text := Env.SockHost;
  edtPort.Text := Env.SockPort.ToString;
end;

procedure TfmSocket.PauseWork;
begin

end;

procedure TfmSocket.RecvData(Sender: TObject);
begin
  Memo1.Lines.Add(FWorkThread.RecvData);
end;

procedure TfmSocket.ResumeWork;
begin

end;

procedure TfmSocket.ShowFrame;
begin

end;

procedure TfmSocket.SpeedButton2Click(Sender: TObject);
begin
  IdTCPClient1.IOHandler.WriteLn(edtMessage.Text);
end;

{ TWorkThread }

constructor TWorkThread.Create(AClient: TIdTcpClient);
begin
  inherited Create(False);

  FreeOnTerminate := False;

  FClient := AClient;
end;

procedure TWorkThread.DoRecvData;
begin
  FOnReadData(Self);
end;

procedure TWorkThread.Execute;
begin
  inherited;

  FClient.ReadTimeout := 100;  // 무한히 기다리지 않도록 ReadTimeOut 을 준다.

  while not Terminated and FClient.Connected do
  begin
    FClient.IOHandler.CheckForDisconnect(True, True);
    FClient.IOHandler.CheckForDataOnSource(100);

    FRecvData := FClient.IOHandler.ReadLn;
    if Assigned(FOnReadData) and (FRecvData <> '') then
      Synchronize(DoRecvData);

    Sleep(100);
  end;
end;

initialization
  RegisterClass(TfmSocket);

finalization


end.
