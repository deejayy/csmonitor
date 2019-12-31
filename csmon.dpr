program csmon;

uses
  ExceptionLog,
  Forms,
  mainunit in 'mainunit.pas' {mainform};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Counter Strike Monitor';
  Application.CreateForm(Tmainform, mainform);
  Application.Run;
end.
