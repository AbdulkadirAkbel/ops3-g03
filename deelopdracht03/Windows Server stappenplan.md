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
8.	Maak een wachtwoord aan voor de Administrator. (wachtwoord = “Project3”)
9.	Log in.

**Guest Additions installeren voor copy/paste:**

1. Klik op de menubalk van de virtuele machien op *Apparaten* en dan op *Invoegen Guest Additions CD-image*.
2. Open powershell met de commando `powershell`.
3. `Get-Volume`
4. `cd E:\`
5. `ls`
6. `start VBoxWindowsAdditions.exe`

### Basisinstellingen configureren

1. Toon de interfaces: `Get-NetIPInterface`. Ethernet 2 (=host-only) heeft als interfaceindex 25.
2. IP adres toewijzen: `New-NetIPAddress -AddressFamily IPv4 -IPAddress 192.168.101.11 -PrefixLength 24 -ifIndex 25`
3. DNS server instellen: `Set-DnsClientServerAddress -InterfaceIndex 25 -ServerAddresses "127.0.0.1"`
4. Valideer aan de hand van `ipconfig /all`
5. Bekijk computernaam met `Get-WmiObject Win32_ComputerSystem`
6. Verander computernaam naar "Projecten3": `Rename-Computer -NewName Projecten3`

Je kan ook gebruik maken van het script `Set-IP.ps1`.

### Active Directory

Voer onderstaande script uit op de server voor de installatie van AD en DNS <br/>
https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht03/Scripts/AD%20DS.ps1

### DNS 
 
Het script van AD DS heeft DNS al geïnstalleerd en een forward lookup zone aangemaakt. Nu moeten we enkel nog een reverse lookup zone aanmaken. Gebruik hiervoor het volgende script: <br/>
https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht03/Scripts/DNS%20ZONE.ps1

### DHCP

https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht03/Scripts/DHCP.ps1

### OU's en gebruikers

Hiervoor hebben we het script van vorig jaar bij Projecten 2 gebruikt. Het standaad wachtwoord voor elke gebruiker is `Project3`. Dit wachtwoord moet opnieuw ingesteld worden als een gebruiker voor de eerste keer inlogd. Voor testdoeleinden geven we bij elke gebruiker die zijn wachtwoord opnieuw moet instellen volgend wachtwoord mee: `Projecten3`.

Script: https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht03/Scripts/OU's%20en%20gebruikers.ps1 <br/>
CSV bestand met gebruikers: https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht03/werknemers.csv <br/>
Logon script: https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht03/logon.vbs

### Shares

We hebben een script geschreven dat alle shares aanmaakt en de juist gebruikers rechten geeft op de juist shares. Het script kan je vinden in op volgende link:

https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht03/Scripts/shares.ps1

### Webserver

We hebben ook een script geschreven dat IIS installeerd en een simpele webpagina aanmaakt. Het script kan gevonden worden op volgende link:

https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht03/Scripts/Webserver.ps1


Bronnen: 

* http://www.thegeekstuff.com/2014/12/install-windows-ad/
* https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht02/Boek%20Powershell/AD%20DS.md
* https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht02/Boek%20Powershell/DNS.md
* http://superuser.com/questions/499264/how-can-i-mount-an-iso-via-powershell-programmatically





