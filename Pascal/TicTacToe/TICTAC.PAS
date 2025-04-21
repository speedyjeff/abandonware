program tic_tac_toe;
(*$I graphics.inc*)

const
  max=2;
  SH=2;

type
  rectype=Record
    top,left,hei,wid:integer;
    col:integer;
    tx:string;
  end;
  arraybut=array[1..max] of rectype;
  arraytype=array[1..3,1..3] of char;

var
  buttext:text;

procedure init(var tiles:arraytype);
var
  j,k:integer;
begin
  for j:=1 to 3 do
   for k:=1 to 3 do
    tiles[j,k]:=' ';
end;

procedure board;
begin
  bar(203,350,197,50);
  bar(303,350,297,50);
  bar(100,247,400,253);
  bar(100,147,400,153);
end;

procedure putTiles(tiles:arraytype);
var
  j,k:integer;
  x,y:integer;
begin
  settextstyle(0,0,7);
  for j:=1 to 3 do
   for k:=1 to 3 do
    begin
      outtextxy(j*90+45,k*90,tiles[k,j]);
    end;
end;

procedure putTile(where:rectype; player:char);
var
  j,k:integer;
begin
  settextstyle(0,0,7);
  if (player = 'X') then
    setcolor(red)
  else
    setcolor(yellow);
  outtextxy(where.left*90+45,where.top*90,player);
end;

procedure checkForWinner(tiles:arraytype;player:char;var found:boolean;
                          var which:rectype);
var
  j,k:integer;
  pl:char;
begin
  settextstyle(0,0,0);
  if (player = 'O') then
   pl:='X'
  else pl:='O';

  found:=false;

  for j:=1 to 3 do
   begin
    if (tiles[j,1] = pl) then
     if (tiles[j,1] = tiles[j,2]) and (tiles[j,2] = tiles[j,3]) then
      begin
       
       which.top:=j;
       found:=true;
      end;
    if (tiles[1,j] = pl) then
     if (tiles[1,j] = tiles[2,j]) and (tiles[2,j] = tiles[3,j]) then
      begin
       
       which.top:=j+3;
       found:=true;
      end;
   end; (* of for do loop*)

  if (tiles[1,1] = pl) then
    if (tiles[1,1] = tiles[2,2]) and (tiles[2,2] = tiles[3,3]) then
      begin
       
       which.top:=7;
       found:=true;
      end;

  if (tiles[1,3] = pl) then
    if (tiles[1,3] = tiles[2,2]) and (tiles[2,2] = tiles[3,1]) then
     begin
       
      which.top:=8;
      found:=true;
     end;
end;

procedure placeline(which:rectype);
begin
  case which.top of
   1:line(100,105,400,105);
   2:line(100,195,400,195);
   3:line(100,295,400,295);
   4:line(160,50,160,350);
   5:line(250,50,250,350);
   6:line(340,50,340,350);
   7:line(120,70,380,330);
   8:line(120,330,380,70);
  end;
end;

procedure checkBoard(x,y:integer;var found:boolean;var where:rectype;
                                     tiles:arraytype);
var
  j,k:integer;
  xin,yin:integer;
begin
 found:=false;
 for j:=1 to 3 do
  for k:=1 to 3 do
   begin
    case j of
      1:yin:=50;
      2:yin:=150;
      3:yin:=250;
    end;
    case k of
     1:xin:=100;
     2:xin:=200;
     3:xin:=300;
    end;
    if (x >= xin) and (y >= yin) and (x <= xin+100) and (y <= yin+100) then
     begin
      where.top:=j;
      where.left:=k;
      if (tiles[j,k] <> 'X') and (tiles[j,k] <> 'O') then
        found:=true;
     end;
   end;
end;

procedure printvalues(tiles:arraytype);
var
  j,k:integer;
begin
 settextstyle(0,0,1);
  for j:= 1 to 3 do
   for k:=1 to 3 do
    outtextxy(j*10,k*10,tiles[j,k]);
end;

procedure initmouse(var buttons:arraybut);
var
  j:integer;
  num:integer;
  st:string;
begin
  assign(buttext,'buttons.txt');
  reset(buttext);
  for j:= 1 to max do
   with buttons[j] do
    begin
     readln(buttext,num);
     top:=num;
     readln(buttext,num);
     left:=num;
     readln(buttext,num);
     hei:=num;
     readln(buttext,num);
     wid:=num;
     readln(buttext,num);
     col:=num;
     readln(buttext,st);
     tx:=st;
    end;
  close(buttext);
end;

procedure makebutton(buttons:rectype);
begin
   with buttons do
    begin
     settextstyle(0,0,1);
     setcolor(15);
     rectangle(top+SH,left+SH,top+hei+SH,left+wid+SH);
     setfillstyle(1,15);
     floodfill(top+hei+1,left+wid+1,15);
     setcolor(col);
     rectangle(top,left,top+hei,left+wid);
     setfillstyle(1,col);
     floodfill(top+1,left+1,col);
     setcolor(black);
     outtextxy(top+5,left+8,tx);
    end;
end;

procedure makebuttons(buttons:arraybut);
var
  j:integer;
begin
  for j:=1 to max do
   with buttons[j] do
    begin
     settextstyle(0,0,1);
     setcolor(15);
     rectangle(top+SH,left+SH,top+hei+SH,left+wid+SH);
     setfillstyle(1,15);
     floodfill(top+hei+1,left+wid+1,15);
     setcolor(col);
     rectangle(top,left,top+hei,left+wid);
     setfillstyle(1,col);
     floodfill(top+1,left+1,col);
     setcolor(black);
     outtextxy(top+5,left+8,tx);
    end;
end;

procedure clickbutton(buttons:rectype);
var
  x,y:integer;
begin
  with buttons do
   begin
     settextstyle(0,0,1);
    setcolor(col);
    outtextxy(top+5,left+8,tx);

    setcolor(0);
    rectangle(top+SH,left+SH,top+hei+SH,left+wid+SH);
    setfillstyle(1,0);
    floodfill(top+hei+1,left+wid+1,0);
    rectangle(top,left,top+hei,left+wid);
    setfillstyle(1,0);
    floodfill(top+1,left+1,0);

    setcolor(col);
    rectangle(top+SH,left+SH,top+hei+SH,left+wid+SH);
    setfillstyle(1,col);
    floodfill(top+6,left+6,col);
    setcolor(black);
    outtextxy(top+10,left+13,tx);
    while(button=1) do begin end;
   end;
  makebutton(buttons);
end;

procedure placeComputerTile(var tiles:arraytype; var where:rectype;
                                player:char);
var
  j,k:integer;
  fj,fk:integer;
  done,found:boolean;
  pl:char;
begin
  found:=false;
  for k:=1 to 2 do
   begin
    if (k=1) then
     pl:='O'
    else
     pl:='X';
    for j:=1 to 3 do
     begin

      if (tiles[j,1] = pl) and (tiles[j,2]=pl) and (tiles[j,3]= ' ') then
       begin
        fj:=j;
        fk:=3;
        found:=true;
       end;
      if (tiles[j,2] = pl) and (tiles[j,3]=pl) and (tiles[j,1]= ' ') then
       begin
        fj:=j;
        fk:=1;
        found:=true;
       end;
      if (tiles[j,3] = pl) and (tiles[j,1]=pl) and (tiles[j,2]= ' ') then
       begin
        fj:=j;
        fk:=2;
        found:=true;
       end;

      if (tiles[1,j] = pl) and (tiles[j,2]=pl) and (tiles[j,3]= ' ') then
       begin
        fj:=3;
        fk:=j;
        found:=true;
       end;
      if (tiles[2,j] = pl) and (tiles[3,j]=pl) and (tiles[1,j]= ' ') then
       begin
        fj:=1;
        fk:=j;
        found:=true;
       end;
      if (tiles[3,j] = pl) and (tiles[1,j]=pl) and (tiles[2,j]= ' ') then
       begin
        fj:=2;
        fk:=j;
        found:=true;
       end;
   end; (* of j for do loop*)
  end; (*of k for do loop*)

  if (tiles[1,1] = pl) then
    if (tiles[1,1] = tiles[2,2]) and (tiles[3,3] = ' ') then
      begin
       fj:=3;
       fk:=3;
       found:=true;
      end;
  if (tiles[1,1] = pl) then
    if (tiles[1,1] = tiles[3,3]) and (tiles[2,2] = ' ') then
      begin
       fj:=2;
       fk:=2;
       found:=true;
      end;
  if (tiles[2,2] = pl) then
    if (tiles[3,3] = tiles[2,2]) and (tiles[1,1] = ' ') then
      begin
       fj:=1;
       fk:=1;
       found:=true;
      end;

  if (tiles[1,3] = pl) then
    if (tiles[1,3] = tiles[2,2]) and (tiles[3,1] = ' ') then
      begin
       fj:=3;
       fk:=1;
       found:=true;
      end;
  if (tiles[2,2] = pl) then
    if (tiles[3,1] = tiles[3,3]) and (tiles[1,3] = ' ') then
      begin
       fj:=1;
       fk:=3;
       found:=true;
      end;
  if (tiles[1,3] = pl) then
    if (tiles[1,3] = tiles[3,1]) and (tiles[2,2] = ' ') then
      begin
       fj:=2;
       fk:=2;
       found:=true;
      end;

  j:=fj;
  k:=fk;

  if not(found) then
   begin
    done:=false;
    repeat
      j:=random(3)+1;
      k:=random(3)+1;
      if (tiles[j,k] = ' ') then
       done:=true;
    until (done);
   end;

  tiles[j,k]:='X';
  where.top:=j;
  where.left:=k;
  puttile(where,'X');
end;

procedure printHeader(owin,xwin,cats:integer);
begin
  settextstyle(0,0,1);
  outtextxy(10,30,'Player 1 is "O"');
  outtextxy(10,40,inttostr('and has ',owin,' wins'));
  outtextxy(10,50,inttostr('and ',cats,' cats games'));
  outtextxy(400,30,'Player 2 is "X"');
  outtextxy(400,40,inttostr('and has ',xwin,' wins'));
  outtextxy(400,50,inttostr('and ',cats,' cats games'));
end;

procedure driver;
var
  tiles:arraytype;
  buttons:arraybut;
  x,y:integer;
  j:integer;
  quit:boolean;
  found:boolean;
  fd:boolean;
  where,which:rectype;
  player:char;
  owin,xwin,cats:integer;
  count:integer;
begin
  randomize;
  player:='O';
  owin:=0;  xwin:=0;
  cats:=0;
  count:=0;
  quit:=false;
  found:=false;
  fd:=false;
  init(tiles);
  initmouse(buttons);
  makebuttons(buttons);
  board;
  setcolor(white);
  printHeader(owin,xwin,cats);
  repeat
   if (player = 'X') and (count < 9) then
    begin
     count:=count+1;
     placeComputerTile(tiles,where,'X');
     player:='O';
     checkForWinner(tiles,player,found,which);
    end;
   if (button=1) then
    begin
     x:=getmousex;
     y:=getmousey;
     (*check the buttons*)
     for j:=1 to max do
      begin
       with buttons[j] do
        if (x >= top) and (x <= top+hei) and (y >= left) and (y <=left+wid) then
         begin
          clickbutton(buttons[j]);
         if (j=1) then
           quit:=true;
         if (j=2) then
          begin
           board;
           setcolor(black);
           placeline(which);
           puttiles(tiles);
           init(tiles);
           count:=0;
          end;
        end;
      end;
     (*check the board*)
     checkBoard(x,y,fd,where,tiles);
     if (fd) then
      begin
        count:=count+1;
        puttile(where,player);
        while (button=1) do
         begin
         end;
        tiles[where.top,where.left]:=player;
        if (player = 'X') then
         player:='O'
        else
          player:='X';
       checkForWinner(tiles,player,found,which);
      end;
   end;

    if (found) then
     begin
      setcolor(black);
      printHeader(owin,xwin,cats);
      if (player = 'O') then
       xwin:=xwin+1
      else owin:=owin+1;
      setcolor(white);
      placeline(which);
      printHeader(owin,xwin,cats);
      count:=10;
      found:=false;
    end;
   if (count=9) then
     begin
      setcolor(black);
      printHeader(owin,xwin,cats);
      cats:=cats+1;
      setcolor(white);
      printHeader(owin,xwin,cats);
      count:=10;
     end;
  until (quit);
end;

begin
  setup(true);
  driver;
  closegraph;
end.
