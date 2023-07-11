rem cmd
PowerShell.exe -ExecutionPolicy Unrestricted -File "C:\cloudagent_windows\domainjoin.ps1"
del "C:\cloudagent_windows\domainjoin.ps1"
del "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\cloudbase-init.conf"
shutdown -r -t 00
exit 1002