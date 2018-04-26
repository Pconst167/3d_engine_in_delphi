program _3point;

uses
  Forms,
  Unit1 in 'Unit1.pas' {fmain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfmain, fmain);
  Application.Run;
end.
