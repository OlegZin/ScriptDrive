unit uModel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uScriptDrive, Vcl.StdCtrls;

type
  TForm3 = class(TForm)
    Button1: TButton;
    mLog: TMemo;
    Button2: TButton;
    Button3: TButton;
    lPlayerInfo: TLabel;
    Button4: TButton;
    lStep: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure log(text: string);
    procedure Button2Click(Sender: TObject);
    procedure Restart;
    procedure FormShow(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses
    uData;

procedure TForm3.Button1Click(Sender: TObject);
var i: integer;
begin
    Restart;
end;


procedure TForm3.Button2Click(Sender: TObject);
begin
    mLog.Lines.Clear;
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
    Script.Exec('PlayerAttack();CreatureAttack();CheckStatus();');

    log(Script.Exec('GetCurrCreatureInfo()'));
    lPlayerInfo.Caption := Script.Exec('GetPlayerInfo()');
    lStep.Caption := Script.Exec('CurrentCreature()') + '/' + Script.Exec('CreaturesCount()');
end;

procedure TForm3.Button4Click(Sender: TObject);
begin
    mLog.Lines.Clear;

    Script.Exec('InitCreatures();');

    log('¬ходим в подземелье...');
    log(Script.Exec('GetCurrCreatureInfo()'));
end;


procedure TForm3.FormShow(Sender: TObject);
begin
    Restart;
end;

procedure TForm3.Restart;
begin
    mLog.Lines.Clear;

    Script.Exec('InitPlayer();InitCreatures()');

    lPlayerInfo.Caption := Script.Exec('GetPlayerInfo()');
    lStep.Caption := Script.Exec('CurrentCreature()') + '/' + Script.Exec('CreaturesCount()');

    log('¬ходим в подземелье...');
    log(Script.Exec('GetCurrCreatureInfo()'));
end;

procedure TForm3.log(text: string);
begin
    mLog.Text := text + sLineBreak + mLog.Text;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
    Script := TScriptDrive.Create;
    Script.SetClass(TData);
end;

end.
