unit produtos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, FireDAC.UI.Intf, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Intf, FireDAC.Comp.UI, Data.Bind.Components, Data.Bind.DBScope,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, FMX.Grid,
  Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Grid,
  FMX.Grid.Style, FMX.ScrollBox;

type
  TFprodutos = class(TForm)
    sg: TStringGrid;
    EdDescricao: TEdit;
    bpesquisa: TSpeedButton;
    ToolBar1: TToolBar;
    sb: TSpeedButton;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    lmens: TLabel;
    AniIndicator2: TAniIndicator;
    procedure bpesquisaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure sgSelectCell(Sender: TObject; const ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sbClick(Sender: TObject);
    procedure sgSelChanged(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Mensagem(xmens:string;tempo:integer=0);

  end;

var
  Fprodutos: TFprodutos;
  xcol,xlin:integer;

  const colcodigo:integer=2;coldescricao:integer=1;colunidade:integer=3;colpreco:integer=4;
        coldesconto:integer=5;


implementation

uses datam,pedido;

{$R *.fmx}
//{$R *.LgXhdpiTb.fmx ANDROID}
//{$R *.SmXhdpiPh.fmx ANDROID}

procedure TFprodutos.bpesquisaClick(Sender: TObject);
/////////////////////////////////////////////////////
var w:string;
begin
   xcol:=-1;xlin:=-1;
   dm.QProdutos.Close;
   dm.QProdutos.Sql.Clear;
   if EdDescricao.text<>'' then begin
      w:=chr(39)+trim('%'+EdDescricao.Text+'%')+chr(39);
      dm.QProdutos.SQL.Add('select esto_codigo,esto_descricao,esto_unidade,esto_desconto,(select esqt_vendavis from estoqueqtde where esto_codigo=esqt_esto_codigo) as precovenda from estoque'+
                           ' where esto_descricao like '+w+' order by esto_descricao' );
   end else begin
      dm.QProdutos.SQL.Add('select esto_codigo,esto_descricao,esto_unidade,esto_desconto,(select esqt_vendavis from estoqueqtde where esto_codigo=esqt_esto_codigo) as precovenda from estoque'+
                           ' order by esto_descricao');

   end;
   dm.QProdutos.open;

//   showmessage( 'precovenda='+dm.QProdutos.FieldByName('precovenda').AsString);
//   dm.QProdutos.next;
//   showmessage( 'precovenda='+dm.QProdutos.FieldByName('precovenda').AsString);

end;

procedure TFprodutos.FormActivate(Sender: TObject);
begin
  if not dm.conexao.Connected then dm.conexao.Connected:=true;
//{
  TThread.CreateAnonymousThread(procedure
  begin
       Mensagem('Aguarde, carregando produtos');
        AniIndicator2.Visible := true;
        AniIndicator2.Enabled := true;
       if not dm.QProdutos.Active then dm.QProdutos.open;
       TThread.Synchronize(nil, procedure
         begin
//                        TLoading.Hide;
            AniIndicator2.Visible := false;
            AniIndicator2.Enabled := false;
            Mensagem(' ');

         end);

  end).Start;
//}
{
       Mensagem('Aguarde, carregando produtos');
       if not dm.QProdutos.Active then dm.QProdutos.open;
       Mensagem(' ');
}
end;

procedure TFprodutos.Mensagem(xmens: string; tempo: integer);
begin
   lmens.Text:=xmens;
   lmens.UpdateEffects;
   if tempo > 0 then
      Sleep( tempo );
end;

procedure TFprodutos.sbClick(Sender: TObject);
begin
  if xlin>=0 then begin
  {
    FPedido.EdCodpro.text:=sg.Cells[0,xlin];
    FPedido.EdDescricao.text:=sg.Cells[1,xlin];
    FPedido.EdUnitario.text:=sg.Cells[3,xlin];
}
    FPedido.EdCodpro.text:=sg.Cells[colcodigo,xlin];
    FPedido.EdDescricao.text:=sg.Cells[coldescricao,xlin];
    FPedido.EdUnitario.text:=sg.Cells[colpreco,xlin];

    FPedido.EdDescontoMaximo.text := sg.cells[coldesconto,xlin];

    FPedido.EdQtde.text:='';
    FPedido.EdQtde.SetFocus;
  end;
  Close;

end;

procedure TFprodutos.sgSelChanged(Sender: TObject);
begin
  if (xcol>0) and (xlin>0)  then begin
    FPedido.EdCodpro.text:=sg.Cells[0,xlin];
    FPedido.EdDescricao.text:=sg.Cells[1,xlin];
    FPedido.EdUnitario.text:=sg.Cells[3,xlin];
    FPedido.EdQtde.SelStart:=0;
    FPedido.EdQtde.text:='';
    FPedido.EdQtde.SetFocus;
    FPedido.EdQtde.UpdateEffects;
    Close;
  end;

end;

procedure TFprodutos.sgSelectCell(Sender: TObject; const ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if (arow<=sg.RowCount) and ( acol<=sg.ColumnCount ) and (sg.RowCount>0)  then begin
   xcol:=acol;
   xlin:=arow;
  end;

end;

end.
