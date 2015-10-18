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

Na het aanmaken van het domein en de forest kan je met volgend script de Forest Mode, Domain Mode, en Schema Version bekijken. Sla het script op als Get-myADVersion.ps1.

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
