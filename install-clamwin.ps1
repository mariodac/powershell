


# link instaladores clamwin https://sourceforge.net/projects/clamwin/files/clamwin/

$URL="https://sourceforge.net/projects/clamwin/files/clamwin/0.103.2.1/clamwin-0.103.2.1-setup.exe"
$PATH="C:\Users\$Env:USERNAME\SETUP_CLAM.exe"
(New-Object System.Net.WebClient).DownloadFile($URL, $PATH)
Set-Location "C:\Users\$Env:USERNAME"
.\SETUP_CLAM.exe sp- /silent /norestart /NOTB