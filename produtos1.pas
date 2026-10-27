unit produtos1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts,
  FMX.Grid.Style, FMX.ScrollBox, Math, FMX.Objects, FMX.ExtCtrls,
   System.IOUtils, System.StartupCopy, Soap.EncdDecd,
   System.Generics.Collections;

type
  TFProdutos1 = class(TForm)
    sg: TStringGrid;
    EdDescricao: TEdit;
    bpesquisa: TSpeedButton;
    ToolBar1: TToolBar;
    sb: TSpeedButton;
    esto_codigo: TStringColumn;
    esto_descricao: TStringColumn;
    esto_unidade: TStringColumn;
    esto_venda: TStringColumn;
    Layout1: TLayout;
    Imagem: TImageControl;
    esto_imagem: TStringColumn;
    esto_desconto: TStringColumn;
    AniIndicator2: TAniIndicator;
    lmens: TLabel;
    AniIndicator1: TAniIndicator;
    AniIndicator3: TAniIndicator;
    procedure bpesquisaClick(Sender: TObject);
    procedure sbClick(Sender: TObject);
    procedure sgSelChanged(Sender: TObject);
    procedure sgSelectCell(Sender: TObject; const ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure EdDescricaoChange(Sender: TObject);
    procedure sgDrawColumnCell(Sender: TObject; const Canvas: TCanvas;
      const Column: TColumn; const Bounds: TRectF; const Row: Integer;
      const Value: TValue; const State: TGridDrawStates);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    function HexToInt(s:String):Int64;
    function BitmapFromBase64(const base64: string): TBitmap;
    function Base64FromBitmap(Bitmap: TBitmap): string;
    function StringToHex(S: String): string;
    function HexToString(H: String): String;
    procedure GetImagem( codigo:string ; Bmpx:TBitMap );
//    procedure GetImagem( codigo:string ; Bmpx:TImage );
// 14.10.2021
    procedure ExecuteX;
    procedure Mensagem(xmens:string;tempo:integer=0);

  end;

  type TProdutos=class
     esto_codigo,esto_descricao,esto_unidade:string;
     esto_venda,esto_desconto               :currency;
     esto_imagem : TBitMap;
//     esto_imagem : TImage;
//     esto_imagem : TSTringStream;

  end;

  var
  FProdutos1   : TFProdutos1;
  xcol,xlin    :integer;
  PProdutos    :TProdutos;
  ListaProdutos:TObjectList<TProdutos>;
//  str          : TMemoryStream;
//  str          : TStringStream;
  caminho,
  arquivo      : string;

  const colcodigo:integer=2;coldescricao:integer=1;colunidade:integer=3;colpreco:integer=4;
        coldesconto:integer=5;

  implementation

uses datam,pedido,FMX.VirtualKeyboard, FMX.Platform;


{$R *.fmx}
//{$R *.LgXhdpiPh.fmx ANDROID}
//{$R *.NmXhdpiPh.fmx ANDROID}

{ TFProdutos1 }

// 20.01.2021
// Converte um Bitmap em uma string no formato base64...
function TFProdutos1.BitmapFromBase64(const base64: string): TBitmap;
////////////////////////////////////////////////////////////
var Input,OutPut:TStringStream;

//    Output:TBytesStream;

begin

  Input:=TStringStream.Create(base64, TEncoding.ASCII);
  try
//    Output:=TBytesStream.Create;
    Output:=TStringStream.Create;
    try
      Soap.EncdDecd.DecodeStream(Input, Output);
      Output.Position := 0;
      Result := TBitmap.Create;
      try
        Result.LoadFromStream(Output);
      except
        Result.Free;
        raise;
      end;
    finally
      Output.Free;
    end;
  finally
    Input.Free;
  end;
end;

// 20.01.2021
// Converte um Bitmap em uma string no formato base64...
function TFProdutos1.Base64FromBitmap(Bitmap: TBitmap): string;
///////////////////////////////////////////////////////
var
// Input:TBytesStream;
    Output,
    Input :TStringStream;

begin

//  Input:=TBytesStream.Create;
  Input:=TStringStream.Create;
  try
    Bitmap.SaveToStream(Input);
    Input.Position := 0;
    Output := TStringStream.Create('', TEncoding.ASCII);
    try
      Soap.EncdDecd.EncodeStream(Input, Output);
      Result := Output.DataString;
    finally
      Output.Free;
    end;
  finally
    Input.Free;
  end;
end;


function TFProdutos1.StringToHex(S: String): string;
///////////////////////////////////////////
var I: Integer;
begin
  Result:= '';
  for I := 1 to length (S) do
    Result:= Result+IntToHex(ord(S[i]),2);
end;

function TFProdutos1.HexToString(H: String): String;
///////////////////////////////////////////
var I: Integer;
begin
  Result:= '';
  for I := 1 to length (H) div 2 do
    Result:= Result+Char(StrToInt('$'+Copy(H,(I-1)*2+1,2)));
end;


// 14.10.2021
procedure TFProdutos1.Mensagem(xmens: string; tempo: integer);
//////////////////////////////////////////////////////////////
begin

   lmens.Text:=xmens;
   lmens.UpdateEffects;
//   Application.ProcessMessages;
   if tempo > 0 then

      Sleep( tempo );

end;

function TFProdutos1.HexToInt(s:String):Int64;
////////////////////////////////////////////////
const Base='0123456789ABCDEF';
var i,p,m:Integer;
    x:Int64;
begin
  Result:=0;
  m:=0;
  x:=1;
  for i:=Length(s) downto 1 do begin
      p:=Pos(s[i],Base)-1;
      Result:=Result+(p*x);
      Inc(m);
      x:=Trunc(Power(16,m));
  end;
end;



// 06.06.15
procedure TFProdutos1.bpesquisaClick(Sender: TObject);
////////////////////////////////////////////////////////
var p,l:integer;
    x: IFMXVirtualKeyboardService;

begin

 x:=TPlatformServices.Current.GetPlatformService(IFMXVirtualKeyboardService) as IFMXVirtualKeyboardService;

// if  TVirtualKeyboardState.Visible in x.VirtualKeyBoardState then
//       x.HideVirtualKeyboard;
  xcol:=-1;xlin:=-1;
  sg.RowCount:=0;
  l:=0;
//  str := TStringStream.create;

  for p := 0 to ListaProdutos.Count-1  do begin

   PProdutos:=ListaProdutos[p];
   if ( Ansipos(Uppercase(eddescricao.Text),Uppercase(PProdutos.esto_descricao))>0 )
      or
      ( trim(EdDescricao.text) = '' )  // 21.09.2021

     then begin

     sg.RowCount:=sg.RowCount+1;
     inc(l);
// 17.01.2021
//     str.LoadFromStream( PProdutos.esto_imagem );
//     sg.Cells[0,l-1]  := 'tratar' ;
     sg.Cells[colcodigo,l-1]:= PProdutos.esto_codigo;
     sg.Cells[coldescricao,l-1]:= PProdutos.esto_descricao;
     sg.Cells[colunidade,l-1]:= PProdutos.esto_unidade;
     sg.Cells[colpreco,l-1]:= Currtostr(PProdutos.esto_venda);
     sg.Cells[coldesconto,l-1]:= Currtostr(PProdutos.esto_desconto);

   end;

  end;
  sg.UpdateEffects;
// 21.09.2021
 if  TVirtualKeyboardState.Visible in x.VirtualKeyBoardState then
       x.HideVirtualKeyboard;

end;

procedure TFProdutos1.EdDescricaoChange(Sender: TObject);
///////////////////////////////////////////////////////////////////
begin

  bpesquisaclick(self);

end;

procedure TFProdutos1.Execute;
//////////////////////////////////
var p,
    i   :integer;
    Buf :Array[1..2] of Char;
    Buf01 :Array[1..2] of String;
    s   : string;

begin

//  show;

///
  {$IFDEF ANDROID}
//     caminho:=GetHomePath ;
     caminho:=TPath.GetTempPath ;
     Arquivo:=caminho+ '/teste.jpg';
//     caminho:=TPath.Combine(TPath.GetDocumentsPath, 'teste.jpg');
//     caminho:=TPath.Combine(TPath.GetHomePath, 'teste.jpg');
//     caminho:='/Android/data/com.embarcadero.VendasCelular/files/teste.jpg';
//     Arquivo:=caminho;
  {$ELSE}
     caminho:=ExtractFilePath( Application.Title ) ;
     Arquivo:=caminho+ '\teste.jpg';
  {$ENDIF}

  if not dm.QProdutos.Active then begin

    TThread.CreateAnonymousThread(procedure
    begin
          AniIndicator2.Visible := true;
          AniIndicator2.Enabled := true;
          Mensagem('Aguarde, carregando produtos...');

//   dm.QProdutos.Close;
       dm.QProdutos.Sql.Clear;
       dm.QProdutos.SQL.Add('select esto_desconto,esto_imagem,esto_codigo,esto_descricao,esto_unidade,'+
                            '(select esqt_vendavis from estoqueqtde where esto_codigo=esqt_esto_codigo) as precovenda from estoque'+
                            ' order by esto_descricao' );

//       Mensagem('Abrindo arquivo de produtos...');
       dm.QProdutos.open;
       p:=0;
       sg.RowCount:=0;
       ListaProdutos:=TObjectList<TProdutos>.Create;
//       Str := TMemoryStream.create;
//       mensagem('Montando tela...',0);
//       sg.BeginUpdate;
       while not dm.QProdutos.Eof do begin
         inc(p);
         sg.RowCount:=p;
    // 17.01.2021
         sg.Cells[colcodigo,p-1]:=dm.QProdutos.FieldByName('esto_codigo').AsString;
         sg.Cells[coldescricao,p-1]:=dm.QProdutos.FieldByName('esto_descricao').AsString;
         sg.Cells[colunidade,p-1]:=dm.QProdutos.FieldByName('esto_unidade').AsString;
         sg.Cells[colpreco,p-1]:=dm.QProdutos.FieldByName('precovenda').AsString;
    // 21.06.2021
         sg.Cells[coldesconto,p-1] := dm.QProdutos.Fieldbyname('esto_desconto').AsString;
         PProdutos:=TProdutos.Create;
         PProdutos.esto_codigo:=dm.QProdutos.FieldByName('esto_codigo').AsString;
         PProdutos.esto_descricao:=dm.QProdutos.FieldByName('esto_descricao').AsString;
         PProdutos.esto_unidade:=dm.QProdutos.FieldByName('esto_unidade').AsString;
         PProdutos.esto_venda:=dm.QProdutos.FieldByName('precovenda').Ascurrency;
    // 21.06.2021 - Guiber
         PProdutos.esto_desconto := dm.QProdutos.FieldByName('esto_desconto').Ascurrency;
         s := dm.QProdutos.FieldByName('esto_imagem').AsString;
           if trim(s)<> '' then begin
                PProdutos.esto_imagem := TBitMap.Create;
    //            PProdutos.esto_imagem := TImage.Create(Owner);
                PProdutos.esto_imagem.Assign( BitmapFromBase64( HextoString(dm.QProdutos.fieldbyname('esto_imagem').asstring) ) );
    //            PProdutos.esto_imagem.Bitmap.Assign( BitmapFromBase64( HextoString(dm.QProdutos.fieldbyname('esto_imagem').asstring) ) );
    //            Imagem.BitMap.Assign( PProdutos.esto_imagem );
           end else
                PProdutos.esto_imagem := nil;

         //end;
         ListaProdutos.Add(PProdutos);
     //    mensagem('Montando tela codigo '+PProdutos.esto_codigo,0);

          dm.QProdutos.Next;

        end;

          TThread.Synchronize(nil, procedure
          begin
//                        TLoading.Hide;
            AniIndicator2.Visible := false;
            AniIndicator2.Enabled := false;
//            sg.EndUpdate;
            Mensagem(' ');
            sg.UpdateEffects;
          end);

    end).Start;

  end;
end;

// 14.10.2021
procedure TFProdutos1.ExecuteX;
///////////////////////////////
begin

       Execute;
       show;

end;

procedure TFProdutos1.GetImagem(codigo: string ; Bmpx: TBitMap );
//procedure TFProdutos1.GetImagem(codigo: string ; Bmpx: TImage );
//////////////////////////////////////////////////////////////
var p:integer;

begin

   for p := 0 to ListaProdutos.count-1 do begin

      PProdutos := ListaProdutos[p];
      if PProdutos.esto_codigo = codigo then begin

//         if not PProdutos.esto_imagem.IsEmpty then
//         if not PProdutos.esto_imagem.Size.IsZero then
//         if not PProdutos.esto_imagem.Bitmap.IsEmpty then
         if PProdutos.esto_imagem <> nil then

             Bmpx.Assign( PProdutos.esto_imagem );
//             Bmpx.Bitmap.Assign( PProdutos.esto_imagem );

      end;

   end;

end;

procedure TFProdutos1.sbClick(Sender: TObject);
///////////////////////////////////////////////////////
begin
  if xlin>=0 then begin

    FPedido.EdCodpro.text:=sg.Cells[colcodigo,xlin];
    FPedido.EdDescricao.text:=sg.Cells[coldescricao,xlin];
    FPedido.EdUnitario.text:=sg.Cells[colpreco,xlin];
// 21.06.2021
    FPedido.EdDescontoMaximo.text := sg.cells[coldesconto,xlin];
    FPedido.EdQtde.text:='';
    FPedido.EdQtde.SetFocus;
// 07.04.2022
    FPedido.EdUnidade.text := sg.cells[colunidade,xlin];

  end;
  Close;

end;


procedure TFProdutos1.sgDrawColumnCell(Sender: TObject; const Canvas: TCanvas;
  const Column: TColumn; const Bounds: TRectF; const Row: Integer;
  const Value: TValue; const State: TGridDrawStates);
///////////////////////////////////////////////////////////////////////

begin

//   if (Column.Index=0) then
//      showmessage('str.Size no drawcolumncell='+inttostr(str.Size) );


   if false then begin
//   if (Column.Index=0) and ( str.size>1) then begin
//   if (Column.Index=0) and ( not Imagem.Bitmap.IsEmpty )  and (sg.tag=0)  then begin

     with Canvas do
     begin

//        Imagem.DrawBitmap(sg.Canvas,Bounds,Imagem.Bitmap,0);
//        Bitmap.Assign(Imagem.BitMap);  // segmentation fault
//          DrawBitmap(Imagem.Bitmap,Bounds,Bounds,0);

  // Draw the image in the cell
      DrawBitmap(Imagem.Bitmap,Bounds.Empty,Bounds.Ceiling,0);

     end;
     sg.tag := 1;

   end;

end;

procedure TFProdutos1.sgSelChanged(Sender: TObject);
begin

  if (xcol>0) and (xlin>0)  then begin

    FPedido.EdCodpro.text:=sg.Cells[colcodigo,xlin];
    FPedido.EdDescricao.text:=sg.Cells[coldescricao,xlin];
    FPedido.EdUnitario.text:=sg.Cells[colpreco,xlin];
// 21.06.2021
    FPedido.EdDescontoMaximo.text := sg.cells[coldesconto,xlin];
    FPedido.EdQtde.SelStart:=0;
    FPedido.EdQtde.text:='';
    FPedido.EdQtde.SetFocus;
    FPedido.EdQtde.UpdateEffects;
// 07.04.2022
    FPedido.EdUnidade.text := sg.cells[colunidade,xlin];
    Close;

  end;

end;

procedure TFProdutos1.sgSelectCell(Sender: TObject; const ACol, ARow: Integer;
  var CanSelect: Boolean);

var Bmp : TBitMap;
//var Bmp : TImage;

begin

  if (arow<=sg.RowCount) and ( acol<=sg.ColumnCount ) and (sg.RowCount>0)
    then begin

    xcol:=acol;
    xlin:=arow;
    Bmp := TBitMap.Create;
//    Bmp := TImage.Create(Owner);

    GetImagem( trim(Sg.cells[colcodigo,arow]),Bmp  );

    if not bmp.IsEmpty then

       Imagem.BitMap.Assign( Bmp )
//       Imagem.Bitmap.EqualsBitmap( Bmp.Bitmap )
//       Image1.MultiResBitmap[0].Assign(  Bmp )

    else

       Imagem.BitMap.Assign( nil );
//       Imagem.Assign( nil );

    bmp.free;

  end;

end;

end.
