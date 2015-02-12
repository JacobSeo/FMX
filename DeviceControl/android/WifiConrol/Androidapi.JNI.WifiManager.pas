{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2014 Embarcadero Technologies, Inc.      }
{                                                       }
{*******************************************************}

unit Androidapi.JNI.WifiManager;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Java.Security,
  Androidapi.JNI.Util,
  Androidapi.JNI.Os;

type
// ===== Forward declarations =====

  JDhcpInfo = interface;//android.net.DhcpInfo
  JNetworkInfo_DetailedState = interface;//android.net.NetworkInfo$DetailedState
  JSupplicantState = interface;//android.net.wifi.SupplicantState
  JWifiConfiguration = interface;//android.net.wifi.WifiConfiguration
  JWifiEnterpriseConfig = interface;//android.net.wifi.WifiEnterpriseConfig
  JWifiInfo = interface;//android.net.wifi.WifiInfo
  JWifiManager = interface;//android.net.wifi.WifiManager
  JWifiManager_MulticastLock = interface;//android.net.wifi.WifiManager$MulticastLock
  JWifiManager_WifiLock = interface;//android.net.wifi.WifiManager$WifiLock
  JWorkSource = interface;//android.os.WorkSource
  JBitSet = interface;//java.util.BitSet

// ===== Interface declarations =====

  JDhcpInfoClass = interface(JObjectClass)
    ['{D9CB198A-3E3F-40F8-8F10-B46CF06EE695}']
    {class} function init: JDhcpInfo; cdecl;
  end;

  [JavaSignature('android/net/DhcpInfo')]
  JDhcpInfo = interface(JObject)
    ['{15AE9247-20B6-412F-8A84-1A6EE8290F09}']
    function _Getdns1: Integer;
    procedure _Setdns1(Value: Integer);
    function _Getdns2: Integer;
    procedure _Setdns2(Value: Integer);
    function _Getgateway: Integer;
    procedure _Setgateway(Value: Integer);
    function _GetipAddress: Integer;
    procedure _SetipAddress(Value: Integer);
    function _GetleaseDuration: Integer;
    procedure _SetleaseDuration(Value: Integer);
    function _Getnetmask: Integer;
    procedure _Setnetmask(Value: Integer);
    function _GetserverAddress: Integer;
    procedure _SetserverAddress(Value: Integer);
    function toString: JString; cdecl;
    property dns1: Integer read _Getdns1 write _Setdns1;
    property dns2: Integer read _Getdns2 write _Setdns2;
    property gateway: Integer read _Getgateway write _Setgateway;
    property ipAddress: Integer read _GetipAddress write _SetipAddress;
    property leaseDuration: Integer read _GetleaseDuration write _SetleaseDuration;
    property netmask: Integer read _Getnetmask write _Setnetmask;
    property serverAddress: Integer read _GetserverAddress write _SetserverAddress;
  end;
  TJDhcpInfo = class(TJavaGenericImport<JDhcpInfoClass, JDhcpInfo>) end;

  JNetworkInfo_DetailedStateClass = interface(JEnumClass)
    ['{23C018BA-81E4-4B2E-B369-9CF46B9A5DAF}']
    {class} function _GetAUTHENTICATING: JNetworkInfo_DetailedState;
    {class} function _GetBLOCKED: JNetworkInfo_DetailedState;
    {class} function _GetCAPTIVE_PORTAL_CHECK: JNetworkInfo_DetailedState;
    {class} function _GetCONNECTED: JNetworkInfo_DetailedState;
    {class} function _GetCONNECTING: JNetworkInfo_DetailedState;
    {class} function _GetDISCONNECTED: JNetworkInfo_DetailedState;
    {class} function _GetDISCONNECTING: JNetworkInfo_DetailedState;
    {class} function _GetFAILED: JNetworkInfo_DetailedState;
    {class} function _GetIDLE: JNetworkInfo_DetailedState;
    {class} function _GetOBTAINING_IPADDR: JNetworkInfo_DetailedState;
    {class} function _GetSCANNING: JNetworkInfo_DetailedState;
    {class} function _GetSUSPENDED: JNetworkInfo_DetailedState;
    {class} function _GetVERIFYING_POOR_LINK: JNetworkInfo_DetailedState;
    {class} function valueOf(name: JString): JNetworkInfo_DetailedState; cdecl;
    {class} function values: TJavaObjectArray<JNetworkInfo_DetailedState>; cdecl;
    {class} property AUTHENTICATING: JNetworkInfo_DetailedState read _GetAUTHENTICATING;
    {class} property BLOCKED: JNetworkInfo_DetailedState read _GetBLOCKED;
    {class} property CAPTIVE_PORTAL_CHECK: JNetworkInfo_DetailedState read _GetCAPTIVE_PORTAL_CHECK;
    {class} property CONNECTED: JNetworkInfo_DetailedState read _GetCONNECTED;
    {class} property CONNECTING: JNetworkInfo_DetailedState read _GetCONNECTING;
    {class} property DISCONNECTED: JNetworkInfo_DetailedState read _GetDISCONNECTED;
    {class} property DISCONNECTING: JNetworkInfo_DetailedState read _GetDISCONNECTING;
    {class} property FAILED: JNetworkInfo_DetailedState read _GetFAILED;
    {class} property IDLE: JNetworkInfo_DetailedState read _GetIDLE;
    {class} property OBTAINING_IPADDR: JNetworkInfo_DetailedState read _GetOBTAINING_IPADDR;
    {class} property SCANNING: JNetworkInfo_DetailedState read _GetSCANNING;
    {class} property SUSPENDED: JNetworkInfo_DetailedState read _GetSUSPENDED;
    {class} property VERIFYING_POOR_LINK: JNetworkInfo_DetailedState read _GetVERIFYING_POOR_LINK;
  end;

  [JavaSignature('android/net/NetworkInfo$DetailedState')]
  JNetworkInfo_DetailedState = interface(JEnum)
    ['{E755D6D6-0DB0-4231-A31B-5AA4E74A4F9F}']
  end;
  TJNetworkInfo_DetailedState = class(TJavaGenericImport<JNetworkInfo_DetailedStateClass, JNetworkInfo_DetailedState>) end;

  JSupplicantStateClass = interface(JEnumClass)
    ['{11D5113E-AE84-4F4C-832D-5F9E78A93530}']
    {class} function _GetASSOCIATED: JSupplicantState;
    {class} function _GetASSOCIATING: JSupplicantState;
    {class} function _GetAUTHENTICATING: JSupplicantState;
    {class} function _GetCOMPLETED: JSupplicantState;
    {class} function _GetDISCONNECTED: JSupplicantState;
    {class} function _GetDORMANT: JSupplicantState;
    {class} function _GetFOUR_WAY_HANDSHAKE: JSupplicantState;
    {class} function _GetGROUP_HANDSHAKE: JSupplicantState;
    {class} function _GetINACTIVE: JSupplicantState;
    {class} function _GetINTERFACE_DISABLED: JSupplicantState;
    {class} function _GetINVALID: JSupplicantState;
    {class} function _GetSCANNING: JSupplicantState;
    {class} function _GetUNINITIALIZED: JSupplicantState;
    {class} function isValidState(state: JSupplicantState): Boolean; cdecl;
    {class} function valueOf(name: JString): JSupplicantState; cdecl;
    {class} function values: TJavaObjectArray<JSupplicantState>; cdecl;
    {class} property ASSOCIATED: JSupplicantState read _GetASSOCIATED;
    {class} property ASSOCIATING: JSupplicantState read _GetASSOCIATING;
    {class} property AUTHENTICATING: JSupplicantState read _GetAUTHENTICATING;
    {class} property COMPLETED: JSupplicantState read _GetCOMPLETED;
    {class} property DISCONNECTED: JSupplicantState read _GetDISCONNECTED;
    {class} property DORMANT: JSupplicantState read _GetDORMANT;
    {class} property FOUR_WAY_HANDSHAKE: JSupplicantState read _GetFOUR_WAY_HANDSHAKE;
    {class} property GROUP_HANDSHAKE: JSupplicantState read _GetGROUP_HANDSHAKE;
    {class} property INACTIVE: JSupplicantState read _GetINACTIVE;
    {class} property INTERFACE_DISABLED: JSupplicantState read _GetINTERFACE_DISABLED;
    {class} property INVALID: JSupplicantState read _GetINVALID;
    {class} property SCANNING: JSupplicantState read _GetSCANNING;
    {class} property UNINITIALIZED: JSupplicantState read _GetUNINITIALIZED;
  end;

  [JavaSignature('android/net/wifi/SupplicantState')]
  JSupplicantState = interface(JEnum)
    ['{1733F9B5-2434-461F-8DF6-F23617BFA5D8}']
  end;
  TJSupplicantState = class(TJavaGenericImport<JSupplicantStateClass, JSupplicantState>) end;

  JWifiConfigurationClass = interface(JObjectClass)
    ['{C8BFCCBF-51DC-4210-9559-EFF599859A26}']
    {class} function init: JWifiConfiguration; cdecl;
  end;

  [JavaSignature('android/net/wifi/WifiConfiguration')]
  JWifiConfiguration = interface(JObject)
    ['{ED67818C-4A3D-441D-987A-9E8826085924}']
    function _GetBSSID: JString;
    procedure _SetBSSID(Value: JString);
    function _GetSSID: JString;
    procedure _SetSSID(Value: JString);
    function _GetallowedAuthAlgorithms: JBitSet;
    procedure _SetallowedAuthAlgorithms(Value: JBitSet);
    function _GetallowedGroupCiphers: JBitSet;
    procedure _SetallowedGroupCiphers(Value: JBitSet);
    function _GetallowedKeyManagement: JBitSet;
    procedure _SetallowedKeyManagement(Value: JBitSet);
    function _GetallowedPairwiseCiphers: JBitSet;
    procedure _SetallowedPairwiseCiphers(Value: JBitSet);
    function _GetallowedProtocols: JBitSet;
    procedure _SetallowedProtocols(Value: JBitSet);
    function _GetenterpriseConfig: JWifiEnterpriseConfig;
    procedure _SetenterpriseConfig(Value: JWifiEnterpriseConfig);
    function _GethiddenSSID: Boolean;
    procedure _SethiddenSSID(Value: Boolean);
    function _GetnetworkId: Integer;
    procedure _SetnetworkId(Value: Integer);
    function _GetpreSharedKey: JString;
    procedure _SetpreSharedKey(Value: JString);
    function _Getpriority: Integer;
    procedure _Setpriority(Value: Integer);
    function _Getstatus: Integer;
    procedure _Setstatus(Value: Integer);
    function _GetwepKeys: TJavaObjectArray<JString>;
    procedure _SetwepKeys(Value: TJavaObjectArray<JString>);
    function _GetwepTxKeyIndex: Integer;
    procedure _SetwepTxKeyIndex(Value: Integer);
    function toString: JString; cdecl;
    property BSSID: JString read _GetBSSID write _SetBSSID;
    property SSID: JString read _GetSSID write _SetSSID;
    property allowedAuthAlgorithms: JBitSet read _GetallowedAuthAlgorithms write _SetallowedAuthAlgorithms;
    property allowedGroupCiphers: JBitSet read _GetallowedGroupCiphers write _SetallowedGroupCiphers;
    property allowedKeyManagement: JBitSet read _GetallowedKeyManagement write _SetallowedKeyManagement;
    property allowedPairwiseCiphers: JBitSet read _GetallowedPairwiseCiphers write _SetallowedPairwiseCiphers;
    property allowedProtocols: JBitSet read _GetallowedProtocols write _SetallowedProtocols;
    property enterpriseConfig: JWifiEnterpriseConfig read _GetenterpriseConfig write _SetenterpriseConfig;
    property hiddenSSID: Boolean read _GethiddenSSID write _SethiddenSSID;
    property networkId: Integer read _GetnetworkId write _SetnetworkId;
    property preSharedKey: JString read _GetpreSharedKey write _SetpreSharedKey;
    property priority: Integer read _Getpriority write _Setpriority;
    property status: Integer read _Getstatus write _Setstatus;
    property wepKeys: TJavaObjectArray<JString> read _GetwepKeys write _SetwepKeys;
    property wepTxKeyIndex: Integer read _GetwepTxKeyIndex write _SetwepTxKeyIndex;
  end;
  TJWifiConfiguration = class(TJavaGenericImport<JWifiConfigurationClass, JWifiConfiguration>) end;

  JWifiEnterpriseConfigClass = interface(JObjectClass)
    ['{8583C57E-0204-4BC8-B0D5-8B25DA81985B}']
    {class} function _GetCREATOR: JParcelable_Creator;
    {class} function init: JWifiEnterpriseConfig; cdecl; overload;
    {class} function init(source: JWifiEnterpriseConfig): JWifiEnterpriseConfig; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/net/wifi/WifiEnterpriseConfig')]
  JWifiEnterpriseConfig = interface(JObject)
    ['{B822B902-C591-48D1-BEFF-56FC393A03A7}']
    function describeContents: Integer; cdecl;
    function getAnonymousIdentity: JString; cdecl;
    function getCaCertificate: JX509Certificate; cdecl;
    function getClientCertificate: JX509Certificate; cdecl;
    function getEapMethod: Integer; cdecl;
    function getIdentity: JString; cdecl;
    function getPassword: JString; cdecl;
    function getPhase2Method: Integer; cdecl;
    function getSubjectMatch: JString; cdecl;
    procedure setAnonymousIdentity(anonymousIdentity: JString); cdecl;
    procedure setCaCertificate(cert: JX509Certificate); cdecl;
    procedure setClientKeyEntry(privateKey: JPrivateKey; clientCertificate: JX509Certificate); cdecl;
    procedure setEapMethod(eapMethod: Integer); cdecl;
    procedure setIdentity(identity: JString); cdecl;
    procedure setPassword(password: JString); cdecl;
    procedure setPhase2Method(phase2Method: Integer); cdecl;
    procedure setSubjectMatch(subjectMatch: JString); cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJWifiEnterpriseConfig = class(TJavaGenericImport<JWifiEnterpriseConfigClass, JWifiEnterpriseConfig>) end;

  JWifiInfoClass = interface(JObjectClass)
    ['{8CC8F57E-4945-400E-9F19-626BDDCB496A}']
    {class} function _GetLINK_SPEED_UNITS: JString;
    {class} function getDetailedStateOf(suppState: JSupplicantState): JNetworkInfo_DetailedState; cdecl;
    {class} property LINK_SPEED_UNITS: JString read _GetLINK_SPEED_UNITS;
  end;

  [JavaSignature('android/net/wifi/WifiInfo')]
  JWifiInfo = interface(JObject)
    ['{D1AC40A2-AD68-4A81-ABD0-A0476CA41C22}']
    function getBSSID: JString; cdecl;
    function getHiddenSSID: Boolean; cdecl;
    function getIpAddress: Integer; cdecl;
    function getLinkSpeed: Integer; cdecl;
    function getMacAddress: JString; cdecl;
    function getNetworkId: Integer; cdecl;
    function getRssi: Integer; cdecl;
    function getSSID: JString; cdecl;
    function getSupplicantState: JSupplicantState; cdecl;
    function toString: JString; cdecl;
  end;
  TJWifiInfo = class(TJavaGenericImport<JWifiInfoClass, JWifiInfo>) end;

  JWifiManagerClass = interface(JObjectClass)
    ['{A3559F69-A273-4480-972E-48D2381B1F93}']
    {class} function _GetACTION_PICK_WIFI_NETWORK: JString;
    {class} function _GetACTION_REQUEST_SCAN_ALWAYS_AVAILABLE: JString;
    {class} function _GetERROR_AUTHENTICATING: Integer;
    {class} function _GetEXTRA_BSSID: JString;
    {class} function _GetEXTRA_NETWORK_INFO: JString;
    {class} function _GetEXTRA_NEW_RSSI: JString;
    {class} function _GetEXTRA_NEW_STATE: JString;
    {class} function _GetEXTRA_PREVIOUS_WIFI_STATE: JString;
    {class} function _GetEXTRA_SUPPLICANT_CONNECTED: JString;
    {class} function _GetEXTRA_SUPPLICANT_ERROR: JString;
    {class} function _GetEXTRA_WIFI_INFO: JString;
    {class} function _GetEXTRA_WIFI_STATE: JString;
    {class} function _GetNETWORK_IDS_CHANGED_ACTION: JString;
    {class} function _GetNETWORK_STATE_CHANGED_ACTION: JString;
    {class} function _GetRSSI_CHANGED_ACTION: JString;
    {class} function _GetSCAN_RESULTS_AVAILABLE_ACTION: JString;
    {class} function _GetSUPPLICANT_CONNECTION_CHANGE_ACTION: JString;
    {class} function _GetSUPPLICANT_STATE_CHANGED_ACTION: JString;
    {class} function _GetWIFI_MODE_FULL: Integer;
    {class} function _GetWIFI_MODE_FULL_HIGH_PERF: Integer;
    {class} function _GetWIFI_MODE_SCAN_ONLY: Integer;
    {class} function _GetWIFI_STATE_CHANGED_ACTION: JString;
    {class} function _GetWIFI_STATE_DISABLED: Integer;
    {class} function _GetWIFI_STATE_DISABLING: Integer;
    {class} function _GetWIFI_STATE_ENABLED: Integer;
    {class} function _GetWIFI_STATE_ENABLING: Integer;
    {class} function _GetWIFI_STATE_UNKNOWN: Integer;
    {class} function calculateSignalLevel(rssi: Integer; numLevels: Integer): Integer; cdecl;
    {class} function compareSignalLevel(rssiA: Integer; rssiB: Integer): Integer; cdecl;
    {class} property ACTION_PICK_WIFI_NETWORK: JString read _GetACTION_PICK_WIFI_NETWORK;
    {class} property ACTION_REQUEST_SCAN_ALWAYS_AVAILABLE: JString read _GetACTION_REQUEST_SCAN_ALWAYS_AVAILABLE;
    {class} property ERROR_AUTHENTICATING: Integer read _GetERROR_AUTHENTICATING;
    {class} property EXTRA_BSSID: JString read _GetEXTRA_BSSID;
    {class} property EXTRA_NETWORK_INFO: JString read _GetEXTRA_NETWORK_INFO;
    {class} property EXTRA_NEW_RSSI: JString read _GetEXTRA_NEW_RSSI;
    {class} property EXTRA_NEW_STATE: JString read _GetEXTRA_NEW_STATE;
    {class} property EXTRA_PREVIOUS_WIFI_STATE: JString read _GetEXTRA_PREVIOUS_WIFI_STATE;
    {class} property EXTRA_SUPPLICANT_CONNECTED: JString read _GetEXTRA_SUPPLICANT_CONNECTED;
    {class} property EXTRA_SUPPLICANT_ERROR: JString read _GetEXTRA_SUPPLICANT_ERROR;
    {class} property EXTRA_WIFI_INFO: JString read _GetEXTRA_WIFI_INFO;
    {class} property EXTRA_WIFI_STATE: JString read _GetEXTRA_WIFI_STATE;
    {class} property NETWORK_IDS_CHANGED_ACTION: JString read _GetNETWORK_IDS_CHANGED_ACTION;
    {class} property NETWORK_STATE_CHANGED_ACTION: JString read _GetNETWORK_STATE_CHANGED_ACTION;
    {class} property RSSI_CHANGED_ACTION: JString read _GetRSSI_CHANGED_ACTION;
    {class} property SCAN_RESULTS_AVAILABLE_ACTION: JString read _GetSCAN_RESULTS_AVAILABLE_ACTION;
    {class} property SUPPLICANT_CONNECTION_CHANGE_ACTION: JString read _GetSUPPLICANT_CONNECTION_CHANGE_ACTION;
    {class} property SUPPLICANT_STATE_CHANGED_ACTION: JString read _GetSUPPLICANT_STATE_CHANGED_ACTION;
    {class} property WIFI_MODE_FULL: Integer read _GetWIFI_MODE_FULL;
    {class} property WIFI_MODE_FULL_HIGH_PERF: Integer read _GetWIFI_MODE_FULL_HIGH_PERF;
    {class} property WIFI_MODE_SCAN_ONLY: Integer read _GetWIFI_MODE_SCAN_ONLY;
    {class} property WIFI_STATE_CHANGED_ACTION: JString read _GetWIFI_STATE_CHANGED_ACTION;
    {class} property WIFI_STATE_DISABLED: Integer read _GetWIFI_STATE_DISABLED;
    {class} property WIFI_STATE_DISABLING: Integer read _GetWIFI_STATE_DISABLING;
    {class} property WIFI_STATE_ENABLED: Integer read _GetWIFI_STATE_ENABLED;
    {class} property WIFI_STATE_ENABLING: Integer read _GetWIFI_STATE_ENABLING;
    {class} property WIFI_STATE_UNKNOWN: Integer read _GetWIFI_STATE_UNKNOWN;
  end;

  [JavaSignature('android/net/wifi/WifiManager')]
  JWifiManager = interface(JObject)
    ['{7411ED93-E0EC-4DBC-979A-5B895346DA34}']
    function addNetwork(config: JWifiConfiguration): Integer; cdecl;
    function createMulticastLock(tag: JString): JWifiManager_MulticastLock; cdecl;
    function createWifiLock(lockType: Integer; tag: JString): JWifiManager_WifiLock; cdecl; overload;
    function createWifiLock(tag: JString): JWifiManager_WifiLock; cdecl; overload;
    function disableNetwork(netId: Integer): Boolean; cdecl;
    function disconnect: Boolean; cdecl;
    function enableNetwork(netId: Integer; disableOthers: Boolean): Boolean; cdecl;
    function getConfiguredNetworks: JList; cdecl;
    function getConnectionInfo: JWifiInfo; cdecl;
    function getDhcpInfo: JDhcpInfo; cdecl;
    function getScanResults: JList; cdecl;
    function getWifiState: Integer; cdecl;
    function isScanAlwaysAvailable: Boolean; cdecl;
    function isWifiEnabled: Boolean; cdecl;
    function pingSupplicant: Boolean; cdecl;
    function reassociate: Boolean; cdecl;
    function reconnect: Boolean; cdecl;
    function removeNetwork(netId: Integer): Boolean; cdecl;
    function saveConfiguration: Boolean; cdecl;
    procedure setTdlsEnabledWithMacAddress(remoteMacAddress: JString; enable: Boolean); cdecl;
    function setWifiEnabled(enabled: Boolean): Boolean; cdecl;
    function startScan: Boolean; cdecl;
    function updateNetwork(config: JWifiConfiguration): Integer; cdecl;
  end;
  TJWifiManager = class(TJavaGenericImport<JWifiManagerClass, JWifiManager>) end;

  JWifiManager_MulticastLockClass = interface(JObjectClass)
    ['{5A3A1B1D-84FB-4E49-8D92-47A2881314CC}']
  end;

  [JavaSignature('android/net/wifi/WifiManager$MulticastLock')]
  JWifiManager_MulticastLock = interface(JObject)
    ['{682F61D0-82D8-484F-8EA8-72BDF4DD7FA9}']
    procedure acquire; cdecl;
    function isHeld: Boolean; cdecl;
    procedure release; cdecl;
    procedure setReferenceCounted(refCounted: Boolean); cdecl;
    function toString: JString; cdecl;
  end;
  TJWifiManager_MulticastLock = class(TJavaGenericImport<JWifiManager_MulticastLockClass, JWifiManager_MulticastLock>) end;

  JWifiManager_WifiLockClass = interface(JObjectClass)
    ['{AE9D4E26-7200-4F0B-A2B7-C0DFA79A4340}']
  end;

  [JavaSignature('android/net/wifi/WifiManager$WifiLock')]
  JWifiManager_WifiLock = interface(JObject)
    ['{43789DF1-6903-4338-A5A6-A6C101944654}']
    procedure acquire; cdecl;
    function isHeld: Boolean; cdecl;
    procedure release; cdecl;
    procedure setReferenceCounted(refCounted: Boolean); cdecl;
    procedure setWorkSource(ws: JWorkSource); cdecl;
    function toString: JString; cdecl;
  end;
  TJWifiManager_WifiLock = class(TJavaGenericImport<JWifiManager_WifiLockClass, JWifiManager_WifiLock>) end;

  JWorkSourceClass = interface(JObjectClass)
    ['{9910D5A2-6162-4A96-B8F3-C5DC531FE31E}']
    {class} function _GetCREATOR: JParcelable_Creator;
    {class} function init: JWorkSource; cdecl; overload;
    {class} function init(orig: JWorkSource): JWorkSource; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/os/WorkSource')]
  JWorkSource = interface(JObject)
    ['{04F85B42-2599-4F09-AB20-D4996613853E}']
    function add(other: JWorkSource): Boolean; cdecl;
    procedure clear; cdecl;
    function describeContents: Integer; cdecl;
    function diff(other: JWorkSource): Boolean; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function remove(other: JWorkSource): Boolean; cdecl;
    procedure &set(other: JWorkSource); cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJWorkSource = class(TJavaGenericImport<JWorkSourceClass, JWorkSource>) end;

  JBitSetClass = interface(JObjectClass)
    ['{1CB74061-9B52-4CCA-AB29-D87B5EE10BCB}']
    {class} function init: JBitSet; cdecl; overload;
    {class} function init(bitCount: Integer): JBitSet; cdecl; overload;
    {class} function valueOf(longs: TJavaArray<Int64>): JBitSet; cdecl; overload;
    {class} function valueOf(bytes: TJavaArray<Byte>): JBitSet; cdecl; overload;
    {class} function valueOf(byteBuffer: JByteBuffer): JBitSet; cdecl; overload;
  end;

  [JavaSignature('java/util/BitSet')]
  JBitSet = interface(JObject)
    ['{2FBDF9C9-FEEE-4377-B2A2-D557CF0BEC31}']
    procedure &and(bs: JBitSet); cdecl;
    procedure andNot(bs: JBitSet); cdecl;
    function cardinality: Integer; cdecl;
    procedure clear(index: Integer); cdecl; overload;
    procedure clear; cdecl; overload;
    procedure clear(fromIndex: Integer; toIndex: Integer); cdecl; overload;
    function clone: JObject; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    procedure flip(index: Integer); cdecl; overload;
    procedure flip(fromIndex: Integer; toIndex: Integer); cdecl; overload;
    function &get(index: Integer): Boolean; cdecl; overload;
    function &get(fromIndex: Integer; toIndex: Integer): JBitSet; cdecl; overload;
    function hashCode: Integer; cdecl;
    function intersects(bs: JBitSet): Boolean; cdecl;
    function isEmpty: Boolean; cdecl;
    function length: Integer; cdecl;
    function nextClearBit(index: Integer): Integer; cdecl;
    function nextSetBit(index: Integer): Integer; cdecl;
    procedure &or(bs: JBitSet); cdecl;
    function previousClearBit(index: Integer): Integer; cdecl;
    function previousSetBit(index: Integer): Integer; cdecl;
    procedure &set(index: Integer); cdecl; overload;
    procedure &set(index: Integer; state: Boolean); cdecl; overload;
    procedure &set(fromIndex: Integer; toIndex: Integer; state: Boolean); cdecl; overload;
    procedure &set(fromIndex: Integer; toIndex: Integer); cdecl; overload;
    function size: Integer; cdecl;
    function toByteArray: TJavaArray<Byte>; cdecl;
    function toLongArray: TJavaArray<Int64>; cdecl;
    function toString: JString; cdecl;
    procedure &xor(bs: JBitSet); cdecl;
  end;
  TJBitSet = class(TJavaGenericImport<JBitSetClass, JBitSet>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.WifiManager.JDhcpInfo', TypeInfo(Androidapi.JNI.WifiManager.JDhcpInfo));
  TRegTypes.RegisterType('Androidapi.JNI.WifiManager.JNetworkInfo_DetailedState', TypeInfo(Androidapi.JNI.WifiManager.JNetworkInfo_DetailedState));
  TRegTypes.RegisterType('Androidapi.JNI.WifiManager.JSupplicantState', TypeInfo(Androidapi.JNI.WifiManager.JSupplicantState));
  TRegTypes.RegisterType('Androidapi.JNI.WifiManager.JWifiConfiguration', TypeInfo(Androidapi.JNI.WifiManager.JWifiConfiguration));
  TRegTypes.RegisterType('Androidapi.JNI.WifiManager.JWifiEnterpriseConfig', TypeInfo(Androidapi.JNI.WifiManager.JWifiEnterpriseConfig));
  TRegTypes.RegisterType('Androidapi.JNI.WifiManager.JWifiInfo', TypeInfo(Androidapi.JNI.WifiManager.JWifiInfo));
  TRegTypes.RegisterType('Androidapi.JNI.WifiManager.JWifiManager', TypeInfo(Androidapi.JNI.WifiManager.JWifiManager));
  TRegTypes.RegisterType('Androidapi.JNI.WifiManager.JWifiManager_MulticastLock', TypeInfo(Androidapi.JNI.WifiManager.JWifiManager_MulticastLock));
  TRegTypes.RegisterType('Androidapi.JNI.WifiManager.JWifiManager_WifiLock', TypeInfo(Androidapi.JNI.WifiManager.JWifiManager_WifiLock));
  TRegTypes.RegisterType('Androidapi.JNI.WifiManager.JWorkSource', TypeInfo(Androidapi.JNI.WifiManager.JWorkSource));
  TRegTypes.RegisterType('Androidapi.JNI.WifiManager.JBitSet', TypeInfo(Androidapi.JNI.WifiManager.JBitSet));
end;

initialization
  RegisterTypes;
end.


