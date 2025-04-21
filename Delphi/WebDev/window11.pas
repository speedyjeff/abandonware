unit window11;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm11 = class(TForm)
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Edit2: TEdit;
    CheckBox1: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    Label4: TLabel;
    Edit3: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Edit6: TEdit;
    Button3: TButton;
    Image1: TImage;
    Label1: TLabel;
    Label12: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form11: TForm11;

implementation

uses menu, notepad;

{$R *.DFM}

procedure TForm11.FormShow(Sender: TObject);
begin
  if (Label1.caption = 'Radio Button') or (Label1.caption = 'Check Boxes') then
   begin
    Label3.visible:=true;
    Edit2.visible:=true;
    CheckBox1.visible:=true;
    CheckBox1.top:=80;
    Button1.top:=104;
    Button1.left:=56;
    Button2.top:=104;
    Button2.left:=144;
    Form11.height:=165;
    //make the rest disapear
    Button3.visible:=false;
    Edit3.visible:=false;
    Edit4.visible:=false;
    Edit5.visible:=false;
    Edit6.visible:=false;
    Label4.visible:=false;
    Label5.visible:=false;
    Label6.visible:=false;
    Label7.visible:=false;
    Label8.visible:=false;
    Label9.visible:=false;
    Label10.visible:=false;
    Memo1.visible:=false;
   end;
  if (Label1.caption = 'Combo Box') or (Label1.caption = 'List Box') then
   begin
    Label3.visible:=true;
    Edit2.visible:=true;
    Label4.visible:=true;
    Label4.top:=88;
    if (Label1.caption <> 'Combo Box') then
     begin
      Label5.visible:=true;
      Label5.top:=88;
      Edit3.visible:=true;
      Edit3.top:=80;
     end
    else
     begin
      Label5.visible:=false;
      Edit3.visible:=false;
     end;
    Memo1.visible:=true;
    Memo1.top:=104;
    Memo1.width:=137;
    Button1.top:=104;
    Button1.left:=200;
    Button2.top:=136;
    Button2.left:=200;
    Form11.height:=194;
    //make the rest disapear
    Button3.visible:=false;
    CheckBox1.visible:=false;
    Edit4.visible:=false;
    Edit5.visible:=false;
    Edit6.visible:=false;
    Label6.visible:=false;
    Label7.visible:=false;
    Label8.visible:=false;
    Label9.visible:=false;
    Label10.visible:=false;
   end;
   if (Label1.caption = 'Plain Text Input') or (Label1.caption = 'Password Input') or (Label1.caption = 'File Input') then
    begin
     Label3.visible:=true;
     Edit2.visible:=true;
     Label6.visible:=true;
     Label6.top:=93;
     Edit4.visible:=true;
     Edit4.top:=88;
     Edit4.left:=72;
     if (Label1.caption <> 'File Input') then
      begin
       Edit5.visible:=true;
       Edit5.top:=88;
       Edit5.left:=232;
       Label7.visible:=true;
       Label7.top:=93;
      end
     else
      begin
       Edit5.visible:=false;
       Label7.visible:=false;
      end;
     Button1.top:=120;
     Button1.left:=64;
     Button2.top:=120;
     Button2.left:=152;
     Form11.height:=178;
    //make the rest disapear
        Button3.visible:=false;
    CheckBox1.visible:=false;
    Edit3.visible:=false;
    Edit6.visible:=false;
    Label4.visible:=false;
    Label5.visible:=false;
    Label8.visible:=false;
    Label9.visible:=false;
    Label10.visible:=false;
    Memo1.visible:=false;
    end;
   if (Label1.caption = 'Paragraph Input') then
    begin
     Label8.visible:=true;
     Label8.top:=88;
     Memo1.top:=104;
     Memo1.visible:=true;
     Memo1.width:=273;
     Label9.visible:=true;
     Label9.top:=173;
     Label10.visible:=true;
     Label10.top:=205;
     Edit4.visible:=true;
     Edit4.top:=168;
     Edit4.left:=64;
     Edit5.visible:=true;
     Edit5.top:=200;
     Edit5.left:=64;
     Button1.top:=168;
     Button1.left:=192;
     Button2.top:=200;
     Button2.left:=192;
     Form11.height:=260;
    //make the rest disapear
    Button3.visible:=false;
    CheckBox1.visible:=false;
    Edit2.visible:=false;
    Edit3.visible:=false;
    Edit6.visible:=false;
    Label3.visible:=false;
    Label4.visible:=false;
    Label5.visible:=false;
    Label6.visible:=false;
    Label7.visible:=false;
    end;
   if (Label1.caption = 'Submit Button') or (Label1.caption = 'Reset Button') or (Label1.caption = 'JavaScript Button') or (Label1.caption = 'Hidden Field') then
    begin
     Label3.visible:=true;
     Edit2.visible:=true;
     Button1.top:=88;
     Button1.left:=8;
     Button2.top:=88;
     Button2.left:=96;
     Form11.height:=146;
    //make the rest disapear
        Button3.visible:=false;
    CheckBox1.visible:=false;
    Edit3.visible:=false;
    Edit4.visible:=false;
    Edit5.visible:=false;
    Edit6.visible:=false;
    Label4.visible:=false;
    Label5.visible:=false;
    Label6.visible:=false;
    Label7.visible:=false;
    Label8.visible:=false;
    Label9.visible:=false;
    Label10.visible:=false;
    Memo1.visible:=false;
    end;
   if (Label1.caption = 'Image Submit') then
    begin
     Label3.visible:=false;
     Edit2.visible:=false;
     Edit6.visible:=true;
     Edit6.top:=88;
     Button3.top:=88;
     Button3.visible:=true;
     Button1.top:=120;
     Button1.left:=64;
     Button2.top:=120;
     Button2.left:=144;
     Form11.height:=183;
    //make the rest disapear
    CheckBox1.visible:=false;
    Edit3.visible:=false;
    Edit4.visible:=false;
    Edit5.visible:=false;
    Label4.visible:=false;
    Label5.visible:=false;
    Label6.visible:=false;
    Label7.visible:=false;
    Label8.visible:=false;
    Label9.visible:=false;
    Label10.visible:=false;
    Memo1.visible:=false;
    end;
end;

procedure TForm11.Button2Click(Sender: TObject);
begin
  Form11.hide;
end;

procedure TForm11.Button3Click(Sender: TObject);
begin
  Form1.OpenDialog1.FileName:='*.*';
  if (Form1.OpenDialog1.execute) then
   Edit6.text:=Form1.OpenDialog1.FileName;
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

procedure TForm11.Button1Click(Sender: TObject);
var
  str:string;
  stop:boolean;
  j:integer;
begin
 if (Label1.caption = 'Radio Button') or (Label1.caption = 'Check Boxes') then
   begin
   //  name value checked
    if (Edit1.text <> '') and (Edit2.text <> '') then
     begin
      str:='<INPUT TYPE=';
      if (Label1.caption = 'Radio Button') then
       str:=str+'radio';
      if (Label1.caption = 'Check Boxes') then
       str:=str+'checkbox';
      str:=str+' NAME="'+Edit1.text+'" VALUE="'+Edit2.text+'"';
      if (CheckBox1.checked) then
       str:=str+' CHECKED';
      str:=str+'>';
      Form2.Memo1.Lines.insert(findEndBody,str);
     end
    else
     showMessage('You must fill in: NAME field and VALUE field');
   end;

  if (Label1.caption = 'Combo Box') or (Label1.caption = 'List Box') then
   begin
    if (Edit1.text <> '') and (Edit2.text <> '') then
     begin
     // name value items
      stop:=false;
      str:='<SELECT NAME="'+Edit1.text+'" VALUE="'+Edit2.text+'"';
      if (Label1.caption <> 'Combo Box') then
       begin
        if (Edit3.text <> '') then
         begin
        //'number of items visible'
          str:=str+' SIZE='+Edit3.text;
         end // of edit3.text <> ''
        else
         begin
          showMessage('You need to fill in the: NUMBER OF VISIBLE ITEMS');
          stop:=true;
         end // of else
       end
        else  // of label = 'combo box'
         str:=str+' SIZE=1';
        if not(stop) then  //if the above showmessage was not called then
         begin
          str:=str+'>';
          Form2.memo1.Lines.insert(findEndBody,str);
          j:=0;
          while (Memo1.Lines[j] <> '') do
           begin
            str:='';
            str:='  <OPTION VALUE="'+Memo1.Lines[j]+'">'+Memo1.Lines[j]+'</OPTION>';
            Form2.Memo1.Lines.insert(findEndBody,str);
            j:=j+1;
           end;
           Form2.Memo1.Lines.insert(findEndBody,'</SELECT>');
         end;   // of not(stop)
       Form11.hide;
     end  //of fields not(full)
    else
     showMessage('You must fill in: NAME field, VALUE field and ITEMS');
   end;

   if (Label1.caption = 'Plain Text Input') or (Label1.caption = 'Password Input') or (Label1.caption = 'File Input') then
    begin
     //  name value 'size of box'
     stop:=false;
     if (Edit1.text <> '') and (Edit2.text <> '') and (Edit4.text <> '') then
      begin
       str:='<INPUT TYPE=';
       if (Label1.caption = 'Plain Text Input') then
        str:=str+'text';
       if (Label1.caption = 'Password Input') then
        str:=str+'password';
       if (Label1.caption = 'File Input') then
        str:=str+'file';
       str:=str+' NAME="'+Edit1.text+'" VALUE="'+Edit2.text+'"';
       str:=str+' SIZE='+Edit4.text;
       if (Label1.caption <> 'File Input') then
        begin
         // 'max length of input'
         if (Edit5.text <> '') then
          str:=str+' MAXLENGTH='+Edit5.text
         else
          begin
           showMessage('You must fill in: the MAX LENGTH OF INPUT');
           stop:=true;
          end; // of if then else
        end; // of label <> 'File Input'
        if not(stop) then
         begin
           str:=str+'>';
           Form2.Memo1.Lines.insert(findEndBody,str);
         end;  //of not(stop)
        Form11.hide;
       end // of check if there for all
      else
       showMessage('You must fill in: NAME field, VALUE field, and SIZE OF BOX');
    end;  // of label = 'stuff'

   if (Label1.caption = 'Paragraph Input') then
    begin
      //name value 'text in field' rows cols
      if (Edit1.text <> '') and (Edit4.text <> '') and (Edit5.text <> '') then
       begin
        str:='<TEXTAREA NAME="'+Edit1.text+'" COLS='+Edit5.text+' ROWS='+Edit4.text+'>';
        Form2.Memo1.Lines.insert(findEndBody,str);
        j:=0;
        while (Memo1.Lines[j] <> '') do
         begin
          Form2.Memo1.Lines.insert(findEndBody,Memo1.Lines[j]);
          j:=j+1;
         end;
        Form2.Memo1.Lines.insert(findEndBody,'</TEXTAREA>');
        Form11.hide;
       end  // of check if there
      else
       showMessage('You must fill in: NAME, VALUE, # COLUMNS, and #ROWS');
    end;  // of label = 'Paragraph Input'

   if (Label1.caption = 'Submit Button') or (Label1.caption = 'Reset Button') or (Label1.caption = 'JavaScript Button') or (Label1.caption = 'Hidden Field') then
    begin
        //name value
     if (Edit1.text <> '') and (Edit2.text <> '') then
      begin
       str:='<INPUT TYPE=';
       if (Label1.caption = 'Submit Button') then
        str:=str+'submit';
       if (Label1.caption = 'Reset Button') then
        str:=str+'reset';
       if (Label1.caption = 'JavaScript Button') then
        str:=str+'button';
       if (Label1.caption = 'Hidden Field') then
        str:=str+'hidden';
       str:=str+' NAME="'+Edit1.text+'" VALUE="'+Edit2.text+'">';
       Form2.Memo1.Lines.insert(findEndBody,str);
       Form11.hide;
      end // of check fields
     else
      showMessage('You must fill in: NAME, and VALUE');
    end;

   if (Label1.caption = 'Image Submit') then
    begin
     //name source
     if (Edit1.text <> '') and (Edit6.text <> 'Source') then
      begin
       str:='<INPUT TYPE=image NAME="'+Edit1.text+'" SRC="'+Edit6.text+'">';
       Form2.Memo1.Lines.insert(findEndBody,str);
       Form11.hide;
      end // of check fields
     else
      showMessage('You must fill in: NAME, and SOURCE');
    end;
 CheckBox1.checked:=false;
 Edit1.text:='';
 Edit2.text:='';
 Edit3.text:='';
 Edit4.text:='';
 Edit5.text:='';
 Edit6.text:='';
 Memo1.selectAll;
 Memo1.cutToClipboard;

end;

end.
