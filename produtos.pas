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
  end;

var
  Fprodutos: TFprodutos;
  xcol,xlin:integer;

implementation

uses datam,pedido;

{$R *.fmx}
{$R *.LgXhdpiTb.fmx ANDROID}
{$R *.SmXhdpiPh.fmx ANDROID}

procedure TFprodutos.bpesquisaClick(Sender: TObject);
/////////////////////////////////////////////////////
var w:string;
begin
   xcol:=-1;xlin:=-1;
   dm.QProdutos.Close;
   dm.QProdutos.Sql.Clear;
   if EdDescricao.text<>'' then begin
      w:=chr(39)+trim('%'+EdDescricao.Text+'%')+chr(39);
      dm.QProdutos.SQL.Add('select esto_codigo,esto_descricao,esto_unidade,(select esqt_vendavis from estoqueqtde where esto_codigo=esqt_esto_codigo) as precovenda from estoque'+
                           ' where esto_descricao like '+w+' order by esto_descricao' );
   end else begin
      dm.QProdutos.SQL.Add('select esto_codigo,esto_descricao,esto_unidade,(select esqt_vendavis from estoqueqtde where esto_codigo=esqt_esto_codigo) as precovenda from estoque'+
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
  if dm.QProdutos.Active then dm.QProdutos.open;
end;

procedure TFprodutos.sbClick(Sender: TObject);
begin
  if xlin>=0 then begin
    FPedido.EdCodpro.text:=sg.Cells[0,xlin];
    FPedido.EdDescricao.text:=sg.Cells[1,xlin];
    FPedido.EdUnitario.text:=sg.Cells[3,xlin];
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
