$url = Read-Host "Please enter URL to exe"
# $url = "https://gamedownloads.rockstargames.com/public/installer/Rockstar-Games-Launcher.exe"
# $output = "$PSScriptRoot\install.exe"
$output = "$Env:temp\install.exe"
$start_time = Get-Date

Invoke-WebRequest -Uri $url -OutFile $output

Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

Invoke-Item $output
