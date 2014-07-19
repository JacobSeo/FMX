unit MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Ani, FMX.Layouts, FMX.ListBox, FMX.Effects, FMX.StdCtrls, MenuDataStructure,
  FMX.Platform, System.Generics.Collections, Fmx.Bind.GenData,
  Data.Bind.GenData, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.ObjectScope;

type
  TForm1 = class(TForm)
    tbTitle: TToolBar;
    lblTitle: TLabel;
    btnMenu: TSpeedButton;
    lytSidebar: TLayout;
    ShadowEffect1: TShadowEffect;
    lstSidebarMenu: TListBox;
    lytMenuHelper: TLayout;
    lytPage: TLayout;
    lytMyInfo: TLayout;
    Rectangle2: TRectangle;
    Circle1: TCircle;
    Text1: TText;
    Text2: TText;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    ListBoxGroupFooter1: TListBoxGroupFooter;
    lytMain: TLayout;
    procedure lytMenuHelperClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnMenuClick(Sender: TObject);
    procedure lstSidebarMenuApplyStyleLookup(Sender: TObject);
  private
    FInit: Boolean;
    FShowMenu: Boolean;

    FMenuDataList: TList<TMenuData>;

    procedure InitData;
    procedure MakeMenu;

    function HandleAppEvent(AAppEvent: TApplicationEvent; AContext: TObject): Boolean;

    procedure SetShowMenu(const Value: Boolean);
  public
    { Public declarations }
    property ShowMenu: Boolean read FShowMenu write SetShowMenu;
  end;

var
  Form1: TForm1;

implementation

uses
  System.Math;

{$R *.fmx}

{ TForm1 }

procedure TForm1.btnMenuClick(Sender: TObject);
begin
  ShowMenu := not ShowMenu;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  EventService: IFMXApplicationEventService;
begin
  FInit := False;
  if TPlatformServices.Current.SupportsPlatformService(IFMXApplicationEventService, IInterface(EventService)) then
    EventService.SetApplicationEventHandler(HandleAppEvent)
  else
    InitData;
end;

function TForm1.HandleAppEvent(AAppEvent: TApplicationEvent;
  AContext: TObject): Boolean;
begin
  case AAppEvent of
    TApplicationEvent.FinishedLaunching:
      begin
        Log.d('Finished Launching');
        InitData;
      end;
    TApplicationEvent.BecameActive:
      begin
        Log.d('Became Active');
        InitData;
      end;
    TApplicationEvent.WillBecomeInactive: Log.d('Will Become Inactive');
    TApplicationEvent.EnteredBackground: Log.d('Entered Background');
    TApplicationEvent.WillBecomeForeground: Log.d('Will Become Foreground');
    TApplicationEvent.WillTerminate: Log.d('Will Terminate');
    TApplicationEvent.LowMemory: Log.d('Low Memory');
    TApplicationEvent.TimeChange: Log.d('Time Change');
    TApplicationEvent.OpenURL: Log.d('Open URL');
  end;
  Result := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FMenuDataList.Free;
end;

procedure TForm1.InitData;
begin
  if FInit then
    Exit;

  FMenuDataList := TList<TMenuData>.Create;

  MakeMenu;

  FInit := True;
end;

procedure TForm1.MakeMenu;
var
  Menu: TMenuData;
  Item: TListBoxItem;
begin
  // 동적으로 메뉴를 생성할 경우 아래의 주석을 해제하세요.
{ // 동적 메뉴 코드 시작
  FMenuDataList.Add(TMenuData.Create('Search demo',   'search.png'));
  FMenuDataList.Add(TMenuData.Create('Connect demo',  'Socket.png'));
  FMenuDataList.Add(TMenuData.Create('환경설정',      'setting.png'));
  FMenuDataList.Add(TMenuData.Create('Blank Frame',   ''));

  lstSidebarmenu.Clear;
  for Menu in FMenuDataList do
  begin
    Item := TListBoxitem.Create(Self);
    Item.Parent := lstSidebarmenu;
    Item.Text := Menu.Title;
    if Assigned(Menu.Icon) then
      Item.ItemData.Bitmap.Assign(Menu.Icon.CreateThumbnail(25, 25));
//    Item.ItemData.Bitmap.Assign(Menu.Icon);
//    Item.Margins.Rect := RectF(5,5,0,5);
    Item.TagObject := Menu;
  end;
}// 동적 메뉴 코드 시작


  // 메뉴의 너비는 스마트폰 너비의 70% 사용(최대 280)
  lytSidebar.Width := Max(Self.Width * 0.7, 280);
  // 상단 ToolBar를 제외한 영역에 메뉴표시
  lytSidebar.Position.Point := PointF(-lytSidebar.Width, tbTitle.Height);
  lytSidebar.Height := ClientHeight - tbTitle.Height;
  // 왼쪽을 가득채우는 메뉴
  //lytSidebar.Position.Point := PointF(-lytSidebar.Width, 0);
  //lytSidebar.Height := ClientHeight;

  // MenuHelper는 메뉴가 표시된면 메뉴이외의 다른 영역을 누르면 메뉴가 닫히도록 하기위한 장치
  lytMenuHelper.Align := TAlignLayout.Contents;
  lytMenuHelper.Visible := False;

  lytMenuHelper.BringToFront;
  lytSidebar.BringToFront;
end;

procedure TForm1.SetShowMenu(const Value: Boolean);
begin
  FShowMenu := Value;

  if FShowMenu then
  begin
    lytSidebar.AnimateFloat('Position.X', 0);
    lytMenuHelper.Visible := True;
  end
  else
  begin
    lytSidebar.AnimateFloat('Position.X', -lytSidebar.Width);
    lytMenuHelper.Visible := False;
  end;
end;

procedure TForm1.lstSidebarMenuApplyStyleLookup(Sender: TObject);
begin
  //
end;

procedure TForm1.lytMenuHelperClick(Sender: TObject);
begin
  ShowMenu := False;
end;

end.
