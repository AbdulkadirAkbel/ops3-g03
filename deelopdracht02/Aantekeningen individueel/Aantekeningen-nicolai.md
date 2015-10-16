# Aantekeningen Online opleiding Nicolai Saliën #


## Chapter 1: Don't fear the shell  ##

- Powershell --> erg goed voor automatisatie <br>
- Best steeds uitvoeren als administrator, anders vaak permission errors<br>
- Powershell V2 --> Windows 7 en Server 2008<br>
- Powershell V3 --> Windows 8 en Server 2012<br>
- Steeds de mogelijkheid om je Powershell aan te passen naargelang je eigen wensen (font, kleur,…)<br>
- `Get-Alias` --> geeft alle verkorte cmdlets weer, zo is “del” = `Remove-Item`<br>
- Vaakgebruikte commando’s --> `cls`, `cd`

## Chapter 2: The help system  ##

- Help pages updaten --> `Update-Help -Force` <br>
- `Get-Help Get-Service –Detailed `--> geeft gedetailleerde hulp terug<br>
- SYNTAX: Get-Service [[-Name] <string[]>] [-ComputerName <string[]>] [-DependentServices] [-RequiredServices] [-Include <str ing[]>] [-Exclude <string[]>]  [<CommonParameters>]<br>
	[-Name] --> positional parameter --> enkel parameter moet worden meegegeven<br>
	[[-Name] <string[]>] --> optioneel<br>
	<string[]> --> als parameter meerdere waarden meegegeven adhv komma<br>
- `Get-eventlog` --> parameters over verduidelijking verplicht, anders TE VEEL logs te geven<br>
--> `get-eventlog –Logname System` --> alle logs over het “System”<br>
- `Get-Help Get-Service –Examples` --> geeft voorbeelden van de cmdlets<br>
- Werken met wildcards --> `Get-Service \*b*` --> geeft services waar “b” in voorkomt<br>
- `Get-Help Get-Service –ShowWindow` --> geeft hulp in apart venster, kan ook -Online<br>
- Copy paste --> rechterklik, rechterklik<br>
- Aanvullen --> Tab, voor terug te gaan --> Shift + tab<br>
- Meerdere methods na elkaar --> punt komma tussen verschillende commando’s

## Chapter 3: The pipeline: getting connected & extending the shell  ##

- | = Pipeline = stuurt objecten één voor één door naar het volgende commando waar er opnieuw iets kan met worden gedaan<br><br>
Vb: `Get-Service –name bits | Stop-Service -PassThru`--> neemt de service en stopt de service met naam “Bits”. -Passthru parameter om output onmiddellijk ook te tonen. <br><br>
Vb: `Get-Service |export-csv –Path c:\service.csv` --> exporteert alle services naar csv bestand. Openen met `Export-csv c:\service.csv`
- Snapshot nemen van processes op een computer adhv XML: `Get-Process | Export-clixml –Path c:\good.xml` --> open notepad en calculator --> dan deze XML file vergelijken met huidige processes door:<br>
	`Compare-Object –ReferenceObject (import-clixml c:\good.xml) –Difference (Get-Process) –    Property name`
- `Get-Content c:\text.txt`
- `ConvertTo-Html` --> data omzetten naar HTML file
- `Whatif` argument --> wat als commando x wordt uitgevoerd
- `Confirm` argument --> wat als commando + moet bevestiging geven
- `Get-Module –ListAvailable` --> geef de beschikbare modules weer (niet voor ws7 en psv2)
- `Import-Module ActiveDirectory` --> importeer de active directory onderdelen

## Chapter 4: Objects for the admin  ##

- Objects = heeft properties en methodes, vergemakkelijkt het leven voor ons 
- `Get-Member` (alias = `gm`) geeft informatie over object (gebruiken in pipe)
- `Get-Service | select –Property name, status | sort –Property name -Descending` --> welke properties wil ik zien van een object, geordend
- `Get-History` --> geschiedenis van wat je getypt hebt
- XML bestand ophalen en in var steken --> `$x = [xml](cat .\r_and_J.xml)`
	--> dan kan je de parents en childs doorgaan van de XML file, vb:
		`$x.PLAY.ACT[0].SCENE[0].SPEECH`
-  `Get-Service | where {$\_.status –eq “Running” -and $_.name -like "b*"} `--> $_ = huidig object in pipeline, status = property
-  Performantie: zover mogelijk rechts proberen filteren (zoals sort), duurt minder lang om uit te voeren
-  Eenvoudigere versie van where zonder {}: `Get-Service | where status -eq "Running"`


## Chapter 5: The pipeline: deeper  ##

- Pipeline stuurt een object tegelijkertijd doorheen de pipeline. 
- Als de nouns matchen zullen ze waarschijnlijk gepiped kunnen worden by value (`get-service |stop-service`)
- Maar wat bij `get-service | stop-process`? `get-service | gm` --> alle nodige info over get-service object
- ByValue ondersteuning --> moet het exact hetzelfde geschreven zijn om te kunnen matchen in pipelines
- Indien je geen ondersteuning hebt om verschillende properties met elkaar te laten matchen, kan ze deze zelf aanmaken --> `get-adcomputer -filter * |select -Property name, @{name='computername';expression={$_.name}}` --> hier verander je de propertynaam van name naar computernaam

## Chapter 6: The PowerShell in the shell: remoting  ##

- WinRM service die nodig is voor remoting
- Kan je specifiek toewijzen waar je je code wilt laten uitvoeren (bv welke pc)
- Enable remoting --> `Enable-PSRemoting` --> maar dit moet allemaal individueel gedaan worden, kan ook toepassen op group policy zodat dit maar 1x gedaan moet worden. 
- In Windows 2012 staat het default aan, het is ook secure, dus geen reden tot paniek rond security
- `Enter-PSSession s1` --> gaat remote naar powershell van Server 1. (aanzie het als een soort van secured telnet)
- `Invoke-Command -computerName dc,s1,s2 {get-eventlog -logname system -new 3}` --> voor de verschillende computers commando's uitvoeren = invoke command is niet remoting
- Bij het toepassen van command op pc('s) werk je niet meer met het echte object, maar met een representatie ervan (deserialised) waarbij je ook over minder methoden zal beschikken (enkel ToString bv)
- `Install-WindowsFeatre WindowsPowershellWebAccess` --> geeft verschillende nieuwe cmdlets --> `install-PswaWebApplicaton -UseTestCerfiticate` --> powershell bedienen vanaf browser --> wie mag dit gebruiken? --> `Add-PswaAuthorizationRule * * *` --> iedereen heeft alle rechten
- Start de applicatie: `start iexplore https://pwa/pswa`
- `icm dc,s1,s2 {Get-Volume} | sort Sizeremaining` (icm = invoke command)


## Chapter 7: Getting prepared for automation  ##

- Kan script niet uitvoeren? --> `Set-ExecutionPolicy AllSigned` lost het probleem niet op --> moet gecertificeerd worden --> `Set-AuthenticodeSignature -Certificate CertName -FilePath PathOfCert`
- `New-SelfSignedCertificate` --> om scripten te ondertekenen (zie vorige stap)
- Variabelen = $ symbool --> neemt niet enkel strings en ints,... maar ook objecten en via de dot notatie methodes uitvoeren of properties ophalen
- `Read-host` --> input opvragen van gebruiker
- `Write-Host` --> output, kan je dingens met wijzigen (kleuren,...), write host niet aan te raden --> WEL: `write-output`, `write-warning` --> in het oranje, `write-error` --> rood
- `${this is a variable} = "Tekst"` --> wordt onthouden in meerdere Powershell sessies.

## Chapter 8:  Automation in scale: remoting ##

- `$sessions = new-PSSession -computername dc` --> `icm -Session $Sessions {$var = 2} ` --> `icm -Session $sessions {$var}` --> var wordt onthouden door de sessie --> alles zal sneller werken
- `$servers = 's1', 's2'` --> `$s = New-PSSession -ComputerName $servers` --> sessies van s1 en s2 worden gestart --> Web servers opstarten op elke server --> `icm -Session $s {Install-WindowsFeature web-server}` --> $servers | foreach{start iexplore https://$_} --> start de IIS op van de servers
- Probleem dat we vaak modules opnieuw moeten importeren wanneer we ons op andere machines bevinden --> `$s = new-PSSession -computername dc` --> `import-pssession -session $s -module ActiveDirectory -Prefix remote` --> nu heb je de commandlets van de active directory van de domein controller!! --> commands worden uitgevoerd op dc maar resultaten komen op de eigen box
