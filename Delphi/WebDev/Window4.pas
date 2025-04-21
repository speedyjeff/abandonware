unit Window4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm6 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label3: TLabel;
    ListBox1: TListBox;
    Label4: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

uses notepad;

{$R *.DFM}



procedure TForm6.Button2Click(Sender: TObject);
begin
  Form6.hide;
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

procedure TForm6.Button1Click(Sender: TObject);
var
  line:integer;
begin
  if (Edit1.text <> '') and (Edit2.text <> '') then
   begin
    line:=findGoodPlacement;
    if (line <> -1) then
     Form2.Memo1.Lines.insert(line,'<META NAME="'+Edit1.text+'" CONTENT="'+Edit2.text+'">');
     Form6.hide;
     Edit1.text:= '';
     Edit2.text:= '';
   end;
end;

procedure TForm6.ListBox1Click(Sender: TObject);
begin
  if (ListBox1.items[ListBox1.ItemIndex] = 'Custom') then
   begin
    Edit1.text:='';
    Edit2.text:='';
    Label3.visible:=false;
   end;
  if (ListBox1.items[ListBox1.ItemIndex] = 'Description') then
   begin
    Edit1.text:='description';
    Edit2.text:='';
    Label3.visible:=false;
   end;
  if (ListBox1.items[ListBox1.ItemIndex] = 'Key Words') then
   begin
    Edit1.text:='keywords';
    Edit2.text:='';
    Label3.visible:=true;
   end;
  if (ListBox1.items[ListBox1.ItemIndex] = 'Generator') then
   begin
    Edit1.text:='generator';
    Edit2.text:='...''s Web Developer';
    Label3.visible:=false;
   end;
  if (ListBox1.items[ListBox1.ItemIndex] = 'Author') then
   begin
    Edit1.text:='author';
    Edit2.text:='';
    Label3.visible:=false;
   end;
  if (ListBox1.items[ListBox1.ItemIndex] = 'Custom') then
   begin
    Edit1.text:='';
    Edit2.text:='';
    Label3.visible:=false;
   end;
end;

end.
