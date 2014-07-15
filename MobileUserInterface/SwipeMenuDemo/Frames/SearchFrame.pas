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
  TfmSearch = class(TFrame, IFrameView, ISearchFeature, ISupportSwipeEvent)
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

    procedure PauseWork;  // �޴��� ǥ���ϴ� ��� �۾� ����
    procedure ResumeWork;

    { ISearchFeature }
    procedure Search;

    { ISupportSwipeEvent }
    procedure SwipeBegin(const AStartPos: TPointF; var AIsInterceptEvent: Boolean);
    procedure Swipe(const APos: TPointF; var AIsInterceptEvent: Boolean);
    procedure SwipeEnd(const AEndPos: TPointF; var AIsInterceptEvent: Boolean);
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

procedure TfmSearch.Swipe(const APos: TPointF; var AIsInterceptEvent: Boolean);
begin
  AIsInterceptEvent := False;
end;

procedure TfmSearch.SwipeBegin(const AStartPos: TPointF;
  var AIsInterceptEvent: Boolean);
begin
  AIsInterceptEvent := False;
  ListView1.Enabled := False;
end;

procedure TfmSearch.SwipeEnd(const AEndPos: TPointF;
  var AIsInterceptEvent: Boolean);
begin
  AIsInterceptEvent := False;
  ListView1.Enabled := True;
end;

// add initialization(RegisterClass)
initialization
  RegisterClass(TfmSearch);

finalization


end.
