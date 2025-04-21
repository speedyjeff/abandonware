{ 

                         *****   KILLER FISH   *****
}

program Killer_fish;

uses
  JeffLib,graphics,mouevent,graph,crt,dos,buttonlib;

const
  MAX=5;

type
  fishtype=(n,s,e,w,nw,ne,se,sw);
  string15=string[15];
  rectype = Record
    xp,yp,col:integer;
  end;
  pointer=^bloodrec;
  bloodrec = record
    bx:integer;
    by:integer;
    rad:integer;
    next:pointer;
  end;
  arraytype = array[1..MAX] of rectype;
  arrayI = array[1..MAX] of integer;
  arrayS = array[1..MAX] of string;

var
  GORE:string[3];
  DELTIME:integer;
  FILLIN:string[3];
  DRIPS:string[3];

procedure drawFish(x,y:integer;fish:fishtype;col:integer; fill:onoff);
var
  eye:integer;
begin
  if (col = 0) then
    eye:=0
  else eye:=4;
  circle(x,y,15);
  if (fill <> on) then
    if (FILLIN = 'on') then
     fill:=on
    else
     fill:=off;
  case fish of
   w:begin
      line(x+11,y-11,x+25,y+15);
      line(x+11,y+11,x+25,y-15);
      line(x+25,y-15,x+25,y+15);
    if (fill = on) then
     begin
      setfillstyle(1,col);
      floodfill(x,y,col);
      setfillstyle(1,col);
      floodfill(x+20,y,col);
     end;
      setcolor(eye);
      circle(x-5,y-5,3);
      setfillstyle(1,eye);
      floodfill(x-5,y-5,eye);
     end;
   e:begin
      line(x-11,y-11,x-25,y+15);
      line(x-11,y+11,x-25,y-15);
      line(x-25,y-15,x-25,y+15);

    if (fill = on) then
     begin
      setfillstyle(1,col);
      floodfill(x,y,col);
      setfillstyle(1,col);
      floodfill(x-20,y,col);
     end;
      setcolor(eye);
      circle(x+5,y-5,3);
      setfillstyle(1,eye);
      floodfill(x+5,y-5,eye);
     end;
   n:begin
      line(x-11,y+11,x+15,y+25);
      line(x+11,y+11,x-15,y+25);
      line(x+15,y+25,x-15,y+25);

   if (fill = on) then
   begin
     setfillstyle(1,col);
      floodfill(x,y+20,col);
      setfillstyle(1,col);
      floodfill(x,y,col);
    end;
      setcolor(eye);
      circle(x-5,y-10,3);
      circle(x+5,y-10,3);
      setfillstyle(1,eye);
      floodfill(x-5,y-10,eye);
      setfillstyle(1,eye);
      floodfill(x+5,y-10,eye);
     end;
   s:begin
      line(x-11,y-11,x+15,y-25);
      line(x+11,y-11,x-15,y-25);
      line(x+15,y-25,x-15,y-25);
    if (fill = on) then
     begin
      setfillstyle(1,col);
      floodfill(x,y,col);
      setfillstyle(1,col);
      floodfill(x,y-20,col);
     end;
      setcolor(eye);
      circle(x-5,y+10,3);
      circle(x+5,y+10,3);
      setfillstyle(1,eye);
      floodfill(x-5,y+10,eye);
      setfillstyle(1,eye);
      floodfill(x+5,y+10,eye);
     end;
   nw:begin
      line(x+15,y-5,x+15,y+30);
      line(x  ,y+15,x+30,y+15);
      line(x+30,y+15,x+15,y+30);
    if (fill = on) then
     begin
      setfillstyle(1,col);
      floodfill(x,y,col);

      setfillstyle(1,col);
      floodfill(x+20,y+20,col);

      setfillstyle(1,col);
      floodfill(x+14,y+14,col);
     end;
      setcolor(eye);
      circle(x-5,y-7,3);
      setfillstyle(1,eye);
      floodfill(x-5,y-7,eye);
     end;
   se:begin
      line(x ,y-15,x-30,y-15);
      line(x-15,y-5,x-15,y-30);
      line(x-30,y-15,x-15,y-30);
    if (fill = on) then
     begin
      setfillstyle(1,col);
      floodfill(x,y,col);

      setfillstyle(1,col);
      floodfill(x-20,y-20,col);

      setfillstyle(1,col);
      floodfill(x-14,y-14,col)
     end;
      setcolor(eye);
      circle(x+7,y+3,3);
      setfillstyle(1,eye);
      floodfill(x+7,y+3,eye);
     end;
   sw:begin
      line(x ,y-15,x+30,y-15);
      line(x+15,y+5,x+15,y-30);
      line(x+30,y-15,x+15,y-30);
    if (fill = on) then
     begin
      setfillstyle(1,col);
      floodfill(x,y,col);

      setfillstyle(1,col);
      floodfill(x+20,y-20,col);

      setfillstyle(1,col);
      floodfill(x+14,y-14,col);
     end;
      setcolor(eye);
      circle(x-7,y+3,3);
      setfillstyle(1,eye);
      floodfill(x-7,y+3,eye);
     end;
   ne:begin
      line(x ,y+15,x-30,y+15);
      line(x-15,y+5,x-15,y+30);
      line(x-30,y+15,x-15,y+30);
    if (fill = on) then
     begin
      setfillstyle(1,col);
      floodfill(x,y,col);

      setfillstyle(1,col);
      floodfill(x-20,y+20,col);

      setfillstyle(1,col);
      floodfill(x-14,y+14,col);
     end;
      setcolor(eye);
      circle(x+5,y-7,3);
      setfillstyle(1,eye);
      floodfill(x+5,y-7,eye);
     end;
  end;  (*of case *)
end;

procedure board;
begin
  setcolor(5);
  rectangle(0,70,635,464);
  rectangle(10,80,625,454);
  setfillstyle(7,14); (*2 7 9*)
  floodfill(15,75,5);
end;

function checkBoard(x,y:integer) : boolean;
begin
  if (x < 30) or (x > 610) or (y < 100) or (y > 430) then
    checkBoard:=true
  else checkBoard:=false;
end;

procedure makePerson(var person:rectype);
var
  rx,ry,rc:integer;
begin
  repeat
    rx:=random(625)+1;
  until (rx > 20) and (rx < 615);
  repeat
    ry:=random(425)+1;
  until (ry > 95) and (ry < 425);
  rc:=random(MAX)+1;
  with person do
   begin
    xp:=rx;
    yp:=ry;
    col:=rc;
   end;
end;

procedure initPeople(var people:arraytype);
var
  j:integer;
  person:rectype;
begin
  for j:=1 to MAX do
   begin
    makePerson(person);
    people[j]:=person;
   end;
end;

function checkPeople(people:arraytype; x,y:integer):integer;
var
  j:integer;
  eatten:integer;
begin
  eatten:=-1;
  for j:= 1 to MAX do
   with people[j] do
    begin
     if (x > xp-30) and (x < xp+30) and (y  > yp-30) and (y < yp+30) then
       eatten:=j;
    end;
  checkPeople:=eatten;
end;

procedure drawPerson(person:rectype);
begin
  (*head*)
  circle(person.xp,person.yp-15,5);
  (*body shaft*)
  line(person.xp,person.yp-10,person.xp,person.yp+5);
  (*left leg*)
  line(person.xp,person.yp+5,person.xp-10,person.yp+20);
  (*right leg*)
  line(person.xp,person.yp+5,person.xp+10,person.yp+20);
  (*left and right arms*)
  line(person.xp-15,person.yp-2,person.xp+15,person.yp-2);
end;

procedure drawpeople(people:arraytype);
var
  j:integer;
begin
  for j:=1 to MAX do
   begin
    setcolor(people[j].col);
    drawPerson(people[j]);
   end;
end;

procedure init(var scM:arrayI);
var
  j:integer;
begin
  for j:=1 to MAX do
    scM[j]:=0;
end;

procedure deletPerson(var people:arraytype; numP:integer);
var
  person:rectype;
begin
  setcolor(black);
  drawperson(people[numP]);
  makePerson(person);
  people[nump]:=person;
end;

procedure munipScore(people:arrayType; numP:integer; var score:integer);
begin
  case (people[numP].col) of
    1:score:=score+5; {blue}
    2:score:=score+3; {green} 
    3:score:=score+1; {cyan}
    4:score:=score-3; {red}
    5:score:=score-5; {purple}
  end;
end;

procedure checkMutiPerson(people:arraytype; var scM:arrayI;var multiPe:integer;var score:integer);
var
  j,c:integer;
  count:integer;
  tempscore:integer;
  percentage:real;
begin
  count:=1;
  c:=people[1].col;
  for j:=2 to MAX do
   if (c = people[j].col) then
    count:=count+1;
  if (count=MAX) then
   begin
    scM[c]:=scM[c]+1;
    multiPe:=c;
    tempscore:=score;
    if (tempscore<0) then
      tempscore:=tempscore*-1;
    case (c) of
      1:percentage:=0.05;
      2:percentage:=0.1;
      3:percentage:=0.25;
      4:percentage:=0.5;
      5:percentage:=1;
    end;
    score:=score + trunc(tempscore * percentage);
   end
  else multiPe:=-1;
end;

procedure clock(var sec,minute,counter:word; takeTime:boolean);
var
  h,m,s,i:word;
begin
  if (takeTime) then
   begin
   end;
  outtextxy(50,30,inttostr(inttostr('',minute,':'),counter,''));
end;

procedure scoreBoard(score:integer;scM:arrayI;colON:boolean);
begin
  if (score >= 0) then
    outtextxy(10,5,inttostr('Number of Points:  ',score,''))
   else
    outtextxy(10,5,inttostr('Number of Points: -',score,''));
  outtextxy(250,5,'Combinations of:');
  if (colON) then
   setcolor(blue);
  outtextxy(276,15,inttostr('BLUE:   ',scM[1],''));
  if (colON) then
   setcolor(green);
  outtextxy(276,25,inttostr('GREEN:  ',scM[2],''));
  if (colON) then
   setcolor(cyan);
  outtextxy(276,35,inttostr('CYAN:   ',scM[3],''));
  if (colON) then
   setcolor(red);
  outtextxy(276,45,inttostr('RED:    ',scM[4],''));
  if (colON) then
   setcolor(magenta);
  outtextxy(276,55,inttostr('PURPLE: ',scM[5],''));
end;

procedure makeTreat(multiPe:integer; color:boolean);
begin
  if (color) then
   setcolor(8)
  else setcolor(black);
  rectangle(395,25,565,60);
  if (color) then
   begin
    setfillstyle(1,8);
    floodfill(400,30,8);
   end
  else
   begin
    setfillstyle(1,0);
    floodfill(400,30,0);
  end;
  if (color) then
    setcolor(yellow);
  outtextxy(400,30,'You have 20 secs');
  outtextxy(400,40,'to totaly get rid of ');
  outtextxy(400,50,'all the');
  if (color) then
    setcolor(multiPe);
  case (multiPe) of
   1:outtextxy(460,50,'Blue people');
   2:outtextxy(460,50,'Green people');
   3:outtextxy(460,50,'Cyan people');
   4:outtextxy(460,50,'Red people');
   5:outtextxy(460,50,'Purple people');
  end;
end;

procedure changeTimer(timer:integer);
begin
  setcolor(8);
  outtextxy(400,30,inttostr('You have ',(timer+1),' secs'));
  setcolor(red);
  outtextxy(400,30,inttostr('You have ',timer,' secs'));
end;

function checkColorPeople(people:arraytype;multiPe:integer):boolean;
var
  count,c,j:integer;
begin
  count:=0;
  c:=multiPe;
  for j:=1 to MAX do
   if (c = people[j].col) then
    count:=count+1;

  if (count > 0) then
   begin
    checkColorPeople:=false;
   end
  else checkColorPeople:=true;

end;

procedure pop(var pivet:pointer;var x,y,r:integer);
var
  p:pointer;       (*temperary pointer*)
begin
  p:=pivet;
  if (p <> nil) then
   begin
    x:=p^.bx;
    y:=p^.by;
    r:=p^.rad;
    pivet:=pivet^.next;
    dispose(p);
   end;   (* of else*)
end;      (* of pop*)

procedure deq(var pivetf,pivetb:pointer;var x,y,r:integer);
begin
  pop(pivetf,x,y,r);
  if (pivetf = NIl) then
    pivetb:=nil;
end;

procedure enq(var pivetf,pivetb:pointer; x,y,r:integer);
var
  p:pointer;
begin
  new(p);
  p^.bx:=x;
  p^.by:=y;
  p^.rad:=r;
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


procedure bloodRings(numP:integer;people:arraytype;var bloodf,bloodb:pointer);
begin
  enq(bloodf,bloodb,people[numP].xp,people[numP].yp,5);
end;

procedure drawRings(bloodf,bloodb:pointer);
var
  p:pointer;
  x,y,r:integer;
begin
  p:=bloodf;
  while (p <> nil) do
   begin
    setcolor(black);
    circle(p^.bx,p^.by,p^.rad);
    if (p^.rad > 100) then
     begin
      deq(bloodf,bloodb,x,y,r);
      p:=bloodf;
     end
    else
     begin
      p^.rad:=p^.rad+5;
      setcolor(red);
      circle(p^.bx,p^.by,p^.rad);
      p:=p^.next;
     end;
   end;
end;

function TheGame : integer;
var
  x,y:integer;
  sx,ty:integer;
  fish:fishtype;
  key:char;
  show:onoff;
  exit:boolean;
  people:arraytype;
  scM:arrayI;
  numP:integer;
  score:integer;
  sec:word;
  hr,mn,sc,mi:word;
  counter,minute:word;
  multiPe:integer;
  timer:integer;
  bloodf,bloodb:pointer;
begin
  bloodf:=nil;
  bloodb:=nil;
  counter:=0;   minute:=0;
  timer:=-2;   multiPe:=-1;
  randomize;
  init(scM);
  initPeople(people);
  show:=on;    exit:=false;
  score:=0;
  x:=100;  y:=150;
  sx:=1;    ty:=0;
  fish:=e;
  board;
  setcolor(white);
  scoreBoard(score,scM,true);
  drawPeople(people);
  if (show = on) then begin
  setcolor(green);
  drawfish(x,y,fish,2,off);
  readln;
  repeat
    numP:=checkPeople(people,x,y);
    if (numP <> -1) then
     begin
       if (GORE = 'on') then
         bloodRings(numP,people,bloodf,bloodb);
       setcolor(black);
       scoreBoard(score,scM,false);
       munipScore(people,numP,score);
       deletPerson(people,numP);
       if (timer = -2) then
        begin
         checkMutiPerson(people,scM,multiPe,score);
         if (multiPe <> -1) then
          begin
           makeTreat(multiPe,true);
           timer:=20;
          end;
        end;
       setcolor(white);
       scoreBoard(score,scM,true);
       drawpeople(people);
     end;
    if (keypressed) then
       begin
       key:=readkey;
        case ord(key) of
          72:begin  (*up*)
              fish:=n;
              sx:=0;
              ty:=-1;
             end;
          80:begin  (*down*)
              fish:=s;
              sx:=0;
              ty:=1;
             end;
          75:begin  (*left*)
              fish:=w;
              sx:=-1;
              ty:=0;
             end;
          77:begin  (*right*)
              fish:=e;
              sx:=1;
              ty:=0;
             end;
        end;
        case (key) of
          'k':begin;  (*S ¯ H*)
            fish:=s;
            sx:=0;
            ty:=1;
           end;
         'i':begin;  (*N ¯ P*)
             fish:=n;
             sx:=0;
             ty:=-1;
           end;
         'j':begin;  (*W ¯ K*)
            fish:=w;
            sx:=-1;
            ty:=0;
           end;
         'l':begin;  (*E ¯ M*)
            fish:=e;
            sx:=1;
            ty:=0;
           end;
         'u':begin;  (*NW*)
            fish:=nw;
            sx:=-1;
            ty:=-1;
           end;
         'o':begin;  (*NE*)
            fish:=ne;
            sx:=1;
            ty:=-1;
           end;
         'n':begin;  (*SW*)
            fish:=sw;
            sx:=-1;
            ty:=1;
           end;
         '.':begin;  (*SE*)
            fish:=se;
            sx:=1;
            ty:=1;
           end;
        end;  (*of case*)
       end;  (*of keypressed*)
    (*GORE*)
    if (GORE = 'on') and (bloodf <> nil) then
     drawRings(bloodf,bloodb);
    (*END OF GORE*)
    setcolor(green);
    drawfish(x,y,fish,2,off);
    setcolor(black);
    drawfish(x,y,fish,0,off);
    gettime(hr,mn,sc,mi);
    if (sc <> sec) then
     begin
      setcolor(black);
      clock(sec,minute,counter,false);
      sec:=sc;
      counter:=counter+1;
      if (counter >= 60) then
       begin
        counter:=0;
        minute:=minute+1;
       end;
       if (timer <> -2) then
        begin

         if (checkColorPeople(people,multiPe)) then
          begin
           timer:=-2;
           makeTreat(multiPe,false);
          end
         else
          begin
           changeTimer(timer);
           timer:=timer-1;
          end;

         if (timer = -1) then
          begin
           setcolor(white);
           outtextxy(100,100,'You ran out of TIME');
           exit:=true;
          end;
        end;
       setcolor(green);
       clock(sec,minute,counter,true);
     end;
    if (checkBoard(x,y)) then
     begin
      setcolor(white);
      outtextxy(100,100,'You are out of bounds');
      exit:=true;
     end;
    delay(DELTIME);
    x:=x+sx;
    y:=y+ty;
  until (ord(key) = 13) or (exit);  end;
  TheGame:=score;
end;

(*====================END MAIN PROGRAM===================================*)
procedure title;
begin
  setcolor(white);
  rectangle(0,0,490,150);
  setfillstyle(1,white);
  floodfill(1,1,white);
  setcolor(red);
  (************* K I L L E R **************)
  (*K*)
  line(10,10,10,140);line(20,10,20,140);line(10,10,20,10);line(10,140,20,140);
  setfillstyle(1,red);
  floodfill(11,11,red);
  line(20,65,50,10);line(20,75,50,140);line(30,70,60,140);line(30,70,60,10);line(50,10,60,10);line(50,140,60,140);
  setfillstyle(1,red);
  floodfill(21,66,red);
  (*I*)
  line(70,10,70,100);line(80,10,80,100);line(70,10,80,10);line(70,100,80,100);
  setfillstyle(1,red);
  floodfill(71,11,red);
  (*L1*)
  line(90,10,90,100);line(100,10,100,100);line(90,10,100,10);line(90,100,105,120);line(100,100,105,120);
  setfillstyle(1,red);
  floodfill(91,11,red);
  (*L2*)
  line(110,10,110,100);line(120,10,120,100);line(110,10,120,10);line(110,100,125,120);line(120,100,125,120);
  setfillstyle(1,red);
  floodfill(111,11,red);
  (*E*)
  line(130,10,130,100);line(130,10,170,10);line(130,100,170,100);line(145,30,170,30);line(145,80,170,80);
  line(145,45,160,45);line(145,65,160,65);
  line(170,100,170,80);line(170,10,170,30);line(145,30,145,45);line(145,80,145,65);line(160,45,160,65);
  setfillstyle(1,red);
  floodfill(131,11,red);
  (*R*)
  line(180,10,180,100);line(180,10,210,10);arc(210,30,260,90,20);line(210,50,230,100);
  line(230,100,210,100);line(195,60,210,100);line(195,60,195,100);
  line(195,100,180,100);circle(205,30,10);line(200,20,200,40);
  setfillstyle(1,red);
  floodfill(199,30,red);
  setfillstyle(1,red);
  floodfill(191,11,red);
  (***********F I S H****************)
  (*F*)
  setcolor(1);
  line(260,10,260,140);line(260,10,320,10);line(280,40,320,40);line(320,10,320,40);
  line(280,70,300,70);line(280,90,300,90);line(280,90,280,140);line(260,140,280,140);
  line(300,70,300,90);line(280,40,280,70);
  setfillstyle(1,1);
  floodfill(261,11,1);
  (*I*)
  line(330,10,330,100);line(340,10,340,100);line(330,10,340,10);line(330,100,340,100);
  setfillstyle(1,1);
  floodfill(331,11,1);
  (*S*)
  line(350,10,400,10);line(350,10,350,50);line(350,50,380,50);line(380,50,380,80);
  line(380,80,350,80);line(350,80,350,100);line(350,100,400,100);line(400,100,400,40);
  line(400,40,370,40);line(370,40,370,20);line(370,20,400,20);line(400,20,400,10);
  setfillstyle(1,1);
  floodfill(351,11,1);
  (*H*)
  line(410,10,410,100);line(430,10,430,40);line(430,60,430,100);line(460,10,460,40);
  line(460,60,460,100);line(480,10,480,100);line(410,10,430,10);line(410,100,430,100);
  line(430,40,460,40);line(430,60,460,60);line(460,10,480,10);line(460,100,480,100);
  setfillstyle(1,1);
  floodfill(411,11,1);
end;

procedure bloodDrips(var d1,d2:integer);
begin
  setcolor(white);
  case (d1) of
   1:begin
      circle(105,128,5);
      line(100,128,105,120);
      line(110,128,105,120);
      setfillstyle(1,white);
      floodfill(105,122,white);
      setfillstyle(1,white);
      floodfill(105,128,white);
     end;
   2:begin
      circle(105,133,5);
      setfillstyle(1,white);
      floodfill(105,133,white);
     end;
  3:begin
      circle(105,144,5);
      setfillstyle(1,white);
      floodfill(105,144,white);
     end;
  4:;
  end;
  case (d2) of
   1:begin
      circle(125,128,5);
      line(120,128,125,120);
      line(130,128,125,120);
      setfillstyle(1,white);
      floodfill(125,122,white);
      setfillstyle(1,white);
      floodfill(125,128,white);
     end;
   2:begin
      circle(125,133,5);
      setfillstyle(1,white);
      floodfill(125,133,white);
     end;
  3:begin
      circle(125,144,5);
      setfillstyle(1,white);
      floodfill(125,144,white);
     end;
  4:;
  end;

  if (d1 = 4) then
   d1:=1
  else d1:=d1+1;
  if (d2 = 4) then
   d2:=1
  else d2:=d2+1;
  setcolor(12);
  case (d1) of
   1:begin
      circle(105,128,5);
      line(100,128,105,120);
      line(110,128,105,120);
      setfillstyle(1,12);
      floodfill(105,122,12);
      setfillstyle(1,12);
      floodfill(105,128,12);
     end;
   2:begin
      circle(105,133,5);
      setfillstyle(1,12);
      floodfill(105,133,12);
     end;
   3:begin
      circle(105,144,5);
      setfillstyle(1,12);
      floodfill(105,144,12);
     end;
   4:;
  end;
  case (d2) of
   1:begin
      circle(125,128,5);
      line(120,128,125,120);
      line(130,128,125,120);
      setfillstyle(1,12);
      floodfill(125,122,12);
      setfillstyle(1,12);
      floodfill(125,128,12);
     end;
   2:begin
      circle(125,133,5);
      setfillstyle(1,12);
      floodfill(125,133,12);
     end;
   3:begin
      circle(125,144,5);
      setfillstyle(1,12);
      floodfill(125,144,12);
     end;
   4:;
  end;
end;

procedure fishDir;
begin
  (*BACK DROP*)
  setcolor(7);
  rectangle(0,160,200,450);
  setfillstyle(1,7);
  (*THE FISH*)
  floodfill(1,161,7);
  setcolor(green);
  drawfish(100,180,n,2,on);
  setcolor(green);  
  drawfish(100,400,s,2,on);
  setcolor(green);
  drawfish(20,290,w,2,on);
  setcolor(green);
  drawfish(180,290,e,2,on);
  setcolor(green);
  drawfish(40,200,nw,2,on);
  setcolor(green);
  drawfish(40,370,sw,2,on);
  setcolor(green);
  drawfish(160,200,ne,2,on);
  setcolor(green);
  drawfish(160,370,se,2,on);
  (*THE LETTERS*)
  settextstyle(1,0,4);
  setcolor(yellow);
  outtextxy(84,172,'*i*');
  outtextxy(80,370,'*k*');
  outtextxy(14,263,'*j*');
  outtextxy(155,263,'*l*');
  outtextxy(21,193,'*u*');
  outtextxy(130,193,'*o*');
  outtextxy(22,335,'*n*');
  outtextxy(135,335,'*.*');
(* the division lines *)
  line(68,227,135,340);
  line(135,227,68,340);
  line(101,210,101,370);
  line(50,284,150,284);
(* directions *)
  settextstyle(0,0,1);
  setcolor(red);
  outtextxy(0,420,' * To move the fish just');
  outtextxy(0,430,' push the key in the ');
  outtextxy(10,440,' [*]asteriks[*]');
end;

procedure peoplePts;
var
  person:rectype;
  j:integer;
begin
  setcolor(15);
  rectangle(390,160,490,450);
  setfillstyle(1,15);
  floodfill(391,161,15);
  setcolor(6);
  outtextxy(392,165,'Point values ');
  outtextxy(392,175,'for the ');
  outtextxy(392,185,'people: ');
  setlinestyle(0,0,3);
  person.xp:=410;
  person.yp:=230;
  for j:=1 to 5 do
   begin
    setcolor(j);
    drawperson(person);
    settextstyle(0,0,3);
    outtextxy(410,person.yp-10,' = ');
    person.yp:=person.yp+45;
  end;
  setcolor(8);
  settextstyle(0,0,2);
  outtextxy(450,225,' 5 ');
  outtextxy(450,270,' 3 ');
  outtextxy(450,310,' 1 ');
  outtextxy(454,358,'-3');
  outtextxy(454,404,'-5');
end;

procedure multiPePts;
var
  j:integer;
  person:rectype;
begin
 setcolor(9);
  setlinestyle(0,0,0);
  rectangle(500,160,635,450);
  setfillstyle(1,9);
  floodfill(501,161,9);
  settextstyle(0,0,1);
  setcolor(yellow);
  outtextxy(503,165,'The percentage ');
  outtextxy(503,175,'increase for ');
  outtextxy(503,185,'collecting');
  outtextxy(503,195,'Multiple people: ');
  setlinestyle(0,0,3);
  person.xp:=518;
  person.yp:=230;
  for j:=1 to 5 do
   begin
    setcolor(j);
    drawperson(person);
    settextstyle(0,0,3);
    outtextxy(525,person.yp-10,' = ');
    person.yp:=person.yp+45;
  end;
  setcolor(yellow);
  settextstyle(0,0,2);
  outtextxy(560,225,' 5% ');
  outtextxy(560,270,' 10% ');
  outtextxy(560,310,' 25% ');
  outtextxy(560,358,' 50%');
  outtextxy(558,404,' 100%');
  settextstyle(0,0,0);
  outtextxy(533,225,'x5');
  outtextxy(533,270,'x5');
  outtextxy(533,314,'x5');
  outtextxy(533,358,'x5');
  outtextxy(533,404,'x5');
end;

(************************************************************************
  eat person:
      blue = 5;
      green  = 3;
      light blue = 1;
      red = -3;
      purple = -5;

  make all people the same color:
      blue = 100%;
      green  = 50%;
      light blue = 25%;
      red = 10%;
      purple = 5%;

  [u]  [i]  [o]
  [j]       [l]
  [n]  [k]  [.]
************************************************************************)

procedure showHighScore;
var
  name:string;
  score:integer;
  FILETEXT:text;
  y:integer;
  col:integer;
begin
  y:=110;  col:=1;
  settextstyle(0,0,2);
  setcolor(red);
  outtextxy(50,40,'Killer Fish:  HIGH SCORES');
  setcolor(white);
  outtextxy(105,80,'NAME');
  outtextxy(350,80,'SCORE');
  assign(FILETEXT,'fishscor.txt');
  reset(FILETEXT);
  while not(EOF(FILETEXT)) do
   begin
    readln(FILETEXT,name);
    readln(FILETEXT,score);
    setcolor(col);
    outtextxy(70,y,inttostr('',col,'.'));
    outtextxy(100,y,name);
    outtextxy(350,y,inttostr('',score,''));
    y:=y+50;
    col:=col+1;
   end;
  close(FILETEXT);
  settextstyle(1,5,4);
  setcolor(white);
  outtextxy(10,100,'Press Enter to Return');
  col:=1;
  settextstyle(0,0,2);
  repeat
    setcolor(col);
    outtextxy(50,40,'Killer Fish:  HIGH SCORES');
    col:=col+1;
    delay(100);
  until (keypressed);
  readln;
end;

procedure intro(var length,drip1,drip2:integer;var buttons:arraybut);
begin
  length:=9;
  title;
  fishdir;
  peoplePts;
  multiPePts;
  drip1:=1; drip2:=3;
  setlinestyle(0,0,0);
  initbutton(buttons,'fishbuts.txt',length);
  makebuttons(buttons,length);
  settextstyle(0,0,2);
  setcolor(red);
  outtextxy(300,225,GORE);
  setcolor(cyan);
  outtextxy(335,300,FILLIN);
  setcolor(yellow);
  outtextxy(335,190,DRIPS);
  settextstyle(0,0,1);
  setcolor(white);
  outtextxy(220,260,'Delay Time');
  outtextxy(255,280,inttostr('',DELTIME,''));
  (*DESIGN BY ...*)
  setcolor(11);
  rectangle(210,420,370,450);
  setfillstyle(1,11);
  floodfill(211,421,11);
  setcolor(red);
  outtextxy(220,423,'Designed By:');
  outtextxy(230,433,'...');
  setcolor(magenta);
  settextstyle(2,0,0);
  outtextxy(220,438,'...');
  (*REPAINT BUTTON*)
  setcolor(white);
  outtextxy(510,30,'If this screen');
  outtextxy(510,40,'Becomes Messed');
  outtextxy(510,50,'Up Just click');
  outtextxy(510,60,'this button and');
  outtextxy(510,70,'It will be ');
  outtextxy(510,80,'Repainted');
end;  

function directions:boolean;
var
  drip1,drip2:integer;
  length:integer;
  buttons:arraybut;
  which:integer;
  stop,play:boolean;
begin
  setmouse(235,170);
  stop:=false;
  play:=false;
  intro(length,drip1,drip2,buttons);
  repeat
   if (button = 1) then
    begin
     which:=checkbuttons(getmousex,getmousey,buttons,length);
     if (which <> -1) then
      begin
      setcolor(yellow);
       case which of
        1:begin
           settextstyle(0,0,2);
           setcolor(black);
           outtextxy(300,225,GORE);
           if (GORE='on') then
             GORE:='off'
            else
             GORE:='on';
           setcolor(red);
           outtextxy(300,225,GORE);
         end;
        2:begin
           if (DELTIME > 0) then
            begin
             setcolor(black);
             outtextxy(255,280,inttostr('',DELTIME,''));
             DELTIME:=DELTIME-1;
             setcolor(white);
             outtextxy(255,280,inttostr('',DELTIME,''));
           end;
         end;
        3:begin
           setcolor(black);
           outtextxy(255,280,inttostr('',DELTIME,''));
           DELTIME:=DELTIME+1;
           setcolor(white);
           outtextxy(255,280,inttostr('',DELTIME,''));
         end;
        4:begin
           clearviewport;
           showHighScore;
           clearviewport;
           setmouse(210,210);
           intro(length,drip1,drip2,buttons);
         end;
        5:begin
           play:=true;
           stop:=true;
          end;
        6:begin
           play:=false;
           stop:=true;
          end;
        7:begin
           clearviewport;
           setmouse(250,200);
           intro(length,drip1,drip2,buttons);
           outtextxy(510,30,'If this screen');
           outtextxy(510,40,'Becomes Messed');
           outtextxy(510,50,'Up Just click');
           outtextxy(510,60,'this button and');
           outtextxy(510,70,'It will be ');
           outtextxy(510,80,'Repainted');
         end;
        8:begin
           settextstyle(0,0,2);
           setcolor(black);
           outtextxy(335,300,FILLIN);
           if (FILLIN='on') then
             FILLIN:='off'
            else
             FILLIN:='on';
           setcolor(cyan);
           outtextxy(335,300,FILLIN);
         end;
        9:begin
           settextstyle(0,0,2);
           setcolor(black);
           outtextxy(335,190,DRIPS);
           if (DRIPS='on') then
             DRIPS:='off'
            else
             DRIPS:='on';
           setcolor(yellow);
           outtextxy(335,190,DRIPS);
         end;
       end;
       which:=-1;
      end;
     end  (*of button eq 1*)
    else
     begin
      setlinestyle(0,0,0);
      settextstyle(0,0,0);
      setcolor(black);
      if (DRIPS='on') then
       bloodDrips(drip1,drip2);
      delay(200);
     end;
  until (stop);
  directions:=play;
end;

(*====================END DIRECTIONS ===================================*)

function newName : string15;
var
  key:char;
  name:string[15];
  count:integer;
  j:integer;
  buttons:arraybut;
  lengths,numb:integer;
  again:boolean;
begin
  lengths:=2;
  initbutton(buttons,'nambuts.txt',lengths);
  repeat
  setup(false);
  clearviewport;
  name:='';
  count:=0;
  key:='a';
  settextstyle(3,0,3);
  outtextxy(10,10,'You are on the High Score List [up to 15 characters]');
  outtextxy(10,50,'Enter your name:');
  outtextxy(11,100,'_______________');
  repeat
    if (keypressed) then
     begin
      key:=readkey;
       case ord(key) of
        13:;
        8:begin
           write(chr(7))
          end;
      else
       begin
         if (count >= 15) then
           write(chr(7))
         else
          begin
           name:=name+key;
           count:=count+1;
          end;
         end;
      end;
      setcolor(red);
      outtextxy(10,100,name);
     end; (*of case*)
  until ord(key) = 13;
  closegraph;
  setup(true);
  setmouse(10,10);
  setfillstyle(1,yellow);
  floodfill(1,1,yellow);
  settextstyle(0,0,3);
  setcolor(2);
  outtextxy(100,150,'Is this right?');
  outtextxy(100,200,'_______________');
  setcolor(red);
  outtextxy(100,200,name);
  settextstyle(0,0,1);
  setcolor(blue);
  outtextxy(200,400,'[Use the mouse]');
  makebuttons(buttons,lengths);
  numb:=-1;
  repeat
   if (button = 1) then
     numb:=checkbuttons(getmousex,getmousey,buttons,lengths);
  until(numb=1) or (numb=2);
  if numb=1 then
    again:=false
   else again:=true;
  closegraph;
  until not(again);
  newName:=name;
end;

procedure addName(highName:string15;score:integer;var scores:arrayI;var name:arrayS);
var
  j,num:integer;
  found:boolean;
  tempname:string;
  tempscor:integer;
begin
  num:=1;
  found:=false;
  while not(found) do
   if (score > scores[num]) then
    found:=true
   else num:=num+1;
  for j:= num to 5 do
   begin
     tempname:=name[j];
     tempscor:=scores[j];
     name[j]:=highName;
     scores[j]:=score;
     highName:=tempname;
     score:=tempscor;
   end;
end;

procedure HighScore(score:integer);
var
  FILETEXT:text;
  name:arrayS;
  scores:arrayI;
  j:integer;
  highName:string15;
begin
  clearviewport;
  assign(FILETEXT,'fishscor.txt');
  reset(FILETEXT);
  for j:=1 to MAX do
   begin
    readln(FILETEXT,name[j]);
    readln(FILETEXT,scores[j]);
   end;
  close(FILETEXT);
  if (score >= scores[5]) then
   begin
    closegraph;
    highName:=newName;
    addName(highName,score,scores,name);
    setup(false);
   end;
  assign(FILETEXT,'fishscor.txt');
  rewrite(FILETEXT);
  for j:=1 to MAX do
   begin
    writeln(FILETEXT,name[j]);
    writeln(FILETEXT,scores[j]);
   end;
  close(FILETEXT);
  showHighScore;
end;

function playAgain : boolean;
var
  str,str1,str2,str3:string;
  j:integer;
  sp:integer;
  lengths:integer;
  buttons:arraybut;
  numb:integer;
  delT,delD:integer;
begin
  str:= 'You have done a good job ';
  str1:='But the job is not done';
  str2:='The people still outnumber the FISH';
  str3:='Get back in there and KILL THEM ALL!!!';
  setcolor(red);
  setfillstyle(1,red);
  floodfill(1,1,red);
  setcolor(white);
  settextstyle(0,0,2);
  sp:=15;
  delT:=90; delD:=5;
  for j:=1 to length(str) do
   begin
     sound(500);
     delay(delD);
     nosound;
     if (keypressed) then
      begin
       delD:=0;
       delT:=0;
      end;
     for j:=1 to j do
       outtextxy(70+j*sp,10,str[j]);
     delay(delT);
   end;
  for j:=1 to length(str1) do
   begin
     sound(500);
     delay(delD);
     nosound;
     if (keypressed) then
      begin
       delD:=0;
       delT:=0;
      end;
     for j:=1 to j do
       outtextxy(75+j*sp,30,str1[j]);
     delay(delT);
   end;
  for j:=1 to length(str2) do
   begin
     sound(500);
     delay(delD);
     nosound;
     if (keypressed) then
      begin
       delD:=0;
       delT:=0;
      end;
     for j:=1 to j do
       outtextxy(20+j*sp,50,str2[j]);
    delay(delT);
   end;
  for j:=1 to length(str3) do
   begin
     sound(500);
     delay(delD);
     nosound;
     if (keypressed) then
      begin
       delD:=0;
       delT:=0;
      end;
     for j:=1 to j do
       outtextxy(8+j*sp,70,str3[j]);
    delay(delT);
   end;
  lengths:=2;
  setcolor(green);
  outtextxy(100,250,'Do you want to Continue?');
  initbutton(buttons,'scorbuts.txt',lengths);
  makebuttons(buttons,lengths);
  setcolor(blue);
  outtextxy(200,400,'[Use the mouse]');
  repeat
   if (button = 1) then
     numb:=checkbuttons(getmousex,getmousey,buttons,lengths);
  until(numb=1) or (numb=2);
  if numb=1 then
    playAgain:=false
   else playAgain:=true;
end;


procedure driver;
var
  exitGame:boolean;
begin
  clrscr;
  GORE:='off';
  DELTIME:=0;
  FILLIN:='off';
  DRIPS:='off';
  repeat
    exitGame:=false;
    setup(true);
    if (directions) then
     begin
      closegraph;
      setup(false);
      settextstyle(0,0,1);
      highScore(TheGame);
      closegraph;
      setup(true);
      exitGame:=playAgain;
     end
    else
      exitGame:=true;
    closegraph;
  until (exitGame);
end;


begin
  driver;
end.
