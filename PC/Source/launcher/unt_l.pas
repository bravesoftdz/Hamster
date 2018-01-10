unit unt_l;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  CnCommon,
  ShlObj,
  mapshare,
  Vcl.Dialogs,
  Vcl.ExtCtrls;

type
  TfrmLauncher = class(TForm)
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure onhExit(var MSG: TMessage); message WM_USER + 4300;
    procedure onIni(var MSG: TMessage); message WM_USER + 4301;
  public
    { Public declarations }
  end;

var
  frmLauncher: TfrmLauncher;
  hIsClose: Boolean = False;

implementation

{$R *.dfm}
procedure TfrmLauncher.onIni(var MSG: TMessage);
begin
  hIsClose := False;
  // ���������򲢵ȴ�����
  if WinExecAndWait32(AppPath + 'Hamster.exe') > -1 then
  begin
    Timer1.Interval := 1000 * 3;
    Timer1.Enabled := True;
  end;
end;

procedure TfrmLauncher.FormCreate(Sender: TObject);
begin
  pShMem^.LHWND := Handle;
  PostMessage(Handle, WM_USER + 4301, 0, 0);
end;

procedure TfrmLauncher.onhExit(var MSG: TMessage);
begin
  // ���յ�����������������ر���Ϣ
  hIsClose := True;
end;

procedure TfrmLauncher.Timer1Timer(Sender: TObject);
begin
  if hIsClose then
  begin
    // �����˳�
    Close;
  end
  else
  begin
    Timer1.Enabled := False;
    // �������˳�
    if MessageBox(Handle, '������������������' + #13#10#13#10 + '�Ƿ���Ҫ�޸���������������������Կ����֡���', '�����Կ�����', MB_YESNO + MB_ICONINFORMATION) = IDYES then
    begin
      // ������ɾ��������վ�ɹ������������������Ϣ
      if DeleteToRecycleBin(GetSpecialFolderLocation(CSIDL_COMMON_APPDATA) + '\Hamster\Cache') then
        PostMessage(Handle, WM_USER + 4301, 0, 0);
    end
    else
      Close;

  end;
end;

end.

