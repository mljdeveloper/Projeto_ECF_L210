program AppXML;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {FR_Principal},
  DBConect in 'DBConect.pas' {DBConect: TDataModule},
  Login in 'Login.pas' {FrmLogin},
  uConsultaDocumento in 'uConsultaDocumento.pas' {frmConsultaDocumento},
  uUsuario in 'uUsuario.pas' {frmCadUsuario};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDBConect, DBConect);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;

end.
