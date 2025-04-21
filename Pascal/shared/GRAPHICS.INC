uses
  crt,graph,mouevent,dos,JeffLib,ButtonLib;

procedure setup(ynmouse:boolean);
var
  graphdriver,graphmode,errorcode:integer;
  com:onoff;
begin
  graphdriver:=detect;
  initgraph(graphdriver,graphmode,' ');
  errorcode:=graphresult;
  if errorcode <> grok then
    begin
      writeln('graphics error: ',grapherrormsg(errorcode));
      writeln('hit enter');
      readln;
    end;   (*of error code if then *)
  if (ynmouse) then
   if (initmouse) then
    begin
     com:=on;
     mousecursor(com);
     mwindow(0,0,getmaxx,getmaxy);
     setmouse(10,10);
    end;

 end;  (* of setup*)

procedure bgcolor(col:integer);
begin
  setfillstyle(1,col);
  floodfill(1,1,col);
end;

function findch(num:integer):char;
var
  temp:integer;
begin
  temp:=num+48;
  findch:=chr(temp);
end;

procedure tostr(var num:integer;der:integer;var str:string);
var
  temp:integer;
  sub:integer;
  ch:char;
begin
  if (num >= der) then
   begin
    tostr(num,der*10,str);
    temp:=num div der;
    sub:=temp * der;
    ch:=findch(temp);
    str:=str+ch;
    if (der = 10) then
     begin
      temp:=num mod der;
      ch:=findch(temp);
      str:=str+ch;
     end;
    num:=num-sub;
  end;
end;

function inttostr(st1:string;num:integer;st2:string):string;
var
  newstring:string;
  ch:char;
begin
  newstring:='';
  if (num < 0) then
   begin
    newstring:='-';
    num:=num*-1;
   end;
  if (num < 10) and (num >= 0) then
   begin
     inttostr:=st1+findch(num)+st2;
   end
  else if (num = 10) then
   begin
    inttostr:=st1+'10'+st2;
   end
  else if (num > 10) then
   begin
    tostr(num,10,newstring);
    inttostr:=st1+newstring+st2;
   end;
end;
