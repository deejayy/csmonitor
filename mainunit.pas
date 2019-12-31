unit mainunit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CoolTrayIcon, TextTrayIcon, ExtCtrls, Menus, XPMenu,
  Buttons;

type
  Tmainform = class(TForm)
    Panel1: TPanel;
    tt: TTextTrayIcon;
    t: TTimer;
    pm: TPopupMenu;
    lb: TListBox;
    Label5: TLabel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    sb1: TSpeedButton;
    host: TEdit;
    port: TEdit;
    int: TEdit;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    topic: TLabel;
    mmaps: TMemo;
    Label6: TLabel;
    procedure timertick(Sender: TObject);
    procedure goClick(Sender: TObject);
    procedure Quit1Click(Sender: TObject);
    procedure ttClick(Sender: TObject);
    procedure Go1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbDblClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel3Click(Sender: TObject);
    procedure Panel5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel5MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel5MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    down: boolean;
    fleft, ftop: integer;
    drag: boolean;
  end;

var
  mainform: Tmainform;

implementation

{$R *.dfm}

uses blcksock, registry;

type st = record
      ipport : string;
      title  : string;
      map    : string;
      game   : string;
      name   : string;
      players: byte;
      limit  : byte;
      tmp    : string;
      tmp2   : byte;
      url    : string;
     end;

     servers = record
      name   : string;
      ipport : string;
     end;

     aoc = array of char;

var sinfo: string;
    gs: string;
    play: integer;
    path: string;
    buffer : aoc;
    tm    : array of servers;

procedure delay(ms: longword);
var tick: longword;
begin
    tick := GetTickCount;
    repeat
      application.processmessages;
    until tick - gettickcount >= ms;
end;

function buildinfo(buf: aoc): string;
var i: longword;
    s: st;
begin
  i := 5;
  repeat if buf[i] <> #0 then s.ipport   := s.ipport   + buf[i] else break; inc(i); until false; inc(i);
  repeat if buf[i] <> #0 then s.title    := s.title    + buf[i] else break; inc(i); until false; inc(i);
  repeat if buf[i] <> #0 then s.map      := s.map      + buf[i] else break; inc(i); until false; inc(i);
  repeat if buf[i] <> #0 then s.game     := s.game     + buf[i] else break; inc(i); until false; inc(i);
  repeat if buf[i] <> #0 then s.name     := s.name     + buf[i] else break; inc(i); until false; inc(i);
  s.players := ord( buf[i] ); inc(i); s.limit := ord( buf[i] ); inc(i);
  repeat if buf[i] <> #0 then s.tmp := s.tmp + buf[i] else break; inc(i); until false; inc(i);
  s.tmp2 := ord( buf[i] ); inc(i);
  repeat if buf[i] <> #0 then s.url := s.url + buf[i] else break; inc(i); until false;

  play   := s.players;
  result := format('IP:Port: %s'#13#10'Map : %s'#13#10'Title: %s'#13#10'Players: %d/%d'#13#10'Last check: %s', [s.ipport, s.map, s.title, s.players, s.limit, timetostr(now)]);

  if (gs <> s.map) and (s.map <> '') then
    if (pos(s.map, mainform.mmaps.text)<>0) then
      mainform.tt.ShowBalloonHint('changelevel', s.map, bitInfo, 10);
  
  if s.map <> '' then
    gs := s.map;
end;

function getinfo(send: string; maxlen: longword): aoc;
var
    sock: TUDPBlockSocket;
begin
    sock := TUDPBlockSocket.Create;
    try
      setlength(result, maxlen);
      sock.CreateSocket;
      sock.SetRecvTimeout(1500);
      sock.EnableBroadcast(true);
      sock.Connect(mainform.host.text, mainform.port.text);
      sock.SendString(send);
      sock.RecvBuffer(pchar( result ), maxlen);
    finally
      sock.AbortSocket;
      sock.CloseSocket;
      sock.Free;
    end;
end;

procedure getserverinfo;
begin
  sinfo := buildinfo(getinfo(#$FF + #$FF + #$FF + #$FF + 'T', 1024));
end;

procedure getplayerinfo;
begin
  buffer := getinfo(#$FF + #$FF + #$FF + #$FF + 'players', 1024);
end;

procedure Tmainform.timertick(Sender: TObject);
var
    i, n: integer;
    kills: integer;
    playa: string;
    mi  : Tmenuitem;
    thid, thr: longword;
begin
    thr := createthread(nil, 0, @getserverinfo, nil, 0, thid);
    delay(1000);
    closehandle(thr);

    thr := createthread(nil, 0, @getplayerinfo, nil, 0, thid);
    delay(1000);
    closehandle(thr);

    tt.hint := sinfo;
    tt.text := inttostr(play);

    i := 7;
    if length(buffer)>6 then begin
      pm.Items.Clear;
      for n := 1 to ord(buffer[5]) do begin
        playa := '';
        repeat if buffer[i] <> #0 then playa := playa + buffer[i] else break; inc(i); until false; inc(i);
        kills := ord(buffer[i]) + ord(buffer[i+1])*256; inc(i, 9);
        mi := TMenuItem.Create(self);
        mi.Caption := playa + #9 + inttostr(kills);
        pm.Items.Add(mi);
      end;
      mi := TMenuItem.Create(self);
      mi.Caption := '-';
      pm.Items.Add(mi);

      mi := TMenuItem.Create(self);
      mi.Caption := 'Run CS!';
      mi.OnClick := go1click;
      pm.Items.Add(mi);

      mi := TMenuItem.Create(self);
      mi.Caption := '-';
      pm.Items.Add(mi);

      mi := TMenuItem.Create(self);
      mi.Caption := 'Quit';
      mi.OnClick := Quit1Click;
      pm.Items.Add(mi);
    end;
end;

procedure Tmainform.goClick(Sender: TObject);
begin
  t.interval := strtoint(int.text);
  t.enabled := true;
  timertick(sender);
  application.Minimize;
end;

procedure Tmainform.Quit1Click(Sender: TObject);
begin
  if messagedlg('Really?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    application.Terminate;
end;

procedure Tmainform.ttClick(Sender: TObject);
begin
  t.enabled := false;
  application.restore;
end;

procedure Tmainform.Go1Click(Sender: TObject);
begin
  chdir(path);
  winexec(pchar(path+'hl.exe -steam -game cstrike +connect '+host.text+':'+port.text), 0);
end;

procedure Tmainform.FormCreate(Sender: TObject);
var reg   : tregistry;
    lpath : string;
    fpath : string;
    f     : textfile;
    s, k  : string;
    vane  : boolean;
    i     : integer;
begin
  gs := '';
  reg := tregistry.create;
  reg.RootKey := HKEY_CURRENT_USER;
  reg.openkey('Software\Valve\Steam', false);
  lpath := reg.ReadString('ModInstallPath');
  reg.closekey;
  reg.destroy;

  lpath := lowercase( lpath );
  path := copy(lpath,1,pos('half-life',lpath)-1) + 'counter-strike\';
  fpath := copy(lpath,1,pos('steamapps',lpath)-1) + 'config\serverbrowser.vdf';
  vane := false;

  i := 0;
  if fileexists(fpath) then begin
    assignfile(f, fpath);
    reset(f);
    setlength(tm, 1);
    while not eof(f) do begin
      readln(f, s);
      if pos('Favorites',s)<>0 then vane := true;
      if vane then begin
        if pos('"name"', s)<>0 then begin
          delete(s,1,pos('"name"',s)+6);
          k := copy(s,pos('"',s)+1,length(s)-pos('"',s)-1);
          tm[i].name := k;
        end;
        if pos('"address"', s)<>0 then begin
          delete(s,1,pos('"address"',s)+9);
          k := copy(s,pos('"',s)+1,length(s)-pos('"',s)-1);
          tm[i].ipport := k;
          setlength(tm, high(tm)+2);
          inc(i);
        end;
      end;
    end;
    closefile(f);
  end;

  for i := 0 to high(tm) do begin
    lb.items.Add(tm[i].name);
  end;
end;

procedure Tmainform.FormShow(Sender: TObject);
begin
  t.enabled := false;
end;

procedure Tmainform.lbDblClick(Sender: TObject);
var x: string;
begin
  x := tm[lb.itemindex].ipport;
  host.text := copy(x,1,pos(':',x)-1);
  port.text := copy(x,pos(':',x)+1,255);
end;

procedure Tmainform.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//
  fleft := mainform.left;
  ftop := mainform.top;
end;

procedure Tmainform.Panel3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  tpanel(sender).BevelOuter := bvLowered;
end;

procedure Tmainform.Panel3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  tpanel(sender).BevelOuter := bvRaised;
end;

procedure Tmainform.Panel3Click(Sender: TObject);
begin
  close;
end;

procedure Tmainform.Panel5MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  fleft := x;
  ftop := y;
  drag := true;
end;

procedure Tmainform.Panel5MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if drag then begin
    mainform.left := mouse.CursorPos.x - fleft;
    mainform.top := mouse.CursorPos.y - ftop;
  end;
end;

procedure Tmainform.Panel5MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  drag := false;
end;

end.
