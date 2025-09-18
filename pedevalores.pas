unit pedevalores;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation;

type
  TFPedeValores = class(TForm)
    Panel1: TPanel;
    EdInicial: TEdit;
    EdFinal: TEdit;
    procedure EdInicialKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    var retorno:Currency;

  end;

var
  FPedeValores: TFPedeValores;

implementation

{$R *.fmx}

procedure TFPedeValores.EdInicialKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if not (KeyChar in ['1','2','3','4','5','6','7','8','9','0',',']) then
     KeyChar :=#0;
end;

procedure TFPedeValores.Execute;
begin

  Show;

end;

procedure TFPedeValores.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   retorno:=StrToCurrDef(EdFinal.text,0) - StrToCurrDef(EdInicial.text,0);
   if retorno<=0 then begin
      ShowMessage('Diferença tem que ser maior que zero');
      retorno:=0;
   end;

end;

end.
