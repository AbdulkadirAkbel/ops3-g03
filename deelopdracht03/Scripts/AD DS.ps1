Install-windowsfeature AD-domain-services
Import-Module ADDSDeployment
$domainname = "Projecten3.be"
$netbiosName = "PROJECTEN3"
Install-ADDSForest -CreateDnsDelegation:$false `
    -DatabasePath "C:\Windows\NTDS" `
    -DomainMode "Win2012R2" `
    -DomainName $domainname `
    -DomainNetbiosName $netbiosName `
    -ForestMode "Win2012R2" `
    -InstallDns:$true `
    -LogPath "C:\Windows\NTDS" `
    -NoRebootOnCompletion:$false `
    -SysvolPath "C:\Windows\SYSVOL" `
    -Force:$true
