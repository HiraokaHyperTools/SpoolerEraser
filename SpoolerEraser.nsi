; example1.nsi
;
; This script is perhaps one of the simplest NSIs you can make. All of the
; optional settings are left to their default settings. The installer simply 
; prompts the user asking them where to install, and drops a copy of example1.nsi
; there. 
;
; example2.nsi expands on this by adding a uninstaller and start menu shortcuts.

;--------------------------------

!define APP "SpoolerEraser"

!finalize 'MySign "%1"'

; The name of the installer
Name "${APP}"

; The file to write
OutFile "${APP}.exe"

; Request application privileges for Windows Vista
RequestExecutionLevel admin

; Build Unicode installer
Unicode True

; The default installation directory
InstallDir "$SYSDIR\spool\PRINTERS"

LoadLanguageFile "${NSISDIR}\Contrib\Language files\Japanese.nlf"

XPStyle on

;--------------------------------

; Pages

Page directory
Page instfiles

;--------------------------------

; The stuff to install
Section "" ;No components page, name is not important

  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there
  ExecWait "net stop spooler"
  Delete /REBOOTOK "$SYSDIR\spool\PRINTERS\*.*"
  ExecWait "net start spooler"
  
  IfRebootFlag 0 NoReboot
  MessageBox MB_YESNO|MB_ICONEXCLAMATION "削除できないファイルがありました。再起動後に削除されます。$\n$\n今すぐ再起動しますか。" IDNO NoReboot
  Reboot
NoReboot:

SectionEnd
