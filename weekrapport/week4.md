# Voortgangsrapport week nn

* Groep: 03
* Datum: 16/10/2015

| Student  | Aanw. | Opmerking |
| :---     | :---  | :---      |
| Abdülkadir |       |           |
| Anthony |       |           |
| Andy |       |           |
| Nicolai |       |           |

## Wat heb je deze week gerealiseerd?

### Algemeen

![kanban-bord](https://github.com/HoGentTIN/ops3-g03/blob/master/weekrapport/image/week4_kanban.PNG)

![toggl algemeen](https://github.com/HoGentTIN/ops3-g03/blob/master/weekrapport/image/week4_toggl_algemeen.PNG)



### Abdülkadir

* Powershell opleiding hoofdstukken 8 en 9 bekeken en notities genomen
* Boek powershell doorgenomen en notities genomen
* Collectd geprobeerd werkende te krijgen

![toggl abdulkadir](https://github.com/HoGentTIN/ops3-g03/blob/master/weekrapport/image/week4_toggl_abdulkadir.PNG)

### Andy

* Collectd afgewerkt
* Hoofdstuk 5 en 6 bekeken cursus windows powershell
* Verslag geschreven hoofdstuk 5 en 6 windows powershell
* Troubleshooting Collectd
* Boek gevonden powershell

![toggl andy](https://github.com/HoGentTIN/ops3-g03/blob/master/weekrapport/image/week4_toggl_andy.PNG)

### Nicolai

* ...

![toggl nicolai](https://github.com/HoGentTIN/ops3-g03/blob/master/weekrapport/image/week4_toggl_nicolai.PNG)

### Anthony

* ...

![toggl anthony](https://github.com/HoGentTIN/ops3-g03/blob/master/weekrapport/image/week4_toggl_anthony.PNG)

## Wat plan je volgende week te doen?

### Algemeen
### Abdülkadir
* Boek powershell uitlezen en aantekeningen maken
* Collectd volledig in orde brengen
* Load testing framework opzetten


### Andy
* Alle hoofdstukken van opleiding powershell afmaken
* Alle verslagen schrijven opleiding powershell
* Boek powershell beginnen lezen en aantekeningen maken
* Verder werken een CollectD (loadtesting)


### Nicolai
### Anthony

## Waar hebben jullie nog problemen mee?

* ...
* ...

## Feedback technisch luik

### Algemeen

Rapporten

* Bedankt voor het goed bijhouden van weekrapporten
* Tip: vervang in het sjabloon (en ook in dit document) *overal* "student x" door jullie namen!

Kanban-bord

* Tickets in de kolom Ready en verder zouden een Assignee moeten hebben: de verantwoordelijke voor het uitvoeren van deze taak.
* Gebruik een werkwoord in de naam van een issue om duidelijker te maken waar het over gaat. Bv. "load testing framework" -> wat houdt dit in? Info opzoeken? Een of meerdere selecteren? Testopstelling uitwerken? Tests uitvoeren?

Linux

* Testplan is zeer mager (zie [Issue #7](https://huboard.com/HoGentTIN/ops3-g03/#/issues/109443126))

Windows

* Blij om de neerslag van het lezen te zien
* Verslag van Anthony??
* Markdown-tips:
    * Zet code tussen backquotes om dit duidelijker in de verf te zetten, bv. `Get-Help Get-Process -full`
    * Blokken code kan je syntaxkleuren geven, bv. (zie broncode van dit document):

        ```PowerShell
        $modulePath = "$env:USERPROFILE\Documents\WindowsPowerShell\Modules\Hello"
        if(!(Test-Path $modulePath)) {
            New-Item -Path $modulePath -ItemType Directory
        }
        # Copy Hello.PSM1 to the new module folder.
        $modulePath = "$env:USERPROFILE\Documents\WindowsPowerShell\Modules\Hello"
        Copy-Item -Path Hello.PSM1 -Destination $modulePath
        ```
    * Let op indentatie en regeleindes. Ook in documentatie is correcte en leesbare code belangrijk!

### Abdülkadir
### Andy
### Nicolai
### Anthony

