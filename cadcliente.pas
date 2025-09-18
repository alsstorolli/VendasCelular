// cadastro de cliente
// 23.06.2021 colocado no vendas celular
//

unit cadcliente;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.Colors;

type
  TFCadClientes = class(TForm)
    Panel1: TPanel;
    Layout1: TLayout;
    EdNomeFantasia: TEdit;
    Panel2: TPanel;
    Layout2: TLayout;
    EdRazaosocial: TEdit;
    bgravar: TCornerButton;
    Panel3: TPanel;
    Layout3: TLayout;
    EdCnpjcpf: TEdit;
    Layout4: TLayout;
    EdIerg: TEdit;
    Layout5: TLayout;
    Edendereco: TEdit;
    ColorQuad1: TColorQuad;
    ColorQuad2: TColorQuad;
    Layout6: TLayout;
    edcep: TEdit;
    EdBairro: TEdit;
    procedure bgravarClick(Sender: TObject);
    procedure EdNomeFantasiaValidate(Sender: TObject; var Text: string);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    function StringToSql(s:String):String;

  end;

var
  FCadClientes: TFCadClientes;

implementation

uses datam, pedido;

{$R *.fmx}

{ TFCadClientes }

procedure TFCadClientes.bgravarClick(Sender: TObject);
/////////////////////////////////////////////////////////
var codigo : integer;
//    xsql,
//    xsql01  : string;

begin

   if length(EdRazaosocial.text) < 10 then begin

      showmessage('Checar Razão Social');
      exit;

   end;
   if length(EdNomeFantasia.text) < 10 then begin

      showmessage('Checar Nome Fantasia');
      exit;

   end;
   if length(Edcnpjcpf.text) < 11 then begin

      showmessage('Checar CNPJ/CPF');
      exit;

   end;
   if length(EdEndereco.text) < 11 then begin

      showmessage('Checar endereço');
      exit;

   end;
   if length(EdBairro.text) < 6 then begin

      showmessage('Checar Bairro');
      exit;

   end;
   if length(EdCep.text) < 08 then begin

      showmessage('Checar CEP');
      exit;

   end;


     Dm.Q.SQL.Clear;
     dm.Q.SQL.Add('select max(clie_codigo) as ultimo from clientes' );
     dm.Q.Open();
     codigo := dm.Q.fieldbyname('ultimo').asinteger+1;
     dm.Q.close;

   if not Dm.TabClientes.Active then  Dm.TabClientes.open;

//   showmessage('lendo os clientes');
//   xsql := 'select * from clientes';
//   Dm.TabClientes.SQL.Add( xsql );
//   showmessage('abrindo os clientes');
//   Dm.TabClientes.Open();
//   showmessage('gravando o cliente');


   try

       dm.TabClientes.Insert;
       dm.TabClientes.FieldByName('clie_codigo').AsInteger := codigo;
       dm.TabClientes.FieldByName('clie_nome').AsString := EdNomeFantasia.text;
       dm.TabClientes.FieldByName('clie_razaosocial').AsString := EdRazaoSocial.text;
       dm.TabClientes.FieldByName('clie_cnpjcpf').AsString := EdCnpjcpf.text;
       dm.TabClientes.FieldByName('clie_rgie').AsString    := Edierg.text;
       dm.TabClientes.FieldByName('clie_endres').AsString   := EdEndereco.text;
       dm.TabClientes.FieldByName('clie_endcom').AsString   := EdEndereco.text;
       dm.TabClientes.FieldByName('clie_cepres').AsString   := EdCep.text;
       dm.TabClientes.FieldByName('clie_cepcom').AsString   := EdCep.text;
       dm.TabClientes.FieldByName('clie_bairrores').AsString   := EdBairro.text;
       dm.TabClientes.FieldByName('clie_bairrocom').AsString   := EdBairro.text;
       dm.TabClientes.FieldByName('clie_obs').AsString   := 'NOVO';
       if trim( FPedido.EdRepr_codigo.text ) <>'' then

          dm.TabClientes.FieldByName('clie_repr_codigo').AsInteger  := strtointdef(FPedido.EdRepr_codigo.text,0);

       if trim( FPedido.EdPortador.text ) <>'' then

          dm.TabClientes.FieldByName('clie_fpgt_codigo').AsString   := copy(FPedido.EdPortador.text,1,3);

       if length(trim(EdCnpjcpf.text)) = 11 then

          dm.TabClientes.FieldByName('clie_tipo').AsString   := 'F'

       else

          dm.TabClientes.FieldByName('clie_tipo').AsString   := 'J';

       dm.TabClientes.Post;

       dm.TabClientes.CachedUpdates:=true;
       dm.TabClientes.ApplyUpdates;


// nao usar Qclientes pois afeta a consulta de clientes
{
     xsql   := 'Insert into clientes ( clie_codigo,clie_nome,clie_razaosocial,clie_cnpjcpf,clie_rgie,'+
             'clie_endres,clie_endcom,clie_cepres,clie_cepcom,clie_bairrores,clie_bairrocom,'+
             'clie_obs,clie_repr_codigo,clie_fpgt_codigo )';
     xsql01 := ' VAlues ('+inttostr(codigo)+','+stringtosql(EdNomeFantasia.text)+','+stringtosql(EdRazaoSocial.text)+','+
                       stringtosql(Edcnpjcpf.text)+','+stringtosql(EdIerg.text)+','+stringtosql(EdEndereco.text)+','+stringtosql(EdEndereco.text)+','+
                       stringtosql(Edcep.text)+','+stringtosql(EdCep.text)+','+stringtosql(EdBairro.text)+','+stringtosql(EdBairro.text)+','+
                       stringtosql('NOVO')+','+stringtosql(FPedido.EdRepr_codigo.text)+','+stringtosql(FPedido.EdPortador.text)+' ) ';

     Dm.Qclientes.SQL.Clear;
     dm.Qclientes.SQL.Add( xsql );
     dm.Qclientes.SQL.Add( xsql01 );
     dm.Qclientes.ExecSQL;
}

    showmessage('Cliente gravado');

   except on E:exception do showmessage('Não gravado.  Erro '+E.message )

   end;

end;

procedure TFCadClientes.EdNomeFantasiaValidate(Sender: TObject;    var Text: string);
//////////////////////////////////////////////////////////////////////////////////////////
begin

     if trim(EdRazaosocial.text)='' then EdRazaosocial.text := EdNOmeFantasia.text;

end;

procedure TFCadClientes.Execute;
/////////////////////////////////
begin

   Show;
   EdNomeFantasia.setfocus;
   {
   EdNOmeFantasia.text := '2000 Médicos Ltda';
   Edrazaosocial.text := '2000 Médicos Ltda';
   Edcnpjcpf.text := '12345678901234';
   Edierg.text := '12345678901';
   Edendereco.text := 'Rua 13 de maio, 567';
   EdBairro.text := 'Centro';
   EdCep.text := '85501010';
}

end;

function TFCadClientes.StringToSql(s: String): String;
//////////////////////////////////////////////////////////
begin

//  s:=RetiraBarra(s);
  Result := Chr(39)+s+Chr(39);

end;

end.
