# Deploying and Managing Active Directory with Windows PowerShell
###Notities door Andy Nelis

## Deploy your first forest and domain

###Configureer het ip address van de server

**Geef de adapter alias en index weer.**

```
Get-NetAdapter | Get-Member
```

####Configureer een statisch ip address

Om een statisch ip address te gebruiken moeten we eerst DHCP uitzetten. Dan pas kunnen we de ipv4 en ipv6 adressen toekennen. In dit voorbeeld gebruiken we 192.168.10.0/24 als het ipv4 subnet, en 2001:db8:0:10::/64 als ipv6 subnet.

**Om DHCP uit te schakellen op netwerkadapter 10, gebruik we het volgende commando.**

```
Set-NetIPInterface -InterfaceAlias "10 Network" -DHCP Disabled -PassThru
```

Door de -PassThru parameter mee te geven geeft powershell een status terug van de ip interface. Standaard wordt die niet weer gegeven dus weten we ook niet of de aanpassing succesvol was.

**Nu kunenn we het ipv4 address 192.168.10.2 instellen met het volgende commando.**

```
New-NetIPAddress -AddressFamily IPv4 -InterfaceAlias "10 Network" -IPAddress 192.168.10.2 -PrefixLength 24 -DefaultGateway 192.168.10.1
```
     
**Nu kunenn we het ipv6 address 2001:db8:0:10::2 instellen met het volgende commando.**

```
New-NetIPAddress -AddressFamily IPv6 -InterfaceAlias "10 Network" -IPAddress 2001:db8:0:10::2 -PrefixLength 64 -DefaultGateway 2001:db8:0:10::1
```
**Stel het DNS ip address in met volgend commando**

```
Set-DnsClientServerAddress -InterfaceAlias "10 Network" -ServerAddresses 192.168.10.2,2001:db8:0:10::2
```

**Bekijk de veranderingen aan network adapter 10.**

```
Get-NetIPAddress -InterfaceAlias "10 Network
```

**Pas de servernaam aan.**

```
Rename-Computer -NewName servernaam -Restart -Force -PassThru
```

###Installeer Active Directory Domain Services

Voor we de server tot domein controller kunnen promoten moeten we de Active Directory Domain Services role op de server installeren. Het volgende commando zal de AD DS role installeren, inclusief the management tools.

```
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
```
###Maak het forest aan (dcpromo)

####Update Windows PowerShell help

Voor je verder gaat is het best dat je de help files van Powershell update. De files worden namenlijk regelmatig aangepast.

Om de files te updaten heb je administrator rechten nodig. Gebruik het volgende commando om de help files up te daten.

```
Update-Help
```

####Test de serveromgeving 

Voor je het forest aanmaakt, test je best of je serveromgeving aan de eisen van een forest voldoet. het volgende script test dit. Sla dit script op als 'Test-myForestCreate.ps1'.

```
Import-Module ADDSDeployment 
Test-ADDSForestInstallation `
     -DomainName 'TreyResearch.net' `
     -DomainNetBiosName 'TREYRESEARCH' `
     -DomainMode 6 `
     -ForestMode 6 `
     -NoDnsOnNetwork `
     -NoRebootOnCompletion
```
Voer het script dan uit in powershell met volgend commando.

```
Test-myForestCreate.ps1
```
Bekijk de uitvoer en zo nodig de waarschuwingen die het script geeft.

####maak het eerste domein en forest aan

Nu staat alles klaar om het forrest aan te maken. Het commando om het forrest aan te maken is heel gelijkend op het testscript dat we net uitgevoerd hebben. Het commando is als volgt.

```
Install-ADDSForest `
     -DomainName 'domeinnaam.net' `
     -DomainNetBiosName 'DOMEINNAAM' `
     -DomainMode 6 `
     -ForestMode 6 `
     -NoDnsOnNetwork `
     -SkipPreChecks `
     -Force
```

Het `-Force` commando zorgt er voor dat tijdens het aanmaken van het forrest geen confirmatie prompts tevoorschijn komen. Desalniettemin zal je toch een prompt krijgen om het Directory Services Restore Mode (DSRM) password in te geven. Bij het aanmaken van veel verschillende forests is dit niet zo interessant en kunnen we deze prompt ook vermijden door de DSMR al mee te geven. Dit doen we met volgend stukje code.

```
$pwdSS = ConvertTo-SecureString -String 'P@ssw0rd!' -AsPlainText -Force
```
De waarde van parameters `DomainmMode` en `ForestMode` kunnen we met volgende tabel verklaren. 

| Functional level        | Nummer        | String   |
| -------------           |:-------------:| -----:   |
| Windows Server 2003     | 2             | win2003  |
| Windows Server 2008     | 3             | win2008  |
| Windows Server 2008 R2  | 4             | win2008R2|
| Windows Server 2012     | 5             | win2012  |
| Windows Server 2012 R2  | 6             | win2012R2|

Het forest en domein hebben dus als functional level Windows Server 2012 R2.

**Informatie bekijken domein en forest**

Na het aanmaken van het domein en de forest kan je met volgend script de Forest Mode, Domain Mode, en Schema Version bekijken. Sla het script op als Get-myADVersion.ps1. Het script staat ook in het script mapje op github.

```
<#
.Synopsis
Get the current Schema version and Forest and Domain Modes
.Description
The Get-myADVersion script queries the AD to discover the current AD schema version,
and the forest mode and domain mode. If run without parameters, it will query the
current AD context, or if a Domain Controller is specified, it will query against
that DC's context. Must be run as a user with sufficient privileges to query AD DS.
.Example
Get-myADVersion
Queries against the current AD context.
.Example
Get-myADVersion -DomainController Trey-DC-02
Gets the AD versions for the Domain Controller "Trey-DC-02"
.Parameter DomainController
Specifies the domain controller to query. This will change the response to match
the AD context of the DC.
.Inputs
[string]
.Notes
    Author: Charlie Russel
 Copyright: 2015 by Charlie Russel
          : Permission to use is granted but attribution is appreciated
   Initial: 3/7/2015 (cpr)
   ModHist:
          :
#>
[CmdletBinding()]
Param(
     [Parameter(Mandatory=$False,Position=0)]
     [string]
     $DomainController
     )

if ($DomainController) {
   $AD = Get-ADRootDSE -Server $DomainController
   Get-ADObject $AD.SchemaNamingContext -Server $DomainController `
                                        -Property ObjectVersion
} else {
   $AD = Get-ADRootDSE
   Get-ADObject $AD.SchemaNamingContext -Property ObjectVersion
}
$Forest = $AD.ForestFunctionality
$Domain = $AD.DomainFunctionality

# Use a Here-String to print out the result.
$VersionCodes = @"

Forest: $Forest
Domain: $Domain


Where the Schema version is:
72 = Windows Server Technical Preview Build 9841
69 = Windows Server 2012 R2
56 = Windows Server 2012
47 = Windows Server 2008 R2
44 = Windows Server 2008
31 = Windows Server 2003 R2
30 = Windows Server 2003
13 = Windows 2000
"@
$VersionCodes
```
Als je het script wilt uitvoeren in Powershell geef je het volgende commando in.

```
Get-myADVersion
```
## Beheer DNS en DHCP

Het is onmogelijk een AD DS te draaien zonder het gebruik van een DNS. 
In het volgende hoofdstuk ga ik dieper in over hoe een DNS tot stand wordt gebracht met Powershell.

### Nieuwe primary forward lookup zone aanmaken
Voor het aanmaken van een nieuwe primary zone gebruiken we het Add-DnsServerPrimaryZone cmdlet. Vervang bij `Name` en `ComputerName` de waarden die van toepassing zijn.
 
```
Add-DnsServerPrimaryZone -Name 'dnsnaam.com' `
                         -ComputerName 'computernaam.treyresearch.net' `
                         -ReplicationScope 'Domain' `
                         -DynamicUpdate 'Secure' `
                         -PassThru
                         
```
### Nieuwe reverse lookup zone aanmaken
Een reverse lookup zone aanmaken is heel gelijkend op het aanmaken van een forward lookup zone. Het enige verschil is dat we idpv parameter `ComputerName` we `NetworkID` gebruiken. We maken ook weer gebruik van het `DnsServerPrimaryZone`.

Pas de `NetworkID` aan naar de waarde die van toepassing is.

***Reverse lookup zone met ipv4***

```
Add-DnsServerPrimaryZone -NetworkID 192.168.10.0/24 `
                         -ReplicationScope 'Forest' `
                         -DynamicUpdate 'NonsecureAndSecure' `
                         -PassThru
```
***Reverse lookup zone met ipv6***

```
Add-DnsServerPrimaryZone -NetworkID 2001:db8:0:10::/64 `
                         -ReplicationScope 'Forest' `
                         -DynamicUpdate 'Secure' `
```
### Lookup zone aanpassen

```
Set-DnsServerPrimaryZone -Name 'TailspinToys.com' `
                         -Notify 'NotifyServers' `
                         -NotifyServers "192.168.10.201","192.168.10.202" `
                         -PassThru
```
### Primary lookup zone exporteren
Het is handig wanneer je een primary DNS zone als file hebt voor disaster recovery of voor gebruik in testomgevingen. Om dit te doen hanteren we de `Export-DnsServerZone` cmdlet.

***Ipv4 DNS zone exporteren***

***Ipv6 DNS zone exporteren***

```
Export-DnsServerZone -Name '0.1.0.0.0.0.0.0.8.b.d.0.1.0.0.2.ip6.arpa' `
                     -Filename '0.1.0.0.0.0.0.0.8.b.d 0.1.0.0.2.ip6.arpa.dns'
```
De file wordt opgeslagen in de  `%windir%\system32\dns` directory. Het bestand bevat alle informatie om de DNS zone te reacreëren.

### Beheer secondary zones

Secondary DNS zones are primarily used for providing distributed DNS resolution when you are using traditional file-based DNS zones. Secondary DNS zones are used for both forward lookup and reverse lookup zones. Een secondary DNS zone is read-only. 

***Secondary zone aanmaken aan de hand van geëxporteerde file***
Om een secondary zone aan te maken gebruiken we het cmdlet `Add-DnsServerSecondaryZone`. In dit voorbeeld gebruiken we het geëxporteerd bestand in de `%windir%\system32\dns` directory. 

```
Add-DnsServerSecondaryZone –Name 0.1.0.0.0.0.0.0.8.b.d.0.1.0.0.2.ip6.arpa `
                           -ZoneFile "0.1.0.0.0.0.0.0.8.b.d.0.1.0.0.2.ip6.arpa.dns" `
                           -LoadExisting `
                           -MasterServers 192.168.10.2,2001:db8:0:10::2 `
                           -PassThru
```
***Secondary zone aanpassen***
Hierbij gebruiken we het `Set-DnsServerSecondaryZone`  cmdlet.

```
Set-DnsServerSecondaryZone -Name 0.1.0.0.0.0.0.0.8.b.d.0.1.0.0.2.ip6.arpa `
                           -MasterServers 192.168.10.3,2001:db8:0:10::3 `
                           -PassThru
```

###Stub zones
Stub DNS zones houden enkel de nodige records bij om een namesever te lokaliseren van van een zone. 
Hun functie is om bij te houden welke servers  gemachtigd zijn om een child zone te betreden, zonder volledige records bij te houden van die child zone. Stub zones kunnen voor zowel forward als reverse lookup zones gebruikt worden.

Stub zones worden vaak gebruikt bij secondary zones. Secondary zones houden namelijk alle records bij van een zone waardoor aan indringeer in het bezit kan geraken van deze belangrijke informatie. Door het gebruik van Stub Zone heeft een potentiële indringer enkel toegang tot ip adressen en de namen van hun DNS servers.

***Stub Zone aanmaken***
Om een Stub zone aan te maken gebruiker we het `Add-DnsServerStubZone` cmdlet. Als voorbeeld heeft de master server ip 192.168.10.4.

```
Add-DnsServerStubZone -Name TailspinToys.com `
                      -MasterServers 192.168.10.4 `
                      -ReplicationScope Domain `
                      -PassThru
```
***Stub Zone aanpassen***
Om een Stub Zone aan te passen gebruiken we het `Set-DnsServerStubZone` cmdlet. 

```
Set-DnsServerStubZone -Name TailspinToys.com `
                      -LocalMasters 192.168.10.201,192.168.10.202 `
                      -PassThru
```

###Conditional forwards configureren
Conditional forwards worden gebruikt om DNS request te forwarden naar specifieke DNS domeinen. 

Voorbeeld:<br>
Je hebt meerder interne DNS domeinen en 1 DNS krijgt een request dat niet voor hem bestemd is. De DNS gaat dan kijken in zijn cache of hij de bestemming van de request heeft. Als dit niet zo is gaat de DNS na of er een conditional forward is geconfigureerd voor de DNS request. Als dit het geval is zal de DNS de request forwarden naar de ingestelde conditional forward.

***Conditional forwarder aanmaken***
Als voorbeeld gaan we een conditional forward configureren voor TreyResearch.net. We gebruiken het `Add-DnsServerConditionalForwarderZone` cmdlet.

```
Add-DnsServerConditionalForwarderZone -Name treyresearch.net `
                                      -MasterServers 192.168.10.2,2001:db8::10:2 `
                                      -ForwarderTimeout 5 `
                                      -ReplicationScope "Forest" `
                                      -Recursion $False `
                                      -PassThru
```