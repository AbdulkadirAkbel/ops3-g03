# Aantekeningen Boek en Online opleiding Nicolai Saliën #


## Chapter 1: Don't fear the shell  ##

- Powershell --> erg goed voor automatisatie <br>
- Best steeds uitvoeren als administrator, anders vaak permission errors<br>
- Powershell V2 --> Windows 7 en Server 2008<br>
- Powershell V3 --> Windows 8 en Server 2012<br>
- Steeds de mogelijkheid om je Powershell aan te passen naargelang je eigen wensen (font, kleur,…)<br>
- Get-Alias --> geeft alle verkorte cmdlets weer, zo is “del” = Remove-Item<br>
- Vaakgebruikte commando’s --> cls, cd

## Chapter 2: The help system  ##

- Help pages updaten --> Update-Help -Force <br>
- Get-Help Get-Service –Detailed --> geeft gedetailleerde hulp terug<br>
- SYNTAX: Get-Service [[-Name] <string[]>] [-ComputerName <string[]>] [-DependentServices] [-RequiredServices] [-Include <str ing[]>] [-Exclude <string[]>]  [<CommonParameters>]<br>
	[-Name] --> positional parameter --> enkel parameter moet worden meegegeven<br>
	[[-Name] <string[]>] --> optioneel<br>
	<string[]> --> als parameter meerdere waarden meegegeven adhv komma<br>
- Get-eventlog --> parameters over verduidelijking verplicht, anders TE VEEL logs te geven<br>
--> get-eventlog –Logname System --> alle logs over het “System”<br>
- Get-Help Get-Service –Examples --> geeft voorbeelden van de cmdlets<br>
- Werken met wildcards --> Get-Service \*b* --> geeft services waar “b” in voorkomt<br>
- Get-Help Get-Service –ShowWindow --> geeft hulp in apart venster, kan ook -Online<br>
- Copy paste --> rechterklik, rechterklik<br>
- Aanvullen --> Tab, voor terug te gaan --> Shift + tab<br>
- Meerdere methods na elkaar --> punt komma tussen verschillende commando’s

## Chapter 3: The pipeline: getting connected & extending the shell  ##

- | = Pipeline = stuurt objecten één voor één door naar het volgende commando waar er opnieuw iets kan met worden gedaan<br><br>
Vb: Get-Service –name bits | Stop-Service -PassThru neemt de service en stopt de service met naam “Bits”. -Passthru parameter om output onmiddellijk ook te tonen. <br><br>
Vb: Get-Service |export-csv –Path c:\service.csv --> exporteert alle services naar csv bestand. Openen met “Export-csv c:\service.csv<br><br>
- Snapshot nemen van processes op een computer adhv XML: Get-Process | Export-clixml –Path c:\good.xml --> open notepad en calculator --> dan deze XML file vergelijken met huidige processes door:<br>
	Compare-Object –ReferenceObject (import-clixml c:\good.xml) –Difference (Get-Process) –    Property name
- Get-Content c:\text.txt
- ConvertTo-Html --> data omzetten naar HTML file
- Whatif argument --> wat als commando x wordt uitgevoerd
- Confirm argument --> wat als commando + moet bevestiging geven
- Get-Module –ListAvailable --> geef de beschikbare modules weer (niet voor ws7 en psv2)
- Import-Module ActiveDirectory --> importeer de active directory onderdelen

## Chapter 4: Objects for the admin  ##

- Objects = heeft properties en methodes, vergemakkelijkt het leven voor ons 
- Get-Member (alias = gm) geeft informatie over object (gebruiken in pipe)
- Get-Service | select –Property name, status | sort –Property name -Descending --> welke properties wil ik zien van een object, geordend
- Get-History --> geschiedenis van wat je getypt hebt
- XML bestand ophalen en in var steken --> $x = [xml](cat .\r_and_J.xml)
	--> dan kan je de parents en childs doorgaan van de XML file, vb:
		$x.PLAY.ACT[0].SCENE[0].SPEECH
-  Get-Service | where {$_.status –eq “Running”} --> $_ = huidig object in pipeline, status = property
