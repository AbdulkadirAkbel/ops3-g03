## Aantekeningen Boek en Opleiding Andy


### Chapter 1: Don't fear the shell


- Altijd als administrator uitvoeren anders kan je errors krijgen in verband met toegang die gewijgerd wordt.
- Commando's van zowel unix als windows kunnen gebruikt worden in powershell.
- meeste cmdlets zijn in de vorm werkwoord-naamwoord
- set-location, cd (directory veranderen)
- get-childitem, ls of dir (inhoud bekijken van een dir)
- clear, cls (scherm clearen)
- get-alias, gal (geeft alle aliassen met hun volledig cmdlet) 
- md andy, mkdir andy (map aanmaken)
- Programma's kan je ook gemakkelijk opstarten door simpelweg hun naam in te geven (bv. notepad, paint,..)
- De ping en ipconfig functionaliteit van cmd in volledig aanwezig in powershell
- gal g* (alle aliassen die beginnen met een g

### Chapter 2: The help system

- Er zijn duizenden cmdlets die je nooit allemaal vanbuiten kan leren, daarom is help gemakkelijk om cmdlets te ontdekken.
- Help system wordt regelmatig gëupdate.
- update-help -Force (help sytem updaten, hier heb je wel internet voor nodig)
- Get-help niet hetzelfde als help en man.
Get-help gaat meteen naar onderaan de help file en moet    je naar boven scrollen om de inhoud te bekijken.
Help en man tonen het begin van de help file, je kan naar onder gaan door op spatie te duwen.
- Je kan steeds gebruik maken van de wildcard *.
- Als je het help systeem gebruikt om naar cmdlets te zoekenmet bv. wildcards, krijg je per cmdlet de categorie, de module en een korte beschrijving.
- Om de korte help file van een cmdlet te bekijken geef je het commando get-help, help of man in, gevolgd door de naam van het cmdlet waar je de help file van wilt bekijken.
- get-verb geeft je alle werkwoorden waarmee je een cmdlet kan vormen.
- get-help get-service -detailed voor gedetailleerde help over een cmdlet.
- get-help get-service -Examples om voorbeelden te krijgen van het cmdlet.
- get-help get-service -Full om de volledige help file te bekijken.
- get-help get-service -Online om online de help file te bekijken met een mooie lay-out.
- get-help get-service -Showwindow opent een appart venster met daar de help file die je kan filteren.
- 







