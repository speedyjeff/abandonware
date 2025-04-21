unit graphics;
interface
  uses
    crt,graph,mouevent,dos;

  procedure setup(ynmouse:boolean);

implementation

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
     setmouse(250,190);
    end;

 end;  (* of setup*)
end.

