unit jsapp;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  Common,
  mapshare,
  pubCon;

type
  // ��չ
  TApp = class
    // ���ڲ���
    class function hWMove: Integer;
    class function hWMin: Integer;
    class function hWMax: Integer;
    class function hExitApp: Integer;
    // ��ʾ�Ա���½����
    class function hShowTkLogin: Integer;
    // ��ȡtkuserinfo
    class function hGetTkInfo: Integer;
    // �Զ�������������������
    class function hautoCreateTk(qq: string): Integer;
    // ת�����Լ���Ӷ���ַ
    class function hToTkUrl(fun: string): Integer;
    // ����ͼƬ�����ص�ַ
    class function hGetImg(sUrl: string): string;
    // ��ȡMMID
    class function hGetMmid: string;
    // ʹ��Ĭ���������URL
    class function hOpenUrl(sUrl: string): Integer;
    // ��ȡ��ǰ��������
    class function hGetRpt(t: Integer): string;
    // ��ȡ����ƻ��б���JSON��ʽ���أ�
    class function hGetCommoncampaignbyitemid(iid: string): string;
    // ���붨��ƻ�,POST��ʽ�ύ
    class function hApplyforcommoncampaign(s: string): string;
    // ����MemberId��ȡ������Ϣ
    class function hPromotioninfo(mid: string): string;
    // ��ȡ��Ʒ����
    class function hSearch(s: string): string;
    // ��QQȺ��ݷ�ʽĿ¼
    class function hOpenDir: Integer;
    // ��ʼȺ��QQ��Ϣ
    class function hSendQQMsg(name: string): Integer;
    // ��ȡQQȺ
    class function hGetQQGroup: string;
    // ��ȡ΢��Ⱥ
    class function hGetWXGroup: string;
    // ����΢����Ϣ
    class function hSendWxMsg(name: string): Integer;
    // ��excel�ĵ�
    class function hOpenExcel: Integer;
    // �����кŶ�ȡEXCEL�ĵ����ݲ���װ��JSON��ʽ
    class function hReadRow(iid: string): string;
    //��ȡexcelȫ������ ������JSON��ʽ�ַ���
    class function hReadAll():string;
    //��ȡhttpGet���� ��������Ϣ
    class function hHttpGet(url:string):string;
    class function hHttpPost(json:string):string;
  end;

implementation

// ��갴��
class function TApp.hWMove: Integer;
begin
  Result := SendMessage(pShMem^.MHWND, WM_H_MOVE_WINDOW, 0, 0);
end;

class function TApp.hWMin: Integer;
begin
  Result := SendMessage(pShMem^.MHWND, WM_H_MIN_WINDOW, 0, 0);
end;

class function TApp.hWMax: Integer;
begin
  Result := SendMessage(pShMem^.MHWND, WM_H_MAX_WINDOW, 0, 0);
end;

class function TApp.hExitApp: Integer;
begin
  // �˳�С����
  Result := SendMessage(pShMem^.MHWND, WM_CLOSE, 0, 0);
end;

class function TApp.hShowTkLogin: Integer;
begin
  // ��ʾ�Ա���½����
  SendMessage(pShMem^.MHWND, WM_SHOW_TK_LOGIN, 0, 0);
  Result := pShMem^.ret;
end;

class function TApp.hGetTkInfo: Integer;
begin
  // ��ȡ�Կ���Ϣ
  SendMessage(pShMem^.MHWND, WM_TK_HGETTKINFO, 0, 0);
  Result := pShMem^.ret;
end;

class function TApp.hautoCreateTk(qq: string): Integer;
begin
  // �Զ��������λ
  CopyMChar(qq);
  Result := SendMessage(pShMem^.MHWND, WM_TK_HAUTOCREATETK, 0, 0);
end;

class function TApp.hToTkUrl(fun: string): Integer;
begin
  with pShMem^ do
  begin
    CopyMChar(fun);       // json����
    if PostMessage(MHWND, WM_TOTKURL, 0, 0) then
      Result := 1
    else
      Result := 0;
  end;
end;

// ����ͼƬ�����ص�ַ
class function TApp.hGetImg(sUrl: string): string;
begin
  with pShMem^ do
  begin
    CopyMChar(sUrl);
    SendMessage(MHWND, WM_GETIMG, 0, 0);
    Result := StrPas(OUTDATA);
  end;
end;

// ��ȡMMID
class function TApp.hGetMmid: string;
begin
  with pShMem^ do
  begin
    SendMessage(MHWND, WM_GETMMID, 0, 0);
    Result := StrPas(OUTDATA);
  end;
end;

// ʹ��Ĭ���������URL
class function TApp.hOpenUrl(sUrl: string): Integer;
begin
  with pShMem^ do
  begin
    CopyMChar(sUrl);
    Result := SendMessage(MHWND, WM_OPENURL, 0, 0);
  end;
end;

// ��ȡ��ǰ��������
class function TApp.hGetRpt(t: Integer): string;
begin
  with pShMem^ do
  begin
    ret := t;
    SendMessage(MHWND, WM_GETRPT, 0, 0);
    Result := StrPas(OUTDATA);
  end;
end;

// ��ȡ����ƻ��б���JSON��ʽ���أ�
class function TApp.hGetCommoncampaignbyitemid(iid: string): string;
begin
  with pShMem^ do
  begin
    CopyMChar(iid);
    SendMessage(MHWND, WM_GET_COMMONCAMPAIGNBYITEMID, 0, 0);
    Result := StrPas(OUTDATA);
  end;
end;

// ���붨��ƻ�,POST��ʽ�ύ
class function TApp.hApplyforcommoncampaign(s: string): string;
begin
  with pShMem^ do
  begin
    CopyMChar(s);
    SendMessage(MHWND, WM_APPLYFORCOMMONCAMPAIGN, 0, 0);
    Result := StrPas(OUTDATA);
  end;
end;

// ����MemberId��ȡ������Ϣ
class function TApp.hPromotioninfo(mid: string): string;
begin
  with pShMem^ do
  begin
    CopyMChar(mid);
    SendMessage(MHWND, WM_PROMOTIONINFO, 0, 0);
    Result := StrPas(OUTDATA);
  end;
end;

// ��ȡ��Ʒ����
class function TApp.hSearch(s: string): string;
begin
  with pShMem^ do
  begin
    CopyMChar(s);
    SendMessage(MHWND, WM_SEARCH, 0, 0);
    Result := StrPas(OUTDATA);
  end;
end;

//���ļ���
class function TApp.hOpenDir: Integer;
begin
  Result := SendMessage(pShMem^.MHWND, WM_OPENDIR, 0, 0);
end;

// ��ʼȺ��QQ��Ϣ
class function TApp.hSendQQMsg(name: string): Integer;
begin
  with pShMem^ do
  begin
    CopyMChar(name);
    if PostMessage(MHWND, WM_QQMSG, 0, 0) then
      Result := 1
    else
      Result := 0;
  end;
end;

// ��ȡQQȺ
class function TApp.hGetQQGroup: string;
begin
  with pShMem^ do
  begin
    SendMessage(MHWND, WM_GET_GROUP, 0, 0);
    Result := StrPas(OUTDATA);
  end;
end;

// ��ȡ΢��Ⱥ
class function TApp.hGetWXGroup: string;
begin
  with pShMem^ do
  begin
    SendMessage(MHWND, WM_GET_WX_GROUP, 0, 0);
    Result := StrPas(OUTDATA);
  end;
end;

// ����΢����Ϣ
class function TApp.hSendWxMsg(name: string): Integer;
begin
  with pShMem^ do
  begin
    CopyMChar(name);
    if PostMessage(MHWND, WM_SEND_WX, 0, 0) then
      Result := 1
    else
      Result := 0;
  end;
end;

// ��excel�ĵ�  ��������
class function TApp.hOpenExcel: Integer;
begin
  with pShMem^ do
  begin
    SendMessage(MHWND, WM_OPEN_EXCEL, 0, 0);
    Result := RET;
  end;

end;

// �����кŶ�ȡEXCEL�ĵ����ݲ���װ��JSON��ʽ
class function TApp.hReadRow(iid: string): string;
begin
  with pShMem^ do
  begin
    RET := StrToInt(iid);
    SendMessage(MHWND, WM_READ_ROW, 0, 0);
    Result := StrPas(OUTDATA);
  end;
end;

class function TApp.hReadAll():string;
begin
    with pShMem^ do
    begin
      SendMessage(MHWND,WM_READ_ALL,0,0);
      Result:=StrPas(OUTDATA);
    end;
end;

class function TApp.hHttpGet(url: string):string;
begin
   with pShMem^ do
   begin
      CopyMChar(url);
      SendMessage(MHWND,WM_TK_HTTP_GET,0,0);
      Result:=StrPas(OUTDATA);
   end;
end;

class function TApp.hHttpPost(json:string):string;
begin
   with pShMem^ do
   begin
      CopyMChar(json);
      SendMessage(MHWND,WM_TK_HTTP_POST,0,0);
      Result:=StrPas(OUTDATA);
   end;
end;

end.

