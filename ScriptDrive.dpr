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
  uTargets in 'uTargets.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
