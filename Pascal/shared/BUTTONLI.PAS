unit ButtonLib;
interface
  uses
    graphics,graph,mouevent,crt,jefflib;

  const
    max=20;
    SH=2;

  type
  rectype=Record
    top,left,hei,wid:integer;
    col:integer;
    tx:string;
  end;
  arraybut=array[1..max] of rectype;
  string20=string[20];

  var
    buttext:text;

  procedure initbutton(var buttons:arraybut; filename:string20;length:integer);
  procedure makebutton(buttons:rectype);
  procedure makebuttons(buttons:arraybut; length:integer);
  procedure clickbutton(buttons:rectype);
  function checkbuttons(x,y:integer;buttons:arraybut;length:integer):integer;

implementation

procedure initbutton(var buttons:arraybut; filename:string20;length:integer);
var
  j:integer;
  num:integer;
  st:string;
  buttext:text;
begin
  assign(buttext,filename);
  reset(buttext);
  for j:=1 to length do
   begin
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

procedure makebuttons(buttons:arraybut; length:integer);
var
  j:integer;
begin
  for j:=1 to length do
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

function checkbuttons(x,y:integer;buttons:arraybut;length:integer):integer;
var
  j,button:integer;
begin
  button:=-1;
  for j:=1 to length do
    begin
     with buttons[j] do
      if (x >= top) and (x <= top+hei) and (y >= left) and (y <=left+wid) then
       begin
        clickbutton(buttons[j]);
        button:=j;
       end;
    end;
  checkbuttons:=button;
end;

end.
