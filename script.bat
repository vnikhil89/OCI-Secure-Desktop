rem cmd
timeout 15
PowerShell.exe -ExecutionPolicy Unrestricted -File "C:\temp\domainjoin.ps1"
del "C:\temp\domainjoin.ps1"
shutdown -r -t 00
exit 1002