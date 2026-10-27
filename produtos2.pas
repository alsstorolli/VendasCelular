unit produtos2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, Datam, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit;

type
  TFProdutos2 = class(TForm)
    ListView1: TListView;
    EdDescricao: TEdit;
    bpesquisa: TSpeedButton;
    AniIndicator2: TAniIndicator;
    procedure bpesquisaClick(Sender: TObject);
    procedure ListView1UpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CarregaProdutos;
  end;

var
  FProdutos2: TFProdutos2;

implementation

uses pedido;

{$R *.fmx}

{ TFProdutos2 }

procedure TFProdutos2.bpesquisaClick(Sender: TObject);
begin
  TThread.CreateAnonymousThread(procedure
  begin
       AniIndicator2.Visible := true;
       AniIndicator2.Enabled := true;
//       CarregaProdutos;
       TThread.Synchronize(nil, procedure
         begin
            CarregaProdutos;
            AniIndicator2.Visible := false;
            AniIndicator2.Enabled := false;
         end);

  end).Start;

end;

procedure TFProdutos2.CarregaProdutos;
///////////////////////////////////////////
var  Item: TListViewItem;
     cor,
     w    : string;
begin

//  if not dm.QProdutos.Active then dm.QProdutos.Open;

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

  ListView1.BeginUpdate;
  try
    ListView1.Items.Clear; // Limpa os itens anteriores
    while not dm.QProdutos.Eof do begin

      Item := ListView1.Items.Add;
  {
      Item.Data['TxtDescricao'] := '12345678901234567890123456789012345678901234567890';
  //    Item.Data['Txtpreco'] := FormatFloat('R$ #,##0.00', QueryProdutos.FieldByName('PRECO').AsFloat);
      Item.Data['Txtpreco'] := 'Preço:'+FormatFloat('R$ #,##0.00', 45.50);
      Item.Data['Txtunidade'] := 'Un';
      Item.Data['Txtdesconto'] := '5';
  }
      Item.Data['TxtDescricao'] := dm.QProdutos.FieldByName('esto_descricao').AsString;
      Item.Data['Txtpreco'] := 'Preço:'+FormatFloat('R$ #,##0.00', dm.QProdutos.FieldByName('precovenda').AsFloat);
      Item.Data['Txtunidade'] := dm.QProdutos.FieldByName('esto_unidade').AsString;

      Item.Data['Txtdesconto'] := FormatFloat('#0.00', dm.QProdutos.FieldByName('esto_desconto').AsFloat);
        // (Opcional) Armazena o ID oculto no item para usar quando o usuário clicar nele
      Item.TagString := dm.QProdutos.FieldByName('esto_codigo').AsString;
      Item.TagFloat := dm.QProdutos.FieldByName('precovenda').AsCurrency;
       dm.QProdutos.Next;
    end;

  finally
    // 4. Libera o ListView para desenhar todos os produtos de uma vez só na tela
    ListView1.EndUpdate;
  end;
end;

procedure TFProdutos2.ListView1ItemClick(const Sender: TObject;  const AItem: TListViewItem);
var  LText: TListItemText;
begin

//    if Assigned(AItem.Viewdata.FindDrawable('Text1')) then
//       ShowMessage(TListItemText(AItem.Viewdata.FindDrawable('Text1')).Text);
   LText := AItem.Objects.FindObject('TxtDescricao') as TListItemText;
   if LText <> nil then FPedido.EdDescricao.text:=LText.Text;
   FPedido.EdCodpro.text:=aitem.TagString;
   FPedido.EdUnitario.text:=CurrTostr(AItem.TagFloat);
//   LText := AItem.Objects.FindObject('Txtpreco') as TListItemText;
//   if LText <> nil then FPedido.EdUnitario.text:=LText.Text;
   LText := AItem.Objects.FindObject('Txtdesconto') as TListItemText;
   if LText <> nil then FPedido.EdDescontoMaximo.text:=LText.Text;
   LText := AItem.Objects.FindObject('Txtunidade') as TListItemText;
   if LText <> nil then FPedido.EdUnidade.text:=LText.Text;
   FPedido.EdQtde.SelStart:=0;
   FPedido.EdQtde.text:='';
   FPedido.EdQtde.SetFocus;
   FPedido.EdQtde.UpdateEffects;
   Close;

end;

procedure TFProdutos2.ListView1UpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
var
  LText: TListItemText;
begin

  // Buscando o campo customizado pelo nome no modo DynamicAppearance
{  retirado para ver se para o erro de list index out of bounds  durante a consulta
  LText := AItem.Objects.FindObject('TxtDescricao') as TListItemText;
  if LText <> nil then
  begin
    // Exemplo de lógica baseada no texto do próprio item
    if AItem.Text.Contains('Agua') then
      LText.TextColor := TAlphaColorRec.Red
    else
      LText.TextColor := TAlphaColorRec.Darkcyan;
  end;
  LText := AItem.Objects.FindObject('Txtpreco') as TListItemText;
  if LText <> nil then
  begin
     LText.TextColor := TAlphaColorRec.Blue;
  end;
}
end;


end.
