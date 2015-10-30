## Aantekeningen Boek en Opleiding Andy


### Chapter 1: Don't fear the shell


- Altijd als administrator uitvoeren anders kan je errors krijgen in verband met toegang die gewijgerd wordt.
- Commando's van zowel unix als windows kunnen gebruikt worden in powershell.
- Meeste cmdlets zijn in de vorm werkwoord-naamwoord
- 'Set-location', 'cd' (directory veranderen)
- 'Get-childitem', 'ls' of 'dir' (inhoud bekijken van een dir)
- 'Clear', 'cls' (scherm clearen)
- 'Get-alias', 'gal' (geeft alle aliassen met hun volledig cmdlet) 
- 'Md andy', 'mkdir andy' (map aanmaken)
- Programma's kan je ook gemakkelijk opstarten door simpelweg hun naam in te geven (bv. notepad, paint,..)
- De ping en ipconfig functionaliteit van cmd in volledig aanwezig in powershell
- 'Gal g*' (alle aliassen die beginnen met een g

### Chapter 2: The help system

- Er zijn duizenden cmdlets die je nooit allemaal van buiten kan leren, daarom is help gemakkelijk om cmdlets te ontdekken.
- Help system wordt regelmatig geüpdate.
- 'update-help -Force' (help sytem updaten, hier heb je wel internet voor nodig)
- 'Get-help' niet hetzelfde als 'help' en 'man'.
Get-help gaat meteen naar onderaan de help file en moet je naar boven scrollen om de inhoud te bekijken.
Help en man tonen het begin van de help file, je kan naar onder gaan door op spatie te duwen.
- Je kan steeds gebruik maken van de wildcard '*'.
- Als je het help systeem gebruikt om naar cmdlets te zoekenmet bv. wildcards, krijg je per cmdlet de categorie, de module en een korte beschrijving.
- Om de korte help file van een cmdlet te bekijken geef je het commando get-help, help of man in, gevolgd door de naam van het cmdlet waar je de help file van wilt bekijken.
- 'Get-verb' geeft je alle werkwoorden waarmee je een cmdlet kan vormen.
- 'Get-help get-service -detailed' voor gedetailleerde help over een cmdlet.
- 'Get-help get-service -Examples' om voorbeelden te krijgen van het cmdlet.
- 'Get-help get-service -Full' om de volledige help file te bekijken.
- 'Get-help get-service -Online' om online de help file te bekijken met een mooie lay-out.
- 'Get-help get-service -Showwindow' opent een appart venster met daar de help file die je kan filteren.
- Copy en paste in de shell gebeurd met de rechtermuisknop.
- 'get-service -DisplayName bit*' geeft de mogelijk cmdlets met als displayname bit...
- 'Get-service -name bits' kan ingekort worden tot 'gsv bits'.
- Tab toets kan je gebruiken om je commando's automatisch aan te vullen.
- Je kan meerdere commando's tegelijk uitvoeren door ze te scheiden met een ';'.

### Chapter 3: The pipeline: getting connected & extending the shell

- Pipeline is heel krachtig dus wees voorzichtig welke commando's je uitvoerd.
- Pipeline vraagt geen confirmatie, de commando's worden meteen uitgevoerd
- Een pipline teken bekom je om mac door shift + alt + l.
- 'Get-service | export-csv -Path c:\service.csv' exporteert de 'Get-service' inhoud naar een file 'service.csv' op de C schijf.
- 'Notepad c:\service.csv' opent het bestand in notepad.
- 'Import c:\service.csv' importeert het bestand naar powershell en geeft het weer.
- 'Get-process | export-clixml -Path c:\good.xml' exporteert alle processen van een pc naar een file 'good.xml' op de C schijf.
- 'Compare-Object -ReferenceObject (import-clixml c:\good.xml) -Diffrence (Get-Process) – Property name' vergelijkt de processenlijst van de good.xml met de processenlijst van de pc die nu draait. Zo kan je gemakkelijk zien of een pc verdachte programma's draait. De dingen tussen '()' worden eerst uitgevoerd.
- 'ConvertTo-Html' zet de gegevens om naar een html file.
- '-WhatIf' parameter toont wat er zou gebeuren moest je het commando uitvoeren.
- '-Confirm' parameter vraagt om confirmatie voor elke lijn dat het commando wilt uitvoeren. Bijvoorbeeld per process dat gestopt wordt.
- 'Get-Service | stop-service' stopt alle services.
- Commando's om specifieke programma's te beheren, worden met behulp van modules meegelverd met het desbetrefende programma. De modules bevatten cmdlets die het programma kunnen beheren of aanpassen. Een voorbeeld van zo een programma is Active Directory.
- 'Get-Module' toont de modules die beschikbaar zijn. Dit is niet van toepassing bij powershell v2 en Windows 7.
- 'Import-Module ...' importeert de gedefinieerde module.

### Chapter 4: Objects for the Admin

- 'get-process |where -gt 900' geeft alles processen met Handles kleiner dan 900.
- 'get-process |where -gt 900 |sort handles' doet hetzelfde dan vorig commando, maar sorteert nog eens op Handles.
- 'get-service -name bits | get-member(gm)' geeft de members van service bits weer.
- 'get-service | Select -Property name,status' selecteert de properties name en status van get-service.
- 'get-childitem | Select -Prorperty name, length | sort -Property length -Descending' 
- 'get-eventlog -Logname System -Newest 5 | Select -Property EventId, TimeWritten, Message | sort -Property timewritten | ConvertTo-html | out-file c:\error.htm' dingen selecteren, sorteren, opslaan in html file.
- '$x = xml(cat .\r_and_j.xml)' plaatst xml file in object $x. 'xml' moet tussen [].
- '$x' Geeft de inhoud weer van de xml file van vorig commando.
- '$x.gettype()' dan krijg je het type van $x.
- '$x.PLAY'geeft de verschillende onderdelen van het xml bestand weer.
- '$x.PLAY.ACT' geeft de verschillende onderdelen van ACT weer.
- '$x.PLAY.ACT[0]' geeft de eerste act weer.
- '$x.PLAY.ACT.SCENE.SPEECH |group speaker |sort count' geeft alle rollen weer met hun aantal zinnen dat ze moeten zeggen.
- 'get-history' geef de geschiedenis van de commando's weer die je getypt heb.
- 'get-service | where -FilterScript {$_.status -eq "Running"}' filtert op status = Running. '-FilterScript' mag weggelaten worden.
- '$_' is het object dat nu de pipeline kruist.
- '-eq' = equals.
- 'get-stuff | where -somestuff | sort|  out-file' het maakt uit dat je pas sorteert na je de where hebt gebruikt. Het is veel perfomanter.
- 'gps |where {$_.handles -ge 1000}' '-ge' staat voor greater than.

### Chapter 5: The pipeline: deeper

- 'get-process calc | dir' geeft het pad weer van calc.
- 'Get -AdComputer -filter *' geft alle ad computer weer 
- 'Get-adcomputer -filter * | Select -Property name, @{name='ComputerName';expression={$_.name}}' maak een nieuwe property ComputerName aan die gelijkaardig is aan name.
- Get-adcomputer -filter * | Select -Property name, @{name='ComputerName';expression={$_.name}} | Get-service -name bits'
- 'get-wmiobject -Class win32 -Computername dc,s1,..' geeft gegevens van de opgegeven computernamen
- 'Get-ADComputer -filter * | Get-WmiObject -class win32_bios'
- Gebruik help om te kijken of iets een pipeline input ondersteund.
- 'Get-WmiObject -class win32_bios -ComputerName (Get-Adcomputer -filter *)' tussen haakjes moet eerst uitgevoerd worden.
- 'getADComputer -filter * | Select -Property name' geeft alleen naam weer
- 'getADComputer -filter * | Select -ExpandProperty name' geeft alleen de namen weer zonder een titel.
- 'Get-WmiObject -class win32_bios -ComputerName (Get-Adcomputer -filter * | Select -ExpandProperty name)' of in PS V3: 'Get-WmiObject -class win32_bios -ComputerName (Get-Adcomputer -filter * ).name' of nog korter 'Get-ADComputer -filter * |get-wmiobject win32_bios -ComputerName {$_.Name}'
- 'Get-help Get-CimInstance' is zelfde dan WmiObject maar ondersteund wel pipeline input.

### Chapter 6: The PowerShell in the shell: remoting

- Eerst moet je PowerShell Remoting activeren: Group Policy Management Editor -> Computer Configuration/Policies/Administrative -> Templates/Windows -> Components/Windows Remote Management <br/> Op Windows Server 2012 is het standaard geactiveerd.
- 'enter-pssession -computername dc' opent een powershell sessie op de domain controller.
- 'invoke-command -computername dc,s1,s2 {get-eventlog -logname system -new 3}' voert commando's uit op de meegegeven pc's. 
- 'invoke-command -computername dc,s1,s2 {restart-computer}' herstart de opgegeven computers.
- 'invoke-command {get-service -name bits}' runt het commando op de lokale host.
- 'enter-pssession pwa' start een ps sessie op pwa.
-  '[pwa]: get-windowsfeature' toont een lijst van alle rollen en features, er staat een x als een rol of feature geïnstalleerd is.
-  '[pwa]: get-windowsfeature \*powershell\*' 
-  '[pwa]: install-windowsfeature windowspowershellwebaccess' installeerd de feature.
-  '[pwa]: get-help \*pswa\*' geeft de nieuwe cmdlets weer van de webaccess.
-  '[pwa]: install-pswebapplication -usertestcertification' nu kan je powershell gebruiken van in de browser.
-  '[pwa]: add-pswaauthorizationrule * * *' aan iedereen alle rechten.
-  'start iexplore https://pwa/pswa' start de powershell in een browser.
-  'invoke-command -computername dc,s1,s2 {get-eventlog -logname system -new 3} | sort timewritten | format-table -property timewritten, message -autosize'
-  'icm dc,s1,s2 {get-volume} | sort sizeremaining' invoke.
-  Om een commando als script op te slaan, sla je het in notepad op met de extentie '.ps1'.
