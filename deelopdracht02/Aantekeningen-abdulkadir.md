## Aantekeningen Boek en Opleiding


### Don't fear the shell

- set-location c:\
- get-childitem OF dir OF ls
- clear OF cls (=clear screen)
- get-alias (geeft alle aliassen) (alias hiervoor: gal)
- md jason (maakt een map met de naam jason)
- mkdir jason doet hetzelfde
- help OF man
- Je kan ook programma's opstarten: notepad, calculator, mspaint
- ipconfig, ping


### The help system

- update-help -Force (downloadt alle helpbestanden die je nodig hebt op je systeem)
- get-help get-service (geeft een deel van de helppagina)
- help get-service geeft de volledige pagina
- get-help \*service\* (geeft alles waar service voorkomt)
- get-help get-service -Online (opent de helppagina online)
- get-help get-service -Example (voorbeelden)
- get-help get-service -ShowWindow (opent het in een venster) (handig om dingen te kopiëren)
- om te kopiëren in powershell: selecteren, rechts klikken, op de plaats waar je het wil plakken opnieuw rechts klikken
- een woord voorafgegaan door een koppelteken = parameter vb: -Name, -ComputerName </br> voorbeeld: get-service -Name bits (geeft de services met de naam bits)
- -name mag je weglaten </br> get-service -name bits = get-service bits
- alias voor get-service = gsv </br> vb: gsv bits
- 3 laatste errors weergeven: get-eventlog -logname system -newest 3 -entrytype error
- 3 laatste errors van 3 computers weergeven: get-eventlog -logname system -newest 3 -entrytype error -computername dc,s1,s2
- cls ; help about_eventlogs = doet 2 zaken in 1 keer


### The pipeline: getting connected & extending the shell

- pipeline = |
- pipeline stuurt de output voor de pipeline naar na de pipeline, zo kan je meerdere taken uitvoeren in 1 lijn
- vb: get-service -name bits (=toont de service) </br> get-service -name bits | stop-service (=toont en stopt de service)
- get-service | export-csv -path c:\service.csv
- get-process | export-clixml -path c:\good.xml
- get-service | out-file -filepath c:\test.txt
- get-content c:\test.txt
- get-service | ConvertTo-html -Property name,status | out-file c:\test.html
- -whatif (wat gaat er gebeuren als ik dit doe?)
- -confirm (powershell vraagt bevestiging voor de uitvoering)
- get-module (actieve modules)
- get-adcomputer -filter * (laadt de module ad automatisch op)
- 
