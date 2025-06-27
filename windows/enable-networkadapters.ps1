Write-Host "Enable network adapters"
Get-NetAdapter | Enable-NetAdapter -Confirm:$false
