Write-Host 'Install the OpenSSH Server'
Get-PSDrive -PSProvider FileSystem | ForEach-Object {
    $Path=Join-Path $_.Root 'LanguagesAndOptionalFeatures'
    if (Test-Path -PathType Container -Path $Path) {
        Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0 -LimitAccess -Source $Path
    }
}
Get-WindowsCapability -Online | Where-Object Name -like "OpenSSH.Server*" | ForEach-Object {
    if ($_.State -ne 'Installed') {
        Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
    }
}

Write-Host 'Start the sshd service'
Start-Service 'sshd'

Write-Host 'Set sshd service to start automatically'
Set-Service -Name 'sshd' -StartupType 'Automatic'

Write-Host 'Set the network in the private category'
Set-NetConnectionProfile -NetworkCategory 'Private'
