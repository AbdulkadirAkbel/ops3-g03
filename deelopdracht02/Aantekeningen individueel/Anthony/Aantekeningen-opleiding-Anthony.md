##Aantekeningen Powershell opleiding Anthony

###Chapter 1: Don't fear the shell

- Powershell altijd starten in administrator modus.
- Native commands werken.
- cd: `Set-Location`.
- dir, ls: `Get-Childitem`.
- type, cat: `Get-Content`.
- copy, cp: `Copy-Item`.
- Unix commando's werken ook op Powershell.
- Aliasen zoeken op naam: `gal '...''...'` - bv: `gal g*`.
- gal: `Get-Alias`.

###Chapter 2: The help system

- Zeer belangrijk, niet alles van buiten leren, maar leren werken met `get-help`.
- Iets updaten via internet: `update-"..."` - bv: `update-help`.
- Uigebreider hulp zoeken: `get-help "..."` - bv: `get-help *service*`
- Joker in iets toevoegen: `*`
- Gedetailleerde hulp krijgen: `get-help "..." -detailed`.
- Gedetailleerde hulp krijgen met informatie over de parameters: `get-help "..." -full`.
- Gedetailleerde hulp krijgen met informatie in een apart venster: `get-help "..." -showwindow`.
- "<String[]>" betekent dat er meerdere waarden kunnen worden toegevoegd tussen "[]".
- Alle aliassen bekijken: `Get-Alias`.

###Chapter 3: The pipeline: getting connected & extending the shell

- Pipeline: `|`.
- Je kan meerdere commando's meegeven tijdens 1 uitvoer.
- NOOIT DOEN: `get-service | stop-service` -> stopt alle services.
- Exporteren en importeren: `get-service | export-csv -Path c:\service.csv` & `import-csv c:\service.csv`.
- Vergelijken: `Compare-Object -ReferenceObject (import-clixml c:\good.xml) -DifferenceObject -Property name`.
- Exporteren: converteren en naar een file schrijven.
- Converteren: `ConvertTo-...`.
- Als je niet zeker bent: `... -whatIf`.
- Confirmatie vragen: `... -confirm`.
- Get-Help zoekt ook in modules die nog niet zijn geïnstalleerd.
- Modules weergeven die geladen zijn: `Get-Module`.

###Chapter 4: Objects for the admin

- Op een bepaalde property sorteren: `... | sort -Property ... (-Descending)`.
- Xml manipulatie gaat makkelijk in powershell v3.
- Filteren: `... |where {...}`.
- Sql: `... | where {$_. ... ... ...}`.

###Chapter 5: The pipeline: deeper

- Accepteert het pipeline input: ` get-help get-service -full`
- Membertype te weten komen: `get-service | gm`
- Waar bevindt een process zich: `get-process ... | dir`
- Name omzetten naar ComputerName: `get-adcomputer -filter * | select -property name, @{name='ComputerName';expression={$_.name}}`
- {}: scipt blog -> code die wordt uitgevoerd.

###Chapter 6: The PowerShell in the shell: remoting

- WinRM: moet aangezet worden voor remoting.
- In Windows Server 2012 staat WinRM aan by default.
- PowerShell sessie openen via remote connectie: `Enter-PSSession -ComputerName ...`
- Een veilige telnet verbinding starten: `mstsc ...`
- PowerShell commando uitvoeren op andere pc's: `invoke-command -ComputerName {...}`
- `Get-WindowsFeature`: [x] = geïnstalleerd - [] = niet geïnstalleerd.
- `Install-WindowsFeature ...`: een bepaalde feature van Windows installeren.
- Security regels voor PowerShell: `Add-PswaAuthorizationRule ... ... ...`
- Schijven bekijken: `Get-Volume`

###Chapter7: Getting prepared for automation

- Certificaat creëren: `new-SelfSignedCertificate`
- Waarde in variabele steken: `... -OutVariable a` -> waarde zit in `$a`
- Scripts worden in PowerShell v3 niet meer altijd uitgevoerd, als er bijvoorbeeld "bad code" in zit krijg je eerst een waarschuwing.
- Scripts uitvoeren: `.\...`
- Variable cmdlets zijn overbodig geworden.
- Werken met variabelen: `$MyVar.staus/stop/start/...`
- Handmatig iets in variabele steken: `$var=read-host "..."`
- `Write-host ...` wordt niet doorgegeven aan de pipeline.
- Variabelen die op meerdere PowerShell terminals beschikbaar zijn: `${...}=...`

###Chapter 8: Automation in scale: remoting

- Na een remote sessie wordt alles terug verwijderd.
- Sessie creëren: `$...=New-PSSession ... ...`
- Script block: `{...}`
- Invoke command: `icm ...`
- PowerShell sessie importeren: `Import-PSSession -session $... ... ...`
- Bestaat een commando: `get-command ...`
- Dynamische code generen van commando: `(... ...).Defenition`
- Prefixen toevoegen aan cmdlets: `... ... -CommandName -get-process -Prefix ...`

###Chapter 9: Introducing scripting and toolmaking

- CRTL-R: switchen tussen console en scripting box.
- Scripting: in PowerShell ISE.
- Intelisense meerdere opties bekijken: CTRL-Space.
- Filteren: `... ... -filter ...`
- Parameters in een script komen bovenaan met `$...`
- Zet de parameters tussen `param(...)` zodat deze kunnen aangepast worden binnen de terminal in plaats van ze te moeten aanpassen binnen het script
- Strongly typen: `[..."[]"]` voor de parameter `$...` -> voorbeeld: `param([string[]]$ComputerName='localhost')`
- Mandatory parameters: `[Paramater(Mandatory=$True)] param( [string[]]$ComputerName='localhost' )` -> geldt enkel voor de eerst volgende paramater binnen het `param()` blok.
- Zelf uitleg toevoegen: bovenaan het script `#.Synopsis this is ... .Description this is ... .Example Diskinfo -ComputerName ... .Inputs ... .Outputs ... .Notes ...#` toevoegen.
- Functie maken: `function Get-diskinfo{[CmdletBinding()]  [Paramater(Mandatory=$True)] param( [string[]]$ComputerName='localhost' ) ...}`
- Script toch in memory laten bijhouden: in plaats van `.\...` doe `. .\...`
- Zelf gemaakte modules niet onder de map van Windows Modules plaatsen.