!include MUI2.nsh
!include LogicLib.nsh
!include WinMessages.nsh
!include FileFunc.nsh
!include nsDialogs.nsh
!include x64.nsh
!include InstallOptions.nsh

RequestExecutionLevel admin # Privilégios de usuário para instalação
XPStyle on
SetOverwrite on 
ShowInstDetails nevershow 
ShowUninstDetails nevershow 

Name "RecuperarNFe" 
OutFile "InstaladorRecuperarNFe.exe"
InstallDir "$PROGRAMFILES\RecuperarNFe"
BrandingText "https://github.com/recuperarxml/recuperarnfe"

# instalador
!define MUI_PRODUCT "RecuperarNFe"
!define MUI_FINISHPAGE_LINK "https://github.com/recuperarxml/recuperarnfe"
!define MUI_FINISHPAGE_LINK_LOCATION https://github.com/recuperarxml/recuperarnfe
!define MUI_COMPONENTSPAGE_NODESC # Não mostra a descrição de cada componente

!define MUI_WELCOMEPAGE_TITLE "Bem-vindo à instalação do RecuperarNFe" 
!define MUI_WELCOMEPAGE_TEXT "Este assistente instalará o RecuperarNFe no seu computador.$\r$\n$\r$\n\
Clique em Próximo para continuar."

# desinstalador
!define MUI_UNWELCOMEPAGE_TITLE "Bem-vindo à desinstalação do RecuperarNFe" 
!define MUI_UNWELCOMEPAGE_TEXT "Este assistente desinstalará o RecuperarNFe no seu computador.$\r$\n$\r$\n\
Clique em Próximo para continuar."

# instalador
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "..\Images\cs.bmp"
!define MUI_HEADERIMAGE_RIGHT
!define MUI_ICON "..\Images\RecuperarNFe_Icon.ico"
!define MUI_WELCOMEFINISHPAGE_BITMAP "..\Images\Front.bmp"

# desinstalador
!define MUI_UNHEADERIMAGE
!define MUI_UNHEADERIMAGE_BITMAP "..\Images\cs.bmp"
!define MUI_UNHEADERIMAGE_RIGHT
!define MUI_UNICON "..\Images\RecuperarNFe_Icon.ico"
!define MUI_UNWELCOMEFINISHPAGE_BITMAP "..\Images\Front.bmp"

!insertmacro MUI_PAGE_INSTFILES
!define MUI_FINISHPAGE_RUN "$INSTDIR\RecuperarNFe.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Iniciar o RecuperarNFe?"
!insertmacro MUI_PAGE_FINISH

# desinstalador
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "PortugueseBR"

VIAddVersionKey /LANG=${LANG_PortugueseBR} "ProductName" "RecuperarNFe"
VIAddVersionKey /LANG=${LANG_PortugueseBR} "Comments" "Recuperar arquivos XML da NF-e"
VIAddVersionKey /LANG=${LANG_PortugueseBR} "CompanyName" "RecuperarNFe"
VIAddVersionKey /LANG=${LANG_PortugueseBR} "LegalTrademarks" "RecuperarNFe"
VIAddVersionKey /LANG=${LANG_PortugueseBR} "LegalCopyright" "© RecuperarNFe"
VIAddVersionKey /LANG=${LANG_PortugueseBR} "FileDescription" "Instalador RecuperarNFe"
VIAddVersionKey /LANG=${LANG_PortugueseBR} "InternalName" "RecuperarNFe"
VIAddVersionKey /LANG=${LANG_PortugueseBR} "FileVersion" "1.0.0"
VIProductVersion "1.0.0.0"

Function ".onInit"
    System::Call 'kernel32::CreateMutexA(i 0, i 0, t "myMutex") i .r1 ?e'
    Pop $R0
    StrCmp $R0 0 +3
    MessageBox MB_OK|MB_ICONEXCLAMATION "Este instalador já está sendo executado neste computador!"
    Abort
FunctionEnd

Section "Instalar" SecInstalar

    SetDetailsPrint none
    SetOutPath "$SYSDIR"

    ${If} ${FileExists} "$SYSDIR\ssleay32.dll"
    ${Else}
        File '..\dll\ssleay32.dll'
    ${EndIf} 

    ${If} ${FileExists} "$SYSDIR\libeay32.dll"
    ${Else}
        File '..\dll\libeay32.dll'
    ${EndIf} 

    ${If} ${FileExists} "$SYSDIR\MSXML5.DLL"
    ${Else}
        File '..\dll\MSXML5.DLL'
    ${EndIf} 

    ${If} ${FileExists} "$SYSDIR\MSXML5R.DLL"
    ${Else}
        File '..\dll\MSXML5R.DLL'
    ${EndIf}

    ${If} ${FileExists} "$SYSDIR\libxml2.dll"
    ${Else}
        File '..\dll\libxml2.dll'
    ${EndIf}

    ${If} ${FileExists} "$SYSDIR\zlib1.dll"
    ${Else}
        File '..\dll\zlib1.dll'
    ${EndIf}

    ${If} ${FileExists} "$SYSDIR\libxslt.dll"
    ${Else}
        File '..\dll\libxslt.dll'
    ${EndIf}

    ${If} ${FileExists} "$SYSDIR\libxmlsec.dll"
    ${Else}
        File '..\dll\libxmlsec.dll'
    ${EndIf}

    ${If} ${FileExists} "$SYSDIR\iconv.dll"
    ${Else}
        File '..\dll\iconv.dll'
    ${EndIf}

    ${If} ${RunningX64}  

    				${If} ${FileExists} "$SYSDIR\ssleay32.dll"
        ${Else}
            File '..\dll\ssleay32.dll'
        ${EndIf} 

        ${If} ${FileExists} "$SYSDIR\libeay32.dll"
        ${Else}
            File '..\dll\libeay32.dll'
        ${EndIf} 

        ${If} ${FileExists} "$SYSDIR\MSXML5.DLL"
        ${Else}
            File '..\dll\MSXML5.DLL'
        ${EndIf} 

        ${If} ${FileExists} "$SYSDIR\MSXML5R.DLL"
        ${Else}
            File '..\dll\MSXML5R.DLL'
        ${EndIf} 

        ${If} ${FileExists} "$SYSDIR\libxml2.dll"
        ${Else}
            File '..\dll\libxml2.dll'
        ${EndIf}

        ${If} ${FileExists} "$SYSDIR\zlib1.dll"
        ${Else}
            File '..\dll\zlib1.dll'
        ${EndIf}

        ${If} ${FileExists} "$SYSDIR\libxslt.dll"
        ${Else}
            File '..\dll\libxslt.dll'
        ${EndIf}

        ${If} ${FileExists} "$SYSDIR\libxmlsec.dll"
        ${Else}
            File '..\dll\libxmlsec.dll'
        ${EndIf}

        ${If} ${FileExists} "$SYSDIR\iconv.dll"
        ${Else}
            File '..\dll\iconv.dll'
        ${EndIf}
    ${endif}

				ExecWait 'regsvr32.exe "$INSTDIR\ssleay32.dll" /s'
				ExecWait 'regsvr32.exe "$INSTDIR\libeay32.dll" /s'
				ExecWait 'regsvr32.exe "$INSTDIR\msxml5.dll" /s'
				ExecWait 'regsvr32.exe "$INSTDIR\msxml5r.dll" /s'

    SetOutPath $INSTDIR
    File "..\Bin\RecuperarNFe.exe"

    # Icone no Painel de Controle
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\RecuperarNFe" "DisplayIcon" "$INSTDIR\RecuperarNFe.exe,0"
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\RecuperarNFe" "DisplayName" "RecuperarNFe"
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\RecuperarNFe" "DisplayVersion" "1.0.0"
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\RecuperarNFe" "HelpLink" "https://github.com/recuperarxml/recuperarnfe"
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\RecuperarNFe" "Publisher" "RecuperarNFe"
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\RecuperarNFe" "UninstallString" "$INSTDIR\DesinstaladorRecuperarNFe.exe"
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\RecuperarNFe" "URLInfoAbout" "https://github.com/recuperarxml/recuperarnfe"

    SetOutPath $INSTDIR

    # Desktop
    CreateShortCut "$DESKTOP\RecuperarNFe.lnk" "$INSTDIR\RecuperarNFe.exe"

    # Menus
    CreateDirectory "$SMPROGRAMS\RecuperarNFe"
    CreateShortCut "$SMPROGRAMS\RecuperarNFe\RecuperarNFe.lnk" "$INSTDIR\RecuperarNFe.exe"

    WriteUninstaller "$INSTDIR\DesinstaladorRecuperarNFe.exe"

    CreateShortCut "$SMPROGRAMS\RecuperarNFe\Desinstalar.lnk" "$INSTDIR\DesinstaladorRecuperarNFe.exe"

SectionEnd

Section "un.Uninstall"	
    Delete "$DESKTOP\RecuperarNFe.lnk"
    Delete "$SMPROGRAMS\RecuperarNFe\*.*"
    RMDir  "$SMPROGRAMS\RecuperarNFe"

    Delete "$INSTDIR\RecuperarNFe.exe"
    Delete "$INSTDIR\DesinstaladorRecuperarNFe.exe"
    RMDir "$INSTDIR"

SectionEnd
