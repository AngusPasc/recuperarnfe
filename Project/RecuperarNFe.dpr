program RecuperarNFe;

uses
  Vcl.Forms,
  Metodos in '..\Source\Metodos.pas' {FAPai},
  HTMLtoXML in '..\Source\HTMLtoXML.pas',
  fGERARXML in '..\Source\fGERARXML.pas' {FfGERARXML},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'RecuperarNFe';
  TStyleManager.TrySetStyle('Aqua Light Slate');
  Application.CreateForm(TFfGERARXML, FfGERARXML);
  Application.Run;
end.
