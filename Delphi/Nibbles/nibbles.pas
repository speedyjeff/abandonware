unit nibbles;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
     procedure ThreadDone(Sender: TObject);
    { Public declarations }
  end;

  theHolyThread = class(TThread)
  private
  protected
    procedure Execute; override;
  public
    constructor Create;
  end;

  Tnibbles = class(theHolyThread)
   public
  end;

var
  Form1: TForm1;
  Tnib : Tnibbles;

implementation

uses
  help;

{$R *.DFM}

const
  W=2;
  SP=1;
type
  pointer=^pivetrec;
  pivetrec=record
    xp:integer;
    yp:integer;
    bs:integer;
    bt:integer;
    next:pointer;
  end;
  pointrec=record
    x1:integer;
    x2:integer;
    y1:integer;
    y2:integer;
  end;
  arraytype=array[1..8]of pointrec;

var
  doublebuffer:tbitmap;
  blankbuffer:tbitmap;
  WAIT:integer;
  DELTIME:integer;
  xf,yf:integer;
  xb,yb:integer;
  s,t:integer;
  sb,tb:integer;
  pivetf,pivetb:pointer;
  delaynum:integer;
  level:integer;
  innerwalls:arraytype;
  box:pointrec;
  numwalls:integer;
  count:integer;
  boxhit:boolean;
  ntlpivet:pointer;
  temparay:integer;
  speed:integer;
  myThread:TThread;
  nibhit,temp:boolean;
  ThreadsRunning: Integer;


  (*************************************************************************)

{procedure Tnibbles.setPriority;
begin
  Priority:= tpTimeCritical;  {tpHighest  tpTimeCritical   }
{end;}

procedure place_numbers;
var
  found:boolean;
  x,y:integer;
  j:integer;
begin
  found:=false;
  while not(found) do
   begin
    found:=true;
    x:=random(600)+10;
    y:=random(400)+10;
    for j:=1 to numwalls do
     begin
      if (x>innerwalls[j].x1-20) and (x<innerwalls[j].x2+5) and (y>innerwalls[j].y1-20) and
         (y<innerwalls[j].y2+5) then
           found:=false;
     end;
   end;
  box.x1:=x;
  box.y1:=y;
  //doublebuffer.canvas.brush.color:=clpurple;
  Form1.canvas.brush.color:=clpurple;
  //doublebuffer.canvas.rectangle(box.x1,box.y1,box.x1+20,box.y1+20);
  Form1.canvas.rectangle(box.x1,box.y1,box.x1+20,box.y1+20);
  //doublebuffer.canvas.brush.color:=clwhite;
  Form1.canvas.brush.color:=clwhite;
  //doublebuffer.canvas.textout(box.x1+4,box.y1+3,inttostr(count));
  Form1.canvas.textout(box.x1+4,box.y1+3,inttostr(count));
end;

procedure place_walls;
begin
  //doublebuffer.canvas.brush.color:=clgreen;
  Form1.canvas.brush.color:=clgreen;
  //doublebuffer.canvas.rectangle(0,0,10,435);
  Form1.canvas.rectangle(0,0,10,435);
  //doublebuffer.canvas.rectangle(0,0,635,10);
  Form1.canvas.rectangle(0,0,635,10);
  //doublebuffer.canvas.rectangle(625,0,635,435);
  Form1.canvas.rectangle(625,0,635,435);
  //doublebuffer.canvas.rectangle(0,425,635,435);
  Form1.canvas.rectangle(0,425,635,435);

  if (level = 1) or (level = 2) or (level = 3) then
   begin
     with innerwalls[1] do
      begin
       x1:=100;
       y1:=75;
       x2:=125;
       y2:=350;
       //doublebuffer.canvas.rectangle(x1,y1,x2,y2);
       Form1.canvas.rectangle(x1,y1,x2,y2);
      end;
     with innerwalls[2] do
      begin
       x1:=500;
       y1:=75;
       x2:=525;
       y2:=350;
       //doublebuffer.canvas.rectangle(x1,y1,x2,y2);
       Form1.canvas.rectangle(x1,y1,x2,y2);
      end;
     numwalls:=2;
   end;  (*of if level 1 2 3*)
  if (level = 2) then
   begin
    with innerwalls[3] do
     begin
      x1:=200;
      y1:=75;
      x2:=450;
      y2:=100;
      //doublebuffer.canvas.rectangle(x1,y1,x2,y2);
      Form1.canvas.rectangle(x1,y1,x2,y2);
     end;
    with innerwalls[4] do
     begin
      x1:=200;
      y1:=325;
      x2:=450;
      y2:=350;
      //doublebuffer.canvas.rectangle(x1,y1,x2,y2);
      Form1.canvas.rectangle(x1,y1,x2,y2);
     end;
    numwalls:=numwalls+2;
   end;  (*of if level 2*)
  if (level = 3) then
   begin
    with innerwalls[3] do
     begin
      x1:=125;
      y1:=200;
      x2:=500;
      y2:=225;
      //doublebuffer.canvas.rectangle(x1,y1,x2,y2);
      Form1.canvas.rectangle(x1,y1,x2,y2);
     end;
    numwalls:=numwalls+1;
   end;

  if (level = 4) then
   begin
    with innerwalls[1] do
      begin
       x1:=200;
       y1:=10;
       x2:=225;
       y2:=180;
       //DoubleBuffer.canvas.rectangle(x1,y1,x2,y2);
       Form1.canvas.rectangle(x1,y1,x2,y2);
      end;
     with innerwalls[2] do
      begin
       x1:=10;
       y1:=300;
       x2:=300;
       y2:=325;
       //doublebuffer.canvas.rectangle(x1,y1,x2,y2);
       Form1.canvas.rectangle(x1,y1,x2,y2);
      end;
    with innerwalls[3] do
      begin
       x1:=325;
       y1:=125;
       x2:=625;
       y2:=150;
       //doublebuffer.canvas.rectangle(x1,y1,x2,y2);
       Form1.canvas.rectangle(x1,y1,x2,y2);
      end;
     with innerwalls[4] do
      begin
       x1:=400;
       y1:=260;
       x2:=425;
       y2:=425;
       //doublebuffer.canvas.rectangle(x1,y1,x2,y2);
       Form1.canvas.rectangle(x1,y1,x2,y2);
      end;
     numwalls:=4;
   end;
end;

procedure check_box;
begin
  if (xf >= box.x1) and (xf <= box.x1+20) and (yf >= box.y1) and (yf <= box.y1+20) then
   begin
    //doublebuffer.canvas.brush.color:=clblack;
    Form1.canvas.brush.color:=clblack;
    //doublebuffer.canvas.rectangle(box.x1,box.y1,box.x1+20,box.y1+20);
    Form1.canvas.rectangle(box.x1,box.y1,box.x1+20,box.y1+20);
    delaynum:=delaynum+count*WAIT;
    count:=count+1;
    if (count <= 10) then
     place_numbers
    else
     begin
      box.x1:=1000;
      box.y1:=1000;
     end;
   end;
end;

procedure pop;
var
  p:pointer;
begin
  p:=pivetf;
  if (p <> nil) then
   begin
    sb:=p^.bs;
    tb:=p^.bt;
    pivetf:=pivetf^.next;
    dispose(p);
   end;
end;

procedure deq;
begin
  pop;
  if (pivetf = nil) then
    pivetb:=nil;
end;

procedure enq;
var
  p:pointer;
begin
  new(p);
  p^.xp:=xf;
  p^.yp:=yf;
  p^.bs:=s;
  p^.bt:=t;
  p^.next:=nil;
  if (pivetf = nil) then
   begin
    pivetb:=p;
    pivetf:=p;
   end
  else
   begin
    pivetb^.next:=p;
    pivetb:=p;
   end;
end;

function check_walls : boolean;
var
  hit:boolean;
  j:integer;
begin
  hit:=false;
  if (xf <= 10-W) or (xf >= 625-W) or (yf <= 10-W) or (yf >= 425-W) then
    hit:=true;
  for j:=1 to numwalls do
   begin
    if (xf >= innerwalls[j].x1) and (xf <= innerwalls[j].x2) and
       (yf >= innerwalls[j].y1) and (yf <= innerwalls[j].y2) then
          hit:=true;
    end;
   check_walls:=hit;
end;

procedure find_next_to_last;
var
  p,pb,pt:pointer;
  found:boolean;
begin
  p:=pivetf;
  pb:=pivetb;
  found:=false;
  while (p <> pb) and not(found) do
   begin
    if (p^.next = pb) then
     begin
      ntlpivet:=p;
      found:=true;
     end;
    p:=p^.next;
   end;
end;

function check_self : boolean;
var
  p,pb,pnb:pointer;
  hit:boolean;
  count:integer;
begin
  count:=1;
  p:=pivetf;
  pb:=pivetb;
  hit:=false;
  (* back on self*)
  if (p <> nil) then
   begin
    if (p = pb) then
     begin
      if (xf = xb) and (xf = p^.xp) then
       begin
        if (yf <= yb) and (yf >= p^.yp) then
         begin
    //      showMessage('Its here #1.1');
         hit:=true;
         end;
        if (yf >= yb) and (yf <= p^.yp) then
         begin
      //    showMessage('Its here #1.2');
         hit:=true;
         end;
      if (yf = yb) and (yf = p^.yp) then
       begin
        if (xf <= xb) and (xf >= p^.xp) then
         begin
        //  showMessage('Its here #1.3');
         hit:=true;
         end;
        if (xf >= xb) and (xf <= p^.xp) then
         begin
          //showMessage('Its here #1.4');
         hit:=true;
         end;
       end;
      end;
    if (p <> pb) then
     begin
      find_next_to_last;
      if (xf = pb^.xp) and (xf = pnb^.xp) then
       begin
        if (yf <= pb^.yp) and (yf >= pnb^.yp) then
         begin
//          showMessage('Its here #2.1');
         hit:=true;
         end;
        if (yf >= pb^.yp) and (yf <= pnb^.yp) then
         begin
  //        showMessage('Its here #2.2');
         hit:=true;
         end;
       end;
      if (yf = pb^.yp) and (yf = pnb^.yp) then
       begin
        if (xf <= pb^.xp) and (xf >= pnb^.xp) then
         begin
    //      showMessage('Its here #2.3');
          hit:=true;
          end;
        if (xf >= pb^.xp) and (xf <= pnb^.xp) then
         begin
      //    showMessage('Its here #2.4');
         hit:=true;
         end;
       end;
     end;
    end;
   end;
  (* end of back on self *)

  p:=pivetf;
  pb:=pivetb;
  while (p <> nil) and not(hit) do
   begin
   (*middle*)
   if (p <> pb) and (p^.next <> nil) then
    begin
     (* equal on the x axis *)
     if (xf >= p^.xp) and (xf <= p^.next^.xp) then
       if (yf = p^.yp) then
         begin
//          showMessage('Its here #3.1');
         hit:=true;
         end;
     if (xf <= p^.xp) and (xf >= p^.next^.xp) then
       if (yf = p^.yp) then
         begin
  //        showMessage('Its here #3.2');
         hit:=true;
         end;
     (* equal on the y axis *)
     if (yf >= p^.yp) and (yf <= p^.next^.yp) then
       if (xf = p^.xp) then
         begin
    //      showMessage('Its here #3.3');
         hit:=true;
         end;
     if (yf <= p^.yp) and (yf >= p^.next^.yp) then
       if (xf = p^.xp) then
         begin
      //    showMessage('Its here #3.4');
         hit:=true;
         end;
    end; (*of p<>pb*)
    if (count = 1) then
     begin
      (* equal on the x axis *)
      if (xf >= p^.xp) and (xf <= xb) then
       if (yf = yb) then
         hit:=true;
      if (xf <= p^.xp) and (xf >= xb) then
       if (yf = yb) then
        hit:=true;
      (* equal on the y axis *)
      if (yf >= p^.yp) and (yf <= yb) then
       if (xf = xb) then
         hit:=true;
      if (yf <= p^.yp) and (yf >= yb) then
       if (xf = xb) then
         hit:=true;
     end;
    p:=p^.next;
    count:=count+1;
   end; (* of while*)
  check_self:=hit;
end;

procedure nibbles_move;
var
  p,pb:pointer;
  yes:boolean;
  difx,dify:integer;
begin
  difx:=0;
  dify:=0;
  yes:=false;
  if (delaynum <= 0) and (speed <> 0) then
   begin
    p:=pivetf;
    //doublebuffer.canvas.brush.color:=clblack;
    form1.canvas.brush.color:=clblack;
    if (p = nil) then
     //doublebuffer.canvas.rectangle(xf-W,yf-W,xb+W,yb+W)
     form1.canvas.rectangle(xf-W,yf-W,xb+W,yb+W)
    else
     //doublebuffer.canvas.rectangle(p^.xp-W,p^.yp-W,xb+W,yb+W);
     form1.canvas.rectangle(p^.xp-W,p^.yp-W,xb+W,yb+W);
    if (p <> nil) then
     if (xb >= p^.xp) and (yb >= p^.yp) then
      if (xb-speed <= p^.xp) and (yb-speed <= p^.yp) then
       begin
        yes:=true;
       { difx:=xb-p^.xp;
        dify:=yb-p^.yp; }
       end;
     if (yes) then
      begin
       xb:=p^.xp;
       yb:=p^.yp;
       deq;
       //doublebuffer.canvas.rectangle(xb-10,yb-10,xb+10,yb+10);
       form1.canvas.rectangle(xb-10,yb-10,xb+10,yb+10);
      end;
    p:=pivetf;
    xb:=xb+sb;
    yb:=yb+tb;
    //doublebuffer.canvas.brush.color:=clred;
    form1.canvas.brush.color:=clred;
    if (p <> nil) then
     //doublebuffer.canvas.rectangle(p^.xp-W,p^.yp-W,xb+W,yb+W);
     form1.canvas.rectangle(p^.xp-W,p^.yp-W,xb+W,yb+W);
   end
  else
   delaynum:=delaynum-speed;
  (*end of back of nibbles*)

  (*front of nibbles*)
  pb:=pivetb;
  xf:=xf+s+difx;
  yf:=yf+t+dify;
  //doublebuffer.canvas.brush.color:=clred;
  form1.canvas.brush.color:=clred;
  if (pb = nil) then
   //doublebuffer.canvas.rectangle(xf-W,yf-W,xb+W,yb+W)
   form1.canvas.rectangle(xf-W,yf-W,xb+W,yb+W)
  else
   //doublebuffer.canvas.rectangle(xf-W,yf-W,pb^.xp+W,pb^.yp+W);
   form1.canvas.rectangle(xf-W,yf-W,pb^.xp+W,pb^.yp+W);
  difx:=0;  dify:=0;
end;

procedure TForm1.ThreadDone(Sender: TObject);
var
  Bitmap1: TBitmap;
begin
  ThreadsRunning:=ThreadsRunning-1;
  if ThreadsRunning = 0 then
  begin
    speed:=-999;
    doublebuffer.canvas.copyrect(rect(0,0,635,435),blankbuffer.canvas,rect(0,0,
                       635,435));
    Bitmap1 := TBitmap.Create;
    Bitmap1.LoadFromFile('site.bmp');
    doublebuffer.canvas.draw(75,30,Bitmap1);
    form1.canvas.copyrect(rect(0,0,635,435),doublebuffer.canvas,rect(0,0,635,435));
  end;
end;

procedure theMeat;
begin
  form1.canvas.copyrect(rect(0,0,635,435),doublebuffer.canvas,rect(0,0,635,435));
  place_walls;
  nibbles_move;
  place_numbers;
  repeat
    place_walls;
    nibbles_move;
    check_box;
    nibhit:=check_self;
    temp:=check_walls;
    if (count > 10) and (delaynum = 0) then
     begin
      doublebuffer.canvas.copyrect(rect(0,0,635,435),blankbuffer.canvas,rect(0,0,
                       635,435));
      while (pivetf <> nil) do
       begin
        deq;
       end;
      pivetf:=nil;
      pivetb:=nil;
      speed:=0;
      WAIT:=WAIT+10;
      delaynum:=0;
      count:=1;
      if (level = 4) then
       level:=0;
      level:=level+1;
      if (level = 1) then
       begin
        s:=0;  t:=0;
        sb:=0;  tb:=0;
        xb:=300;  xf:=300;
        yb:=100;  yf:=200;
       end;
      if (level = 2) or (level = 3) then
       begin
        s:=0; t:=0;
        sb:=0; tb:=0;
        xb:=100; xf:=200;
        yb:=50; yf:=50;
       end;
      if (level = 4) then
       begin
        s:=0; t:=0;
        sb:=0; tb:=0;
        xb:=305; xf:=305;
        yb:=105; yf:=205;
       end;
     form1.canvas.copyrect(rect(0,0,635,435),doublebuffer.canvas,rect(0,0,635,435));
      place_walls;
      place_numbers;
      nibbles_move;
     end;
  until (temp) or (nibhit);
  showMessage('Its over');
{  if (temp) then
    showMessage('The walls')
   else
   if (nibhit) then
    showMessage('Himself')
   else
    showMessage('Who knows');}
end;    // end of theMeat

procedure Tform1.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if not(temp) and not(nibhit) and (speed <> 0) then
  begin
   case (key) of
     '8':begin
          s:=0;
          t:=-speed;
          enq;
          //label1.caption:='up';
        end;
     '4':begin
          s:=-speed;
          t:=0;
          enq;
          //label1.caption:='left';
        end;
     '6':begin
          s:=speed;
          t:=0;
          enq;
          //label1.caption:='right';
        end;
     '5':begin
          s:=0;
          t:=speed;
          enq;
          //label1.caption:='down';
        end;
     end;  (*of case*)
   nibbles_move;
  end;
  if (speed = 0) and (ord(key)=27) then
    begin
     speed:=SP;
     if (level = 1) or (level = 4) then
      begin
       s:=0;  t:=speed;
       sb:=0;  tb:=speed;
      end
     else
      begin
       s:=speed;  t:=0;
       sb:=speed;  tb:=0;
      end;
     nibbles_move;
    end;
  if (speed = -999) and (ord(key) = 13) then
    close;
  if (speed = -999) and (ord(key) = 27) then
    close;
end;

constructor theHolyThread.Create;
  begin
    inherited Create(False);
    FreeOnTerminate := True;
    Priority:= tpIdle;  {tpIdle, tpLowest, tpLower, tpNormal, tpHigher, tpHighest,
  tpTimeCritical); }
    //showMessage(inttostr(ord(Priority)));
  end;

  procedure theHolyThread.Execute;
  begin
    theMeat;
  end;

{procedure TForm1.Timer1Timer(Sender: TObject);
begin
    nibbles_move;
    place_walls;  (*draws the walls*)
      check_box;
      check_walls;
      if (check_self) then
       exit:=true;
      if (count > 10) and (delaynum = 0) then
       begin
        doublebuffer.canvas.copyrect(rect(0,0,635,435),blankbuffer.canvas,rect(0,0,
                         635,435));
        while (pivetf <> nil) do
         begin
          deq;
         end;
        pivetf:=nil;
        pivetb:=nil;
        speed:=0;
        WAIT:=WAIT+10;
        delaynum:=0;
        count:=1;
        if (level = 4) then
         level:=0;
        level:=level+1;
        if (level = 1) then
         begin
          s:=0;  t:=0;
          sb:=0;  tb:=0;
          xb:=300;  xf:=300;
          yb:=100;  yf:=200;
         end;
        if (level = 2) or (level = 3) then
         begin
          s:=0; t:=0;
          sb:=0; tb:=0;
          xb:=100; xf:=200;
          yb:=50; yf:=50;
         end;
        if (level = 4) then
         begin
          s:=0; t:=0;
          sb:=0; tb:=0;
          xb:=305; xf:=305;
          yb:=105; yf:=205;
         end;
        place_walls;
        place_numbers;
        nibbles_move;
       end;
      form1.canvas.copyrect(rect(0,0,635,435),doublebuffer.canvas,rect(0,0,635,435));
end;
}


procedure TForm1.FormActivate(Sender: TObject);
begin
  doublebuffer:=tbitmap.create;
  doublebuffer.height:=435;
  doublebuffer.width:=635;
  doublebuffer.canvas.brush.color:=clblack;
  doublebuffer.canvas.rectangle(0,0,635,435);
  blankbuffer:=tbitmap.create;
  blankbuffer.height:=435;
  blankbuffer.width:=635;
  blankbuffer.canvas.brush.color:=clblack;
  blankbuffer.canvas.rectangle(0,0,635,435);
  randomize;
  level:=1;
  speed:=0;
  s:=0;  t:=speed;
  sb:=0;  tb:=speed;
  (*level 1*)
  xb:=300;  xf:=300;
  yb:=50;  yf:=150;
  (*level 2 and 3*)
(*  xb:=100; xf:=200;
  yb:=50; yf:=50;*)
  (*level 4*)
(*  xb:=305; xf:=305;
  yb:=105; yf:=205;*)
  pivetf:=nil;
  pivetb:=nil;
  WAIT:=10;
  boxhit:=true;
  DELTIME:=10;
  delaynum:=0;
  count:=1;
  nibhit:=false;
  temp:=false;
  ThreadsRunning := 1;
  with Tnibbles.Create do
    OnTerminate := form1.ThreadDone;
  //Tnibbles.setPriority;
  //showMessage('you have started');
  form1.canvas.copyrect(rect(0,0,635,435),Blankbuffer.canvas,rect(0,0,635,435));
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form3.close;
end;

end.
