$name = hostname
$User = "XXXXXXX\administrator"
$PWord = ConvertTo-SecureString -String "XXXXXXX" -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord
Add-Computer -ComputerName $name -DomainName "horizonvdi.local" -Credential $cred
function test {
    param (
      [String]$Name
    )
    $data = foreach($line in Get-Content “/Users/niks/Documents/cloudbase/cloudbase-init.conf”)
  {
    if($line -like "*$Name*" )
    {
    }
    else
    {
     $line
    }
  }
  $data |Set-Content “/Users/niks/Documents/cloudbase/cloudbase-init.conf” -Force
  }
  test -Name metadata
  test -Name plugins
