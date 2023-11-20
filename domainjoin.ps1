#Variable Section
$ver = "v1"
$Logfile = "C:\temp\DomainJoin-$ver.log"
$name = hostname

Function Logwrite
{
    Param([string]$logstring)
    $datentime = Get-Date -Format g
    $logstring = "$datentime" + ":" + "$logstring"
    Add-Content $Logfile -Value $logstring
}

$User = "testuser"
$PWord = ConvertTo-SecureString -String "Password@12345!" -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord
$ComputerOU = "OU=SecureDesktop,DC=VDI,DC=local"

# Joining to Domain ,Capturing error message and retries after 5sec
Logwrite "Computer Name is $name"
Logwrite " Joining the Computer to the OU $ComputerOU"
do {
     $joined = $true
     try { 
            Add-Computer -ComputerName $name -DomainName "vdi.local" -OUPath $ComputerOU -Credential $cred -ErrorAction Stop
        }
    catch {
    $joined = $false
    Write-Output $_.Exception.Message
    Logwrite $_.Exception.Message
    Start-Sleep -Seconds 5
    }
} until ($joined)

# Editing Cloudbase init Config file
function editcloubaseinit {
    param (
      [String]$Name
    )
    $data = foreach($line in Get-Content "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\cloudbase-init.conf")
  {
    if($line -like "*$Name*" )
    {
    }
    else
    {
     $line
    }
  }
  $data |Set-Content "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\cloudbase-init.conf" -Force
  }
  Logwrite "Updating Cloudinit Configuration"
  editcloubaseinit -Name metadata
  editcloubaseinit -Name plugins
  editcloubaseinit -Name local_scripts_path

