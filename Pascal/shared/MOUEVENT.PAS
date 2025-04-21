unit mouevent;
  interface

  uses
    crt,dos;
  var
    regs:registers;
  type
    onoff=(on,off);
  function initmouse:boolean;
  procedure mousecursor(com:onoff);
  function getmousex:integer;
  function getmousey:integer;
  procedure setmouse(x,y:integer);
  function button:integer;
  procedure mwindow(x1,y1,x2,y2:integer);
  procedure set_pointer(hotx,hoty:Word;image:POINTER);
  procedure hideRegion(top,left,bottom,right:Word);
  procedure mbuttonrelease(var x,y:integer);
  procedure printscreen;

  implementation

  procedure printscreen;
  begin
    intr($05,regs);
  end;

  function Pseg(x:pointer):Word;  inline($5a/$58);
  function POfs(x:pointer):Word;  inline($58/$5a);

  function initmouse:boolean;
  begin
    regs.ax:=$00;
    intr($33,regs);
    if (regs.ax=0) then
      initmouse:=false;
    if (regs.ax=-1) then
      initmouse:=true;
  end;

  procedure mousecursor(com:onoff);
  begin
    if (com = off) then
     begin
      regs.ax:=$02;
      intr($33,regs);
     end;
    if (com = on) then
     begin
      regs.ax:=$01;
      intr($33,regs);
     end;
  end;

  function getmousex:integer;
  begin
   regs.ax:=$03;
   intr($33,regs);
   getmousex:=regs.cx;
  end;

  function getmousey:integer;
  begin
    regs.ax:=$03;
    intr($33,regs);
    getmousey:=regs.dx;
  end;

  procedure mbuttonrelease(var x,y:integer);
  begin
    regs.ax:=$06;
    regs.bx:=button;
    intr($33,regs);
    x:=regs.cx;
    y:=regs.dx;
  end;

  procedure setmouse(x,y:integer);
  begin
    regs.ax:=$04;
    regs.dx:=y;
    regs.cx:=x;
    intr($33,regs);
  end;

  function button:integer;
  begin
    regs.ax:=$03;
    intr($33,regs);
    button:=regs.bx;
  end;

  procedure mwindow(x1,y1,x2,y2:integer);
  begin
    regs.ax:=$08;
    regs.cx:=y1;
    regs.dx:=y2;
    intr($33,regs);
    regs.ax:=$07;
    regs.cx:=x1;
    regs.dx:=x2;
    intr($33,regs);
  end;

  (*====================================================================
      ms_set_graphPointer                     real-mode mouse function 9
    ====================================================================
      hotx, hoty (+/-16) are the hot spot coordinates relative to the
      upper-left of the pointer image.
      image = pointer to the mouse pointer image bitmap
        The first 32 bytes define the screen mask
        The last 32 bytes define the pointer mask
      The pointer is drawn by:
         AND screen mask with pixels under the pointer,
         XOR pointer mask with result
      In mode 6, each bit defines the color of a pixel.
      In modes 4 and 5, each pair of bits defines the color of a
      pixel.
  *)

  procedure set_pointer (hotx,hoty:Word; image: Pointer);
  begin
    regs.ax:=9;
    regs.bx:=hotx;
    regs.cx:=hoty;
    regs.dx:=pofs(image);
    regs.es:=pseg(image);
    intr($33,regs);
  end;

  procedure hideregion(top,left,bottom,right:Word);
  var
    Regs:registers;
  begin
    regs.ax:=16;
    regs.cx:=left;
    regs.dx:=top;
    regs.si:=right;
    regs.di:=bottom;
    intr($33,regs);
  end;

end.
