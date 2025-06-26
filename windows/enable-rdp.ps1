Write-Host 'Enable Remote Desktop'
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name 'fDenyTSConnections' -Value 0
New-NetFirewallRule -DisplayName "Remote Desktop" -Direction Inbound -LocalPort 3389 -Protocol TCP -Action Allow
