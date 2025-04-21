unit Window5;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm7 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

uses notepad;

{$R *.DFM}

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

procedure TForm7.Button2Click(Sender: TObject);
begin
  Form7.hide;
end;

procedure TForm7.Button1Click(Sender: TObject);
var
  line:integer;
begin
  if (Edit1.text <> '') and (Edit2.text <> '') then
   begin
    line:=findEndApplet;
    if (line <> -1) then
     Form2.Memo1.Lines.insert(line,'<PARAM NAME="'+Edit1.text+'" VALUE="'+Edit2.text+'">');
    Edit1.text:='';
    Edit2.text:='';
   end;
end;

end.
