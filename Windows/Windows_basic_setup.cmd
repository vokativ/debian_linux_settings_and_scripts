REM Install chocolatey first.
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

REM Read modified environment variables
RefreshEnv

REM Install original packages...

REM Chocolatey updates
choco install -y chocolatey-core.extension
choco install -y chocolatey-dotnetfx.extension
choco install -y chocolatey-misc-helpers.extension
choco install -y chocolatey-windowsupdate.extension
choco install -y chocolateygui
choco install -y chocolatey-windowsupdate.extension

REM Some tools...
choco install -y 7zip.install
choco install -y f.lux
choco install -y foxitreader
choco install -y googledrive
choco install -y notepadplusplus.install
choco install -y paint.net
choco install -y skype
choco install -y treesizefree
choco install -y adobeair
choco install -y 1password


REM Multimedia and games...
choco install -y vlc
choco install -y k-litecodecpackfull
choco install youtube-dl
choco install -y steam
choco install -y calibre
choco install -y steam-cleaner

REM an Office suite
choco install -y libreoffice-fresh


REM Essential fonts ;-)
choco install -y dejavufonts
choco install -y FiraCode
choco install -y hackfont
choco install -y inconsolata
choco install -y RobotoFonts

REM More web browsers...
choco install -y GoogleChrome
choco install -y chromium
choco install -y microsoft-edge

REM Backend stuff...
choco install -y dotnetfx
choco install -y vcredist140
choco install -y sysinternals
choco install -y silverlight
choco install -y teamviewer
choco install -y dotnet4.5
choco install -y nssm
choco install -y teracopy
choco install -y bulk-crap-uninstaller
choco install -y powertoys
choco install -y adwcleaner
choco install -y cpu-z.install
choco install -y putty.install
choco install -y revo-uninstaller
choco install -y rufus
