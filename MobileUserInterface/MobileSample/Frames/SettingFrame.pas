unit SettingFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.ListBox, FMX.Layouts, CommonInterface;

type
  TfmSetting = class(TFrame, IFrameView, ISaveFeature)
    ListBox1: TListBox;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    ListBoxItem1: TListBoxItem;
    edtSockHost: TEdit;
    ListBoxItem2: TListBoxItem;
    edtSockPort: TEdit;
    ListBoxGroupHeader2: TListBoxGroupHeader;
    ListBoxItem4: TListBoxItem;
    edtDSHost: TEdit;
    ListBoxItem3: TListBoxItem;
    edtDSPort: TEdit;
  private
    { Private declarations }
    { IFrameInf }
    procedure CreateFrame;
    procedure DestroyFrame;
    procedure ShowFrame;
    procedure HideFrame;

    function IsProcessBackButton: Boolean;

    procedure PauseWork;
    procedure ResumeWork;

    { ISaveFeature }
    procedure Save;
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses
  Environment;

{ TfmSetting }

procedure TfmSetting.CreateFrame;
begin
  edtSockHost.Text := Env.SockHost;
  edtSockPort.Text := Env.SockPort.ToString;
  edtDSHost.Text := Env.DSHost;
  edtDSPort.Text := Env.DSPort.ToString;
end;

procedure TfmSetting.DestroyFrame;
begin

end;

procedure TfmSetting.HideFrame;
begin

end;

function TfmSetting.IsProcessBackButton: Boolean;
begin
  Result := False;
end;

procedure TfmSetting.PauseWork;
begin

end;

procedure TfmSetting.ResumeWork;
begin

end;

procedure TfmSetting.Save;
begin
  Env.SockHost := edtSockHost.Text;
  Env.SockPort := StrToIntDef(edtSockPort.Text, -1);
  Env.DSHost    := edtDSHost.Text;
  Env.DSPort    := StrToIntDef(edtDSPort.Text, -1);
end;

procedure TfmSetting.ShowFrame;
begin

end;

initialization
  RegisterClass(TfmSetting);

finalization

end.
