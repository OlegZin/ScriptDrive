unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, FMX.WebBrowser,

  System.NetEncoding;
  /// https://flixengineering.com/archives/961
  /// кодировка картинки в base64

type
  TForm1 = class(TForm)
    wb: TWebBrowser;
    Panel1: TPanel;
    m: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin
    wb.LoadFromStrings(m.text, '');
end;

end.
