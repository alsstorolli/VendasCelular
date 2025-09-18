unit pedido;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Layouts, FMX.Grid, FMX.TabControl, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope, FireDAC.UI.Intf,
  FireDAC.FMXUI.Wait, FireDAC.Stan.Intf, FireDAC.Comp.UI, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdFTP,
  FMX.EditBox, FMX.NumberBox, FMX.DateTimeCtrls, DateUtils, FMX.Grid.Style,
  FMX.ScrollBox, FMX.Ani,System.JSON, REST.Types, REST.Client,
  Data.Bind.ObjectScope, FMX.Memo, FMX.Memo.Types,  idftpcommon,
  RESTRequest4D;

type
  TFPedido = class(TForm)
    tabc: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    sg: TStringGrid;
    EdCodcli: TEdit;
    EdNome: TEdit;
    sbclientes: TSpeedButton;
    Panel1: TPanel;
    Edenderecoftp: TEdit;
    Edporta: TEdit;
    cb: TCheckBox;
    ftp: TIdFTP;
    lmens: TLabel;
    sbcriabanco: TSpeedButton;
    Edcodpro: TEdit;
    Eddescricao: TEdit;
    sbprodutos: TSpeedButton;
    label3: TLabel;
    sbconfirma: TSpeedButton;
    esto_codigo: TStringColumn;
    Esto_descricao: TStringColumn;
    Esto_unidade: TStringColumn;
    esqt_venda: TStringColumn;
    esqt_qtde: TStringColumn;
    totalitem: TStringColumn;
    Edportador: TEdit;
    labelportador: TLabel;
    sbportador: TSpeedButton;
    labelcondicao: TLabel;
    sbcondicao: TSpeedButton;
    Edcondicao: TEdit;
    sbportadores: TSpeedButton;
    bgravar: TCornerButton;
    TabItem3: TTabItem;
    sgpedidosd: TStringGrid;
    StringColumn7: TStringColumn;
    StringColumn8: TStringColumn;
    StringColumn9: TStringColumn;
    StringColumn10: TStringColumn;
    StringColumn11: TStringColumn;
    StringColumn12: TStringColumn;
    EdData: TDateEdit;
    batualiza: TCornerButton;
    benviapedidos: TCornerButton;
    sblimpapedidos: TSpeedButton;
    Edatedata: TDateEdit;
    bapagaitem: TCornerButton;
    EdQtde: TEdit;
    EdUnitario: TEdit;
    ToolBar1: TToolBar;
    labelversao: TLabel;
    EdPasta01ftp: TEdit;
    EdPasta02ftp: TEdit;
    spsalvaconfig: TSpeedButton;
    Edtotalpedidos: TNumberBox;
    sbcriaportadores: TSpeedButton;
    sbimpclientes: TSpeedButton;
    sbcriaprodutos: TSpeedButton;
    sbcriaclientes: TSpeedButton;
    CornerButton1: TCornerButton;
    sgpedidos: TStringGrid;
    Numero: TStringColumn;
    Cliente: TStringColumn;
    Data: TStringColumn;
    Valor: TStringColumn;
    sbcriaconfig: TSpeedButton;
    Edrepr_codigo: TEdit;
    Edusuarioftp: TEdit;
    Edsenhaftp: TEdit;
    cbalterapedido: TCornerButton;
    EdNumPedido: TEdit;
    Label1: TLabel;
    rbvenda: TRadioButton;
    rbbonificacao: TRadioButton;
    rbcomodato: TRadioButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    sbimportaproduto: TSpeedButton;
    Edenderecoftplocal: TEdit;
    EdDescricaoPortador: TEdit;
    EdDescriaofpagto: TEdit;
    EdDesconto: TEdit;
    percdesconto: TStringColumn;
    EdDescontomaximo: TEdit;
    EdValorPedido: TLabel;
    Edsupe_codigo: TEdit;
    EdSenha: TEdit;
    EdOnLine: TEdit;
    SpeedButton3: TSpeedButton;
    sbexeportadores: TSpeedButton;
    sbexeprodutos: TSpeedButton;
    AniIndicator1: TAniIndicator;
    RESTClient1: TRESTClient;
    RESTResponse1: TRESTResponse;
    RESTRequest1: TRESTRequest;
    PathAnimation1: TPathAnimation;
    AniIndicator2: TAniIndicator;
    Memo1: TMemo;
    sbestrtura: TSpeedButton;
    EdUnidade: TEdit;
    Pvalores: TPanel;
    EdInicial: TEdit;
    bpedevalores: TButton;
    EdFinal: TEdit;
    dataproducao: TStringColumn;
    EdDtproducao: TDateEdit;
    Dtfabricacao: TStringColumn;
    EdPedidocli: TEdit;
    EdClientesPedidos: TEdit;
    sbimpportadores: TSpeedButton;
    sbimpclientesapi: TSpeedButton;
    sbimpprodutosapi: TSpeedButton;
    sbtextocondicao: TSpeedButton;
    sbimportacondicao: TSpeedButton;
    EdPortaFtp: TEdit;
    bgerapdf: TCornerButton;
    procedure sbclientesClick(Sender: TObject);
    procedure sbimpclientesClick(Sender: TObject);
    procedure cbClick(Sender: TObject);
    procedure sbcriabancoClick(Sender: TObject);
    procedure sbprodutosClick(Sender: TObject);
    procedure sbimportaprodutoClick(Sender: TObject);
    procedure sbconfirmaClick(Sender: TObject);
    procedure sbportadoresClick(Sender: TObject);
    procedure sbportadorClick(Sender: TObject);
    procedure sbcondicaoClick(Sender: TObject);
    procedure sgSelectCell(Sender: TObject; const ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure bgravarClick(Sender: TObject);
    procedure TabItem3Click(Sender: TObject);
    procedure sgpedidosSelectCell(Sender: TObject; const ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure benviapedidosClick(Sender: TObject);
    procedure ftpWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure ftpWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure TabItem2Click(Sender: TObject);
    procedure sblimpapedidosClick(Sender: TObject);
    procedure batualizaClick(Sender: TObject);
    procedure bapagaitemClick(Sender: TObject);
    procedure TabItem1Click(Sender: TObject);
    procedure EdcodproExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure sbsalvaonfigClick(Sender: TObject);
    procedure spsalvaconfigClick(Sender: TObject);
    procedure sbcriaportadoresClick(Sender: TObject);
    procedure sbcriaprodutosClick(Sender: TObject);
    procedure sbcriaclientesClick(Sender: TObject);
    procedure CornerButton1Click(Sender: TObject);
    procedure clienteClick(Sender: TObject);
    procedure sgpedidosClick(Sender: TObject);
    procedure sbcriaconfigClick(Sender: TObject);
    procedure ftpWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure cbalterapedidoClick(Sender: TObject);
    procedure lbimpclientesClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure sbexeportadoresClick(Sender: TObject);
    procedure sbexeprodutosClick(Sender: TObject);
    procedure sbestrturaClick(Sender: TObject);
    procedure EdQtdeKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure EdQtdeTap(Sender: TObject; const Point: TPointF);
    procedure bpedevaloresClick(Sender: TObject);
    procedure EdInicialKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure sbimpportadoresClick(Sender: TObject);
    procedure sbimpclientesapiClick(Sender: TObject);
    procedure sbimpprodutosapiClick(Sender: TObject);
    procedure sbimportacondicaoClick(Sender: TObject);
    procedure bgerapdfClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    procedure mensagem(xmens:string;tempo:integer=0);
    procedure Editstogrid;
    function GetLinhaembranco(xsg:TStringgrid):integer;
    function SomaGrid:currency;
    function DateToSql(Dt:TDateTime):String;
    procedure LimpaGrid( Grid:TStringGrid );
    procedure ApagaTabela(xtab:string);
    function TextToValor(Text:string):currency;
    function CurrencyparaGravar(Text:string):currency;
// 20.09.2021
    function TemCampo( tabela,campo : string ):boolean;
    procedure GravaOnlineX;
    function FormataData(data: TDatetime ; ano:boolean=false): string;
    function FormataDataJson(data: TDatetime ; ano:boolean=false): string;
// 30.08.24
    procedure BaixaApiportadores;
    procedure IncluiPortadores(cjson:string);
// 05.09.24
    procedure BaixaApiclientes;
    procedure IncluiClientes(cjson:string);
// 13.12.24
    procedure BaixaApiprodutos;
    procedure IncluiProdutos(cjson:string);
// 20.12.24
    procedure BaixaApicondicao;
    procedure IncluiCondicao(cjson:string);
// 14.01.25
    function TiraBarra(s: string ;  caracter:string='/';caracternolugar:string='' ): string;

end;


var
  FPedido: TFPedido;
  linhaatual,
  NumPedido,
  Numerodoc,
  linhaatualsgpedidos  :integer;
  pastanoftp,ultimos,pastanoftp01,
  Tipomov,
  codcli,
  TotalPedido,
  codportador,
  codfpgt,
  porta      :string;

const xunidade : string = '001';
//////porta : string = '9000';  // depois usa da configuracao
const colcodigo=0;colnome=1;colunidade=2;colqtde=3;colvenda=4;coltotalitem=5;coldesconto=6;
      coldataproducao=7;

implementation

uses datam,clientes,produtos, portadores, condicao, Produtos1,FMX.VirtualKeyboard, FMX.Platform,
     pedevalores,classeportadores, System.Generics.Collections,classeclientes,classeprodutos,
     classecondicao, gerapdfpedidovenda;

{$R *.fmx}

//{$R *.LgXhdpiTb.fmx ANDROID}
//{$R *.SmXhdpiPh.fmx ANDROID}

//{$R *.LgXhdpiTb.fmx ANDROID}
//{$R *.LgXhdpiPh.fmx ANDROID}

procedure TFPedido.bapagaitemClick(Sender: TObject);
////////////////////////////////////////////////////////////
begin

    if ( trim(sg.Cells[colcodigo,linhaatual])<>'') and ( linhaatual>=0) then begin

        if not Dm.TabPedidosD.Active then Dm.TabPedidosD.Open();

// 22.06.2021
      if NumPedido > 0 then begin

          dm.TabPedidosd.Edit;
          dm.TabPedidosd.Locate('mpdd_numerodoc;mpdd_esto_codigo',Vararrayof([inttostr(numpedido),trim(sg.Cells[colcodigo,linhaatual])]),[]);
          dm.TabPedidosd.Delete;
//          dm.TabPedidosd.Post;

      end;

      sg.Cells[colcodigo,linhaatual]:='';
      sg.Cells[colnome,linhaatual]:='';
      sg.Cells[colunidade,linhaatual]:='';
      sg.Cells[colqtde,linhaatual]:='';
      sg.Cells[colvenda,linhaatual]:='';
      sg.Cells[coltotalitem,linhaatual]:='';
      sg.Cells[coldesconto,linhaatual]:='';
      sg.Cells[coldataproducao,linhaatual]:='';
      sg.Repaint;
      EdValorPedido.Text:=FormatCurr('###,###.##',SomaGrid);
      EdValorPedido.UpdateEffects;


    end;

end;

procedure TFPedido.ApagaTabela(xtab:string);
//////////////////////////////////
begin
     dm.Q.SQL.Clear;
     dm.Q.SQL.Add('drop table '+xtab);
     dm.Q.ExecSQL;
     dm.Q.Close;
end;


procedure TFPedido.batualizaClick(Sender: TObject);
begin
   TabItem3Click(self);
end;

procedure TFPedido.benviapedidosClick(Sender: TObject);
////////////////////////////////////////////////////////////
var Arquivonoftp,Arquivonoftp1,
    linha,
    caminho,
    Arquivonoftpcli  :string;
//    Arquivo,Arquivo1:TMemoryStream;
//    Arquivo,Arquivo1:TStream;
    Arquivo,Arquivo1:TStringStream;
//    Arquivot1,arquivot:TextFile;
    Arquivot1,
    arquivot,
    ArquivoCli,
    xsql      :string;
//    Arquivo1:TStringStream;
//    m : TStream;
    Lista,
    Lista1,
    ListaCli,
    ListaCodigoscli  :TStringlist;
    p : integer;

begin

   if EdOnline.Text = 'S' then begin

      Showmessage('App configurado para gravação Online');
      exit;

   end;

   ftp.Disconnect;
// 23.10.19
   if cb.IsChecked then ftp.Host:=Edenderecoftplocal.text
   else ftp.Host:=Edenderecoftp.text;

   if trim(Edsenhaftp.text)<>'' then
     ftp.Password:=Edsenhaftp.text
   else
     ftp.Password:='clientes';
   if trim(Edusuarioftp.text)<>'' then
     ftp.Username:=Edusuarioftp.text
   else
     ftp.Username:='clientes';
   ftp.Passive:=true;
   ftp.PassiveUseControlHost:=true;
   ftp.ReadTimeout:=1000;
   if trim(Edportaftp.text)<>'' then ftp.port := strtoint(EdPortaftp.text)
   else ftp.port := 60500;
//   else ftp.port := 9145;

   Arquivonoftp:='PEDM'+copy(EdData.Text,1,2)+copy(EdData.Text,4,2)+copy(EdData.Text,7,4)+'.TXT';
   Arquivonoftp1:='PEDD'+copy(EdData.Text,1,2)+copy(EdData.Text,4,2)+copy(EdData.Text,7,4)+'.TXT';
// 25.06.2021
   Arquivonoftpcli :='CLIE'+copy(EdData.Text,1,2)+copy(EdData.Text,4,2)+copy(EdData.Text,7,4)+'.TXT';

// 19.12.16
//   if trim(EdRepr_codigo.text)<>'' then begin
// 23.05.25 - tentativa de evitar arquivo com 'representante 0' ( zero )
   if (trim(EdRepr_codigo.text)<>'') and (trim(EdRepr_codigo.text)<>'0' ) then begin

     Arquivonoftp:='PEDM'+inttostr(strtoint(EdRepr_codigo.text))+copy(EdData.Text,1,2)+copy(EdData.Text,4,2)+copy(EdData.Text,7,4)+'.TXT';
     Arquivonoftp1:='PEDD'+inttostr(strtoint(EdRepr_codigo.text))+copy(EdData.Text,1,2)+copy(EdData.Text,4,2)+copy(EdData.Text,7,4)+'.TXT';
     Arquivonoftpcli :='CLIE'+inttostr(strtoint(EdRepr_codigo.text))+copy(EdData.Text,1,2)+copy(EdData.Text,4,2)+copy(EdData.Text,7,4)+'.TXT';

   end;

   Lista   :=TStringlist.Create;
   Lista1  :=TStringlist.Create;
   ListaCli:=TStringlist.Create;

   Arquivo:=TStringStream.Create;
   Arquivo1:=TStringStream.Create;
//   Arquivo:=TStream.Create;
//   Arquivo1:=TStream.Create;
//   Arquivo:=TMemoryStream.Create;
//   Arquivo1:=TMemoryStream.Create;
   Mensagem('Lendo pedidos de '+Eddata.Text);
   dm.Q.Sql.Clear;
   dm.Q.SQL.Add('select * from movped where mped_datamvto='+Datetosql(EdDAta.Date));
   dm.Q.Open();
   linha:='';
   while not Dm.Q.Eof do begin

     linha:=Dm.Q.FieldByName('mped_numerodoc').AsString+';'+
            Dm.Q.FieldByName('mped_datamvto').AsString+';'+
            Dm.Q.FieldByName('mped_tipo_codigo').AsString+';'+
            Dm.Q.FieldByName('mped_totprod').AsString+';'+
            Dm.Q.FieldByName('mped_vlrtotal').AsString+';'+
            Dm.Q.FieldByName('mped_fpgt_codigo').AsString+';'+
            Dm.Q.FieldByName('mped_port_codigo').AsString+';'+
// 19.02.18
            Dm.Q.FieldByName('mped_tipomov').AsString+';'+
// 26.08.24 - Vida Nova - numero do pedido do muffato pra tag xped no xml da nota
            Dm.Q.FieldByName('mped_contatopedido').AsString;
//            Dm.Q.FieldByName('mped_repr_codigo').AsString ;
// deixar pegando do cadastro do cliente o representante..
            Lista.Add(linha+chr(10)+chr(13));
     Dm.Q.Next;

   end;

   Dm.Q.Close;
   dm.Q.Sql.Clear;
   dm.Q.SQL.Add('select * from movpeddet where mpdd_datamvto='+Datetosql(EdDAta.Date));
   dm.Q.Open();
   linha:='';
   while not Dm.Q.Eof do begin

     linha:=Dm.Q.FieldByName('mpdd_numerodoc').AsString+';'+
            Dm.Q.FieldByName('mpdd_tipo_codigo').AsString+';'+
            Dm.Q.FieldByName('mpdd_esto_codigo').AsString+';'+
            Dm.Q.FieldByName('mpdd_venda').AsString+';'+
            Dm.Q.FieldByName('mpdd_qtde').AsString +';'+
// 26.08.24 - Vida Nova - data de fabricação do leite para rastreamento
            Dm.Q.FieldByName('mpdd_datamontagem').AsString;
//            Dm.Q.FieldByName('mpdd_repr_codigo').AsString ;
            Lista1.Add(linha+chr(10)+chr(13));
     Dm.Q.Next;

   end;
   Dm.Q.Close;


// 23.06.2021
/////////////
//   if not Dm.TabClientes.Active then  Dm.TabClientes.open;

   dm.Q.close;
   dm.Q.Sql.Clear;
//   dm.Q.SQL.Add('select * from clientes where clie_obs = '+chr(39)+'NOVO'+chr(39) );
   dm.Q.SQL.Add('select * from clientes where clie_obs = '+chr(39)+'NOVO'+chr(39) );

   dm.Q.Open();
   linha:='';
   ListaCodigoscli := TStringList.create;
//   bmsg.text := '';

   while not Dm.Q.Eof do begin

     linha:=Dm.Q.FieldByName('clie_codigo').AsString+';'+
            Dm.Q.FieldByName('clie_nome').AsString+';'+
            Dm.Q.FieldByName('clie_razaosocial').AsString+';'+
            Dm.Q.FieldByName('clie_cnpjcpf').AsString+';'+
            Dm.Q.FieldByName('clie_rgie').AsString+';'+
            Dm.Q.FieldByName('clie_endres').AsString+';'+
            Dm.Q.FieldByName('clie_endcom').AsString+';'+
            Dm.Q.FieldByName('clie_cepres').AsString+';'+
            Dm.Q.FieldByName('clie_cepcom').AsString+';'+
            Dm.Q.FieldByName('clie_bairrores').AsString+';'+
            Dm.Q.FieldByName('clie_bairrocom').AsString+';'+
            Dm.Q.FieldByName('clie_obs').AsString+';'+
            Dm.Q.FieldByName('clie_repr_codigo').AsString+';'+
            Dm.Q.FieldByName('clie_fpgt_codigo').AsString;

            Listacli.Add(linha+chr(10)+chr(13));
            ListacodigosCli.add( Dm.Q.FieldByName('clie_codigo').AsString );

     Dm.Q.Next;

   end;
   Dm.Q.Close;

//   Lista.SaveToStream( arquivo );
//   Lista1.SaveToStream( arquivo1 );
   {$IFDEF ANDROID}
     caminho:=GetHomePath ;
     Arquivot:=caminho+ '/mestre.txt';
     Arquivot1:=caminho+'/detalhe.txt';
     Arquivocli := caminho+'/clientes.txt';

   {$ELSE}

     caminho:=ExtractFilePath( Application.Title ) ;
     Arquivot:=caminho+ '\mestre.txt';
     Arquivot1:=caminho+'\detalhe.txt';
     Arquivocli := caminho+'\clientes.txt';

   {$ENDIF}

////////   showmessage( arquivot );
   Lista.SaveToFile( arquivot, TEncoding.UTF8 );
   Lista1.SaveToFile( arquivot1,  TEncoding.ANSI );

   if ListaCodigoscli.count>0 then

      ListaCli.SAvetoFile( arquivocli ,  TEncoding.UTF8 );


   Mensagem('Conectando no ftp...');
   try
     try
        ftp.Connect();
        AssErt(ftp.Connected);
//        ftpacbr.StartDownload;
     except
       on E:exception do
       mensagem('Problemas para conectar no ftp:'+ftp.Host+':'+inttostr(ftp.Port));
//       Sistema.BeginProcess('Problemas para conectar no ftp:'+ftpacbr.ftp.ftpHost+':'+ftpacbr.ftp.ftpPort+' '+E.Message);
     end;
   finally
//    ftp.ChangeDir('BkpClientes');
// 22.12.16
    if trim(pastanoftp01)<>'' then
      ftp.ChangeDir( PastanoFtp01 );
//    ftp.ChangeDir('Vendasmovel');
// 19.04.16
    if trim(pastanoftp)<>'' then
      ftp.ChangeDir( PastanoFtp );
//      aviso('Problemas para conectar no ftp:'+ftpacbr.ftp.ftpHost+':'+ftpacbr.ftp.ftpPort);
   end;
   mensagem('Enviando pedidos ao ftp');
   try
//     ftp.Put(Arquivo,ArquivonoFtp,true);
//     ftp.SiteToSiteUpload(ftp,Arquivo.DataString,Arquivonoftp);
//     ftp.Site('CHMOD 777 '+ArquivonoFtp);
//     ftp.Put(Lista.ToString,ArquivonoFtp,false);
     ftp.Put(Arquivot,ArquivonoFtp,false);
   except on E:exception do
     mensagem('Problemas para enviar arquivo '+Arquivonoftp+' '+E.message);
   end;
   try
//     ftp.Put(Arquivo1,Arquivonoftp1,false);
//     ftp.Put(Lista1.ToString,Arquivonoftp1,false);
     ftp.Put(Arquivot1,ArquivonoFtp1,false);
   except on E:exception do
     mensagem('Problemas para baixar arquivo '+Arquivonoftp1+' '+E.message);
   end;

// 25.06.2021
   if ListaCli.count>0 then begin

     mensagem('Enviando CLIENTES ao ftp');
     try

       ftp.Put(Arquivocli,ArquivonoFtpcli,false);

// mudo no cadastro do tablet pra não enviar novamente no proximo envio
       for p := 0 to ListaCodigoscli.count do begin

           if length(trim(ListacodigosCli[p]))>3 then begin

             xsql   := 'Update clientes set clie_obs = '+chr(39)+'ENVIADONOVO'+chr(39)+
                       ' where clie_codigo = '+ListaCodigosCli[p];
             Dm.Qclientes.SQL.Clear;
             dm.Qclientes.SQL.Add( xsql );
             dm.Qclientes.ExecSQL;
             dm.Qclientes.Close;

           end;

       end;

//       bmsg.text := 'Clientes '+inttostr(LIstacodigoscli.count);

     except on E:exception do

       mensagem('Problemas para enviar arquivo '+Arquivonoftpcli+' '+E.message);

     end;

   end;

//   List

//   Lista:=TStringList.Create;
//   Lista.LoadFromStream( arquivo );
//   Lista.Add( arquivo.DataString );
//   Lista.AddObject( arquivo.DataString , arquivo );
//   Lista1.AddObject( arquivo1.DataString , arquivo1 );

   benviapedidos.Text:='Término envio';
   benviapedidos.UpdateEffects;
   ftp.Disconnect;
   Lista.Free;Lista1.Free;
end;

procedure TFPedido.bgerapdfClick(Sender: TObject);
var FGerapdf:TGerapdfpedidovenda;
    numero:integer;
    xData:TDatetime;
begin
//    showmessage('acessou geração pdf');

//    numero:=StrToIntDef(sgpedidos.Cells[0,sgpedidos.Row] ,0);
//    assim pega sempre a primeira linha do grid
    numero:=StrToIntDef(sgpedidos.Cells[0,linhaatualsgpedidos] ,0);

//    showmessage('numero='+sgpedidos.Cells[0,linhaatualsgpedidos]);

    if numero>0 then begin
      xData:=StrToDate(sgpedidos.Cells[2,linhaatualsgpedidos]);
//      showmessage('data='+sgpedidos.Cells[2,sgpedidos.Row]);
      FGerapdf:=TGerapdfpedidovenda.Create;
      FGerapdf.Execute(numero,xdata,xunidade);

    end;
end;

procedure TFPedido.bgravarClick(Sender: TObject);
/////////////////////////////////////////////////////
var p         :integer;
    venda,qtde:currency;
    codprod   :string;


     procedure GravaOnline;
    /////////////////////
    begin

           AniIndicator2.Visible := true;
           AniIndicator2.Enabled := true;
//        TLoading.Show(Form1, 'Consultando...');

        TThread.CreateAnonymousThread(procedure
        begin

                gravaonlinex;
                TThread.Synchronize(nil, procedure
                begin
//                        TLoading.Hide;
                  AniIndicator2.Visible := false;
                  AniIndicator2.Enabled := false;
                  ShowMessage('Pedido Enviado');

                end);

        end).Start;

    end;



begin
   if edportador.Text='' then begin
     Showmessage('Checar portador');
     exit;
   end;
   if edcondicao.Text='' then begin
     Showmessage('Checar condição de pagamento');
     exit;
   end;
   if edcodcli.Text='' then begin
     Showmessage('Checar codigo do cliente');
     exit;
   end;
// 23.08.24
   dm.Q.Close;
   dm.Q.SQL.Clear;
   dm.Q.SQL.Add('select conf_clientespedido from config')  ;
   dm.Q.Open();
   if trim(dm.Q.FieldByName('conf_clientespedido').AsString)<>'' then begin
     if (trim(EdPedidoCli.text)='' ) and ( AnsiPos(EdCodcli.Text,dm.Q.FieldByName('conf_clientespedido').AsString)>0 ) then begin
       Showmessage('Checar numero do pedido do cliente');
       exit;
     end;
   end;
   dm.Q.Close;
// 19.02.18
   Tipomov:='PV';
   if rbcomodato.IsChecked then Tipomov:='CM'
   else if rbbonificacao.IsChecked then Tipomov:='BN';

   Dm.Q.SQL.Clear;
   dm.Q.SQL.Add('select mped_status from movped ' );
   dm.Q.Open();
   if dm.q.Eof then
     numerodoc:=1
   else begin
     Dm.Q.SQL.Clear;
     dm.Q.SQL.Add('select max(mped_numerodoc) as ultimo from movped' );
     dm.Q.Open();
     numerodoc:=dm.Q.fieldbyname('ultimo').asinteger+1;
   end;
   if not Dm.TabPedidosM.Active then Dm.TabPedidosM.Open();
   if not Dm.TabPedidosD.Active then Dm.TabPedidosD.Open();
   codcli := EdCodcli.Text;
   codportador := EdPortador.Text;
   TotalPedido := EdValorPedido.Text;
   codfpgt     := EdCondicao.Text;

   if NumPedido=0 then begin


       dm.TabPedidosM.Insert;
       dm.TabPedidosM.FieldByName('mped_status').AsString:='N';
       dm.TabPedidosM.FieldByName('mped_numerodoc').AsInteger:=(numerodoc);
       dm.TabPedidosM.FieldByName('mped_datamvto').AsDatetime:=date();
       dm.TabPedidosM.FieldByName('mped_dataemissao').AsDateTime:=date();
       dm.TabPedidosM.FieldByName('mped_tipo_codigo').AsInteger:=strtoint(EdCodcli.Text);
       dm.TabPedidosM.FieldByName('mped_tipomov').AsString:=Tipomov;
       dm.TabPedidosM.FieldByName('mped_fpgt_codigo').AsString:=EdPortador.Text;
       dm.TabPedidosM.FieldByName('mped_port_codigo').AsString:=Edcondicao.Text;
//       dm.TabPedidosM.FieldByName('mped_vlrtotal').Ascurrency:=CurrencyparaGravar(Edvalorpedido.Text);
       try
//          dm.TabPedidosM.FieldByName('mped_vlrtotal').Ascurrency:=strtocurr(Edvalorpedido.Text);
// assim grava até 999,99
//       dm.TabPedidosM.FieldByName('mped_vlrtotal').Ascurrency:=CurrencyparaGravar(Edvalorpedido.Text);
         dm.TabPedidosM.FieldByName('mped_vlrtotal').Ascurrency:=strtocurr(TiraBarra(Edvalorpedido.Text,'.'));
       except on E:Exception do
           showmessage('Problemas no ascurrency do mped_vlrtotal. Mensagem : '+E.Message+' '+TiraBarra(Edvalorpedido.Text) );
       end;
// 23.08.24
       dm.TabPedidosM.FieldByName('mped_contatopedido').AsString:=EdPedidocli.Text;
// 26.08.24
//       dm.TabPedidosM.FieldByName('mped_repr_codigo').AsString:=EdRepr_codigo.Text;

       try
         dm.TabPedidosM.Post;
       except on E:Exception do
           showmessage('Problemas no post tabpedidosM.post. Mensagem : '+E.Message );
       end;

// 20.09.2021


//       end;


   end else begin

// 13.09.24 - quando apaga pedido de somente 1 item fica sem total do pedido...
      if trim(Edvalorpedido.Text)<>'' then begin
        dm.TabPedidosM.Locate('mped_numerodoc',inttostr(NumPedido));
        dm.TabPedidosM.Edit;
//        dm.TabPedidosM.FieldByName('mped_vlrtotal').Ascurrency:=Strtocurr(Edvalorpedido.Text);
// 19.02.25 - tem  q tirar ponto do milhar para nao dar pau na strtocurr com valor < 999.99
        dm.TabPedidosM.FieldByName('mped_vlrtotal').Ascurrency:=strtocurr(TiraBarra(Edvalorpedido.Text,'.'));
        dm.TabPedidosM.Post;
      end;
   end;

 //  dm.TabPedidosM.CachedUpdates:=true;
//   dm.TabPedidosM.ApplyUpdates;
 // 19.08.24
   try
//      dm.TabPedidosM.CommitUpdates;
     dm.TabPedidosM.ApplyUpdates;
   except on E:Exception do

       showmessage('Problemas na gravação tabpedidosM appy updates. Mensagem : '+E.Message );

   end;

//   dm.TabPedidosM.CachedUpdates:=true;
//   dm.TabPedidosM.CommitUpdates;
   for p:=0 to sg.RowCount-1 do begin

     codprod:=sg.Cells[colcodigo,p];

     if trim(codprod)<>'' then begin

//       qtde  := texttovalor(sg.Cells[colqtde,p]);
//       venda := texttovalor(sg.Cells[colvenda,p]);
       qtde  := strtocurr(sg.Cells[colqtde,p]);
       venda := strtocurr(sg.Cells[colvenda,p]);

       try

       if numpedido>0  then begin

          if dm.TabPedidosd.Locate('mpdd_numerodoc;mpdd_esto_codigo',Vararrayof([inttostr(numpedido),codprod]),[]) then

             dm.TabPedidosd.Edit

          else

             dm.TabPedidosd.Insert;

       end else

          dm.TabPedidosD.Insert;

       //       dm.TabPedidosD.Append;
       dm.TabPedidosd.FieldByName('mpdd_status').AsString:='N';

       if NumPedido>0 then
         dm.TabPedidosd.FieldByName('mpdd_numerodoc').AsInteger:=(numpedido)
       else
         dm.TabPedidosd.FieldByName('mpdd_numerodoc').AsInteger:=(numerodoc);

       dm.TabPedidosd.FieldByName('mpdd_datamvto').AsDatetime:=date();
       dm.TabPedidosd.FieldByName('mpdd_datalcto').AsDatetime:=date();
       dm.TabPedidosd.FieldByName('mpdd_tipo_codigo').AsInteger:=strtoint(EdCodcli.Text);
       dm.TabPedidosd.FieldByName('mpdd_esto_codigo').AsString:=codprod;
       dm.TabPedidosd.FieldByName('mpdd_qtde').AsCurrency:=qtde;
       dm.TabPedidosd.FieldByName('mpdd_venda').Ascurrency:=venda;
// 22.06.2021
       dm.TabPedidosd.FieldByName('mpdd_perdesco').Ascurrency:=strtocurrdef(EdDesconto.text,0);
// 23.08.2024
       dm.TabPedidosd.FieldByName('mpdd_datamontagem').AsDateTime:=StrToDate(sg.Cells[coldataproducao,p]);
// 26.08.24
//      dm.TabPedidosd.FieldByName('mpdd_repr_codigo').AsString:=EdRepr_codigo.Text;

       dm.TabPedidosd.Post;

       except on E:Exception do begin

          showmessage('Problemas no post '+codprod+'. Mensagem : '+E.Message );

       end;

       end;

     end;

   end;

//   dm.TabPedidosd.CachedUpdates:=true;
//  19.08.24
//   dm.TabPedidosd.ApplyUpdates;
   try
 //     dm.TabPedidosD.CommitUpdates;
      dm.TabPedidosd.ApplyUpdates;
   except on E:Exception do

       showmessage('Problemas na gravação tabpedidosD appyupdates. Mensagem : '+E.Message );

   end;


// 07.08.15 - as vezes duplica o pedido
//   dm.TabPedidosM.CachedUpdates:=false;
//   dm.TabPedidosD.CachedUpdates:=false;
// 19.08.24 - retirado

//   dm.TabPedidosD.CachedUpdates:=true;
//   dm.TabPedidosD.CommitUpdates;
   if numpedido>0  then
      showmessage('Pedido '+inttostr(numpedido)+' ALTERADO.')
   else
      showmessage('Pedido '+inttostr(numerodoc)+' gravado.');

   NumPedido:=0;  // para q o proximo seja outro pedido indepentente
   label1.text:='INCLUSÃO';
   rbvenda.IsChecked:=true;
   rbcomodato.IsChecked:=false;
   rbbonificacao.IsChecked:=false;
// 14.10.2021
   if EdOnLine.Text = 'S' then  gravaonline;

   Edvalorpedido.Text:='';
   Edcodcli.Text:='';
   EdNOme.Text:='';
   Edcodpro.text:='';
   EdDescricao.text:='';
   Edqtde.text:='0';
   EdUnitario.Text:='0';
   EdUnitario.UpdateEffects;
   EdPortador.Text:='';
   labelportador.Text:='';
   EdCondicao.Text:='';
   labelcondicao.Text:='';
   EdDescricaoPortador.Text := '';
   EdDescriaofpagto.Text := '';
   EdPedidocli.Text := '';
// 13.08.15
   LimpaGrid( sg );
   sg.RowCount:=0;
   EdValorPedido.Text:='0';
   dm.Q.Close;
// 13.09.24 pra ver se altera sem duplicar
   Dm.TabPedidosM.Close();
   Dm.TabPedidosD.Close();

end;

procedure TFPedido.bpedevaloresClick(Sender: TObject);
var retorno:Currency;
begin
   pvalores.Visible:=False;
   pvalores. Enabled:=False;
   if EdUnidade.text='HS' then  begin

     retorno:=StrToCurrDef(EdFinal.text,0) - StrToCurrDef(EdInicial.text,0);
     if retorno<=0 then
        ShowMessage('Diferença tem que ser maior que zero')
     else
        EdQtde.Text:=CurrToStr(retorno);

   end;

end;

// 14.02.18
procedure TFPedido.cbalterapedidoClick(Sender: TObject);
/////////////////////////////////////////////////////////
begin
   tabc.ActiveTab:=TabItem1;
   TabItem1Click(Self.EdNumPedido);
end;

procedure TFPedido.cbClick(Sender: TObject);
begin
 //  if cb.IsChecked then EdEnderecoftp.Text:='192.168.10.105' else EdEnderecoftp.Text:='storollicia.no-ip.info';
 //  Edenderecoftp.UpdateEffects;

end;

procedure TFPedido.clienteClick(Sender: TObject);
begin

end;

// 03.09.16
procedure TFPedido.CornerButton1Click(Sender: TObject);
/////////////////////////////////////////////////////////////
begin
   if trim(EdCodcli.text)<>'' then begin
     tabc.ActiveTab:=TabItem3;
     TabItem3Click(self.EdCodcli );
   end;
end;

function TFPedido.CurrencyparaGravar(Text: string): currency;
////////////////////////////////////////////////////////////////
var texto : string;
    e     : integer;

begin

  Texto:='';
// tira o ponto do milhar
  for e := 0  to Length(Text) do begin
//      if (Text[e]=',') then begin
//         Texto := Texto + ',' ;
      if (Text[e]='.') then begin
         Texto := Texto  ;
      end else if Text[e] in ['0'..'9','-'] then begin
         Texto := Texto + Text[e];
      end;

  end;
{
  repeat
    p:=Pos(',',Text);
    if p>0 then Text[p]:='.';
  until p=0;
}
  if Texto='' then Texto:='0';

  result := strtocurr( Texto );

//  result := StrToFloat( Texto );


end;

function TFPedido.DateToSql(Dt: TDateTime): String;
////////////////////////////////////////////////////////
//const Meses: Array[1..12] of string = ('jan','feb','mar','apr','may','jun',
//                                       'jul','aug','sep','oct','nov','dec');
const Meses: Array[1..12] of string = ('01','02','03','04','05','06',
                                       '07','08','09','10','11','12');
var sDt,FmtDelphi:String;
begin
  Result := '';
     if Dt>0 then begin
//        FmtDelphi := 'dd"/'+Meses[MonthOf(Dt)]+'/"yyyy';
        FmtDelphi := 'yyyy"-'+Meses[MonthOf(Dt)]+'-"dd';
        sDt := FormatDateTime(FmtDelphi,Dt);
     end else sDt := '';
//     if sDt='' then Result:='CAST(NULL AS DATE)' else Result:='CAST('''+sDt+''' AS DATE)';
     if sDt='' then Result:='CAST(NULL AS DATE)' else Result:='Date('''+sDt+''')';
//     if sDt='' then Result:='CAST(NULL AS DATE)' else Result:=chr(39)+sDt+chr(39);
end;

procedure TFPedido.EdcodproExit(Sender: TObject);
begin
   if EdCodpro.text<>'' then EdQtde.SetFocus;

end;

procedure TFPedido.EdInicialKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if not (KeyChar in ['1','2','3','4','5','6','7','8','9','0',',']) then
     KeyChar :=#0;

end;

procedure TFPedido.Editstogrid;
////////////////////////////////
var linha    :integer;
    totalitem,
    uniliquido :currency;
begin

  sg.RowCount:=sg.RowCount+1;
  linha:=GetLinhaembranco(sg);
  sg.Cells[colcodigo,linha]:=EdCodpro.Text;
  sg.Cells[colnome,linha]:=EdDescricao.Text;
  dm.Q.SQL.Clear;
  dm.Q.SQL.Add('select * from estoque where esto_codigo='+chr(39)+Edcodpro.text+chr(39));
  dm.q.Open();
  sg.Cells[colunidade,linha]:=dm.Q.FieldByName('esto_unidade').AsString;
  sg.Cells[colqtde,linha]:=Edqtde.Text;
  if strtointdef( EdDesconto.text , 0 ) > 0 then  begin

     uniliquido := strtocurr(Edunitario.text) -
                   (
                   strtocurr(Edunitario.text) * ( strtocurr(EdDesconto.text)/100)
                   );
     EdUnitario.text := currtostr(uniliquido);

  end;

  sg.Cells[colvenda,linha]     := Edunitario.Text;
  totalitem                    := strtocurr(edqtde.text)*strtocurr(EdUnitario.text);
  sg.Cells[coltotalitem,linha] := FormatCurr('###.##.##', totalitem );
// 03.08.2021
//  sg.Cells[coltotalitem,linha] := currtostr( totalitem );
// 21.06.2021
  sg.Cells[coldesconto,linha] := EdDesconto.text;
// 23.08.2024
  sg.Cells[coldataproducao,linha] := EdDtproducao.text;
  if NumPedido=0 then
    EdValorPedido.Text:=FormatCurr('###,###0.00',SomaGrid)
  else if trim(EdValorPedido.Text)<>'' then
    EdValorPedido.Text:=FormatCurr('###,###0.00',strtocurr(EdValorPedido.Text)+totalitem)
// 13.09.24
  else
    EdValorPedido.Text:=FormatCurr('###,###0.00',(totalitem));
  EdValorPedido.UpdateEffects;
  EdDesconto.Text:='';

end;

procedure TFPedido.EdQtdeKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin

 ShowMessage('entrou qtdekeydown');
// if UpperCase(sg.Cells[colunidade,sg.Row])='HS' then  begin
 if EdUnidade.text='HS' then  begin

     FPedeValores.Execute;
     EdQtde.Text:=CurrToStr(FPedevalores.retorno)

  end;
end;

procedure TFPedido.EdQtdeTap(Sender: TObject; const Point: TPointF);
begin
// if UpperCase(sg.Cells[colunidade,sg.Row])='HS' then  begin
 if EdUnidade.text='HS' then  begin

//     FPedeValores.Execute;
//     EdQtde.Text:=CurrToStr(FPedevalores.retorno)
     pvalores.Visible:=true;
     pvalores. Enabled:=true;
     EdInicial.SetFocus;

  end;
end;

procedure TFPedido.BaixaApiclientes;
////////////////////////////////////
var ipservidor:string;
    retorno : string;
    LResponse:IResponse;
begin

//     Mensagem('baixando clientes da api',1000);
     if cb.IsChecked then ipservidor:=Edenderecoftplocal.text
     else ipservidor:=Edenderecoftp.text;
     LResponse:=TRequest.New.BaseURL( 'http://'+ipservidor+':'+Edporta.text+'/clientes')
                 .Accept('application/json')
                 .Get;
//                 .Token('Bearer '+FToken)
//                 .AddBody(cJson).Put;
      retorno:=LResponse.Content;
      if LResponse.StatusCode=200 then begin
         Mensagem('incluindo clientes...',1000);
         IncluiClientes(retorno);
      end else
         Mensagem('retorno api='+IntToSTR(LResponse.StatusCode)+'-'+copy(retorno,1,2000),2000);
end;

procedure TFPedido.BaixaApicondicao;
//////////////////////////////////////////
var ipservidor:string;
    retorno : string;
    LResponse:IResponse;

begin

     if cb.IsChecked then ipservidor:=Edenderecoftplocal.text
     else ipservidor:=Edenderecoftp.text;
// 20.02.25 - colocar nos portadores e ver demais..mas q porra...
     if porta='' then porta :=Edporta.Text;
     Mensagem('conectando na api '+ipservidor+':'+porta+'/condicao',1000);
      LResponse:=TRequest.New.BaseURL( 'http://'+ipservidor+':'+porta+'/condicao')
                 .Accept('application/json')
                 .Get;
//                 .Token('Bearer '+FToken)
//                 .AddBody(cJson).Put;
      retorno:=LResponse.Content;
      if LResponse.StatusCode=200 then begin
//         Mensagem('condicao a incluir='+retorno,1000);
        IncluiCondicao(retorno);
      end else
         Mensagem('retorno api='+IntToSTR(LResponse.StatusCode)+'-'+retorno,2000);
end;

procedure TFPedido.BaixaApiportadores;
///////////////////////////////////
var ipservidor:string;
    retorno : string;
    LResponse:IResponse;

begin

//     Mensagem('conectando na api',1000);
     if cb.IsChecked then ipservidor:=Edenderecoftplocal.text
     else ipservidor:=Edenderecoftp.text;
{
     RESTClient1.BaseURL := 'http://'+ipservidor+':'+porta+'/portadores';
     RESTRequest1.Method := TRESTRequestMethod.rmGET;
     Mensagem('url='+RESTClient1.BaseURL,1000);
     RESTRequest1.ClearBody;
     RESTRequest1.Execute;
//     retorno:=RESTResponse1.Content;
//     Corpo   := TJsonObject.Create;
//     CorpoItens := TJsonArray.Create;
//     RESTRequest1.Method:=rmGET;
     if (RESTResponse1.StatusCode = 200) then
        retorno:=RESTRequest1.Response.Content
     else
        retorno:='Statuscode='+IntToStr(RESTResponse1.StatusCode) ;
}
      LResponse:=TRequest.New.BaseURL( 'http://'+ipservidor+':'+Edporta.text+'/portadores')
                 .Accept('application/json')
                 .Get;
//                 .Token('Bearer '+FToken)
//                 .AddBody(cJson).Put;
      retorno:=LResponse.Content;
      if LResponse.StatusCode=200 then begin
//         Mensagem('portadores a incluir='+retorno,1000);
        IncluiPortadores(retorno);
      end else
         Mensagem('retorno api='+IntToSTR(LResponse.StatusCode)+'-'+retorno,2000);
end;

// 13.12.24
procedure TFPedido.BaixaApiprodutos;
//////////////////////////////////////
var ipservidor:string;
    retorno : string;
    LResponse:IResponse;
begin

     Mensagem('baixando produtos da api',1000);
     if cb.IsChecked then ipservidor:=Edenderecoftplocal.text
     else ipservidor:=Edenderecoftp.text;
     LResponse:=TRequest.New.BaseURL( 'http://'+ipservidor+':'+Edporta.Text+'/produtos')
                 .Accept('application/json')
                 .Get;
//                 .Token('Bearer '+FToken)
//                 .AddBody(cJson).Put;
      retorno:=LResponse.Content;
      if LResponse.StatusCode=200 then begin
         Mensagem('incluindo produtos...',1000);
         IncluiProdutos(retorno);
      end else
         Mensagem('retorno api='+IntToSTR(LResponse.StatusCode)+'-'+copy(retorno,1,2000),2000);
end;

procedure TFPedido.FormActivate(Sender: TObject);
//////////////////////////////////////////////////////
var x:TEdit;
    Lista:TStringList;
begin

  pvalores.Visible:=False;
  pvalores. Enabled:=False;
  x:=TEdit.Create(self);
//  EdQtde.KeyboardType:=x.KeyboardType.vktNumberPad;
  EdQtde.KeyboardType:=TVirtualKeyboardType.NumberPad;
  ultimos:='N';
//  EdUnitario.KeyboardType:=x.KeyboardType.vktNumberPad;
// 07.08.15 - tablet samsung nao libera virgula...
//  EdUnitario.KeyboardType:=x.KeyboardType.vktNumbersAndPunctuation;
// 24.06.24 - ajustes delphi 11.3
  EdUnitario.KeyboardType:=TVirtualKeyboardType.NumbersAndPunctuation;
// 15.09.25
  linhaatualsgpedidos:=-1;
  Lista:=TStringList.Create;
  if not dm.conexao.Connected then dm.conexao.Connected:=true;
  dm.conexao.GetTableNames('', '', '', Lista );
  mensagem('checando tabela config em '+inttostr(lista.Count)+' tabelas');
  if Lista.IndexOf('config')<>-1 then begin

    mensagem('achou tabela config no banco de dados');
    dm.Q.SQL.Clear;
    dm.Q.SQL.Add('select * from config')  ;
    dm.Q.Open();
    if not dm.Q.eof then begin

      Edenderecoftp.Text:=dm.Q.fieldbyname('conf_enderecoftp').asstring;
      if TemCampo('config','conf_enderecoftplocal') then
         Edenderecoftplocal.Text:=dm.Q.fieldbyname('conf_enderecoftplocal').asstring;
      Edpasta01ftp.Text:=dm.Q.fieldbyname('conf_pasta01ftp').asstring;
      Edpasta02ftp.Text:=dm.Q.fieldbyname('conf_pasta02ftp').asstring;
//      Edporta.Text:=dm.Q.fieldbyname('conf_portaftp').asstring;
// 27.01.25
      Edportaftp.Text:=dm.Q.fieldbyname('conf_portaftp').asstring;
      if TemCampo('config','conf_portaapi') then begin
        Edporta.Text:=dm.Q.fieldbyname('conf_portaapi').asstring;
// 19.12.24
        porta := dm.Q.fieldbyname('conf_portaapi').asstring;
      end;
// 19.12.16
      Edrepr_codigo.Text:=inttostr(dm.Q.fieldbyname('conf_repr_codigo').asinteger);
      EdUsuarioftp.Text:=dm.Q.fieldbyname('conf_usuarioftp').asstring;
      EdSenhaftp.Text:=dm.Q.fieldbyname('conf_senhaftp').asstring;
// 20.07.2021
      EdSupe_codigo.Text:=inttostr(dm.Q.fieldbyname('conf_supe_codigo').asinteger);
//      mensagem('achou tabela config |'+dm.Q.fieldbyname('conf_pasta02ftp').asstring+'|');
// 21.10.2021
      if TemCampo('config','conf_online') then begin

         EdOnline.text := dm.Q.fieldbyname('conf_online').asstring ;

      end;
// 28.08.2024
      if TemCampo('config','conf_clientespedido') then begin

         EdClientesPedidos.Text:=dm.Q.fieldbyname('conf_clientespedido').asstring ;

      end;

    end else

      mensagem('tabela config vazia');
    pastanoftp:=EdPasta02ftp.Text;
    pastanoftp01:=EdPasta01ftp.Text;
    dm.Q.Close;
  end;

end;

function TFPedido.FormataData(data: TDatetime; ano: boolean): string;
//////////////////////////////////////////////////////////////////////////////
begin

  if data>1 then begin
    result:=formatdatetime('dd/mm/yy',data);
    if ano then result:=formatdatetime('dd/mm/yyyy',data);

  end else
    result:='        ';

end;

function TFPedido.FormataDataJson(data: TDatetime; ano: boolean): string;
//////////////////////////////////////////////////////////////////////////////
begin

  if data>1 then begin
    result:=formatdatetime('yy-mm-dd',data);
    if ano then result:=formatdatetime('yyyy-mm-dd',data);

  end else
    result:='        ';

end;

procedure TFPedido.ftpWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
   benviapedidos.Text:='Enviando';
   benviapedidos.UpdateEffects;
end;

procedure TFPedido.ftpWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
   benviapedidos.Text:='Inicio envio';
   benviapedidos.UpdateEffects;

end;

procedure TFPedido.ftpWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
   benviapedidos.Text:='Enviado';
   benviapedidos.UpdateEffects;

end;

function TFPedido.GetLinhaembranco(xsg: TStringgrid):integer;
/////////////////////////////////////////////////////////////
var i,ret:integer;
begin
  ret:=0;
  for I := 0 to xsg.RowCount-1 do begin
    if trim(xsg.Cells[0,i])='' then begin
      ret:=i;
      break;
    end;
  end;
  result:=ret
end;


procedure TFPedido.GravaOnlineX;
/////////////////////////////////
var i       : integer;
    qtdec,
    vendac,
    codprod  : string;
    Corpo,
    Corpod1  : TJsonObject;
    CorpoItens: TJSONArray;

begin

    begin

           RESTClient1.BaseURL := 'http://192.168.10.161:8082/api/novopedido';
           Corpo   := TJsonObject.Create;
           CorpoItens := TJsonArray.Create;

           Corpo.AddPair('mped_unid_codigo',xunidade);
           Corpo.AddPair('mped_numerodoc',inttostr(numerodoc));
           Corpo.AddPair('mped_tipo_codigo',Codcli);
//           Corpo.AddPair('mped_datamvto',DateTimeToStr( Date() ) );
//           Corpo.AddPair('mped_datamvto',DateToSql( Date() ) );
           Corpo.AddPair('mped_datamvto',FormataDataJson( Date(),true ) );
           Corpo.AddPair('mped_vlrtotal',TotalPedido );
           Corpo.AddPair('mped_fpgt_codigo',codfpgt);
           Corpo.AddPair('mped_port_codigo',codportador);
           Corpo.AddPair('mped_fpgt_prazos',DM.TabFpgto.FieldByName('fpgt_prazos').AsString);

           for i:=0 to sg.RowCount-1 do begin

              codprod := sg.Cells[colcodigo,i];
              if trim(codprod) <> '' then begin

                 qtdec  := (sg.Cells[colqtde,i]);
                 vendac := (sg.Cells[colvenda,i]);
                 CorpoD1 := TJSONObject.Create;;
                 Corpod1.AddPair('mpdd_unid_codigo',xunidade);
                 Corpod1.AddPair('mpdd_numerodoc',inttostr(numerodoc));
                 Corpod1.AddPair('mpdd_tipo_codigo',Codcli);
                 Corpod1.AddPair('mpdd_esto_codigo',codprod);
                 Corpod1.AddPair('mpdd_qtde',qtdec);
                 Corpod1.AddPair('mpdd_venda',vendac);

                 CorpoItens.Add(Corpod1);
                 Corpod1.Free;

              end;

           end;

           Corpo.AddPair('Itens',CorpoItens);

           RestRequest1.AddBody( corpo );

//           memo1.Lines.clear;
//           memo1.Lines.Add('Pedido Enviado' );

//           ShowMessage('Pedido Enviado');
           RESTRequest1.Method := TRESTRequestMethod.rmPOST;
           RESTRequest1.Execute;

    end;

end;

// 02.09.24
procedure TFPedido.IncluiClientes(cjson: string);
/////////////////////////////////////////////////
var obj:TJSONObject;
    portadoresApi:TJSONArray;
    Clientes:TClientes;
    ListaClientes:TObjectList<TClientes>;
    p:integer;
begin

//    mensagem('parse no '+copy(cjson,1,2000)+' montando obj');
    obj := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(cjson), 0) as TJSONObject;
//    mensagem('formando array de Clientes');
    portadoresApi := obj.GetValue<TJSONArray>('clientes');
//    mensagem('percorrendo array de Clientes');
    ListaClientes:=TObjectList<TClientes>.Create;
    for p := 0 to portadoresApi.Size - 1 do begin
      Clientes:=TClientes.Create;
      Clientes.Clie_Codigo:=portadoresApi[p].GetValue<integer>('clie_codigo');
      Clientes.Clie_Nome:=(portadoresApi[p].GetValue<string>('clie_nome'));
      Clientes.Clie_Razaosocial:=(portadoresApi[p].GetValue<string>('clie_razaosocial'));
      Clientes.Clie_Cidade:=(portadoresApi[p].GetValue<string>('clie_cidade'));
      Clientes.Clie_Cnpjcpf:=(portadoresApi[p].GetValue<string>('clie_cnpjcpf'));
      ListaClientes.Add(Clientes);
    end;
    if ListaClientes.Count>0 then begin
       if not dm.conexao.Connected then dm.conexao.Connected:=true;
//       mensagem('Apagando clientes do sistema');
       dm.Q.Close;
       dm.Q.sql.Clear;
       dm.Q.sql.Add('delete from clientes');
       dm.Q.ExecSQL;
       dm.Q.Close;
//       mensagem('Incluindo clientes no sistema',2000);
       if not Dm.TabClientes.Active then Dm.TabClientes.Open();
       for p:=0 to Pred(ListaClientes.Count) do begin
         dm.TabClientes.Insert;
         dm.TabClientes.FieldByName('clie_codigo').asinteger:=Listaclientes[p].Clie_Codigo;
         dm.TabClientes.FieldByName('clie_nome').asstring:=Listaclientes[p].Clie_Nome;
         dm.TabClientes.FieldByName('clie_razaosocial').asstring:=Listaclientes[p].Clie_Razaosocial;
         dm.TabClientes.FieldByName('clie_cidade').asstring:=Listaclientes[p].Clie_Cidade;
         dm.TabClientes.FieldByName('clie_cnpjcpf').asstring:=Listaclientes[p].Clie_Cnpjcpf;
         dm.TabClientes.Post;
       end;
       if (ListaClientes.Count>0) then begin
         dm.TabClientes.CachedUpdates:=true;
         dm.TabClientes.CommitUpdates;
       end;
    end;
    mensagem('Incluido '+IntToStr(ListaClientes.Count)+' Clientes no sistema');
    FreeandNIl(ListaClientes);
    Dm.TabClientes.Close();
end;

procedure TFPedido.IncluiCondicao(cjson: string);
//////////////////////////////////////////////////////////
var obj:TJSONObject;
    portadoresApi:TJSONArray;
    Portadores:TCondicao;
    ListaPortadores:TObjectList<TCondicao>;
    p:integer;
begin

//    mensagem('parse no '+cjson+' montando obj');
    obj := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(cjson), 0) as TJSONObject;
//    mensagem('formando array de condicao de pagamento');
    portadoresApi := obj.GetValue<TJSONArray>('condicao');
    mensagem('percorrendo array de portadores');
    ListaPortadores:=TObjectList<TCondicao>.Create;
    for p := 0 to portadoresApi.Size - 1 do begin
      Portadores:=TCondicao.Create;
      Portadores.Fpgt_Codigo:=(portadoresApi[p].GetValue<string>('fpgt_codigo'));
      Portadores.fpgt_Descricao:=(portadoresApi[p].GetValue<string>('fpgt_descricao'));
      Portadores.fpgt_prazos:=portadoresApi[p].GetValue<string>('fpgt_prazos');
      ListaPortadores.Add(Portadores);
    end;
//{
    if ListaPortadores.Count>0 then begin
       if not dm.conexao.Connected then dm.conexao.Connected:=true;
       mensagem('Apagando condição do sistema');
       dm.Q.Close;
       dm.Q.sql.Clear;
       dm.Q.sql.Add('delete from fpgto');
       dm.Q.ExecSQL;
       dm.Q.Close;
       mensagem('Incluindo condicao no sistema',2000);
       if not Dm.TabFpgto.Active then Dm.TabFpgto.Open();
       for p:=0 to Pred(ListaPortadores.Count) do begin
         dm.TabFpgto.Insert;
         dm.TabFpgto.FieldByName('fpgt_codigo').asstring:=ListaPortadores[p].Fpgt_Codigo;
         dm.TabFpgto.FieldByName('fpgt_descricao').asstring:=ListaPortadores[p].Fpgt_Descricao;
         dm.TabFpgto.FieldByName('fpgt_prazos').asstring:=ListaPortadores[p].Fpgt_prazos;
         dm.TabFpgto.Post;
       end;
       if (ListaPortadores.Count>0) then begin
         dm.TabFpgto.CachedUpdates:=true;
         dm.TabFpgto.CommitUpdates;
       end;
    end;
    mensagem('Incluido '+IntToStr(ListaPortadores.Count)+' condições no sistema');
//    }
    FreeandNIl(ListaPortadores);
    Dm.TabFpgto.Close();
end;

procedure TFPedido.IncluiPortadores(cjson: string);
////////////////////////////////////////////////////
var obj:TJSONObject;
    portadoresApi:TJSONArray;
    Portadores:TClassePortadores;
    ListaPortadores:TObjectList<TClassePortadores>;
    p:integer;
begin

//    mensagem('parse no '+cjson+' montando obj');
    obj := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(cjson), 0) as TJSONObject;
//    mensagem('formando array de portadores');
    portadoresApi := obj.GetValue<TJSONArray>('portadores');
//    mensagem('percorrendo array de portadores');
    ListaPortadores:=TObjectList<TClassePortadores>.Create;
    for p := 0 to portadoresApi.Size - 1 do begin
      Portadores:=TClassePortadores.Create;
      Portadores.Codigo:=(portadoresApi[p].GetValue<string>('port_codigo'));
      Portadores.Descricao:=(portadoresApi[p].GetValue<string>('port_descricao'));
      Portadores.Conta:=StrtoIntDef(portadoresApi[p].GetValue<string>('port_plan_conta'),0);
      ListaPortadores.Add(Portadores);
    end;
//{
    if ListaPortadores.Count>0 then begin
       if not dm.conexao.Connected then dm.conexao.Connected:=true;
//       mensagem('Apagando portadores do sistema');
       dm.Q.Close;
       dm.Q.sql.Clear;
       dm.Q.sql.Add('delete from portadores');
       dm.Q.ExecSQL;
       dm.Q.Close;
//       mensagem('Incluindo portadores no sistema',2000);
       if not Dm.TabPortadores.Active then Dm.TabPortadores.Open();
       for p:=0 to Pred(ListaPortadores.Count) do begin
         dm.TabPortadores.Insert;
         dm.TabPortadores.FieldByName('port_codigo').asstring:=ListaPortadores[p].Codigo;
         dm.TabPortadores.FieldByName('port_descricao').asstring:=ListaPortadores[p].Descricao;
//         dm.TabPortadores.FieldByName('port_plan_codigo').asinteger:=ListaPortadores[p].Conta;
         dm.TabPortadores.Post;
       end;
       if (ListaPortadores.Count>0) then begin
         dm.TabPortadores.CachedUpdates:=true;
         dm.TabPortadores.CommitUpdates;
       end;
    end;
    mensagem('Incluido '+IntToStr(ListaPortadores.Count)+' portadores no sistema');
//    }
    FreeandNIl(ListaPortadores);
    Dm.TabPortadores.Close();
end;

// 13.12.24
procedure TFPedido.IncluiProdutos(cjson: string);
////////////////////////////////////////////////////
var obj:TJSONObject;
    portadoresApi:TJSONArray;
    Produtos:TProdutos;
    ListaProdutos:TObjectList<TProdutos>;
    p:integer;
begin

    mensagem('parse no '+copy(cjson,1,2000)+' montando obj');
    obj := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(cjson), 0) as TJSONObject;
    mensagem('formando array de Produtos');
    portadoresApi := obj.GetValue<TJSONArray>('produtos');
    ListaProdutos:=TObjectList<TProdutos>.Create;
    for p := 0 to portadoresApi.Size - 1 do begin
      Produtos:=TProdutos.Create;
      Produtos.Esto_Codigo:=portadoresApi[p].GetValue<string>('esto_codigo');
      Produtos.Esto_Descricao:=(portadoresApi[p].GetValue<string>('esto_descricao'));
      Produtos.Esto_Descricao:=TiraBarra(Produtos.Esto_Descricao,'"','');
      Produtos.Esto_Unidade:=(portadoresApi[p].GetValue<string>('esto_unidade'));
      Produtos.Esto_Imagem:=(portadoresApi[p].GetValue<string>('esto_imagem'));
      Produtos.Esto_Desconto:=(portadoresApi[p].GetValue<Double>('esto_desconto'));
//      Produtos.Esqt_Qtde:=(portadoresApi[p].GetValue<Double>('esqt_qtde'));
      Produtos.Esqt_Qtde:=StrToFloat(portadoresApi[p].GetValue<String>('esqt_qtde'));
//      Produtos.Esqt_Vendavis:=(portadoresApi[p].GetValue<Double>('esqt_vendavis'));
      Produtos.Esqt_Vendavis:=StrToFloat(portadoresApi[p].GetValue<String>('esqt_vendavis'));
//      mensagem('percorrendo array de Produtos '+Produtos.Esto_Codigo);
      ListaProdutos.Add(Produtos);
    end;
    if ListaProdutos.Count>0 then begin
       if not dm.conexao.Connected then dm.conexao.Connected:=true;
       mensagem('Apagando produtos do sistema');
       dm.Q.Close;
       dm.Q.sql.Clear;
       dm.Q.sql.Add('delete from estoque');
       dm.Q.ExecSQL;
       dm.Q.Close;
       if not Dm.TabProdutos.Active then Dm.TabProdutos.Open();
       mensagem('Incluindo '+IntToStr(ListaProdutos.Count)+' produtos no sistema',2000);
       for p:=0 to Pred(ListaProdutos.Count) do begin
         dm.TabProdutos.Insert;
         dm.TabProdutos.FieldByName('esto_codigo').asstring:=Listaprodutos[p].Esto_Codigo;
         dm.TabProdutos.FieldByName('esto_descricao').asstring:=(Listaprodutos[p].Esto_Descricao);
         dm.TabProdutos.FieldByName('esto_unidade').asstring:=Listaprodutos[p].Esto_Unidade;
         dm.TabProdutos.FieldByName('esto_imagem').asstring:=Listaprodutos[p].Esto_Imagem;
         dm.TabProdutos.FieldByName('esto_desconto').AsCurrency:=Listaprodutos[p].Esto_Desconto;
         try
           dm.TabProdutos.Post;
         except
//         on E:Exception do
           raise Exception.Create('Problema no post do produto '+Listaprodutos[p].Esto_Codigo+' - '+Listaprodutos[p].Esto_Descricao);
         end;
//         mensagem('Post no produto '+Listaprodutos[p].Esto_Codigo+' - '+Listaprodutos[p].Esto_Descricao,00);
       end;
       if (ListaProdutos.Count>0) then begin
         mensagem('Efetuando a gravação dos produtos no sistema',2000);
         try
           dm.TabProdutos.CachedUpdates:=true;
           dm.TabProdutos.CommitUpdates;
         except
//         on E:Exception do
           raise Exception.Create('Problema no commitupdates dos produtos');
         end;
       end;
    end;
    mensagem('Incluido '+IntToStr(ListaProdutos.Count)+' Produtos no sistema');
    Dm.TabProdutos.Close();
// atualiza os precos...
    if ListaProdutos.Count>0 then begin
       if not dm.conexao.Connected then dm.conexao.Connected:=true;
       mensagem('Apagando precos do sistema');
       dm.Q.Close;
       dm.Q.sql.Clear;
       dm.Q.sql.Add('delete from estoqueqtde');
       dm.Q.ExecSQL;
       dm.Q.Close;
       mensagem('Incluindo precos no sistema',1000);
       if not Dm.TabPrecos.Active then Dm.TabPrecos.Open();
       for p:=0 to Pred(ListaProdutos.Count) do begin

         dm.TabPrecos.Insert;
         dm.TabPrecos.FieldByName('esqt_esto_codigo').asstring:=Listaprodutos[p].Esto_Codigo;
         dm.TabPrecos.FieldByName('esqt_qtde').AsCurrency:=(Listaprodutos[p].Esqt_Qtde);
         dm.TabPrecos.FieldByName('esqt_vendavis').ascurrency:=Listaprodutos[p].Esqt_Vendavis;
         try
           dm.TabPrecos.Post;
         except
//         on E:Exception do
           raise Exception.Create('Problema no post do produto '+Listaprodutos[p].Esto_Codigo);
         end;
//         mensagem('Post no PREÇO do produto '+Listaprodutos[p].Esto_Codigo+' - '+Listaprodutos[p].Esto_Descricao,00);

       end;
       if (ListaProdutos.Count>0) then begin
         try
           dm.TabPrecos.CachedUpdates:=true;
           dm.TabPrecos.CommitUpdates;
         except
//         on E:Exception do
           raise Exception.Create('Problema no commitupdates dos preços ');
         end;
       end;
    end;
    mensagem('Incluido '+IntToStr(ListaProdutos.Count)+' Preços no sistema');
    Dm.TabPrecos.Close();
    ListaProdutos.Clear;
end;

procedure TFPedido.lbimpclientesClick(Sender: TObject);
begin

end;

// 13.08.15
procedure TFPedido.LimpaGrid(Grid: TStringGrid);
//////////////////////////////////////////////////
var i:integer;
begin
   for i := 0 to Grid.RowCount-1 do begin
     Grid.Cells[colcodigo,i]:='';
     Grid.Cells[colnome,i]:='';
     Grid.Cells[colqtde,i]:='';
     Grid.Cells[colvenda,i]:='';
   end;

end;

procedure TFPedido.mensagem(xmens:string;tempo:integer=0);
//////////////////////////////////////////
begin
   lmens.Text:=xmens;
//   lmens.UpdateEffects;
//   Application.ProcessMessages;
   Sleep( tempo );
end;


procedure TFPedido.sbimpclientesapiClick(Sender: TObject);
////////////////////////////////////////////////////////////
begin
        AniIndicator1.Visible := true;
        AniIndicator1.Enabled := true;
        Mensagem('baixando clientes da api',1000);
//{
        TThread.CreateAnonymousThread(procedure
        begin

                BaixaApiclientes;
                TThread.Synchronize(nil, procedure
                begin
//                        TLoading.Hide;
                   AniIndicator1.Visible := false;
                   AniIndicator1.Enabled := false;

                end);

        end).Start;

//}
// se for em thread dá msg 'duplicates not allowed'
{
        BaixaApiClientes;
        AniIndicator1.Visible := false;
        AniIndicator1.Enabled := false;
//        Mensagem('terminado de baixar clientes da api',1000);
//}

end;

procedure TFPedido.sbimpclientesClick(Sender: TObject);
/////////////////////////////////////////////////////
var Arquivonoftp:string;
    Arquivo:TStringStream;
    Lista,ListaTabelas:TStringlist;
begin

   Mensagem('Verificando conexão com ftp...',1000);

//   sbimpclientes.Text := 'Verificando conexão com ftp';
 //  sbimpclientes.UpdateEffects;

//   ftp.Disconnect;
// 14.08.24
   if ftp.Connected then ftp.Disconnect;
   if cb.IsChecked then ftp.Host:=Edenderecoftplocal.text
   else ftp.Host:=Edenderecoftp.text;

   ftp.port := strtoint(EdPortaftp.text);
   if trim(Edsenhaftp.text)<>'' then
     ftp.Password:=Edsenhaftp.text
   else
     ftp.Password:='clientes';
   if trim(Edusuarioftp.text)<>'' then
     ftp.Username:=Edusuarioftp.text
   else
     ftp.Username:='clientes';
   ftp.Passive:=true;
   ftp.ReadTimeout:=10000;
//   ftp.PassiveUseControlHost:=true;
// 14.08.24
   ftp.TransferType := ftBinary;
   Arquivonoftp:='scriptcliente.sql';
   Lista:=TStringlist.Create;
   ListaTabelas:=TStringlist.Create;
   Arquivo:=TStringStream.Create;
   Mensagem('Conectando no ftp...',1000);
   try
     try
//        ftp.Connect(true,10000);
        ftp.Connect();
//        ftpacbr.StartDownload;
     except
       on E:exception do
       mensagem('Problemas para conectar no ftp:'+ftp.Host+':'+inttostr(ftp.Port));
//       Sistema.BeginProcess('Problemas para conectar no ftp:'+ftpacbr.ftp.ftpHost+':'+ftpacbr.ftp.ftpPort+' '+E.Message);
     end;
   finally
//    ftp.ChangeDir('BkpClientes');
// 13.01.2021
    pastanoftp  :=EdPasta02ftp.Text;
    pastanoftp01:=EdPasta01ftp.Text;
/////////////////
///
// 22.12.16
    Mensagem('Mudando de pasta no ftp '+pastanoftp01,1000);
    if trim(pastanoftp01)<>'' then
      ftp.ChangeDir( PastanoFtp01 );
//    ftp.ChangeDir('Vendasmovel');
// 19.04.16
//    if trim(pastanoftp)<>'' then
//      ftp.ChangeDir( PastanoFtp );
   // 26.09.19
    if trim(EdPasta02ftp.Text)<>'' then begin

      Mensagem('Mudando de pasta no ftp '+edpasta02ftp.text,1000);
      ftp.ChangeDir( EdPasta02ftp.Text );

    end;
//      aviso('Problemas para conectar no ftp:'+ftpacbr.ftp.ftpHost+':'+ftpacbr.ftp.ftpPort);
   end;
// busca script de inclusao de clientes
//   mensagem('Clientes :'+ftp.Host+':'+inttostr(ftp.Port)+' '+Pastanoftp01+' '+EdPasta02ftp.Text,1500);
   mensagem('Clientes: Arquivo '+arquivonoftp+' Pastas '+Pastanoftp01+' '+EdPasta02ftp.Text,1500);
   try
    ftp.Get(Arquivonoftp,Arquivo,true);
   except on E:exception do
     mensagem('Problemas para baixar arquivo '+Arquivonoftp+' '+E.message,1000);
   end;


//   Lista:=TStringList.Create;
//   Lista.Duplicates:=dupIgnore;
// 14.08.24
   Lista.Duplicates:=dupAccept;
//   Lista.LoadFromStream( arquivo );
//   Lista.Add( arquivo.DataString );
   Lista.AddObject( arquivo.DataString , arquivo );
   ftp.Disconnect;
   if not dm.conexao.Connected then dm.conexao.Connected:=true;
   dm.conexao.GetTableNames('', '', '', ListaTabelas );
   mensagem('Apagando clientes do sistema',1500);
   if ListaTabelas.IndexOf('clientes')<>-1 then  ApagaTAbela('clientes');


//   dm.IncluiClientes.Close;
//   dm.IncluiClientes.sql.Clear;
//   dm.IncluiClientes.sql.Add('Truncate table clientes');
//   dm.IncluiClientes.sql.Add('Truncate clientes');
//   dm.IncluiClientes.sql.Add('delete from clientes');
// 12.04.17
   mensagem('Incluindo os clientes no sistema',500);

   dm.IncluiClientes.Close;
   dm.IncluiClientes.sql.Clear;
   dm.IncluiClientes.sql.Add(Lista.Text);

//   showmessage( lista.Text ) ;
//   mensagem('no execsql ');

   try
      dm.IncluiClientes.ExecSQL;
   except
      mensagem('Problema na inclusão de cliente',5000);
   end;
   dm.IncluiClientes.Close;
{
   mensagem('Verificando nomes acima de 60 caracteres');
   dm.TabClientes.Open();
   while not dm.TabClientes.Eof do begin

     if length(trim(dm.TabClientes.FieldByName('clie_razaosocial').AsString))>60 then begin

        dm.TabClientes.Edit;
        dm.TabClientes.FieldByName('clie_razaosocial').AsString :=
        copy(dm.TabClientes.FieldByName('clie_razaosocial').AsString,1,60);
        dm.TabClientes.Post;

     end;
     dm.TabClientes.Next;

   end;
   dm.TabClientes.Close;
}
   Lista.Free;
   ListaTabelas.Free;
   mensagem('Terminado');


end;

procedure TFPedido.sbclientesClick(Sender: TObject);
begin
  if trim(EdCodcli.Text)<>'' then
     EdNome.Text:=FClientes.GetNome( EdCodcli.Text )
  else
    FClientes.Show;

end;

procedure TFPedido.sbcondicaoClick(Sender: TObject);
var x: IFMXVirtualKeyboardService;
begin
   FPgto.show;
   x:=TPlatformServices.Current.GetPlatformService(IFMXVirtualKeyboardService) as IFMXVirtualKeyboardService;
   if  TVirtualKeyboardState.Visible in x.VirtualKeyBoardState then
             x.HideVirtualKeyboard;
end;

procedure TFPedido.sbconfirmaClick(Sender: TObject);
/////////////////////////////////////////////////////////
var vuni:currency;
    x: IFMXVirtualKeyboardService;
    podedardesconto : boolean;

begin

// 13.09.24
   if trim(EdCodpro.Text)='' then begin

      Showmessage('Obrigatório informar codigo do produto');
      exit;

   end;

// 20.07.2021
   podedardesconto := false;
   if strtointdef(EdSupe_codigo.text,0) <> 0 then begin

      dm.Q.SQL.Clear;
      dm.Q.SQL.Add('select * from config')  ;
      dm.Q.Open();
      if not dm.Q.eof then  begin

         if trim(dm.Q.fieldbyname('conf_supe_codigo').asstring) = trim(EdSupe_codigo.text) then

            podedardesconto := true;

      end;
      dm.Q.Close;

   end;

   if TryStrToCurr(edunitario.Text,vuni) then begin
// 21.06.2021
     if StrToCurrDef(eddesconto.text,0) <= strtocurrdef(EdDescontoMaximo.text,0)  then begin

         if StrToCurrDef(edqtde.text,0)*strtocurrdef(EdUnitario.text,0)>0  then begin

           x:=TPlatformServices.Current.GetPlatformService(IFMXVirtualKeyboardService) as IFMXVirtualKeyboardService;
           if  TVirtualKeyboardState.Visible in x.VirtualKeyBoardState then

                 x.HideVirtualKeyboard;

           Editstogrid;

         end else

            showmessage('Checar quantidade e preço informado');

     end else if not podedardesconto  then begin


            showmessage('Desconto máximo permitido é '+EdDescontomaximo.text);

     end else if podedardesconto then begin

         if StrToCurrDef(edqtde.text,0)*strtocurrdef(EdUnitario.text,0)>0      then begin

           x:=TPlatformServices.Current.GetPlatformService(IFMXVirtualKeyboardService) as IFMXVirtualKeyboardService;
           if  TVirtualKeyboardState.Visible in x.VirtualKeyBoardState then

                 x.HideVirtualKeyboard;

           Editstogrid;

         end else

            showmessage('Checar quantidade e preço informado');

     end;

   end else

      showmessage('Informar o preço usando somente a vírgula');

end;

procedure TFPedido.sbcriabancoClick(Sender: TObject);
///////////////////////////////////////////////////////////
var Lista:TStringList;

    procedure ApagaTabela(xtab:string);
    //////////////////////////////////
    begin
     dm.Q.SQL.Clear;
     dm.Q.SQL.Add('drop table '+xtab);
     dm.Q.ExecSQL;
     dm.Q.Close;
    end;


begin
   Lista:=TStringList.Create;
   if not dm.conexao.Connected then dm.conexao.Connected:=true;
//   dm.conexao.GetTableNames( dm.conexao.GetCatalogNames(cata,Lista), dm.conexao.GetSchemaNames(cata,'',Lista) ,'', Lista);
   dm.conexao.GetTableNames('', '', '', Lista );
   if Lista.IndexOf('clientes')<>-1 then ApagaTAbela('clientes');
   if Lista.IndexOf('estoque')<>-1 then  ApagaTAbela('estoque');
   if Lista.IndexOf('estoqueqtde')<>-1 then ApagaTAbela('estoqueqtde');
   if Lista.IndexOf('movped')<>-1 then ApagaTAbela('movped');
   if Lista.IndexOf('movpeddet')<>-1 then ApagaTAbela('movpeddet');
   if Lista.IndexOf('portadores')<>-1 then ApagaTAbela('portadores');
   if Lista.IndexOf('fpgto')<>-1 then ApagaTAbela('fpgto');
   if Lista.IndexOf('config')<>-1 then ApagaTAbela('config');

   mensagem('Criando tabelas');
   dm.CriaBanco.Close;
   dm.CriaBanco.ExecSQL;
   dm.CriaBanco.Close;
   mensagem('Terminado');

end;

procedure TFPedido.sbcriaclientesClick(Sender: TObject);
///////////////////////////////////////////////////////////
var   Lista:TStringList;
begin
   Lista:=TStringList.Create;
   if not dm.conexao.Connected then dm.conexao.Connected:=true;
   dm.conexao.GetTableNames('', '', '', Lista );
   if Lista.IndexOf('clientes')<>-1 then  ApagaTAbela('clientes');
   mensagem('Criando tabelas de clientes');
   dm.CriaTabelasCliente.Close;
   dm.CriaTabelasCliente.ExecSQL;
   dm.CriaTabelasCliente.Close;
   mensagem('Terminado');
end;

// 19.12.16
procedure TFPedido.sbcriaconfigClick(Sender: TObject);
///////////////////////////////////////////////////////
var   Lista:TStringList;
begin

   Lista:=TStringList.Create;
   if not dm.conexao.Connected then dm.conexao.Connected:=true;
   dm.conexao.GetTableNames('', '', '', Lista );
   if Lista.IndexOf('config')<>-1 then begin
     dm.Q.SQL.Clear;
//     dm.Q.SQL.Add(' alter table config add conf_repr_codigo numeric (4,0) ');
     dm.Q.SQL.Add(' drop table config');
     dm.Q.ExecSQL;
     dm.Q.Close;
   end;
//     mensagem('Criando tabela config');
     dm.CriaTabelaConfig.Close;
     dm.CriaTabelaConfig.ExecSQL;
     dm.CriaTabelaConfig.Close;
   mensagem('Terminado');

end;

procedure TFPedido.sbcriaportadoresClick(Sender: TObject);
var   Lista:TStringList;
begin
   Lista:=TStringList.Create;
   if not dm.conexao.Connected then dm.conexao.Connected:=true;
//   dm.conexao.GetTableNames( dm.conexao.GetCatalogNames(cata,Lista), dm.conexao.GetSchemaNames(cata,'',Lista) ,'', Lista);
   dm.conexao.GetTableNames('', '', '', Lista );
   if Lista.IndexOf('portadores')<>-1 then begin
     mensagem('Eliminando tabela Portadores');
     dm.Q.SQL.Clear;
     dm.Q.SQL.Add('drop table portadores');
     dm.Q.ExecSQL;
     dm.Q.Close;
   end;
   if Lista.IndexOf('fpgto')<>-1 then begin
     mensagem('Eliminando tabela fpgto');
     dm.Q.SQL.Clear;
     dm.Q.SQL.Add('drop table fpgto');
     dm.Q.ExecSQL;
     dm.Q.Close;
   end;
   dm.Q.SQL.Clear;
   mensagem('Criando tabela Portadores');
   dm.Q.SQL.Add('CREATE TABLE portadores (');
   dm.Q.SQL.Add('port_codigo character varying(3) NOT NULL,');
   dm.Q.SQL.Add('port_descricao character varying(50),');
   dm.Q.SQL.Add('port_plan_conta numeric(8,0) );');
   dm.Q.ExecSQL;
   dm.Q.Close;
   dm.Q.SQL.Clear;
   mensagem('Criando tabela Condição Pagamento');
   dm.Q.SQL.Add('CREATE TABLE fpgto (');
   dm.Q.SQL.Add('fpgt_codigo character varying(3) NOT NULL,');
   dm.Q.SQL.Add('fpgt_descricao character varying(50),');
   dm.Q.SQL.Add('fpgt_reduzido character varying(15),');
   dm.Q.SQL.Add('fpgt_aplicacao character varying(20),');
   dm.Q.SQL.Add('fpgt_prazos character varying(50),');
   dm.Q.SQL.Add('fpgt_acrescimos numeric(10,5),');
   dm.Q.SQL.Add('fpgt_descontos numeric(10,5),');
   dm.Q.SQL.Add('fpgt_entrada numeric(10,5),');
   dm.Q.SQL.Add('fpgt_comissao numeric(10,5),');
   dm.Q.SQL.Add('fpgt_icmsint numeric(10,5) )');
   dm.Q.ExecSQL;
   dm.Q.Close;
   mensagem('Terminado');

end;

procedure TFPedido.sbcriaprodutosClick(Sender: TObject);
///////////////////////////////////////////
var   Lista:TStringList;
begin
   Lista:=TStringList.Create;
   if not dm.conexao.Connected then dm.conexao.Connected:=true;
   dm.conexao.GetTableNames('', '', '', Lista );
   if Lista.IndexOf('estoque')<>-1 then  ApagaTAbela('estoque');
   if Lista.IndexOf('estoqueqtde')<>-1 then ApagaTAbela('estoqueqtde');

   mensagem('Criando tabelas do estoque');
   dm.CriaTabelasEstoque.Close;
   dm.CriaTabelasEstoque.ExecSQL;
   dm.CriaTabelasEstoque.Close;
   mensagem('Terminado');
end;

// 21.10.2021
procedure TFPedido.sbestrturaClick(Sender: TObject);
////////////////////////////////////////////////////////
var   Lista : TStringList;
begin

   Lista:=TStringList.Create;
   if not dm.conexao.Connected then dm.conexao.Connected:=true;
   dm.conexao.GetTableNames('', '', '', Lista );
   if Lista.IndexOf('config') <> -1 then begin
     if not TemCampo('config','conf_online') then begin

       mensagem('Alterando Estrutura da tabela config');
       dm.QEstru.SQL.Clear;
       dm.QEstru.SQL.Add(' alter table config  add column  conf_online char(1) ');
       dm.QEstru.ExecSQL;
       dm.QEstru.Close;
       mensagem('Criado campo conf_online na tabela config');

     end;
     if not TemCampo('config','conf_clientespedido') then begin

       mensagem('Alterando Estrutura da tabela config');
       dm.QEstru.SQL.Clear;
       dm.QEstru.SQL.Add(' alter table config  add column  conf_clientespedido char(100) ');
       dm.QEstru.ExecSQL;
       dm.QEstru.Close;
       mensagem('Criado campo conf_clientespedido na tabela config');

     end;
// 30.08.24
     if not TemCampo('config','conf_enderecoftplocal') then begin

       mensagem('Alterando Estrutura da tabela config');
       dm.QEstru.SQL.Clear;
       dm.QEstru.SQL.Add(' alter table config  add column  conf_enderecoftplocal char(100) ');
       dm.QEstru.ExecSQL;
       dm.QEstru.Close;
       mensagem('Criado campo conf_enderecoftplocal na tabela config');

     end;
// 27.01.25
     if not TemCampo('config','conf_portaapi') then begin

       mensagem('Alterando Estrutura da tabela config');
       dm.QEstru.SQL.Clear;
       dm.QEstru.SQL.Add(' alter table config  add column  conf_portaapi char(06) ');
       dm.QEstru.ExecSQL;
       dm.QEstru.Close;
       mensagem('Criado campo conf_portaapi na tabela config');

     end;

   end;

//   mensagem('Terminado');



end;

procedure TFPedido.sbexeportadoresClick(Sender: TObject);
////////////////////////////////////////////////////////////////////////
begin

        AniIndicator1.Visible := true;
        AniIndicator1.Enabled := true;
//        TLoading.Show(Form1, 'Consultando...');


        TThread.CreateAnonymousThread(procedure
        begin
                sleep(1000);

//                sbportadores.OnClick(self);
                sbportadoresClick(self);

                TThread.Synchronize(nil, procedure
                begin
//                        TLoading.Hide;
                  AniIndicator1.Visible := false;
                  AniIndicator1.Enabled := false;
                end);

        end).Start;


end;

procedure TFPedido.sbimportacondicaoClick(Sender: TObject);
begin
        AniIndicator1.Visible := true;
        AniIndicator1.Enabled := true;
{
        TThread.CreateAnonymousThread(procedure
        begin

                BaixaApicondicao;
                TThread.Synchronize(nil, procedure
                begin
//                        TLoading.Hide;
                   AniIndicator1.Visible := false;
                   AniIndicator1.Enabled := false;

                end);

        end).Start;
}

// se for em thread dá msg 'duplicates not allowed'

//{
        BaixaApiCondicao;
        AniIndicator1.Visible := false;
        AniIndicator1.Enabled := false;
//}

end;

procedure TFPedido.sbimportaprodutoClick(Sender: TObject);
//////////////////////////////////////////////////////////////////////////
var Arquivonoftp,Arquivonoftp1:string;
    Arquivo,Arquivo1:TStringStream;
    Lista,Lista1,ListaTabelas:TStringlist;
begin
   ftp.Disconnect;
   if cb.IsChecked then ftp.Host:=Edenderecoftplocal.text
   else ftp.Host:=Edenderecoftp.text;
   ftp.port := strtoint(EdPortaftp.text);
   if trim(Edsenhaftp.text)<>'' then
     ftp.Password:=Edsenhaftp.text
   else
     ftp.Password:='clientes';
   if trim(Edusuarioftp.text)<>'' then
     ftp.Username:=Edusuarioftp.text
   else
     ftp.Username:='clientes';
   ftp.Passive:=true;
   ftp.ReadTimeout:=1000;
   Arquivonoftp:='scriptproduto.sql';
   Arquivonoftp1:='scriptprecos.sql';
//   Lista:=TStringlist.Create;
   Lista1:=TStringlist.Create;
   ListaTabelas:=TStringlist.Create;
   Arquivo:=TStringStream.Create;
   Arquivo1:=TStringStream.Create;
   Mensagem('Conectando no ftp...');
   try
     try
//        ftp.Connect(true,10000);
        ftp.Connect();
//        ftpacbr.StartDownload;
     except
       on E:exception do
       mensagem('Problemas para conectar no ftp:'+ftp.Host+':'+inttostr(ftp.Port));
//       Sistema.BeginProcess('Problemas para conectar no ftp:'+ftpacbr.ftp.ftpHost+':'+ftpacbr.ftp.ftpPort+' '+E.Message);
     end;
   finally
//    ftp.ChangeDir('BkpClientes');
// 22.12.16
    if trim(pastanoftp01)<>'' then
      ftp.ChangeDir( PastanoFtp01 );
//    ftp.ChangeDir('Vendasmovel');
// 19.04.16
//    if trim(pastanoftp)<>'' then
//      ftp.ChangeDir( PastanoFtp );
// 26.09.19
    if trim(EdPasta02ftp.Text)<>'' then
      ftp.ChangeDir( EdPasta02ftp.Text );

//      aviso('Problemas para conectar no ftp:'+ftpacbr.ftp.ftpHost+':'+ftpacbr.ftp.ftpPort);
   end;
   mensagem('Baixando produtos do ftp');
   try
    ftp.Get(Arquivonoftp,Arquivo,true);
   except on E:exception do
     mensagem('Problemas para baixar arquivo '+Arquivonoftp+' '+E.message);
   end;
   try
    ftp.Get(Arquivonoftp1,Arquivo1,true);
   except on E:exception do
     mensagem('Problemas para baixar arquivo '+Arquivonoftp1+' '+E.message);
   end;

   Lista:=TStringList.Create;
//   Lista.LoadFromStream( arquivo );
//   Lista.Add( arquivo.DataString );
   Lista.AddObject( arquivo.DataString , arquivo );
   Lista1.AddObject( arquivo1.DataString , arquivo1 );
   ftp.Disconnect;
//   showmessage('conectando ao banco');
   if not dm.conexao.Connected then dm.conexao.Connected:=true;
   dm.conexao.GetTableNames('', '', '', ListaTabelas );
   if ListaTabelas.IndexOf('estoque')<>-1 then  ApagaTAbela('estoque');
   if ListaTabelas.IndexOf('estoqueqtde')<>-1 then  ApagaTAbela('estoqueqtde');

   mensagem('Apagando produtos do sistema');
   {
   dm.Q.Close;
   dm.Q.sql.Clear;
   dm.Q.sql.Add('delete from estoque');
   dm.Q.ExecSQL;
   }
   mensagem('Incluindo os produtos no sistema');
   dm.Q.Close;
   dm.Q.sql.Clear;
   dm.Q.sql.Add(Lista.Text);
   dm.Q.ExecSQL;
   dm.Q.Close;
   mensagem('Apagando preços do sistema');
   {
   dm.Q.sql.Clear;
   dm.Q.sql.Add('delete from estoqueqtde');
   dm.Q.ExecSQL;
   }
   mensagem('Incluindo os preços no sistema');
   dm.Q.Close;
   dm.Q.sql.Clear;
   dm.Q.sql.Add(Lista1.Text);
   dm.Q.ExecSQL;
   dm.Q.Close;

   mensagem('Terminado');

end;

// 30.08.24
procedure TFPedido.sbimpportadoresClick(Sender: TObject);
////////////////////////////////////////////////////////
begin

        AniIndicator1.Visible := true;
        AniIndicator1.Enabled := true;

        TThread.CreateAnonymousThread(procedure
        begin

                BaixaApiportadores;
                TThread.Synchronize(nil, procedure
                begin
//                        TLoading.Hide;
                   AniIndicator1.Visible := false;
                   AniIndicator1.Enabled := false;

                end);

        end).Start;

// se for em thread dá msg 'duplicates not allowed'

{
        BaixaApiPortadores;
        AniIndicator1.Visible := false;
        AniIndicator1.Enabled := false;
        }
end;

procedure TFPedido.sbimpprodutosapiClick(Sender: TObject);
begin

//        AniIndicator1.Visible := true;
//        AniIndicator1.Enabled := true;
        Mensagem('inicio baixa dos produtos da api',1000);
//{
        TThread.CreateAnonymousThread(procedure
        begin

                BaixaApiprodutos;
                TThread.Synchronize(nil, procedure
                begin
//                        TLoading.Hide;
                   AniIndicator1.Visible := false;
                   AniIndicator1.Enabled := false;
//                   Mensagem('Terminado de baixar produtos da api',1000);

                end);

        end).Start;
//}
// se for em thread dá msg 'duplicates not allowed'
{
        Mensagem('inicio SEM THREAD DA baixa dos produtos da api',1000);
        BaixaApiProdutos;
        AniIndicator1.Visible := false;
        AniIndicator1.Enabled := false;
}
end;

procedure TFPedido.sblimpapedidosClick(Sender: TObject);
begin
   dm.Q.Close;
   dm.Q.sql.Clear;
   dm.Q.sql.Add('delete from movped where mped_datamvto<='+DAtetosql(EdateDAta.Date));
   dm.Q.ExecSQL;
   dm.Q.Close;
   dm.Q.sql.Clear;
   dm.Q.sql.Add('delete from movpeddet where mpdd_datamvto<='+DAtetosql(EdateDAta.Date));
   dm.Q.ExecSQL;
   dm.Q.Close;
   sblimpapedidos.Text:='OK até '+Edatedata.Text;

end;

procedure TFPedido.sbportadorClick(Sender: TObject);
begin
  FPortadores.Show;

end;

procedure TFPedido.sbportadoresClick(Sender: TObject);
////////////////////////////////////////////////////////////////
var Arquivonoftp,Arquivonoftp1:string;
    Arquivo,Arquivo1:TStringStream;
    Lista,Lista1,ListaTabelas:TStringlist;
begin

   if ftp.Connected then ftp.Disconnect;
   if cb.IsChecked then ftp.Host:=Edenderecoftplocal.text
   else ftp.Host:=Edenderecoftp.text;
   if trim(Edsenhaftp.text)<>'' then
     ftp.Password:=Edsenhaftp.text
   else
     ftp.Password:='clientes';
   if trim(Edusuarioftp.text)<>'' then
     ftp.Username:=Edusuarioftp.text
   else
     ftp.Username:='clientes';
//   if ansipos('STOROLLI',Uppercase(Edenderecoftp.text))>0 then begin
   ftp.Passive:=true;
   ftp.PassiveUseControlHost:=true;
// 30.04.20
   ftp.port := strtoint(EdPortaftp.text);

//   end else begin
//     ftp.Passive:=false;
 //    ftp.PassiveUseControlHost:=false;
 //  end;
   ftp.ReadTimeout:=2000;
   Arquivonoftp:='scriptportadores.sql';
   Arquivonoftp1:='scriptfpagto.sql';
   Lista:=TStringlist.Create;
   Lista1:=TStringlist.Create;
   ListaTabelas:=TStringlist.Create;
   Arquivo:=TStringStream.Create;
   Arquivo1:=TStringStream.Create;
   Mensagem('Conectando no ftp...');
   try
     try
        ftp.Connect();
//        ftpacbr.StartDownload;
     except
       on E:exception do
       mensagem('Problemas para conectar no ftp:'+ftp.Host+':'+inttostr(ftp.Port)+
                 ' '+PastanoFtp01+' '+Pastanoftp+
                ' '+ftp.Username+' '+ftp.Password);
//       Sistema.BeginProcess('Problemas para conectar no ftp:'+ftpacbr.ftp.ftpHost+':'+ftpacbr.ftp.ftpPort+' '+E.Message);
     end;
   finally
//    ftp.ChangeDir('BkpClientes');
// 22.12.16
    if trim(EdPasta01Ftp.text)<>'' then
      ftp.ChangeDir( EdPasta01Ftp.text );

//    ftp.ChangeDir('Vendasmovel');
// 19.04.16
//    if trim(PastanoFtp)<>'' then
//      ftp.ChangeDir( PastanoFtp );
// 26.09.19
    if trim(EdPasta02ftp.Text)<>'' then
      ftp.ChangeDir( EdPasta02ftp.Text );

//      aviso('Problemas para conectar no ftp:'+ftpacbr.ftp.ftpHost+':'+ftpacbr.ftp.ftpPort);
   end;
   mensagem('Baixando portadores e condição de pagto do ftp');
   try
    ftp.Get(Arquivonoftp,Arquivo,true);
   except on E:exception do
     mensagem('Problemas para baixar arquivo '+Arquivonoftp+' '+E.message);
   end;
   try
    ftp.Get(Arquivonoftp1,Arquivo1,true);
   except on E:exception do
     mensagem('Problemas para baixar arquivo '+Arquivonoftp1+' '+E.message);
   end;

   Lista:=TStringList.Create;
//   Lista.LoadFromStream( arquivo );
//   Lista.Add( arquivo.DataString );
   Lista.AddObject( arquivo.DataString , arquivo );
   Lista1.AddObject( arquivo1.DataString , arquivo1 );
   ftp.Disconnect;
//   showmessage('conectando ao banco');
   if not dm.conexao.Connected then dm.conexao.Connected:=true;
// 18.04.17
   dm.conexao.GetTableNames('', '', '', ListaTabelas );
   if ListaTabelas.IndexOf('portadores')<>-1 then  ApagaTAbela('portadores');
   if ListaTabelas.IndexOf('fpgto')<>-1 then  ApagaTAbela('fpgto');

   mensagem('Apagando portadores do sistema');
   {
   dm.Q.Close;
   dm.Q.sql.Clear;
   dm.Q.sql.Add('delete from portadores');
   dm.Q.ExecSQL;
   }
   dm.Q.Close;
   dm.Q.sql.Clear;
   dm.Q.sql.Add(Lista.Text);
   dm.Q.ExecSQL;
   {
   dm.Q.Close;
   dm.Q.sql.Clear;
   dm.Q.sql.Add('delete from fpgto');
   dm.Q.ExecSQL;
   }
   dm.Q.Close;
   dm.Q.sql.Clear;
   dm.Q.sql.Add(Lista1.Text);
   dm.Q.ExecSQL;
   dm.Q.Close;

   mensagem('Terminado');
end;

procedure TFPedido.sbprodutosClick(Sender: TObject);
begin
//  FProdutos.Show;
//  FProdutos1.Execute;
  FProdutos1.ExecuteX;
  EdInicial.text:='';
  EdFinal.text:='';
end;

procedure TFPedido.sbsalvaonfigClick(Sender: TObject);
//////////////////////////////////////////////////////////////////
begin
  mensagem('Conectando o banco');
  if not dm.conexao.Connected then dm.conexao.Connected:=true;
  mensagem('Conectando a tabela config');
  if not dm.TabConfig.Active then dm.TabConfig.Open;
  mensagem('Checando a tabela config');
  dm.Q.SQL.Clear;
  dm.Q.SQL.Add('select * from config')  ;
  dm.Q.Open();
  if dm.Q.eof then
    dm.tabconfig.insert
  else
    dm.tabconfig.Edit;
  mensagem('Acessando data module');
  dm.tabconfig.fieldbyname('conf_enderecoftp').asstring:=Edenderecoftp.Text;
  dm.tabconfig.fieldbyname('conf_pasta01ftp').asstring:=Edpasta01ftp.Text;
  dm.tabconfig.fieldbyname('conf_pasta02ftp').asstring:=Edpasta02ftp.Text;
  dm.tabconfig.fieldbyname('conf_portaftp').asstring:=Edportaftp.Text;
// 27.01.25
  if TemCampo('config','conf_portaapi') then
     dm.tabconfig.fieldbyname('conf_portaapi').asstring:=Edporta.Text;
  dm.tabconfig.Post;
  dm.tabconfig.CachedUpdates:=true;
  dm.tabconfig.CommitUpdates;
  dm.Q.close;
  mensagem('Configuração Gravada');


end;

procedure TFPedido.sgpedidosClick(Sender: TObject);
begin
   showmessage('entrou no onclick');
end;

procedure TFPedido.sgpedidosSelectCell(Sender: TObject; const ACol,  ARow: Integer; var CanSelect: Boolean);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
var p:integer;
    totalitem:currency;
    condicao:boolean;
begin

  if trim(sgpedidos.Cells[acol,arow])='' then exit;
// 06.09.16
//  if trim(sgpedidos.Cells[0,arow])='' then showmessage('sem codigo');
  //exit;
// 15.09.25
  linhaatualsgpedidos:=arow;

  dm.Q.SQL.Clear;
  dm.Q.SQL.Add('select movpeddet.*,esto_descricao,esto_unidade from movpeddet inner join estoque on ( esto_codigo=mpdd_esto_codigo )'+
               ' where mpdd_numerodoc='+sgpedidos.Cells[0,arow] );
  dm.Q.Open();
  sgpedidosd.RowCount:=0;
  sgpedidosd.UpdateEffects;
  p:=0;
// 14.02.18
  Ednumpedido.text:=sgpedidos.Cells[0,arow];
  {
      sgpedidosd.Cells[0,p]:='';
      sgpedidosd.Cells[1,p]:='';
      sgpedidosd.Cells[2,p]:='';
      sgpedidosd.Cells[3,p]:='';
      sgpedidosd.Cells[4,p]:='';
      sgpedidosd.Cells[5,p]:='';
}

  while not dm.q.eof do begin
//    if dm.Q.FieldByName('mpdd_datamvto').AsDateTime=Strtodate(EdData.Text) then begin
// 06.09.16
    condicao:= dm.Q.FieldByName('mpdd_datamvto').AsDateTime=Strtodate(EdData.Text);
    if ultimos = 'S' then begin
        condicao:= true;
    end;

//  showmessage( 'condicao='+BoolToStr(condicao) );

    if condicao then begin
      sgpedidosd.RowCount:=sgpedidosd.RowCount+1;
      sgpedidosd.Cells[colcodigo,p]:=dm.Q.FieldByName('mpdd_esto_codigo').AsString;
      sgpedidosd.Cells[colnome,p]:=dm.Q.FieldByName('esto_descricao').AsString;
      sgpedidosd.Cells[colunidade,p]:=dm.Q.FieldByName('esto_unidade').AsString;
      sgpedidosd.Cells[colqtde,p]:=dm.Q.FieldByName('mpdd_qtde').AsString;
      sgpedidosd.Cells[colvenda,p]:=dm.Q.FieldByName('mpdd_venda').AsString;
      totalitem:=dm.Q.FieldByName('mpdd_qtde').AsCurrency*dm.Q.FieldByName('mpdd_venda').AsCurrency;
      sgpedidosd.Cells[coltotalitem,p]:=FormatCurr('###,##0.00', totalitem );
// 23.08.24
      sgpedidosd.Cells[coldataproducao-1,p]:=dm.Q.FieldByName('mpdd_datamontagem').AsString;
      inc(p);
    end;
    dm.q.next;
  end;
  dm.Q.Close;
end;

procedure TFPedido.sgSelectCell(Sender: TObject; const ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
    if trim(sg.Cells[colcodigo,arow])<>'' then begin
      linhaatual:=arow;
    end;
end;

function TFPedido.SomaGrid: currency;
////////////////////////////////////////
var total:currency;
    p:integer;
begin
  total:=0;
  for p :=0 to sg.RowCount-1 do begin

    if trim(sg.Cells[colcodigo,p])<>'' then total:=total+strtocurr(sg.Cells[coltotalitem,p]);

  end;
  result:=total;
end;

procedure TFPedido.SpeedButton3Click(Sender: TObject);
///////////////////////////////////////////////////////////////
begin

        AniIndicator1.Visible := true;
        AniIndicator1.Enabled := true;
//        TLoading.Show(Form1, 'Consultando...');


        TThread.CreateAnonymousThread(procedure
        begin

//                sleep(1000);
                // Acesso ao banco...
                // Acesso aos WS...
                // Processamento...

                sbimpclientesclick(self);

                TThread.Synchronize(nil, procedure
                begin
//                        TLoading.Hide;
                   AniIndicator1.Visible := false;
                   AniIndicator1.Enabled := false;

                end);

        end).Start;

end;

procedure TFPedido.sbexeprodutosClick(Sender: TObject);
/////////////////////////////////////////////////////////////
begin


        AniIndicator1.Visible := true;
        AniIndicator1.Enabled := true;
//        TLoading.Show(Form1, 'Consultando...');

        TThread.CreateAnonymousThread(procedure
        begin
                sleep(1000);

                sbimportaprodutoClick(self);

                TThread.Synchronize(nil, procedure
                begin
//                        TLoading.Hide;
                  AniIndicator1.Visible := false;
                  AniIndicator1.Enabled := false;
                end);

        end).Start;


end;

procedure TFPedido.spsalvaconfigClick(Sender: TObject);
//////////////////////////////////////////////////////

begin

// 20.07.2021
  if (trim(EdSupe_codigo.text) <> '' ) and (trim(EdSupe_codigo.text) <> '0')  then begin

     if trim(EdSenha.text) <> '954854' then exit;

  end;

  mensagem('Conectando o banco');
  if not dm.conexao.Connected then dm.conexao.Connected:=true;
//  mensagem('Conectando a tabela config');
  if not dm.TabConfig.Active then dm.TabConfig.Open;
//  mensagem('select na tabela config');
  dm.Q.SQL.Clear;
  dm.Q.SQL.Add('select * from config')  ;
  dm.Q.Open();
  if dm.Q.eof then begin
    dm.tabconfig.insert;
//    mensagem('Acessando data module inserindo');
  end else begin
    dm.tabconfig.Edit;
//    mensagem('Acessando data module alterando');
  end;
  dm.tabconfig.fieldbyname('conf_enderecoftp').asstring:=Edenderecoftp.Text;
  dm.tabconfig.fieldbyname('conf_pasta01ftp').asstring:=Edpasta01ftp.Text;
  dm.tabconfig.fieldbyname('conf_pasta02ftp').asstring:=Edpasta02ftp.Text;
  dm.tabconfig.fieldbyname('conf_portaftp').asstring:=Edportaftp.Text;
// 19.12.16
  if trim(EdRepr_codigo.text)<>'' then
    dm.tabconfig.fieldbyname('conf_repr_codigo').asinteger:=strtoint(Edrepr_codigo.Text)
  else
    dm.tabconfig.fieldbyname('conf_repr_codigo').asinteger:=0;
// 21.12.16
//  if trim(EdUsuarioftp.text)<>'' then
    dm.tabconfig.fieldbyname('conf_usuarioftp').asstring:=(EdUsuarioftp.Text);
//  if trim(EdSenhaftp.text)<>'' then
    dm.tabconfig.fieldbyname('conf_senhaftp').asstring:=(EdSenhaftp.Text);
// 20.07.2021 - Guiber
  if trim(EdSupe_codigo.text)<>'' then
    dm.tabconfig.fieldbyname('conf_supe_codigo').asinteger:=strtoint(Edsupe_codigo.Text)
  else
    dm.tabconfig.fieldbyname('conf_supe_codigo').asinteger:=0;
  mensagem('Verificando campo novo');
// 20.09.2021
  if TemCampo('config','conf_online') then begin

     mensagem('Campo novo encontrado');
     dm.tabconfig.fieldbyname('conf_online').asstring := EdOnline.text;

  end;
// 23.08.2024
  if TemCampo('config','conf_clientespedido') then begin

     dm.tabconfig.fieldbyname('conf_clientespedido').asstring := EdClientesPedidos.Text;

  end;
// 30.08.2024
  if TemCampo('config','conf_enderecoftplocal') then begin

     dm.tabconfig.fieldbyname('conf_enderecoftplocal').asstring := Edenderecoftplocal.Text;

  end;
// 27.01.2025
  if TemCampo('config','conf_portaapi') then begin

     mensagem('Campo conf_portaapi encontrado');
     dm.tabconfig.fieldbyname('conf_portaapi').asstring := Edporta.Text;

  end;

  dm.tabconfig.Post;
  dm.tabconfig.CachedUpdates:=true;
  dm.tabconfig.CommitUpdates;
  dm.Q.close;
  mensagem('Configuração Gravada');

end;

procedure TFPedido.TabItem1Click(Sender: TObject);
////////////////////////////////////////////////////
var sqlnumpedido:string;
    p:integer;
    totalitem:currency;

begin

  linhaatual:=-1;
  toolbar1.Visible:=true;
  toolbar1.BringToFront;
  toolbar1.SetFocus;
// 14.02.18
  NumPedido:=0;
  label1.text:='INCLUSÃO';

  if Sender is TEdit then begin

    if strtointdef(TEdit(Sender).Text,0)>0 then begin

        NumPedido:=strtointdef(TEdit(Sender).Text,0);
        dm.Q.SQL.Clear;
        if Sender is TEdit then begin

          if trim(TEdit(Sender).Text)<>'' then begin
            sqlnumpedido:=' where mped_numerodoc = '+(TEdit(Sender).Text);
          end;

        end;

        dm.Q.SQL.Add('select movped.*,clie_nome from movped inner join clientes on ( clie_codigo=mped_tipo_codigo )'+
                     sqlnumpedido+
                     ' order by mped_datamvto' );
        dm.Q.Open();

        label1.text:='ALTERAÇÃO';
        label1.UpdateEffects;

        sg.RowCount:=0;
        for p := 0 to sg.RowCount-1  do begin

            sg.Cells[colcodigo,p]:='';
            sg.Cells[colnome,p]:='';
            sg.Cells[colunidade,p]:='';
            sg.Cells[colqtde,p]:='';
            sg.Cells[colvenda,p]:='';
            sg.Cells[coltotalitem,p]:='';
            sg.Cells[coldesconto,p]:='';
            sg.Cells[coldataproducao,p]:='';

        end;

        EdCodCli.Text:=dm.Q.FieldByName('mped_tipo_codigo').AsString;
        EdNome.Text:=sgpedidos.Cells[1,SgPedidos.Row];
        EdPOrtador.Text:=dm.Q.FieldByName('mped_port_codigo').AsString;
        EdCondicao.Text:=dm.Q.FieldByName('mped_fpgt_codigo').AsString;
        Edvalorpedido.Text:=dm.Q.FieldByName('mped_vlrtotal').AsString;
        EdPedidocli.Text:=dm.Q.FieldByName('mped_contatopedido').AsString;

        dm.Close;
// 22.06.2021 - faltava puxar os itens
        dm.Q.sql.clear;
        dm.Q.SQL.Add('select movpeddet.*,esto_descricao,esto_unidade from movpeddet inner join estoque on ( esto_codigo=mpdd_esto_codigo )'+
               ' where mpdd_numerodoc='+(TEdit(Sender).Text) );
        dm.Q.Open();
        p := 0;

        while not dm.q.eof do begin

          sg.RowCount:=sg.RowCount+1;
          sg.Cells[colcodigo,p]:=dm.Q.FieldByName('mpdd_esto_codigo').AsString;
          sg.Cells[colnome,p]:=dm.Q.FieldByName('esto_descricao').AsString;
          sg.Cells[colunidade,p]:=dm.Q.FieldByName('esto_unidade').AsString;
          sg.Cells[colqtde,p]:=dm.Q.FieldByName('mpdd_qtde').AsString;
          sg.Cells[colvenda,p]:=dm.Q.FieldByName('mpdd_venda').AsString;
          totalitem:=dm.Q.FieldByName('mpdd_qtde').AsCurrency*dm.Q.FieldByName('mpdd_venda').AsCurrency;
          sg.Cells[coltotalitem,p]:=FormatCurr('###,##0.00', totalitem );
          sg.Cells[coldesconto,p]:=dm.Q.FieldByName('mpdd_perdesco').AsString;
          sg.Cells[coldataproducao,p]:=dm.Q.FieldByName('mpdd_datamontagem').AsString;
          inc(p);

          dm.Q.Next;

        end;

        dm.Close;

    end;

  end;

end;

procedure TFPedido.TabItem2Click(Sender: TObject);
begin
   EdAtedata.Text:=Datetostr(Date()-30);
end;

procedure TFPedido.TabItem3Click(Sender: TObject);
//////////////////////////////////////////////////
var p:integer;
    xtot:currency;
    sqlcliente:string;
    condicao:boolean;
begin
// 14.02.18
  benviapedidos.Text:='Envia Ped.';
  dm.Q.SQL.Clear;
//  Eddata.Text:=datetostr(date());
//  Eddata.UpdateEffects;
//  dm.Q.SQL.Add('select movped.*,clie_nome from movped inner join clientes on ( clie_codigo=mped_tipo_codigo ) where mped_datamvto='+datetosql(EdData.Date));
//  dm.Q.SQL.Add('select movped.*,clie_nome from movped inner join clientes on ( clie_codigo=mped_tipo_codigo ) where mped_datamvto=date('''+FormatDateTime('YYYY-MM-DD',EdData.Date)+''')');
// depois ver como pesquisar pela data direto na select
  sqlcliente:='';
  if Sender is TEdit then begin
    if trim(TEdit(Sender).Text)<>'' then begin
      sqlcliente:=' where mped_tipo_codigo = '+(TEdit(Sender).Text);
      ultimos:='S';
    end;
  end;

  dm.Q.SQL.Add('select movped.*,clie_nome from movped inner join clientes on ( clie_codigo=mped_tipo_codigo )'+
               sqlcliente+
               ' order by mped_datamvto' );
  dm.Q.Open();

 // sgpedidos.RowCount:=1;
 // sgpedidos.UpdateEffects;
 // sgpedidos.Repaint;

  for p := 0 to sgpedidos.RowCount-1  do begin
      sgpedidos.Cells[0,p]:='';
      sgpedidos.Cells[1,p]:='';
      sgpedidos.Cells[2,p]:='';
      sgpedidos.Cells[3,p]:='';
  end;

//  showmessage( 'limpou grid' );

  xtot:=0;p:=0;
  sgpedidos.RowCount:=1;
  while not dm.q.eof do begin
//    if dm.Q.FieldByName('mped_datamvto').AsDateTime=Strtodate(EdData.Text) then begin
//    if dm.Q.FieldByName('mped_datamvto').AsDateTime=EdData.Date then begin
    condicao:=( dm.Q.FieldByName('mped_datamvto').AsDateTime=EdData.Date );
    if Sender is TEdit then begin
      if trim(TEdit(Sender).Text)<>'' then
        condicao:= dm.Q.FieldByName('mped_tipo_codigo').AsString=(TEdit(Sender).Text);
    end;
    if condicao  then begin
      sgpedidos.Cells[0,p]:=dm.Q.FieldByName('mped_numerodoc').AsString;
      sgpedidos.Cells[1,p]:=dm.Q.FieldByName('clie_nome').AsString;
      sgpedidos.Cells[2,p]:=dm.Q.FieldByName('mped_datamvto').AsString;
      sgpedidos.Cells[3,p]:='   '+FormatCurr('###,##0.00',dm.Q.FieldByName('mped_vlrtotal').AsCurrency);
      sgpedidos.RowCount:=sgpedidos.RowCount+1;
      xtot:=xtot+dm.Q.FieldByName('mped_vlrtotal').Ascurrency;
      inc(p);
    end;
    dm.q.next;
  end;
  Edtotalpedidos.Text:=currtostr(xtot);
  dm.Q.Close;
  sgpedidosd.RowCount:=0;
end;


// 03.08.2021
// 20.09.2021
function TFPedido.TemCampo(tabela, campo: string): boolean;
//////////////////////////////////////////////////////////////
begin

   dm.QCampo.SQL.Clear;
   dm.QCampo.SQL.Add('select sql from sqlite_master where type = ''table'''+
                     ' and name = '''+tabela+'''');
   dm.QCampo.Open();
   if not Dm.QCampo.Eof then begin

      if AnsiPos( Uppercase(campo),Uppercase(dm.QCampo.fieldbyname('sql').asstring) ) > 0  then

         result := true

      else

         result := false;

   end else

     result := false;

   dm.QCampo.close;

end;

function TFPedido.TextToValor(Text: string): Currency;
/////////////////////////////////////////////////////////
var p,e:integer;
    Texto:string;
    Ponto:Boolean;
begin

  Ponto:=False;
  Texto:='';
  repeat
    p:=Pos(',',Text);
    if p>0 then Text[p]:='.';
  until p=0;
  for e:=Length(Text) downto 1 do begin
      if (Text[e]='.') and (not Ponto) then begin
         Texto:='.'+Texto;
         Ponto:=True;
      end else if Text[e] in ['0'..'9','-'] then begin
         Texto:=Text[e]+Texto;
      end;
  end;
  if Texto='' then Texto:='0';
  try
    Val(Texto,Result,e);
//    Result := strtocurrdef(Texto,0);
  except
    Result:=0;
  end;
end;

function TFPedido.TiraBarra(s: string ;  caracter:string='/';caracternolugar:string='' ): string;
////////////////////////////////////////////////////////////////////////////////////////////////
var p:integer;
begin
  result:='';
  for p:=1 to length(s) do begin
    if pos( copy(s,p,1),caracter ) =0 then
      result:=result+copy(s,p,1)
    else
      result:=result+caracternolugar;
  end;
end;


end.

