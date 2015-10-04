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

- Er zijn duizenden cmdlets die je nooit allemaal vanbuiten kan leren, daarom is help gemakkelijk om cmdlets te ontdekken.
- Help system wordt regelmatig gëupdate.
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

-






