# Verifica se está rodando como administrador
if (-not ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {

    Start-Process pwsh `
        -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" `
        -Verb RunAs

    exit
}

# =========================
# RESTART REDE
# =========================

Get-NetAdapter |
Where-Object { $_.Status -ne "Disabled" } |
ForEach-Object {
    Disable-NetAdapter -Name $_.Name -Confirm:$false
    Start-Sleep -Seconds 3
    Enable-NetAdapter -Name $_.Name -Confirm:$false
}
