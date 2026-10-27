unit vepdf;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.WebBrowser,
  FMX.Controls.Presentation,System.IOUtils,
{$IFDEF ANDROID}
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.provider,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Net,
  Androidapi.JNI.App,
  AndroidAPI.jNI.OS,
  Androidapi.JNIBridge,
  Androidapi.JNI.Java.Net,
  Androidapi.JNI,
  FMX.Helpers.Android,
  Androidapi.Helpers,
  IdUri,
  FMX.Platform.Android,
  FMX.Dialogs.Android,
{$ENDIF}
  FMX.StdCtrls;

type
  TFVePDF = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    WebBrowser: TWebBrowser;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(xarq:string);
  end;

var
  FVePDF: TFVePDF;

implementation

{$R *.fmx}

{ TFVePDF }

procedure TFVePDF.Execute(xarq: string);
var  arquivo:string;
 {$IFDEF ANDROID}
  Intent: JIntent;
  J: JFile;
  Uri: Jnet_Uri;
//  Permissao:JString;
  {$ENDIF}
  Sharedpath:string;
begin

 {$IFDEF ANDROID}
    if TFile.Exists(xarq) then
    begin
{
      LUri    := TAndroidHelper.StrToJURI(xarq);
      Intent := TJIntent.Create;
      Intent.setAction(TJIntent.JavaClass.ACTION_VIEW);
      Intent.setDataAndType(LUri,StringToJString('application/pdf'));
      Intent.addFlags(TJIntent.JavaClass.FLAG_GRANT_READ_URI_PERMISSION); // Conceder permissão de leitura

          SharedActivity.startActivity(Intent);
       try except
          on E: Exception do
            ShowMessage('Erro ao abrir o PDF: ' + E.Message);
        end;
}
  // Converte o caminho do arquivo em uma URI aceita pelas APIs modernas do Android
  URI := TAndroidHelper.JFileToJURI(TJFile.JavaClass.init(StringToJString(xarq)));
  Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW);
  Intent.setDataAndType(URI, StringToJString('application/pdf'));
  // Concede permissão temporária de leitura para o aplicativo que vai abrir o PDF
  Intent.setFlags(TJIntent.JavaClass.FLAG_GRANT_READ_URI_PERMISSION);
  try
    TAndroidHelper.Activity.startActivity(Intent);
  except
    on E: Exception do
      ShowMessage('Nenhum leitor de PDF encontrado no dispositivo.');
  end;
{
  Show;
// para 'limpar' o webbrowser' caso ja tenha visualizado outro pedido
//  webBrowser.Navigate('about:blank') ;
//  webbrowser.Navigate(Widestring(arquivo));
  webbrowser.Navigate('file://' + xarq );
//  webbrowser.Navigate('content:' + xarq );
  webbrowser.UpdateEffects;
//}

    end
    else
      ShowMessage('Arquivo '+xarq+' não encontrado.');
  {$ENDIF}




end;

procedure TFVePDF.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   WebBrowser.Stop;
end;

end.
