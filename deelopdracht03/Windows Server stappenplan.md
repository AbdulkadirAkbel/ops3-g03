## Stappenplan Windows Server

### VM

1.	Maak een nieuwe virtuele machine aan met een naam naar keuze, als type Microsoft Windows en versie Windows 2012 (64-bit).
2.	RAM: 2048 MB
3.	Kies om een nieuwe virtuele harde schrijf aan te maken.
4.	Kies als bestandstype van de harde schijf VDI (VirtualBox Disk Image).
5.	Opslag fysieke schijf: Dynamisch gealloceerd
6.	Kies locatie en grootte virtuele schijf: 25 GB en klik op aanmaken.

### Windows Server 2012 R2

1.	Voeg het iso-bestand toe aan de Opslag Controller: IDE.
2.	Start de virtuele machine.
3.	Kies taal, indeling voor tijd en valuta, toetsenbord.
4.	Voer de productcode in om Windows te activeren.
5.	Kies voor een server met een core.
6.	Kies voor een aangepaste installatie.
7.	Selecteer de gewenste harde schijf.
8.	Maak een wachtwoord aan voor de Administrator. (wachtwoord = “Projecten3”)
9.	Log in.

### Basisinstellingen configureren

1. Toon de interfaces: `Get-NetIPInterface`. Ethernet 2 (=host-only) heeft als interfaceindex 25.
2. IP adres toewijzen: `New-NetIPAddress -AddressFamily IPv4 -IPAddress 192.168.101.11 -PrefixLength 24 -ifIndex 25`
3. DNS server instellen: `Set-DnsClientServerAddress -InterfaceIndex 25 -ServerAddresses "127.0.0.1"`
4. Valideer aan de hand van `ipconfig /all`
5. Bekijk computernaam met `Get-WmiObject Win32_ComputerSystem`
6. Verander computernaam naar "Projecten3": `Rename-Computer -NewName Projecten3`


### Active Directory en DNS

1. De exacte naam bekijken van de Active Directory service `Get-WindowsFeature *ad*` (AD-Domain-Services)
2. Installeren `Install-windowsfeature AD-domain-services`
3. De module ADDSDeployment importeren: `Import-Module ADDSDeployment`
4. De server promoveren naar Domain Controller met volgende parameters: 

    	$domainname = "Projecten3.be"
    	$netbiosName = PROJECTEN3
    	Install-ADDSForest 
    	-CreateDnsDelegation:$false `
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

5. 



Bronnen:

* http://www.thegeekstuff.com/2014/12/install-windows-ad/
* 







