unit uModel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uScriptDrive, Vcl.StdCtrls, Vcl.ExtCtrls, StrUtils,
  Vcl.ComCtrls;

type
  TForm3 = class(TForm)
    Button1: TButton;
    mLog: TMemo;
    bAttack: TButton;
    lPlayerInfo: TLabel;
    lStep: TLabel;
    lCreatureInfo: TLabel;
    cbItem: TComboBox;
    bUseItem: TButton;
    cbSkill: TComboBox;
    bSkillUse: TButton;
    lNeedExp: TLabel;
    cbAutoAttack: TCheckBox;
    tAutoAttack: TTimer;
    lAutoCount: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Craft: TTabSheet;
    lbLoot: TListBox;
    Label1: TLabel;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure log(text: string);
    procedure FormShow(Sender: TObject);
    procedure bAttackClick(Sender: TObject);
    procedure UpdateInterface;
    procedure bLvlUpClick(Sender: TObject);
    procedure tAutoAttackTimer(Sender: TObject);
    procedure bUseItemClick(Sender: TObject);
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

var
    oldPlayerItems
   ,oldPlayerLoot
            : string;

procedure TForm3.bUseItemClick(Sender: TObject);
begin
    if cbItem.ItemIndex = -1 then exit;
    Script.Exec('UseItem('+Copy(cbItem.Text, 0, Pos('=', cbItem.Text)-1)+')');
    UpdateInterface;
end;

procedure TForm3.bLvlUpClick(Sender: TObject);
begin
    Script.Exec('LevelUpPlayer()');
    UpdateInterface;
end;

procedure TForm3.Button1Click(Sender: TObject);
var i: integer;
begin
    Script.Exec('CurrentLevel(1);');
    UpdateInterface;

    log('Enter into Dungeon...');
end;


procedure TForm3.bAttackClick(Sender: TObject);
begin
    Script.Exec('PlayerAttack();CreatureAttack();CheckStatus();');
    UpdateInterface;
end;

procedure TForm3.FormShow(Sender: TObject);
begin
    mLog.Lines.Clear;

    Script.Exec('InitPlayer();CurrentLevel(1);InitCreatures();SetAutoATK(1000);');
    UpdateInterface;

    log('Enter into Dungeon...');
end;

procedure TForm3.tAutoAttackTimer(Sender: TObject);
begin

    if   Script.Exec('ProcessAuto()') <> ''
    then UpdateInterface;

    if cbAutoAttack.Checked then
    begin
        Script.Exec('ChangeAutoATK(-1)');
        bAttack.Click;
    end;


end;

procedure TForm3.UpdateInterface;
var
    item: integer;
    AutoCount: integer;
    tmp: string;
begin
    item := cbItem.ItemIndex;

    lStep.Caption := 'Lvl:' + Script.Exec('GetCurrentLevel()') + ', ' + Script.Exec('CurrentCreature()') + '/' + Script.Exec('CreaturesCount()');
    lCreatureInfo.Caption := ReplaceStr( Script.Exec('GetCurrCreatureInfo()'), ',', '  ' );

    tmp := Script.Exec('GetPlayerInfo()');
    lPlayerInfo.Caption := ReplaceStr( tmp, ',', '  ' );

    lNeedExp.Caption := 'LvlUp: ' + Script.Exec('NeedExp()');

    tmp := Script.Exec('GetPlayerItems()');
    if (tmp <> oldPlayerItems) or (oldPlayerItems = '') then
    begin
        cbItem.Items.CommaText := tmp;
        oldPlayerItems := tmp;
    end;

    tmp := Script.Exec('GetPlayerLoot()');
    if (tmp <> oldPlayerLoot) or (oldPlayerLoot = '') then
    begin
        lbLoot.Items.CommaText := tmp;
        oldPlayerLoot := tmp;
    end;

    AutoCount := StrToIntDef(Script.Exec('GetAutoATK()'), 0);
    lAutoCount.Caption := 'Auto: ' + IntToStr(AutoCount);


    if AutoCount <= 0 then
    begin
        cbAutoAttack.Checked := false;
        cbAutoAttack.Enabled := false;
    end else
        cbAutoAttack.Enabled := true;


    log(Script.Exec('GetEvents()'));

    /// восстанавливаем элемент в списке
    if   cbItem.Items.Count-1 >= item
    then cbItem.ItemIndex := item;

end;

procedure TForm3.log(text: string);
begin
    if text <> '' then
    mLog.Text := text + sLineBreak + mLog.Text;
    mLog.Text := Copy(mLog.Text, 0, 1000);
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
    Script := TScriptDrive.Create;
    Script.SetClass(TData, Data);
end;

end.
