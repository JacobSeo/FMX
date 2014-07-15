unit SearchFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListView.Types, FMX.ListView, Fmx.Bind.GenData, Data.Bind.GenData,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.ObjectScope,
  CommonInterface;

type
  TfmSearch = class(TFrame, IFrameView, ISearchFeature)
    ListView1: TListView;
    PrototypeBindSource1: TPrototypeBindSource;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
  private
    { Private declarations }
    { IFrameInf }
    procedure CreateFrame;
    procedure DestroyFrame;
    procedure ShowFrame;
    procedure HideFrame;

    function IsProcessBackButton: Boolean;

    procedure PauseWork;  // 메뉴를 표시하는 경우 작업 멈춤
    procedure ResumeWork;

    procedure Search;
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

{ TFrame1 }

procedure TfmSearch.CreateFrame;
begin

end;

procedure TfmSearch.DestroyFrame;
begin

end;

procedure TfmSearch.HideFrame;
begin

end;

function TfmSearch.IsProcessBackButton: Boolean;
begin
  Result := False;
  if ListView1.SearchVisible then
  begin
    ListView1.SearchVisible := False;
    Result := True;
  end;

end;

procedure TfmSearch.PauseWork;
begin

end;

procedure TfmSearch.ResumeWork;
begin

end;

procedure TfmSearch.Search;
begin
  ListView1.SearchVisible := not ListView1.SearchVisible;
end;

procedure TfmSearch.ShowFrame;
begin

end;

// add initialization(RegisterClass)
initialization
  RegisterClass(TfmSearch);

finalization


end.
