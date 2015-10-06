## Aantekeningen Boek en Opleiding Abdülkadir


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

### Objects for the Admin

- objecten vergemakkelijken je leven
- get-process | where handles -gt 900 (geeft de processen waarvan de handles goter is dan 900)
- get-process | where handles -gt 900 | sort handles (zelfde als hierboven, maar gesorteerd volgens handles)
- -get-member toont welke type object door de pipeline gaat 
- get-service -name bits | get-member (alias: gm)
- get-service | select -property name,status (geeft enkel de naam ens tatus van de services)
- voorbeeld: get-childitem | select -property name, length | sort -property length -descending
- alles waar er property in staat kan je gebruiken met select, sort...
- get-eventlog -logname system -newest 5 | select -property eventid, timewritten, message | sort -property timewritten | convertto-html | out-file c:error.html
- $x = [xml]\(cat .\bestand.xml) <br/> xml-bestand ophalen en in variabele x steken <br/> zo kan je in een xml-bestand gegevens opvragen: $x.PLAY.ACT[0].SCENE[0].SPEECH
- get-history
- $_ = huidig object in de pipeline
- get-service | where {$_.status -eq "Running}
- get-service | where {$_.status = "Running}
- get-service | where {$PSItem_.status = "Running} <br/> alle 3 zijn hetzelfde
- get-process (alias: gps)
- gps | where {$_.handles -ge 1000}

### The pipeline: deeper

- get-service | stop-service zal werken <br/>maar get-service | stop-process zal niet werken omdat niet de juiste parameter wordt doorgegeven
- get-adcomputer -filter * (geeft alle info van alle computers die in AD zitten)
- get-adcomputer -filter * | select -property name, @{name='ComputerName' ;expression={$_.name}} <br/>zet de property name om naar ComputerName <br/> korter: get-adcomputer -filter * | select -property name, @{n='ComputerName' ;e={$_.name}} 
- get-adcomputer -filter * | select -property @{n='ComputerName' ;e={$_.name}} | get-service -name bits
- get-wmiobject -class win32_bios (geeft bios info)
- get-wmiobject -class win32_bios -cumputername dc,s1,s2 (geeft bios info van computers dc,s1,s2)
- get-adcomputer -filter * | gm
- geen pipeline input mogelijk voor get-wmiobject -class win32_bios
- get-wmiobject -class win32_bios -computername (get-adcomputer -filter *) (wat tussen haakjes staat wordt eerst uitgevoerd, daarna wordt het meegegeven aan -computername)
- get-adcomputer -filter * | select -property name (type is adcomputer)
- get-adcomputer -filter * | select -expandproperty name (geeft geen titel, de type is ook string en geen adcomputer, dat bekom je na | gm)
- get-wmiobject -class win32_bios -computername (get-adcomputer -filter * | select -expandproperty name)
- korter: get-wmiobject -class win32_bios -computername (get-adcomputer -filter * ).name
- get-adcomputer -filter * | get-wmiobject -class win32_bios -computername {$_.name}