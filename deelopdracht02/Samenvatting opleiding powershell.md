## Aantekeningen Opleiding Microsoft Virtual Academy


### Chapter 1: Don't fear the shell

- Powershell altijd als administrator uitvoeren anders kan je errors krijgen in verband met toegang die geweigerd wordt.
- Commando's van zowel unix als windows kunnen gebruikt worden in powershell.
- Meeste cmdlets zijn in de vorm werkwoord-naamwoord
- Powershell V2 --> Windows 7 en Server 2008
- Powershell V3 --> Windows 8 en Server 2012
- Steeds de mogelijkheid om je Powershell aan te passen naargelang je eigen wensen (font, kleur,…)
- `set-location c:\`
- `get-childitem` OF `dir` OF `ls`
- `clear` OF `cls` (=clear screen)
- `get-alias` (geeft alle aliassen) (alias hiervoor: `gal`)
- `md jason` (maakt een map met de naam jason)
- `mkdir jason` doet hetzelfde
- `help` OF `man`
- Je kan ook programma's opstarten: `notepad`, `calculator`, `mspaint`
- `ipconfig`, `ping`


### Chapter 2: The help system

- Er zijn duizenden cmdlets die je nooit allemaal van buiten kan leren, daarom is help gemakkelijk om cmdlets te ontdekken.
- Help system wordt regelmatig geüpdate.
- `update-help -Force` (downloadt alle helpbestanden die je nodig hebt op je systeem)
- 'Get-help' niet hetzelfde als 'help' en 'man'.<br/>
Get-help gaat meteen naar onderaan de help file en moet je naar boven scrollen om de inhoud te bekijken.<br/>
Help en man tonen het begin van de help file, je kan naar onder gaan door op spatie te duwen.
- Als je het help systeem gebruikt om naar cmdlets te zoeken met bv. wildcards, krijg je per cmdlet de categorie, de module en een korte beschrijving.
- `get-verb` geeft je alle werkwoorden waarmee je een cmdlet kan vormen.
- `get-help get-service` (geeft een deel van de helppagina)
- `help get-service` geeft de volledige pagina
- `get-help *service*` (geeft alles waar service voorkomt)
- `get-help get-service -Online` (opent de helppagina online)
- `get-help get-service -Full` (opent de volledige helppagina)
- `get-help get-service -Example` (voorbeelden)
- `get-help get-service -ShowWindow` (opent een appart venster met daar de help file die je kan filteren of kopiëren)
- om te kopiëren in powershell: selecteren, rechts klikken, op de plaats waar je het wil plakken opnieuw rechts klikken
- commando aanvullen --> Tab, om terug te gaan --> Shift + tab
- een woord voorafgegaan door een koppelteken = parameter vb: `-Name`, `-ComputerName` </br> voorbeeld: `get-service -Name bits` (geeft de services met de naam bits)
- `-name` mag je weglaten </br> `get-service -name bits` = `get-service bits`
- alias voor `get-service` = `gsv` </br> vb: `gsv bits`
- 3 laatste errors weergeven: `get-eventlog -logname system -newest 3 -entrytype error`
- 3 laatste errors van 3 computers weergeven: `get-eventlog -logname system -newest 3 -entrytype error -computername dc,s1,s2`
- Je kan meerdere commando's tegelijk uitvoeren door ze te scheiden met een `;`.
- `cls ; help about_eventlogs` = doet 2 zaken in 1 keer


### Chapter 3: The pipeline: getting connected & extending the shell

- Pipeline is heel krachtig dus wees voorzichtig welke commando's je uitvoerd.
- Pipeline vraagt geen confirmatie, de commando's worden meteen uitgevoerd
- pipeline = `|`
- pipeline stuurt de output voor de pipeline naar na de pipeline, zo kan je meerdere taken uitvoeren in 1 lijn
- vb: `get-service -name bits` (=toont de service) </br> `get-service -name bits | stop-service` (=toont en stopt de service)
- `get-service | export-csv -path c:\service.csv`
- `get-process | export-clixml -path c:\good.xml`
- `get-service | out-file -filepath c:\test.txt`
- `get-content c:\test.txt`
- `get-service | ConvertTo-html -Property name,status | out-file c:\test.html`
- `-whatif` (wat gaat er gebeuren als ik dit doe?)
- `-confirm` (powershell vraagt bevestiging voor de uitvoering)
- Commando's om specifieke programma's te beheren, worden met behulp van modules meegelverd met het desbetrefende programma. De modules bevatten cmdlets die het programma kunnen beheren of aanpassen. Een voorbeeld van zo een programma is Active Directory.
- `get-module` (actieve modules)
- `Import-Module ActiveDirectory` (importeert AD module)


### Chapter 4: Objects for the Admin

- objecten vergemakkelijken je leven
- `get-process | where handles -gt 900` (geeft de processen waarvan de handles goter is dan 900)
- `get-process | where handles -gt 900 | sort handles` (zelfde als hierboven, maar gesorteerd volgens handles)
- `-get-member` toont welke type object door de pipeline gaat 
- `get-service -name bits | get-member` (alias: `gm`)
- `get-service | select -property name,status` (geeft enkel de naam ens tatus van de services)
- voorbeeld: `get-childitem | select -property name, length | sort -property length -descending`
- alles waar er property in staat kan je gebruiken met `select`, `sort`...
- `get-eventlog -logname system -newest 5 | select -property eventid, timewritten, message | sort -property timewritten | convertto-html | out-file c:error.html`
- `$x = [xml]\(cat .\bestand.xml)` <br/> xml-bestand ophalen en in variabele x steken <br/> zo kan je in een xml-bestand gegevens opvragen: `$x.PLAY.ACT[0].SCENE[0].SPEECH`
- `get-history`
- `$_` = huidig object in de pipeline
- `get-service | where {$_.status -eq "Running}` huidig object in pipeline, status = property
- `get-service | where {$_.status = "Running}`
- Eenvoudigere versie van where zonder {}: `Get-Service | where status -eq "Running"`
- `get-service | where {$PSItem_.status = "Running} `<br/> alle 3 zijn hetzelfde
- `get-process` (alias: `gps`)
- `gps | where {$_.handles -ge 1000}`

### Chapter 5: The pipeline: deeper

- `get-service | stop-service` zal werken <br/>maar `get-service | stop-process` zal niet werken omdat niet de juiste parameter wordt doorgegeven
- Als de nouns matchen zullen ze waarschijnlijk gepiped kunnen worden by value (`get-service |stop-service`)
- `get-adcomputer -filter *` (geeft alle info van alle computers die in AD zitten)
- `get-adcomputer -filter * | select -property name, @{name='ComputerName' ;expression={$_.name}}` <br/>zet de property name om naar ComputerName <br/> korter: `get-adcomputer -filter * | select -property name, @{n='ComputerName' ;e={$_.name}} `
- `get-adcomputer -filter * | select -property @{n='ComputerName' ;e={$_.name}} | get-service -name bits`
- `get-wmiobject -class win32_bios` (geeft bios info)
- `get-wmiobject -class win32_bios -cumputername dc,s1,s2 (geeft bios info van computers dc,s1,s2)`
- `get-adcomputer -filter * | gm`
- geen pipeline input mogelijk voor `get-wmiobject -class win32_bios`
- `get-wmiobject -class win32_bios -computername (get-adcomputer -filter *)` (wat tussen haakjes staat wordt eerst uitgevoerd, daarna wordt het meegegeven aan `-computername`)
- `get-adcomputer -filter * | select -property name `(type is adcomputer)
- `get-adcomputer -filter * | select -expandproperty name` (geeft geen titel, de type is ook string en geen adcomputer, dat bekom je na `| gm`)
- `get-wmiobject -class win32_bios -computername (get-adcomputer -filter * | select -expandproperty name)`
- korter: `get-wmiobject -class win32_bios -computername (get-adcomputer -filter * ).name`
- `get-adcomputer -filter * | get-wmiobject -class win32_bios -computername {$_.name}`

### Chapter 6: The PowerShell in the shell: remoting

- PowerShell Remoting activeren: (Group Policy Management Editor) Computer Configuration/Policies/Administrative Templates/Windows Components/Windows Remote Management <br/> Op Windows Server 2012 is het standaard geactiveerd.
- `enter-pssession -computername dc` (opent een powershell sessie op dc)
- `invoke-command -computername dc,s1,s2 {get-eventlog -logname system -new 3}` <br/> invoke-command runs commands on local and remote computers. alias = `icm`
- `invoke-command -computername dc,s1,s2 {restart-computer}`
- `invoke-command -computername dc,s1,s2 {get-service -name bits}`
- `invoke-command {get-service -name bits}` <br/> runt het lokaal
- `enter-pssession pwa` (ps sessie op pwa)
-  `[pwa]` (sessie op pwa): `get-windowsfeature` (toont een lijst van alle rollen en features, er staat een x als het is geïnstalleerd)
-  `[pwa]: get-windowsfeature *powershell*`
-  `[pwa]: install-windowsfeature windowspowershellwebaccess`
-  `[pwa]: get-help *pswa*`
-  `[pwa]: install-pswebapplication -usertestcertification` (maakt een webapp aan)
-  `[pwa]: add-pswaauthorizationrule * * *` (betekent dat iedereen alles kan doen)
-  `start iexplore https://pwa/pswa` (powershell in een browser)
-  `invoke-command -computername dc,s1,s2 {get-eventlog -logname system -new 3} | sort timewritten | format-table -property timewritten, message -autosize`
-  `get-volume`
-  `icm dc,s1,s2 {get-volume} | sort sizeremaining`
-  `icm dc,s1,s2 {get-volume} | sort sizeremaining | select -last 3`
-  hoe een script maken? commando opslaan in bv kladblok, opslaan als naam.ps1

### Chapter 7: Getting prepared for automation

- Kan script niet uitvoeren? --> `Set-ExecutionPolicy AllSigned` lost het probleem niet op --> moet gecertificeerd worden --> `Set-AuthenticodeSignature -Certificate CertName -FilePath PathOfCert`
- `New-SelfSignedCertificate` --> om scripten te ondertekenen (zie vorige stap)
- `get-psdrive` (geeft de schijfstations) <br/>er is een drive met de naam Cert (certificate)
- `dir Cert:\CurrentUser -recurse -codesigningcert -outvariable a` (zoekt recursief naar de codesigningcertificaten
- `$a` (zet de output van hierboven in de variabele a)
- `$cert = $a[0]`
- `get-executionpolicy` (output: remotesigned)
- `set-executionpolicy "allsigned"`
- `dir` (kijkt naar de mappen in de directory)
- er is een testscript: test.ps1 <br/>opent de script met: `notepad .\test.ps1` (inhoud van de script: `Write-Output "Hello world"`)
- `cat .\test.ps1`
- als je het runt gaat het niet omdat het niet digitally signed is: `.\test.ps1`
- `set-authenticodesignature -certificatert -filepath .\test.ps1` <br/> als je hierna `cat .\test.ps1` opent, lukt het wel
- `.\test.ps1` (je kan het runnen)
- `set-executionpolicy remotesigned`
- `.\test.ps1` (runnen lukt)
- `notepad .\test.ps1` (`restart-computer` toevoegen aan de script -> proberen runnen: lukt niet: executable script code found in signature block)
- `allsigned` = ieder script dat je downloadt of dat je aanmaakt lokaal moet signed zijn
- `remotesigned` = alles dat je downloadt van het internet moet signed zijn (powershell weet of je het hebt gedownloadt hebt of zelf aangemaakt hebt adhv een tag)
- `remotesigned` is goed om te starten, `allsigned` is het beste
- `remotesigned` is defaultwaarde
- `get-help *variable`
- `$myvar="Hello"`
- `$myvar` (output: Hello)
- `$myvar=get-service bits`
- `$myvar` (output: get-service bits)
- `$myvar.status` (output: running)
- `$myvar.stop()`
- `$myvar.status` (output: running)
- `$myvar.refresh()`
- `$myvar.status` (output: stopped)
- `myvar = get-service bits` (error: the term myvar is not recognized as the name of a cmdlet, dus zonder $ zijn het commando's, variabelen altijd met $)
- `Read-host` input opvragen van gebruiker
- `Write-Host` --> output, kan je dingen met wijzigen (kleuren,...), write host niet aan te raden --> WEL: `write-output`, `write-warning` --> in het oranje, `write-error` --> rood
- `$var=read-host "Enter a computername"` (vraagt computer name, vb dc ingeven)
- `$var` (output: dc)
- `get-service -name bits -computername $var`
- `write-host $var` (output: dc)
- `write-host $var -foregroundcolor red -backgroundcolor green`
- `write-host $var | gm` (output: er passeert geen object de pipeline)
- `write-output $var | gm` (er is nu wel een output, write-output passeert we de pipeline)
- `write-warning "Please..don't do that"`
- `write-error "Stop touching me!"`
-` ${this is a test} = 4`
- `${this is a test}` (output: 4)
- `${this is a test61671515135gd} = "WOOW"`
- `${this is a test61671515135gd}` (output: WOOW)
- `1..5` (output: 1 2 3 4 5)
- `1..5 >test.txt`
- `${C:\jumpstart\test.txt}` (output: 1 2 3 4 5)
- `${C:\jumpstart\test.txt} = "are you freaking kidding me?"` (output: are you freaking kidding me?)

### Chapter 8: Automation in scale: remoting

- `icm -comp dc {$var=2}` (maakt een variabele var aan op dc)
- `icm -comp dc {write-output $var}` (we krijgen geen output omdat de console dood gaat na het uitvoeren van de eerste commando) <br/> oplossing: een verbinding maken, alles uitvoeren, verbinding verbreken = powershell sessie)
- `$sessions=new-pssession -computername dc`
- `get-pssession`
- `icm -session $sessions {$var=2}`
- `icm -session $sessions {$var}` (nu krijgen we wel output) var wordt onthouden door de sessie --> alles zal sneller werken
- `measure-command {icm -computername dc {get-process}}`<br/>toont hoe lang de commando nodig heeft om uitgevoerd te worden
- `measure-command {icm -session $sessions {get-process}}` <br/>op deze manier gaat het sneller
- `$servers='s1', 's2'`
- `$servers | foreach{start iexplore http://$_}`<br/>voor elk object dat de pipeline passeert wordt de code tussen {} uitgevoerd (nu kan de pagina nog niet worden weergegeven omdat s1 en s2 geen webserver zijn)
- `$s = new-pssession -computername $servers`
- `$s (output: 2 sessies, s1 en s2)`
- `icm -session $s {install-windowsfeature web-server} `(installeert web-server op s1 en s2, zo kan je bv met zeer weinig werk iets installeren op 100 computers tegelijk)
- `$servers | foreach{start iexplore http://$_}`<br/>startpagina iis wordt geopend 
- `notepad c:\default.html` <br/>De tekst "MVA and PowerShell Rocks!" ingeven in het aangemaakte bestand
- `$servers | foreach{copy-item c:\default.html -destination \\$_\c$\inetpub\wwwroot}` <br/>aangemaakte webpagina plaatsen op de webserver
- `$servers | foreach{start iexplore http://$_}`
- `$s=new-pssession -computername dc`
- `import-pssession -session $s -module activedirectory -prefix remote `<br/> installeerd de module activedirectory op de remote computer, zo kan je alle commando's van de remote computer gebruiken zonder dat je ze lokaal moet installeren
- `get-help *remotead*`
- `get-remoteadcomputer -filter *`
- `$c = get-command get-process` (geeft meer info over de commando)
- `$c.parameters`
- `$c.parameters["Name"]`
- `get-command get-*adcomputer` (toont een functie en een commando)
- `(get-command get-remoteadcomputer).definition` (toont de functie)

### Chapter 9: Introducing scripting and toolmaking

- PowerShell ISE: scriptpagina en powershell tegelijk
- ctrl+R wisselt tussen scriptpagina en powershell
- `get-wmiobject win32_logicaldisk -filter "DeviceID='c:'"` <br/>info over drive c
- `get-wmiobject win32_logicaldisk -filter "DeviceID='c:'" | select freespace `<br/> geeft de vrije ruimte in bytes
- als je bij het ingeven van een commando/parameter ctrl+spatie doet, krijg je een lijst met de mogelijke combinaties
- `get-wmiobject win32\_logicaldisk -filter "DeviceID='c:'" | select @{n='freegb'; e={$\_.freespace / 1gb -as [int]}}`
- `-get-wmiobject win32_logicaldisk -filter "DeviceID='c:'" `<br/> dit opslaan in ise als een script en dan runnen in powershell venster <br/>
- `function get-diskinfo{`<br/>
`[cmdletbinding()]`<br/>
`param(`<br/>
`[Parameter(Mandatory=$True)]`<br/>
`[string[]]$computername,}`<br/>
`$bogus`<br/>
`)`<br/>
`get-wmiobject -computername $computername -class win32_logicaldisk -filter "DeviceID='c:'"}`
- dit kan je dan uitvoeren met `.\diskinfo.ps1 -computername dc` of gewoon `.\diskinfo.ps1`, dan vraagt de prompt naar een computernaam
- `<# .... #>` = commentaar
- een script opslaan als een module: diskinfo.psm1
- `import-module .\diskinfo.psm1 -force -verbose`
- dan kan je het zo gebruiken: `get-diskinfo -computername dc`
- `$env:PSModulePath -split ";"` <br/>je kan je eigen modules opslaan in de eerste pad dat wordt weergegeven in de output (met dezelfde naam!)
- `remove-module diskinfo`
- `import-module diskinfo`
