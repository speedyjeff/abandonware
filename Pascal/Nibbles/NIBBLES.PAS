
program Nibbles;

uses
  graphics,graph,jefflib,crt;

type
  pointer=^pivetrec;
  pivetrec = record
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
  arraytype=array[1..8] of pointrec;

var
  WAIT:integer;
  DELTIME:integer;

procedure pop(var pivet:pointer;var sb,tb:integer);
var
  p:pointer;       (*temperary pointer*)
begin
  p:=pivet;
  if (p <> nil) then
   begin
    sb:=p^.bs;
    tb:=p^.bt;
    pivet:=pivet^.next;
    dispose(p);
   end;   (* of else*)
end;      (* of pop*)

procedure deq(var pivetf,pivetb:pointer;var sb,tb:integer);
begin
  pop(pivetf,sb,tb);
  if (pivetf = NIl) then
    pivetb:=nil;
end;

procedure enq(var pivetf,pivetb:pointer; xf,yf,sb,tb:integer);
var
  p:pointer;
begin
  new(p);
  p^.xp:=xf;
  p^.yp:=yf;
  p^.bs:=sb;
  p^.bt:=tb;
  p^.next:=nil;
  if pivetf = Nil then
   begin
     pivetb:=p;
     pivetf:=p;
   end
   else
   begin
     pivetb^.next:=p;
     pivetb:=p;
   end;
end;   (*of enq*)

procedure place_numbers(var box:pointrec; innerwalls:arraytype;
                        numwalls:integer; delaynum,count:integer);
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
      if (x>innerwalls[j].x1-20) and (x<innerwalls[j].x2+5) and (y>innerwalls[j].y1-20) and (y<innerwalls[j].y2+5) then
        found:=false;
     end;
   end;
  box.x1:=x;
  box.y1:=y;
  setcolor(magenta);
  rectangle(box.x1,box.y1,box.x1+20,box.y1+20);
  setfillstyle(1,5);
  floodfill(box.x1+1,box.y1+1,5);
  setcolor(white);
  outtextxy(box.x1+2,box.y1+5,inttostr('',count,''));
end;

function check_walls(xf,yf:integer; innerwalls:arraytype; numwalls:integer):boolean;
var
  hit:boolean;
  j:integer;
begin
  hit:=true;
  if (xf <= 5) or (xf >= 630) or (yf <= 5) or (yf >= 430) then
    hit:=false;
  for j:= 1 to numwalls do
   begin
    if (xf >= innerwalls[j].x1) and (xf <= innerwalls[j].x2) and
       (yf >= innerwalls[j].y1) and (yf <= innerwalls[j].y2) then
         hit:=false;
   end;
  check_walls:=hit;
end;

function find_next_to_last(pivetf,pivetb:pointer):pointer;
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
      pt:=p;
      found:=true;
     end;
    p:=p^.next;
   end;
  find_next_to_last:=pt;
end;


function check_self(xf,yf,xb,yb:integer;pivetf,pivetb:pointer):boolean;
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
         hit:=true;
        if (yf >= yb) and (yf <= p^.yp) then
         hit:=true;
      if (yf = yb) and (yf = p^.yp) then
       begin
        if (xf <= xb) and (xf >= p^.xp) then
         hit:=true;
        if (xf >= xb) and (xf <= p^.xp) then
         hit:=true;
       end;
      end;
    if (p <> pb) then
     begin
      pnb:=find_next_to_last(pivetf,pivetb);
      if (xf = pb^.xp) and (xf = pnb^.xp) then
       begin
        if (yf <= pb^.yp) and (yf >= pnb^.yp) then
         hit:=true;
        if (yf >= pb^.yp) and (yf <= pnb^.yp) then
         hit:=true;
       end;
      if (yf = pb^.yp) and (yf = pnb^.yp) then
       begin
        if (xf <= pb^.xp) and (xf >= pnb^.xp) then
          hit:=true;
        if (xf >= pb^.xp) and (xf <= pnb^.xp) then
         hit:=true;
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
         hit:=true;
     if (xf <= p^.xp) and (xf >= p^.next^.xp) then
       if (yf = p^.yp) then
         hit:=true;
     (* equal on the y axis *)
     if (yf >= p^.yp) and (yf <= p^.next^.yp) then
       if (xf = p^.xp) then
         hit:=true;
     if (yf <= p^.yp) and (yf >= p^.next^.yp) then
       if (xf = p^.xp) then
         hit:=true;
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

procedure check_box(xf,yf:integer; var delaynum:integer;var box:pointrec;
                    innerwalls:arraytype; numwalls:integer; var count:integer);
begin
  if (xf >= box.x1) and (xf <= box.x1+20) and (yf >= box.y1) and (yf <= box.y1+20) then
   begin
     (* clears box *)
     setcolor(black);
     rectangle(box.x1,box.y1,box.x1+20,box.y1+20);
     setfillstyle(1,0);
     floodfill(box.x1+1,box.y1+1,0);
     (* set the delay *)
     delaynum:=count*WAIT+delaynum;
     (* calls for new number *)
     count:=count+1;
     if (count<=10) then
      place_numbers(box,innerwalls,numwalls,delaynum,count)
     else
      begin
       box.x1:=0;
       box.y1:=0;
      end;
   end;
end;

procedure place_walls(var level:integer; var innerwalls:arraytype;var numwalls:integer);
begin
  (*the outer limit*)
  setcolor(green);
  rectangle(0,0,635,435);
  rectangle(5,5,630,430);
  setfillstyle(1,2);
  floodfill(1,1,2);
  if (level = 1) or (level = 2) or (level = 3) then
   begin
    with innerwalls[1] do
     begin
      x1:=100;
      y1:=75;
      x2:=125;
      y2:=350;
      rectangle(x1,y1,x2,y2);
      setfillstyle(1,2);
      floodfill(x1+1,y1+1,2);
     end;
    with innerwalls[2] do
     begin
      x1:=500;
      y1:=75;
      x2:=525;
      y2:=350;
      rectangle(x1,y1,x2,y2);
      setfillstyle(1,2);
      floodfill(x1+1,y1+1,2);
     end;
    numwalls:=2;
   end;
  if (level = 2) then
   begin
    with innerwalls[3] do
     begin
      x1:=200;
      y1:=75;
      x2:=450;
      y2:=100;
      rectangle(x1,y1,x2,y2);
      setfillstyle(1,2);
      floodfill(x1+1,y1+1,2);
     end;
    with innerwalls[4] do
     begin
      x1:=200;
      y1:=325;
      x2:=450;
      y2:=350;
      rectangle(x1,y1,x2,y2);
      setfillstyle(1,2);
      floodfill(x1+1,y1+1,2);
     end;
    numwalls:=numwalls+2;
   end;
  if (level = 3) then
   begin
   with innerwalls[3] do
     begin
      x1:=125;
      y1:=200;
      x2:=500;
      y2:=225;
      rectangle(x1,y1,x2,y2);
      setfillstyle(1,2);
      floodfill(x1+1,y1+1,2);
     end;
    numwalls:=numwalls+1;
   end;
  if (level = 4) then
   begin
    with innerwalls[1] do
     begin
      x1:=200;
      y1:=5;
      x2:=225;
      y2:=180;
      rectangle(x1,y1,x2,y2);
      setfillstyle(1,2);
      floodfill(x1+1,y1+1,2);
     end;
    with innerwalls[2] do
     begin
      x1:=5;
      y1:=300;
      x2:=300;
      y2:=325;
      rectangle(x1,y1,x2,y2);
      setfillstyle(1,2);
      floodfill(x1+1,y1+1,2);
     end;
    with innerwalls[3] do
     begin
      x1:=300;
      y1:=75;
      x2:=635;
      y2:=100;
      rectangle(x1,y1,x2,y2);
      setfillstyle(1,2);
      floodfill(x1+1,y1+1,2);
     end;
    with innerwalls[4] do
     begin
      x1:=400;
      y1:=260;
      x2:=425;
      y2:=435;
      rectangle(x1,y1,x2,y2);
      setfillstyle(1,2);
      floodfill(x1+1,y1+1,2);
     end;
    numwalls:=4;
   end;
  level:=level+1;
end;

procedure nibbles_move(var xf,xb,yf,yb,s,t,sb,tb:integer;
                       var pivetf,pivetb:pointer;
                       var delaynum:integer);
var
  p,pb:pointer;
begin
  (* the back of nibbles *)
  if (delaynum = 0) then
   begin
    p:=pivetf;
    setcolor(black);
    if (p = nil) then
      line(xf,yf,xb,yb)
    else
     line(p^.xp,p^.yp,xb,yb);
    if (p <> nil) then
      if (xb = p^.xp) and (yb = p^.yp) then
        deq(pivetf,pivetb,sb,tb);
    p:=pivetf;
    xb:=xb+sb;
    yb:=yb+tb;
    setcolor(red);
    if (p <> nil) then
      line(p^.xp,p^.yp,xb,yb);
   end
   else  delaynum:=delaynum-1;
  (* end of back of nibbles *)

  (* front of nibbles *)
  pb:=pivetb;
  xf:=xf+s;
  yf:=yf+t;
  setcolor(red);
  if (pb = nil) then
    line(xf,yf,xb,yb)
  else
    line(xf,yf,pb^.xp,pb^.yp);
end;

procedure mainGame;
var
  key:char;
  xf,yf:integer;
  xb,yb:integer;
  s,t:integer;
  sb,tb:integer;
  pivetf,pivetb:pointer;
  delaynum:integer;
  level:integer;
  temp:boolean;
  innerwalls:arraytype;
  box:pointrec;
  numwalls:integer;
  count:integer;
  nibhit:boolean;
  lastkey:char;
begin
  randomize;
  level:=1;
  s:=0;  t:=1;
  sb:=0;  tb:=1;
  xb:=300; xf:=300;
  yb:=100; yf:=200;
  pivetf:=nil;
  pivetb:=nil;
  key:=' ';
  WAIT:=10;
  delaynum:=0;
  count:=1;
  place_walls(level,innerwalls,numwalls);
  place_numbers(box,innerwalls,numwalls,delaynum,count);
  readln;
  repeat
    nibbles_move(xf,xb,yf,yb,s,t,sb,tb,pivetf,pivetb,delaynum);
    check_box(xf,yf,delaynum,box,innerwalls,numwalls,count);
    nibhit:=check_self(xf,yf,xb,yb,pivetf,pivetb);
    temp:=check_walls(xf,yf,innerwalls,numwalls);
    if (temp) and not(nibhit) then
     begin
      if (keypressed) then
       begin
       lastkey:=key;
       key:=readkey;
        case ord(key) of
          72:begin     (*up*)
             if (ord(lastkey) <> 80) then
              begin
               s:=0;
               t:=-1;
               enq(pivetf,pivetb,xf,yf,s,t);
              end;
            end;
          80:begin       (*down*)
             if (ord(lastkey) <> 72) then
              begin
               s:=0;
               t:=1;
               enq(pivetf,pivetb,xf,yf,s,t);
              end;
            end;
          75:begin      (*left*)
             if (ord(lastkey) <> 77) then
              begin
               s:=-1;
               t:=0;
               enq(pivetf,pivetb,xf,yf,s,t);
              end;
            end;
          77:begin    (*right*)
             if (ord(lastkey) <> 75) then
              begin
               s:=1;
               t:=0;
               enq(pivetf,pivetb,xf,yf,s,t);
              end;
            end;
          end;  (*of case*)
        end;  (*of if then*)
      end;
     if (count > 10) and (delaynum = 0) then
      begin
       clearviewport;
       pivetf:=nil;
       pivetb:=nil;
       key:=' ';
       WAIT:=WAIT+10;
       DELTIME:=DELTIME-1;
       delaynum:=0;
       count:=1;
       place_walls(level,innerwalls,numwalls);
       place_numbers(box,innerwalls,numwalls,delaynum,count);
       if (level-1 = 2) or (level-1 = 3) then
        begin
         s:=1;  t:=0;
         sb:=1;  tb:=0;
         xb:=100; xf:=200;
         yb:=50; yf:=50;
        end
       else if (level-1 = 4) then
        begin
         s:=0;  t:=1;
         sb:=0;  tb:=1;
         xb:=350; xf:=350;
         yb:=105; yf:=205;
         level:=1;
        end;
       readln;
      end;
    delay(DELTIME);
  until (key = 'q') or not(temp) or (nibhit);
  clearviewport;
  outtextxy(200,200,'Its over');
end;

procedure mainDirections;
begin
  (* back ground *)
  setfillstyle(9,2);
  floodfill(0,0,2);
 (* nibbles back ground *)
  setcolor(15);
  rectangle(50,10,600,170);
  setfillstyle(1,15);
  floodfill(51,51,15);
  setcolor(red);
  settextstyle(4,0,12);
  outtextxy(130,0,'Nibbles');
  settextstyle(1,0,3);
  setcolor(yellow);
  outtextxy(150,200,'Use the arrow keys to move!');
  setcolor(red);
  outtextxy(175,225,'Press enter to START');
 (* credit *)
  setcolor(10);
  rectangle(10,450,getmaxx-10,getmaxy-10);
  setfillstyle(1,10);
  floodfill(11,451,10);
  setcolor(red);
  settextstyle(0,0,0);
  outtextxy(15,452,'This version of Nibbles ');
  outtextxy(15,461,'was designed by:');
  setcolor(white);
  settextstyle(3,0,3);
  outtextxy(225,442,'...');
  setcolor(black);
  settextstyle(2,0,4);
  outtextxy(400,448,'...');
  outtextxy(400,458,'http://...');
  (* end credit *)
  setcolor(white);
  settextstyle(1,0,3);
  outtextxy(25,300,'Enter the delay time: ');
  DELTIME:=readInt(300,300);
  settextstyle(0,0,0);
  cleardevice;
end;

begin
  setup(false);
  mainDirections;
  mainGame;
  readln;
  closegraph;
end.