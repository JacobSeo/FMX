{
  관련글 : http://blog.hjf.pe.kr/326
  원글
    - http://www.gesource.jp/weblog/?p=6835
    - http://www.gesource.jp/weblog/?p=6833
    - http://www.gesource.jp/weblog/?p=6832
  권한설정
    Bluetooth
    Bluetooth Admin
}

unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button4: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  Androidapi.JNI.Bluetooth,
  Androidapi.Helpers,
  Androidapi.JNI.GraphicsContentViewText;

procedure TForm1.Button1Click(Sender: TObject);
var
  Adapter: JBluetoothAdapter;
begin
  Adapter := TJBluetoothAdapter.JavaClass.getDefaultAdapter;
  if Adapter.isEnabled then
    ShowMessage('Bluetooth가 활성화 되어있습니다.')
  else
    ShowMessage('Bluetooth가 활성화 되지 않았습니다.');
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Adapter: JBluetoothAdapter;
begin
  Adapter := TJBluetoothAdapter.JavaClass.getDefaultAdapter;
  if Adapter.enable then
    ShowMessage('Bluetooth를 활성화합니다.')
  else
    ShowMessage('사용할 수 없습니다.');
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  Adapter: JBluetoothAdapter;
begin
  Adapter := TJBluetoothAdapter.JavaClass.getDefaultAdapter;
  if Adapter.disable then
    ShowMessage('Bluetooth를 비활성화합니다.')
  else
    ShowMessage('사용할 수 없습니다.');
end;

procedure TForm1.Button4Click(Sender: TObject);
  function HasPermission(const Permission: string): Boolean;
  begin
    Result := SharedActivityContext.checkCallingOrSelfPermission(StringToJString(Permission)) = TJPackageManager.JavaClass.PERMISSION_GRANTED
  end;

begin
  if HasPermission('android.permission.BLUETOOTH') then
    ShowMessage('Bluetooth 통신 권한이 있습니다.')
  else
    ShowMessage('Bluetooth 통신 권한이 없습니다');

  if HasPermission('android.permission.BLUETOOTH_ADMIN') then
    ShowMessage('Bluetooth 설정 수정 권한이 있습니다.')
  else
    ShowMessage('Bluetooth 설정 수정 권한이 없습니다.');
end;

end.
