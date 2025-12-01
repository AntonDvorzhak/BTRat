//---------------------------------------------------------------------------

// This software is Copyright (c) 2015 Embarcadero Technologies, Inc.
// You may only use this software if you are an authorized licensee
// of an Embarcadero developer tools product.
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------

unit Unit6;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,StrUtils,
  System.Bluetooth, FMX.StdCtrls, System.Bluetooth.Components, System.Permissions,
  FMX.Layouts, FMX.ListBox, FMX.Controls.Presentation, FMX.TabControl, FMX.Edit,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo,System.IOUtils,System.DateUtils,
  FMX.Helpers.Android,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.Net, Androidapi.JNIBridge;

type
  REvent=record
    PreTime,Intencity,PulseDuration,Frequency:double;
  end;

  RChannel=record
    CurEvID,
    Count:integer;
    CountEXE:integer;
    Duration:double;
    Active:boolean;
    Name,
    Comment,
    Programm,
    Instruction:string;
    Events:array of REvent;
    EventsEXE:array of REvent;
  end;

  TForm6 = class(TForm)
    BluetoothLE1: TBluetoothLE;
    Timer1: TTimer;
    Y: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    Panel1: TPanel;
    lbDevices: TListBox;
    TabItem3: TTabItem;
    tExp: TTimer;
    tEvent: TTimer;
    tGeneral: TTimer;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    lGeneralTime: TLabel;
    lExpTime: TLabel;
    lEventTime: TLabel;
    mProtocol: TMemo;
    Panel2: TPanel;
    cbGPIO4: TCheckBox;
    cbGPIO3: TCheckBox;
    cbGPIO2: TCheckBox;
    cbGPIO1: TCheckBox;
    Label4: TLabel;
    ePWM4: TEdit;
    cbPWM4: TCheckBox;
    Label2: TLabel;
    ePWM2: TEdit;
    cbPWM2: TCheckBox;
    Label3: TLabel;
    ePWM3: TEdit;
    cbPWM3: TCheckBox;
    Label1: TLabel;
    ePWM1: TEdit;
    cbPWM1: TCheckBox;
    btLight: TButton;
    eEventComment: TEdit;
    eExpComment: TEdit;
    btExp: TButton;
    Splitter2: TSplitter;
    bClean: TButton;
    bDelLast: TButton;
    Panel3: TPanel;
    Splitter3: TSplitter;
    mPProtocol: TMemo;
    btStartProgramm: TButton;
    eProgramExpTitle: TEdit;
    btPClean: TButton;
    btPShare: TButton;
    Panel4: TPanel;
    btnStartScan: TButton;
    btConnect: TButton;
    Label5: TLabel;
    ProgressBar1: TProgressBar;
    btPWMFr: TButton;
    btShare: TButton;
    Programm: TEdit;
    ProgressBar3: TProgressBar;
    ToolBar2: TToolBar;
    lPExpTime: TLabel;
    lPGeneralTime: TLabel;
    btPDelLast: TButton;
    lbChannels: TListBox;
    Label6: TLabel;
    Label7: TLabel;
    eChComment: TEdit;
    btIndicator: TButton;
    ComboBox1: TComboBox;
    btSaveDevice: TButton;
    btDelDevice: TButton;
    lePWM1: TEdit;
    lePWM3: TEdit;
    lePWM2: TEdit;
    lePWM4: TEdit;
    leGPIO1: TEdit;
    leGPIO3: TEdit;
    leGPIO2: TEdit;
    leGPIO4: TEdit;
    Label8: TLabel;
    procedure btnStartScanClick(Sender: TObject);
    procedure BluetoothLE1DiscoverLEDevice(const Sender: TObject; const ADevice: TBluetoothLEDevice; Rssi: Integer; const ScanResponse: TScanResponse);
    procedure Timer1Timer(Sender: TObject);
    procedure BluetoothLE1EndDiscoverDevices(const Sender: TObject; const ADeviceList: TBluetoothLEDeviceList);
    procedure FormShow(Sender: TObject);
    procedure BluetoothLE1ServicesDiscovered(const Sender: TObject; const AServiceList: TBluetoothGattServiceList);
    procedure lbDevicesItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure FormCreate(Sender: TObject);
    procedure btConnectClick(Sender: TObject);
    procedure ePWM1Change(Sender: TObject);
    procedure btLightClick(Sender: TObject);
    procedure tGeneralTimer(Sender: TObject);
    procedure tEventTimer(Sender: TObject);
    procedure btExpClick(Sender: TObject);
    procedure tExpTimer(Sender: TObject);
    procedure bCleanClick(Sender: TObject);
    procedure bDelLastClick(Sender: TObject);
    procedure BluetoothLE1Disconnect(Sender: TObject);
    procedure btPWMFrClick(Sender: TObject);
    procedure btShareClick(Sender: TObject);
    procedure btStartProgrammClick(Sender: TObject);
    procedure btPDelLastClick(Sender: TObject);
    procedure btPCleanClick(Sender: TObject);
    procedure btPShareClick(Sender: TObject);
    procedure cbPWM1Change(Sender: TObject);
    procedure cbPWM2Change(Sender: TObject);
    procedure cbPWM3Change(Sender: TObject);
    procedure cbPWM4Change(Sender: TObject);
    procedure lbChannelsChangeCheck(Sender: TObject);
    procedure eChCommentChange(Sender: TObject);
    procedure btIndicatorClick(Sender: TObject);
    procedure ProgrammChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure btSaveDeviceClick(Sender: TObject);
    procedure btDelDeviceClick(Sender: TObject);
    procedure TabItem2Click(Sender: TObject);
    procedure lePWM1Change(Sender: TObject);
    procedure lePWM2Change(Sender: TObject);
    procedure lePWM3Change(Sender: TObject);
    procedure lePWM4Change(Sender: TObject);
    procedure leGPIO1Change(Sender: TObject);
    procedure leGPIO2Change(Sender: TObject);
    procedure leGPIO3Change(Sender: TObject);
    procedure leGPIO4Change(Sender: TObject);
    procedure lbChannelsItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
  private
    { Private declarations }
    Scanning: Boolean;
    ScanningStart: Cardinal;
    FLocationPermission: string;
    ProgrammInRun:boolean;
    Channels:Array [0..7] of RChannel;
    ProgrammDuration:double;
    ProgrammStartTime,ExpStartTime,EventStartTime:TDateTime;
    ProgrammPWMareActivated:boolean;
    procedure RequestPermissionsResult(Sender: TObject; const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray);
    procedure DisplayRationale(Sender: TObject; const APermissions: TClassicStringDynArray; const APostRationaleProc: TProc);
    procedure StartBLEDiscovery;
    procedure StopBLEDiscovery;
    function SendCommandToJDY(Command: TBytes): Boolean;
    function StrToTBytes(Val: string): TBytes;
    function ManualActivation(Activate: Boolean): Boolean;
    function GetFileName: string;
    procedure ReadChannels;
    procedure ProgrammTimerCycle(TimeText: string);
    procedure GetChannel(ChlID: integer);
    function CreateEventsEXE: boolean;
  public
    { Public declarations }
    Device:TBluetoothLEDevice;
    DeviceID:string;
    function GetNextEvent(var t: string): REvent;
    function GetNumber(t: string): double;
    procedure SendCommand(Ch: integer; Intence: double);
    procedure PWMSetPercent(Instruction: string; percent: double);
    procedure UnselectLBChannels;
    procedure PreSetChannelsTo0;
    procedure StopProgramm;
    procedure SaveData(Item, DName: string);
    function LoadList: string;
    procedure LoadDeviceParameters(Item: string);
    procedure UpdateComboBox;
    function FindItemPosition(Item: string; SearchByID: boolean=true): integer;
    procedure AddNewItem(rec: string);
    function FindDevice: boolean;
    procedure LoadData(p: integer);
    procedure ShowCurrentChannelInfo(Item: TListBoxItem);
  end;

function LaunchActivity(const Intent: JIntent): Boolean; overload;
function PosBack(SubStr, Str: string; Position: integer): integer;
procedure SendEmail(Subject: string; Memo: TMemo);


const
  ScanningTime = 3000; // 10s in msecs
var

  Form6: TForm6;
  JDYservice:TBluetoothGattService;
  DataList,MemoList:TStringList;

implementation

uses
{$IFDEF ANDROID}
  Androidapi.Helpers,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Os,
{$ENDIF}
  FMX.DialogService;

{$R *.fmx}

procedure TForm6.bCleanClick(Sender: TObject);
begin
  mProtocol.Lines.Clear;
end;

procedure TForm6.bDelLastClick(Sender: TObject);
begin
  mProtocol.Lines.Delete(mProtocol.Lines.Count-1);
end;

procedure TForm6.BluetoothLE1Disconnect(Sender: TObject);
var
  t:string;
  r:boolean;
  dt:TDateTime;
begin
  if btConnect.Text='Disconnect' then begin
    if btStartProgramm.Text='Stop' then begin
      dt:=Now;
      t:=DateTimeToStr(dt)+';!!! Disconnected !!!';
      mPProtocol.Lines.Add(t);
      while ((btStartProgramm.Text='Stop') AND not Device.IsConnected AND
        (SecondsBetween(Now,dt)<30)) do begin
        Device.Connect;
        Application.ProcessMessages;
      end;
      if Device.IsConnected then begin
        t:=DateTimeToStr(Now)+';!!! Reconnected !!! From start = ';
        t:=t+floattostr(SecondsBetween(Now,ExpStartTime))+'s';
        mPProtocol.Lines.Add(t);
      end else btConnectClick(btConnect);
//        (BluetoothLE1.ConnectionState=TBluetoothConnectionState.Disconnected)) do begin
    end else begin
      if btLight.Text='OFF' then begin
          btLight.Text:='ON';
          btLight.FontColor:=$FF000000;
          tEvent.Enabled:=false;
          mProtocol.Lines.Add(TimeToStr(Now)+'; Stop Even, duration='+
            floattostr(SecondsBetween(Now,EventStartTime)+
                       MilliSecondsBetween(Now,EventStartTime)/10000)+'s' );
      end;
      if btExp.Text='Stop exp' then btExpClick(btexp);
      btConnectClick(btConnect);
    end;
  end;
end;

procedure TForm6.BluetoothLE1DiscoverLEDevice(const Sender: TObject; const ADevice: TBluetoothLEDevice; Rssi: Integer; const ScanResponse: TScanResponse);
var
  PrevDiscoveredDevicesCount: Integer;
  DiscoveredDevicesCount: Integer;
  DiscoveredDeviceIndex: Integer;
  DiscoveredDevice: TBluetoothLEDevice;
  DiscoveredDeviceName: string;
begin
  if DeviceID='' then begin
    PrevDiscoveredDevicesCount := lbDevices.Count;
    DiscoveredDevicesCount := BluetoothLE1.DiscoveredDevices.Count;

    for DiscoveredDeviceIndex := 0 to DiscoveredDevicesCount - 1 do
    begin
      DiscoveredDevice := BluetoothLE1.DiscoveredDevices[DiscoveredDeviceIndex];
      DiscoveredDeviceName := DiscoveredDevice.DeviceName;
      if DiscoveredDeviceName = '' then
        DiscoveredDeviceName := 'Unknown device';
      DiscoveredDeviceName :=IntToStr(DiscoveredDeviceIndex+1)+'-'+ DiscoveredDeviceName + ' - ' + DiscoveredDevice.Identifier;

      if DiscoveredDeviceIndex = PrevDiscoveredDevicesCount then
        lbDevices.Items.Add(DiscoveredDeviceName)
      else
        lbDevices.Items[DiscoveredDeviceIndex] := DiscoveredDeviceName;
    end;
  end else begin
    if (ADevice.Identifier=DeviceID) and (lbDevices.Items.Count=0) then begin
      Device:=ADevice;
      lbDevices.Items.Add(ComboBox1.Items[ComboBox1.ItemIndex]+' - '+ADevice.Identifier+' is found.');
      StopBLEDiscovery;
      TThread.CreateAnonymousThread(
      procedure
      begin
        if not Device.DiscoverServices then
          TThread.Synchronize(nil,
            procedure
            begin
            end);
      end).Start;
      btConnect.Enabled:=true;
    end;
  end;
end;

procedure TForm6.BluetoothLE1EndDiscoverDevices(const Sender: TObject; const ADeviceList: TBluetoothLEDeviceList);
begin
  if Scanning then
    ProgressBar1.Value := ProgressBar1.Max;
  Timer1.Enabled := False;
  Scanning := False;
  if DeviceID='' then begin
    btnStartScan.Enabled:=true;
    btnStartScan.Text:='Start Scan';
  end else begin
    btConnect.Enabled:=false;
    lbDevices.Items.Add('The device is not found!' );

  end;

end;

procedure TForm6.BluetoothLE1ServicesDiscovered(const Sender: TObject; const AServiceList: TBluetoothGattServiceList);
var
  ServiceIndex: Integer;
  Service: TBluetoothGattService;
  CharacteristicIndex: Integer;
  Characteristic: TBluetoothGattCharacteristic;
begin
  if AServiceList.Count > 0 then begin
    for ServiceIndex := 0 to AServiceList.Count - 1 do
    begin
      Service := AServiceList[ServiceIndex];
//      Listbox2.Items.Add((ServiceIndex + 1).ToString + ' - ' + Service.UUIDName + ' - ' + Service.UUID.ToString);
//      Memo1.Lines.Add((ServiceIndex + 1).ToString + ' - ' + Service.UUIDName + ' - ' + Service.UUID.ToString);
      if ServiceIndex=1 then  JDYservice:=Service;
{      for CharacteristicIndex := 0 to Service.Characteristics.Count - 1 do
      begin
        Characteristic := Service.Characteristics[CharacteristicIndex];
//        Listbox2.Items.Add('    - ' + Characteristic.UUIDName + ' - ' + Characteristic.UUID.ToString);

      end;}
    end;
    btConnect.Enabled:=true;
  end;
end;

procedure TForm6.btExpClick(Sender: TObject);
var
  t:string;
begin
  if btexp.Text='Start exp' then begin
    btExp.Text:='Stop exp';
    btExp.FontColor:=$FFFF0000;
    btLight.Enabled:=true;
    ExpStartTime:=Now;
    tExp.Interval:=100;
    tExp.Enabled:=true;
    t:=DateTimeToStr(Now)+'; Start Exp; '+eExpComment.Text +'; ';
    t:=t+'Device: '+Device.DeviceName+' - '+Device.Identifier;
    mProtocol.Lines.Add(t);
  end else begin
    if btLight.Text='OFF' then btLightClick(btLight);
    btExp.Text:='Start exp';
    btLight.Enabled:=false;
    btExp.FontColor:=$FF000000;
    btLight.Enabled:=false;
    tExp.Enabled:=false;
    mProtocol.Lines.Add(TimeToStr(Now)+'; Stop Exp; Duration='+
      floattostr(MilliSecondsBetween(Now,ExpStartTime)/1000)+'s' );
  end;

end;

procedure TForm6.btIndicatorClick(Sender: TObject);
  procedure Filtration(var t:string);
  var
    p,i:integer;
  begin
    p:=pos('-0/',t);
    while p>0 do begin
      i:=p-1;
      while t[i]<>'/'do dec(i);
      Delete(t,i+1,p+2-i);
      p:=pos('-0/',t);
    end;
  end;
var
  t:string;
  ia:array [0..7] of integer;
  i,mi:integer;
  time, time0:double;
  state,state0:boolean;
begin
  try
  t:='/0-';
  ReadChannels;
  for I := 0 to 7 do ia[i]:=0;
  state0:=false;
  state:=false;
  time0:=0;
  time:=0;
  while time>=0 do begin
    time:=-1;
    state:=false;
    for I := 0 to 7 do
      if (Channels[i].Active) and (i<>lbChannels.ItemIndex) and
         (ia[i]<Channels[i].Count) then begin
         if time<0 then begin
           time:=Channels[i].Events[ia[i]].PreTime;
           mi:=i;
         end else begin
           if time>=Channels[i].Events[ia[i]].PreTime then begin
             time:=Channels[i].Events[ia[i]].PreTime;
             mi:=i;
           end;
         end;
      end;
    if (state0<>(Channels[mi].Events[ia[mi]].Intencity>0)) then begin
      state:=false;
      for I := 0 to 7 do
        if Channels[i].Active and (i<>mi) and (ia[i]>0) then
          state:=state or (Channels[i].Events[ia[i]-1].Intencity>0);
      state:=state or (Channels[mi].Events[ia[mi]].Intencity>0);
      if (time-time0>=0)and (state<>state0) then begin
        t:=t+FloatToStr((time-time0)/1000);
        if State then
          t:=t+'/1-'
        else
          t:=t+'/0-';
        time0:=time;
      end;
      state0:=state;
    end;
    inc(ia[mi]);
  end;
  Filtration(t);
  Programm.Text:=t;
  except
    Programm.Text:='';
  end;
end;

procedure TForm6.btLightClick(Sender: TObject);
var
  t:string;
begin
  if btLight.Text='ON' then begin
    btLight.Text:='OFF';
    btLight.FontColor:=$FFFF0000;
    EventStartTime:=Now;
    t:=TimeToStr(Now)+'; Start event; '+eEventComment.Text +'; ';
    if cbPWM1.IsChecked then t:=t+'PWM1-'+ePWM1.Text+';';
    if cbPWM2.IsChecked then t:=t+'PWM2-'+ePWM2.Text+';';
    if cbPWM3.IsChecked then t:=t+'PWM3-'+ePWM3.Text+';';
    if cbPWM4.IsChecked then t:=t+'PWM4-'+ePWM4.Text+';';
    if cbGPIO1.IsChecked then t:=t+'GPIO1;';
    if cbGPIO2.IsChecked then t:=t+'GPIO2;';
    if cbGPIO3.IsChecked then t:=t+'GPIO3;';
    if cbGPIO4.IsChecked then t:=t+'GPIO4;';
    mProtocol.Lines.Add(t);
    tEvent.Enabled:=true;
    ManualActivation(true);
  end else begin
    btLight.Text:='ON';
    btLight.FontColor:=$FF000000;
    ManualActivation(false);
    tEvent.Enabled:=false;
    mProtocol.Lines.Add(TimeToStr(Now)+'; Stop Event; Duration='+
      floattostr(MilliSecondsBetween(Now,EventStartTime)/1000)+'s' );
  end;
end;

procedure TForm6.btnStartScanClick(Sender: TObject);
begin
  DeviceID:='';
  lbDevices.Enabled:=true;
  if btnStartScan.Text='Start Scan' then begin
    PermissionsService.RequestPermissions([FLocationPermission], RequestPermissionsResult, DisplayRationale);
    btnStartScan.Text:='Stop Scan';
    btConnect.Enabled:=false;
  end else begin
    StopBLEDiscovery;
    btnStartScan.Text:='Start Scan';
  end;
end;

procedure TForm6.btPCleanClick(Sender: TObject);
begin
  mPProtocol.Lines.Clear;
end;

procedure TForm6.btPDelLastClick(Sender: TObject);
begin
  mPProtocol.Lines.Delete(mPProtocol.Lines.Count-1);
end;

procedure TForm6.btPShareClick(Sender: TObject);
begin
  SendEmail('Optogenetic programm protocol',mPProtocol);
end;

procedure TForm6.btPWMFrClick(Sender: TObject);
begin
  InputBox('Change PWM frequency','PWM frequency (50-4kHz)','1000',
    procedure (const AResult: TModalResult;const AValue: string)
    var
      fs:string;
      f:integer;
    begin
      if not TryStrToInt(AValue,f) then exit;
      if f<50 then f:=50;
      if f>4000 then f:=4000;
      fs:=IntToHex(f,2);
      SendCommandToJDY(StrToTBytes('E8A2'+fs));
    end);
end;


function LaunchActivity(const Intent: JIntent): Boolean; overload;
var
  ResolveInfo: JResolveInfo;
begin
  ResolveInfo := SharedActivity.getPackageManager.resolveActivity(Intent, 0);
  Result := ResolveInfo <> nil;
  if Result then
    SharedActivity.startActivity(Intent);
end;

procedure SendEmail(Subject: string; Memo: TMemo);
var
  Intent: JIntent;
begin
  Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_SEND);
  Intent.putExtra(TJIntent.JavaClass.EXTRA_EMAIL, StringToJString('anton.dvorzhak@charite.de'));//Recipient
  Intent.putExtra(TJIntent.JavaClass.EXTRA_SUBJECT, StringToJString(Subject));//Subject
  Intent.putExtra(TJIntent.JavaClass.EXTRA_TEXT, StringToJString(Memo.text));//Content
  // Intent.setType(StringToJString('plain/text'));
  Intent.setType(StringToJString('message/rfc822'));
  // LaunchActivity(Intent);
  LaunchActivity(TJIntent.JavaClass.createChooser(Intent, StrToJCharSequence('Which email app?')));
end;

procedure TForm6.btShareClick(Sender: TObject);
begin
  SendEmail('Optogenetic manual protocol',mProtocol);
end;

procedure TForm6.btStartProgrammClick(Sender: TObject);
var
  t:string;
  i:integer;
begin
  try
  if btStartProgramm.Text='Start' then begin
    btStartProgramm.Text:='Stop';
    btStartProgramm.FontColor:=$FFFF0000;
    btLight.Enabled:=true;
    t:=DateTimeToStr(Now)+'; Start; '+eProgramExpTitle.Text +'; ';
    t:=t+'Device: '+Device.DeviceName+' - '+Device.Identifier;
    mPProtocol.Lines.Add(t);
    for I := 0 to 7 do
      if Channels[i].Active then begin
        t:=Channels[i].Name+' ('+Channels[i].Comment+') '+Channels[i].Programm;
        mPProtocol.Lines.Add(t);
      end;
    ProgrammPWMareActivated:=false;
    ExpStartTime:=Now;
    UnselectLBChannels;
    PreSetChannelsTo0;
    ReadChannels;
    if not CreateEventsEXE then StopProgramm;
    tExp.Interval:=1;
    ProgrammStartTime:=now();
    tExp.Enabled:=true;
  end else StopProgramm;
  except
    StopProgramm;
  end;
end;

procedure TForm6.btSaveDeviceClick(Sender: TObject);
begin
  if ComboBox1.ItemIndex=0 then begin
    TDialogService.InputQuery('Enter a new device name',['Device name'],[''],
      procedure (const AResult: TModalResult; const AValues: array of string)
        var p:integer;
      begin
        if  (AResult=mrOK) then begin
          SaveData(DeviceID,AValues[0]);
          UpdateComboBox;
          ComboBox1.ItemIndex := ComboBox1.Count - 1;
        end;
      end);
  end else begin
    SaveData(DeviceID,ComboBox1.Items[ComboBox1.ItemIndex]);
  end;
end;

procedure TForm6.btConnectClick(Sender: TObject);
begin
  if DeviceID='' then begin
    if lbDevices.Items.Count=0 then exit;
    Device:=BluetoothLE1.DiscoveredDevices[lbDevices.ItemIndex];
    DeviceID:=Device.Identifier;
  end;
  if btConnect.Text='Connect' then begin
    if Device.Connect then begin
      TabItem2.Enabled:=true;
      TabItem3.Enabled:=true;
      ComboBox1.Enabled:=false;
      btnStartScan.Enabled:=false;
      btConnect.Text:='Disconnect';
    end;
  end else begin
    if Device.Disconnect then begin
      TabItem2.Enabled:=false;
      TabItem3.Enabled:=false;
      ComboBox1.Enabled:=True;
      if ComboBox1.ItemIndex=0 then  btnStartScan.Enabled:=True;
      y.TabIndex:=0;
      btConnect.Text:='Connect';
    end;
  end;

end;


procedure TForm6.btDelDeviceClick(Sender: TObject);
var
  p,i:integer;
  id:string;
begin
  MemoList.Clear;
  if ComboBox1.ItemIndex>0 then begin
    TDialogService.MessageDialog('Delete record?',
      TMsgDlgType.mtConfirmation, mbYesNo,TMsgDlgBtn.mbYes, 0,
      procedure (const AResult: TModalResult)
      begin
        if  (AResult=mrYes) then begin
          p:=FindItemPosition(ComboBox1.Items[ComboBox1.ItemIndex],false);
          if p>=0 then begin
            id:=DataList.Strings[p-1];
            delete(id,1,1);
            while DataList.Strings[p]<> id+'}' do DataList.Delete(p);
            DataList.Delete(p);
            DataList.Delete(p-1);
            DataList.SaveToFile(GetFileName);
          end;
          UpdateComboBox;
          ComboBox1.ItemIndex:=0;
        end;
      end);
  end;

end;

procedure TForm6.cbPWM1Change(Sender: TObject);
begin
  ePWM1.Enabled:=(Sender as TCheckBox).IsChecked;
end;

procedure TForm6.cbPWM2Change(Sender: TObject);
begin
  ePWM2.Enabled:=(Sender as TCheckBox).IsChecked;
end;

procedure TForm6.cbPWM3Change(Sender: TObject);
begin
  ePWM3.Enabled:=(Sender as TCheckBox).IsChecked;
end;

procedure TForm6.cbPWM4Change(Sender: TObject);
begin
  ePWM4.Enabled:=(Sender as TCheckBox).IsChecked;
end;

procedure TForm6.ComboBox1Change(Sender: TObject);
begin
  if ComboBox1.ItemIndex>0 then begin
    btnStartScan.Enabled:=false;
    LoadDeviceParameters(ComboBox1.Items[ComboBox1.ItemIndex]);
  end else begin
    StopBLEDiscovery;
    btnStartScan.Enabled:=true;
    btConnect.Enabled:=false;
  end;
end;

procedure TForm6.FormCreate(Sender: TObject);
var
  i:integer;
begin
{$IFDEF ANDROID}
  FLocationPermission := JStringToString(TJManifest_permission.JavaClass.ACCESS_FINE_LOCATION);
{$ENDIF}
  Channels[0].Name:='PWM1';
  Channels[1].Name:='PWM2';
  Channels[2].Name:='PWM3';
  Channels[3].Name:='PWM4';
  Channels[4].Name:='GPIO1';
  Channels[5].Name:='GPIO2';
  Channels[6].Name:='GPIO3';
  Channels[7].Name:='GPIO4';

  Channels[0].Instruction:='E8A3';
  Channels[1].Instruction:='E8A4';
  Channels[2].Instruction:='E8A5';
  Channels[3].Instruction:='E8A6';
  Channels[4].Instruction:='E7F1';
  Channels[5].Instruction:='E7F2';
  Channels[6].Instruction:='E7F3';
  Channels[7].Instruction:='E7F4';

  lbChannels.Clear;
  for I := 0 to 7 do begin
    Channels[i].Programm:='/0-';
    Channels[i].Active:=false;
    lbChannels.Items.Append(Channels[i].Name);
    lbChannels.ListItems[i].IsChecked:=false;
    lbChannels.ListItems[i].IsSelected:=false;
  end;
  lbChannels.ItemIndex:=0;
  ShowCurrentChannelInfo(lbChannels.ListItems[0]);
  DataList:=TStringList.Create;
  MemoList:=TStringList.Create;
end;

procedure TForm6.FormDestroy(Sender: TObject);
begin
  DataList.Free;
  MemoList.Free;
end;

procedure TForm6.FormShow(Sender: TObject);
begin
  Scanning := False;
  tGeneral.Enabled:=true;
  tExp.Enabled:=false;
  tEvent.Enabled:=false;
  ProgrammDuration:=0;
  y.TabIndex:=0;
  LoadList;
  UpdateComboBox;
  ComboBox1.ItemIndex:=0;
end;

procedure TForm6.lbChannelsChangeCheck(Sender: TObject);
var
  i:integer;
begin
  i:=lbChannels.ItemIndex;
  Channels[i].Active:=lbChannels.ListItems[i].IsChecked;
end;

procedure TForm6.lbChannelsItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  ShowCurrentChannelInfo(Item);
end;

procedure TForm6.ShowCurrentChannelInfo(Item: TListBoxItem);
var
  i:integer;
begin
  i:=Item.Index;
  Programm.Text:=Channels[i].Programm;
  eChComment.Text:=Channels[i].Comment;
end;

procedure TForm6.lbDevicesItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
begin
  StopBLEDiscovery;
  btnStartScan.Text:='Start Scan';
//  Listbox2.Clear;
//  Listbox2.Items.Add('- Discovering services -->');
  if DeviceID='' then begin
    TThread.CreateAnonymousThread(
    procedure
    begin
      if not BluetoothLE1.DiscoveredDevices[lbDevices.ItemIndex].DiscoverServices then
        TThread.Synchronize(nil,
          procedure
          begin
//            Listbox2.Items.Add('- Service discovery not allowed');
            lbDevices.Enabled := True;
          end);
    end).Start;
  end else begin
    TThread.CreateAnonymousThread(
    procedure
    begin
      if not Device.DiscoverServices then
        TThread.Synchronize(nil,
          procedure
          begin
//            Listbox2.Items.Add('- Service discovery not allowed');
            lbDevices.Enabled := True;
          end);
    end).Start;
  end;
  btConnect.Enabled:=true;
end;

procedure TForm6.leGPIO1Change(Sender: TObject);
begin
  Channels[4].Comment:=(Sender as TEdit).Text;
end;

procedure TForm6.leGPIO2Change(Sender: TObject);
begin
  Channels[5].Comment:=(Sender as TEdit).Text;
end;

procedure TForm6.leGPIO3Change(Sender: TObject);
begin
  Channels[6].Comment:=(Sender as TEdit).Text;
end;

procedure TForm6.leGPIO4Change(Sender: TObject);
begin
  Channels[7].Comment:=(Sender as TEdit).Text;
end;

procedure TForm6.lePWM1Change(Sender: TObject);
begin
  Channels[0].Comment:=(Sender as TEdit).Text;
end;

procedure TForm6.lePWM2Change(Sender: TObject);
begin
  Channels[1].Comment:=(Sender as TEdit).Text;
end;

procedure TForm6.lePWM3Change(Sender: TObject);
begin
  Channels[2].Comment:=(Sender as TEdit).Text;
end;

procedure TForm6.lePWM4Change(Sender: TObject);
begin
  Channels[3].Comment:=(Sender as TEdit).Text;
end;

procedure TForm6.DisplayRationale(Sender: TObject; const APermissions: TClassicStringDynArray; const APostRationaleProc: TProc);
begin
  TDialogService.ShowMessage('We need to be given permission to discover BLE devices',
    procedure(const AResult: TModalResult)
    begin
      APostRationaleProc;
    end)
end;

procedure TForm6.eChCommentChange(Sender: TObject);
begin
  Channels[lbChannels.ItemIndex].Comment:=eChComment.Text;
end;

procedure TForm6.ePWM1Change(Sender: TObject);
var
  v:double;
begin
  if  TryStrToFloat((Sender as TEdit).Text,v) then begin
    if v<0 then (Sender as TEdit).Text:='0';
    if v>100 then (Sender as TEdit).Text:='100';
  end else begin
    (Sender as TEdit).Text:='50';
  end;

end;

procedure TForm6.RequestPermissionsResult(Sender: TObject; const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray);
begin
  // 1 permissions involved: ACCESS_FINE_LOCATION
  if (Length(AGrantResults) = 1) and (AGrantResults[0] = TPermissionStatus.Granted) then
    StartBLEDiscovery
  else
    TDialogService.ShowMessage('Cannot start BLE scan as the permission has not been granted');
end;

procedure TForm6.StartBLEDiscovery;
begin
  if not Scanning then
  begin
    lbDevices.Clear;
    ScanningStart := TThread.GetTickCount;
    BluetoothLE1.DiscoverDevices(ScanningTime);
    ProgressBar1.Value := 0;
    Timer1.Enabled := True;
    Scanning := True;
  end;
end;

procedure TForm6.StopBLEDiscovery;
begin
  Timer1.Enabled := False;
  Scanning := False;
  BluetoothLE1.CancelDiscovery;
end;

procedure TForm6.tEventTimer(Sender: TObject);
var
  t,s,m:int64;
begin
  t:=MilliSecondsBetween(Now,EventStartTime);
  s:=trunc(t/1000);
  m:=trunc(t/60000);
  s:=s-m*60;
  t:=t-m*60000-s*1000;
  lEventTime.Text:=inttostr(m)+':'+
                 FormatFloat('0.0',s+t/1000)+' m:s';
end;

procedure TForm6.tExpTimer(Sender: TObject);
var
  ms,s,m:int64;
  t:string;
begin
  ms:=MilliSecondsBetween(Now,ExpStartTime);
  s:=trunc(ms/1000);
  m:=trunc(ms/60000);
  s:=s-m*60;
  ms:=ms-m*60000-s*1000;
  t:=inttostr(m)+':'+ FormatFloat('0.0',s+ms/1000)+' m:s';
  lExpTime.Text:=t;
  ProgrammTimerCycle(t);
end;

procedure TForm6.tGeneralTimer(Sender: TObject);
begin
  lGeneralTime.Text:=DateTimeToStr(Now);
  lPGeneralTime.Text:=DateTimeToStr(Now);
end;

procedure TForm6.Timer1Timer(Sender: TObject);
var
  LElapsed: Cardinal;
begin
  LElapsed := TThread.GetTickCount - ScanningStart;
  ProgressBar1.Value := ProgressBar1.Max * (LElapsed.ToSingle / ScanningTime);
end;

function TForm6.SendCommandToJDY(Command: TBytes): Boolean;
begin
  Device.Services[1].Characteristics[1].SetValue(Command);
  Result:=Device.WriteCharacteristic(JDYService.Characteristics[1]);

{  BluetoothLE1.DiscoveredDevices[lbDevices.ItemIndex].Services[1].Characteristics[1].SetValue(Command);
  Result:=BluetoothLE1.DiscoveredDevices[lbDevices.ItemIndex].WriteCharacteristic(JDYService.Characteristics[1]);}
end;

function TForm6.StrToTBytes(Val: string): TBytes;
var
  b:string;
  i, l: integer;
begin
  l:=length(Val) div 2;
  SetLength(result,l);
  for i:=0 to l-1 do begin
    b:=MidStr(Val, i*2+1, 2);
    result[i]:=strtoint('$'+b);
  end;
end;

procedure TForm6.TabItem2Click(Sender: TObject);
begin
  lePWM1.Text:=Channels[0].Comment;
  lePWM2.Text:=Channels[1].Comment;
  lePWM3.Text:=Channels[2].Comment;
  lePWM4.Text:=Channels[3].Comment;
  leGPIO1.Text:=Channels[4].Comment;
  leGPIO2.Text:=Channels[5].Comment;
  leGPIO3.Text:=Channels[6].Comment;
  leGPIO4.Text:=Channels[7].Comment;
end;

function TForm6.ManualActivation(Activate: Boolean): Boolean;
begin
  if Activate then begin

    if cbPWM1.IsChecked then PWMSetPercent('E8A3',strtofloat(ePWM1.Text))
    else SendCommandToJDY(StrToTBytes('E8A300'));

    if cbPWM2.IsChecked then PWMSetPercent('E8A4',strtofloat(ePWM2.Text))
    else SendCommandToJDY(StrToTBytes('E8A400'));

    if cbPWM3.IsChecked then PWMSetPercent('E8A5',strtofloat(ePWM3.Text))
    else SendCommandToJDY(StrToTBytes('E8A500'));

    if cbPWM4.IsChecked then PWMSetPercent('E8A6',strtofloat(ePWM4.Text))
    else SendCommandToJDY(StrToTBytes('E8A600'));

    SendCommandToJDY(StrToTBytes('E8A101'));

    if cbGPIO1.IsChecked then SendCommandToJDY(StrToTBytes('E7F101'))
    else SendCommandToJDY(StrToTBytes('E7F100'));

    if cbGPIO2.IsChecked then SendCommandToJDY(StrToTBytes('E7F201'))
    else SendCommandToJDY(StrToTBytes('E7F200'));

    if cbGPIO3.IsChecked then SendCommandToJDY(StrToTBytes('E7F301'))
    else SendCommandToJDY(StrToTBytes('E7F300'));

    if cbGPIO4.IsChecked then SendCommandToJDY(StrToTBytes('E7F401'))
    else SendCommandToJDY(StrToTBytes('E7F400'));

  end else begin
    SendCommandToJDY(StrToTBytes('E7F0'));
    SendCommandToJDY(StrToTBytes('E8A100'));
  end;
end;

function TForm6.GetFileName: string;
begin
//  Result := Edit1.Text;
  Result :='Devices.txt';
  Result := System.IOUtils.TPath.Combine(TPath.GetDownloadsPath, Result);
end;

procedure TForm6.ReadChannels;
var
  i:integer;
begin
  GetChannel(0);
  ProgrammDuration:=Channels[0].Duration;
  for i := 1 to 7 do begin
    GetChannel(i);
    if ProgrammDuration<Channels[i].Duration then
      ProgrammDuration:=Channels[i].Duration;
  end;
end;

procedure TForm6.ProgrammChange(Sender: TObject);
begin
  Channels[lbChannels.ItemIndex].Programm:=Programm.Text;
end;

procedure TForm6.ProgrammTimerCycle(TimeText: string);
var
  i:integer;
  ms:int64;
begin
  if (ProgrammDuration=0) then exit;
  try
  lPExpTime.Text:=TimeText;
  ms:=MilliSecondsBetween(Now(),ProgrammStartTime);
  if (ms>ProgrammDuration) then StopProgramm
  else begin
    ProgressBar3.Value:=100*ms/ProgrammDuration;
    for I := 0 to 7 do
      if (Channels[i].CurEvID<Channels[i].CountEXE) then begin
        if ms>=Channels[i].EventsEXE[Channels[i].CurEvID].PreTime then begin
          SendCommand(i,Channels[i].EventsEXE[Channels[i].CurEvID].Intencity);
        if Channels[i].CountEXE=Channels[i].Count then
          lbChannels.ListItems[i].IsSelected:=
            Channels[i].EventsEXE[Channels[i].CurEvID].Intencity>0;
          inc(Channels[i].CurEvID);
        end;
      end;
  end;
  except
//    StopProgramm;
  end;
end;

procedure TForm6.GetChannel(ChlID: integer);
var
  t:string;
  n,l:integer;
  e:REvent;
begin
  Channels[ChlID].Count:=0;
  Channels[ChlID].Duration:=0;
  Channels[ChlID].CurEvID:=0;
  while Channels[ChlID].Programm[1]=' ' do delete(Channels[ChlID].Programm,1,1);
  while Channels[ChlID].Programm[length(Channels[ChlID].Programm)]=' ' do
    delete(Channels[ChlID].Programm,length(Channels[ChlID].Programm),1);
  l:=length(Channels[ChlID].Programm);
  if Channels[ChlID].Active and (l>1) then begin
    t:=Channels[ChlID].Programm;
    if Channels[ChlID].Programm[l]<>'-' then t:=t+'-';
    if Channels[ChlID].Programm[1]<>'/' then t:='0/'+t;
    e:=GetNextEvent(t);
    n:=0;
    while e.PreTime>=0 do begin
      inc(n);
      SetLength(Channels[ChlID].Events,n);
      Channels[ChlID].Events[n-1]:=e;
      Channels[ChlID].Count:=n;
      Channels[ChlID].Duration:=Channels[ChlID].Duration+e.PreTime;
      Channels[ChlID].Events[n-1].PreTime:=Channels[ChlID].Duration;
      e:=GetNextEvent(t);
    end;
  end;
end;


function TForm6.GetNextEvent(var t: string): REvent;
var
  p1,p2,fp:integer;
  e:string;
begin
  Result.PreTime:=-1;
  p1:=PosEx('/',t,1);
  if p1>0 then begin
    Result.PreTime:=GetNumber(Copy(t,1,p1-1))*1000;
    p2:=PosEx('-',t,p1);
    if p2>0 then begin
      e:=Copy(t,p1+1,p2-p1-1);
      fp:=pos('*',e);
      if fp>0 then begin
        Result.Intencity:=100;
        Result.PulseDuration:=GetNumber(LeftStr(e,fp-1));
        Result.Frequency:=GetNumber(RightStr(e,length(e)-fp));
      end else begin
        Result.Intencity:=GetNumber(e);
        Result.PulseDuration:=0;
        Result.Frequency:=0;
     end;

      t:=RightStr(t,Length(t)-p2);
    end else begin
      Result.Intencity:=0;
      t:=RightStr(t,Length(t)-p1);
    end;
  end;
end;

function TForm6.GetNumber(t: string): double;
var
  p,n:Integer;
begin
  Result:=0;
  p:=1;
  while p<=Length(t) do begin
    if t[p] in ['0'..'9','.',','] then inc(p) else delete(t,p,1);
  end;
  if Length(t)>0 then begin
    if not TryStrToFloat(t,Result) then Result:=0;
  end;
end;

procedure TForm6.SendCommand(Ch: integer; Intence: double);
begin
  if Ch<4 then begin
    if not ProgrammPWMareActivated then begin
      SendCommandToJDY(StrToTBytes('E8A101'));
      ProgrammPWMareActivated:=true;
    end;
    PWMSetPercent(Channels[Ch].Instruction,Intence)
  end else begin
    if Intence>0 then
      SendCommandToJDY(StrToTBytes(Channels[Ch].Instruction+'01'))
    else
      SendCommandToJDY(StrToTBytes(Channels[Ch].Instruction+'00'));
  end;
end;

procedure TForm6.PWMSetPercent(instruction: string; percent: double);
var
  p:integer;
  ps:string;
begin
  p:=trunc(percent*255/100);
  ps:=IntToHex(p,2);
  SendCommandToJDY(StrToTBytes(instruction+ps));
end;

procedure TForm6.UnselectLBChannels;
var
  i:integer;
begin
  for I := 0 to lbChannels.Items.Count-1 do
    lbChannels.ListItems[i].IsSelected:=false;
end;

procedure TForm6.PreSetChannelsTo0;
var
  Ch:integer;
begin
  for Ch := 0 to 7 do begin
    if Ch<4 then
      PWMSetPercent(Channels[Ch].Instruction,0)
    else
      SendCommandToJDY(StrToTBytes(Channels[Ch].Instruction+'00'));
  end;
end;

procedure TForm6.StopProgramm;
begin
    btStartProgramm.Text:='Start';
    btStartProgramm.FontColor:=$FF000000;
    ProgrammDuration:=0;
    tExp.Enabled:=false;
    SendCommandToJDY(StrToTBytes('E7F0'));
    SendCommandToJDY(StrToTBytes('E8A100'));
    UnselectLBChannels;
    ProgrammPWMareActivated:=false;
    mPProtocol.Lines.Add(TimeToStr(Now)+'; Stop; Duration='+
      floattostr(SecondsBetween(Now,ExpStartTime))+'s' );
end;

procedure TForm6.SaveData(Item, DName: string);
var
  p, i: integer;
begin
   p := FindItemPosition(Item);
   if p >= 0 then begin
     while DataList.Strings[p + 1] <> Item + '}' do DataList.Delete(p + 1);
     inc(p);
   end else begin
     p:=DataList.Count+1;
     AddNewItem(Item);
   end;
   DataList.Insert(p, DName);
   inc(p);
   for I := 0 to 7 do begin
     DataList.Insert(p+i*2,Channels[i].Comment);
     DataList.Insert(p+i*2+1,Channels[i].Programm);
   end;
   DataList.SaveToFile(GetFileName);
end;

function TForm6.LoadList: string;
begin
  Result := GetFileName;
  if FileExists(Result) then
    DataList.LoadFromFile(Result)
  else
    DataList.SaveToFile(Result);
end;

procedure TForm6.LoadDeviceParameters(Item: string);
var
  p: integer;
begin
  p := FindItemPosition(Item,false);
  if p >= 0 then begin
    DeviceID:=DataList.Strings[p-1];
    Delete(DeviceID,1,1);
    LoadData(p);
    PermissionsService.RequestPermissions([FLocationPermission], RequestPermissionsResult, DisplayRationale);
  end else begin
    btnStartScan.Enabled:=true;
    ComboBox1.ItemIndex:=0;
  end;
end;

procedure TForm6.UpdateComboBox;
var
  i: integer;
begin
  ComboBox1.Clear;
  ComboBox1.Items.Add('New');
  for i := 0 to DataList.Count - 1 do begin
    if pos('{', DataList.Strings[i]) > 0 then
      ComboBox1.Items.Add(DataList.Strings[i+1]);
  end;
end;

function TForm6.FindItemPosition(Item: string; SearchByID: boolean): integer;
begin
    Result := 0;
    if SearchByID then Item:='{' + Item;
    while (Result < DataList.Count) and
          (DataList.Strings[Result] <> Item) do inc(Result);
    if (Result = DataList.Count) then
      Result := -1;
end;

procedure TForm6.AddNewItem(rec: string);
begin
  MemoList.Clear;
  MemoList.Add(rec);
  DataList.Add('{' + rec);
  DataList.Add(rec + '}');
end;

function TForm6.FindDevice: boolean;
var
  i,n:integer;
  d: TBluetoothLEDevice;
begin
  n:= BluetoothLE1.DiscoveredDevices.Count;
  i:=0;
  while I <n do begin
    d := BluetoothLE1.DiscoveredDevices[i];
    if DeviceID=d.Identifier then begin
      Device:=d;
      Timer1.Enabled := False;
      Scanning := False;
      Device.DiscoverServices;
      Application.ProcessMessages;

      {TThread.CreateAnonymousThread(
        procedure
        begin
          if not Device.DiscoverServices then
            TThread.Synchronize(nil,
              procedure
              begin
//                Listbox2.Items.Add('- Service discovery not allowed');
                 lbDevices.Enabled := True;
              end);
        end).Start;}

      Break;
    end;
    inc(i);
  end;
  Result:=i<n;
end;

function PosBack(SubStr, Str: string; Position: integer): integer;
var
 i:integer;
begin
 Result:=pos(SubStr,Str);
 i:=Result;
 while (i<Position) and (i>0) do begin
  Result:=i;
  i:=Pos(SubStr,Str,i+1);
 end;
 if Result>=Position then Result:=0;
end;

procedure TForm6.LoadData(p: integer);
var
  i: integer;
begin
  eExpComment.Text:=DataList.Strings[p];
  eProgramExpTitle.Text:=DataList.Strings[p];
  for I := 0 to 7 do begin
    Channels[i].Comment:=DataList.Strings[p+1+i*2];
    Channels[i].Programm:=DataList.Strings[p+1+i*2+1];
  end;
end;

function TForm6.CreateEventsEXE: boolean;
var
  c,e,i,j,n:integer;
  d:double;
begin
  Result:=false;
  try
  for c := 0 to 7 do begin
    SetLength(Channels[c].EventsEXE,0);
    i:=0;
    for e := 0 to Channels[c].Count-1 do begin
      if (Channels[c].Events[e].PulseDuration<=0) or
         (Channels[c].Events[e].Frequency<=0) or
         (e=Channels[c].Count-1) then begin
        SetLength(Channels[c].EventsEXE,i+1);
        Channels[c].EventsEXE[i]:=Channels[c].Events[e];
      end else begin
        if (Channels[c].Events[e].PulseDuration<2) or    //Проверка на границы временных интервалов
           (Channels[c].Events[e].Frequency>200) or
           ((1000/Channels[c].Events[e].Frequency)-
            Channels[c].Events[e].PulseDuration<2) then begin
            TDialogService.ShowMessage('Fr./Pulse-Duration problem with channel '+Channels[c].Name);
            exit;
  {          procedure (const AResult: TModalResult; const AValues: array of string)
            var p:integer;
            begin
              if  (AResult=mrOK) then begin
              end;
            end);}
        end else begin
          d:=(Channels[c].Events[e+1].PreTime-Channels[c].Events[e].PreTime);
          n:=trunc(d*Channels[c].Events[e].Frequency/1000);
          for j := 0 to n-1 do begin
            SetLength(Channels[c].EventsEXE,i+1);
            Channels[c].EventsEXE[i].Intencity:=100;   //Описание пульса
            Channels[c].EventsEXE[i].Frequency:=0;
            Channels[c].EventsEXE[i].PulseDuration:=0;
            if j=0 then
              Channels[c].EventsEXE[i].PreTime:=Channels[c].Events[e].PreTime
            else
              Channels[c].EventsEXE[i].PreTime:=
                Channels[c].EventsEXE[i-1].PreTime+
                (1000/Channels[c].Events[e].Frequency)-
                Channels[c].Events[e].PulseDuration;
            inc(i);

            SetLength(Channels[c].EventsEXE,i+1);   //Описание базового состояния
            Channels[c].EventsEXE[i].Intencity:=0;
            Channels[c].EventsEXE[i].Frequency:=0;
            Channels[c].EventsEXE[i].PulseDuration:=0;
            Channels[c].EventsEXE[i].PreTime:=
                Channels[c].EventsEXE[i-1].PreTime+
                Channels[c].Events[e].PulseDuration;
            inc(i);
          end;
        end;
      end;
      inc(i);
    end;
    Channels[c].CountEXE:=i;
  end;
  Result:=true;
  except
  end;
end;

end.
