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
  FMX.Memo, FMX.Objects, FMX.Ani, FMX.Edit;

const
  MENUHELPER_OPACITY = 0.8;

type
  TForm1 = class(TForm)
    lytMain: TLayout;
    lytPage: TLayout;
    tbTitle: TToolBar;
    lblTitle: TLabel;
    lytMenuHelper: TLayout;
    lytMenu: TLayout;
    ShadowEffect1: TShadowEffect;
    lstLeftMenu: TListBox;
    btnSearch: TSpeedButton;
    btnSave: TSpeedButton;
    btnConnect: TSpeedButton;
    Rectangle1: TRectangle;
    faniShowMenu: TFloatAnimation;
    btnMenu: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actMenuShowExecute(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure lstLeftMenuItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure lytMenuHelperClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure faniShowMenuFinish(Sender: TObject);
    procedure btnMenuClick(Sender: TObject);
  private type
    TSwipeDirection = (None, Vertical, Horizontal, Etc); // ETC(대각선 등)
    TSwipeData = record
      private
        Direction: TSwipeDirection;
        MouseDown: Boolean;
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

  FSwipeData.MouseDown := False;
  FSwipeData.MouseDownPos := PointF(0, 0);

  FInit := True;
end;

procedure TForm1.MakeMenu;
var
  Menu: TFrameMenuData;
  Item: TListBoxItem;
begin
  // Menu control
//  lytMenu.Visible := False;

//  FFrameMenuList.Add(TFrameMenuData.Create('IBLite(임베디드 DB)',     'iblite.png',   'TfmIBLite'));
//  FFrameMenuList.Add(TFrameMenuData.Create('DataSnap(미들웨어)',      'database.png', 'TfmDataSnap'));
//  FFrameMenuList.Add(TFrameMenuData.Create('RESTClient(Web Service)', 'globe.png',    'TfmREST'));
//  FFrameMenuList.Add(TFrameMenuData.Create('BaaS(Cloud Service)',     'cloud.png',    'TfmBaaS'));
  FFrameMenuList.Add(TFrameMenuData.Create('Search Demo',             'search.png',   'TfmSearch'));
  FFrameMenuList.Add(TFrameMenuData.Create('Connect Demo',            'Socket.png',   'TfmConnect'));
  FFrameMenuList.Add(TFrameMenuData.Create('환경설정 Demo',           'setting.png',  'TfmSetting'));
  FFrameMenuList.Add(TFrameMenuData.Create('Blank Frame',             '',             'TfmBlank'));

  for Menu in FFrameMenuList do
  begin
    Item := TListBoxitem.Create(Self);
    Item.Parent := lstLeftMenu;
    Item.Text := Menu.Title;
    Item.ItemData.Bitmap.Assign(Menu.Icon);
    Item.Margins.Rect := RectF(5,5,0,5);
    Item.TagObject := Menu;
  end;

  lytMenu.Width := Max(Self.Width * 0.7, 280);
  lytMenu.Position.Point := PointF(-lytMenu.Width, 0);
  lytMenu.Height := ClientHeight;
  lytMenuHelper.Align := TAlignLayout.Contents;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  Menu: TFrameMenuData;
begin
  for Menu in FFrameMenuList do
    Menu.DisposeOf;
  FFrameMenuList.Free;
end;

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
      FSwipeData.MouseDown := True;
      FSwipeData.MouseDownPos := EventInfo.Location;
    end
    // Touch event 이동
    else if EventInfo.Flags = [] then
    begin
      if FSwipeData.Direction = TSwipeDirection.None then
      begin
        // 좌우
        MovePos := EventInfo.Location.Subtract(FSwipeData.MouseDownPos);
        if (Abs(MovePos.X) > 10) and (Abs(MovePos.X) > Abs(MovePos.Y) * 2) then
        begin
          FSwipeData.Direction := TSwipeDirection.Horizontal;
          DoSwipeBegin(FSwipeData.MouseDownPos);
        end;
      end;

      if FSwipeData.Direction = TSwipeDirection.Horizontal then
      begin
        DoSwipe(EventInfo.Location);
      end;

    end
    // Touch event 끝(손가락을 뗌)
    else if TInteractiveGestureFlag.gfEnd in EventInfo.Flags then
    begin
      FSwipeData.Direction := TSwipeDirection.None;
      FSwipeData.MouseDown := False;
      DoSwipeEnd(EventInfo.Location);
    end;
  end;
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

procedure TForm1.actMenuShowExecute(Sender: TObject);
begin
  ShowMenu := not ShowMenu;
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
    lytMenuHelper.Visible := True;
    Log.d('Set - ShowMenu');
  end
  else
  begin
    faniShowMenu.StopValue := -lytMenu.Width;
    faniShowMenu.Start;
    lytMenuHelper.Visible := False;
    Log.d('Set - HideMenu');
  end;
end;

{$REGION FeatureInterface}
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
  ShowMenu := not ShowMenu;
end;

{$ENDREGION}

procedure TForm1.SetMenuPosition(const Value: Single);
begin
  if ShowMenu then
  begin
    if Value < 0 then // 왼쪽으로
      lytMenu.Position.X := Max(Value, -lytMenu.Width);
  end
  else
  begin
    if Value > 0 then
      lytMenu.Position.X := Min(-lytMenu.Width + Value, 0);
  end;

  lytMenuHelper.Visible := True;
  Rectangle1.Opacity := ((lytMenu.Width + lytMenu.Position.X) / lytMenu.Width) * MENUHELPER_OPACITY;
  Log.d('%f = %f %f', [(lytMenu.Width + lytMenu.Position.X) / lytMenu.Width, lytMenu.Width, lytMenu.Position.X]);
  Rectangle1.Repaint;
end;

procedure TForm1.DoSwipeBegin(const P: TPointF);
begin
  FSwipeStartPos := P;
end;

procedure TForm1.DoSwipe(const P: TPointF);
var
  MovePos: TPointF;
begin
  MovePos := P.Subtract(FSwipeStartPos);
  SetMenuPosition(MovePos.X);
  Log.d('DoSwipe : %f - %f', [FSwipeStartPos.X, P.X]);
end;

procedure TForm1.DoSwipeEnd(const P: TPointF);
var
  MovePos: TPointF;
begin
  MovePos := P.Subtract(FSwipeStartPos);
  SetMenuPosition(MovePos.X);

  Log.d('DoSwipeEnd : %f > %f', [lytMenu.Width + lytMenu.Position.X, Self.Width * 0.4]);
  ShowMenu := (lytMenu.Width + lytMenu.Position.X) >= (Self.Width * 0.4);
end;

procedure TForm1.lstLeftMenuItemClick(const Sender: TCustomListBox;
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

  ShowMenu := False;
end;

// 메뉴가 표시되면 다른영역을 선택해도 메뉴가 닫히도록 처리
procedure TForm1.lytMenuHelperClick(Sender: TObject);
begin
  ShowMenu := False;
end;

end.
