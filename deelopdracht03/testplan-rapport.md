## Testplan en -rapport taak 3: Windows Server deployment met Powershell

* Verantwoordelijke uitvoering: `Abdülkadir`
* Verantwoordelijke testen: `Nicolai`

### Testplan

Auteur(s) testplan: Andy

***AD DS***

1. Active Directory is correct geïnstalleerd.
2. Het domein is aangemaakt.

Cmdlets om te testen: https://technet.microsoft.com/en-us/library/hh852274(v=wps.630).aspx

***DNS*** (get-DNSserverZone)

1. De DNS is gëinstalleerd.
2. Er is een primary forward-lookup zone geconfigureerd.
3. Er is een primary reverse-lookup zone geconfigureerd.

Cmdlets om te testen: https://technet.microsoft.com/en-us/library/jj649850.aspx

***DHCP***

1. De DHCP role is geïnstalleerd
2. Er is een scope aangemaakt voor de hosts.(`Get-DhcpServerv4Scope`)
3. Er is een exclusion range aangemaakt. (`Get-DhcpServerv4ExclusionRange`)
4. De DHCP is geactiveerd.

Cmdlets om te testen: https://technet.microsoft.com/en-us/library/jj590751(v=wps.630).aspx

***Gebruikers en OU's***

1. Er zijn gebruikers aangemaakt.
2. De gebruikers zitten in de correcte OU's.
3. De gegevens van de gebruikers zijn allemaal aanwezig.
4. Gebruikers kunnen inloggen op het domein.

Om gebruikers te bekijken: `Get-ADUser -Filter 'Enabled -eq $true'` 

### Testrapport

Uitvoerder(s) test: Nicolai

***AD DS***

1. OK <br/> `Get-ADComputer` <br/> `Get-ADDomainController`
2. OK `Get-ADDomain`

Cmdlets om te testen: https://technet.microsoft.com/en-us/library/hh852274(v=wps.630).aspx

***DNS*** 

1. OK `Get-DnsServer`
2. OK `get-DNSserverZone`
3. OK `get-DNSserverZone`

Cmdlets om te testen: https://technet.microsoft.com/en-us/library/jj649850.aspx

***DHCP***

1. OK `Get-DhcpServerInDC`
2. OK `Get-DhcpServerv4Scope`
3. OK `Get-DhcpServerv4ExclusionRange`
4. 

Cmdlets om te testen: https://technet.microsoft.com/en-us/library/jj590751(v=wps.630).aspx

***Gebruikers en OU's***

1. OK `Get-ADUser -Filter 'Enabled -eq $true'` 
2. OK
3. OK
4. OK

