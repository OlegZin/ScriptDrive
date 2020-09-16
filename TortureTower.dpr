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
  uConst in 'uConst.pas',
  uTowerMode in 'uTowerMode.pas',
  uThinkMode in 'uThinkMode.pas',
  uLog in 'uLog.pas',
  uGameDrive in 'uGameDrive.pas',
  uScriptDrive in 'uScriptDrive.pas',
  uGameInterface in 'uGameInterface.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
