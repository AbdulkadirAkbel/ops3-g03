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

***Shares***

1. Shares zijn aangemaakt. `Get-SmbShare | Get-SmbShareAccess`
2. Gebruikers hebben de juist rechten op de shares. `Get-SmbShare | Get-SmbShareAccess`
3. De shares zijn benaderbaar vanaf het werkstation.

***IIS***

1. De webservice runt. `Get-Service W3SVC`
2. De webpagina is te bereiken van op het werkstation met het ip-adres. `http://192.168.101.11/index.html`
3. De webpagina is te bereiken van op het werkstation met de domeinnaam. `http://project3.be/index.html`

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

Schermafbeelding van `ipconfig /all` op het werkstation dat een IP-adres krijgt van de server en dat lid is van het domein Project3.be:<br/>
![](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht03/Images/testdhcp.PNG)

Cmdlets om te testen: https://technet.microsoft.com/en-us/library/jj590751(v=wps.630).aspx

***Gebruikers en OU's***

1. OK `Get-ADUser -Filter 'Enabled -eq $true'` 
2. OK
3. OK
4. OK

***Shares***

1. OK
2. OK
3. 

***IIS***

1. OK 
2. OK
3. OK

De aangemaakte gebruiker AbAkb2 kan inloggen op het werkstation met wachtwoord `Projecten3`. 

