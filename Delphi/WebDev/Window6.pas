unit Window6;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm9 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Edit1: TEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Button1: TButton;
    Edit2: TEdit;
    Button2: TButton;
    Edit3: TEdit;
    Label2: TLabel;
    Edit4: TEdit;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Label3: TLabel;
    ComboBox4: TComboBox;
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

uses Window3, notepad;

{$R *.DFM}

procedure TForm9.Button4Click(Sender: TObject);
begin
  Form9.hide();
end;

procedure TForm9.Button1Click(Sender: TObject);
begin
  if (Form5.ColorDialog1.Execute) then
   Edit2.text:=intToHex(ColorToRGB(Form5.ColorDialog1.Color),6);
end;

procedure TForm9.Button2Click(Sender: TObject);
begin
  if (Form5.ColorDialog1.Execute) then
   Edit3.text:=intToHex(ColorToRGB(Form5.ColorDialog1.Color),6);
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

procedure TForm9.Button3Click(Sender: TObject);
var
  line:integer;
begin
  if (Edit1.text <> '') and (Edit2.text <> '') and (Edit3.text <> '') and (Edit4.text <> '') then
   begin
    line:=findEndBody;
    if (line <> -1) then
     begin
      if (ComboBox4.text <> 'Default') then
        begin
         if (ComboBox4.text = 'Center') then
           Form2.Memo1.Lines.insert(line,'<CENTER>')
          else
           Form2.Memo1.Lines.insert(line,'<P ALIGN="'+ComboBox4.text+'">');
         line:=line+1;
        end;
      Form2.Memo1.Lines.insert(line,'<APPLET CODE=SineText.class CODEBASE=http://... HEIGHT=80 WIDTH=580>');
      line:=line+1;
      Form2.Memo1.Lines.insert(line,'<PARAM NAME=rate VALUE="'+Edit4.text+'">');
      if (CheckBox2.checked) then
       Form2.Memo1.Lines.insert(line,'<PARAM NAME=MouseClick VALUE="yes">')
      else
       Form2.Memo1.Lines.insert(line,'<PARAM NAME=MouseClick VALUE="no">');
      if (CheckBox1.checked) then
       Form2.Memo1.Lines.insert(line,'<PARAM NAME=Traveling VALUE="yes">')
      else
       Form2.Memo1.Lines.insert(line,'<PARAM NAME=Traveling VALUE="no">');
      Form2.Memo1.Lines.insert(line,'<PARAM NAME=BackGround VALUE="'+Edit3.text+'">');
      Form2.Memo1.Lines.insert(line,'<PARAM NAME=ForeGround VALUE="'+Edit2.text+'">');
      Form2.Memo1.Lines.insert(line,'<PARAM NAME=Text VALUE="'+Edit1.text+'">');
      line:=findEndBody;
      Form2.Memo1.Lines.insert(line,'</APPLET>');
      if (ComboBox4.text <> 'Default') then
         if (ComboBox4.text = 'Center') then
           Form2.Memo1.Lines.insert(line+1,'</CENTER>')
        end;
    end;
  Edit1.text:='';
  Edit2.text:='';
  Edit3.text:='';
  Edit4.text:='';
  Form9.hide;
end;

end.
