unit Window3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Spin, ComCtrls, Tabnotbk, Buttons;

type
  TForm5 = class(TForm)
    TabbedNotebook1: TTabbedNotebook;
    CheckBox8: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    ComboBox2: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    Label17: TLabel;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Label18: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Button1: TButton;
    Bevel2: TBevel;
    CheckBox13: TCheckBox;
    Label19: TLabel;
    Edit2: TEdit;
    ScrollBox1: TScrollBox;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    SpeedButton2: TSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    SpeedButton3: TSpeedButton;
    Label7: TLabel;
    Label8: TLabel;
    SpeedButton4: TSpeedButton;
    Label9: TLabel;
    Label10: TLabel;
    SpeedButton5: TSpeedButton;
    Label11: TLabel;
    Label12: TLabel;
    SpeedButton6: TSpeedButton;
    Label13: TLabel;
    Label14: TLabel;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    Label15: TLabel;
    Label16: TLabel;
    Label20: TLabel;
    OpenDialog1: TOpenDialog;
    ColorDialog1: TColorDialog;
    FontDialog1: TFontDialog;
    Button2: TButton;
    Edit4: TEdit;
    Edit3: TEdit;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Bevel3: TBevel;
    Button6: TButton;
    Button7: TButton;
    Bevel4: TBevel;
    Label21: TLabel;
    Edit5: TEdit;
    Label22: TLabel;
    ComboBox3: TComboBox;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    CheckBox1: TCheckBox;
    Label23: TLabel;
    Label24: TLabel;
    Edit8: TEdit;
    Label25: TLabel;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Bevel5: TBevel;
    CheckBox14: TCheckBox;
    Edit9: TEdit;
    Label26: TLabel;
    Button15: TButton;
    Edit10: TEdit;
    Edit11: TEdit;
    Label27: TLabel;
    Label28: TLabel;
    CheckBox15: TCheckBox;
    Button16: TButton;
    Label29: TLabel;
    Edit12: TEdit;
    ComboBox4: TComboBox;
    Label30: TLabel;
    Label31: TLabel;
    Edit13: TEdit;
    Label32: TLabel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    Edit14: TEdit;
    Edit15: TEdit;
    Label33: TLabel;
    Edit6: TEdit;
    ComboBox5: TComboBox;
    Label34: TLabel;
    Label35: TLabel;
    Edit7: TEdit;
    Button17: TButton;
    Button18: TButton;
    CheckBox16: TCheckBox;
    Button19: TButton;
    ScrollBox2: TScrollBox;
    RadioGroup1: TRadioGroup;
    RadioButton6: TRadioButton;
    RadioGroup2: TRadioGroup;
    RadioButton7: TRadioButton;
    RadioGroup3: TRadioGroup;
    RadioButton8: TRadioButton;
    Bevel8: TBevel;
    Label36: TLabel;
    Label37: TLabel;
    Edit16: TEdit;
    ComboBox6: TComboBox;
    Edit17: TEdit;
    Button20: TButton;
    Button21: TButton;
    RadioGroup4: TRadioGroup;
    RadioButton9: TRadioButton;
    RadioGroup5: TRadioGroup;
    RadioButton10: TRadioButton;
    Label38: TLabel;
    Edit18: TEdit;
    Edit19: TEdit;
    Label39: TLabel;
    Label40: TLabel;
    Bevel9: TBevel;
    Label41: TLabel;
    ComboBox7: TComboBox;
    Label42: TLabel;
    Edit20: TEdit;
    RadioButton11: TRadioButton;
    RadioButton12: TRadioButton;
    Button22: TButton;
    Button23: TButton;
    Button24: TButton;
    Label43: TLabel;
    Edit21: TEdit;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure CheckBox13Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure ComboBox2Exit(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure CheckBox15Click(Sender: TObject);
    procedure CheckBox14Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure RadioButton5Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure RadioGroup3Click(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure RadioGroup4Click(Sender: TObject);
    procedure RadioGroup5Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure RadioButton8Click(Sender: TObject);
    procedure RadioButton7Click(Sender: TObject);
    procedure RadioButton6Click(Sender: TObject);
    procedure RadioButton9Click(Sender: TObject);
    procedure RadioButton10Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure ComboBox7Change(Sender: TObject);
    procedure RadioButton11Click(Sender: TObject);
    procedure RadioButton12Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure ComboBox7Exit(Sender: TObject);
    procedure Button24Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses notepad, window1, Window5, Banner, Window6, Window7, window11;

{$R *.DFM}

function con(str:String) : String;
var
  r,g,b:String;
begin
  b:=str[1]+str[2];
  g:=str[3]+str[4];
  r:=str[5]+str[6];
  con:=r+g+b;
end;

const
  MAXLINES=8;

procedure header;
begin
  //Form2.numLines:=0;
  Form2.Memo1.SelectAll;
  Form2.Memo1.cutToClipboard;
  Form2.Memo1.Lines.Add('<HTML>');
  Form2.Memo1.Lines.Add('<HEAD>');
  //Form2.numLines:=Form2.numLines+2;
end;

procedure footer;
begin
  Form2.Memo1.Lines.Add('</HEAD>');
  Form2.Memo1.Lines.Add('</HTML>');
  //Form2.numLines:=Form2.numLines+2;
end;

procedure TForm5.SpeedButton1Click(Sender: TObject);
begin
  header;
  Form2.Memo1.Lines.Add('<FRAMESET COLS="35%,*">');
  Form2.Memo1.Lines.Add('          <FRAME NAME=navBar SRC="Untitled1.htm">');
  Form2.Memo1.Lines.Add('          <FRAMESET ROWS="35%,*">');
  Form2.Memo1.Lines.Add('                    <FRAME NAME=headerFrame SRC="Untitled2.htm">');
  Form2.Memo1.Lines.Add('                    <FRAME NAME=mainFrame SRC="Untitled3.htm">');
  Form2.Memo1.Lines.Add('          </FRAMESET>');
  Form2.Memo1.Lines.Add('<NOFRAME>Your Browser Does Not Support Frames</NOFRAME>');
  Form2.Memo1.Lines.Add('</FRAMESET>');
  footer;
  //Form2.numLines:=Form2.numLines+8;
end;

procedure TForm5.SpeedButton2Click(Sender: TObject);
begin
  header;
  Form2.Memo1.Lines.Add('<FRAMESET COLS="*,*">');
  Form2.Memo1.Lines.Add('          <FRAME NAME=leftFrame SRC="Untitled2.htm">');
  Form2.Memo1.Lines.Add('          <FRAME NAME=rightFrame SRC="Untitled3.htm">');
  Form2.Memo1.Lines.Add('<NOFRAME>Your Browser Does Not Support Frames</NOFRAME>');
  Form2.Memo1.Lines.Add('</FRAMESET>');
  footer;
  //Form2.numLines:=Form2.numLines+5;
end;

procedure TForm5.SpeedButton3Click(Sender: TObject);
begin
  header;
  Form2.Memo1.Lines.Add('<FRAMESET ROWS="*,*">');
  Form2.Memo1.Lines.Add('          <FRAME NAME=topFrame SRC="Untitled2.htm">');
  Form2.Memo1.Lines.Add('          <FRAME NAME=bottomFrame SRC="Untitled3.htm">');
  Form2.Memo1.Lines.Add('<NOFRAME>Your Browser Does Not Support Frames</NOFRAME>');
  Form2.Memo1.Lines.Add('</FRAMESET>');
  footer;
  //Form2.numLines:=Form2.numLines+5;
end;

procedure TForm5.SpeedButton4Click(Sender: TObject);
begin
  header;
  Form2.Memo1.Lines.Add('<FRAMESET COLS="35%,*">');
  Form2.Memo1.Lines.Add('          <FRAME NAME=navBar SRC="Untitled1.htm">');
  Form2.Memo1.Lines.Add('          <FRAMESET ROWS="*,35%">');
  Form2.Memo1.Lines.Add('                    <FRAME NAME=mainFrame SRC="Untitled2.htm">');
  Form2.Memo1.Lines.Add('                    <FRAME NAME=headerFrame SRC="Untitled3.htm">');
  Form2.Memo1.Lines.Add('          </FRAMESET>');
  Form2.Memo1.Lines.Add('<NOFRAME>Your Browser Does Not Support Frames</NOFRAME>');
  Form2.Memo1.Lines.Add('</FRAMESET>');
  footer;
  //Form2.numLines:=Form2.numLines+8;
end;

procedure TForm5.SpeedButton5Click(Sender: TObject);
begin
  header;
  Form2.Memo1.Lines.Add('<FRAMESET COLS="35%,*">');
  Form2.Memo1.Lines.Add('          <FRAME NAME=navBar SRC="Untitled2.htm">');
  Form2.Memo1.Lines.Add('          <FRAME NAME=mainFrame SRC="Untitled3.htm">');
  Form2.Memo1.Lines.Add('<NOFRAME>Your Browser Does Not Support Frames</NOFRAME>');
  Form2.Memo1.Lines.Add('</FRAMESET>');
  footer;
  //Form2.numLines:=Form2.numLines+5;
end;

procedure TForm5.SpeedButton7Click(Sender: TObject);
begin
  header;
  Form2.Memo1.Lines.Add('<FRAMESET ROWS="*,35%">');
  Form2.Memo1.Lines.Add('          <FRAME NAME=mainBar SRC="Untitled2.htm">');
  Form2.Memo1.Lines.Add('          <FRAME NAME=footFrame SRC="Untitled3.htm">');
  Form2.Memo1.Lines.Add('<NOFRAME>Your Browser Does Not Support Frames</NOFRAME>');
  Form2.Memo1.Lines.Add('</FRAMESET>');
  footer;
  //Form2.numLines:=Form2.numLines+5;
end;

procedure TForm5.SpeedButton8Click(Sender: TObject);
begin
  header;
  Form2.Memo1.Lines.Add('<FRAMESET ROWS="35%,*">');
  Form2.Memo1.Lines.Add('          <FRAME NAME=headBar SRC="Untitled2.htm">');
  Form2.Memo1.Lines.Add('          <FRAME NAME=mainFrame SRC="Untitled3.htm">');
  Form2.Memo1.Lines.Add('<NOFRAME>Your Browser Does Not Support Frames</NOFRAME>');
  Form2.Memo1.Lines.Add('</FRAMESET>');
  footer;
  //Form2.numLines:=Form2.numLines+5;
end;

procedure TForm5.SpeedButton6Click(Sender: TObject);
begin
  header;
  Form2.Memo1.Lines.Add('<FRAMESET COLS="*,*">');
  Form2.Memo1.Lines.Add('          <FRAMESET ROWS="*,*">');
  Form2.Memo1.Lines.Add('                    <FRAME NAME=topLeftFrame SRC="Untitled1.htm">');
  Form2.Memo1.Lines.Add('                    <FRAME NAME=bottomLeftFrame SRC="Untitled2.htm">');
  Form2.Memo1.Lines.Add('          </FRAMESET>');
  Form2.Memo1.Lines.Add('          <FRAMESET ROWS="*,*">');
  Form2.Memo1.Lines.Add('                    <FRAME NAME=topRightFrame SRC="Untitled3.htm">');
  Form2.Memo1.Lines.Add('                    <FRAME NAME=bottomRightFrame SRC="Untitled4.htm">');
  Form2.Memo1.Lines.Add('          </FRAMESET>');
  Form2.Memo1.Lines.Add('<NOFRAME>Your Browser Does Not Support Frames</NOFRAME>');
  Form2.Memo1.Lines.Add('</FRAMESET>');
  footer;
  //Form2.numLines:=Form2.numLines+11;
end;

procedure TForm5.RadioButton2Click(Sender: TObject);
begin
  Button1.visible:=true;
  Edit1.text:='';
end;

procedure TForm5.RadioButton1Click(Sender: TObject);
begin
  Edit1.text:='http://';
  Button1.visible:=false;
end;

procedure TForm5.RadioButton3Click(Sender: TObject);
begin
  Edit1.text:='mailto:';
  Button1.visible:=false;
end;

procedure TForm5.CheckBox13Click(Sender: TObject);
begin
  if (CheckBox13.checked) then
   begin
    label19.enabled:=true;
    edit2.enabled:=true;
   end
  else
   begin
    label19.enabled:=false;
    edit2.enabled:=false;
   end;
end;

procedure TForm5.Button1Click(Sender: TObject);
begin
  OpenDialog1.FileName:= '*.*';
  if (OpenDialog1.Execute) then
     Edit1.text:=OpenDialog1.FileName;
end;

procedure TForm5.ComboBox2Change(Sender: TObject);
begin
if (ComboBox2.text = 'Custom') then
   if (ColorDialog1.Execute) then
    ComboBox2.text:=con(intToHex(ColorToRGB(ColorDialog1.Color),6));
end;

procedure TForm5.Button2Click(Sender: TObject);
begin
  FontDialog1.Font:=Edit4.Font;
  if (FontDialog1.Execute) then
   begin
    Edit4.text:=FontDialog1.Font.Name;
    Edit3.text:=intToStr(FontDialog1.Font.Size);
    ComboBox2.text:=intToHex(ColorToRGB(FontDialog1.Font.Color),6);
   end;
end;

procedure TForm5.Button5Click(Sender: TObject);
begin
  CheckBox2.checked:=false;
  CheckBox3.checked:=false;
  CheckBox4.checked:=false;
  CheckBox5.checked:=false;
  CheckBox6.checked:=false;
  CheckBox7.checked:=false;
  CheckBox8.checked:=false;
  CheckBox9.checked:=false;
  CheckBox10.checked:=false;
  CheckBox11.checked:=false;
  CheckBox12.checked:=false;
  CheckBox13.checked:=false;
  ComboBox1.text:='Normal';
  ComboBox2.text:='Default';
  ComboBox3.text:='Default';
  Edit3.text:='';
  Edit4.text:='';
end;

procedure TForm5.Button3Click(Sender: TObject);
begin
  Form5.hide;
end;

procedure TForm5.Button7Click(Sender: TObject);
begin
  RadioButton1.checked:=true;
  Edit1.text:='http://';
  Edit5.text:='';
  Edit2.text:='';
  CheckBox13.checked:=false;
  Label19.enabled:=false;
  Edit2.enabled:=false;
  Button1.visible:=false;
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

procedure TForm5.Button6Click(Sender: TObject);
var
  line:integer;
  additional:string;
begin
  additional:='';
  line:=findEndBody;
  if (line <> -1) then
   begin
    if (CheckBox13.checked) then
     additional:=' TARGET="'+Edit2.text+'"';
    Form2.Memo1.Lines.insert(line,'<A'+additional+' HREF="'+Edit1.text+'">'+Edit5.text+'</A>');
    //Form2.numLines:=Form2.numLines+1;
   end;
end;

procedure TForm5.Button4Click(Sender: TObject);
var
  start,finish,fontStart:string;
  line:integer;
begin
  start:='';
  finish:='';
  fontStart:='';
  if (CheckBox10.checked) then
   begin
     start:=start+'<CITE>';
     finish:='</CITE>'+finish;
   end;
  if (CheckBox8.checked) then
   begin
     start:=start+'<CODE>';
     finish:='</CODE>'+finish;
   end;
  if (CheckBox5.checked) then
   begin
     start:=start+'<BLINK>';
     finish:='</BLINK>'+finish;
   end;
  if (CheckBox6.checked) then
   begin
     start:=start+'<B>';
     finish:='</B>'+finish;
   end;
  if (CheckBox2.checked) then
   begin
     start:=start+'<U>';
     finish:='</U>'+finish;
   end;
  if (CheckBox4.checked) then
   begin
     start:=start+'<TT>';
     finish:='</TT>'+finish;
   end;
  if (CheckBox9.checked) then
   begin
     start:=start+'<SAMP>';
     finish:='</SAMP>'+finish;
   end;
  if (CheckBox7.checked) then
   begin
     start:=start+'<I>';
     finish:='</I>'+finish;
   end;
  if (CheckBox11.checked) then
   begin
     start:=start+'<VAR>';
     finish:='</VAR>'+finish;
   end;
  if (CheckBox12.checked) then
   begin
     start:=start+'<DFN>';
     finish:='</DFN>'+finish;
   end;
  if (CheckBox3.checked) then
   begin
     start:=start+'<STRIKE>';
     finish:='</STRIKE>'+finish;
   end;
  //Vertical position
  if (ComboBox1.text = 'SuperScript') then
   begin
       start:=start+'<SUP>';
       finish:='</SUP>'+finish;
   end;
   if (ComboBox1.text = 'SubScript') then
    begin
     start:=start+'<SUB>';
     finish:='</SUB>'+finish;
    end;
  //horizontal position
  if (ComboBox3.text = 'Center') then
   begin
    start:=start+'<CENTER>';
    finish:='</CENTER>'+finish;
   end;
  if (ComboBox3.text = 'Left') then
   start:=start+'<P ALIGN=left>';
  if (ComboBox3.text = 'Right') then
   start:=start+'<P ALIGN=right>';
  //write start part
  if (start <> '') then
   begin
    line:=findEndBody;
    Form2.Memo1.lines.insert(line,start);
   end;
  //font
  if (Edit4.text <> '') then
   begin
    fontStart:=fontStart+'<FONT FACE="'+Edit4.text+'"';
    if (Edit3.text <> '') then
      fontStart:=fontStart+' SIZE='+Edit3.text;
    if (ComboBox2.text <> 'Default') then
      fontStart:=FontStart+' COLOR="'+ComboBox2.text+'"';
    fontStart:=fontStart+'>';
    line:=findEndBody;
    Form2.Memo1.lines.insert(line,fontStart);
   end;
  //write to place
  if (start <> '') or (fontStart <> '') then
   begin
    line:=findEndBody;
    Form2.Memo1.lines.insert(line,'');
   end;
  if (fontStart <> '') then
   begin
    line:=findEndBody;
    Form2.Memo1.lines.insert(line,'</FONT>');
   end;
  if (finish <> '') then
   begin
     line:=findEndBody;
     Form2.Memo1.lines.insert(line,finish);
   end;
end;

procedure TForm5.Button8Click(Sender: TObject);
var
  line:integer;
begin
  line:=findEndBody;
  Form2.Memo1.lines.insert(line,'<BR>');
  //Form2.numLines:=Form2.numLines+1;
end;

procedure TForm5.Button9Click(Sender: TObject);
var
  line:integer;
begin
  line:=findEndBody;
  Form2.Memo1.lines.insert(line,'<HR>');
  //Form2.numLines:=Form2.numLines+1;
end;

procedure TForm5.ComboBox2Exit(Sender: TObject);
begin
  if (ComboBox2.text = 'Custom') then
   ComboBox2.text:=intToHex(ColorToRGB(ColorDialog1.Color),6);
end;

procedure TForm5.Button10Click(Sender: TObject);
var
  line:integer;
begin
  line:=findEndBody;
  Form2.Memo1.lines.insert(line,'<!--    -->');
end;

procedure TForm5.Button15Click(Sender: TObject);
begin
  OpenDialog1.FileName:='*.class';
  if (OpenDialog1.execute) then
    Edit9.text:=OpenDialog1.FileName;
end;

procedure clearIt;
begin

end;

procedure TForm5.Button16Click(Sender: TObject);
var
  line:integer;
  str:string;
begin
  if (Edit9.text <> '') and (Edit10.text <> '') and (Edit11.text <> '') then
   begin
    line:=findEndBody;
    if (ComboBox4.text <> 'Default') then
      if (ComboBox4.text = 'Center') then
        Form2.Memo1.Lines.insert(line,'<CENTER>')
       else
        Form2.Memo1.Lines.insert(line,'<P ALIGN="'+ComboBox4.text+'">');
    line:=findEndBody;
    str:='<APPLET ';
    if (Edit12.text <> '') then
     str:=str+' CODEBASE="'+Edit12.text+'"';
    str:=str+' CODE="'+Edit9.text+'" HEIGHT='+Edit10.text+' WIDTH='+Edit11.text;
    if (CheckBox15.checked) then
     str:=str+' NAME="'+Edit13.text+'" MAYSCRIPT';
    str:=str+'>';
    Form2.Memo1.Lines.insert(line,str);
    Form2.Memo1.Lines.insert(line+1,'</APPLET>');
    if (ComboBox4.text <> 'Default') then
      if (ComboBox4.text = 'Center') then
        Form2.Memo1.Lines.insert(line,'</CENTER>');
    Edit9.text:='';
    Edit10.text:='';
    Edit11.text:='';
    Edit12.text:='';
    Edit13.text:='';
    ComboBox4.text:='Default';
    CheckBox15.checked:=false;
    CheckBox16.checked:=false;
    if (CheckBox16.checked) then
     Form7.show;
  end;
end;

procedure TForm5.CheckBox15Click(Sender: TObject);
begin
  if (CheckBox15.checked) then
   begin
    Label31.Enabled:=true;
    Edit13.Enabled:=true;
   end
  else
   begin
    Label31.Enabled:=false;
    Edit13.Enabled:=false;
   end
end;

procedure TForm5.CheckBox14Click(Sender: TObject);
begin
  if (CheckBox14.checked) then
     begin
     Label26.Enabled:=true;
     Label27.Enabled:=true;
     Label28.Enabled:=true;
     Label29.Enabled:=true;
     Label30.Enabled:=true;
     Edit9.Enabled:=true;
     Edit10.Enabled:=true;
     Edit11.Enabled:=true;
     Edit12.Enabled:=true;
     Button15.Enabled:=true;
     Button16.Enabled:=true;
     Button19.Enabled:=true;
     ComboBox4.Enabled:=true;
     CheckBox15.Enabled:=true;
     CheckBox16.Enabled:=true;
   end
  else
   begin
     Label26.Enabled:=false;
     Label27.Enabled:=false;
     Label28.Enabled:=false;
     Label29.Enabled:=false;
     Label30.Enabled:=false;
     Label31.Enabled:=false;
     Edit9.Enabled:=false;
     Edit10.Enabled:=false;
     Edit11.Enabled:=false;
     Edit12.Enabled:=false;
     Edit13.Enabled:=false;
     Button15.Enabled:=false;
     Button16.Enabled:=false;
     Button19.Enabled:=false;
     ComboBox4.Enabled:=false;
     CheckBox15.Enabled:=false;
     CheckBox16.Enabled:=false;
   end;
end;

procedure TForm5.Button12Click(Sender: TObject);
begin
  Form8.show;
end;

procedure TForm5.Button11Click(Sender: TObject);
begin
  OpenDialog1.FileName:='*.*';
  if (OpenDialog1.execute) then
    Edit8.text:=OpenDialog1.FileName;
end;

procedure TForm5.CheckBox1Click(Sender: TObject);
begin
  if (CheckBox1.checked) then
   begin
    Label23.Enabled:=true;
    Label24.Enabled:=true;
    Edit14.Enabled:=true;
    Edit15.Enabled:=true;
   end
  else
   begin
    Label23.Enabled:=false;
    Label24.Enabled:=false;
    Edit14.Enabled:=false;
    Edit15.Enabled:=false;
   end;

end;

procedure TForm5.RadioButton4Click(Sender: TObject);
begin
  Button11.enabled:=true;
end;

procedure TForm5.RadioButton5Click(Sender: TObject);
begin
  Button11.enabled:=false;
end;

procedure TForm5.Button18Click(Sender: TObject);
begin
  RadioButton5.checked:=true;
  Button11.Enabled:=false;
  Edit6.text:='';
  Edit7.text:='';
  Edit8.text:='';
  Edit14.text:='';
  Edit15.text:='';
  ComboBox5.text:='Default';
  Label23.Enabled:=false;
  Label24.Enabled:=false;
  Edit14.Enabled:=false;
  Edit15.Enabled:=false;
  CheckBox1.Checked:=false;
end;

procedure TForm5.Button17Click(Sender: TObject);
var
  str:string;
  line:integer;
begin
  str:='';
  if (Edit8.text <> '') then
   begin
    str:='<IMG SRC="'+Edit8.text+'"';
    if (CheckBox1.checked) then
     if (Edit14.text <> '') and (Edit15.text <> '') then
      str:=str+' HEIGHT='+Edit14.text+' WIDTH='+Edit15.text;
    if (ComboBox5.text <> 'Default') then
     str:=str+' ALIGN="'+ComboBox5.text+'"';
    if (Edit7.text <> '') then
     str:=str+' NAME="'+Edit7.text+'"';
    if (Edit6.text <> '') then
     str:=str+' ALT="'+Edit6.text+'"';
    str:=str+'>';
    //write it to Memo1
    line:=findEndBody;
    Form2.Memo1.Lines.insert(line,str);
   end;
end;

procedure TForm5.Button14Click(Sender: TObject);
begin
  Form9.show;
end;

procedure TForm5.Button13Click(Sender: TObject);
begin
  Form10.show;
end;



procedure TForm5.Button19Click(Sender: TObject);
begin
  Edit9.text:='';
  Edit10.text:='';
  Edit11.text:='';
  Edit12.text:='';
  Edit13.text:='';
  ComboBox4.text:='Default';
  CheckBox15.checked:=false;
  CheckBox16.checked:=false;
end;

procedure TForm5.RadioGroup3Click(Sender: TObject);
begin
  Form11.Label1.caption:=RadioGroup3.items[RadioGroup3.ItemIndex];
  Form11.show();
end;

procedure TForm5.RadioGroup2Click(Sender: TObject);
begin
  Form11.Label1.caption:=RadioGroup2.items[RadioGroup2.ItemIndex];
  Form11.show();
end;

procedure TForm5.RadioGroup1Click(Sender: TObject);
begin
  Form11.Label1.caption:=RadioGroup1.items[RadioGroup1.ItemIndex];
  Form11.show();
end;

procedure TForm5.RadioGroup4Click(Sender: TObject);
begin
  Form11.Label1.caption:=RadioGroup4.items[RadioGroup4.ItemIndex];
  Form11.show();
end;

procedure TForm5.RadioGroup5Click(Sender: TObject);
begin
  Form11.Label1.caption:=RadioGroup5.items[RadioGroup5.ItemIndex];
  Form11.show();
end;

procedure TForm5.Button20Click(Sender: TObject);
var
  str:string;
  line:integer;
begin
  if (Edit16.text <> '') and (Edit17.text <> '') then
   begin
    str:='<FORM NAME="'+Edit16.text+'" ACTION="'+Edit17.text+'"';
    if (ComboBox6.text <> 'Method') then
       str:=str+' METHOD="'+ComboBox6.text+'"';
    str:=str+'>';
    line:=findEndBody;
    Form2.Memo1.Lines.insert(line,str);
    RadioButton6.enabled:=true;
    RadioButton7.enabled:=true;
    RadioButton8.enabled:=true;
    RadioButton9.enabled:=true;
    RadioButton10.enabled:=true;
    Button20.enabled:=false;
    Button21.enabled:=true;
    Edit16.text:='';
    Edit17.text:='';
    ComboBox6.text:='Method';
   end
  else
   showMessage('You must fill in all the Fields');
end;

procedure TForm5.RadioButton8Click(Sender: TObject);
begin
  RadioGroup1.enabled:=false;
  RadioGroup2.enabled:=false;
  RadioGroup3.enabled:=false;
  RadioGroup4.enabled:=false;
  RadioGroup5.enabled:=false;
// set to true
  RadioGroup3.enabled:=true;
end;

procedure TForm5.RadioButton7Click(Sender: TObject);
begin
  RadioGroup1.enabled:=false;
  RadioGroup2.enabled:=false;
  RadioGroup3.enabled:=false;
  RadioGroup4.enabled:=false;
  RadioGroup5.enabled:=false;
// set to true
  RadioGroup2.enabled:=true;
end;

procedure TForm5.RadioButton6Click(Sender: TObject);
begin
  RadioGroup1.enabled:=false;
  RadioGroup2.enabled:=false;
  RadioGroup3.enabled:=false;
  RadioGroup4.enabled:=false;
  RadioGroup5.enabled:=false;
// set to true
  RadioGroup1.enabled:=true;

end;

procedure TForm5.RadioButton9Click(Sender: TObject);
begin
  RadioGroup1.enabled:=false;
  RadioGroup2.enabled:=false;
  RadioGroup3.enabled:=false;
  RadioGroup4.enabled:=false;
  RadioGroup5.enabled:=false;
// set to true
  RadioGroup4.enabled:=true;

end;

procedure TForm5.RadioButton10Click(Sender: TObject);
begin
  RadioGroup1.enabled:=false;
  RadioGroup2.enabled:=false;
  RadioGroup3.enabled:=false;
  RadioGroup4.enabled:=false;
  RadioGroup5.enabled:=false;
// set to true
  RadioGroup5.enabled:=true;
end;

procedure TForm5.Button21Click(Sender: TObject);
begin
  Button20.enabled:=true;
  Button21.enabled:=false;
  RadioGroup1.enabled:=false;
  RadioGroup2.enabled:=false;
  RadioGroup3.enabled:=false;
  RadioGroup4.enabled:=false;
  RadioGroup5.enabled:=false;
  RadioButton6.enabled:=false;
  RadioButton7.enabled:=false;
  RadioButton8.enabled:=false;
  RadioButton9.enabled:=false;
  RadioButton10.enabled:=false;
  RadioButton6.Checked:=false;
  RadioButton7.Checked:=false;
  RadioButton8.Checked:=false;
  RadioButton9.Checked:=false;
  RadioButton10.Checked:=false;
  Form2.Memo1.Lines.insert(findEndBody,'</FORM>');
end;

procedure TForm5.ComboBox7Change(Sender: TObject);
begin
  if (ComboBox7.text = 'Custom') then
    if (ColorDialog1.Execute) then
      ComboBox7.text:=con(intToHex(ColorToRGB(ColorDialog1.Color),6));
end;

procedure TForm5.RadioButton11Click(Sender: TObject);
begin
  Button22.enabled:=true;
end;

procedure TForm5.RadioButton12Click(Sender: TObject);
begin
  button22.enabled:=false;
end;

procedure TForm5.Button22Click(Sender: TObject);
begin
  OpenDialog1.FileName:='*.gif';
  if (OpenDialog1.execute) then
    Edit20.text:=OpenDialog1.FileName;
end;

procedure TForm5.Button23Click(Sender: TObject);
var
  str:string;
  j,k:integer;
begin
  if (Edit18.text <> '') and (Edit19.text <> '') then
   begin
    str:='<TALBE COLS='+Edit18.text+' ROWS='+Edit19.text;
    if (Edit21.text <> '') then
      str:=str+' WIDTH="'+Edit21.text+'"';
    if (ComboBox7.text <> 'Default') then
      str:=str+' BGCOLOR="'+ComboBox7.text+'"';
    if (Edit20.text <> '') then
      str:=str+' BACKGROUND="'+Edit20.text+'"';
    str:=str+'>';
    Form2.Memo1.Lines.insert(findEndBody,str);
    for j:= 1 to strToInt(Edit19.text) do
     begin
      Form2.Memo1.Lines.insert(findEndBody,'<TR>');
      str:='';
      for k:= 1 to strToInt(Edit18.text) do
       str:=str+'<TD></TD>';
     Form2.Memo1.Lines.insert(findEndBody,str);
     Form2.Memo1.Lines.insert(findEndBody,'</TR>');
    end;
    Form2.Memo1.Lines.insert(findEndBody,'</TABLE>');
    Edit18.text:='';
    Edit19.text:='';
    Edit20.text:='';
    Edit21.text:='';
    ComboBox7.text:='Default';
   end;
end;

procedure TForm5.ComboBox7Exit(Sender: TObject);
begin
  if (ComboBox7.text = 'Custom') then
   ComboBox7.text:=intToHex(ColorToRGB(ColorDialog1.Color),6);
end;

procedure TForm5.Button24Click(Sender: TObject);
begin
  Edit18.text:='';
  Edit19.text:='';
  Edit20.text:='';
  Edit21.text:='';
  ComboBox7.text:='Default';

end;

end.
