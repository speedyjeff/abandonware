unit Banner;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm8 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label3: TLabel;
    ComboBox2: TComboBox;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Image1: TImage;
    ComboBox4: TComboBox;
    Label2: TLabel;
    Bevel1: TBevel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

uses notepad;


{$R *.DFM}

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

procedure TForm8.Button2Click(Sender: TObject);
begin
  Form8.hide;
end;

procedure TForm8.Button1Click(Sender: TObject);
var
 line:integer;
 str:string;
begin
  if (Edit1.text <> '') then
   begin
    line:=findEndBody;
    if (line <> -1) then
      if (ComboBox4.text <> 'Default') then
       begin
        if (ComboBox4.text = 'Center') then
          Form2.Memo1.Lines.insert(line,'<CENTER>')
         else
          Form2.Memo1.Lines.insert(line,'<P ALIGN="'+ComboBox4.text+'">');
        line:=line+1;
       end;
    end;
  str:='<APPLET CODEBASE="http://..."';
  if (RadioButton1.checked) then
    str:=str+' CODE=smbanner.class HEIGHT=19 WIDTH=500'
   else
    str:=str+' CODE=banner.class HEIGHT=40 WIDTH=500';
   str:=str+'>';
  Form2.Memo1.Lines.insert(line,str);
  line:=line+1;
  Form2.Memo1.Lines.insert(line,'<PARAM NAME=background VALUE="'+ComboBox1.text+'">');
  Form2.Memo1.Lines.insert(line,'<PARAM NAME=foreground VALUE="'+ComboBox2.text+'">');
  Form2.Memo1.Lines.insert(line,'<PARAM NAME=string VALUE="'+Edit1.text+'">');
  line:=line+3;
  Form2.Memo1.Lines.insert(line,'</APPLET>');
  if (Edit1.text <> '') then
   begin
    line:=findEndBody;
    if (line <> -1) then
     if (ComboBox4.text <> 'Default') then
       if (ComboBox4.text = 'Center') then
          Form2.Memo1.Lines.insert(line,'</CENTER>')
   end;
  Edit1.text:='';
  Form8.hide;

end;

end.
