# Installeert AD DS
Install-windowsfeature AD-domain-services

# Importeert de module ADDSDeployment 
Import-Module ADDSDeployment

$domainname = "Project3.be"
$netbiosName = "PROJECT3"

# Promoveert de server tot DC
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
