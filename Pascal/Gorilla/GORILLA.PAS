program Gorilla;
(* 8-19-97 *)

uses
  jefflib,graph,graphics,crt;

type
  peopleposition=record
    xint:integer;
    yint:integer;
  end;
  arraytype=array[1..2]of peopleposition;
  buildingrec=record
    xint1:integer;
    xint2:integer;
    y1:integer;
  end;
  arraytype2=array[1..20]of buildingrec;

procedure putOffScreenImage(I1:pointer;x,y:integer);
begin
  PutImage(x, y, I1^,NormalPut);
end;
procedure makeOffScreenImage(var I1:pointer;x,y,hei,wid:integer);
var
  Size:word;
begin
  Size:=ImageSize(x,y,x+hei,y+wid);
  GetMem(I1, Size); { Get memory from heap }
  GetImage(x,y,x+hei,y+wid,I1^);
end;


(***********************************************************)
function check_persons(person:arraytype; intx,inty:integer):integer;
(*---------------------------------------------------------*)
(*
(*---------------------------------------------------------*)
var
  P1x,P1y:integer;
  P2x,P2y:integer;
begin
  P1x:=person[1].xint;
  P1y:=person[1].yint;
  P2x:=person[2].xint;
  P2y:=person[2].yint;
(*  rectangle(P1x-15,P1y-20,P1x+15,P1y+20);
  rectangle(P2x-15,P2y-20,P2x+15,P2y+20);*)
  if (intx > P1x-15) and (intx < P1x+15) and (inty  > P1y-20) and (inty < P1y+20) then
   begin
    outtextxy(200,90,'person 1 was hit');
    check_persons:=1;
   end
  else
  if (intx > P2x-15) and (intx < P2x+15) and (inty  > P2y-20) and (inty < P2y+20) then
   begin
    outtextxy(200,90,'person 2 was hit');
    check_persons:=2;
   end
  else
    check_persons:=0;
end;

(***********************************************************)
function check_buildings(buildings:arraytype2;intx,inty:integer;
                         numbuild:integer):boolean;
(***********************************************************)
(*
(***********************************************************)
var
  j:integer;
  build:integer;
begin
  build:=0;
  for j:=1 to numbuild do
   begin
    if (buildings[j].xint1 < intx) and (buildings[j].xint2 > intx) and (buildings[j].y1 <= inty) then
      build:=j;
   end;
  if (build<>0) then
    check_buildings:=true
  else check_buildings:=false;
  setcolor(15);
end;

(***********************************************************)
procedure people(person:arraytype);
(*---------------------------------------------------------*)
(*
(*---------------------------------------------------------*)
var
  j:integer;
begin
  setcolor(15);
  for j:=1 to 2 do
   begin
    (*head*)
    circle(person[j].xint,person[j].yint-15,5);
    (*body shaft*)
    line(person[j].xint,person[j].yint-10,person[j].xint,person[j].yint+5);
    (*left leg*)
    line(person[j].xint,person[j].yint+5,person[j].xint-10,person[j].yint+20);
    (*right leg*)
    line(person[j].xint,person[j].yint+5,person[j].xint+10,person[j].yint+20);
    (*left and right arms*)
    line(person[j].xint-15,person[j].yint-2,person[j].xint+15,person[j].yint-2);
   end;
end;

procedure destroyPerson(hit:integer; person:arraytype);
var
  j:integer;
  x,y:integer;
begin
  x:=person[hit].xint;
  y:=person[hit].yint;
  setcolor(3);
  for j:=1 to 35 do
    circle(x,y,j);
end;

procedure placeBanna(ban1,ban2,ban3,ban4,banB:pointer;x,y:integer; time:real);
var
  ct:integer;
begin
  ct:=round((time*10));
  if (x > 205) and (y > 40) or (x < 450) and (y > 40) then
   begin
    if (ct mod 4 = 0) then
      putOffScreenImage(ban1,x,y)
    else if (ct mod 4 = 1) then
      putOffScreenImage(ban2,x,y)
    else if (ct mod 4 = 2) then
      putOffScreenImage(ban3,x,y)
    else if (ct mod 4 = 3) then
      putOffScreenImage(ban4,x,y);
    if (y > 0) then
      delay(100);
    putOffScreenImage(banB,x,y);
  end;
end;

(***********************************************************)
function bannana_position(person:arraytype; theta,velocity:integer;
                           num:integer;buildings:arraytype2;
                           numbuild:integer;ban1,ban2,ban3,ban4,banB:pointer):boolean;
(*---------------------------------------------------------*)
(*
(*---------------------------------------------------------*)
var
  y,x:real;
  intx,inty:integer;
  time:real;
  TempAngle:integer;
  WasHit:boolean;
  hit:integer;
  buildHit:boolean;
begin
  WasHit:=false;
  buildHit:=false;
  time:=0;
  hit:=0;
  if (num = 2) then
   begin
    TempAngle:=180-theta;
    theta:=180-theta;
   end;
  repeat
    time:=time + 0.1;
    x:=((cos(theta*(3.1415/180))*velocity)*time)+person[num].xint;
    y:=-(((sin(theta*(3.1415/180))*velocity)*time)-(4.5*time*time))+person[num].yint;
    intx:=trunc(x);
    inty:=trunc(y);
    placeBanna(ban1,ban2,ban3,ban4,banB,intx-10,inty-10,time);
{    circle(intx,inty,1);}
    if (time > 1.5) then
      hit:=check_persons(person,intx,inty);
    if (hit <> 0) then
      WasHit:=true;
    buildHit:=check_buildings(buildings,intx,inty,numbuild);
  until (y > 500) or (x > 700) or (x < 0) or (buildHit) or (WasHit);
  outtextxy(200,100,'Next Person');
  people(person);
  if (wasHit) then
   destroyPerson(hit,person);
  bannana_position:=WasHit;
end;

(***********************************************************)
procedure people_value(var person:arraytype);
(*---------------------------------------------------------*)
(*
(*---------------------------------------------------------*)
var
  incX:integer;
  j:integer;
begin
  incX:=10;
  for j:=1 to 2 do
   begin
    if (j = 2) then
     begin
       incX:=400;
     end;
    person[j].xint:=random(220)+incX;
    person[j].yint:=1;
    while (person[j].yint < 200) do
      person[j].yint:=random(400)+1;
   end;
end;

(***********************************************************)
procedure bulidings_values(person:arraytype;var bulidings:arraytype2;
                            var numBuild:integer);
(***********************************************************)
(*
(***********************************************************)
var
  xval:integer;
  xpos:integer;
  count:integer;
  time:integer;
begin
  count:=1;    time:=1;
  xpos:=0;
  (* make a variable that finds if it fits exactly*)
  repeat
   if (time=1) then
     xval:=person[1].xint-20;
   if (time=2) then
     xval:=person[2].xint-20;
   if (time=3) then
     xval:=635;
   while (xpos < xval) do
    begin
     xpos:=xpos+40;
     if (xpos >= xval) then
      begin
       bulidings[count].xint1:=xpos-40;
       bulidings[count].xint2:=xval;
       bulidings[count].y1:=random(300)+100;
       count:=count+1;
      end;
     if (xpos < xval) then
      begin
       bulidings[count].xint1:=xpos-40;
       bulidings[count].xint2:=xpos;
       bulidings[count].y1:=random(300)+100;
       count:=count+1;
      end;
    end;
   xpos:=xval+40;
   time:=time+1;
  until time = 4;
  numBuild:=count-1;
end;

procedure drawWindow(j,k:integer);
begin
  rectangle(j,k,j+5,k+10);
  setfillstyle(1,yellow);
  floodfill(j+1,k+1,yellow);
end;

procedure makeWindows(xtl,ytop,xtr,xb,wid,bot:integer);
var
  j,k:integer;
begin
  setcolor(yellow);
  if ((xtr-xtl) > wid) then
   begin
    j:=xtl+(wid div 2)-1;
    while (j < xtr) do
     begin
      k:=ytop+(wid div 2)-1;
      while (k < bot) do
       begin
        drawWindow(j,k);
        k:=k+wid;
       end;  (*of k while do*)
       j:=j+wid;
     end;  (*of j while do*)
  end;  (*of if then*)
end;


(***********************************************************)
procedure draw_buildings(person:arraytype;buildings:arraytype2;
                         numBuild:integer);
(*---------------------------------------------------------*)
(*
(*---------------------------------------------------------*)
var
 x:integer;
 j:integer;
 color,cl:integer;
 clP1,clP2:integer;
begin
  with person[1] do
   begin
    repeat
      clP1:=random(14)+1;
    until (clP1 <> 14) and (clP1 <> 3);
    setcolor(clP1);
    rectangle(xint-20,yint+20,xint+20,getmaxx);
    setfillStyle(1,clP1);
    floodfill(xint,yint+30,clP1);
    makeWindows(xint-20,yint+20,xint+20,getmaxx,15,getmaxy);
   end;
   with person[2] do
   begin
    repeat
      clP2:=random(14)+1;
    until (clP2 <> 14) and (clP2 <> 3);
    setcolor(clP2);
    rectangle(xint-20,yint+20,xint+20,getmaxx);
    setfillStyle(1,clP2);
    floodfill(xint,yint+30,clP2);
    makeWindows(xint-20,yint+20,xint+20,getmaxx,15,getmaxy);
   end;
  for j:=1 to numBuild do
   begin
     with buildings[j] do
      begin
        cL:=color;
        color:=random(14)+1;
        if (j = 1) then
         cL:=color;
        repeat
          color:=random(14)+1;
        until (color <> 0) and (cl <> color) and (color <> clP1) and (color <> clP2) and (color <> 14) and (color <> 3);
        setcolor(color);
        rectangle(xint1,y1,xint2,getmaxx);
        setfillstyle(1,color);
        floodfill(xint1+1,y1+1,color);
        makeWindows(xint1,y1,xint2,getmaxx,15,getmaxy);
      end;
   end;
   setcolor(15);
end;

procedure makebuil;
var
  j:integer;
  col,cl:integer;
  x,y:integer;
begin
  x:=200;
  y:=random(70)+10;
  cl:=1;
  repeat
   col:=random(14)+1;
  until (cl <> col) and (col <> 14) and (col <> 3);
  cl:=col;
  col:=random(14)+1;
  for j:=1 to 10 do
   begin
    setcolor(col);
    rectangle(x,350,x+20,350-y);
    setfillstyle(1,col);
    floodfill(x+1,345,col);
    x:=200+(j*20);
    y:=random(70)+10;
    repeat
     col:=random(14)+1;
    until (cl <> col) and (col <> 14) and (col <> 3);
    cl:=col;
   end;
end;




(***********************************************************)
procedure mainscreen(var max:integer;var blank,ban1,ban2,ban3,ban4,banb:pointer);
(*---------------------------------------------------------*)
(*
(*---------------------------------------------------------*)
begin
  setfillstyle(3,blue);
  floodfill(137,53,white);
  settextstyle(3,0,37);
  outtextxy(100,10,'Gorilla');
  (* make the little window*)
  setcolor(3);
  rectangle(200,200,400,350);
  setfillstyle(1,3);
  floodfill(201,201,3);
  makeOffScreenImage(banB,200,200,20,20);
  makeOffScreenImage(blank,200,200,165,30);
  makebuil;
 (* END *)
 (* make the bannas *)
  setcolor(yellow);
  (* QUAD 2*)
  arc(250,250,90,180,10);
  line(250,240,240,250);
  setfillstyle(1,yellow);
  floodfill(244,244,yellow);
  makeOffScreenImage(ban2,235,235,20,20);
  (* QUAD 1*)
  arc(260,240,0,90,10);
  line(260,230,270,240);
  setfillstyle(1,yellow);
  floodfill(265,234,yellow);
  makeOffScreenImage(ban1,255,225,20,20);
  (* QUAD 4*)
  arc(280,220,270,360,10);
  line(290,220,280,230);
  setfillstyle(1,yellow);
  floodfill(286,226,yellow);
  makeOffScreenImage(ban4,275,215,20,20);
  (* QUAD 3*)
  arc(310,230,180,270,10);
  line(300,230,310,240);
  setfillstyle(1,yellow);
  floodfill(304,236,yellow);
  makeOffScreenImage(ban3,295,225,20,20);
 (* END *)
 (* GIVE CREDIT *)
  setcolor(10);
  rectangle(10,450,getmaxx-10,getmaxy-10);
  setfillstyle(1,10);
  floodfill(11,451,10);
  setcolor(red);
  settextstyle(0,0,0);
  outtextxy(15,452,'This version of Gorillas ');
  outtextxy(15,461,'was designed by:');
  setcolor(white);
  settextstyle(3,0,3);
  outtextxy(225,442,'...');
  setcolor(black);
  settextstyle(2,0,4);
  outtextxy(400,448,'...');
  outtextxy(400,458,'http://...');
 (* END *)
  setcolor(white);
  SetTextStyle(DefaultFont, HorizDir,2);
  outtextxy(50,400,'How many do you want to play to?');
  line(250,438,280,438);
  max:=readInt(250,420);
  setTextStyle(DefaultFont,Horizdir,1);
  closegraph;
  setup(false);
end;

procedure freeTheMem(var I1:pointer;x,y,hei,wid:integer);
var
  size:word;
begin
  Size:=ImageSize(x,y,x+hei,y+wid);
  FreeMem(I1, size);
end;

procedure background(player:integer);
var
  x,y:integer;
begin
  y:=1;
  if player=1 then
    x:=1
  else
    x:=450;
  setcolor(0);
  rectangle(x,y,x+165,y+30);
  setfillstyle(1,0);
  floodfill(x+2,y+2,0);
end;

procedure score(winP1,winP2:integer);
begin
  setcolor(black);
  rectangle(275,430,365,450);
  setfillstyle(1,black);
  floodfill(301,431,black);
  setcolor(white);
  outtextxy(280,435,inttostr(inttostr('',winP1,' <WINS> '),winP2,''));
end;


(***********************************************************)
procedure driver;
(*---------------------------------------------------------*)
(*
(*---------------------------------------------------------*)
var
  person:arraytype;
  theta:integer;
  velocity:integer;
  j:integer;
  hit:boolean;
  buildings:arraytype2;
  numBuild:integer;
  max,wins,winP1,winP2:integer;
  I1,I2,I3,I4,P : pointer;
  ban1,ban2,ban3,ban4,banB:pointer;
  blank:pointer;
  player:integer;
begin
  randomize;
  player:=1;
  wins:=0; winP1:=0; winP2:=0;
  mainscreen(max,blank,ban1,ban2,ban3,ban4,banB);
  setfillstyle(1,3);
  floodfill(1,1,3);
  people_value(person);
  bulidings_values(person,buildings,numBuild);
  people(person);
  draw_buildings(person,buildings,numBuild);
  score(winP1,winP2);
  repeat
    hit:=false;
    velocity:=0;
    while (velocity <> -999) and not(hit) do
     begin
       background(player);
       setcolor(white);
       if (player = 1) then
        begin
         outtextxy(5,5,'Enter VELOCITY: ');
         velocity:=readint(125,5);
        end
       else
        begin
         outtextxy(455,5,'Enter VELOCITY: ');
         velocity:=readint(575,5);
        end;
       if (velocity < 0) and (velocity <> -999) or (velocity <> -999) and (velocity > 600) then
         velocity:=260;
       if (velocity <> -999) then
        begin
          if (player = 1) then
           begin
            outtextxy(5,20,'Enter ANGLE: ');
            theta:=readint(125,20);
           end
          else
           begin
            outtextxy(455,20,'Enter ANGLE: ');
            theta:=readint(575,20);
           end;
          hit:=bannana_position(person,theta,velocity,player,buildings,numBuild,ban1,ban2,ban3,ban4,banB);
        end;
       readln;
      putOffScreenImage(Blank,200,80);
       settextstyle(0,0,0);
      if (player = 1) then
       begin
        putOffScreenImage(blank,1,1);
        player:=2;
       end
      else
       begin
        putOffScreenImage(blank,450,1);
        player:=1;
       end;
     end; (* of while do *)
     if (player = 1) and (velocity <> -999) then
       winP2:=winP2+1
      else if (velocity <> -999) then
       winP1:=winP1+1;
     wins:=wins+1;
     if (velocity <> -999) and (wins < max) then
      begin
       cleardevice;
       setfillstyle(1,3);
       floodfill(1,1,3);
       people_value(person);
       bulidings_values(person,buildings,numBuild);
       people(person);
       draw_buildings(person,buildings,numBuild);
       score(winP1,winP2);
      end;
   until (wins >= max) or (velocity = -999);
  
  cleardevice;
  setcolor(5);
  setfillstyle(8,5);
  floodfill(0,0,5);
  setcolor(red);
  settextstyle(0,0,7);
  outtextxy(100,100,'Its over');
  setcolor(white);
  outtextxy(10,300,inttostr(inttostr('',winP1,' <WINS> '),winP2,''));
  freeTheMem(ban1,0,0,20,20);
  freeTheMem(ban2,0,0,20,20);
  freeTheMem(ban3,0,0,20,20);
  freeTheMem(ban4,0,0,20,20);
  freeTheMem(banB,0,0,20,20);
  freeTheMem(blank,0,0,165,30);
end;   (*of driver*)

(*==========================================================*)
var
  max:integer;
begin
  setup(false);
  driver;
  readln;
  closegraph;
end.   (*of main *)