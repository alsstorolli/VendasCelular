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
  Intent: JIntent;
  J: JFile;
  LUri: Jnet_Uri;
  Sharedpath:string;
  Permissao:JString;
begin

//  arquivo:='file://' + xarq;
//  arquivo:='file:/' + xarq;
//  arquivo:='file:' + xarq;
//  arquivo:='file:///' + xarq;
//  arquivo:=xarq;
//  ShowMessage('Arquivo='+arquivo+' xarq='+xarq);

//  SharedPath:=TPath.Combine(TPath.GetSharedDocumentsPath,'AppSac');
//  if not DirectoryExists(SharedPath) then
//     ForceDirectories(SharedPath);

//  ShowMessage('Apos sharedpath  Sharedpath='+sharedpath+' xarq='+xarq);

//  SharedPath:=TPath.Combine(SharedPath,xarq);
//  ShowMessage('Apos sharedpath tpath.combine... Sharedpath='+sharedpath+' xarq='+xarq);

//  if TFile.Exists(Sharedpath) then TFile.Delete(Sharedpath);

//  ShowMessage('Apos fileexists delete. Sharedpath='+sharedpath+' Arquivo='+arquivo+' xarq='+xarq);

//  TFile.Copy(xarq,sharedpath);

//  ShowMessage('Apos o copy.  Sharedpath='+sharedpath+' xarq='+xarq);

//  xarq:=sharedpath;

//  ShowMessage('Sharedpath='+sharedpath);
//  arquivo:='file:/' + xarq;
  Permissao:=StringToJString(JStringToString(TAndroidHelper.Context.getApplicationContext.getPackageName) + '.fileprovider');
  // Certifique-se de que o arquivo existe
  if TFile.Exists(xarq) then
  begin

  //    LUri := TJnet_Uri.JavaClass.parse(StringToJString(arquivo));
//    Luri := TJFileProvider.JavaClass.GeturiForFile();
    LUri    := TAndroidHelper.StrToJURI(xarq);
    Intent := TJIntent.Create;
    Intent.setAction(TJIntent.JavaClass.ACTION_VIEW);
    Intent.setDataAndType(LUri,StringToJString('application/pdf'));
    Intent.addFlags(TJIntent.JavaClass.FLAG_GRANT_READ_URI_PERMISSION); // Conceder permissão de leitura

//    ShowMessage('Antes de abrir o pdf em xarq='+xarq);
    // 3. Iniciar a atividade no Android
    try
        SharedActivity.startActivity(Intent);
//        TAndroidHelper.Activity.startActivity(Intent);
      except
        on E: Exception do
          ShowMessage('Erro ao abrir o PDF: ' + E.Message);
      end;


{
    Intent := TJIntent.JavaClass.init;
    Intent.setAction(TJIntent.JavaClass.ACTION_VIEW);
    J := TJFile.JavaClass.init(StringToJString(xarq));
    Intent.setDataAndType(TAndroidHelper.JFileToJURI(J), StringToJString('application/pdf'));
    Intent.setFlags(TJintent.JavaClass.FLAG_GRANT_READ_URI_PERMISSION);
    SharedActivity.StartActivity(Intent);
}

    {
      PDFFile := TJavaFile.JavaObject.init(PDFPath);
      PDFUri := TAndroidContent.JavaClass.From(TAndroidContent). getContentUri(PDFFile);

      // 3. Criar o Intent para exibir o PDF
      Intent := TAndroidIntent.Create;
      Intent.setAction(TJIntent.JavaClass.ACTION_VIEW); // Ação para visualizar
      Intent.setData(JObject(PDFUri)); // Define o URI do PDF
      Intent.setType(JStringToString('application/pdf')); // Tipo MIME do PDF
      Intent.addFlags(TJIntent.JavaClass.FLAG_GRANT_READ_URI_PERMISSION); // Concede permissão de leitura

      // 4. Iniciar a atividade do visualizador de PDF
      try
        TJActivityManager.JavaClass.getFrom(TAndroidApp.Context).startActivity(Intent);
      except
        on E: Exception do
          ShowMessage('Erro ao abrir o PDF: ' + E.Message);
      end;
      }
  end
  else
    ShowMessage('Arquivo '+xarq+' não encontrado.');


{
//  Show;
// para 'limpar' o webbrowser' caso ja tenha visualizado outro pedido
//  webBrowser.Navigate('about:blank') ;
//  webbrowser.Navigate(Widestring(arquivo));
//  webbrowser.Navigate('content:/' + xarq );
//  webbrowser.Navigate('content:' + xarq );
//  webbrowser.setfocus;
}

end;

procedure TFVePDF.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   WebBrowser.Stop;
end;

end.
