unit clientes1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.StdCtrls, FMX.Edit, FMX.Controls.Presentation,
  FMX.ScrollBox, FMX.Grid, clientes, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  datam,cadcliente;

type
  TFClientes1 = class(TForm)
    EdNome: TEdit;
    bpesquisa: TSpeedButton;
    EdCidade: TEdit;
    sbcidade: TSpeedButton;
    bcadastracliente: TButton;
    AniIndicator2: TAniIndicator;
    lmens: TLabel;
    sbcnpjcpf: TSpeedButton;
    Edcnpjcpf: TEdit;
    ListView1: TListView;
    procedure bcadastraclienteClick(Sender: TObject);
    procedure bpesquisaClick(Sender: TObject);
    procedure sbcidadeClick(Sender: TObject);
    procedure sbcnpjcpfClick(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CarregaClientes;
  end;

var
  FClientes1: TFClientes1;

implementation

uses pedido;

{$R *.fmx}

procedure TFClientes1.bcadastraclienteClick(Sender: TObject);
begin
    FCadClientes.Execute;

end;

procedure TFClientes1.bpesquisaClick(Sender: TObject);
begin
  TThread.CreateAnonymousThread(procedure
  begin
       AniIndicator2.Visible := true;
       AniIndicator2.Enabled := true;
//       CarregaClientes;
       TThread.Synchronize(nil, procedure
         begin
            CarregaClientes;
            AniIndicator2.Visible := false;
            AniIndicator2.Enabled := false;
         end);

  end).Start;
end;

procedure TFClientes1.CarregaClientes;
///////////////////////////////////////
var  Item: TListViewItem;
     cor,
     s1,
     s,
     w,
     xcnpj,
     sqlcnpjcpf,
     sqlcidade   : string;
begin

   s:='';
   s1:='';
//   if not dm.TabConfig.Active then dm.TabConfig.Open;
{  13.08.24 - retirado para usar transportadores(motorista)
              arquivo de cliente já vem filtrado do sac
   if dm.TabConfig.FieldByName('conf_repr_codigo').AsInteger <>0 then begin

        s :='and clie_repr_codigo = '+dm.TabConfig.FieldByName('conf_repr_codigo').AsString+' and '   ;
        s1:='where clie_repr_codigo = '+dm.TabConfig.FieldByName('conf_repr_codigo').AsString   ;

   end;
}

  dm.QClientes.Close;
//  dm.QClientes.Sql.Clear;
  dm.QClientes.Sql.Text:='';
  sqlcidade:='';
  sqlcnpjcpf:='';
  if EdCidade.text<>'' then sqlcidade:=' and clie_cidade like '+chr(39)+trim('%'+Edcidade.Text+'%')+chr(39);
  if Edcnpjcpf.text<>'' then sqlcnpjcpf:= 'and clie_cnpjcpf like '+chr(39)+trim('%'+Edcnpjcpf.Text+'%')+chr(39);

  if EdNome.text<>'' then begin

      w:=chr(39)+trim('%'+Ednome.Text+'%')+chr(39);
//      dm.QClientes.SQL.Add('select clie_codigo,clie_nome,clie_cidade,clie_razaosocial,clie_cnpjcpf,clie_uf from clientes'+
//                           ' where '+s+' clie_nome like '+w+' order by clie_nome' );
      dm.QClientes.SQL.Text:='select clie_codigo,clie_nome,clie_cidade,clie_razaosocial,clie_cnpjcpf,clie_uf from clientes'+
                           ' where clie_nome is not null '+s+' and clie_nome like '+w+sqlcidade+sqlcnpjcpf+' order by clie_nome';
  end else begin

//      dm.QClientes.SQL.Add('select clie_codigo,clie_nome,clie_cidade,clie_razaosocial,clie_cnpjcpf,clie_uf from clientes '+
//                           s1+' order by clie_nome');
      dm.QClientes.SQL.Text:='select clie_codigo,clie_nome,clie_cidade,clie_razaosocial,clie_cnpjcpf,clie_uf from clientes '+
                             'where clie_nome is not null '+s1+sqlcidade+sqlcnpjcpf+' order by clie_nome';

  end;
  dm.QClientes.open;
  if dm.QClientes.Eof then lmens.Text:='N OK' else lmens.Text:='OK';

  ListView1.BeginUpdate;
  try
    ListView1.Items.Clear; // Limpa os itens anteriores
    while not dm.QClientes.Eof do begin
      Item := ListView1.Items.Add;
      Item.Data['clie_nome'] := dm.QClientes.FieldByName('clie_nome').AsString;
      Item.Data['clie_razaosocial'] := dm.QClientes.FieldByName('clie_razaosocial').AsString;
      xcnpj:=dm.QClientes.FieldByName('clie_cnpjcpf').AsString;
{
      Item.Data['clie_cnpjcpf'] :=Format('%s.%s.%s/%s-%s', [
                xCNPJ.Substring(0, 2),
                xCNPJ.Substring(2, 3),
                xCNPJ.Substring(5, 3),
                xCNPJ.Substring(8, 4),
                xCNPJ.Substring(12, 2)
                }
      if Length(Trim(xcnpj))=14 then
         Item.Data['clie_cnpjcpf'] :=Format('%s.%s.%s/%s-%s', [
                xCNPJ[1]+xCNPJ[2],
                xCNPJ[3]+xCNPJ[4]+xCNPJ[5],
                xCNPJ[6]+xCNPJ[7]+xCNPJ[8],
                xCNPJ[9]+xCNPJ[10]+xCNPJ[11]+xCNPJ[12],
                xCNPJ[13]+xCNPJ[14]
              ])
       else
         Item.Data['clie_cnpjcpf'] := xcnpj;
      Item.Data['clie_cidade'] := dm.QClientes.FieldByName('clie_cidade').AsString;
//      Item.Data['clie_cidade'] := dm.QClientes.FieldByName('clie_cidade').AsString+' - '+dm.QClientes.FieldByName('clie_uf').AsString;
//      Item.Data['clie_uf'] := dm.QClientes.FieldByName('clie_uf').AsString;
        // (Opcional) Armazena o ID oculto no item para usar quando o usuário clicar nele
      Item.TagString := dm.QClientes.FieldByName('clie_codigo').AsString;
      dm.QClientes.Next;
    end;

  finally
    // 4. Libera o ListView para desenhar todos os produtos de uma vez só na tela
    ListView1.EndUpdate;
    ListView1.UpdateEffects;
    lmens.UpdateEffects;
  end;
end;

procedure TFClientes1.ListView1ItemClick(const Sender: TObject;  const AItem: TListViewItem);
////////////////////////////////////////////////////////////////////////////////////////////////
var  LText: TListItemText;
begin
   LText := AItem.Objects.FindDrawable('clie_nome') as TListItemText;
   if LText <> nil then FPedido.EdNome.text:=LText.Text;
   FPedido.EdCodcli.text:=aitem.TagString;
   Close;
end;

procedure TFClientes1.sbcidadeClick(Sender: TObject);
////////////////////////////////////////////////////////
begin
  TThread.CreateAnonymousThread(procedure
  begin
       AniIndicator2.Visible := true;
       AniIndicator2.Enabled := true;
       CarregaClientes;
       TThread.Synchronize(nil, procedure
         begin
            AniIndicator2.Visible := false;
            AniIndicator2.Enabled := false;
         end);

  end).Start;

end;

procedure TFClientes1.sbcnpjcpfClick(Sender: TObject);
//////////////////////////////////////////////////////////
begin
  TThread.CreateAnonymousThread(procedure
  begin
       AniIndicator2.Visible := true;
       AniIndicator2.Enabled := true;
       CarregaClientes;
       TThread.Synchronize(nil, procedure
         begin
            AniIndicator2.Visible := false;
            AniIndicator2.Enabled := false;
         end);

  end).Start;

end;

end.
