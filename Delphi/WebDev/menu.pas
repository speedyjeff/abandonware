unit menu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, Buttons;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    View1: TMenuItem;
    View2: TMenuItem;
    Help1: TMenuItem;
    Save1: TMenuItem;
    Open1: TMenuItem;
    Save2: TMenuItem;
    SaveAs1: TMenuItem;
    Close1: TMenuItem;
    CloseAll1: TMenuItem;
    Exit1: TMenuItem;
    CutCtrDel1: TMenuItem;
    CopyCtrIns1: TMenuItem;
    PasteShiftIns1: TMenuItem;
    About1: TMenuItem;
    EditWindow1: TMenuItem;
    AddJSWindow1: TMenuItem;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    AddHTML1: TMenuItem;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    ClearAll1: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    ScrollinBanner1: TMenuItem;
    DynamicClock1: TMenuItem;
    SineTextBanner1: TMenuItem;
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure EditWindow1Click(Sender: TObject);
    procedure CloseAll1Click(Sender: TObject);
    procedure AddJSWindow1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure AddHTML1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure CutCtrDel1Click(Sender: TObject);
    procedure CopyCtrIns1Click(Sender: TObject);
    procedure PasteShiftIns1Click(Sender: TObject);
    procedure ClearAll1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure ScrollinBanner1Click(Sender: TObject);
    procedure DynamicClock1Click(Sender: TObject);
    procedure SineTextBanner1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses notepad, window2, window1, Window3, Window4, Window5, Banner, Window6,
  Window7;

{$R *.DFM}

procedure TForm1.Button3Click(Sender: TObject);
begin
  Form4.show();
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Form3.show();
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Form2.show();
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Form2.hide();
  Form3.hide();
  Form4.hide();
  Form5.hide();
  Form6.hide();
  Form7.hide();
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Form5.show();
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  Form6.show();
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  Form7.show();
end;


procedure TForm1.Exit1Click(Sender: TObject);
begin
  Application.terminate();
end;

procedure TForm1.EditWindow1Click(Sender: TObject);
begin
  Form2.show();
end;

procedure TForm1.CloseAll1Click(Sender: TObject);
begin
  Form2.hide();
  Form3.hide();
  Form4.hide();
  Form5.hide();
  Form6.hide();
  Form7.hide();
  Form8.hide();
  Form9.hide();
end;

procedure TForm1.AddJSWindow1Click(Sender: TObject);
begin
  Form3.show();
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  SaveDialog1.FileName:='*.htm';
  if (SaveDialog1.execute) then
    Form2.Memo1.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TForm1.AddHTML1Click(Sender: TObject);
begin
  Form4.show();
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  Form3.show();
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
  Form4.show();
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
  Form2.show();
end;

procedure TForm1.CutCtrDel1Click(Sender: TObject);
begin
  Form2.Memo1.CutToClipBoard;
end;

procedure TForm1.CopyCtrIns1Click(Sender: TObject);
begin
  Form2.Memo1.CopyToClipboard;
end;

procedure TForm1.PasteShiftIns1Click(Sender: TObject);
begin
  Form2.Memo1.PasteFromClipboard;
end;

procedure TForm1.ClearAll1Click(Sender: TObject);
begin
  Form2.Memo1.selectAll;
  Form2.Memo1.cutToClipboard;
  Form2.Memo1.Lines.Add('<HTML>');
  Form2.Memo1.Lines.Add('<HEAD>');
  Form2.Memo1.Lines.Add('</HEAD>');
  Form2.Memo1.Lines.Add('<BODY>');
  Form2.Memo1.Lines.Add('<!--   Insert your HTML page here  -->');
  Form2.Memo1.Lines.Add('</BODY>');
  Form2.Memo1.Lines.Add('</HTML>');
  //Form2.numLines:=6;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  OpenDialog1.FileName:='*.htm';
  if (OpenDialog1.execute) then
    Form2.Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
end;

procedure TForm1.ScrollinBanner1Click(Sender: TObject);
begin
  Form8.show;
end;

procedure TForm1.DynamicClock1Click(Sender: TObject);
begin
  Form10.show;
end;

procedure TForm1.SineTextBanner1Click(Sender: TObject);
begin
  Form9.show;
end;

end.
