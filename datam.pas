unit datam;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Phys.SQLiteWrapper.Stat;

type
  Tdm = class(TForm)
    conexao: TFDConnection;
    CriaBanco: TFDQuery;
    QClientes: TFDQuery;
    IncluiClientes: TFDQuery;
    Q: TFDQuery;
    QProdutos: TFDQuery;
    TabClientes: TFDTable;
    TabPrecos: TFDTable;
    TabPortadores: TFDTable;
    TabFpgto: TFDTable;
    TabPedidosM: TFDTable;
    TabPedidosD: TFDTable;
    TabConfig: TFDTable;
    CriaTabelasEstoque: TFDQuery;
    CriaTabelasCliente: TFDQuery;
    CriaTabelaConfig: TFDQuery;
    QEstru: TFDQuery;
    QCampo: TFDQuery;
    TabProdutos: TFDTable;
    QPed: TFDQuery;
    procedure conexaoBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

uses System.IOUtils;

{$R *.fmx}

procedure Tdm.conexaoBeforeConnect(Sender: TObject);
begin
  {$IFDEF ANDROID}
  dm.Conexao.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'sacandroid.db3');
  {$ELSE}
  dm.Conexao.Params.Values['Database'] := '\Delphixe7Projetos\Vendas\BancodeDados\sacandroid.db';
  {$ENDIF}

end;

end.
