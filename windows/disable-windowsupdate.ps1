Write-Host "Disable Windows Update"
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoUpdate" -Value 1 -Type DWord
Write-Host "Disable Windows Update service"
Set-Service -Name wuauserv -StartupType Disabled
Write-Host "Stop Windows Update service"
Stop-Service -Name wuauserv -Force
