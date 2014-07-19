unit MenuDataStructure;

interface

uses
  FMX.Graphics;

type
  TMenuData = class
  private
    FTitle: string;

    FIcon: TBitmap;
  public
    constructor Create(ATitle, AIcon: string);
    destructor Destroy; override;

    property Title: string read FTitle;
    property Icon: TBitmap read FIcon;
  end;

implementation

uses
  System.IOUtils;

{ TFrameMenuData }

constructor TMenuData.Create(ATitle, AIcon: string);
var
  Path: string;
begin
  FTitle := ATitle;

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

destructor TMenuData.Destroy;
begin

  inherited;
end;

end.
