program ScriptDrive;

uses
  Vcl.Forms,
  uModel in 'uModel.pas' {Form3},
  uScriptDrive in 'uScriptDrive.pas',
  uData in 'uData.pas',
  uTypes in 'uTypes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
