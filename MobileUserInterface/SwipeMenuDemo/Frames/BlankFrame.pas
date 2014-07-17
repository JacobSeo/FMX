unit BlankFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  // Add interface unit
  CommonInterface, FMX.Edit, FMX.Objects, FMX.Layouts;

type
  TfmBlank = class(TFrame, IFrameView)
    Button1: TButton;
    Timer1: TTimer;
    Edit1: TEdit;
    Label1: TLabel;
    ScrollBox1: TScrollBox;
    Rectangle1: TRectangle;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject); // Add IFrameInf
  private
    { Private declarations }

    // Add interface method
    { IFrameInf }
    procedure CreateFrame;
    procedure DestroyFrame;
    procedure ShowFrame;
    procedure HideFrame;

    function IsProcessBackButton: Boolean;

    procedure PauseWork;  // 메뉴를 표시하는 경우 작업 멈춤
    procedure ResumeWork;
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

{ TfmBlank }

procedure TfmBlank.Button1Click(Sender: TObject);
begin
  ShowMessage('빈 프레임입니다.');
end;

procedure TfmBlank.CreateFrame;
begin
  Log.d('Create frame');
end;

procedure TfmBlank.DestroyFrame;
begin
  Log.d('Destroy frame');
end;

procedure TfmBlank.ShowFrame;
begin

end;

procedure TfmBlank.Timer1Timer(Sender: TObject);
begin
  Edit1.Text := FormatDateTime('HH:NN:SS', Now);
end;

procedure TfmBlank.HideFrame;
begin

end;

function TfmBlank.IsProcessBackButton: Boolean;
begin
  Result := False;
end;

procedure TfmBlank.PauseWork;
begin
  Timer1.Enabled := False;
end;

procedure TfmBlank.ResumeWork;
begin
  Timer1.Enabled := True;
end;

// add initialization(RegisterClass)
initialization
  RegisterClass(TfmBlank);

finalization

end.
