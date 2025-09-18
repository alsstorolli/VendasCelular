unit portadores;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, FireDAC.UI.Intf, FireDAC.FMXUI.Wait, FireDAC.Stan.Intf,
  FireDAC.Comp.UI, Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, FMX.Grid,
  FMX.Grid.Style, FMX.ScrollBox;

type
  TFPortadores = class(TForm)
    sg: TStringGrid;
    EdNome: TEdit;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    ToolBar1: TToolBar;
    sb: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure sbClick(Sender: TObject);
    procedure sgSelectCell(Sender: TObject; const ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sgSelChanged(Sender: TObject);
    procedure sgGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPortadores: TFPortadores;
  xcol,xlin:integer;

implementation

uses datam, pedido,fmx.gestures;

{$R *.fmx}

procedure TFPortadores.FormActivate(Sender: TObject);
begin

  if not dm.conexao.Connected then dm.conexao.Connected:=true;
  if not dm.TabPortadores.Active then dm.TabPortadores.Open;
  xcol:=-1;xlin:=-1;

end;

procedure TFPortadores.sgGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
var s:string;
begin



end;

procedure TFPortadores.sgSelChanged(Sender: TObject);
begin


  if (xcol>0) and (xlin>=0)  then begin

     FPedido.EdPOrtador.text:=sg.Cells[0,xlin];
     FPedido.labelportador.Text:=sg.Cells[1,xlin];
     FPedido.EdDescricaoPortador.text:=sg.Cells[1,xlin];
     close;

  end;

end;

procedure TFPortadores.sgSelectCell(Sender: TObject; const ACol,
  ARow: Integer; var CanSelect: Boolean);
  /////////////////////////////////////////////////////
begin

//  showmessage( 'no selectcell linha '+inttostr(arow) );

  if (arow<=sg.RowCount) and ( acol<=sg.ColumnCount ) and (sg.RowCount>0)  then begin
   xcol:=acol;
   xlin:=arow;
 end;

end;

procedure TFPortadores.sbClick(Sender: TObject);
begin

   if xlin>=0 then begin

     FPedido.EdPOrtador.text:=sg.Cells[0,xlin];
     FPedido.labelportador.Text:=sg.Cells[1,xlin];
     FPedido.EdDescricaoPortador.text:=sg.Cells[1,xlin];

   end;
   Close;

end;


end.
