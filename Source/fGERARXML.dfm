object FfGERARXML: TFfGERARXML
  Left = 322
  Top = 102
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Recuperar XML da NF-e'
  ClientHeight = 461
  ClientWidth = 829
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Memo2: TMemo
    Left = 619
    Top = 321
    Width = 57
    Height = 54
    TabStop = False
    Align = alCustom
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 619
    Top = 260
    Width = 57
    Height = 54
    TabStop = False
    Align = alCustom
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 829
    Height = 73
    Align = alTop
    Color = clWindow
    ParentBackground = False
    TabOrder = 2
    object lbl3: TLabel
      Left = 10
      Top = 11
      Width = 559
      Height = 28
      Cursor = crHandPoint
      AutoSize = False
      Caption = 'https://github.com/recuperarxml/recuperarnfe'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -20
      Font.Name = 'Verdana'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = lbl3Click
    end
  end
  object Panel2: TPanel
    Left = 415
    Top = 73
    Width = 414
    Height = 388
    Align = alClient
    TabOrder = 3
    object wbXMLResposta: TWebBrowser
      Left = 1
      Top = 1
      Width = 412
      Height = 386
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 415
      ExplicitHeight = 393
      ControlData = {
        4C000000952A0000E52700000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 73
    Width = 415
    Height = 388
    Align = alLeft
    Color = clWindow
    ParentBackground = False
    TabOrder = 4
    object LabelChavedeAcesso: TLabel
      Left = 16
      Top = 15
      Width = 269
      Height = 19
      Caption = '1 - Digitar a chave de acesso da NF-e:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblStatus: TLabel
      Left = 16
      Top = 323
      Width = 373
      Height = 20
      Alignment = taCenter
      AutoSize = False
      Caption = 'Conectando'
      FocusControl = ProgressBar1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object ImageCaptcha: TImage
      Left = 17
      Top = 124
      Width = 387
      Height = 79
      Stretch = True
    end
    object Label4: TLabel
      Left = 20
      Top = 219
      Width = 291
      Height = 23
      AutoSize = False
      Caption = '3 - Digite as letras/n'#250'meros da imagem:'
      FocusControl = ProgressBar1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 16
      Top = 77
      Width = 225
      Height = 19
      Caption = '2 - Carregar a imagem captcha:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 20
      Top = 270
      Width = 224
      Height = 23
      AutoSize = False
      Caption = '4 - Iniciar o download do XML:'
      FocusControl = ProgressBar1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object ProgressBar1: TProgressBar
      Left = 16
      Top = 347
      Width = 373
      Height = 27
      TabOrder = 0
    end
    object edtChaveNFe: TEdit
      Left = 16
      Top = 36
      Width = 388
      Height = 24
      TabStop = False
      Color = 10930928
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      HideSelection = False
      ParentFont = False
      TabOrder = 1
    end
    object EditCaptcha: TEdit
      Left = 312
      Top = 217
      Width = 92
      Height = 27
      Color = 10930928
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      HideSelection = False
      ParentFont = False
      TabOrder = 2
    end
    object BitBtnXML1: TButton
      Left = 246
      Top = 263
      Width = 158
      Height = 35
      Caption = 'Download do XML'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = BitBtnXML1Click
    end
    object ButtonNovaConsulta: TButton
      Left = 248
      Top = 72
      Width = 156
      Height = 34
      Caption = 'Carregar imagem'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = ButtonNovaConsultaClick
    end
  end
  object WebBrowser: TWebBrowser
    Left = 907
    Top = 176
    Width = 100
    Height = 78
    TabOrder = 5
    OnProgressChange = WebBrowserProgressChange
    OnDocumentComplete = WebBrowserDocumentComplete
    ControlData = {
      4C000000560A0000100800000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
end
