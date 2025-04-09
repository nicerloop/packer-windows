Write-Host 'Get the VirtualBox Guest Additions ISO Volume'
$volume = Get-Volume | where FileSystemLabel -match 'VBox_GAs.*'

Write-Host 'Install the VirtualBox provided certificates to the trusted publisher store'
$certdir = $volume.DriveLetter + ':\cert\'
$VBoxCertUtil = $certdir + 'VBoxCertUtil.exe'
Get-ChildItem $certdir *.cer | ForEach-Object { & $VBoxCertUtil add-trusted-publisher $_.FullName --root $_.FullName}

Write-Host 'Install the VirtualBox Guest Additions'
$exe = $volume.DriveLetter + ':\VBoxWindowsAdditions.exe'
$parameters = '/S'
Start-Process $exe $parameters -Wait
