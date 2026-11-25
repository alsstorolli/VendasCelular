program VendasCelular;

uses
  System.StartUpCopy,
  FMX.Forms,
  pedido in 'pedido.pas' {FPedido},
  datam in 'datam.pas' {dm: TDataModule},
  clientes in 'clientes.pas' {FClientes},
  produtos in 'produtos.pas' {Fprodutos},
  portadores in 'portadores.pas' {FPortadores},
  condicao in 'condicao.pas' {Fpgto},
  produtos1 in 'produtos1.pas' {FProdutos1},
  cadcliente in 'cadcliente.pas' {FCadClientes},
  Classeportadores in 'Classeportadores.pas',
  classeclientes in 'classeclientes.pas',
  classeprodutos in 'classeprodutos.pas',
  classecondicao in 'classecondicao.pas',
  Gerapdfpedidovenda in 'Gerapdfpedidovenda.pas',
  vepdf in 'vepdf.pas' {FVePDF},
  classepedidodetalhe in 'classepedidodetalhe.pas',
  classepedidomestre in 'classepedidomestre.pas',
  clientes1 in 'clientes1.pas' {FClientes1},
  produtos2 in 'produtos2.pas' {FProdutos2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFPedido, FPedido);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TFClientes, FClientes);
  Application.CreateForm(TFprodutos, Fprodutos);
  Application.CreateForm(TFPortadores, FPortadores);
  Application.CreateForm(TFPortadores, FPortadores);
  Application.CreateForm(TFpgto, Fpgto);
  Application.CreateForm(TFProdutos1, FProdutos1);
  Application.CreateForm(TFCadClientes, FCadClientes);
  Application.CreateForm(TFVePDF, FVePDF);
  Application.CreateForm(TFClientes1, FClientes1);
  Application.CreateForm(TFProdutos2, FProdutos2);
  Application.CreateForm(TFProdutos2, FProdutos2);
  Application.Run;
end.
