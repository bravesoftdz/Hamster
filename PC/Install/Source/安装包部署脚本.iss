#Define Plugin_UnInst true
#Define Plugin_UnInst_Dir "Unins"
#include "AllMove.Ish"
#include "botva2.ish"
#include "ProgressBar.ish"
#include "Botva2_Visual.Ish"
#include "istask.ish"

#define APPID "{C2216201-4D92-4462-A884-BE113AAB8AAA}"
#define WPAppName "�����Կ�����"
#define WPpubVer "2.0.1.21"
#define WPCSetup "1"
#define WPCuninstall "0"
#define WPCID "3"
#define WPREG "Hamster"
#define WPDIR "Hamster"
#define UCPDIR "Hamster"

[Setup]
AppId={{#APPID}
AppName={#WPAppName}
AppVersion={#WPpubVer}
AppPublisher=���׿Ƽ�
DefaultDirName={pf}\{#WPDIR}
DefaultGroupName={#WPAppName}
OutputDir=..\Output
OutputBaseFilename={#WPDIR}-{#WPpubVer}
VersionInfoVersion={#WPpubVer}
VersionInfoDescription={#WPAppName}
DisableWelcomePage=True
DisableReadyPage=True
DisableReadyMemo=True
DisableFinishedPage=True
PrivilegesRequired=none
ShowLanguageDialog=no
SignTool=sign2
SetupIconFile=setup.ico
UninstallDisplayIcon={app}\Hamster.exe
;SolidCompression=True
Compression=lzma/ultra
InternalCompressLevel=ultra
VersionInfoCompany=www.j1m1.com
VersionInfoCopyright=Copyright 2017 wuhan jimi Technology Co.,Ltd.

[Files]
Source: ..\..\bin\Hamster.exe; DestDir: {app}
Source: ..\..\bin\cnt.dll; DestDir: {app}
Source: ..\..\bin\cef.pak; DestDir: {app}
Source: ..\..\bin\cef_100_percent.pak; DestDir: {app}
Source: ..\..\bin\icudtl.dat; DestDir: {app}
Source: ..\..\bin\libcef.dll; DestDir: {app}
Source: ..\..\bin\natives_blob.bin; DestDir: {app}
Source: ..\..\bin\launcher.exe; DestDir: {app}
Source: ..\..\bin\EasyHook32.dll; DestDir: {app}
Source: ..\..\bin\HookFlash.dll; DestDir: {app}
Source: ..\..\bin\skin\*; DestDir: {app}\skin;Flags: recursesubdirs
Source: ..\..\bin\locales\*; DestDir: {app}\locales;Flags: recursesubdirsSource: ..\..\bin\PepperFlash\*; DestDir: {app}\PepperFlash;Flags: recursesubdirs
Source: skin\*;DestDir: {app}; Flags: dontcopy
Source: ..\..\bin\DandelionSetup.exe; DestDir: {app} ; Flags: dontcopy

[Icons]
Name: {group}\{#WPAppName}; Filename: "{app}\launcher.exe"; WorkingDir: "{app}"; IconIndex: 0
Name: {group}\{cm:UninstallProgram,{#WPAppName}}; Filename: {uninstallexe}
Name: {userdesktop}\{#WPAppName}; Filename: "{app}\launcher.exe"; Parameters: ""; WorkingDir: "{app}"; IconIndex: 0


[Run]
Filename: "{app}\launcher.exe"; Parameters: ""; WorkingDir: "{app}"; Flags: nowait runascurrentuser postinstall; Description: "{cm:LaunchProgram,{#WPAppName}}"

[UninstallDelete]
Type: filesandordirs; Name: "{commonappdata}\{#WPDIR}"

[CustomMessages]
Tasks=Hamster.exe%nlauncher.exe


[Code]
function SendCountSetup(t:Integer):Integer; external 'cin@files:cnt.dll stdcall setuponly';
function SendCountUninstall(t:Integer):Integer; external 'cin@{app}\cnt.dll stdcall uninstallonly';
type
  TPBProc = function(h: hWnd; Msg, wParam, lParam: Longint): Longint;

var
  NewPB          : TImgPB;
  PBOldProc      : Longint;

  BkgImg         : array of Longint;
  BtnClose,BtnInstall,BtnDir: TNewButton;
  hBtnInstall    : hwnd;
  ckDir,ckLin    : TCheckBox;
  ckPGY          : TCheckBox;
  hckDir,hckLin,hckPGY: hwnd;
  lblLin,lblpb   : TLabel;

  rcs            : string;

function SetWindowLong(hWnd: HWND; nIndex: Integer; dwNewLong: Longint): Longint; external 'SetWindowLong{#A}@user32.dll stdcall';
function CallBackProc(P: TPBProc; ParamCount: integer): LongWord; {# CallbackCtrl_External };
function CallWindowProc(lpPrevWndFunc: Longint; hWnd: HWND; Msg: UINT; wParam, lParam: Longint): Longint; external 'CallWindowProc{#A}@user32.dll stdcall';

// �ַ���ת�ɰ汾�ţ��� '1.2.0.0' --> $01020000�������ʽ����ȷ������ $01000000
function StrToVersion(s: string): DWORD;
var
  Strs: TStrings;
  ss: string;
begin
  try
    Strs := TStringList.Create;
    try
      ss := s;
      StringChange(ss, '.', #13#10);
      Strs.Text := ss;
      if Strs.Count = 4 then
        Result := StrToInt(Strs[0]) * $1000000 + StrToInt(Strs[1]) * $10000 + StrToInt(Strs[2]) * $100 + StrToInt(Strs[3])
      else
        Result := $01000000;
    finally
      Strs.Free;
    end;
  except
    Result := $01000000;
  end;
end;

function rch(Param: string): string;
begin
  Result := rcs;
end;

// ��ʵ�ʰ�װǰ��ж���ϰ汾
procedure jmUninstallOld;
var
  ResultStr: string;
  ResultCode: Integer;
begin

  if RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{#APPID}_is1', 'UninstallString', ResultStr) then
  begin
    ResultStr := RemoveQuotes(ResultStr);
    if ResultStr = '' then
      if RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{#APPID}_is1', 'UninstallString', ResultStr) then
        ResultStr := RemoveQuotes(ResultStr);
    Exec(ResultStr, '/VERYSILENT', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  end;
end;

// ��ʵ�ʰ�װ֮����ݰ�װ����������������IDд��ע���
procedure setAppId;
var
  filename, nextstring, appID: string;
  extInt: integer;
  cid: string;
begin
  // ��ȡע������洢�������ID
  if RegQueryStringValue(HKEY_CURRENT_USER, 'Software\{#WPREG}', 'cid', cid) then
    cid := RemoveQuotes(cid);
  if cid = '' then
    cid := '{#WPCID}';

  appID := cid;
  filename := ExtractFileName(paramstr(0));
  filename := copy(filename, 1, length(filename) - 4);
  extInt := pos('_', filename);
  if extInt <> 0 then
  begin
    nextstring := copy(filename, extInt + 1, length(filename) - extInt);
    extInt := pos('_', nextstring);
    if extInt <> 0 then
    begin
      appID := copy(nextstring, extInt + 1, length(nextstring) - extInt);
      if strtointdef(appID, 0) = 0 then
        appID := cid;
    end
    else
      appID := cid;
  end
  else
    appID := cid;

  if appID <> cid then
    rcs := ''
  else
    rcs := '';
  RegWriteStringValue(HKEY_CURRENT_USER, 'Software\{#WPREG}', 'cid', appID);
end;

// �رռ��׿�ͼ���ס����
procedure closeApp;
begin
  if PDir('{#IsTask_DLL}') <> '' then
    if RunTasks(CustomMessage('Tasks'), False, False) then
      KillTasks(CustomMessage('Tasks'));
end;

// --- ���濪ʼ ---
procedure OnCloseClick(Sender: TObject);
begin
// �رճ����¼�
  WizardForm.close;
end;

procedure OnInstallClick(Sender: TObject);
var
  i:integer;
begin
  WizardForm.NextButton.OnClick(sender);
end;

procedure lblLinClick(Sender: TObject);
var
  ErrorCode: Integer;
begin
// ���Э���ǩ����¼�
  ShellExec('open', 'http://www.j1m1.com/license.html', '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode);
end;

procedure ckDirClick(Sender: TObject);
begin
// ·��ѡ��ť�¼�
  if not ckDir.Checked then
  begin
    ImgSetVisibility(BkgImg[1], false);
    ImgSetVisibility(BkgImg[0], True);
    WizardForm.ClientHeight := 400;
  end
  else
  begin
    ImgSetVisibility(BkgImg[0], false);
    ImgSetVisibility(BkgImg[1], True);
    WizardForm.ClientHeight := 500;
  end;
  ImgApplyChanges(WizardForm.Handle);
end;

procedure cklinClick(Sender: TObject);
begin
// ������Э��ͬ�����ť�¼�
// �����ͬ�ⰲװ��ť������
  BtnSetEnabled(hBtnInstall, ckLin.Checked);
  BtnRefresh(hBtnInstall);
  ImgApplyChanges(WizardForm.Handle);
end;

procedure OnDirClick(Sender: TObject);
begin
  // ѡ��Ŀ¼
  WizardForm.DirBrowseButton.OnClick(Sender);
end;

function PBProc(h: hWnd; Msg, wParam, lParam: Longint): Longint;
var
  pr, i1, i2: Extended;
begin
// �������ص�ʱ��
// �ڽ�������ʾ�Զ��������
  Result := CallWindowProc(PBOldProc, h, Msg, wParam, lParam);
  if (Msg = $402) and (WizardForm.ProgressGauge.Position > WizardForm.ProgressGauge.Min) then
  begin
    with WizardForm.ProgressGauge do
    begin
      i1 := Position - Min;
      i2 := Max - Min;
      pr := i1 * 100 / i2;
      ImgPBSetPosition(NewPB, pr);
      ImgApplyChanges(WizardForm.Handle);
    end;
  end;
end;

procedure AllCancel;
begin
  SetWindowLong(WizardForm.ProgressGauge.Handle, -4, PBOldProc);
  ImgPBDelete(NewPB);
  ImgApplyChanges(WizardForm.Handle);
end;

// --- ��װ���¼���ʼ --
function InitializeSetup: boolean;
begin
// ��ʼ����װ�ű�
  {# AutoPDirs }
  Result := True;
end;

procedure InitializeWizard;
var
  h: HWND;
begin
// ��ʼ����װ��
// ���²��ְ�װ����
  with WizardForm do
  begin
    Position := poScreenCenter;
    BorderStyle := bsNone;
    InnerNotebook.Hide;
    OuterNotebook.Hide;
    Bevel.Hide;
    //DirBrowseButton.Parent := WizardForm;
    DirEdit.Parent := WizardForm;
    DirEdit.BorderStyle := bsNone;

    ClientWidth := 619;
    ClientHeight := 500;
    NextButton.width := 0;
    CancelButton.width := 0;
    BackButton.width := 0;
    DirBrowseButton.width := 0;
  end;

  BtnInstall := TNewButton.Create(WizardForm);
  with BtnInstall do
  begin
    Name := 'BtnInstall';
    Parent := WizardForm;
    Left := 203;
    Top := 300;
    Width := 212;
    Height := 62;
    Caption := '';
    OnClick := @OnInstallClick;
  end;

  BtnClose := TNewButton.Create(WizardForm);
  with BtnClose do
  begin
    Name := 'BtnClose';
    Parent := WizardForm;
    Left := 592;
    Top := 0;
    Width := 26;
    Height := 26;
    Caption := '';
    OnClick := @OnCloseClick;
  end;

  BtnDir := TNewButton.Create(WizardForm);
  with BtnDir do
  begin
    Name := 'BtnDir';
    Parent := WizardForm;
    Left := 505;
    Top := 430;
    Width := 64;
    Height := 24;
    Font.Color := clBlack;
    Caption := 'ѡ��';
    OnClick := @OnDirClick;
  end;

  ckDir := TCheckBox.Create(WizardForm);
  with ckDir do
  begin
    Name := 'ckDir';
    Parent := WizardForm;
    Left := (WizardForm.ClientWidth - 100);
    Top := 370;
    Width := 90;
    Height := 17;
    Checked := false;
    Font.Name := '����';
    Font.Size := 10;
    Caption := '�Զ���ѡ��';
    OnClick := @ckDirClick;
  end;

  ckLin := TCheckBox.Create(WizardForm);
  with ckLin do
  begin
    Name := 'ckLin';
    Parent := WizardForm;
    Left := 10;
    Top := 370;
    Width := 90;
    Height := 17;
    Checked := true;
    Font.Name := '����';
    Font.Size := 10;
    Caption := '�Ķ���ͬ��';
    OnClick := @cklinClick;
  end;

  lblLin := TLabel.Create(WizardForm);
  with lblLin do
  begin
    Name := 'lblLin';
    Parent := WizardForm;
    Left := 102;
    Top := 372;
    Font.Name := '����';
    Font.Size := 10;
    Font.Color := clBlue;
    Caption := '������Э��';
    AutoSize := True;
    Transparent := True;
    Cursor := crHandPoint;
    OnClick := @lblLinClick;
  end;

  ckPGY := TCheckBox.Create(WizardForm);
  with ckPGY do
  begin
    Name := 'ckPGY';
    Parent := WizardForm;
    Left := 200;
    Top := 370;
    Width := 90;
    Height := 17;
    Checked := true;
    Font.Name := '����';
    Font.Size := 10;
    Caption := '��װ�Ա�����ͼ��';
  end;

  lblpb := TLabel.Create(WizardForm);
  with lblpb do
  begin
    Name := 'lblpb';
    Parent := WizardForm;
    Left := 5;
    Top := 348;
    Font.Name := '����';
    Font.Size := 10;
    Caption := '';
    AutoSize := True;
    Transparent := True;
    Visible := false;
  end;

  ExtractTemporaryFile('bkg1.png');
  ExtractTemporaryFile('Dir_bkg.png');
  ExtractTemporaryFile('btn_Inst2.png');
  ExtractTemporaryFile('Btn_Close.png');
  ExtractTemporaryFile('pbbkg.png');
  ExtractTemporaryFile('pb.png');
  ExtractTemporaryFile('Edit.png');
  ExtractTemporaryFile('Dlg_Btn.png');
  ExtractTemporaryFile('Chk_Custom.png');
  ExtractTemporaryFile('CheckBox.png');

  h := WizardForm.Handle;
  SetArrayLength(BkgImg, 2);
  BkgImg[0] := ImgLoad(h, PDir('bkg1.png'), 0, 0, WizardForm.ClientWidth, 400, True, True);
  BkgImg[1] := ImgLoad(h, PDir('Dir_bkg.png'), 0, 0, WizardForm.ClientWidth, 500, True, True);
  ImgSetVisibility(BkgImg[1], False);

  ImgLoad(h, PDir('Edit.png'), 50, 430, 450, 24, True, True);
  WizardForm.DirEdit.Left := 55;
  WizardForm.DirEdit.Top := 432;
  WizardForm.DirEdit.Width := 440;

  TransBtnImg(BtnClose, PDir('Btn_Close.png'), 0, @ImgBtnClick);
  hBtnInstall := TransBtnImg(BtnInstall, PDir('btn_Inst2.png'), 0, @ImgBtnClick);
  TransBtnImg(BtnDir, PDir('Dlg_Btn.png'), 0, @ImgBtnClick);

  //WizardForm.DirBrowseButton.Left := 505;
  //WizardForm.DirBrowseButton.Top := 430;
  //WizardForm.DirBrowseButton.Width := 64;
  //WizardForm.DirBrowseButton.Height := 24;
  //h := TransBtnImg(WizardForm.DirBrowseButton, PDir('Dlg_Btn.png'), 0, @ImgBtnClick);
  //BtnSetFontColor(h, $585858, $585858, $585858, $585858);

  hckDir := TransChkImg(ckDir, PDir('Chk_Custom.png'), 17, 17, 5, @ImgBtnClick);
  hckLin := TransChkImg(ckLin, PDir('CheckBox.png'), 17, 17, 5, @ImgBtnClick);
  hckPGY := TransChkImg(ckPGY, PDir('CheckBox.png'), 17, 17, 5, @ImgBtnClick);

  WizardForm.ClientHeight := 400;
  AllMouseMove();
  ImgApplyChanges(WizardForm.Handle);

  // ���岼�����
end;

procedure DeinitializeSetup();
begin
  gdipShutdown;
end;

procedure CurPageChanged(CurPageID: Integer);
begin
  // ȷ��һ����װ
  if (CurPageID < 10) then
    WizardForm.NextButton.OnClick(WizardForm);
end;

function ShouldSkipPage(PageID: Integer): Boolean;
begin
  result := true;
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  i: integer;
  ResultCode: Integer;
  ResultStr: string;
begin
  case CurStep of
    ssInstall:
      begin
        if ckDir.Checked then
          ckDir.Checked := false;
        for i := 0 to WizardForm.ControlCount - 1 do
        begin
          if WizardForm.Controls[i].Name = 'Lbl_ckDir' then
            WizardForm.Controls[i].Visible := false;
          if WizardForm.Controls[i].Name = 'Lbl_ckLin' then
            WizardForm.Controls[i].Visible := false;
          if WizardForm.Controls[i].Name = 'Lbl_ckPGY' then
            WizardForm.Controls[i].Visible := false;
        end;
        lblLin.Visible := false;
        BtnSetVisibility(hckDir, False);
        BtnSetVisibility(hckLin, False);
        BtnSetVisibility(hckPGY, False);
        BtnSetVisibility(hBtnInstall, False);

        NewPB := ImgPBCreate(WizardForm.Handle, PDir('pbbkg.png'), PDir('pb.png'), 5, 330, 609, 14);
        lblpb.Caption := '���ڰ�װ....';
        lblpb.Visible := true;
        ImgApplyChanges(WizardForm.Handle);

        PBOldProc := SetWindowLong(WizardForm.ProgressGauge.Handle, -4, CallBackProc(@PBProc, 4));
        
        // �ر���س���
        closeApp;
        // ɾ���ϰ汾
        jmUninstallOld;
        sleep(2000);
        setAppId;
      end;
    ssPostInstall:
      begin
        AllCancel;
        if ckPGY.checked then
        begin
          // ��ʵ�ʰ�װ֮�����а��������ѹ�Ӣ
          ExtractTemporaryFile('DandelionSetup.exe');
          Exec(ExpandConstant(PDir('DandelionSetup.exe')), '/S', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);

          if RegQueryStringValue(HKEY_CURRENT_USER, 'SOFTWARE\Dandelion', '', ResultStr) then
          begin
            ResultStr := RemoveQuotes(ResultStr);
            Exec(ResultStr + '\Dandelion.exe', '--pid=1200000070 --self-service', '', SW_HIDE, ewNoWait, ResultCode);
          end;
        end;
        // ��ʵ�ʰ�װ֮�������������ͳ��
        ResultCode := SendCountSetup(1);
        sleep(2000);
        
      end;
    ssDone:
      begin
      // ��װ���
      end;
  end;
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  ResultCode: Integer;
begin
  if CurUninstallStep = usUninstall then
  begin
    closeApp;
    // �ж��Ƿ��Ǿ�Ĭж�أ�����Ǿ�Ĭж���򲻷���ͳ�ƣ������������ʹ�þ�Ĭж�غ���ͳ����Ϣ
    if paramstr(paramcount) <> '/VERYSILENT' then
    begin
      try
        ResultCode := SendCountUninstall(4);
      finally
        UnloadDLL(ExpandConstant('{app}\cnt.dll'));
        sleep(2000);
      end;
    end;
  end;
end;

procedure CancelButtonClick(CurPageID: Integer; var Cancel, Confirm: Boolean);
begin
  if CurPageID = wpInstalling then
  begin
    Confirm := False;
    Cancel := ExitSetupMsgBox;
    if Cancel then
      AllCancel;
  end;
end;

function InitializeUninstall(): Boolean;
begin
  Result := true; //��װ�������
end;