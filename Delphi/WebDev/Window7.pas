unit Window7;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm10 = class(TForm)
    Image1: TImage;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form10: TForm10;

implementation

uses notepad;

{$R *.DFM}

procedure TForm10.Button2Click(Sender: TObject);
begin
  Form10.hide;
end;

function findEndBody : integer;
var
  j,ret:integer;
begin
  ret:=-1;
  for j:=0 to Form2.numLines do
   if (pos('</body>',AnsiLowerCase(Form2.Memo1.Lines[j])) > 0) then
    ret:=j;
  findEndBody:=ret;
end;

function findEndApplet : integer;
var
  j,ret:integer;
begin
  ret:=-1;
  for j:=0 to Form2.numLines do
   if (pos('</applet>',AnsiLowerCase(Form2.Memo1.Lines[j])) > 0) then
    ret:=j;
  findEndApplet:=ret;
end;

function inc(var d:integer) : integer;
begin
  d:=d+1;
  inc:=d;
end;

function findGoodPlacement : integer;
var
  j,ret:integer;
begin
  ret:=-1;
  for j:=0 to Form2.numLines do
   begin
    if (pos('<head>',AnsiLowerCase(Form2.Memo1.Lines[j])) > 0) then
     ret:=j+1;
    if (pos('<title>',AnsiLowerCase(Form2.Memo1.Lines[j])) > 0) then
     ret:=j+1;
    if (pos('<meta',AnsiLowerCase(Form2.Memo1.Lines[j])) > 0) then
     ret:=j+1;
   end;
  findGoodPlacement:=ret;
end;

procedure TForm10.Button1Click(Sender: TObject);
var
  line:integer;
  str:string;
begin
  line:=findEndBody;
  Form2.Memo1.Lines.insert(line,'</APPLET>');
  Form2.Memo1.Lines.insert(line,'<PARAM NAME="shadow" VALUE="'+ComboBox3.text+'">');
  Form2.Memo1.Lines.insert(line,'<PARAM NAME="wbgcolor" VALUE="'+ComboBox4.text+'">');
  Form2.Memo1.Lines.insert(line,'<PARAM NAME="facecolor" VALUE="'+ComboBox1.text+'">');
  Form2.Memo1.Lines.insert(line,'<PARAM NAME="cbgcolor" VALUE="'+ComboBox2.text+'">');
  str:='<APPLET NAME="clock" CODE=Clock.class CODEBASE="http://..." HEIGHT=180 WIDTH=330';
  if (CheckBox2.checked) then
    str:=str+' MAYSCRIPT';
  str:=str+'>';
  Form2.Memo1.Lines.insert(line,str);
  if (CheckBox1.checked) then
   begin
    line:=findEndApplet;
    Form2.Memo1.Lines.insert(line,'<!--  if browser does not support Java -->');
    inc(line);
    Form2.Memo1.Lines.insert(line,'<FORM NAME="Timeform">');
    inc(line);
    Form2.Memo1.Lines.insert(line,'<BR><BR><BR><BR>');
    inc(line);
    Form2.Memo1.Lines.insert(line,'<FONT COLOR=RED SIZE=+1>');
    inc(line);
    Form2.Memo1.Lines.insert(line,'<CENTER>');
    inc(line);
    Form2.Memo1.Lines.insert(line,'Your Browser Does not support Java<BR>');
    inc(line);
    Form2.Memo1.Lines.insert(line,'</FONT>');
    inc(line);
    Form2.Memo1.Lines.insert(line,'<INPUT TYPE=text SIZE=50 MAXLENGTH=50 NAME="Timeofday"></CENTER>');
    inc(line);
    Form2.Memo1.Lines.insert(line,'</FORM>');
    inc(line);
    Form2.Memo1.Lines.insert(line,'<BR><BR><BR><BR>');
    inc(line);
    Form2.Memo1.Lines.insert(line,'<SCRIPT LANGUAGE="JavaScript">');
    inc(line);
    Form2.Memo1.Lines.insert(line,'<!--');
    inc(line);
    Form2.Memo1.Lines.insert(line,'dailytime();');
    inc(line);
    Form2.Memo1.Lines.insert(line,'function dailytime() {');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	var tod = new Date()');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	tod.getTime()');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	document.Timeform.Timeofday.value = tod.toString()');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	timerID = setTimeout("dailytime()",1000)');
    inc(line);
    Form2.Memo1.Lines.insert(line,'}');
    inc(line);
    Form2.Memo1.Lines.insert(line,'// -->');
    inc(line);
    Form2.Memo1.Lines.insert(line,'</SCRIPT>');
   end;
  if (CheckBox2.checked) then
   begin
    line:=findGoodPlacement;
    Form2.Memo1.Lines.insert(line,'<SCRIPT LANGUAGE="JavaScript">');
    inc(line);
    Form2.Memo1.Lines.insert(line,'<!--');
    inc(line);
    Form2.Memo1.Lines.insert(line,'var changeFace = false;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'var changeCBG = false;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'var changeWBG = false;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'var changeShad = false;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'var expdate = new Date ();');
    inc(line);
    Form2.Memo1.Lines.insert(line,'expdate.setTime (expdate.getTime() + (7200 * 60 * 60 * 1000));');
    inc(line);
    Form2.Memo1.Lines.insert(line,'function getCookieVal(offset) {');
    inc(line);
    Form2.Memo1.Lines.insert(line,'  var endstr = document.cookie.indexOf (";", offset);');
    inc(line);
    Form2.Memo1.Lines.insert(line,'  if (endstr == -1)');
    inc(line);
    Form2.Memo1.Lines.insert(line,'    endstr = document.cookie.length;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'  return unescape(document.cookie.substring(offset, endstr));');
    inc(line);
    Form2.Memo1.Lines.insert(line,'}');
    inc(line);
    Form2.Memo1.Lines.insert(line,'function GetCookie(name) {');
    inc(line);
    Form2.Memo1.Lines.insert(line,'  var arg = name + "=";');
    inc(line);
    Form2.Memo1.Lines.insert(line,'  var alen = arg.length;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'  var clen = document.cookie.length;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'  var i = 0;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'  while (i < clen) {');
    inc(line);
    Form2.Memo1.Lines.insert(line,'    var j = i + alen;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'    if (document.cookie.substring(i, j) == arg)');
    inc(line);
    Form2.Memo1.Lines.insert(line,'      return getCookieVal(j);');
    inc(line);
    Form2.Memo1.Lines.insert(line,'    i = document.cookie.indexOf(" ", i) + 1;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'    if (i == 0) break;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'  }');
    inc(line);
    Form2.Memo1.Lines.insert(line,'  return null;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'}');
    inc(line);
    Form2.Memo1.Lines.insert(line,'function SetCookie(name,value,expires,path,domain,secure) {');
    inc(line);
    Form2.Memo1.Lines.insert(line,'  document.cookie = name + "=" + escape (value) +');
    inc(line);
    Form2.Memo1.Lines.insert(line,'    ((expires) ? "; expires=" + expires.toGMTString() : "") +');
    inc(line);
    Form2.Memo1.Lines.insert(line,'    ((path) ? "; path=" + path : "") +');
    inc(line);
    Form2.Memo1.Lines.insert(line,'    ((domain) ? "; domain=" + domain : "") +');
    inc(line);
    Form2.Memo1.Lines.insert(line,'    ((secure) ? "; secure" : "");');
    inc(line);
    Form2.Memo1.Lines.insert(line,'}');
    inc(line);
    Form2.Memo1.Lines.insert(line,'function saveValues() {');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	var loc;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	if (changeShad) {');
    inc(line);
    Form2.Memo1.Lines.insert(line,'		loc = document.fm.shadowColor.selectedIndex;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'		SetCookie("shadc",document.fm.shadowColor[loc].value,expdate);');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	}');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	if (changeCBG) {');
    inc(line);
    Form2.Memo1.Lines.insert(line,'		loc = document.fm.cBGColor.selectedIndex;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'		SetCookie("cbgc",document.fm.cBGColor[loc].value,expdate);');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	}');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	if (changeFace) {');
    inc(line);
    Form2.Memo1.Lines.insert(line,'		loc = document.fm.faceColor.selectedIndex;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'		SetCookie("facec",document.fm.faceColor[loc].value,expdate);');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	}');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	if (changeWBG) {');
    inc(line);
    Form2.Memo1.Lines.insert(line,'		loc = document.fm.winBGColor.selectedIndex;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'		SetCookie("winbgc",document.fm.winBGColor[loc].value,expdate);');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	}');
    inc(line);
    Form2.Memo1.Lines.insert(line,'}');
    inc(line);
    Form2.Memo1.Lines.insert(line,'function getValues() {');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	var str;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	str = GetCookie("cbgc");');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	if (str != null)');
    inc(line);
    Form2.Memo1.Lines.insert(line,'		reDrawCBGColor(str);');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	str = GetCookie("shadc");');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	if (str != null)');
    inc(line);
    Form2.Memo1.Lines.insert(line,'		reDrawShadow(str);');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	str = GetCookie("facec");');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	if (str != null)');
    inc(line);
    Form2.Memo1.Lines.insert(line,'		reDrawFace(str);');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	str = GetCookie("winbgc");');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	if (str != null)');
    inc(line);
    Form2.Memo1.Lines.insert(line,'		reDrawWinBGColor(str);');
    inc(line);
    Form2.Memo1.Lines.insert(line,'}');
    inc(line);
    Form2.Memo1.Lines.insert(line,'function update() {');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	document.clock.offScreenImage();');
    inc(line);
    Form2.Memo1.Lines.insert(line,'}');
    inc(line);
    Form2.Memo1.Lines.insert(line,'function reDrawShadow(str) {');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	changeShad = true;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	document.clock.stop()');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	document.clock.shad = str;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	update();');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	document.clock.start()');
    inc(line);
    Form2.Memo1.Lines.insert(line,'}');
    inc(line);
    Form2.Memo1.Lines.insert(line,'function reDrawFace(str) {');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	changeFace = true;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	document.clock.stop()');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	document.clock.cfc = str;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	update();');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	document.clock.start()');
    inc(line);
    Form2.Memo1.Lines.insert(line,'}');
    inc(line);
    Form2.Memo1.Lines.insert(line,'function reDrawWinBGColor(str) {');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	changeWBG = true;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	document.clock.stop()');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	document.clock.wbgc = str;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	document.bgcolor = str;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	update();');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	document.clock.start()');
    inc(line);
    Form2.Memo1.Lines.insert(line,'}');
    inc(line);
    Form2.Memo1.Lines.insert(line,'function reDrawCBGColor(str) {');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	changeCBG = true;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	document.clock.stop()');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	document.clock.cbgc = str;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	update();');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	document.clock.start()');
    inc(line);
    Form2.Memo1.Lines.insert(line,'}');
    inc(line);
    Form2.Memo1.Lines.insert(line,'function resetValues() {');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	changeShad = true;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	changeFace = true;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	changeWBG = true;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	changeCBG = true;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	document.clock.stop()');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	var loc = document.fm.winBGColor.selectedIndex;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	document.clock.shad = "dark gray";');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	document.clock.cfc = "black";');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	document.clock.wbgc = document.fm.winBGColor[loc].value;');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	document.clock.cbgc = "white";');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	document.clock.start()');
    inc(line);
    Form2.Memo1.Lines.insert(line,'}');
    inc(line);
    Form2.Memo1.Lines.insert(line,'function stopClock() {');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	document.clock.stop()');
    inc(line);
    Form2.Memo1.Lines.insert(line,'}');
    inc(line);
    Form2.Memo1.Lines.insert(line,'function startClock() {');
    inc(line);
    Form2.Memo1.Lines.insert(line,'	document.clock.start()');
    inc(line);
    Form2.Memo1.Lines.insert(line,'}');
    inc(line);
    Form2.Memo1.Lines.insert(line,'// -->');
    inc(line);
    Form2.Memo1.Lines.insert(line,'</SCRIPT>');
    inc(line);
   end;
  if (CheckBox2.checked) then
   begin
    line:=findEndApplet;
    Form2.Memo1.Lines.insert(line,'<FORM NAME=fm>');inc(line);
    Form2.Memo1.Lines.insert(line,'<TABLE ALIGN=right BORDER=0>');inc(line);
    Form2.Memo1.Lines.insert(line,'');inc(line);
    Form2.Memo1.Lines.insert(line,'<!--  #1  -->');inc(line);
    Form2.Memo1.Lines.insert(line,'<TR>');inc(line);
    Form2.Memo1.Lines.insert(line,'<TD><INPUT TYPE=button VALUE="Start Clock" onClick="startClock()"></TD>');inc(line);
    Form2.Memo1.Lines.insert(line,'<TD>&nbsp;</TD>');inc(line);
    Form2.Memo1.Lines.insert(line,'<TD BGCOLOR=black><CENTER><FONT COLOR=white SIZE=+1>Shadow Color</FONT></CENTER></TD>'');inc(line); ');inc(line);
    Form2.Memo1.Lines.insert(line,'<TD>&nbsp;</TD>');inc(line);
    Form2.Memo1.Lines.insert(line,'<TD BGCOLOR=black><CENTER><FONT COLOR=red SIZE=+1>Clock Face Color</FONT></CENTER></TD></TR>');inc(line);
    Form2.Memo1.Lines.insert(line,'');inc(line);
    Form2.Memo1.Lines.insert(line,'<TR>');inc(line);
    Form2.Memo1.Lines.insert(line,'<TD><INPUT TYPE=button VALUE="Stop Clock" onClick="stopClock()"></TD>');inc(line);
    Form2.Memo1.Lines.insert(line,'<TD>&nbsp;</TD>');inc(line);
    Form2.Memo1.Lines.insert(line,'</TD>');inc(line);
    Form2.Memo1.Lines.insert(line,'<TD><CENTER>');inc(line);
    Form2.Memo1.Lines.insert(line,'<SELECT NAME="shadowColor" SIZE=1 onChange="reDrawShadow(document.fm.shadowColor[document.fm.shadowColor.selectedIndex].value)">');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="dark gray">Dark Gray</OPTION>	');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="white">White</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="black">Black</OPTION>	');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="light gray">Light Gray</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="green">Green</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="blue">Blue</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="red">Red</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="purple">Purple</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="pink">Pink</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="yellow">Yellow</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="light blue">Light Blue</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="orange">Orange</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'</SELECT></CENTER></TD>');inc(line);
    Form2.Memo1.Lines.insert(line,'<TD>&nbsp;</TD>');inc(line);
    Form2.Memo1.Lines.insert(line,'<TD><CENTER>');inc(line);
    Form2.Memo1.Lines.insert(line,'<SELECT NAME="faceColor" SIZE=1 onChange="reDrawFace(document.fm.faceColor[document.fm.faceColor.selectedIndex].value)">');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="black">Black</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="blue">Blue</OPTION>	');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="white">White</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="light gray">Light Gray</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="dark gray">Dark Gray</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="green">Green</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="red">Red</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="purple">Purple</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="pink">Pink</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="yellow">Yellow</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="light blue">Light Blue</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="orange">Orange</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'</SELECT></CENTER></TD>');inc(line);
    Form2.Memo1.Lines.insert(line,'</TR>');inc(line);
    Form2.Memo1.Lines.insert(line,'');inc(line);
    Form2.Memo1.Lines.insert(line,'<!--  #2  -->');inc(line);
    Form2.Memo1.Lines.insert(line,'<TR>');inc(line);
    Form2.Memo1.Lines.insert(line,'<TD><INPUT TYPE=button VALUE="Reset All Values" onClick="resetValues()"></TD>');inc(line);
    Form2.Memo1.Lines.insert(line,'<TD>&nbsp;</TD>');inc(line);
    Form2.Memo1.Lines.insert(line,'<TD BGCOLOR=black><CENTER><FONT COLOR=green SIZE=+1>Window BackGround Color</FONT></CENTER></TD>');inc(line);
    Form2.Memo1.Lines.insert(line,'<TD>&nbsp;</TD>');inc(line);
    Form2.Memo1.Lines.insert(line,'<TD BGCOLOR=black><CENTER><FONT COLOR="#7B68EE" SIZE=+1>Clock BackGround Color</FONT></CENTER></TD>');inc(line);
    Form2.Memo1.Lines.insert(line,'</TR>');inc(line);
    Form2.Memo1.Lines.insert(line,'');inc(line);
    Form2.Memo1.Lines.insert(line,'<TR>');inc(line);
    Form2.Memo1.Lines.insert(line,'<TD><INPUT TYPE=button VALUE="Save Values" onClick="saveValues()"></TD>');inc(line);
    Form2.Memo1.Lines.insert(line,'<TD>&nbsp;</TD>');inc(line);
    Form2.Memo1.Lines.insert(line,'<TD><CENTER>');inc(line);
    Form2.Memo1.Lines.insert(line,'<SELECT NAME="winBGColor" SIZE=1 onChange="reDrawWinBGColor(document.fm.winBGColor[document.fm.winBGColor.selectedIndex].value)">');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="black">Black</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="white">White</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="light gray">Light Gray</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="dark gray">Dark Gray</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="green">Green</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="blue">Blue</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="red">Red</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="purple">Purple</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="pink">Pink</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="yellow">Yellow</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="light blue">Light Blue</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="orange">Orange</OPTION>	');inc(line);
    Form2.Memo1.Lines.insert(line,'</SELECT></CENTER></TD><TD>&nbsp;&nbsp;&nbsp;</TD>');inc(line);
    Form2.Memo1.Lines.insert(line,'<TD><CENTER>');inc(line);
    Form2.Memo1.Lines.insert(line,'<SELECT NAME="cBGColor" SIZE=1 onChange="reDrawCBGColor(document.fm.cBGColor[document.fm.cBGColor.selectedIndex].value)">');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="white">White</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'<OPTION VALUE="red">Red</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="black">Black</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="light gray">Light Gray</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="dark gray">Dark Gray</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="green">Green</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="blue">Blue</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="purple">Purple</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="pink">Pink</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="yellow">Yellow</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="light blue">Light Blue</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'	<OPTION VALUE="orange">Orange</OPTION>');inc(line);
    Form2.Memo1.Lines.insert(line,'</SELECT></CENTER></TD></TR>');inc(line);
    Form2.Memo1.Lines.insert(line,'</TABLE>');inc(line);
    Form2.Memo1.Lines.insert(line,'</FORM>');inc(line);
   end;

  Form10.hide;
end;

procedure TForm10.Button3Click(Sender: TObject);
begin
  showMessage('Don''t we all need HELP!');
end;

end.
