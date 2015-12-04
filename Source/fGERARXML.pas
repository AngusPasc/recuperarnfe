unit fGERARXML;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Menus, Vcl.ComCtrls, SHDocVw, MSHtml, UrlMon, WinInet, Vcl.Imaging.pngimage,
  (* ACBr *) ACBrUtil, pcnAuxiliar, ACBrDFeUtil, ACBrNFeConfiguracoes,
  (* Projeto *) Metodos, HTMLtoXML;

type
  TFfGERARXML = class(TForm)
    Memo2: TMemo;
    WebBrowser: TWebBrowser;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    LabelChavedeAcesso: TLabel;
    lblStatus: TLabel;
    ImageCaptcha: TImage;
    Label4: TLabel;
    ProgressBar1: TProgressBar;
    edtChaveNFe: TEdit;
    EditCaptcha: TEdit;
    BitBtnXML1: TButton;
    ButtonNovaConsulta: TButton;
    wbXMLResposta: TWebBrowser;
    ImageRx: TImage;
    procedure FormShow(Sender: TObject);
    procedure BtCloseClick(Sender: TObject);
    procedure WebBrowserProgressChange(ASender: TObject; Progress, ProgressMax: Integer);
    procedure WebBrowserDocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
    procedure DeleteIECache;
    procedure NovaConsulta;
    procedure BitBtnXML1Click(Sender: TObject);
    procedure ButtonNovaConsultaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FfGERARXML: TForm;
  DirXML: String;

implementation

{$R *.dfm}

procedure TFfGERARXML.FormShow(Sender: TObject);
begin
   inherited;
   DirXML := GetTempDir;
   NovaConsulta;
end;

procedure TFfGERARXML.ButtonNovaConsultaClick(Sender: TObject);
begin
   NovaConsulta;
   DeleteIECache;
   EditCaptcha.Clear;
   ProgressBar1.Position := 0;
   lblStatus.Caption := '';
end;

procedure TFfGERARXML.BitBtnXML1Click(Sender: TObject);
begin
   inherited;
   if trim(edtChaveNFe.Text) = '' then
   begin
      MessageDlg('Chave de acesso não informado!', mtError, [mbok], 0);
      if edtChaveNFe.CanFocus then
         edtChaveNFe.SetFocus;
      Exit;
   end;

   if trim(EditCaptcha.Text) = '' then
   begin
      MessageDlg('Digite o valor da imagem!', mtError, [mbok], 0);
      if EditCaptcha.CanFocus then
         EditCaptcha.SetFocus;
      Exit;
   end;

   try
      WebBrowser.OleObject.Document.all.Item('ctl00$ContentPlaceHolder1$txtChaveAcessoCompleta', 0).value := edtChaveNFe.Text;
      WebBrowser.OleObject.Document.all.Item('ctl00$ContentPlaceHolder1$txtCaptcha', 0).value := EditCaptcha.Text;
      WebBrowser.OleObject.Document.all.Item('ctl00$ContentPlaceHolder1$btnConsultar', 0).click;
   except
      raise;
   end;
   lblStatus.Caption := 'Em Processamento';
end;

procedure TFfGERARXML.BtCloseClick(Sender: TObject);
begin
   inherited;
   DeleteIECache;
   ProgressBar1.Position := 0;
   WebBrowser.Stop;
   Close;
end;

procedure TFfGERARXML.WebBrowserDocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
var
  i: Integer;
  Source: AnsiString;
  dest, XMLGerado, PathImage: string;
  textoNFe: IHTMLDocument2;
begin
   Application.ProcessMessages;
   try
      if (WebBrowser.LocationURL = 'http://www.nfe.fazenda.gov.br/portal/consulta.aspx?tipoConsulta=completa&tipoConteudo=XbSeqxE8pl8=') or
         (WebBrowser.LocationURL = 'http://www.nfe.fazenda.gov.br/portal/consulta.aspx?tipoConsulta=completa&tipoConteudo=XbSeqxE8pl8%3d') then
      begin
         try
            textoNFe := WebBrowser.Document as IHTMLDocument2;
            repeat
               Application.ProcessMessages;
            until Assigned(textoNFe.body);

            Memo1.Lines.Clear;
            Memo1.Lines.Text := textoNFe.body.innerHTML;
            Source := StripLinkBase64(Memo1.Lines.Text);
            Source := Copy(Source, 8, length(Source));

            dest := GetTempDir + 'captcha.png';
            ConverteBase64(Source, dest);
            PathImage := GetTempDir + 'captcha';
            ImageCaptcha.Picture.LoadFromFile(dest);
            ProgressBar1.Position := 0;
            lblStatus.Caption := '';
            if edtChaveNFe.CanFocus then
               edtChaveNFe.SetFocus;
         except
         end;
      end
      else
      if (WebBrowser.LocationURL = 'http://www.nfe.fazenda.gov.br/portal/consultaCompleta.aspx?tipoConteudo=XbSeqxE8pl8=') then
      begin
         textoNFe := WebBrowser.Document as IHTMLDocument2;
         repeat
            Application.ProcessMessages;
         until Assigned(textoNFe.body);
         Memo2.Lines.Text := StripHTML(textoNFe.body.innerHTML);
         Memo2.Lines.Text := StringReplace(Memo2.Lines.Text,'&nbsp;','',[rfReplaceAll, rfIgnoreCase]);

         i := 0;
         while i < memo2.Lines.Count-1 do
         begin
            if trim(Memo2.Lines[i]) = '' then
            begin
               Memo2.Lines.Delete(i);
               i := i - 1;
            end;
            if pos('function',Memo2.lines[i])>0 then
            begin
               Memo2.Lines.Delete(i);
               i := i - 1;
            end;
            if pos('document',Memo2.lines[i])>0 then
            begin
               Memo2.Lines.Delete(i);
               i := i - 1;
            end;
            if pos('{',Memo2.lines[i])>0 then
            begin
               Memo2.Lines.Delete(i);
               i := i - 1;
            end;
            if pos('}',Memo2.lines[i])>0 then
            begin
               Memo2.Lines.Delete(i);
               i := i - 1;
            end;
            i := i + 1;
         end;

         if not(FindText(Memo2, 'NF-e INEXISTENTE na base nacional')) then
         begin
            try
               XMLGerado := GerarXML(Memo2.Lines.Text, DirXML);
               wbXMLResposta.Navigate(XMLGerado);
               lblStatus.Caption := 'Concluído';
               ProgressBar1.Position := 0;
               WebBrowser.Stop;
               DeleteFile(XMLGerado);
            except
               raise
            end;
         end;
      end
      else
      if WebBrowser.LocationURL = 'http://www.nfe.fazenda.gov.br/portal/consultaCompleta.aspx?tipoConteudo=XbSeqxE8pl8=' then
         NovaConsulta;

   finally
   end;
end;

procedure TFfGERARXML.WebBrowserProgressChange(ASender: TObject; Progress, ProgressMax: Integer);
begin
   inherited;
   if ProgressMax = 0 then
      Exit
   else
   begin
      try
         ProgressBar1.Max := ProgressMax;
         if (Progress <> -1) and (Progress <= ProgressMax) then
            ProgressBar1.Position := Progress;
      except
         on EDivByZero do
           Exit;
      end;
   end;
end;

procedure TFfGERARXML.DeleteIECache;
var
   lpEntryInfo: PInternetCacheEntryInfo;
   hCacheDir: LongWord;
   dwEntrySize: LongWord;
begin
   dwEntrySize := 0;

   FindFirstUrlCacheEntry(nil, TInternetCacheEntryInfo(nil^), dwEntrySize);

   GetMem(lpEntryInfo, dwEntrySize);

   if dwEntrySize>0 then
     lpEntryInfo^.dwStructSize := dwEntrySize;

   hCacheDir := FindFirstUrlCacheEntry(nil, lpEntryInfo^, dwEntrySize);

   if hCacheDir<>0 then
   begin
     repeat
       DeleteUrlCacheEntry(lpEntryInfo^.lpszSourceUrlName);
       FreeMem(lpEntryInfo, dwEntrySize);
       dwEntrySize := 0;
       FindNextUrlCacheEntry(hCacheDir, TInternetCacheEntryInfo(nil^), dwEntrySize);
       GetMem(lpEntryInfo, dwEntrySize);
       if dwEntrySize>0 then
         lpEntryInfo^.dwStructSize := dwEntrySize;
     until not FindNextUrlCacheEntry(hCacheDir, lpEntryInfo^, dwEntrySize)
   end;
   FreeMem(lpEntryInfo, dwEntrySize);

   FindCloseUrlCache(hCacheDir)
end;

procedure TFfGERARXML.NovaConsulta;
begin
   if TemConexaoInternet('http://www.nfe.fazenda.gov.br') then
   begin
      DeleteIECache;
      Memo2.Lines.Clear;
      WebBrowser.Silent := True;
      WebBrowser.Navigate('http://www.nfe.fazenda.gov.br/portal/consulta.aspx?tipoConsulta=completa&tipoConteudo=XbSeqxE8pl8=');
   end
   else
   begin
      ShowMessage('O Portal da NF-e está fora do ar. Tente novamente mais tarde!');
      Close;
   end;
end;

initialization
   RegisterClasses([TFfGERARXML]);
end.
