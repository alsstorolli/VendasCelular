unit Gerapdfpedidovenda;

interface

uses

 ACBr_fpdf,ACBr_fpdf_ext,ACBr_fpdf_report,SqlExpr,
 System.SysUtils, FMX.Dialogs, Datam,pedido, System.DateUtils,
 vepdf,System.IOUtils;

type TGerapdfpedidovenda = class

   FVisualizaPDF:TFVePDF;

   private
   procedure Rodape(APDF: TFPDF);
   procedure Cabecalho(APDF: TFPDF);

   public

   procedure Execute( xnumero:integer; xemissao:TDateTime ; xUnidade:string );
   function space(n:integer):string;
   function FormataTelefone(t:string):string;
   function FormataData(d:TDatetime):string;
   function FormataValor(v:double):string;
   function DateToSql(Dt:TDateTime):String;

end;

var arquivo,
    pastaimagens,
    fpfiledir,
    linha,
    arqlogo,
    unidade :string;
    QPed,
    QCli,
    QUni:TSqlquery;
    pdf:TFPDFExt;



implementation

{ TGerapdfpedidovenda }

procedure TGerapdfpedidovenda.Cabecalho(APDF: TFPDF);
////////////////////////////////////////////////////////////////
var
  vw: Double;
  titulo,
  caminho,
  Arqlogo:string;

begin
   {$IFDEF ANDROID}
//     caminho:=GetHomePath ;
     arqlogo:=caminho+'/'+'Logo.jpg' ;

   {$ELSE}

     arqlogo:=ExtractFilePath( Application.ExeName ) + 'Logo.jpg' ;
     Arquivot:=caminho+ '\mestre.txt';

   {$ENDIF}

  if FileExists( arqlogo) then
     pdf.Image( arqlogo, 01, 01, 25,22);

  // Arial bold 15
  APDF.SetFont('Arial','B',15);
  titulo := 'Orçamento / Pedido de Venda '+Dm.QPed.fieldbyname('mped_numerodoc').asstring;
  // Calculate width of TheTitle and position
  vw := APDF.GetStringWidth(Titulo)+6;
  APDF.SetX((210-vw)/2);  // calcula posicao para centralizar quadro do titulo
  // Colors of frame, background and text
  APDF.SetDrawColor(0,80,180);  // cor do 'quadro' azul
  APDF.SetFillColor(230,230,0); // cor do fundo em amarelo
//  APDF.SetTextColor(220,50,50);  // define cor do texto vermelha
//  APDF.SetTextColor(123,50,50);  // define cor do texto cinza
  // Thickness of frame (1 mm)
  APDF.SetLineWidth(1);
  // The Title
  APDF.Cell(vw, 9, Titulo, '1', 1, 'C', true);
  // Line break
//  APDF.Ln(10);
  APDF.Ln(05);
  APDF.SetFont('Arial','',10);
  apdf.SetXY(01,20);
  apdf.Write(10,'Codigo     :'+Dm.QClientes.fieldbyname('clie_codigo').asstring);
  apdf.SetXY(01,25);
  apdf.Write(10,'Nome       :'+Dm.QClientes.fieldbyname('clie_nome').asstring+
                space(12)+'Email   :'+Dm.QClientes.fieldbyname('clie_email').asstring );
  apdf.SetXY(01,30);
  apdf.Write(10,'Endereço :'+Dm.QClientes.fieldbyname('clie_endres').asstring+
                space(10)+'Cidade :'+Dm.QClientes.fieldbyname('clie_cidade').asstring+
                space(46)+'Forma Pagto :'+Dm.QPed.fieldbyname('Mped_fpgt_prazos').asstring);
  apdf.SetXY(01,35);
  apdf.Write(10,'Fone        :'+FormataTelefone( Dm.QClientes.fieldbyname('clie_foneres').asstring)+
                space(10)+'Celular :'+FormataTelefone( Dm.QClientes.fieldbyname('clie_fonecel').asstring) );

  apdf.SetXY(120,35);
  apdf.Write(10,'Data : '+FormataData(Dm.QPed.fieldbyname('mped_datamvto').asdatetime));
  apdf.SetXY(156,35);
  apdf.Write(10,'Valor Total : '+FormataValor(Dm.QPed.fieldbyname('mped_vlrtotal').ascurrency));
  apdf.SetXY(01,43);
  apdf.LIne(01,43,01+195,43);

end;

function TGerapdfpedidovenda.DateToSql(Dt: TDateTime): String;
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

procedure TGerapdfpedidovenda.Execute(xnumero: integer; xemissao: TDateTime;xUnidade: string);
///////////////////////////////////////////////////////////////////////////////////////////////
var arqproduto,
    caminho,
    nomearquivo:string;
    hor,ver:integer;
    valortotalitem:currency;
begin

//  showmessage('acessou form gerapdfpedidovenda');

  caminho:=GetHomePath ;

  unidade:=xunidade;
  dm.QPed.SQL.Clear;
  dm.QPed.SQL.Add('select * from movpeddet'+
        ' inner join movped on ( mped_numerodoc=mpdd_numerodoc and mped_datamvto=mpdd_datamvto )'+
//        ' inner join clientes on ( clie_codigo=mped_tipo_codigo )'+
        ' inner join estoque on ( mpdd_esto_codigo=esto_codigo)'+
        ' where mpdd_status = ''N'''+
//        ' and mped_tipo_codigo= '+
        ' and mpdd_numerodoc = '+inttostr(xNUmero)+
        ' and mpdd_datamvto = '+DateToSql(xemissao));
//        ' and mped_unid_codigo = '+Stringtosql(xUnidade) );
  dm.QPed.Open();
  if dm.QPed.Eof then begin
     Showmessage('Nada encontrado para impressão');
     exit;
  end;
  dm.QClientes.SQL.Clear;
  dm.QClientes.SQL.Add('select * from clientes where clie_codigo='+dm.QPed.fieldbyname('mped_tipo_codigo').asstring);
  dm.QClientes.Open();

//  QUNi:=sqltoquery('select * from unidades where unid_codigo='+stringtosql(unidade));;
// monta o pdf
//  linha:=replicate('-',165);

//   showmessage('dm.qped.sql:'+dm.qped.sql.CommaText);
//   showmessage('encontrou pedido:'+dm.QPed.fieldbyname('mped_numerodoc').asstring+' Cliente:'+dm.QPed.fieldbyname('mped_tipo_codigo').asstring);

  linha:='------------------------------------------------------------';
  pdf := TFPDFExt.Create;
  pdf.AddPage;
  pdf.SetFont('Arial','',15);
  pdf.setFontSize(12);
  pdf.OnHeader:=cabecalho;
  pdf.OnFooter:=rodape;
//  fpfiledir:=ExtractFilePath( Application.ExeName ) + 'Impressao\';

//  showmessage('caminho='+caminho);

  fpfiledir:=caminho + '/Impressao';
  cabecalho(pdf);
  ver:=50;

//  showmessage('antes QPed.eof ');

  while not Dm.QPed.eof do begin

    hor:=01;
    arqproduto:=Dm.QPed.fieldbyname('mpdd_esto_codigo').asstring+'.jpg';
    if FileExists(fpfiledir+arqproduto) then
//       pdf.Image(fpfiledir+arqproduto, hor, ver, 20,30);
       pdf.Image(fpfiledir+arqproduto, hor, ver, 20,27);
    hor:=hor+30;
    pdf.SetXY(hor,ver);
    pdf.Write(8, Dm.QPed.fieldbyname('mpdd_esto_codigo').asstring);
    hor:=hor+20;
    pdf.SetXY(hor,ver);
    pdf.Write(8, (Dm.QPed.fieldbyname('esto_descricao').asstring));
    ver:=ver+05;
    pdf.SetXY(hor,ver);
    pdf.Write(8,'Qtde:'+Dm.QPed.fieldbyname('mpdd_qtde').asstring);
    hor:=hor+50;
    pdf.SetXY(hor,ver);
    pdf.Write(8,'Unitário:'+FormataValor(Dm.QPed.fieldbyname('mpdd_venda').ascurrency));
    hor:=hor+60;
    pdf.SetXY(hor,ver);
    valortotalitem:=(Dm.QPed.fieldbyname('mpdd_venda').AsCurrency*Dm.QPed.fieldbyname('mpdd_qtde').AsCurrency);
    pdf.Write(8,'Valor Item:'+FormataValor(valortotalitem));

    ver:=ver+18;
    hor:=01;
    pdf.SetXY(hor,ver);
//    pdf.Write(8,linha);
    pdf.LIne(hor,ver,hor+195,ver);
    ver:=ver+02;
//    PDF.Cell(00, 10, '', '1', 1, 'C', true);
// entender melhor...

    if ver>=260 then begin
       pdf.AddPage;
       ver:=50;
    end;

//    showmessage('QPed.eof.next ');

    Dm.QPed.Next;

  end;


//  arquivo:=  ExtractFilePath( Application.ExeName ) +'Pedidov'+inttostr(xNUmero)+'.pdf';
//  caminho:= TPath.Combine(TPath.GetSharedDocumentsPath, 'tuto1-pas.pdf');
//  arquivo:=  caminho +'/Pedidov'+inttostr(xNUmero)+'.pdf';
  nomearquivo:='Pedidov'+inttostr(xNUmero)+'.pdf';
//  arquivo:=  TPath.Combine(TPath.GetDocumentsPath(), nomearquivo); // assim salva na pasta 'embarcadero.'...
//  arquivo:=  TPath.Combine(TPath.GetPublicPath, nomearquivo);    // assim salva na pasta....android/data.
//  arquivo:=  TPath.Combine(TPath.GetHOmePath, nomearquivo);    // assim salva na pasta data/user../embarcadero.vendascelular...

  arquivo:=  TPath.Combine(TPath.GetSharedDocumentsPath, nomearquivo);    // assim salva na pasta 'documents'
  pdf.SaveToFile( arquivo );

  showmessage('arquivo salvo em '+arquivo);

//  FVisualizapdf.Execute(arquivo);
  FVepdf.Execute(arquivo);

  pdf.Close;
  pdf.free;
  dm.QPed.Close;
  dm.QClientes.Close;

end;

function TGerapdfpedidovenda.FormataData(d: TDatetime): string;
begin
   result:=Datetostr(d);
end;

function TGerapdfpedidovenda.FormataTelefone(t: string): string;
begin
  result:=t;
end;

function TGerapdfpedidovenda.FormataValor(v: double): string;
begin
   result:=CurrToStr(V);
end;

procedure TGerapdfpedidovenda.Rodape(APDF: TFPDF);
begin
  APDF.SetY(-17);
  // Arial italic 8
//  APDF.SetFont('Arial','I',8);
  // Text color in gray
//  APDF.SetTextColor(128);
  // Page number
  APDF.Cell( 0, 10, 'Página '+IntToStr(APDF.PageNo()), '0', 0, 'C');
  APDF.SetY(-10);
//  APDF.Cell( 0, 10, QUni.fieldbyname('unid_nome').asstring+' - '+qUni.fieldbyname('unid_Endereco').asstring+' - '+
//                    QUni.fieldbyname('unid_fone').asstring+' - '+
//                    QUni.fieldbyname('unid_email').asstring , '0', 0, 'C');
//  apdf.Write(10,FUnidades.GetNome(unidade));

end;

function TGerapdfpedidovenda.space(n: integer): string;
/////////////////////////////////////////////////////////
var p:integer;
begin
   result:='';
   for p := 0 to n-1 do  result:=result+' ';
end;

end.
