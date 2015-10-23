# Installeert AD DS
Install-windowsfeature AD-domain-services

# Importeert de module ADDSDeployment 
Import-Module ADDSDeployment
<<<<<<< HEAD

$domainname = "Project3.be"
$netbiosName = "PROJECT3"

# Promoveert de server tot DC
=======
$domainname = "Projecten3.be"
$netbiosName = "PROJECTEN3"
>>>>>>> 03ed54deefa37aee5f1bbbf1489b3e000b0c7a5a
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
