## PowerShell cheat sheet

| Command | Task	   | 
| :---           | :---    |  
|  	``		     |         |  
|  	``		     |         |   
|  	``		     |         |     
|  	``		     |         | 

### Basics

| Term | Task 	  | 
| :---      | :---    |  
|  	Cmdlet		|   Commands built into shell written in .NET      |  
|  	Functions		|    Commands written in PowerShell language     |   
|  	Parameter		|  Argument to a Cmdlet/Function/Script       |     
|  	Alias		| Shortcut for a Cmdlet or Function        | 
|  	Scripts		|   Text files with .ps1 extension      |  
|  	Applications		|  Existing windows programs       |   
|  	Pipelines		|  Pass objects Get-process word `|` Stop-Process       |     
|  	Ctrl+c		|   Interrupt current command      | 
|  	Left/right		|   Navigate editing cursor      |  
|  	Ctrl+left/right		|  Navigate a word at a time       |   
|  	Home / End		|  Move to start / end of line       |     
|  	Up/down		|  Move up and down through history       | 
|  	Insert		|  Toggles between insert/overwrite mode       |  
|  	F7		|   Command history in a window      |   
|  	Tab / Shift-Tab		|  Command line completion       |  
   

### Help

| Command  | Task	   | 
| :---           | :---    |  
|  	`Get-Command`		     |   Get all commands      |  
|  	`Get-Command -Module RGHS`		     |   Get all commands in RGHS module      |   
|  	`Get-Command Get-p*`		     |  Get all commands starting with get-p       |     
|  	`Get-help get-process`		     | Get help for command        | 
|  	`Get-Process | Get-Member`		     |  Get members of the object       |     
|  	`Get-Process| format-list -properties *`		     |  Get-Process as list with all properties       | 

### Variables

| Command | Task	   | 
| :---           | :---    |  
|  	`$var = "string"`		     |  Assign variable       |  
|  	`$a,$b = 0 or $a,$b = 'a','b'`		     |   Assign multiple variables      |   
|  	`$a,$b = $b,$a`		     |   Flip variables      |     
|  	`$var=[int]5`		     |   Strongly typed variable      | 

### Assignment, Logical, Comparison Operators

| Command  | Task	   | 
| :---           | :---    |  
|  	`=,+=,-=,++,--`		     |  Assign values to variable       |  
|  	`-and,-or,-not,!`		     |  Connect expressions / statements       |   
|  	`-eq, -ne`		     | Equal, not equal        |     
|  	`-gt, -ge`		     | Greater than, greater than or equal        | 
|  	`-lt, -le`		     |  Less than, less than or equal       |  
|  	`-replace`		     |  “Hi” -replace “H”, “P”       |   
|  	`-match,-notmatch`		     |  Regular expression match       |     
|  	`-like,-notlike`		     |  Wildcard matching       | 
|  	`-contains,-notcontains`		     |  Check if value in array       |  
|  	`-in, -notin`		     |  Reverse of contains,notcontains.       |

### Parameters
  
| Command  | Task	   |  
|  	`-Confirm`		     | Prompt whether to take action        |     
|  	`-WhatIf`		     |   Displays what command would do      | 

### Importing, Exporting, Converting

| Command  | Command	   | 
| :---           | :---    |  
|  	`Export-CliXML`		     |   `Import-CliXML`      |  
|  	`ConvertTo-XML`		     |   `ConvertTo-HTML`      |   
|  	`Export-CSV`		     |   `Import-CSV`     |     
|  	`ConvertTo-CSV`		     |    `ConvertFrom-CSV`     | 

### Flow Control

| Command |  
| :---           |  
|  	`If(){} Elseif(){ } Else{ }`		     |       
|  	`while(){}`		     |         
|  	`For($i=0; $i -lt 10; $i++){}`		     |          
|  	`Foreach($file in dir C:\){$file.name}`		     |  
|  	`1..10 | foreach{$_}`		     |    

### Comments, Escape Characters

| Command | Task	   | 
| :---           | :---    |  
|  	`#Comment`		     |   Comment      |  
|  	`<#comment#>`		     |  Multiline Comment       |   
|  	`" 		     |     Escape char     |     
|  	`t		     |  Tab       | 
|  	`n	     |   New line      |
|  	`	     |   Line continue      |

###  Aliases for common commands

| Command | Task	   | 
| :---           | :---    |  
|  	`Gcm`		     |   `Get-Command`      |  
|  	`Foreach,%`		     |    `Foreach-Object`     |   
|  	`Sort`		     |    `Sort-Object`     |     
|  	`Where,?`		     |    `Where-Object`     | 
|  	`Diff,compare`		     |    `Compare-Object`     | 
|  	`Dir, ls, gci`		     |   `Get-ChildItem`      |  
|  	`Gi`		     |    `Get-Item`     |   
|  	`Copy,cp,cpi`		     |    `Copy-Item`     |     
|  	`Move,mv,mi`		     |    `Move-Item`     | 
|  	`Del,rm`		     |    `Remove-Item`     | 
|  	`Rni,ren`		     |   `Rename-Item`      |  
|  	`Ft`		     |    `Format-Table`     |   
|  	`Fl`		     |    `Format-List`     |     
|  	`Gcim`		     |    `Get-CimInstance`     | 
|  	`Cat,gc,type`		     |    `Get-Content`     | 
|  	`Sc`		     |   `Set-Content`      |  
|  	`h,history,ghy`		     |    `Get-History`     |   
|  	`Ihy,r`		     |    `Invoke-History`     |     
|  	`Gp`		     |    `Get-ItemProperty`     | 
|  	`Sp`		     |    `Set-ItemProperty`     | 
|  	`Pwd,gl`		     |   `Get-Location`      |  
|  	`Gm`		     |    `Get-Member`     |   
|  	`Sls`		     |    `Select-String`     |     
|  	`Cd,chdir,sl`		     |    `Set-Location`     | 
|  	`Cls,clear`		     |    `Clear-Host`     | 