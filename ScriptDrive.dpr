program ScriptDrive;

uses
  Vcl.Forms,
  uModel in 'uModel.pas' {Form3},
  uScriptDrive in 'uScriptDrive.pas',
  uData in 'uData.pas',
  uTypes in 'uTypes.pas',
  uDoc in 'uDoc.pas',
  uThinkModeData in 'uThinkModeData.pas',
  uFloors in 'uFloors.pas',
  uTargets in 'uTargets.pas',
  uTools in 'uTools.pas',
  superobject in 'SuperObject\superobject.pas',
  supertypes in 'SuperObject\supertypes.pas',
  superdate in 'SuperObject\superdate.pas',
  supertimezone in 'SuperObject\supertimezone.pas',
  uAssets in 'uAssets.pas' {fAssets};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TfAssets, fAssets);
  Application.Run;
end.
