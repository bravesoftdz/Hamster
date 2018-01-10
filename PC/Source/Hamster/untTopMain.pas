unit untTopMain;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  Winapi.ShlObj,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.DateUtils,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.OleCtrls,
  Vcl.Buttons,
  Vcl.DockTabSet,
  Vcl.ComCtrls,
  Vcl.Menus,
  Vcl.ActnList,
  Vcl.StdCtrls,
  DcefB.Core.App,
  DcefB.Core.DcefBrowser,
  DcefB.Cef3.Interfaces,
  DcefB.Cef3.Types,
  DcefB.Cef3.Classes,
  Web.HTTPApp,
  IdBaseComponent,
  IdHTTP,
  IdAntiFreezeBase,
  Vcl.IdAntiFreeze,
  Common,
  CnInetUtils,
  mapshare,
  pubCon,
  CometSkin,
  CnCommon,
  JwaWinUser,
  jsapp,
  XLSFonts4,
  XLSReadWriteII4,
  CnClasses,
  CnFileSystemWatcher;

type
  TtopMain = class(TSkinFormEx)
    cefMain: TDcefBrowser;
    Button1: TButton;
    IdAntiFreeze1: TIdAntiFreeze;
    OpenDialog1: TOpenDialog;
    xls: TXLSReadWriteII4;
    cfsWatcher: TCnFileSystemWatcher;
    procedure FormCreate(Sender: TObject);
    procedure cefMainBeforeContextMenu(const browser: ICefBrowser; const frame: ICefFrame; const params: ICefContextMenuParams; const model: ICefMenuModel);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cefMainBeforePopup(const browser: ICefBrowser; const frame: ICefFrame; const targetUrl, targetFrameName: ustring; targetDisposition: TCefWindowOpenDisposition; userGesture: Boolean; var popupFeatures: TCefPopupFeatures; var windowInfo: TCefWindowInfo; var client: ICefClient; var settings: TCefBrowserSettings; var noJavascriptAccess, Cancel, CancelDefaultEvent: Boolean);
    procedure cefMainDownloadUpdated(const browser: ICefBrowser; const downloadItem: ICefDownloadItem; const callback: ICefDownloadItemCallback);
    procedure Button1Click(Sender: TObject);
    procedure cefMainLoadEnd(const browser: ICefBrowser; const frame: ICefFrame; httpStatusCode: Integer);
    procedure cefMainLoadError(const browser: ICefBrowser; const frame: ICefFrame; errorCode: Integer; const errorText, failedUrl: ustring; var CancelDefaultEvent: Boolean);
    procedure cfsWatcherChange(Sender: TObject; FileOperation: TFileOperation; const FileName1, FileName2: string);
  private
    procedure WMExitSizeMove(var Message: TMessage); message WM_EXITSIZEMOVE;
    procedure _ini(var MSG: TMessage); message WM_INIMAIN;
    procedure _MoveWindow(var MSG: TMessage); message WM_H_MOVE_WINDOW;
    procedure _MinWindow(var MSG: TMessage); message WM_H_MIN_WINDOW;
    procedure _MaxWindow(var MSG: TMessage); message WM_H_MAX_WINDOW;
    procedure _ShowTkLogin(var MSG: TMessage); message WM_SHOW_TK_LOGIN;
    procedure _ToTkUrl(var MSG: TMessage); message WM_TOTKURL;
    procedure _GetImg(var MSG: TMessage); message WM_GETIMG;
    procedure _getTkInfo(var MSG: TMessage); message WM_TK_HGETTKINFO;
    procedure _autoCreateTk(var MSG: TMessage); message WM_TK_HAUTOCREATETK;
    procedure _getMmid(var MSG: TMessage); message WM_GETMMID;
    procedure _getRpt(var MSG: TMessage); message WM_GETRPT;
    procedure _openUrl(var MSG: TMessage); message WM_OPENURL;
    procedure _getCommoncampaignbyitemid(var MSG: TMessage); message WM_GET_COMMONCAMPAIGNBYITEMID;
    procedure _applyforcommoncampaign(var MSG: TMessage); message WM_APPLYFORCOMMONCAMPAIGN;
    procedure _promotioninfo(var MSG: TMessage); message WM_PROMOTIONINFO;
    procedure _search(var MSG: TMessage); message WM_SEARCH;
    procedure _OpenDir(var MSG: TMessage); message WM_OPENDIR;                  //��Ⱥ���ļ���
    procedure _SendQQMessage(var MSG: TMessage); message WM_QQMSG;              //����QQ��Ϣ
    procedure _GetQQGroup(var MSG: TMessage); message WM_GET_Group;             // ��ȡQQȺ

    procedure _GetWXGroup(var MSG: TMessage); message WM_GET_WX_GROUP;
    procedure _SendWXMessage(var MSG: TMessage); message WM_SEND_WX;
    procedure _OpenExcel(var MSG: TMessage); message WM_OPEN_EXCEL;      // ��EXCEL
    procedure _ReadRow(var MSG: TMessage); message WM_READ_ROW;
    procedure _ReadAll(var MSG: TMessage); message WM_READ_ALL;
    procedure _HttpGet(var MSG: TMessage); message WM_TK_HTTP_GET; //ͨ��������
    procedure _HttpPost(var MSG: TMessage); message WM_TK_HTTP_POST;
  public
    function httpGet(url: string): string; // ����GET����
    function httpPost(url: string; data: string): string; //POST����
    procedure cefSize;         // ����CEF���ڵĴ�С
    procedure getTkInfo;       // ͨ���ӿڻ�ȡ��½���û��������Ϣ �����Ȼ�ȡcookie;
    procedure autoCreateTk;    // �Զ�������������������
    function createAdzonecreate: Boolean; // ��������
    function createGuideadd(qq: string): Boolean;  // ��������λ
    procedure getSClick(iid, fun: string); // ��ȡ�Կ�����
    function getImg(turl: string): string; // ����ͼƬ�����ر���·��
    function getMmid: string; // ��ȡmmid
    function getRpt(t: Integer): string; // ��ȡ��ǰ��������
    function getCommoncampaignbyitemid(iid: string): string; // ������ƷID��ȡ����Ʒ�Ķ���ƻ�
    function applyforcommoncampaign(s: string): string;  // ���붨��ƻ�,POST��ʽ�ύ
    function getPromotioninfo(mid: string): string; // ����MemberId��ȡ������Ϣ
    function getSearch(s: string): string; // ��ȡ��Ʒ��ϸ��Ϣ
    function searchInk(Path: string): string; // ����QQȺ��lnk
    procedure AppException(Sender: TObject; E: Exception);
  end;

var
  topMain: TtopMain;
  tk_otherAdzones_name, tk_siteid, tk_otherAdzones_sub_name, tk_adzoneid: string;
  tkState: Byte = 0; // ��ǰ�Կ��ʺ�״̬ 1=����״̬��2=û�е������ƣ�22=û��������
  tClick: DWORD;
  qqLnkPath: string; // qqȺlnk���·��

implementation

uses
{$IFDEF DEBUG}
  CnDebug,
{$ENDIF}
  superobject,
  untMMLogin;
{$R *.dfm}

function TtopMain.httpGet(url: string): string;
var
  http: TIdHTTP;
  _cookie, ret: string;
begin
  http := TIdHTTP.Create(nil);
  try
    _cookie := 'Cookie: ' + cookie;
    http.HandleRedirects := True;
    http.Request.UserAgent := DcefBApp.CefUserAgent;
    http.Request.CustomHeaders.Add(_cookie);
    ret := http.Get(url);
    if ret[1] = '{' then
      Result := ret
    else if InStr('deny.html', http.Request.URL) then
      Result := 'ndk'    // ����Ƶ��
    else if InStr('login.htm', http.Request.URL) then
      Result := 'nck'    // δ��¼��COOKIEʧЧ
    else if InStr('limit_status.htm', http.Request.URL) then
      Result := 'ntk';   // ���Ա����˺�
  finally
    http.Free;
  end;
end;

function TtopMain.httpPost(url: string; data: string): string;
var
  http: TIdHTTP;
  _cookie: string;
  PostDataStream: TStringStream;
  ParamData: TStringStream;
begin
  http := TIdHTTP.Create(nil);
  try
    _cookie := 'Cookie: ' + cookie;
    PostDataStream := TStringStream.Create('');
    ParamData := TStringStream.Create('');
    ParamData.WriteString(data);
    http.HandleRedirects := True;
    http.Request.UserAgent := DcefBApp.CefUserAgent;
    http.Request.CustomHeaders.Add(_cookie);
    http.Post(url, ParamData, PostDataStream);
    PostDataStream.Position := 0;
    Result := PostDataStream.DataString;
  finally
    http.Free;
  end;
end;

procedure TtopMain.cefSize;
var
  x1, x2: Integer;
begin
  if IsZoomed(Handle) then
  begin
    x1 := 0;
    x2 := 0;
  end
  else
  begin
    x1 := 1;
    x2 := 2;
  end;
  with cefMain do
  begin
    Left := x1;
    Top := x1;
    Width := topMain.ClientWidth - x2;
    Height := topMain.ClientHeight - x2;
  end;
end;

procedure TtopMain.cfsWatcherChange(Sender: TObject; FileOperation: TFileOperation; const FileName1, FileName2: string);
var
  FileName: string;
var
  FileName3: string;
begin
  case FileOperation of
    TFileOperation.foAdded:
      begin
        cefMain.ActiveBrowser.MainFrame.ExecuteJavaScript('QQGroup("Add","' + ChangeFileExt(ExtractFileName(FileName1), '') + '");', 'about:blank', 0);
      end;
    TFileOperation.foRemoved:
      cefMain.ActiveBrowser.MainFrame.ExecuteJavaScript('QQGroup("remove","' + ChangeFileExt(ExtractFileName(FileName1), '') + '");', 'about:blank', 0);
    TFileOperation.foRenamed:
      cefMain.ActiveBrowser.MainFrame.ExecuteJavaScript('QQGroup("rename","' + ChangeFileExt(ExtractFileName(FileName1), '') + '","' + ChangeFileExt(ExtractFileName(FileName2), '') + '");', 'about:blank', 0);
    TFileOperation.foModified:
      cefMain.ActiveBrowser.MainFrame.ExecuteJavaScript('QQGroup("rename","' + ChangeFileExt(ExtractFileName(FileName1), '') + '","' + ChangeFileExt(ExtractFileName(FileName2), '') + '");', 'about:blank', 0);
  end;
end;

// ���ڴ�С�ı����
procedure TtopMain.WMExitSizeMove(var Message: TMessage);
begin
  cefSize;
end;

// ���ڽ����ĳ�ʼ����Ϣ�������
procedure TtopMain._ini(var MSG: TMessage);
begin
  cefSize;  // ��������Ԫ�ص�λ��
  cefMain.AddPage(D_MAIN_URL);
  cefMain.AddPage(AppPath + '\skin\top\index.html');

  // ����qqȺ����ݷ�ʽĿ¼
  qqLnkPath := GetSpecialFolderLocation(CSIDL_COMMON_APPDATA) + '\Hamster\Group';
  if not DirectoryExists(qqLnkPath) then
  begin
    ForceDirectories(qqLnkPath);
  end;

  cin(2);  // ����ͳ��
end;

// �����ƶ�
procedure TtopMain._MoveWindow(var MSG: TMessage);
begin
  ReleaseCapture;
  SendMessage(Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
end;

// ������С��
procedure TtopMain._MinWindow(var MSG: TMessage);
begin
  SendMessage(Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
end;

// �������
procedure TtopMain._MaxWindow(var MSG: TMessage);
begin
  if IsZoomed(Handle) then
    SendMessage(Handle, WM_SYSCOMMAND, SC_RESTORE, 0)
  else
    SendMessage(Handle, WM_SYSCOMMAND, SC_MAXIMIZE, 0);
end;

// ��ʾ�Ա���½����
procedure TtopMain._ShowTkLogin(var MSG: TMessage);
begin
  pShMem^.ret := frmMMLogin.ShowModal;
end;

// ���ջ�ȡTK������Ϣ
procedure TtopMain._ToTkUrl(var MSG: TMessage);
var
  iid, jstr, fun: string;
  sObj: ISuperObject;
begin
  try
    with pShMem^ do
    begin
      jstr := StrPas(INDATA);
      if jstr[1] = '{' then
      begin
        sObj := SO(jstr);
        iid := sObj.S['iid'];
        fun := sObj.S['fun'];
        getSClick(iid, fun);
      end;
    end;
  except

  end;
end;

// ���ջ�ȡimg������Ϣ
procedure TtopMain._GetImg(var MSG: TMessage);
var
  imgUrl, path: string;
begin
  with pShMem^ do
  begin
    imgUrl := StrPas(INDATA);
    path := getImg(imgUrl);
    CopyMChar(path, 1);
  end;
end;

procedure TtopMain._getTkInfo(var MSG: TMessage);
begin
  getTkInfo;
end;

procedure TtopMain._autoCreateTk(var MSG: TMessage);
begin
  autoCreateTk;
end;

// ��ȡMMID
procedure TtopMain._getMmid(var MSG: TMessage);
var
  sRet: string;
begin
  with pShMem^ do
  begin
    sRet := getMmid;
    CopyMChar(sRet, 1);
  end;
end;

// ʹ��Ĭ���������url
procedure TtopMain._openUrl(var MSG: TMessage);
var
  sUrl: string;
begin
  sUrl := StrPas(pShMem^.INDATA);
  OpenUrl(sUrl, True);
end;

procedure TtopMain._getRpt(var MSG: TMessage);
var
  sRet: string;
begin
  // ��ȡ��������
  with pShMem^ do
  begin
    sRet := getRpt(ret);
    CopyMChar(sRet, 1);
  end;
end;

// ��ȡ��������
procedure TtopMain._getCommoncampaignbyitemid(var MSG: TMessage);
var
  sRet, inStr: string;
begin
  with pShMem^ do
  begin
    inStr := StrPas(INDATA);
    sRet := getCommoncampaignbyitemid(inStr);
    CopyMChar(sRet, 1);
  end;
end;

procedure TtopMain._applyforcommoncampaign(var MSG: TMessage);
var
  sRet, inStr: string;
begin
  // ���붨��ƻ�,POST��ʽ�ύ
  with pShMem^ do
  begin
    inStr := StrPas(INDATA);
    sRet := applyforcommoncampaign(inStr);
    CopyMChar(sRet, 1);
  end;
end;

// ����MemberId��ȡ������Ϣ
procedure TtopMain._promotioninfo(var MSG: TMessage);
var
  sRet, inStr: string;
begin
  with pShMem^ do
  begin
    inStr := StrPas(INDATA);
    sRet := getPromotioninfo(inStr);
    CopyMChar(sRet, 1);
  end;
end;

// ��ȡ��Ʒ��ϸ��Ϣ
procedure TtopMain._search(var MSG: TMessage);
var
  sRet, inStr: string;
begin
  with pShMem^ do
  begin
    inStr := StrPas(INDATA);
    sRet := getSearch(inStr);
    CopyMChar(sRet, 1);
  end;
end;

// ���ļ���
procedure TtopMain._OpenDir(var MSG: TMessage);
begin
  ExploreDir(qqLnkPath, True);
end;

// ����QQ��Ϣ
procedure TtopMain._SendQQMessage(var MSG: TMessage);
var
  name: string;
  _hwnd: DWORD;
begin
  with pShMem^ do
  begin
    name := StrPas(INDATA);
    RunFile(qqLnkPath + '\' + name + '.lnk');
    Sleep(2000);
    _hwnd := FindWindow('TXGuiFoundation', PChar(name));
//    StayOnTop(_hwnd, True);
    SwitchToThisWindow(_hwnd, True);
    cv;
    cefMain.JsExtention.GetExecuteScriptResultProc(cefMain.ActiveBrowser, 'qqcomplate();', nil);
  end;
end;

// ��ȡQQȺ
procedure TtopMain._GetQQGroup(var MSG: TMessage);
var
  lnkList: string;
begin
  lnkList := searchInk(qqLnkPath);
  with pShMem^ do
  begin
    CopyMChar(lnkList, 1);
  end;
end;

// ��ȡ΢��Ⱥ
procedure TtopMain._GetWXGroup(var MSG: TMessage);
var
  h: HWND;
  p: array[0..255] of char;
  names: string;
  clname: string;
begin
  h := GetWindow(Handle, GW_HWNDFIRST);
  names := '[';
  clname := 'ChatWnd';
  while h <> 0 do
  begin
    GetClassName(h, p, Length(p));
    if p = clname then
    begin
      GetWindowText(h, p, Length(p));
      names := names + '"' + p + '",';
    end;
    h := GetWindow(h, GW_HWNDNEXT);
  end;
  if Length(names) = 1 then
  begin
    names := '[]';
  end
  else
  begin
    names := Copy(names, 0, Length(names) - 1) + ']';
  end;
  with pShMem^ do
  begin
    CopyMChar(names, 1);
  end;
end;

// ����΢����Ϣ
procedure TtopMain._SendWXMessage(var MSG: TMessage);
var
  h: DWORD;
  name: string;
  clname: string;
begin
  with pShMem^ do
  begin
    clname := 'ChatWnd';
    name := StrPas(INDATA);
    h := FindWindow(PWideChar(clname), PWideChar(name));
//    StayOnTop(h, True);
    SwitchToThisWindow(h, True);
    send(h);
    cefMain.JsExtention.GetExecuteScriptResultProc(cefMain.ActiveBrowser, 'wxcomplate();', nil);
  end;
end;

procedure TtopMain._OpenExcel(var MSG: TMessage);
begin
  if OpenDialog1.Execute(Handle) then
  begin
    xls.Clear;
    xls.Filename := OpenDialog1.FileName;
    xls.Read;
    with pShMem^ do
    begin

      ret := xls.Sheet[0].LastRow;
    end;
  end
  else
  begin
    with pShMem^ do
    begin
      ret := -1;
    end;
  end;
end;

procedure TtopMain._ReadRow(var MSG: TMessage);
var
  iRow: Integer;
  //sObj: ISuperObject;
  jCol: string;
  fmartStr: string;
begin
  with pShMem^ do
  begin
    iRow := ret;
    jCol := xls.Sheet[0].AsString[9, 0];
    iRow := iRow + 1;
    //sObj:=SO;
    fmartStr := '{gid:"%s",name:"%s",pic:"%s",url:"%s",price:"%s",commissionRate:"%s",commission:"%s",shortUrl:"%s",taoToken:"%s",couponInfo:"%s",couponTaoToken:"%s",couponShotUrl:"%s",isHeightCom:%s}';
    if '�״̬' = Trim(jCol) then
    begin
      // ��Ӷ��XLS
      fmartStr := Format(fmartStr, [xls.Sheet[0].AsString[0, iRow], xls.Sheet[0].AsString[1, iRow], xls.Sheet[0].AsString[2, iRow], xls.Sheet[0].AsString[3, iRow], xls.Sheet[0].AsString[5, iRow], xls.Sheet[0].AsString[10, iRow], xls.Sheet[0].AsString[11, iRow], xls.Sheet[0].AsString[15, iRow], xls.Sheet[0].AsString[17, iRow], xls.Sheet[0].AsString[20, iRow], xls.Sheet[0].AsString[24, iRow], xls.Sheet[0].AsString[25, iRow], 'true']);
    end
    else
    begin
      fmartStr := Format(fmartStr, [xls.Sheet[0].AsString[0, iRow], xls.Sheet[0].AsString[1, iRow], xls.Sheet[0].AsString[2, iRow], xls.Sheet[0].AsString[3, iRow], xls.Sheet[0].AsString[5, iRow], xls.Sheet[0].AsString[7, iRow], xls.Sheet[0].AsString[8, iRow], xls.Sheet[0].AsString[10, iRow], xls.Sheet[0].AsString[12, iRow], xls.Sheet[0].AsString[15, iRow], xls.Sheet[0].AsString[19, iRow], xls.Sheet[0].AsString[20, iRow], 'false']);
    end;
    CopyMChar(fmartStr, 1);
     //sObj:=nil;
  end;
end;

procedure TtopMain._ReadAll(var MSG: TMessage);
var
  count: Integer;
  formatStr: string;
  jCol: string;
  i: Integer;
  rnum: Integer;
  returnJsonStr: string;
begin
  count := xls.Sheet[0].LastRow;
  formatStr := '{gid:"%s",name:"%s",pic:"%s",url:"%s",price:"%s",commissionRate:"%s",commission:"%s",shortUrl:"%s",taoToken:"%s",couponInfo:"%s",couponTaoToken:"%s",couponShotUrl:"%s",isHeightCom:%s}';
  jCol := xls.Sheet[0].AsString[9, 0];
  returnJsonStr := '';
  if '�״̬' = Trim(jCol) then
  begin
    for rnum := 0 to count - 1 do
    begin
      i := rnum + 1;
      returnJsonStr := Concat(returnJsonStr, Format(formatStr, [xls.Sheet[0].AsString[0, i], xls.Sheet[0].AsString[1, i], xls.Sheet[0].AsString[2, i], xls.Sheet[0].AsString[3, i], xls.Sheet[0].AsString[5, i], xls.Sheet[0].AsString[10, i], xls.Sheet[0].AsString[11, i], xls.Sheet[0].AsString[15, i], xls.Sheet[0].AsString[17, i], xls.Sheet[0].AsString[20, i], xls.Sheet[0].AsString[24, i], xls.Sheet[0].AsString[25, i], 'true']), ',');
    end;
  end
  else
  begin
    for rnum := 0 to count - 1 do
    begin
      i := rnum + 1;
      returnJsonStr := Concat(returnJsonStr, Format(formatStr, [xls.Sheet[0].AsString[0, i], xls.Sheet[0].AsString[1, i], xls.Sheet[0].AsString[2, i], xls.Sheet[0].AsString[3, i], xls.Sheet[0].AsString[5, i], xls.Sheet[0].AsString[7, i], xls.Sheet[0].AsString[8, i], xls.Sheet[0].AsString[10, i], xls.Sheet[0].AsString[12, i], xls.Sheet[0].AsString[15, i], xls.Sheet[0].AsString[19, i], xls.Sheet[0].AsString[20, i], 'false']), ',');
    end;
  end;
  if Length(returnJsonStr) = 0 then
  begin
    returnJsonStr := '[]';
  end
  else
  begin
    returnJsonStr := '[' + StrLeft(returnJsonStr, Length(returnJsonStr) - 1) + ']';
  end;
  with pShMem^ do
  begin
    CopyMChar(returnJsonStr, 1);
  end;
end;

procedure TtopMain._HttpGet(var MSG: TMessage);
var
  res, url: string;
begin
    //res:= httpGet(url);
  with pShMem^ do
  begin
    url := StrPas(pShMem^.INDATA);
    res := httpGet(url);
    CopyMChar(res, 1);
  end;
end;

procedure TtopMain._HttpPost(var MSG: TMessage);
var
  res, json, data, url: string;
  jsonObj: ISuperObject;
begin
  with pShMem^ do
  begin
    json := StrPas(pShMem^.INDATA);
    jsonObj := SO(json);
    url := jsonObj['url'].AsString;
    data := jsonObj['data'].AsString;
    res := httpPost(url, data);
    CopyMChar(res, 1);
  end;
end;

// ----------------------------��Ϣ����

// ----------------------------����
// ��ȡ�û������Ϣ
procedure TtopMain.getTkInfo;
var
  tk_info: string;
  sObj, data: ISuperObject;
  otherAdzones, sub: TSuperArray;
  i, subi: Integer;
  name, id, subName, subId: string;
begin
  try
    tkState := 0;  // ֵΪ0���������쳣
    tk_info := httpGet(Format(D_TK_USER_INFO, [token]));
    if tk_info[1] = '{' then
    begin
      sObj := SO(tk_info);
      data := sObj.N['data'];
      otherAdzones := data.A['otherAdzones'];
      tkState := 2; // ��tkStateһ����ʼֵ �ٶ�������������
      // �ж�otherAdzones �Ƿ�Ϊ��
      if otherAdzones <> nil then
      begin
        // ѭ����ȡ��������
        for i := 0 to otherAdzones.Length - 1 do
        begin
          name := otherAdzones.N[i].S['name'];
          id := otherAdzones.N[i].S['id'];
          sub := otherAdzones.N[i].A['sub'];
          // �ж��Ƿ���� �����Կ����˵ĵ�����
          if name = otherAdzones_name then
          begin
            tkState := 1;
            tk_otherAdzones_name := name;
            tk_siteid := id;
            Break; // ����ѭ��
          end;
        end;

        // ���ﵱ tkState = 1 ˵������������
        if tkState = 1 then
        begin
          tkState := 22; // ����ٶ�������������
          // �ж�sub�Ƿ�Ϊ��
          if sub <> nil then
          begin
            // ѭ����ȡ������
            for subi := 0 to sub.Length - 1 do
            begin
              subName := sub.N[subi].S['name'];
              subId := sub.N[subi].S['id'];
              // �ж��Ƿ���� �����Կ��ƹ�λ�� ������
              if subName = otherAdzones_sub_name then
              begin
                tkState := 1;
                tk_otherAdzones_sub_name := subName;
                tk_adzoneid := subId;
                Break; // ����ѭ��
              end;
            end;
          end;
        end;
      end;
    end
    else if tk_info = 'ndk' then
      tkState := 3
    else if tk_info = 'nck' then
      tkState := 4
    else if tk_info = 'ntk' then
      tkState := 5;
    // �����ڴ����������״̬
    pShMem^.ret := tkState;
  except
  end;
end;

// �Զ�������������������
procedure TtopMain.autoCreateTk;
var
  qq: string;
begin
  // ��� tkState = 2 ˵��������������
  if tkState = 2 then
  begin
    qq := StrPas(pShMem^.INDATA);
    if createGuideadd(qq) then
      getTkInfo;
  end;

  // ��� tkState = 22˵������������������������
  if tkState = 22 then
  begin
    if createAdzonecreate then
      getTkInfo;
  end;
end;

// ����
procedure TtopMain.Button1Click(Sender: TObject);
begin
  cefMain.ShowDevTools(cefMain.ActiveBrowser);
end;

// ������������
function TtopMain.createAdzonecreate: Boolean;
var
  ret: string;
  Param: TStringList;
  sObj: ISuperObject;
  http: TIdHTTP;
begin
  Result := False;
  http := TIdHTTP.Create(nil);
  Param := TStringList.Create;
  try
    Param.Add('tag=29');
    Param.Add('gcid=8');   // gcid=8�������������
    Param.Add('siteid=' + tk_siteid);
    Param.Add('selectact=add');
    Param.Add('newadzonename=' + otherAdzones_sub_name);
    Param.Add('channelIds=');
    Param.Add('_tb_token_=' + token);

    http.Request.CustomHeaders.Add('Cookie: ' + cookie);
    try
      ret := http.Post(D_TK_API_ADZONECREATE, Param);
      sObj := SO(ret);
      if sObj.B['ok'] = True then
        Result := True;
    except
      Result := False;
    end;
  finally
    Param.Free;
    http.Free;
  end;
end;

// �����ƹ�λ
function TtopMain.createGuideadd(qq: string): Boolean;
var
  ret: string;
  Param: TStringList;
  sObj: ISuperObject;
  http: TIdHTTP;
begin
  Result := False;
  http := TIdHTTP.Create(nil);
  Param := TStringList.Create;
  try
    Param.Add('name=' + otherAdzones_name);
    Param.Add('categoryId=13');
    Param.Add('account1=' + qq);
    Param.Add('account2=');
    Param.Add('_tb_token_=' + token);

    http.Request.CustomHeaders.Add('Cookie: ' + cookie);
    try
      ret := http.Post(D_TK_API_GUIDEADD, Param);
      sObj := SO(ret);
      if sObj.B['ok'] = True then
        Result := True;
    except
      Result := False;
    end;
  finally
    Param.Free;
    http.Free;
  end;
end;

// ��ȡTK��
procedure TtopMain.getSClick(iid, fun: string);
var
  ret: string;
begin
  try
    if (tk_siteid <> '') and (tk_adzoneid <> '') then
    begin
      ret := httpGet(Format(D_TK_API_URLTRANS, [iid, tk_adzoneid, tk_siteid, token]));
      // ִ�лص�����
      if ret[1] = '{' then
        cefMain.JsExtention.GetExecuteScriptResultProc(cefMain.ActiveBrowser, Format('%s(%s,%s);', [fun, iid, ret]), nil)
      else
        cefMain.JsExtention.GetExecuteScriptResultProc(cefMain.ActiveBrowser, Format('%s(%s,"%s");', [fun, iid, ret]), nil);
    end;
  except
  end;
end;

// ��ȡͼƬ�����ر���·��
function TtopMain.getImg(turl: string): string;
var
  mImg: TMemoryStream;
  //http: TIdHTTP;
  extName: string; // ��չ��
begin
  Result := '';
  mImg := TMemoryStream.Create;
  //http := TIdHTTP.Create(nil);
  extName := _CnExtractFileExt(_CnExtractFileName(turl));  // ��url�л�ȡ�ļ���չ��
  try
    if CnInet_GetStream(turl, mImg) then
    begin
      Result := CnGetTempFileName(extName);
      mImg.SaveToFile(Result);
    end;
  finally
    //http.Free;
    mImg.Free;
  end;
end;

// ��ȡMMID
function TtopMain.getMmid: string;
var
  sObj: ISuperObject;
  sub: TSuperArray;
  html: string;
  l, i: Integer;
begin
  Result := 'null';
  for l := 1 to 100 do
  begin
    // ����ҳ����1��100ҳ
    html := httpGet(Format(D_TK_MMID, [l, token]));
    if html[1] = '{' then
    begin
      sObj := SO(html);
      sub := sObj.N['data'].A['pagelist'];
      for i := 0 to sub.Length - 1 do
      begin
        if sub.N[i].S['name'] = otherAdzones_sub_name then
        begin
          Result := sub.N[i].S['adzonePid'];
          Exit;
        end;
      end;
    end
    else
      Break;
  end;
end;

// ��ȡ��������
function TtopMain.getRpt(t: Integer): string;
var
  sObj: ISuperObject;
  html, startTime, endTime: string;
  datas, countMap: string;
begin
  case t of
    1:
      begin
        // ����
        startTime := FormatDateTime('yyyy-mm-dd', IncDay(Date, -1));
        endTime := FormatDateTime('yyyy-mm-dd', IncDay(Date, -1));
      end;
    7:
      begin
        // ��ȥ7��
        startTime := FormatDateTime('yyyy-mm-dd', IncDay(Date, -8));
        endTime := FormatDateTime('yyyy-mm-dd', IncDay(Date, -1));
      end;
    15:
      begin
        // ��ȥ15��
        startTime := FormatDateTime('yyyy-mm-dd', IncDay(Date, -16));
        endTime := FormatDateTime('yyyy-mm-dd', IncDay(Date, -1));
      end;
    30:
      begin
        // ��ȥ30��
        startTime := FormatDateTime('yyyy-mm-dd', IncDay(Date, -30));
        endTime := FormatDateTime('yyyy-mm-dd', IncDay(Date, -1));
      end;
  end;
  html := httpGet(Format(D_TK_GET_RPT2, [tk_siteid, startTime, endTime, token]));
  if html[1] = '{' then
  begin
    sObj := SO(html);
    if sObj.N['info'].B['ok'] = True then
    begin
      countMap := sObj.N['data'].N['countMap'].AsJSon(False, False);
      datas := sObj.N['data'].N['datas'].AsJSon(False, False);
      Result := Format('{"countMap":%s,"datas":%s}', [countMap, datas]);
    end;
  end
  else
    Result := html;
end;

// ��ȡ����ƻ��б���JSON��ʽ���أ�
function TtopMain.getCommoncampaignbyitemid(iid: string): string;
begin
  Result := httpGet(Format(D_TK_GET_COMMONCAMPAIGNBYITEMID, [iid, token]));
end;

// ���붨��ƻ�,POST��ʽ�ύ
function TtopMain.applyforcommoncampaign(s: string): string;
var
  ret: string;
  Param: TStringList;
  sObj: ISuperObject;
  http: TIdHTTP;
begin
  http := TIdHTTP.Create(nil);
  Param := TStringList.Create;
  try
    // �������ݹ�����JSON����
    sObj := SO(s);
    Param.Add('campId=' + sObj.S['campId']);
    Param.Add('keeperid=' + sObj.S['keeperid']);
    Param.Add('applyreason=' + sObj.S['applyreason']);
    Param.Add('_tb_token_=' + token);

    http.Request.CustomHeaders.Add('Cookie: ' + cookie);
    try
      Result := http.Post(D_TK_APPLYFORCOMMONCAMPAIGN, Param);
    except
      Result := '';
    end;
  finally
    Param.Free;
    http.Free;
  end;
end;

// ����MemberId��ȡ������Ϣ
function TtopMain.getPromotioninfo(mid: string): string;
begin
  Result := httpGet(Format(D_TK_PROMOTIONINFO, [mid, token]));
end;

// ��ȡ��Ʒ��ϸ��Ϣ
function TtopMain.getSearch(s: string): string;
begin
  Result := httpGet(Format(D_TK_SEARCH, [HTTPEncode(s), token]));
end;

// ��ȡQQȺ��lnk
function TtopMain.searchInk(Path: string): string;
var
  SearchRec: TSearchRec;
  found: Integer;
begin
  Result := '[';
  found := FindFirst(Path + '\*.lnk', faAnyFile, SearchRec);
  while found = 0 do
  begin
    if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') and (SearchRec.Attr <> faDirectory) then
      Result := Result + '"' + SearchRec.Name + '",';
    found := FindNext(SearchRec);
  end;
  if Length(Result) = 1 then
  begin
    Result := Result + ']';
  end
  else
  begin
    Result := Copy(Result, 0, Length(Result) - 1) + ']';
  end;
  FindClose(SearchRec);
end;
// ----- ��������-----

procedure TtopMain.cefMainBeforeContextMenu(const browser: ICefBrowser; const frame: ICefFrame; const params: ICefContextMenuParams; const model: ICefMenuModel);
begin
  // ȥ��ҳ���ʼ��˵�
  model.remove(Integer(TCefMenuId.MENU_ID_BACK));
  model.remove(Integer(TCefMenuId.MENU_ID_FORWARD));
  model.remove(Integer(TCefMenuId.MENU_ID_PRINT));
  model.remove(Integer(TCefMenuId.MENU_ID_VIEW_SOURCE));
  model.RemoveAt(0);
end;

procedure TtopMain.cefMainBeforePopup(const browser: ICefBrowser; const frame: ICefFrame; const targetUrl, targetFrameName: ustring; targetDisposition: TCefWindowOpenDisposition; userGesture: Boolean; var popupFeatures: TCefPopupFeatures; var windowInfo: TCefWindowInfo; var client: ICefClient; var settings: TCefBrowserSettings; var noJavascriptAccess, Cancel, CancelDefaultEvent: Boolean);
begin
  // ����ҳ������ַ
  CancelDefaultEvent := True;
end;

procedure TtopMain.cefMainDownloadUpdated(const browser: ICefBrowser; const downloadItem: ICefDownloadItem; const callback: ICefDownloadItemCallback);
begin
  //ȡ��CEF�ڲ������ļ�
  //callback.Cancel;
end;

procedure TtopMain.cefMainLoadEnd(const browser: ICefBrowser; const frame: ICefFrame; httpStatusCode: Integer);
var
  ljs: string;
  bc: Integer;
begin
  {$IFDEF DEBUG}
  CnDebugger.LogMsg(frame.url);
  {$ENDIF}
  if inStr('graph.qq.com', frame.url) then
  begin
    // ����QQ��¼��Ĵ�ֱ������
    ljs := 'document.getElementById("lay_main").style.display="none"; ';
    frame.ExecuteJavaScript(ljs, '', 0);
  end;
  if inStr('/hamster/login', frame.url) then
  begin
    // ��ҳ�������Ϻ���ʾQQ��¼��
    ljs := 'document.getElementById("qqlogin").style.display="inline"; ';
    frame.ExecuteJavaScript(ljs, '', 0);
    bc := cefMain.ActiveBrowserId;
    cefMain.CloseBrowser(bc, bc - 1);
  end;

end;

procedure TtopMain.cefMainLoadError(const browser: ICefBrowser; const frame: ICefFrame; errorCode: Integer; const errorText, failedUrl: ustring; var CancelDefaultEvent: Boolean);
begin
  {$IFDEF DEBUG}
  CnDebugger.LogMsgWithLevel(errorText + ' ' + failedUrl, errorCode);
  {$ENDIF}
  if inStr('j1m1.com', failedUrl) then
  begin
    // �ڵ�ǰ����ҳ��ִ�нű�
    cefMain.ActiveBrowser.MainFrame.ExecuteJavaScript('loadfail();', '', 0);
  end;
end;

procedure TtopMain.AppException(Sender: TObject; E: Exception);
begin
  // ����ٳ�
  try
  except
  end;
end;

procedure TtopMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // �ر�ʱ������Ϣ
  PostMessage(pShMem^.LHWND, WM_USER + 4300, 0, 0);
end;

procedure TtopMain.FormCreate(Sender: TObject);
begin
  Application.OnException := AppException;
  {$IFDEF DEBUG}
  //Button1.Visible := True;
  cefMain.DcefBOptions.DevToolsEnable := True;
  {$ENDIF}
  pShMem^.MHWND := topMain.Handle;

  Width := 975;
  Height := 650;
  Constraints.MinHeight := 650;
  Constraints.MinWidth := 975;

  PostMessage(Handle, WM_INIMAIN, 0, 0);  // ��ʼ��������
end;

procedure TtopMain.FormResize(Sender: TObject);
begin
  if (GetTickCount - tClick) > 500 then
  begin
    cefSize;
    tClick := GetTickCount;
  end;

end;

initialization
  DcefBApp.RegisterClasses([TApp]);

end.

