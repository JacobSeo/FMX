unit CommonInterface;

interface

uses
  FMX.Forms, FMX.Graphics, System.Types;

type
  // Frame Interface
  IFrameView = interface
   ['{62BE91AB-E9CC-4E13-91E7-8C5F42E6E7E3}']
    procedure CreateFrame;  // Frame ���� �� ȣ��
    procedure DestroyFrame; // Frame ���� �� ȣ��
    procedure ShowFrame;    // Frame �������� ��� ȣ��
    procedure HideFrame;    // Frame �������� ��� ȣ��

    // �����ӿ��� ���ư ����ߴ��� ����
    function IsProcessBackButton: Boolean;

    // Frame ������ Thread, Timer�� ������ ���� ��� �ִϸ��̼� ȿ���� ������ �ټ� �����Ƿ� �ش� �۾����� ����
    procedure PauseWork;  // �޴��� ǥ���ϴ� ��� �۾� ����
    procedure ResumeWork; // �޴��� ���ߴ� ��� �۾� ������
  end;

  // Feature Interface
  ISearchFeature = interface
  ['{5D1E9F09-0A7A-4040-BB4A-B4C013E44B2A}']
    procedure Search;
  end;

  ISaveFeature = interface
  ['{3D24974E-3657-44C6-BD5A-64F4099482C6}']
    procedure Save;
  end;

  IConnectFeature = interface
  ['{104E89EC-3A00-43CB-8961-FEC6F2013071}']
    procedure Connect(Sender: TObject);
  end;

  // Swipe Event Interface
  ISupportSwipeEvent = interface
  ['{152551D7-6455-4439-BEF8-4345811D5900}']
    procedure SwipeBegin(const AStartPos: TPointF; var Handled: Boolean);
    procedure SwipeMove(const AMovePos: TPointF; var Handled: Boolean);
    procedure SwipeEnd(const AEndPos: TPointF; var Handled: Boolean);
  end;

  TFrameMenuData = class
  private
    FTitle: string;
    FViewClassName: string;

    FIcon: TBitmap;
    FView: TFrame;
    function GetView: TFrame;
  public
    constructor Create(ATitle, AIcon, AClass: string);
    destructor Destroy; override;

    property Title: string read FTitle write FTitle;
    property Icon: TBitmap read FIcon;
    property View: TFrame read GetView;
//    property ViewClassName: string read FViewClassName;
  end;

implementation

uses
  System.SysUtils,
  System.IOUtils, System.Classes;

{ TFrameMenuItem }

constructor TFrameMenuData.Create(ATitle, AIcon, AClass: string);
var
  Path: string;
begin
  FTitle := ATitle;
  FViewClassName := AClass;

{$IFDEF MSWINDOWS}
  // [EXE file path]
  Path := TPath.GetLibraryPath;
{$ELSE}
  // ios : StartUp\Documents
  // android : assets\internal
  Path := TPath.GetDocumentsPath;
{$ENDIF}
  Path := TPath.Combine(Path, 'Res');
  Path := TPath.Combine(Path, AIcon);

  if System.IOUtils.TFile.Exists(Path) then
    FIcon := TBitmap.CreateFromFile(Path);
end;

function TFrameMenuData.GetView: TFrame;
var
  PersistentClass: TPersistentClass;
begin
  if not Assigned(FView) then
  begin
    PersistentClass := GetClass(FViewClassName);
    if Assigned(PersistentClass) then
      FView := TComponentClass(PersistentClass).Create(nil) as TFrame;
    (FView as IFrameView).CreateFrame; // �ʱ�ȭ �޽��� ����
   end;

  Result := FView;
end;

destructor TFrameMenuData.Destroy;
begin
  if Assigned(FView) then
  begin
    (FView as IFrameView).DestroyFrame;
    FView.Free;
  end;
end;

end.
