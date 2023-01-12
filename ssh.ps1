
$ssh_client = (Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.Client*' | Where-Object State -like "NotPresent").Count
$ssh_server = (Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.Server*' | Where-Object State -like "NotPresent").Count
if ($ssh_client -gt 0 )
{
	#$ssh_client
	Write-Output "SSH Client NotPresent. Installing ..."
	# Install the OpenSSH Client
	Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

}
if ($ssh_server -gt 0)
{
	#$ssh_server
	Write-Output "SSH Server NotPresent. Installing ..."
	# Install the OpenSSH Server
	Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
}

# Start the sshd service
Start-Service sshd

# OPTIONAL but recommended:
Set-Service -Name sshd -StartupType 'Automatic'

# Confirm the Firewall rule is configured. It should be created automatically by setup. Run the following to verify
if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP' does not exist, creating it..."
    New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
} else {
    Write-Output "Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists."
}