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
  uLog in 'uLog.pas',
  uGameDrive in 'uGameDrive.pas',
  uScriptDrive in 'uScriptDrive.pas',
  uGameInterface in 'uGameInterface.pas',
  uTower in 'uTower.pas' {fTower},
  uNotes in 'uNotes.pas',
  uAtlas in 'uAtlas.pas' {fAtlas},
  uThink in 'uThink.pas' {fThink},
  PhrasesDB in 'PhrasesDB.pas',
  uFloor in 'uFloor.pas' {fFloor},
  uFloorAtlas in 'uFloorAtlas.pas' {fFloorAtlas};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TfAtlas, fAtlas);
  Application.CreateForm(TfTower, fTower);
  Application.CreateForm(TfAtlas, fAtlas);
  Application.CreateForm(TfThink, fThink);
  Application.CreateForm(TfFloor, fFloor);
  Application.CreateForm(TfFloorAtlas, fFloorAtlas);
  Application.Run;
end.
