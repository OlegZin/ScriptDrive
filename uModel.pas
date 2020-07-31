unit uModel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uScriptDrive, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm3 = class(TForm)
    Button1: TButton;
    mLog: TMemo;
    Button2: TButton;
    bAttack: TButton;
    lPlayerInfo: TLabel;
    lStep: TLabel;
    lCreatureInfo: TLabel;
    cbItem: TComboBox;
    bItemUse: TButton;
    cbSkill: TComboBox;
    bSkillUse: TButton;
    lNeedExp: TLabel;
    cbAutoAttack: TCheckBox;
    tAutoAttack: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure log(text: string);
    procedure Button2Click(Sender: TObject);
    procedure Restart;
    procedure FormShow(Sender: TObject);
    procedure bAttackClick(Sender: TObject);
    procedure UpdateInterface;
    procedure bLvlUpClick(Sender: TObject);
    procedure tAutoAttackTimer(Sender: TObject);
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

procedure TForm3.bLvlUpClick(Sender: TObject);
begin
    Script.Exec('LevelUpPlayer()');
    UpdateInterface;
end;

procedure TForm3.Button1Click(Sender: TObject);
var i: integer;
begin
    Restart;
end;


procedure TForm3.Button2Click(Sender: TObject);
begin
    mLog.Lines.Clear;
end;

procedure TForm3.bAttackClick(Sender: TObject);
begin
    Script.Exec('PlayerAttack();CreatureAttack();CheckStatus();');
    UpdateInterface;
end;

procedure TForm3.FormShow(Sender: TObject);
begin
    Restart;
end;

procedure TForm3.Restart;
begin
    mLog.Lines.Clear;

    Script.Exec('InitPlayer();CurrLevel(1);InitCreatures()');
    UpdateInterface;

    log('¬ходим в подземелье...');
end;

procedure TForm3.tAutoAttackTimer(Sender: TObject);
begin
    if cbAutoAttack.Checked then bAttack.Click;
end;

procedure TForm3.UpdateInterface;
begin
    lStep.Caption := 'Lvl:' + Script.Exec('CurrentLevel()') + ', ' + Script.Exec('CurrentCreature()') + '/' + Script.Exec('CreaturesCount()');
    lCreatureInfo.Caption := Script.Exec('GetCurrCreatureInfo()');
    lPlayerInfo.Caption := Script.Exec('GetPlayerInfo()');
    lNeedExp.Caption := 'LvlUp: ' + Script.Exec('NeedExp()');
    cbItem.Items.CommaText := Script.Exec('GetPlayerItems()');
    log(Script.Exec('GetEvents()'));
end;

procedure TForm3.log(text: string);
begin
    if text <> '' then
    mLog.Text := text + sLineBreak + mLog.Text;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
    Script := TScriptDrive.Create;
    Script.SetClass(TData);
end;

end.
