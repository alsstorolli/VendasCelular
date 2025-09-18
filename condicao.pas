unit condicao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, FireDAC.UI.Intf, FireDAC.FMXUI.Wait, FMX.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Comp.UI, Data.Bind.Components, Data.Bind.Grid,
  Data.Bind.DBScope, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, FMX.Grid,
  FMX.Grid.Style, FMX.ScrollBox;

type
  TFpgto = class(TForm)
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fpgto: TFpgto;
  xcol,xlin:integer;

implementation

uses datam, pedido, fmx.gestures;


{$R *.fmx}

procedure TFpgto.FormActivate(Sender: TObject);
begin
  if not dm.conexao.Connected then dm.conexao.Connected:=true;
  if not dm.TabFpgto.Active then dm.TabFpgto.Open;
  xcol:=-1;xlin:=-1;

end;

procedure TFpgto.sbClick(Sender: TObject);
begin
  if xlin>=0 then begin

    FPedido.EdCondicao.text:=sg.Cells[0,xlin];
    FPedido.labelcondicao.Text:=sg.Cells[1,xlin];
    FPedido.EdDescriaofpagto.Text:=sg.Cells[1,xlin];

  end;
  Close;

end;

procedure TFpgto.sgSelChanged(Sender: TObject);
begin
  if (xcol>0) and (xlin>=0)  then begin

    FPedido.EdCondicao.text:=sg.Cells[0,xlin];
    FPedido.labelcondicao.Text:=sg.Cells[1,xlin];
    FPedido.EdDescriaofpagto.Text:=sg.Cells[1,xlin];
    Close;

  end;

end;

procedure TFpgto.sgSelectCell(Sender: TObject; const ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if (arow<=sg.RowCount) and ( acol<=sg.ColumnCount ) and (sg.RowCount>0)  then begin
    xcol:=acol;
    xlin:=arow;
  end;
end;

end.
