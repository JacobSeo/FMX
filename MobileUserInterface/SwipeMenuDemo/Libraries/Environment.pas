unit Environment;

interface

uses
  System.IniFiles;

type
  TEnvironment = class
  private
    FPath: string;
    FIniFile: TIniFile;
    FDSPort: Integer;
    FDSHost: string;
    FSockPort: Integer;
    FSockHost: string;
    procedure SetDSHost(const Value: string);
    procedure SetDSPort(const Value: Integer);
    procedure SetSockHost(const Value: string);
    procedure SetSockPort(const Value: Integer);
  public
    constructor Create;
    destructor Destroy; override;

    procedure LoadConfig;
//    procedure SaveConfig;

    property SockHost: string read FSockHost write SetSockHost;
    property SockPort: Integer read FSockPort write SetSockPort;

    property DSHost: string read FDSHost write SetDSHost;
    property DSPort: Integer read FDSPort write SetDSPort;
  end;

function Env: TEnvironment;

implementation

uses
  System.IOUtils;//, System.Classes, System.SysUtils, FMX.Forms,
//  FMX.Graphics;

const
  _INI_FILE_NAME = 'Env.ini';

var
  _Env: TEnvironment;

function Env: TEnvironment;
begin
  if not Assigned(_Env) then
    _Env := TEnvironment.Create;

  Result := _Env;
end;

{ TEnvironment }

constructor TEnvironment.Create;
begin
{$IFDEF MSWINDOWS}
  FPath := TPath.GetLibraryPath;
{$ELSE}
  FPath := TPath.GetDocumentsPath;
{$ENDIF}
  LoadConfig
end;

destructor TEnvironment.Destroy;
begin
  inherited;
end;

procedure TEnvironment.LoadConfig;
begin
  FIniFile := TIniFile.Create(TPath.Combine(FPath, _INI_FILE_NAME));
  try
    // Socket
    FSockHost := FIniFile.ReadString('Socket', 'Host', '');
    FSockPort := FIniFile.ReadInteger('Socket', 'Port', 8090);

    // DataSnap
    FDSHost := FiniFile.ReadString('DataSnap', 'Host', '');
    FDSPort := FiniFile.ReadInteger('DataSnap', 'Port', 8080);
  finally
    FIniFile.Free;
  end;
end;
{
procedure TEnvironment.SaveConfig;
begin
  FIniFile := TIniFile.Create(TPath.Combine(FPath, _INI_FILE_NAME));
  try
    FIniFile.WriteString('Socket', 'Host', FSockHost);
    FIniFile.WriteInteger('Socket', 'Port', FSockPort);
    FIniFile.WriteString('DataSnap', 'Host', FDSHost);
    FIniFile.WriteInteger('DataSnap', 'Port', FDSPort);
  finally
    FIniFile.Free;
  end;
end;
}

procedure TEnvironment.SetDSHost(const Value: string);
begin
  FDSHost := Value;
  FIniFile := TIniFile.Create(TPath.Combine(FPath, _INI_FILE_NAME));
  try
    FIniFile.WriteString('DataSnap', 'Host', Value);
  finally
    FIniFile.Free;
  end;
end;

procedure TEnvironment.SetDSPort(const Value: Integer);
begin
  FDSPort := Value;
  FIniFile := TIniFile.Create(TPath.Combine(FPath, _INI_FILE_NAME));
  try
    FIniFile.WriteInteger('DataSnap', 'Port', Value);
  finally
    FIniFile.Free;
  end;
end;

procedure TEnvironment.SetSockHost(const Value: string);
begin
  FSockHost := Value;
  FIniFile := TIniFile.Create(TPath.Combine(FPath, _INI_FILE_NAME));
  try
    FIniFile.WriteString('Socket', 'Host', Value);
  finally
    FIniFile.Free;
  end;
end;

procedure TEnvironment.SetSockPort(const Value: Integer);
begin
  FSockPort := Value;
  FIniFile := TIniFile.Create(TPath.Combine(FPath, _INI_FILE_NAME));
  try
    FIniFile.WriteInteger('Socket', 'Port', Value);
  finally
    FIniFile.Free;
  end;
end;

initialization

finalization
  // ARC 사용 시 해제
  if not _Env.Disposed then
    _Env.DisposeOf;

end.
