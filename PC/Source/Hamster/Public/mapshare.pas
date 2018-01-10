{ ******************************************************* }
{ �ڴ�ӳ�������ݵ�Ԫ }
{ ******************************************************* }
unit mapshare;

interface

uses
  windows,
  messages;

const
  // �Զ�����Ϣ
  WM_H_MOVE_WINDOW = WM_USER + 7001;
  WM_H_MIN_WINDOW = WM_USER + 7002;
  WM_H_MAX_WINDOW = WM_USER + 7003;
  // qq Ⱥ�������Ϣ
  WM_OPENDIR = WM_USER + 5004;                    // ��QQȺ��ݷ�ʽĿ¼
  WM_QQMSG = WM_USER + 5005;                      // �Զ�����QQ��Ϣ
  WM_GET_GROUP = WM_USER + 5006;                  // ��ȡȺ

  // ΢��Ⱥ�������Ϣ
  WM_GET_WX_GROUP = WM_USER + 5007;
  WM_SEND_WX = WM_USER + 5008;
  WM_STOP = WM_USER + 5009;
  // ��EXCEL�ĵ�
  WM_OPEN_EXCEL = WM_USER + 5010;
  WM_READ_ROW = WM_USER + 5011;
  WM_READ_ALL=WM_USER+5012;

  WM_INIMAIN = WM_USER + 8101;                    // ���ڽ����ĳ�ʼ����Ϣ
  WM_SHOW_TK_LOGIN = WM_USER + 8102;              // ��ʾ�Ա���½����
  WM_GET_TK_COOKIE = WM_USER + 8103;              // ��ȡ�Ա����˻���½���cookie
  WM_TOTKURL = WM_USER + 8104;                    // ��������׬�Կ�����
  WM_GETIMG = WM_USER + 8105;                     // ����ͼƬ�����ص�ַ
  WM_GETMMID = WM_USER + 8106;                    // ��ȡmmid
  WM_OPENURL = WM_USER + 8107;                    // ��URL
  WM_GETRPT = WM_USER + 8108;                     // ��ȡ��������
  WM_GET_COMMONCAMPAIGNBYITEMID = WM_USER + 8109; // ��ȡ����ƻ��б���JSON��ʽ���أ�
  WM_APPLYFORCOMMONCAMPAIGN = WM_USER + 8112;     //  ���붨��ƻ�,POST��ʽ�ύ
  WM_PROMOTIONINFO = WM_USER + 8113;              // ����MemberId��ȡ������Ϣ
  WM_SEARCH = WM_USER + 8114;                     // ��ȡ��Ʒ��ϸ��Ϣ
  WM_TK_SHUTDOWN=WM_USER+8115; //�ػ�
  WM_TK_HTTP_GET=WM_USER+8116;//GET����ʽ
  WM_TK_HTTP_POST=WM_USER+8117;//POST����ʽ

  WM_TK_HGETTKINFO = WM_USER + 8110;
  WM_TK_HAUTOCREATETK = WM_USER + 8111;


  MappingFileName = '{C7F46FCE-7B24-4DFA-90D9-8F9E9EEBAC56}';
  IceMutex = '{2165109E-F55A-45AD-BADD-11AF9D44D6CA}';
  IceMutexLauncher = '{2B6298AD-9ED2-490F-BD78-1AAC63A875A3}';

type
  TShareMem = record
    MHWND: HWND;                                  // �����ھ��
    LHWND: HWND;                                  // Launcher���ھ��
    INDATA: array[0..100000] of Char;
    OUTDATA: array[0..100000] of Char;
    RET: Integer;
  end;

  PShareMem = ^TShareMem;

function CheckForPrevInstance: Boolean;            // �жϳ����Ƿ����� �Ѿ��������� false

function CheckForPrevInstanceLauncher: Boolean;

procedure ClearUpCheckForPrevInstance;

procedure ClearUpCheckForPrevInstanceLauncher;

procedure CopyMChar(p1: string; inout: Byte = 0);

var
  hMapObj: THandle;
  Mutex, MutexLauncher: Cardinal;
  pShMem: PShareMem;

implementation

procedure CopyMChar(p1: string; inout: Byte = 0);
begin
  // �����ַ����ڴ�������
  with pShMem^ do
  begin
    if inout = 0 then
    begin
      FillChar(INDATA, 100000, 0);
      CopyMemory(@(INDATA), PChar(p1), Length(p1) * SizeOf(Char));
    end
    else
    begin
      FillChar(OUTDATA, 100000, 0);
      CopyMemory(@(OUTDATA), PChar(p1), Length(p1) * SizeOf(Char));
    end;
  end;
end;

procedure OpenMap;
begin
  // ���ڴ�ӳ��
  hMapObj := OpenFileMapping(FILE_MAP_WRITE, False, PChar(MappingFileName));

  if hMapObj = 0 then
    hMapObj := CreateFileMapping($FFFFFFFF, nil, PAGE_READWRITE, 0, SizeOf(TShareMem), PChar(MappingFileName));

  pShMem := PShareMem(MapViewOfFile(hMapObj, FILE_MAP_ALL_ACCESS, 0, 0, 0));
  if pShMem = nil then
  begin
    CloseHandle(hMapObj);
    Halt;
  end;

  // FillChar(pShMem^, SizeOf(TShareMem), 0);
end;

procedure CloseMap;
begin
  // �ر��ڴ�ӳ��
  if pShMem <> nil then
    UnmapViewOfFile(pShMem);
  if hMapObj <> 0 then
    CloseHandle(hMapObj);
end;

function CheckForPrevInstance: Boolean;
begin
  // �������Ƿ��Ѿ�����
  Mutex := CreateMutex(nil, True, PChar(IceMutex));
  Result := (Mutex <> 0) and (GetLastError = 0);
end;

procedure ClearUpCheckForPrevInstance;
begin
  if Mutex <> 0 then
  begin
    CloseHandle(Mutex);
    Mutex := 0;
  end;
end;

function CheckForPrevInstanceLauncher: Boolean;
begin
  // �������Ƿ��Ѿ�����
  MutexLauncher := CreateMutex(nil, True, PChar(IceMutexLauncher));
  Result := (MutexLauncher <> 0) and (GetLastError = 0);
end;

procedure ClearUpCheckForPrevInstanceLauncher;
begin
  if MutexLauncher <> 0 then
  begin
    CloseHandle(MutexLauncher);
    MutexLauncher := 0;
  end;
end;


initialization
  OpenMap;

finalization
  CloseMap;

end.

