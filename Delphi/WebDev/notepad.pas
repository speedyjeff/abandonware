unit notepad;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm2 = class(TForm)
    Memo1: TMemo;
    function numLines : integer;
  private
    { Private declarations }
  public
    { Public declarations }
      lineNum:integer;
  end;

var
  Form2: TForm2;

implementation

{$R *.DFM}

function TForm2.numLines : integer;
var
  j:integer;
begin
  j:=0;
  while (pos('</html>',AnsiLowerCase(Form2.Memo1.Lines[j])) <= 0) do
   j:=j+1;
  numLines:=j;
end;

end.
