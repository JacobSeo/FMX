unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure SetWifiEnabled(AEnable: Boolean);
function IsWifiEnabled: Boolean;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  Androidapi.Helpers,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNIBridge,
  Androidapi.JNI.WifiManager;

// Uses Permissions > Change wifi state
procedure SetWifiEnabled(AEnable: Boolean);
var
  Obj: JObject;
  WifiManager: JWifiManager;
begin
  Obj := SharedActivityContext.getSystemService(TJContext.JavaClass.WIFI_SERVICE);
  if Obj = nil then
    Exit;

  WifiManager := TJWifiManager.Wrap((Obj as ILocalObject).GetObjectID);
  WifiManager.setWifiEnabled(AEnable);
end;

// Uses Permissions > Access wifi state
function IsWifiEnabled: Boolean;
var
  Obj: JObject;
  WifiManager: JWifiManager;
begin
  Obj := SharedActivityContext.getSystemService(TJContext.JavaClass.WIFI_SERVICE);
  if Obj = nil then
    Exit;

  WifiManager := TJWifiManager.Wrap((Obj as ILocalObject).GetObjectID);
  Result := WifiManager.isWifiEnabled;
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
  SetWifiEnabled(True);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  SetWifiEnabled(False);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if IsWifiEnabled then
    Edit1.Text := 'On'
  else
    Edit1.Text := 'Off';
end;

end.
