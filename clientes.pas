unit clientes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, FMX.Grid,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope,
  FireDAC.UI.Intf, FireDAC.FMXUI.Wait, FireDAC.Stan.Intf, FireDAC.Comp.UI,
  FMX.Grid.Style, FMX.ScrollBox;

type
  TFClientes = class(TForm)
    sg: TStringGrid;
    EdNome: TEdit;
    bpesquisa: TSpeedButton;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    EdCidade: TEdit;
    sbcidade: TSpeedButton;
    bcadastracliente: TButton;
    AniIndicator2: TAniIndicator;
    lmens: TLabel;
    Edcnpjcpf: TEdit;
    sbcnpjcpf: TSpeedButton;
    procedure bpesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure sgSelectCell(Sender: TObject; const ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sbClick(Sender: TObject);
    procedure sbcidadeClick(Sender: TObject);
    procedure sgTap(Sender: TObject; const Point: TPointF);
    procedure sgDblClick(Sender: TObject);
    procedure sgSelChanged(Sender: TObject);
    procedure EdNomeChange(Sender: TObject);
    procedure bcadastraclienteClick(Sender: TObject);
    procedure sbcnpjcpfClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Mensagem(xmens:string;tempo:integer=0);
    function GetNome(codigo:string):string;
  end;

var
  FClientes: TFClientes;
  xcol,xlin:integer;

const colcodigo:integer=0;colnome:integer=1;colcnpjcpf:integer=2;colrazaosocial:integer=3;
      colcidadeinteger=4;

implementation

uses datam,pedido,FMX.VirtualKeyboard, FMX.Platform, cadcliente;

{$R *.fmx}

// 23.06.2021
procedure TFClientes.bcadastraclienteClick(Sender: TObject);
////////////////////////////////////////////////////////////
begin

    FCadClientes.Execute;

end;

procedure TFClientes.bpesquisaClick(Sender: TObject);
/////////////////////////////////////////////////////////////
var w,
    s,
    s1:string;
    x: IFMXVirtualKeyboardService;

begin

   dm.QClientes.Close;
   dm.QClientes.Sql.Clear;
   s:='';
   s1:='';
// 25.10.19
   if not dm.TabConfig.Active then dm.TabConfig.Open;
{  13.08.24 - retirado para usar transportadores(motorista)
              arquivo de cliente já vem filtrado do sac
   if dm.TabConfig.FieldByName('conf_repr_codigo').AsInteger <>0 then begin

        s :='clie_repr_codigo = '+dm.TabConfig.FieldByName('conf_repr_codigo').AsString+' and '   ;
        s1:='where clie_repr_codigo = '+dm.TabConfig.FieldByName('conf_repr_codigo').AsString   ;

   end;
}

   if EdNome.text<>'' then begin

      w:=chr(39)+trim('%'+Ednome.Text+'%')+chr(39);
      dm.QClientes.SQL.Add('select clie_codigo,clie_nome,clie_cidade,clie_razaosocial,clie_cnpjcpf from clientes'+
                           ' where '+s+' clie_nome like '+w+' order by clie_nome' );
   end else begin

      dm.QClientes.SQL.Add('select clie_codigo,clie_nome,clie_cidade,clie_razaosocial,clie_cnpjcpf from clientes '+
                           s1+' order by clie_nome');

   end;
   dm.QClientes.open;
   x:=TPlatformServices.Current.GetPlatformService(IFMXVirtualKeyboardService) as IFMXVirtualKeyboardService;
   if  TVirtualKeyboardState.Visible in x.VirtualKeyBoardState then
         x.HideVirtualKeyboard;

end;

procedure TFClientes.EdNomeChange(Sender: TObject);
/////////////////////////////////////////////////////
begin

   bpesquisaclick(self);

end;

procedure TFClientes.FormActivate(Sender: TObject);
////////////////////////////////////////////////////////
begin

  xcol:=-1;xlin:=-1;
  if not dm.conexao.Connected then dm.conexao.Connected:=true;
// 25.10.19
  if not dm.TabConfig.Active then dm.TabConfig.Open;


  TThread.CreateAnonymousThread(procedure
  begin

/////////////////

          Mensagem('Montando tela de clientes');
          AniIndicator2.Visible := true;
          AniIndicator2.Enabled := true;
//  13.08.24 - retirado para usar transportadores(motorista)
//              arquivo de cliente já vem filtrado do sac
//        if dm.TabConfig.FieldByName('conf_repr_codigo').AsInteger <>0 then begin
//
//           if dm.QClientes.Active then dm.QClientes.open else
//
//            begin
//              Dm.QClientes.SQL.Clear;
//              Dm.QClientes.SQL.Add('select clie_codigo,clie_nome,clie_cidade,clie_razaosocial from clientes'+
//                                 ' where clie_repr_codigo = '+dm.TabConfig.FieldByName('conf_repr_codigo').AsString)   ;
//              Dm.QClientes.Open;
//            end;
//
//        end else begin

           if not dm.QClientes.Active then dm.QClientes.open;

//        end;
////////////////////

          TThread.Synchronize(nil, procedure
          begin
//                        TLoading.Hide;
            AniIndicator2.Visible := false;
            AniIndicator2.Enabled := false;
            Mensagem(' ');

          end);


  end).Start;



end;

procedure TFClientes.FormCreate(Sender: TObject);
///////////////////////////////////////////////////////////
//var xcolcodigo,xcolnome,xlin:integer;
begin
{
  if not dm.conexao.Connected then
    dm.conexao.Connected:=true;
//  showmessage('carregando clientes');
  dm.QClientes.open;
  sg.RowCount:=2;
  xcolcodigo:=0;
  xcolnome:=1;
  xlin:=1;
//  showmessage('clientes para o grid');
  while not dm.Qclientes.eof do begin
    sg.Cells[xcolcodigo,xlin]:=Dm.QClientes.FieldByName('clie_codigo').AsString;
    sg.Cells[xcolnome,xlin]:=Dm.QClientes.FieldByName('clie_nome').AsString;
    dm.Qclientes.Next;
    inc(xlin);
    sg.RowCount:=sg.RowCount+1;
  end;
  dm.QClientes.Close;
}

end;

// 23.08.24
function TFClientes.GetNome(codigo: string): string;
////////////////////////////////////////////////////
var w:string;
begin
   dm.Q.Close;
   dm.Q.Sql.Clear;
   w:=chr(39)+trim(codigo)+chr(39);
   dm.Q.SQL.Add('select clie_nome from clientes'+
                        ' where clie_codigo =  '+w+' order by clie_nome' );
   dm.Q.open;
   if not dm.Q.eof then result:= dm.Q.FieldByName('clie_nome').asstring
   else result:='Não encontrado';
end;

procedure TFClientes.Mensagem(xmens: string; tempo: integer);
//////////////////////////////////////////////////////////////
begin

   lmens.Text:=xmens;
   lmens.UpdateEffects;
//   Application.ProcessMessages;
   if tempo > 0 then

      Sleep( tempo );

end;

procedure TFClientes.sbcidadeClick(Sender: TObject);
var w:string;
    x: IFMXVirtualKeyboardService;
begin
   dm.QClientes.Close;
   dm.QClientes.Sql.Clear;
   if EdCidade.text<>'' then begin
      w:=chr(39)+trim('%'+EdCidade.Text+'%')+chr(39);
      dm.QClientes.SQL.Add('select clie_codigo,clie_nome,clie_cidade,clie_razaosocial,clie_cnpjcpf from clientes'+
                           ' where clie_cidade like '+w+' order by clie_nome' );
   end else begin
      dm.QClientes.SQL.Add('select clie_codigo,clie_nome,clie_cidade,clie_razaosocial,clie_cnpjcpf from clientes'+
                           ' order by clie_nome');

   end;
   dm.QClientes.open;
// 13.08.24
   x:=TPlatformServices.Current.GetPlatformService(IFMXVirtualKeyboardService) as IFMXVirtualKeyboardService;
   if  TVirtualKeyboardState.Visible in x.VirtualKeyBoardState then
         x.HideVirtualKeyboard;

end;

procedure TFClientes.sbClick(Sender: TObject);
begin
  if xlin>=0 then begin
//    if StrToIntDef(sg.Cells[colcodigo,xlin],0)=0 then begin;
      FPedido.EdCodcli.text:=sg.Cells[colcodigo,xlin];
      FPedido.EdNome.text:=sg.Cells[colnome,xlin];
//    end;
  end;
  Close;
end;

// 13.08.24
procedure TFClientes.sbcnpjcpfClick(Sender: TObject);
var w:string;
    x: IFMXVirtualKeyboardService;
begin
   dm.QClientes.Close;
   dm.QClientes.Sql.Clear;
   if Edcnpjcpf.text<>'' then begin
//      w:=chr(39)+trim('%'+Edcnpjcpf.Text+'%')+chr(39);
// 14.08.24 - pesquisa pelo cnpj tem q ser pelo começo
      w:=chr(39)+trim(Edcnpjcpf.Text+'%')+chr(39);
      dm.QClientes.SQL.Add('select clie_codigo,clie_nome,clie_cidade,clie_razaosocial,clie_cnpjcpf from clientes'+
                           ' where clie_cnpjcpf like '+w+' order by clie_nome' );
   end else begin
      dm.QClientes.SQL.Add('select clie_codigo,clie_nome,clie_cidade,clie_razaosocial,clie_cnpjcpf from clientes'+
                           ' order by clie_nome');

   end;
   dm.QClientes.open;
// 13.08.24
   x:=TPlatformServices.Current.GetPlatformService(IFMXVirtualKeyboardService) as IFMXVirtualKeyboardService;
   if  TVirtualKeyboardState.Visible in x.VirtualKeyBoardState then
         x.HideVirtualKeyboard;


end;

procedure TFClientes.sgDblClick(Sender: TObject);
begin
{
  if (xcol>0) and (xlin>0)  then begin
   FPedido.EdCodcli.text:=sg.Cells[0,xlin];
   FPedido.EdNome.text:=sg.Cells[1,xlin];
   close;
  end;
}
end;

procedure TFClientes.sgSelChanged(Sender: TObject);
begin

  if (xcol>0) and (xlin>=0)  then begin

//    if StrToIntDef(sg.Cells[colcodigo,xlin],0)=0 then begin;
      FPedido.EdCodcli.text:=sg.Cells[colcodigo,xlin];
      FPedido.EdNome.text:=sg.Cells[colnome,xlin];
      close;
//    end;

  end;

end;

procedure TFClientes.sgSelectCell(Sender: TObject; const ACol, ARow: Integer;
  var CanSelect: Boolean);
//////////////////////////////////////////////////////////////////////////////////////
begin
  if (arow<=sg.RowCount) and ( acol<=sg.ColumnCount ) and (sg.RowCount>0)  then begin
   xcol:=acol;
   xlin:=arow;
//   FPedido.EdCodcli.text:=sg.Cells[0,xlin];
//   FPedido.EdNome.text:=sg.Cells[1,xlin];
//   close;
  end;
end;

procedure TFClientes.sgTap(Sender: TObject; const Point: TPointF);
begin

  if (xcol>0) and (xlin>0)  then begin
    if StrToIntDef(sg.Cells[colcodigo,xlin],0)=0 then begin;
      FPedido.EdCodcli.text:=sg.Cells[colcodigo,xlin];
      FPedido.EdNome.text:=sg.Cells[colnome,xlin];
      close;
    end;
  end;

end;

end.
