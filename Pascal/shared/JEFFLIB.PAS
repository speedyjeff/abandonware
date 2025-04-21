unit JeffLib;

interface
  {uses, const, type or var declarations if any}
  uses
    crt,graph,graphics;
  {functions, procedure headers}

  function findch(num:integer):char;
  procedure tostr(var num:integer;der:integer;var str:string);
  function inttostr(st1:string;num:integer;st2:string):string;
  procedure help;
  function strtoint(str:string) : integer;
  function readInt(x,y:integer) : integer;

implementation
  {full declations of functions and procedures}

  function sqr(a,b:integer) : integer;
  var
    j:integer;
    num:integer;
  begin
    num:=a;
    for j:=1 to b-1 do
      num:=num*a;
    sqr:=num;
  end;

  function strtoint(str:string) : integer;
  var
    j:integer;
    pl:integer;
    dig,number,num:integer;
    negative:boolean;
    N:integer;
  begin
    number:=0;
    if (str[1] = '-') then
      begin
       N:=1;
       negative:=true;
      end
     else
      begin
       N:=0;
       negative:=false;
      end;
    for j:=length(str)-N downto 2 do
     begin
      pl:=length(str) - j + 1;
      dig:=ord(str[pl]) - 48;
      num:=dig * sqr(10,j-1);
      number:=number+num;
     end;
    dig:=ord(str[length(str)]) - 48;
    number:=number+dig;
    if (negative) then
      number:=number*-1;
    strtoint:=number;
  end;

  function readInt(x,y:integer) : integer;
  var
    key:char;
    str:string;
    i:integer;
  begin
    str:='';
    repeat
     if (keypressed) then
      begin
       key:=readkey;
       if (ord(key) <> 13) then
        str:=str+key;
        outtextxy(x,y,str);
      end;
    until (ord(key) = 13);
    if (str = '') then
      str:='0';
    i:=strtoint(str);
    readInt:=i;
  end;

  procedure help;
  begin
    writeln;
    writeln('   ******** string INTTOSTR(string,integer,string); ***********');
    writeln('---TEXT----');
    writeln('To use this UNIT you use the function ¯INTTOSTR(''string'',integer,''string''); ');
    writeln('use it in a string:=inttostr(''string'',number,''string'')); and it will return the string');
    writeln;
    writeln('----GRAPHICS---');
    writeln('To use this UNIT you use the function ¯INTTOSTR(''string'',integer,''string''); ');
    writeln('use it in a outtextxy(10,10,inttostr(''string'',number,''string'')); and it will return the string');
    writeln;
    writeln('   ********* integer READINT(integer,integer);  ***************');
    writeln(' proper usage:    num:=readint(x,y);');
    writeln('In graphics mode will display the number as you enter it at the');
    writeln('x and y cordinates that you specify.');
    writeln;
    writeln('  **********  integer STRTOINT(string);  ***************');
    writeln(' proper usage:   num:=strtoint(''123'');');
    writeln('It will return the integer of the string value');
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

end.
