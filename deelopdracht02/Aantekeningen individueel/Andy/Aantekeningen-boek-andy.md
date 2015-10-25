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

Voor je het forest aanmaakt, test je best of je serveromgeving aan de eisen van een forest voldoet. het volgende script test dit. Sla dit script op als 'Test-myForestCreate.ps1'. Het script staat ook in het mapje scripts op github.

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
##DNS 

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
Een reverse lookup zone aanmaken is heel gelijkend op het aanmaken van een forward lookup zone. Het enige verschil is dat we idpv parameter `ComputerName` we `NetworkID` gebruiken. We maken ook weer gebruik van het `DnsServerPrimaryZone` cmdlet.

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

***Secondary zone aanmaken aan de hand van geëxporteerde file***<br>
Om een secondary zone aan te maken gebruiken we het cmdlet `Add-DnsServerSecondaryZone`. In dit voorbeeld gebruiken we het geëxporteerd bestand in de `%windir%\system32\dns` directory. 

```
Add-DnsServerSecondaryZone –Name 0.1.0.0.0.0.0.0.8.b.d.0.1.0.0.2.ip6.arpa `
                           -ZoneFile "0.1.0.0.0.0.0.0.8.b.d.0.1.0.0.2.ip6.arpa.dns" `
                           -LoadExisting `
                           -MasterServers 192.168.10.2,2001:db8:0:10::2 `
                           -PassThru
```
***Secondary zone aanpassen***<br>
Hierbij gebruiken we het `Set-DnsServerSecondaryZone` cmdlet.

```
Set-DnsServerSecondaryZone -Name 0.1.0.0.0.0.0.0.8.b.d.0.1.0.0.2.ip6.arpa `
                           -MasterServers 192.168.10.3,2001:db8:0:10::3 `
                           -PassThru
```

###Stub zones
Stub DNS zones houden enkel de nodige records bij om een namesever te lokaliseren van van een zone. 
Hun functie is om bij te houden welke servers  gemachtigd zijn om een child zone te betreden, zonder volledige records bij te houden van die child zone. Stub zones kunnen voor zowel forward als reverse lookup zones gebruikt worden.

Stub zones worden vaak gebruikt bij secondary zones. Secondary zones houden namelijk alle records bij van een zone waardoor een indringer in het bezit kan geraken van deze belangrijke informatie. Door het gebruik van Stub Zone heeft een potentiële indringer enkel toegang tot ip adressen en de namen van hun DNS servers.

***Stub Zone aanmaken***<br>
Om een Stub zone aan te maken gebruiker we het `Add-DnsServerStubZone` cmdlet. Als voorbeeld heeft de master server ip 192.168.10.4.

```
Add-DnsServerStubZone -Name TailspinToys.com `
                      -MasterServers 192.168.10.4 `
                      -ReplicationScope Domain `
                      -PassThru
```
***Stub Zone aanpassen***<br>
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

***Conditional forwarder aanmaken***<br>
Als voorbeeld gaan we een conditional forward configureren voor TreyResearch.net. We gebruiken het `Add-DnsServerConditionalForwarderZone` cmdlet.

```
Add-DnsServerConditionalForwarderZone -Name treyresearch.net `
                                      -MasterServers 192.168.10.2,2001:db8::10:2 `
                                      -ForwarderTimeout 5 `
                                      -ReplicationScope "Forest" `
                                      -Recursion $False `
                                      -PassThru
```

***Conditional forwarder aanpassen***<br>
Om een conditional forwarder aan te passen gebruik je het `Add-DnsServerConditionalForwarderZone` cmdlet.

```
Add-DnsServerConditionalForwarderZone -Name treyresearch.net `
                                      -MasterServers 192.168.10.3,2001:db8::10:3 `
                                      -PassThru
```

###Beheer zone delegation
Zone delegation wordt gebruikt om grote zones te verdelen in kleinere subzones om de performantie te verhogen.

***Zone delagation aanmaken***<br>
Om een zone delegation aan te maken gebruiken we het `Add-DnsServerZoneDelegation` cmdlet.

```
Add-DnsServerZoneDelegation -Name TreyResearch.net `
                            -ChildZoneName Engineering `
                            -IPAddress 192.168.10.12,2001:db8:0:10::c `
                            -NameServer trey-engdc-12.engineering.treyresearch.net `
                            -PassThru
```

***Zone delagation aanpassen***                            
Om een zone delegation aan te passen gebruiken we het `Set-DnsServerZoneDelegation` cmdlet.                            
 
```
Set-DnsServerZoneDelegation -Name TreyResearch.net `
                            -ChildZoneName Engineering `
                            -IPAddress 192.168.10.13,2001:db8:0:10::d `
                            -NameServer trey-engdc-13.engineering.treyresearch.net `
                            -PassThru
```                            

###Beheer DNS records
Een DNS server doet veel meer dan enkel een servernaam vertalen naar een ip-adres. De DNS houd bijvoorbeeld informaitie bij die services zoals mail servers nodig hebben om de server van bestemming te vinden. Deze informatie wordt bijgehouden in records. Er zijn veel verschillende soorten records en daarom ga ik ze niet allemaal overlopen. Om ze op te vragen kan je het volgende help commando gebruiken.

```   
Get-Help Add-DnsServerResourceRecord* | ft -auto Name,Synopsis
```   

Als uitvoer krijg je dan:

``` 
Name                              Synopsis
----                              --------
Add-DnsServerResourceRecord       Adds a resource record of a specified type to...
Add-DnsServerResourceRecordA      Adds a type A resource record to a DNS zone.
Add-DnsServerResourceRecordAAAA   Adds a type AAAA resource record to a DNS server.
Add-DnsServerResourceRecordCName  Adds a type CNAME resource record to a DNS  zone.
Add-DnsServerResourceRecordDnsKey Adds a type DNSKEY resource record to a DNS zone.
Add-DnsServerResourceRecordDS     Adds a type DS resource record to a DNS zone.
Add-DnsServerResourceRecordMX     Adds an MX resource record to a DNS server.
Add-DnsServerResourceRecordPtr    Adds a type PTR resource record to a DNS server.

``` 

##DHCP

###DHCP intialiseren

***Role installeren***<br>
Om DHCP te kunnen gebruiken is een role nodig. Deze moet dus eerst geïnstalleerd worden.

``` 
Install-WindowsFeature -ComputerName trey-dns-03 `
                       -Name DHCP `
                       -IncludeAllSubFeature `
                       -IncludeManagementTools
```  

***User groups aanmaken***<br>
Eens de role geïnstalleerd is moeten er 2 lokale groepen aangemaakt worden op de DHCP server: DHCP Users en DHCP Administrators. We doen dit aan de hand van volgende commando's.

``` 
$connection = [ADSI]"WinNT://trey-dns-03"
$lGroup = $connection.Create("Group","DHCP Administrators")
$lGroup.SetInfo()
$lGroup = $connection.Create("Group","DHCP Users")
$lGroup.SetInfo()
``` 

***DHCP activeren in AD DS***<br>
De laatste stap die genomen moet worden voor de je de DHCP kan configureren is de DHCP te activeren in de AD DS als een geautoriseerde server. Dit doen we door gebruik te maken van het `Add-DhcpServerInDC` cmdlet. De `-DnsName` kan zowel met het ip adres als de DNS naam ingevuld worden.

``` 
Add-DhcpServerInDC -DnsName 'trey-dns-03' -PassThru
``` 

###DHCP configureren
Nu de role geïnstalleerd is en alles klaar gezet is kunnen we beginnen met het configureren van de DHCP server. 

***Ipv4 scope maken***<br>
Om een Ipv4 scope aan te maken gebruiken we het `Add-DhcpServerv4Scope` cmdlet.
Als voorbeeld maken we een scope aan van 200 ip adressen.

``` 
Add-DhcpServerv4Scope -Name "Trey-Default" `
                      -ComputerName "trey-dns-03" `
                      -Description "Default IPv4 Scope for Lab" `
                      -StartRange "192.168.10.1" `
                      -EndRange   "192.168.10.200" `
                      -SubNetMask "255.255.255.0" `
                      -State Active `
                      -Type DHCP `
                      -PassThru
``` 
Als het aanmaken van de scope goed verlopen is krijg je volgende uitvoer te zien.

``` 
ScopeId       SubnetMask    Name         State   StartRange    EndRange
LeaseDuration
-------       ----------    ----         -----   ----------    --------        ------
-------
192.168.10.0  255.255.255.0 Trey-Default Active  192.168.10.1  192.168.10.200
8.00:00:00
``` 
***Ipv4 exclusion range***<br>
Vervolgens maken we nu een exclusion range aan die we kunnen gebruiken voor servers op het netwerk die een statisch ip adres hebben. We maken in de voorbeeld een exclusion range aan voor 20 statische ip adressen. We gebruiken hiervoor het `Add-DhcpServerv4ExclusionRange` cmdlet.

``` 
Add-DhcpServerv4ExclusionRange -ScopeID "192.168.10.0" `
                               -ComputerName "trey-dns-03" `
                               -StartRange "192.168.10.1" `
                               -EndRange   "192.168.10.20" `
                               -PassThru
``` 
Als het aanmaken van de exclusion range goed verlopen is krijg je volgende uitvoer te zien.

```
ScopeId              StartRange           EndRange
-------              ----------           --------
192.168.10.0         192.168.10.1         192.168.10.20
```

***IpV4 scope opties***<br>
Als laatste moeten nog enkele opties op de scope aangepast worden. Dit doen we met het `Set-DhcpServerv4OptionValue` cmdlet.

``` 
Set-DhcpServerv4OptionValue -ScopeID 192.168.10.0 `
                            -ComputerName "trey-dns-03" `
                            -DnsDomain "TreyResearch.net" `
                            -DnsServer "192.168.10.2" `
                            -Router "192.168.10.1" `
                            -PassThru
``` 

***IpV6 configuratie***<br>
De IpV6 configuratie is volledig analoog aan de IpV4 configuratie. Het enige verschil is dat in de cmdlets de 4 wordt vervangen door een 6 en dat de Ipv4 adressen natuurlijk worden vervangen door IpV6 adressen.


***Meer configuratie DHCP***<br>
Er zijn nog meer dingen die je kan configureren aan je DHCP. Gebruik hiervoor de cmdlet set `Set-DhcpServer`. Gebruik de help functie om de verschillende cmdlets te bekijken.

##Aanmaken en beheren gebruikers en groepen
###Gebruikers

***Eerste gebruiker aanmaken***<br>
Een gebruiker aanmaken door alle gegevens te specifieren.

``` 
$SecurePW = Read-Host -Prompt "Enter a password" -asSecureString
New-ADUser -Name "Charlie Russel" `
           -AccountPassword $SecurePW  `
           -SamAccountName 'Charlie' `
           -DisplayName 'Charlie Russel' `
           -EmailAddress 'Charlie@TreyResearch.net' `
           -Enabled $True `
           -GivenName 'Charlie' `
           -PassThru `
           -PasswordNeverExpires $True `
           -Surname 'Russel' `
           -UserPrincipalName 'Charlie'
``` 

***Administrator account aanmaken***<br>
Een administrator account aanmaken. Ook wel het '500' account genoemd omdat zijn SID eindigd op 500. Dit account moet zeer goed beveiligd zijn.

``` 
Get-ADUser -Identity Administrator
``` 
***Gebruikers aanmaken doormiddel van een CSV bestand***<br>
Het is natuurlijk veel gemakkelijker om gebruikers via een CSV bestand toe te voegen dan elk individueel. Om dit te doen gebruiken we het script `Create-TreyUsers.ps1` dat ook te vinden is in het mapje scripts.

``` 
<#
.Synopsis
Creates the TreyResearch.net users
.Description
Create-TreyUsers reads a CSV file to create an array of users. The users are then added
to the users container in Active Directory. Additionally, Create-TreyUsers adds the
user Charlie to the same AD DS Groups as the Administrator account.
.Example
Create-TreyUsers
Creates AD Accounts for the users in the default "TreyUsers.csv" source file
.Example
Create-TreyUsers -Path "C:\temp\NewUsers.txt"
Creates AD accounts for the users listed in the file C:\temp\NewUsers.txt"
.Parameter Path
The path to the input CSV file. The default value is ".\TreyUsers.csv".
.Inputs
[string]
.Notes
    Author: Charlie Russel
 Copyright: 2015 by Charlie Russel
          : Permission to use is granted but attribution is appreciated
   Initial: 3/26/2015 (cpr)
   ModHist:
          :
#>
[CmdletBinding()]
Param(
     [Parameter(Mandatory=$False,Position=0)]
     [string]
     $Path = ".\TreyUsers.csv"
     )

$TreyUsers = @()
If (Test-Path $Path ) {
   $TreyUsers = Import-CSV $Path
} else {
   Throw  "This script requires a CSV file with user names and properties."
}

ForEach ($user in $TreyUsers ) {
   New-AdUser -DisplayName $User.DisplayName `
              -GivenName $user.GivenName `
              -Name $User.Name `
              -SurName $User.SurName `
              -SAMAccountName $User.SAMAccountName `
              -Enabled $True `
              -PasswordNeverExpires $true `
              -UserPrincipalName $user.SAMAccountName `
              -AccountPassword (ConvertTo-SecureString -AsPlainText -Force -String
"P@ssw0rd!" )
   If ($User.SAMAccountName -eq "Charlie" ) {
      $cprpwd = Read-Host -Prompt 'Enter Password for account: Charlie' -AsSecureString
      Set-ADAccountPassword -Identity Charlie -NewPassword $cprpwd -Reset
      $SuperUserGroups = @()
      $SuperUserGroups = (Get-ADUser -Identity "Administrator" -Properties * ).MemberOf

      ForEach ($Group in $SuperUserGroups ) {
         Add-ADGroupMember -Identity $Group -Members "Charlie"
      }
      Write-Host "The user $user.SAMAccountName has been added to the following AD
Groups: "
      (Get-ADUser -Identity $user.SAMAccountName -Properties * ).MemberOf
   }
}
``` 

Het CSV bestand moet volgende opmaak hebben als je bovenstaand script wilt gebruiken.

``` 
Name,GivenName,Surname,DisplayName,SAMAccountName,Description
David Guy,David,Guy,Dave R. Guy,Dave,Customer Appreciation Manager
Alfredo Fettucine,Alfredo,Fettuccine,Alfie NoNose,Alfie,Shop Foreman
Stanley Behr,Stanley,Behr,Stanley T. Behr, Stanley,WebMaster
``` 

***Aangemaakte gebruikers bekijken***<br>
Met volgend commando krijg je een lijst van de aangemaakte gebruikers.

``` 
(Get-ADUser -Filter {Enabled -eq "True"} -Properties DisplayName).DisplayName
``` 

###Groepen
***Nieuwe groep aanmaken***<br>

``` 
New-ADGroup –Name 'Accounting Users' `
            -Description 'Security Group for all accounting users' `
            -DisplayName 'Accounting Users' `
            -GroupCategory Security `
            -GroupScope Universal `
            -SAMAccountName 'AccountingUsers' `
            -PassThru
``` 

***Gebruiker aan groep toevoegen***<br>
R. Guy en Stanley T. toevoegen aan groep AccountingUsers.

``` 
Add-ADGroupMember -Identity AccountingUsers -Members Dave,Stanley -PassThru
``` 

Bekijke de leden van de groep met:

``` 
Get-ADGroupMember -Identity AccountingUsers
``` 

***Array van gebruikers toevoegen aan groep***<br>
Array van managers maken.

``` 
$ManagerArray = (Get-ADUser -Filter {Description -like "*Manager*" } `
                            -Properties Description).SAMAccountName
``` 

Dan de array toevoegen aan de groep managers.

``` 
Add-ADGroupMember -Identity "Managers" -Members $ManagerArray -PassThru
``` 

Bekijk of de gebruikers aan de groep toegevoegd zijn.

``` 
Get-ADGroupMember -Identity Managers | ft -auto SAMAccountName,Name
``` 

***Gebruiker aan meerdere groepen toevoegen***<br>
Array van groepen maken.

```
$Groups = (Get-ADUser -Identity Charlie -Properties *).MemberOf
```

Gebruiker toevoegen aan de array van groepen.

```
Add-ADPrincipalGroupMembership -Identity Alfie -MemberOf $Groups
```

Bekijk of de gebruiker aan de groepen toegevoegd zijn.

``` 
(Get-ADUser -Identity Alfie -Properties MemberOf).MemberOf
``` 

***Gebruiker verwijderen uit een groep***<br>

```
Remove-ADPrincipalGroupMembership -Identity Alfie `
                                  -MemberOf "Enterprise Admins",`
                                            "Schema Admins",`
                                            "Group Policy Creator Owners" `
                                  -PassThru
```

Bekijk of de gebruiker verwijderd is uit de groepen.

``` 
(Get-ADUser -Identity Alfie -Properties MemberOf).MemberOf
``` 

###OU's
***OU aanmaken***<br>

``` 
New-ADOrganizationalUnit -Name Engineering `
                         -Description 'Engineering department users and computers' `
                         -DisplayName 'Engineering Department' `
                         -ProtectedFromAccidentalDeletion $True `
                         -Path "DC=TreyResearch,DC=NET" `
                         -PassThru
```   
***Gebruikers en computers aan de OU toevoegen.***<br>
Om gebruikers of computers te verplaatsen naar een OU hebben we hun DN of GUID nodig. Deze paramter vullen we in bij `Identity`. Bij `TargetPath` vullen we de doel OU en de DC in.

Om de GUID van bijvoorbeeld Harlod te vinden gebruiken we.

``` 
Get-ADUser -Identity Harold
``` 

Om de GUID van de computer van Harold te vinden gebruiken we.

``` 
Get-ADComputer -Filter {Description -like "*Harold*" }
``` 
Nu kunnen we de computer van Harold toevoegen aan de OU Engineering.

``` 
Move-ADObject -Identity "46df71bd-ba88-4b26-9091-b8db6e07261a" `
              -TargetPath " OU=Engineering,DC=TreyResearch,DC=net" `
              -PassThru
```                        