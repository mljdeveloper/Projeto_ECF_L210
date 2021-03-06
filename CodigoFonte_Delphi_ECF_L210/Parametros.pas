unit Parametros ;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  fcadastro, ComCtrls, StdCtrls, Buttons, ToolWin, ExtCtrls, rsEdit, Mask,
  rsFlyovr, RseditDB, Db, DBTables, CheckLst, jpeg, Menus,
  cxLookAndFeelPainters, cxGraphics, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinsdxStatusBarPainter, cxControls, dxStatusBar, cxButtons,
  cxContainer, cxEdit, cxGroupBox, cxRadioGroup, cxLookAndFeels, dxSkinBlack,
  dxSkinBlue, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, cxTextEdit, cxMaskEdit,
  cxButtonEdit,FileCtrl, Vcl.ImgList ;

type
  TFrmParametros = class(TFrmCadastro)
    QGrid: TQuery;
    qryAux: TQuery;
    Panel1: TPanel;
    Panel2: TPanel;
    editTreinamento: TrsSuperEdit;
    editInstrutor: TrsSuperEdit;
    OpenDialog: TOpenDialog;
    Panel3: TPanel;
    ediCodigo: TrsSuperEdit;
    ImageList1: TImageList;
    btnSelecionaIns: TcxButton;
    btnSelecionaTre: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSelecionaInsClick(Sender: TObject);
    procedure btnSelecionaTreClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Function Check : Boolean ; Override ;
    Procedure Search ; Override;
  end;

var
  FrmParametros: TFrmParametros;

implementation

{$R *.DFM}

Uses
   Global, ObjFun, MensFun, TestFun, ConsTabFun, Perfil, Constantes ;

procedure TFrmParametros.FormCreate(Sender: TObject);
begin
    LabCadTit.Caption := 'Parametros' ;
    FormOperacao := 'SIS_PARAM' ;
    FormTabela := 'Parametros' ;
    FormChaves := 'ServidorSMTP' ;
    FormCtrlFocus := 'ediCodigo' ;
    FormDataFocus := 'editInstrutor' ;

    inherited;
    ediCodigo.AsString := '0';
    ButPesquisarClick(Self);
    ButAlterarClick(Self);

end;



procedure TFrmParametros.FormShow(Sender: TObject);
begin
  inherited;
   WindowState := wsMaximized;
end;

procedure TFrmParametros.Search;
begin
  inherited;

end;

procedure TFrmParametros.btnSelecionaInsClick(Sender: TObject);
var
  FDir : String;
begin
  inherited;
  if Win32MajorVersion >= 6 then
    with TFileOpenDialog.Create(nil) do
    try
      Title := 'Selecionar Diretório';
      Options := [fdoPickFolders, fdoPathMustExist, fdoForceFileSystem]; // YMMV
      OkButtonLabel := 'Selecionar';
      DefaultFolder := FDir;
      FileName := FDir;
      if Execute then
        editInstrutor.Text := FileName;
    finally
      Free;
    end
  else
    if SelectDirectory('Selecionar Diretório', ExtractFileDrive(FDir), FDir,
             [sdNewUI, sdNewFolder]) then
      editInstrutor.Text := FDir;
end;

procedure TFrmParametros.btnSelecionaTreClick(Sender: TObject);
var
  FDir : String;
begin
  inherited;
  if Win32MajorVersion >= 6 then
    with TFileOpenDialog.Create(nil) do
    try
      Title := 'Selecionar Diretório';
      Options := [fdoPickFolders, fdoPathMustExist, fdoForceFileSystem]; // YMMV
      OkButtonLabel := 'Selecionar';
      DefaultFolder := FDir;
      FileName := FDir;
      if Execute then
        editTreinamento.Text := FileName;
    finally
      Free;
    end
  else
    if SelectDirectory('Selecionar Diretório', ExtractFileDrive(FDir), FDir,
             [sdNewUI, sdNewFolder]) then
      editTreinamento.Text := FDir;

end;

Function TFrmParametros.Check : Boolean ;
Begin
  Result := False;
  ediCodigo.Text   := '0';
  Result := True ;
End ;


end.

