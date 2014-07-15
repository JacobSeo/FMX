{
  Interfaced Frame Demo
    - Drawer menu(Left)
    - Using Frame view
    - Attach swipe event

  Author: 김현수(Humphery Kim)
          http://blog.hjf.pe.kr
          hjfactory@gmail.com

  배포 전 Deployment에서 Res를 다시(reset) 설정하세요.
}

unit MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ListBox, FMX.Effects, FMX.StdCtrls, System.Generics.Collections,
  FMX.Platform, CommonInterface, System.Actions, FMX.ActnList,
  FMX.Memo, FMX.Objects, FMX.Ani, FMX.Edit, System.Diagnostics;

const
  MENUHELPER_OPACITY = 0.8; // 메뉴표시 시 메뉴이외 배경의 투명도

  // 터치 시작/끝이 300ms 미만이면 빠른이동 처리(50 pixel 이상 이동 시 처리)
  SWIPE_FASTMOVE_VALUE = 50;
  SWIPE_FASTMOVE_TIME_MS = 300;
  SWIPE_MOVE_MINVALUE = 10; // 10 pixel 이상 움직여야 Swipe 시작

  SIDEBAR_WIDTH_RATE  = 0.7;
  SIDEBAR_WIDTH_MAX   = 280;
  SIDEBAR_SWITCH_RATE = 0.5; // 화면의 0.5이상 메뉴가 나오면 표시 아니면 감춤

type
  TForm1 = class(TForm)
    lytMain: TLayout;
    lytPage: TLayout;
    tbTitle: TToolBar;
    lblTitle: TLabel;
    lytMenuHelper: TLayout;
    lytSidebar: TLayout;
    ShadowEffect1: TShadowEffect;
    lstSidebarMenu: TListBox;
    btnSearch: TSpeedButton;
    btnSave: TSpeedButton;
    btnConnect: TSpeedButton;
    Rectangle1: TRectangle;
    faniShowMenu: TFloatAnimation;
    btnMenu: TButton;
    lytMyInfo: TLayout;
    Rectangle2: TRectangle;
    Circle1: TCircle;
    Text1: TText;
    Text2: TText;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure lstSidebarMenuItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure lytMenuHelperClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure btnMenuClick(Sender: TObject);
    procedure lytMenuHelperMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure lytMenuHelperMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  private type
    TSwipeDirection = (None, Vertical, Horizontal, Etc); // ETC(대각선 등)
    TSwipeData = record
      private
        Direction: TSwipeDirection;
        MouseDownPos: TPointF;
    end;
  private
    { Private declarations }
    FInit: Boolean;
    FFrameMenuList: TList<TFrameMenuData>;

    FShowMenu: Boolean;
    FCurrentMenu: TFrameMenuData;

    FSwipeData: TSwipeData;
    FSwipeStartPos: TPointF;
    FMenuHelperDown: Boolean;
    FSwipeBeginStopWatch: TStopWatch;

    procedure InitData;
    procedure MakeMenu;
    procedure EmbedFrame(AFrameMenuData: TFrameMenuData);

    procedure SetShowMenu(const Value: Boolean);
    procedure SetMenuPosition(const Value: Single);

    function HandleAppEvent(AAppEvent: TApplicationEvent; AContext: TObject): Boolean;

    procedure DoSwipeBegin(const P: TPointF);
    procedure DoSwipe(const P: TPointF);
    procedure DoSwipeEnd(const P: TPointF);
  public
    property ShowMenu: Boolean read FShowMenu write SetShowMenu;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  FMX.Styles, System.Math;

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

procedure TForm1.InitData;
begin
  if FInit then
    Exit;

{$IFNDEF MSWINDOWS}
  btnMenu.Visible := False;
{$ENDIF}

  btnSearch.Visible := False;
  btnSave.Visible := False;
  btnConnect.Visible := False;

  FFrameMenuList := TList<TFrameMenuData>.Create;

  MakeMenu;

  FSwipeData.MouseDownPos := PointF(0, 0);

  FInit := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  Menu: TFrameMenuData;
begin
  for Menu in FFrameMenuList do
    Menu.DisposeOf;
  FFrameMenuList.Free;
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  // Android backbutton 처리
  if Key = vkHardwareBack then
  begin
    if ShowMenu then
    begin
      ShowMenu := False;
      Key := 0;
      Exit;
    end;

    if Assigned(FCurrentMenu) and (FCurrentMenu.View as IFrameView).IsProcessBackButton then
    begin
      Key := 0;
      Exit;
    end;
  end;
end;

procedure TForm1.MakeMenu;
var
  Menu: TFrameMenuData;
  Item: TListBoxItem;
begin
  // Menu control
  FFrameMenuList.Add(TFrameMenuData.Create('Search Demo',             'search.png',   'TfmSearch'));
  FFrameMenuList.Add(TFrameMenuData.Create('Connect Demo',            'Socket.png',   'TfmConnect'));
  FFrameMenuList.Add(TFrameMenuData.Create('환경설정 Demo',           'setting.png',  'TfmSetting'));
  FFrameMenuList.Add(TFrameMenuData.Create('Blank Frame',             '',             'TfmBlank'));

  for Menu in FFrameMenuList do
  begin
    Item := TListBoxitem.Create(Self);
    Item.Parent := lstSidebarMenu;
    Item.Text := Menu.Title;
    Item.ItemData.Bitmap.Assign(Menu.Icon);
    Item.Margins.Rect := RectF(5,5,0,5);
    Item.TagObject := Menu;
  end;

  lstSidebarMenu.AniCalculations.TouchTracking := [];

  lytSidebar.Width := Max(Self.Width * SIDEBAR_WIDTH_RATE, SIDEBAR_WIDTH_MAX);
  lytSidebar.Position.Point := PointF(-lytSidebar.Width, 0);
  lytSidebar.Height := ClientHeight;
  lytMenuHelper.Align := TAlignLayout.Contents;
end;

procedure TForm1.SetShowMenu(const Value: Boolean);
begin
  FShowMenu := Value;

  // 메뉴를 표시할때 작업화면의 작업을 중단하기 위한 코드
  // 작업화면에서 주기적으로 작업을 진행할 경우 Animation에 영향을 줄 수 있음
  if Assigned(FCurrentMenu) then
  begin
    if FShowMenu then   (FCurrentMenu.View as IFrameView).PauseWork
    else                (FCurrentMenu.View as IFrameView).ResumeWork;
  end;

  if FShowMenu then
  begin
    faniShowMenu.StopValue := 0;
    faniShowMenu.Start;
//    Log.d('lytMenuHelper.Visible := True; // SetShowMenu');
    lytMenuHelper.Visible := True;
    Log.d('Set - ShowMenu');
  end
  else
  begin
    faniShowMenu.StopValue := -lytSidebar.Width;
    faniShowMenu.Start;
//    Log.d('lytMenuHelper.Visible := False; // SetShowMenu');
    lytMenuHelper.Visible := False;
    lytMenuHelper.Repaint;
    Log.d('Set - HideMenu');
  end;
end;

procedure TForm1.lstSidebarMenuItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  EmbedFrame(Item.TagObject as TFrameMenuData);
end;

procedure TForm1.EmbedFrame(AFrameMenuData: TFrameMenuData);
begin
  // 이전 메뉴 감춤
  if Assigned(FCurrentMenu) then
  begin
    if FCurrentMenu = AFrameMenuData then
    begin
      Log.d('TForm1.EmbedFrame begin');
      ShowMenu := False;
      Exit;
    end;

    (FCurrentMenu.View as IFrameView).HideFrame;
    FCurrentMenu.View.Parent := nil;
    FCurrentMenu.View.Visible := False;
  end;

  FCurrentMenu := AFrameMenuData;

  // 현재 메뉴 표시
  AFrameMenuData.View.Parent := lytPage;
  AFrameMenuData.View.Align := TAlignLayout.Client;
  AFrameMenuData.View.Visible := True;
  (AFrameMenuData.View as IFrameView).ShowFrame;

  lblTitle.Text := AFrameMenuData.Title;

  // 기능지원 여부를
  btnSearch.Visible   := Supports(AFrameMenuData.View, ISearchFeature);
  btnSave.Visible     := Supports(AFrameMenuData.View, ISaveFeature);
  btnConnect.Visible  := Supports(AFrameMenuData.View, IConnectFeature);

  Log.d('TForm1.EmbedFrame end');
  ShowMenu := False;
end;

// 메뉴가 표시되면 다른영역을 선택해도 메뉴가 닫히도록 처리
procedure TForm1.lytMenuHelperMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  FMenuHelperDown := True;
  Log.d('TForm1.lytMenuHelperMouseDown');
end;

// Swipe 시에도 Click 이벤트가 발생하므로 MenuHelper에서 이벤트가 시작된 경우만 닫기
procedure TForm1.lytMenuHelperClick(Sender: TObject);
begin
  Log.d('TForm1.lytMenuHelperClick');
  if FMenuHelperDown then
  begin
    Log.d('TForm1.lytMenuHelperClick - ShowMenu False');
    ShowMenu := False;
  end;
  FMenuHelperDown := False;
end;

procedure TForm1.lytMenuHelperMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  Log.d('TForm1.lytMenuHelperMouseUp');
end;

{$REGION 'FeatureInterface'}
procedure TForm1.btnConnectClick(Sender: TObject);
var
  Feature: IConnectFeature;
begin
  if Supports(FCurrentMenu.View, IConnectFeature, Feature) then
    Feature.Connect(btnConnect);
end;

procedure TForm1.btnSaveClick(Sender: TObject);
var
  Feature: ISaveFeature;
begin
  if Supports(FCurrentMenu.View, ISaveFeature, Feature) then
    Feature.Save;
end;

procedure TForm1.btnSearchClick(Sender: TObject);
var
  Feature: ISearchFeature;
begin
  if Supports(FCurrentMenu.View, ISearchFeature, Feature) then
    Feature.Search;
end;
procedure TForm1.btnMenuClick(Sender: TObject);
begin
  Log.d('TForm1.btnMenuClick');
  ShowMenu := not ShowMenu;
end;

{$ENDREGION}

{$REGION 'Swipe function'}
procedure TForm1.FormGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
var
  MovePos: TPointF;
begin
  if EventInfo.GestureID = igiPan then
  begin
    // Touch event 시작
    if TInteractiveGestureFlag.gfBegin in EventInfo.Flags then
    begin
      FSwipeData.Direction := TSwipeDirection.None;
      FSwipeData.MouseDownPos := EventInfo.Location;
    end
    // Touch event 이동
    else if EventInfo.Flags = [] then
    begin
      if FSwipeData.Direction = TSwipeDirection.None then
      begin
        // 좌우
//        MovePos := EventInfo.Location.Subtract(FSwipeData.MouseDownPos);
        MovePos := EventInfo.Location - FSwipeData.MouseDownPos;

        // Android의 경우 첫번째 EventInfo.Location과 FSwipeData.MouseDownPos가 같음
        if MovePos = PointF(0, 0) then
          Exit;
        // 10이상 움직인경우 시작
        if (Abs(MovePos.X) > SWIPE_MOVE_MINVALUE) then
        begin
          if (Abs(MovePos.X) > Abs(MovePos.Y) * 2) then
          begin
            FSwipeData.Direction := TSwipeDirection.Horizontal;
            DoSwipeBegin(FSwipeData.MouseDownPos);
          end
          else
          begin
            FSwipeData.Direction := TSwipeDirection.Etc;
          end;
        end;
      end;

      if FSwipeData.Direction = TSwipeDirection.Horizontal then
        DoSwipe(EventInfo.Location);
    end
    // Touch event 끝(손가락을 뗌)
    else if TInteractiveGestureFlag.gfEnd in EventInfo.Flags then
    begin
      if FSwipeData.Direction = TSwipeDirection.Horizontal then
        DoSwipeEnd(EventInfo.Location);
      FSwipeData.Direction := TSwipeDirection.None;
    end;
  end;
end;

procedure TForm1.SetMenuPosition(const Value: Single);
begin
  if ShowMenu then
  begin
    if Value < 0 then // 왼쪽으로
      lytSidebar.Position.X := Max(Value, -lytSidebar.Width);
  end
  else
  begin
    if Value > 0 then
      lytSidebar.Position.X := Min(-lytSidebar.Width + Value, 0);
  end;

  lytMenuHelper.Visible := True;
  Rectangle1.Opacity := ((lytSidebar.Width + lytSidebar.Position.X) / lytSidebar.Width) * MENUHELPER_OPACITY;
  Rectangle1.Repaint;
end;

procedure TForm1.DoSwipeBegin(const P: TPointF);
var
  SwipeEvent: ISupportSwipeEvent;
  B: Boolean;
begin
  Log.d('TForm1.DoSwipeBegin');

  FSwipeBeginStopWatch.Reset;
  FSwipeBeginStopWatch.Start;
  if Assigned(FCurrentMenu) and Supports(FCurrentMenu.View, ISupportSwipeEvent, SwipeEvent) then
    SwipeEvent.SwipeBegin(P, B);

  FSwipeStartPos := P;

  FMenuHelperDown := False;
end;

procedure TForm1.DoSwipe(const P: TPointF);
var
  MovePos: TPointF;

  SwipeEvent: ISupportSwipeEvent;
  B: Boolean;
begin
  if Assigned(FCurrentMenu) and Supports(FCurrentMenu.View, ISupportSwipeEvent, SwipeEvent) then
    SwipeEvent.Swipe(P, B);

//  MovePos := P.Subtract(FSwipeStartPos);
  MovePos := P - FSwipeStartPos;
  SetMenuPosition(MovePos.X);
  Log.d('DoSwipe : %f - %f', [FSwipeStartPos.X, P.X]);
end;

procedure TForm1.DoSwipeEnd(const P: TPointF);
var
  MovePos: TPointF;
  SwipeEvent: ISupportSwipeEvent;
  B: Boolean;
begin
  if Assigned(FCurrentMenu) and Supports(FCurrentMenu.View, ISupportSwipeEvent, SwipeEvent) then
    SwipeEvent.SwipeEnd(P, B);

//  MovePos := P.Subtract(FSwipeStartPos);
  MovePos := P - FSwipeStartPos;
  SetMenuPosition(MovePos.X);

//  Log.d('DoSwipeEnd : %f > %f(SW: %d)', [lytSidebar.Width + lytSidebar.Position.X, Self.Width * 0.4, FSwipeBeginStopWatch.ElapsedMilliseconds]);
  // 짧게 Swipe하는 경우 방향만 맞으면 메뉴전환
  if FSwipeBeginStopWatch.ElapsedMilliseconds < SWIPE_FASTMOVE_TIME_MS then
  begin
    if ShowMenu then
      ShowMenu := (MovePos.X > -SWIPE_FASTMOVE_VALUE)
    else
      ShowMenu := (MovePos.X > SWIPE_FASTMOVE_VALUE);
  end
  // 길게 Swipe하는 경우 특정위치 이상 메뉴 이동 시 전환
  else
    ShowMenu := (lytSidebar.Width + lytSidebar.Position.X) >= lytSidebar.Width * 0.5;
  Log.d('TForm1.DoSwipeEnd');
end;
{$ENDREGION}

end.
