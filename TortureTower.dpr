program TortureTower;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {fMain},
  uMenu in 'uMenu.pas',
  superdate in 'SuperObject\superdate.pas',
  superobject in 'SuperObject\superobject.pas',
  supertimezone in 'SuperObject\supertimezone.pas',
  supertypes in 'SuperObject\supertypes.pas',
  superxmlparser in 'SuperObject\superxmlparser.pas',
  Unit1 in 'Unit1.pas' {Form1},
  uConst in 'uConst.pas',
  uTowerMode in 'uTowerMode.pas',
  uThinkMode in 'uThinkMode.pas',
  uLog in 'uLog.pas',
  uData in 'uData.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
