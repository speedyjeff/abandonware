unit othelloC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Menus;

type
  TForm1 = class(TForm)
    Bevel1: TBevel;
    Edit1: TEdit;
    SpeedButton65: TSpeedButton;
    SpeedButton66: TSpeedButton;
    Bevel2: TBevel;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton1: TSpeedButton;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    SpeedButton17: TSpeedButton;
    SpeedButton18: TSpeedButton;
    SpeedButton19: TSpeedButton;
    SpeedButton20: TSpeedButton;
    SpeedButton21: TSpeedButton;
    SpeedButton22: TSpeedButton;
    SpeedButton23: TSpeedButton;
    SpeedButton24: TSpeedButton;
    SpeedButton25: TSpeedButton;
    SpeedButton26: TSpeedButton;
    SpeedButton27: TSpeedButton;
    SpeedButton28: TSpeedButton;
    SpeedButton29: TSpeedButton;
    SpeedButton30: TSpeedButton;
    SpeedButton31: TSpeedButton;
    SpeedButton32: TSpeedButton;
    SpeedButton33: TSpeedButton;
    SpeedButton34: TSpeedButton;
    SpeedButton35: TSpeedButton;
    SpeedButton36: TSpeedButton;
    SpeedButton37: TSpeedButton;
    SpeedButton38: TSpeedButton;
    SpeedButton39: TSpeedButton;
    SpeedButton40: TSpeedButton;
    SpeedButton41: TSpeedButton;
    SpeedButton42: TSpeedButton;
    SpeedButton43: TSpeedButton;
    SpeedButton44: TSpeedButton;
    SpeedButton45: TSpeedButton;
    SpeedButton46: TSpeedButton;
    SpeedButton47: TSpeedButton;
    SpeedButton48: TSpeedButton;
    SpeedButton49: TSpeedButton;
    SpeedButton50: TSpeedButton;
    SpeedButton51: TSpeedButton;
    SpeedButton52: TSpeedButton;
    SpeedButton53: TSpeedButton;
    SpeedButton54: TSpeedButton;
    SpeedButton55: TSpeedButton;
    SpeedButton56: TSpeedButton;
    SpeedButton57: TSpeedButton;
    SpeedButton58: TSpeedButton;
    SpeedButton59: TSpeedButton;
    SpeedButton60: TSpeedButton;
    SpeedButton61: TSpeedButton;
    SpeedButton62: TSpeedButton;
    SpeedButton63: TSpeedButton;
    SpeedButton64: TSpeedButton;
    PopupMenu1: TPopupMenu;
    New1: TMenuItem;
    Player1: TMenuItem;
    Player2: TMenuItem;
    Exit: TMenuItem;
    procedure SpeedButton66Click(Sender: TObject);
    procedure SpeedButton65Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure placewhitesquare;
    procedure placeblacksquare;
    procedure placegreensquare;
    procedure placement;
    procedure placed;
    procedure CheckDirection;
    procedure PlacementLegal(directr,directc,count:integer;var successful:boolean);
    procedure RowAndColumn(var row,col:integer; Butnumber:integer);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure SpeedButton16Click(Sender: TObject);
    procedure SpeedButton17Click(Sender: TObject);
    procedure SpeedButton18Click(Sender: TObject);
    procedure SpeedButton19Click(Sender: TObject);
    procedure SpeedButton20Click(Sender: TObject);
    procedure SpeedButton21Click(Sender: TObject);
    procedure SpeedButton22Click(Sender: TObject);
    procedure SpeedButton23Click(Sender: TObject);
    procedure SpeedButton24Click(Sender: TObject);
    procedure SpeedButton25Click(Sender: TObject);
    procedure SpeedButton26Click(Sender: TObject);
    procedure SpeedButton27Click(Sender: TObject);
    procedure SpeedButton28Click(Sender: TObject);
    procedure SpeedButton29Click(Sender: TObject);
    procedure SpeedButton30Click(Sender: TObject);
    procedure SpeedButton31Click(Sender: TObject);
    procedure SpeedButton32Click(Sender: TObject);
    procedure SpeedButton33Click(Sender: TObject);
    procedure SpeedButton34Click(Sender: TObject);
    procedure SpeedButton35Click(Sender: TObject);
    procedure SpeedButton36Click(Sender: TObject);
    procedure SpeedButton37Click(Sender: TObject);
    procedure SpeedButton38Click(Sender: TObject);
    procedure SpeedButton39Click(Sender: TObject);
    procedure SpeedButton40Click(Sender: TObject);
    procedure SpeedButton41Click(Sender: TObject);
    procedure SpeedButton42Click(Sender: TObject);
    procedure SpeedButton43Click(Sender: TObject);
    procedure SpeedButton44Click(Sender: TObject);
    procedure SpeedButton45Click(Sender: TObject);
    procedure SpeedButton46Click(Sender: TObject);
    procedure SpeedButton47Click(Sender: TObject);
    procedure SpeedButton48Click(Sender: TObject);
    procedure SpeedButton49Click(Sender: TObject);
    procedure SpeedButton50Click(Sender: TObject);
    procedure SpeedButton51Click(Sender: TObject);
    procedure SpeedButton52Click(Sender: TObject);
    procedure SpeedButton53Click(Sender: TObject);
    procedure SpeedButton54Click(Sender: TObject);
    procedure SpeedButton55Click(Sender: TObject);
    procedure SpeedButton56Click(Sender: TObject);
    procedure SpeedButton57Click(Sender: TObject);
    procedure SpeedButton58Click(Sender: TObject);
    procedure SpeedButton59Click(Sender: TObject);
    procedure SpeedButton60Click(Sender: TObject);
    procedure SpeedButton61Click(Sender: TObject);
    procedure SpeedButton62Click(Sender: TObject);
    procedure SpeedButton63Click(Sender: TObject);
    procedure SpeedButton64Click(Sender: TObject);
    procedure Player1Click(Sender: TObject);
    procedure New1Click(Sender: TObject);
    procedure ExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

type
  string20=string[20];
  d2arraytype = array[1..8,1..8] of integer;
  d1arraytype = array[1..64] of integer;

var
  player:integer;
  squares:d2arraytype;
  butnum:integer;
  direction:d1arraytype;
  button:integer;
  row,col:integer;



{$R *.DFM}


procedure TForm1.SpeedButton66Click(Sender: TObject);
{ Player 2 }
var
  j,k,con1,con2:integer;
begin
  con1:=0; con2:=0;
  edit1.clear;
  edit1.text:='                        player 2';
  player:=2;
  { Counts all the tiles }
  for j:=1 to 8 do
   for k:=1 to 8 do
    begin
     if squares[j,k]=1 then
       con1:=con1+1;
     if squares[j,k]=2 then
       con2:=con2+1;
    end;
  { puts the values in right place }
  edit3.clear;
  edit2.clear;
  edit3.text:=inttostr(con2);
  edit2.text:=inttostr(con1);
  player2.visible:=false;
  player1.visible:=true;
end;

procedure TForm1.SpeedButton65Click(Sender: TObject);
{ Player one }
var
  j,k,con1,con2:integer;
begin
  con1:=0; con2:=0;
  edit1.clear;
  edit1.text:='player 1';
  player:=1;
  for j:=1 to 8 do
   for k:=1 to 8 do
    begin
     if squares[j,k]=1 then
      con1:=con1+1;
     if squares[j,k]=2 then
      con2:=con2+1;
    end;
  edit3.clear;
  edit2.clear;
  edit3.text:=inttostr(con2);
  edit2.text:=inttostr(con1);
  player1.visible:=false;
  player2.visible:=true;
end;


procedure TForm1.FormCreate(Sender: TObject);
var
  j,k:integer;
begin
  for j:=1 to 8 do
    for k:=1 to 8 do
      squares[j,k]:=0;
  for j:=1 to 64 do
    direction[j]:=0;
  squares[4,4]:=1;
  squares[4,5]:=2;
  squares[5,4]:=2;
  squares[5,5]:=1;
  edit1.text:='player 1';
  player:=1;
  edit2.text:='2';
  edit3.text:='2';
end;

procedure Tform1.RowAndColumn(var row,col:integer; Butnumber:integer);
begin
  //determine the row which it is in
  row:=(Butnumber*8) div 64;
  if (Butnumber mod 8 <> 0) then
    row:=row+1;
  //determines the column which it is in
  col:=Butnumber - ((row*8)-8);
end;

procedure Tform1.placement;
var
  spaceC,spaceR:integer;
  next:integer;
  count:integer;
  MinDirC,MinDirR:integer;
begin
  next:=1;
  count:=0;
{  RowAndColumn(row,col,butnum);}

  //checks to see if the placement is legal
  if squares[row,col] = 0 then
   begin
    while (count < 8) do
     begin
      count:=count+1;
      case count of
        1: begin
            MinDirR:=-1;
            MinDirC:=-1;
           end;
        2:begin
            MinDirR:=-1;
            MinDirC:=0;
           end;
        3:begin
            MinDirR:=-1;
            MinDirC:=1;
           end;
        4:begin
            MinDirR:=0;
            MinDirC:=-1;
           end;
        5:begin
            MinDirR:=0;
            MinDirC:=1;
           end;
        6:begin
            MinDirR:=1;
            MinDirC:=-1;
           end;
        7:begin
            MinDirR:=1;
            MinDirC:=0;
           end;
        8:begin
            MinDirR:=1;
            MinDirC:=1;
           end;
      end;      (*for case*)
      spaceC:=butnum+MinDirC;
      spaceR:=butnum+MinDirR;
      if (squares[spaceR,spaceC] <> 0) then
        begin
         //check the row and column
         if (col=1) and (count=1) or (col=1) and (count=4) or (col=1) and (count=6) then
           continue;
         if (col=8) and (count=3) or (col=8) and (count=5) or (col=8) and (count=8) then
           continue;
         if (row=1) and (count=1) or (row=1) and (count=2) or (row=1) and (count=3) then
           continue;
         if (row=8) and (count=6) or (row=8) and (count=7) or (row=8) and (count=8) then
           continue;
         if (spaceR > 0) and (spaceR <= 8) and (spaceC > 0) and (spaceC <=8) then
           if (squares[spaceR,spaceC]<>player) then
            begin
             direction[next]:=count;
             next:=next+1;
            end; (*of if then*)
        end;   (*of if then*)
     end;      (*of while do*)
    end; (* of if then *)

  direction[next]:=0;
  if direction[1] <> 0 then
    CheckDirection;
end;

procedure Tform1.CheckDirection;
var
  count:integer;
  directR,directC:integer;
  con1,con2,j,k:integer;
  successful:boolean;
begin
  count:=1;
  successful:=false;
  while (count<=8) and (direction[count]<>0) do
   begin
    case count of
        1: begin
            directR:=-1;
            directC:=-1;
           end;
        2:begin
            directR:=-1;
            directC:=0;
           end;
        3:begin
            directR:=-1;
            directC:=1;
           end;
        4:begin
            directR:=0;
            directC:=-1;
           end;
        5:begin
            directR:=0;
            directC:=1;
           end;
        6:begin
            directR:=1;
            directC:=-1;
           end;
        7:begin
            directR:=1;
            directC:=0;
           end;
        8:begin
            directR:=1;
            directC:=1;
           end;
      end;      (*for case*)
    PlacementLegal(directR,directC,count,successful);
    count:=count+1;
   end;   (*While do*)

  if (Successful) then
   begin
    edit1.clear;
    if (player = 1) then
     begin
      edit1.text:='                        player 2';
      player:=2;
      player2.visible:=false;
      player1.visible:=true;
     end
    else
    if (player = 2) then
     begin
      edit1.text:='player 1';
      player:=1;
      player1.visible:=false;
      player2.visible:=true;
     end;
    con1:=0; con2:=0;
    edit3.clear;
    edit2.clear;
    for j:=1 to 8 do
     for k:=1 to 8 do
      begin
       if squares[j,k]=1 then
         con1:=con1+1;
       if squares[j,k]=2 then
         con2:=con2+1;
      end;
     edit3.text:=inttostr(con2);
     edit2.text:=inttostr(con1);
   end;
 end;

function convertToNumber(sidleR,sidleC:integer) : integer;
begin
  convertToNumber:= (sidleR * 8) + sidleC;
end;

procedure Tform1.PlacementLegal(directR,directC,count:integer;var successful:boolean);
var
  sidleC,sidleR:integer;
  Times:integer;
  GoodBad:boolean;
  j,k:integer;
  orgButnum:integer;
  counter:integer;
  lRow,lCol:integer;
  pRow,pCol:integer;
begin
  Times:=0;  counter:=0;
  lRow:=0;  lCol:=0;
  pRow:=0;  pCol:=0;
  orgButnum:=butnum;
  GoodBad:=false;
  sidleR:=OrgButnum+directR;
  sidleC:=orgButnum+directC;
  //showmessage('Sidle is '+inttostr(sidle)+' Direct is '+inttostr(direct));
  repeat
    counter:=counter+1;
    if (sidleR > 0) and (sidleR <= 8) and (sidleC > 0) and (sidleC <=8) then
      if (squares[sidleR,sidleC] <> 0) then
        begin
        if (squares[sidleR,sidleC] <> player) then
         begin
          Times:=Times+1;
          sidleR:=sidleR+directR;
          sidleC:=sidleC+directC;
         end;  (*of if then*)
         // to stop the rap around
         {if (row = 8) then
           pRow:=row;
         if (row = 1) then
           pRow:=row;
         if (col= 8) then
           pCol:=col;
         if (col = 1) then
           Pcol:=col;
         if (pCol = 8) and (col = 1) then
           break;
         if (pCol = 1) and (col = 8) then
           break;
         if (sidle mod 8 = 0) and (pRow = row) then
           break;}
         // to stop the below or above
         if (row > 8) or (row < 1) or (col > 8) or (col < 1) then
          begin
           showmessage('row is '+inttostr(row)+' BREAK');
           break;
          end;
         if (squares[sidleR,sidleC] = player) and (sidleR < 9) and (sidleR > 0) then
          begin
           GoodBad:=true;
           successful:=true;
           break;
          end;  (*of if then*)
        end;    (*of if then*)
  until (squares[sidleR,sidleC]=0) or (sidleR < 1) or (sidleR > 8) or (counter = 25) or
                     (row > 8) or (row < 1) or (sidleC < 1) or (sidleC > 8);
 // showmessage('Number of times is '+inttostr(times));
  if (GoodBad) then
   begin
    sidleR:=OrgButnum;
    sidleC:=orgButnum;
    if (player = 1) then
      for j:=0 to times do
       begin
        butnum:=convertToNumber(sidleR,sidleC);
        squares[sidleR,sidleC]:=1;
        placewhitesquare;
        sidleR:=OrgButnum+directR;
        sidleC:=orgButnum+directC;
       end;
     if (player = 2) then
      for j:=0 to times do
       begin
        butnum:=convertToNumber(sidleR,sidleC);
        squares[sidleR,sidleC]:=2;
        placeblacksquare;
        sidleR:=OrgButnum+directR;
        sidleC:=orgButnum+directC;
       end;   (*of for do*)
    end;
  butnum:=OrgButnum;
end;

procedure Tform1.placed;
begin
  if player=1 then
   begin
  (*  if squares[butnum]<>player then
     begin *)
      placewhitesquare;
      squares[row,col]:=1;
     end;
   (*  else
      begin
       placegreensquare;
       squares[butnum]:=0;
      end;
   end; *)
 if player=2 then
  begin
 (*  if squares[butnum]<>player then
    begin *)
     placeblacksquare;
     adf
     squares[row,col]:=2;
    end;
 (*   else
      begin
       placegreensquare;
       squares[butnum]:=0;
      end;
   end; *)
end;

procedure Tform1.placewhitesquare;
begin
  case butnum of
    1:speedbutton1.glyph.loadfromfile('whitedisc.bmp');
    2:speedbutton2.glyph.loadfromfile('whitedisc.bmp');
    3:speedbutton3.glyph.loadfromfile('whitedisc.bmp');
    4:speedbutton4.glyph.loadfromfile('whitedisc.bmp');
    5:speedbutton5.glyph.loadfromfile('whitedisc.bmp');
    6:speedbutton6.glyph.loadfromfile('whitedisc.bmp');
    7:speedbutton7.glyph.loadfromfile('whitedisc.bmp');
    8:speedbutton8.glyph.loadfromfile('whitedisc.bmp');
    9:speedbutton9.glyph.loadfromfile('whitedisc.bmp');
    10:speedbutton10.glyph.loadfromfile('whitedisc.bmp');
    11:speedbutton11.glyph.loadfromfile('whitedisc.bmp');
    12:speedbutton12.glyph.loadfromfile('whitedisc.bmp');
    13:speedbutton13.glyph.loadfromfile('whitedisc.bmp');
    14:speedbutton14.glyph.loadfromfile('whitedisc.bmp');
    15:speedbutton15.glyph.loadfromfile('whitedisc.bmp');
    16:speedbutton16.glyph.loadfromfile('whitedisc.bmp');
    17:speedbutton17.glyph.loadfromfile('whitedisc.bmp');
    18:speedbutton18.glyph.loadfromfile('whitedisc.bmp');
    19:speedbutton19.glyph.loadfromfile('whitedisc.bmp');
    20:speedbutton20.glyph.loadfromfile('whitedisc.bmp');
    21:speedbutton21.glyph.loadfromfile('whitedisc.bmp');
    22:speedbutton22.glyph.loadfromfile('whitedisc.bmp');
    23:speedbutton23.glyph.loadfromfile('whitedisc.bmp');
    24:speedbutton24.glyph.loadfromfile('whitedisc.bmp');
    25:speedbutton25.glyph.loadfromfile('whitedisc.bmp');
    26:speedbutton26.glyph.loadfromfile('whitedisc.bmp');
    27:speedbutton27.glyph.loadfromfile('whitedisc.bmp');
    28:speedbutton28.glyph.loadfromfile('whitedisc.bmp');
    29:speedbutton29.glyph.loadfromfile('whitedisc.bmp');
    30:speedbutton30.glyph.loadfromfile('whitedisc.bmp');
    31:speedbutton31.glyph.loadfromfile('whitedisc.bmp');
    32:speedbutton32.glyph.loadfromfile('whitedisc.bmp');
    33:speedbutton33.glyph.loadfromfile('whitedisc.bmp');
    34:speedbutton34.glyph.loadfromfile('whitedisc.bmp');
    35:speedbutton35.glyph.loadfromfile('whitedisc.bmp');
    36:speedbutton36.glyph.loadfromfile('whitedisc.bmp');
    37:speedbutton37.glyph.loadfromfile('whitedisc.bmp');
    38:speedbutton38.glyph.loadfromfile('whitedisc.bmp');
    39:speedbutton39.glyph.loadfromfile('whitedisc.bmp');
    40:speedbutton40.glyph.loadfromfile('whitedisc.bmp');
    41:speedbutton41.glyph.loadfromfile('whitedisc.bmp');
    42:speedbutton42.glyph.loadfromfile('whitedisc.bmp');
    43:speedbutton43.glyph.loadfromfile('whitedisc.bmp');
    44:speedbutton44.glyph.loadfromfile('whitedisc.bmp');
    45:speedbutton45.glyph.loadfromfile('whitedisc.bmp');
    46:speedbutton46.glyph.loadfromfile('whitedisc.bmp');
    47:speedbutton47.glyph.loadfromfile('whitedisc.bmp');
    48:speedbutton48.glyph.loadfromfile('whitedisc.bmp');
    49:speedbutton49.glyph.loadfromfile('whitedisc.bmp');
    50:speedbutton50.glyph.loadfromfile('whitedisc.bmp');
    51:speedbutton51.glyph.loadfromfile('whitedisc.bmp');
    52:speedbutton52.glyph.loadfromfile('whitedisc.bmp');
    53:speedbutton53.glyph.loadfromfile('whitedisc.bmp');
    54:speedbutton54.glyph.loadfromfile('whitedisc.bmp');
    55:speedbutton55.glyph.loadfromfile('whitedisc.bmp');
    56:speedbutton56.glyph.loadfromfile('whitedisc.bmp');
    57:speedbutton57.glyph.loadfromfile('whitedisc.bmp');
    58:speedbutton58.glyph.loadfromfile('whitedisc.bmp');
    59:speedbutton59.glyph.loadfromfile('whitedisc.bmp');
    60:speedbutton60.glyph.loadfromfile('whitedisc.bmp');
    61:speedbutton61.glyph.loadfromfile('whitedisc.bmp');
    62:speedbutton62.glyph.loadfromfile('whitedisc.bmp');
    63:speedbutton63.glyph.loadfromfile('whitedisc.bmp');
    64:speedbutton64.glyph.loadfromfile('whitedisc.bmp');
   end;
end;

procedure Tform1.placeblacksquare;
begin
  case butnum of
    1:speedbutton1.glyph.loadfromfile('blackdisc.bmp');
    2:speedbutton2.glyph.loadfromfile('blackdisc.bmp');
    3:speedbutton3.glyph.loadfromfile('blackdisc.bmp');
    4:speedbutton4.glyph.loadfromfile('blackdisc.bmp');
    5:speedbutton5.glyph.loadfromfile('blackdisc.bmp');
    6:speedbutton6.glyph.loadfromfile('blackdisc.bmp');
    7:speedbutton7.glyph.loadfromfile('blackdisc.bmp');
    8:speedbutton8.glyph.loadfromfile('blackdisc.bmp');
    9:speedbutton9.glyph.loadfromfile('blackdisc.bmp');
    10:speedbutton10.glyph.loadfromfile('blackdisc.bmp');
    11:speedbutton11.glyph.loadfromfile('blackdisc.bmp');
    12:speedbutton12.glyph.loadfromfile('blackdisc.bmp');
    13:speedbutton13.glyph.loadfromfile('blackdisc.bmp');
    14:speedbutton14.glyph.loadfromfile('blackdisc.bmp');
    15:speedbutton15.glyph.loadfromfile('blackdisc.bmp');
    16:speedbutton16.glyph.loadfromfile('blackdisc.bmp');
    17:speedbutton17.glyph.loadfromfile('blackdisc.bmp');
    18:speedbutton18.glyph.loadfromfile('blackdisc.bmp');
    19:speedbutton19.glyph.loadfromfile('blackdisc.bmp');
    20:speedbutton20.glyph.loadfromfile('blackdisc.bmp');
    21:speedbutton21.glyph.loadfromfile('blackdisc.bmp');
    22:speedbutton22.glyph.loadfromfile('blackdisc.bmp');
    23:speedbutton23.glyph.loadfromfile('blackdisc.bmp');
    24:speedbutton24.glyph.loadfromfile('blackdisc.bmp');
    25:speedbutton25.glyph.loadfromfile('blackdisc.bmp');
    26:speedbutton26.glyph.loadfromfile('blackdisc.bmp');
    27:speedbutton27.glyph.loadfromfile('blackdisc.bmp');
    28:speedbutton28.glyph.loadfromfile('blackdisc.bmp');
    29:speedbutton29.glyph.loadfromfile('blackdisc.bmp');
    30:speedbutton30.glyph.loadfromfile('blackdisc.bmp');
    31:speedbutton31.glyph.loadfromfile('blackdisc.bmp');
    32:speedbutton32.glyph.loadfromfile('blackdisc.bmp');
    33:speedbutton33.glyph.loadfromfile('blackdisc.bmp');
    34:speedbutton34.glyph.loadfromfile('blackdisc.bmp');
    35:speedbutton35.glyph.loadfromfile('blackdisc.bmp');
    36:speedbutton36.glyph.loadfromfile('blackdisc.bmp');
    37:speedbutton37.glyph.loadfromfile('blackdisc.bmp');
    38:speedbutton38.glyph.loadfromfile('blackdisc.bmp');
    39:speedbutton39.glyph.loadfromfile('blackdisc.bmp');
    40:speedbutton40.glyph.loadfromfile('blackdisc.bmp');
    41:speedbutton41.glyph.loadfromfile('blackdisc.bmp');
    42:speedbutton42.glyph.loadfromfile('blackdisc.bmp');
    43:speedbutton43.glyph.loadfromfile('blackdisc.bmp');
    44:speedbutton44.glyph.loadfromfile('blackdisc.bmp');
    45:speedbutton45.glyph.loadfromfile('blackdisc.bmp');
    46:speedbutton46.glyph.loadfromfile('blackdisc.bmp');
    47:speedbutton47.glyph.loadfromfile('blackdisc.bmp');
    48:speedbutton48.glyph.loadfromfile('blackdisc.bmp');
    49:speedbutton49.glyph.loadfromfile('blackdisc.bmp');
    50:speedbutton50.glyph.loadfromfile('blackdisc.bmp');
    51:speedbutton51.glyph.loadfromfile('blackdisc.bmp');
    52:speedbutton52.glyph.loadfromfile('blackdisc.bmp');
    53:speedbutton53.glyph.loadfromfile('blackdisc.bmp');
    54:speedbutton54.glyph.loadfromfile('blackdisc.bmp');
    55:speedbutton55.glyph.loadfromfile('blackdisc.bmp');
    56:speedbutton56.glyph.loadfromfile('blackdisc.bmp');
    57:speedbutton57.glyph.loadfromfile('blackdisc.bmp');
    58:speedbutton58.glyph.loadfromfile('blackdisc.bmp');
    59:speedbutton59.glyph.loadfromfile('blackdisc.bmp');
    60:speedbutton60.glyph.loadfromfile('blackdisc.bmp');
    61:speedbutton61.glyph.loadfromfile('blackdisc.bmp');
    62:speedbutton62.glyph.loadfromfile('blackdisc.bmp');
    63:speedbutton63.glyph.loadfromfile('blackdisc.bmp');
    64:speedbutton64.glyph.loadfromfile('blackdisc.bmp');
   end;
end;

procedure Tform1.placegreensquare;
begin
  case butnum of
    1:speedbutton1.glyph.loadfromfile('greensqu.bmp');
    2:speedbutton2.glyph.loadfromfile('greensqu.bmp');
    3:speedbutton3.glyph.loadfromfile('greensqu.bmp');
    4:speedbutton4.glyph.loadfromfile('greensqu.bmp');
    5:speedbutton5.glyph.loadfromfile('greensqu.bmp');
    6:speedbutton6.glyph.loadfromfile('greensqu.bmp');
    7:speedbutton7.glyph.loadfromfile('greensqu.bmp');
    8:speedbutton8.glyph.loadfromfile('greensqu.bmp');
    9:speedbutton9.glyph.loadfromfile('greensqu.bmp');
    10:speedbutton10.glyph.loadfromfile('greensqu.bmp');
    11:speedbutton11.glyph.loadfromfile('greensqu.bmp');
    12:speedbutton12.glyph.loadfromfile('greensqu.bmp');
    13:speedbutton13.glyph.loadfromfile('greensqu.bmp');
    14:speedbutton14.glyph.loadfromfile('greensqu.bmp');
    15:speedbutton15.glyph.loadfromfile('greensqu.bmp');
    16:speedbutton16.glyph.loadfromfile('greensqu.bmp');
    17:speedbutton17.glyph.loadfromfile('greensqu.bmp');
    18:speedbutton18.glyph.loadfromfile('greensqu.bmp');
    19:speedbutton19.glyph.loadfromfile('greensqu.bmp');
    20:speedbutton20.glyph.loadfromfile('greensqu.bmp');
    21:speedbutton21.glyph.loadfromfile('greensqu.bmp');
    22:speedbutton22.glyph.loadfromfile('greensqu.bmp');
    23:speedbutton23.glyph.loadfromfile('greensqu.bmp');
    24:speedbutton24.glyph.loadfromfile('greensqu.bmp');
    25:speedbutton25.glyph.loadfromfile('greensqu.bmp');
    26:speedbutton26.glyph.loadfromfile('greensqu.bmp');
    27:speedbutton27.glyph.loadfromfile('greensqu.bmp');
    28:speedbutton28.glyph.loadfromfile('greensqu.bmp');
    29:speedbutton29.glyph.loadfromfile('greensqu.bmp');
    30:speedbutton30.glyph.loadfromfile('greensqu.bmp');
    31:speedbutton31.glyph.loadfromfile('greensqu.bmp');
    32:speedbutton32.glyph.loadfromfile('greensqu.bmp');
    33:speedbutton33.glyph.loadfromfile('greensqu.bmp');
    34:speedbutton34.glyph.loadfromfile('greensqu.bmp');
    35:speedbutton35.glyph.loadfromfile('greensqu.bmp');
    36:speedbutton36.glyph.loadfromfile('greensqu.bmp');
    37:speedbutton37.glyph.loadfromfile('greensqu.bmp');
    38:speedbutton38.glyph.loadfromfile('greensqu.bmp');
    39:speedbutton39.glyph.loadfromfile('greensqu.bmp');
    40:speedbutton40.glyph.loadfromfile('greensqu.bmp');
    41:speedbutton41.glyph.loadfromfile('greensqu.bmp');
    42:speedbutton42.glyph.loadfromfile('greensqu.bmp');
    43:speedbutton43.glyph.loadfromfile('greensqu.bmp');
    44:speedbutton44.glyph.loadfromfile('greensqu.bmp');
    45:speedbutton45.glyph.loadfromfile('greensqu.bmp');
    46:speedbutton46.glyph.loadfromfile('greensqu.bmp');
    47:speedbutton47.glyph.loadfromfile('greensqu.bmp');
    48:speedbutton48.glyph.loadfromfile('greensqu.bmp');
    49:speedbutton49.glyph.loadfromfile('greensqu.bmp');
    50:speedbutton50.glyph.loadfromfile('greensqu.bmp');
    51:speedbutton51.glyph.loadfromfile('greensqu.bmp');
    52:speedbutton52.glyph.loadfromfile('greensqu.bmp');
    53:speedbutton53.glyph.loadfromfile('greensqu.bmp');
    54:speedbutton54.glyph.loadfromfile('greensqu.bmp');
    55:speedbutton55.glyph.loadfromfile('greensqu.bmp');
    56:speedbutton56.glyph.loadfromfile('greensqu.bmp');
    57:speedbutton57.glyph.loadfromfile('greensqu.bmp');
    58:speedbutton58.glyph.loadfromfile('greensqu.bmp');
    59:speedbutton59.glyph.loadfromfile('greensqu.bmp');
    60:speedbutton60.glyph.loadfromfile('greensqu.bmp');
    61:speedbutton61.glyph.loadfromfile('greensqu.bmp');
    62:speedbutton62.glyph.loadfromfile('greensqu.bmp');
    63:speedbutton63.glyph.loadfromfile('greensqu.bmp');
    64:speedbutton64.glyph.loadfromfile('greensqu.bmp');
   end;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  butnum:=3;
  col:=3;
  row:=1;
  placement;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  butnum:=2;
  col:=2;
  row:=1;
  placement;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  butnum:=1;
  col:=1;
  row:=1;
  placement;
end;


procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  butnum:=4;
  col:=4;
  row:=1;
  placement;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
  butnum:=5;
  col:=5;
  row:=1;
  placement;
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
begin
  butnum:=6;
  col:=6;
  row:=1;
  placement;
end;

procedure TForm1.SpeedButton7Click(Sender: TObject);
begin
  butnum:=7;
  col:=7;
  row:=1;
  placement;
end;

procedure TForm1.SpeedButton8Click(Sender: TObject);
begin
  butnum:=8;
  col:=8;
  row:=1;
  placement;
end;

procedure TForm1.SpeedButton9Click(Sender: TObject);
begin
  butnum:=9;
  col:=1;
  row:=2;
  placement;
end;

procedure TForm1.SpeedButton10Click(Sender: TObject);
begin
  butnum:=10;
  col:=2;
  row:=2;
  placement;
end;

procedure TForm1.SpeedButton11Click(Sender: TObject);
begin
  butnum:=11;
  col:=3;
  row:=2;
  placement;
end;

procedure TForm1.SpeedButton12Click(Sender: TObject);
begin
  butnum:=12;
  col:=4;
  row:=2;
  placement;
end;

procedure TForm1.SpeedButton13Click(Sender: TObject);
begin
  butnum:=13;
  col:=5;
  row:=2;
  placement;
end;

procedure TForm1.SpeedButton14Click(Sender: TObject);
begin
  butnum:=14;
  col:=6;
  row:=2;
  placement;
end;

procedure TForm1.SpeedButton15Click(Sender: TObject);
begin
  butnum:=15;
  col:=7;
  row:=2;
  placement;
end;

procedure TForm1.SpeedButton16Click(Sender: TObject);
begin
  butnum:=16;
  col:=8;
  row:=2;
  placement;
end;

procedure TForm1.SpeedButton17Click(Sender: TObject);
begin
  butnum:=17;
  col:=1;
  row:=3;
  placement;
end;

procedure TForm1.SpeedButton18Click(Sender: TObject);
begin
  butnum:=18;
  col:=2;
  row:=3;
  placement;
end;

procedure TForm1.SpeedButton19Click(Sender: TObject);
begin
  butnum:=19;
  col:=3;
  row:=3;
  placement;
end;

procedure TForm1.SpeedButton20Click(Sender: TObject);
begin
  butnum:=20;
  col:=4;
  row:=3;
  placement;
end;

procedure TForm1.SpeedButton21Click(Sender: TObject);
begin
  butnum:=21;
  col:=5;
  row:=3;
  placement;
end;

procedure TForm1.SpeedButton22Click(Sender: TObject);
begin
  butnum:=22;
  col:=6;
  row:=3;
  placement;
end;

procedure TForm1.SpeedButton23Click(Sender: TObject);
begin
  butnum:=23;
  col:=7;
  row:=3;
  placement;
end;

procedure TForm1.SpeedButton24Click(Sender: TObject);
begin
  butnum:=24;
  col:=8;
  row:=3;
  placement;
end;

procedure TForm1.SpeedButton25Click(Sender: TObject);
begin
  butnum:=25;
  col:=1;
  row:=4;
  placement;
end;

procedure TForm1.SpeedButton26Click(Sender: TObject);
begin
  butnum:=26;
  col:=2;
  row:=4;
  placement;
end;

procedure TForm1.SpeedButton27Click(Sender: TObject);
begin
  butnum:=27;
  col:=3;
  row:=4;
  placement;
end;

procedure TForm1.SpeedButton28Click(Sender: TObject);
begin
  butnum:=28;
  col:=4;
  row:=4;
  placement;
end;

procedure TForm1.SpeedButton29Click(Sender: TObject);
begin
  butnum:=29;
  col:=5;
  row:=4;
  placement;
end;

procedure TForm1.SpeedButton30Click(Sender: TObject);
begin
  butnum:=30;
  col:=6;
  row:=4;
  placement;
end;

procedure TForm1.SpeedButton31Click(Sender: TObject);
begin
  butnum:=31;
  col:=7;
  row:=4;
  placement;
end;

procedure TForm1.SpeedButton32Click(Sender: TObject);
begin
  butnum:=32;
  col:=8;
  row:=4;
  placement;
end;

procedure TForm1.SpeedButton33Click(Sender: TObject);
begin
  butnum:=33;
  col:=1;
  row:=5;
  placement;
end;

procedure TForm1.SpeedButton34Click(Sender: TObject);
begin
  butnum:=34;
  col:=2;
  row:=5;
  placement;
end;

procedure TForm1.SpeedButton35Click(Sender: TObject);
begin
  butnum:=35;
  col:=3;
  row:=5;
  placement;
end;

procedure TForm1.SpeedButton36Click(Sender: TObject);
begin
  butnum:=36;
  col:=4;
  row:=5;
  placement;
end;

procedure TForm1.SpeedButton37Click(Sender: TObject);
begin
  butnum:=37;
  col:=5;
  row:=5;
  placement;
end;

procedure TForm1.SpeedButton38Click(Sender: TObject);
begin
  butnum:=38;
  col:=6;
  row:=5;
  placement;
end;

procedure TForm1.SpeedButton39Click(Sender: TObject);
begin
  butnum:=39;
  col:=7;
  row:=5;
  placement;
end;

procedure TForm1.SpeedButton40Click(Sender: TObject);
begin
  butnum:=40;
  col:=8;
  row:=5;
  placement;
end;

procedure TForm1.SpeedButton41Click(Sender: TObject);
begin
  butnum:=41;
  col:=1;
  row:=6;
  placement;
end;

procedure TForm1.SpeedButton42Click(Sender: TObject);
begin
  butnum:=42;
  col:=2;
  row:=6;
  placement;
end;

procedure TForm1.SpeedButton43Click(Sender: TObject);
begin
  butnum:=43;
  col:=3;
  row:=6;
  placement;
end;

procedure TForm1.SpeedButton44Click(Sender: TObject);
begin
  butnum:=44;
  col:=4;
  row:=6;
  placement;
end;

procedure TForm1.SpeedButton45Click(Sender: TObject);
begin
  butnum:=45;
  col:=5;
  row:=6;
  placement;
end;

procedure TForm1.SpeedButton46Click(Sender: TObject);
begin
  butnum:=46;
  col:=6;
  row:=6;
  placement;
end;

procedure TForm1.SpeedButton47Click(Sender: TObject);
begin
  butnum:=47;
  col:=7;
  row:=6;
  placement;
end;

procedure TForm1.SpeedButton48Click(Sender: TObject);
begin
  butnum:=48;
  col:=8;
  row:=6;
  placement;
end;

procedure TForm1.SpeedButton49Click(Sender: TObject);
begin
  butnum:=49;
  col:=1;
  row:=7;
  placement;
end;

procedure TForm1.SpeedButton50Click(Sender: TObject);
begin
  butnum:=50;
  col:=2;
  row:=7;
  placement;
end;

procedure TForm1.SpeedButton51Click(Sender: TObject);
begin
  butnum:=51;
  col:=3;
  row:=7;
  placement;
end;

procedure TForm1.SpeedButton52Click(Sender: TObject);
begin
  butnum:=52;
  col:=4;
  row:=7;
  placement;
end;

procedure TForm1.SpeedButton53Click(Sender: TObject);
begin
  butnum:=53;
  col:=5;
  row:=7;
  placement;
end;

procedure TForm1.SpeedButton54Click(Sender: TObject);
begin
  butnum:=54;
  col:=6;
  row:=7;
  placement;
end;

procedure TForm1.SpeedButton55Click(Sender: TObject);
begin
  butnum:=55;
  col:=7;
  row:=7;
  placement;
end;

procedure TForm1.SpeedButton56Click(Sender: TObject);
begin
  butnum:=56;
  col:=8;
  row:=7;
  placement;
end;

procedure TForm1.SpeedButton57Click(Sender: TObject);
begin
  butnum:=57;
  col:=1;
  row:=8;
  placement;
end;

procedure TForm1.SpeedButton58Click(Sender: TObject);
begin
  butnum:=58;
  col:=2;
  row:=8;
  placement;
end;

procedure TForm1.SpeedButton59Click(Sender: TObject);
begin
  butnum:=59;
  col:=3;
  row:=8;
  placement;
end;

procedure TForm1.SpeedButton60Click(Sender: TObject);
begin
  butnum:=60;
  col:=4;
  row:=8;
  placement;
end;

procedure TForm1.SpeedButton61Click(Sender: TObject);
begin
  butnum:=61;
  col:=5;
  row:=8;
  placement;
end;

procedure TForm1.SpeedButton62Click(Sender: TObject);
begin
  butnum:=62;
  col:=6;
  row:=8;
  placement;
end;

procedure TForm1.SpeedButton63Click(Sender: TObject);
begin
  butnum:=63;
  col:=7;
  row:=8;
  placement;
end;

procedure TForm1.SpeedButton64Click(Sender: TObject);
begin
  butnum:=64;
  col:=8;
  row:=8;
  placement;
end;

procedure TForm1.Player1Click(Sender: TObject);
begin
  player1.visible:=false;

end;

procedure TForm1.New1Click(Sender: TObject);
var
  j,k:integer;
begin
  for j:=1 to 8 do
   for k:=1 to 8 do
     squares[j,k]:=0;
  for j:=1 to 64 do
   begin
    direction[j]:=0;
    butnum:=j;
    placegreensquare;
   end;
  // replace the white and black discs
  butnum:=28;
  placewhitesquare;
  butnum:=29;
  placeblacksquare;
  butnum:=36;
  placeblacksquare;
  butnum:=37;
  placewhitesquare;
  squares[4,4]:=1;
  squares[4,5]:=2;
  squares[5,4]:=2;
  squares[5,5]:=1;
  edit1.text:='player 1';
  player:=1;
  edit2.text:='2';
  edit3.text:='2';
end;

procedure TForm1.ExitClick(Sender: TObject);
begin
  application.terminate;
end;

end.
