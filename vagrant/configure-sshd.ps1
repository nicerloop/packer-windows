Write-Host 'Configure user key'
New-Item -Force -ItemType 'Directory' -Path "$Env:USERPROFILE\.ssh"
$VagrantPub = @"
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN1YdxBpNlzxDqfJyw/QKow1F+wvG9hXGoqiysfJOn5Y vagrant insecure public key
"@
Set-Content -Path "$Env:USERPROFILE\.ssh\authorized_keys" -Value $VagrantPub

Write-Host 'Configure sshd to allow standard key location for all users'
$sshd_config = "$Env:ProgramData\ssh\sshd_config"
(Get-Content $sshd_config).Replace('Match Group administrators', '# Match Group administrators') | Set-Content $sshd_config
(Get-Content $sshd_config).Replace('AuthorizedKeysFile', '# AuthorizedKeysFile') | Set-Content $sshd_config
