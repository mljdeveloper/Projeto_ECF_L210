unit uCadConsultasSAP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FCadastro, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue,
  dxSkinsdxStatusBarPainter, Vcl.Menus, Vcl.ExtCtrls, Vcl.StdCtrls, cxButtons,
  dxStatusBar, Vcl.Mask, rsEdit, RseditDB,SetParametro,TestFun,MensFun,Constantes,
  EditBusca, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmCadConsultasSAP = class(TFrmCadastro)
    Panel1: TPanel;
    EdiCodigo: TrsSuperEdit;
    EditBuscaConsulta: TEditBusca;
    Panel5: TPanel;
    editNome: TrsSuperEdit;
    Panel2: TPanel;
    editUsuario: TrsSuperEdit;
    Panel3: TPanel;
    ediQuery: TrsSuperEdit;
    Panel4: TPanel;
    editVariant: TrsSuperEdit;
    Panel6: TPanel;
    editAno: TrsSuperEdit;
    QryAux: TFDQuery;
    Panel7: TPanel;
    rsSuperEdit1: TrsSuperEdit;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditBuscaConsultaClick(Sender: TObject);
    procedure ButNovoClick(Sender: TObject);
    procedure ButSalvarClick(Sender: TObject);
    procedure ButExcluirClick(Sender: TObject);
  private
    { Private declarations }
      Function Check : Boolean ; Override ;
  public
    { Public declarations }
  end;

var
  frmCadConsultasSAP: TfrmCadConsultasSAP;

implementation

{$R *.dfm}

uses DBConect;

procedure TfrmCadConsultasSAP.ButExcluirClick(Sender: TObject);
begin
  inherited;
  EditBuscaConsulta.Text := '';
  EditBuscaConsulta.bs_KeyValues.Clear;
end;

procedure TfrmCadConsultasSAP.ButNovoClick(Sender: TObject);
begin
  inherited;
  EdiCodigo.AsString := LastCodigo('ECF_CONSULTA_ID', 'ECF_CONSULTA', '');
  editNome.Clear;
  ediQuery.Clear;
  editUsuario.Clear;
  editVariant.Clear;
  editAno.Clear;

  EditBuscaConsulta.Text := EdiCodigo.AsString;
  editNome.SetFocus; // foco no campo de Codigo.
end;

procedure TfrmCadConsultasSAP.ButSalvarClick(Sender: TObject);
begin
  if Check then
  begin
    inherited;
    EditBuscaConsulta.Text := '';
    EditBuscaConsulta.bs_KeyValues.Clear;
  end;
end;

function TfrmCadConsultasSAP.Check: Boolean;
begin
   Result := False ;

   If ( Test_IsEmptyStr(editNome.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar o Nome da Consulta !') ;        //EdiApelido
			 editNome.SetFocus ;
			 Exit ;
	 End ;

   If ( Test_IsEmptyStr(editUsuario.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar o Nome do Usu�rio do SAP !') ;        //EdiApelido
			 editUsuario.SetFocus ;
			 Exit ;
	 End ;

   If ( Test_IsEmptyStr(ediQuery.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar o Nome da Query !') ;        //EdiApelido
			 ediQuery.SetFocus ;
			 Exit ;
	 End ;

   If ( Test_IsEmptyStr(editVariant.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar o Nome da Variant !') ;        //EdiApelido
			 editVariant.SetFocus ;
			 Exit ;
	 End ;

   If ( Test_IsEmptyStr(editAno.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar o Ano da Movimenta��o a ser Extra�do do SAP !') ;        //EdiApelido
			 editVariant.SetFocus ;
			 Exit ;
	 End ;

   if ((VarOperacao = OPE_INCLUSAO) or (VarOperacao = OPE_ALTERACAO)) then
   begin
       QryAux.Close;
       QryAux.SQL.Clear;
       QryAux.SQL.Add('Select * From ECF_CONSULTA Where QUERY = :QUERY and VARIANTE = :VARIANTE and ANO = :ANO and ANO_FISCAL = :ANO_FISCAL ' );
       QryAux.Params.ParamByName('QUERY').AsString    :=  ediQuery.Text;
       QryAux.Params.ParamByName('VARIANTE').AsString :=  editVariant.Text;
       QryAux.Params.ParamByName('ANO').AsString      :=  editAno.Text;
       QryAux.Params.ParamByName('ANO_FISCAL').AsString  :=  editAno.Text;


       QryAux.Open;
       if not QryAux.IsEmpty then
       begin
           Mens_MensInf('Query j� cadastrada para este ANO !') ;        //EdiApelido
           ediQuery.SetFocus ;
           QryAux.Close;
           Exit ;
       end;
   end;


   Result := True ;

end;

procedure TfrmCadConsultasSAP.EditBuscaConsultaClick(Sender: TObject);
begin
   if EditBuscaConsulta.Text <> '' then
    EditBuscaConsulta.bs_Filter := ' and ANO_FISCAL = ' + QuotedStr(EditBuscaConsulta.Text);


  inherited;
  if ((EditBuscaConsulta.Text <> '') and (EditBuscaConsulta.bs_KeyValues.Count > 0)) then
  begin
   EdiCodigo.AsString := VarToStr(EditBuscaConsulta.bs_KeyValue);
   if VarOperacao <> OPE_INCLUSAO then
     ButPesquisarClick(Self);
  end;
end;

procedure TfrmCadConsultasSAP.FormCreate(Sender: TObject);
begin
  LabCadTit.Caption := 'Cadastro de Consulta do SAP ' ;
  FormOperacao      := 'CAD_CONSULTA_SAP';
  FormTabela        := 'ECF_CONSULTA' ;
  FormChaves        := 'ECF_CONSULTA_ID' ;
  FormCtrlFocus     := 'EditBuscaConsulta' ;
  FormDataFocus     := 'editNome' ;

  SetParametros(EditBuscaConsulta, Tipo_ConsultaSAP);
  inherited;

end;

procedure TfrmCadConsultasSAP.FormShow(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;
end;

end.
