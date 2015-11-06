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
|  	Scopes	     |  global, local, private or script       |  
|  	`$global:var = "var"`		     |  Assign global scoped variable       |   


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
| :---           | :---    |  
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

| Command |  Task	   | 
| :---           |  :---    |
|  	`If(){} Elseif(){ } Else{ }`		     |   if    |
|  	`while(){}`		     |     while    |
|  	`For($i=0; $i -lt 10; $i++){}`		     |    for  |    
|  	`Foreach($file in dir C:\){$file.name}`		     |foreach  |
|  	`1..10 | foreach{$_}`		     | foreach   |
|  	`Switch -options (<values to switch on>){PatternX {statement} Default {Default Statement} }`		     |  switch       | 

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

### Cmdlets

| Command | 
| :---           |   
|  	`Get-EventLog`		     |        
|  	`Get-WinEvent`		     |           
|  	`Get-Date`		     |             
|  	`Start-Sleep`		     |
|  	`Start-Job`		     |        
|  	`Compare-Object`		     |           
|  	`Get-Credential`		     |             
|  	`Test-Connection`		     | 
|  	`New-PSSession`		     |        
|  	`Test-Path`		     |           
|  	`Split-Path`		     |             
|  	`Get-ADUser`		     | 
|  	`Get-ADComputer`		     |        
|  	`Get-History`		     |           
|  	`Get-WMIObject`		     |             
|  	`New-ISESnippet`		     |  
|  	`Get-CimInstance`		     |          
|  	`Set-Location`		     |         
|  	`Get-Content`		     |           
|  	`Add-Content`		     |        
|  	`Set-Content`		     |        
|  	`Out-File`		     |         
|  	`Out-String`		     |           
|  	`Copy-Item`		     |         
|  	`Remove-Item`		     |         
|  	`Move-Item`		     |          
|  	`Set-Item`		     |              
|  	`New-Item`		     |  

### Arrays

| Command | Task	   | 
| :---           | :---    |  
|  	`$arr = "a", "b"`		     |   Array of strings      |  
|  	`$arr = @()`		     |   Empty array      |   
|  	`$arr[5]`		     |   Sixth array element      |     
|  	`$arr[-3..-1]`		     |   Last three array elements      | 
|  	`$arr[1,4+6..9]`		     | Elements at index 1,4, 6-9        |  
|  	`$arr[1] += 200`		     | Add to array item value        |   
|  	`$z = $arA + $arB`		     |  Two arrays into single array       |      

### Objects

| Command | Task	   | 
| :---           | :---    | 
|  	`[pscustomobject]@{x=1;z=2}`		     | Create custom object       | 
|  	`(Get-Date).Date`		     |  Date property of object from Get-Date       |  
|  	`Get-Date | Get-Member`		     |   List properties and methods of object      |   
|  	`[DateTime]::Now`		     |   Static properties referenced with "::"      |     
|  	`"string".ToUpper()`		     | Use ToUpper() method on string        | 
|  	`[system.Net.Dns]::GetHostByAddress("127.0.0.1")`		     |   Use static method to get hostname with "::"      |     
|  	`$excel = new-object -com excel.application`		     | Create a new Excel COM object to work with   |

### Writing output and reading input

| Command | Task	   | 
| :---           | :---    |  
|  	`"This displays a string"`		     |  String is written directly to output       |  
|  	`Write-Host "color" -ForegroundColor Red -NoNewLine`		     |   String with colors, no new line at end      |   
|  	`$age = Read-host "Please enter your age"`		     |   Set $age variable to input from user      |     
|  	`$pwd = Read-host "Please enter your password" -asSecureString`		     | Read in $pwd as secure string        |  
|  	`Clear-Host`		     |   Clear console      | 

### Automatic variables

| Command | Task	   | 
| :---           | :---    |  
|  	`$_, $PSItem`		     |  Current pipeline object       |  
|  	`$Args`		     |    Script or function arguments     |   
|  	`$Error`		     |   Errors from commands      |     
|  	`$True, $False`		     |   Boolean value for true, false      |
|  	`$null`		     |    Empty     |
|  	`$profile`		     |  Array of profile locations       | 

### Regular Expressions

| Command | Task	   | 
| :---           | :---    |  
|  	`\w`		     |   Any word character [a-zA-Z0-9]      |  
|  	`\W`		     |      Any non-word character   |   
|  	`\s`		     |     Any whitespace character    |     
|  	`\S`		     |    Any non-whitespace character     | 
|  	`\d \D`		     |     Any digit or non-digit    | 
|  	`{n} {n,} {n,m}`		     |   Match n through m instances of a pattern      | 

     

### Scripts

| Command | Task	   | 
| :---           | :---    |  
|  	`Set-ExecutionPolicy -ExecutionPolicy Bypass`		     |  Set execution policy to allow all scripts       |  
|  	`."\\c-is-ts-91\c$\scripts\script.ps1"`		     | Run Script.PS1 script in current scope        |   
|  	`&"\\c-is-ts-91\c$\scripts\script.ps1"`		     |  Run Script.PS1 script in script scope       |     
|  	`.\Script.ps1`		     | Run Script.ps1 script in script scope        | 
|  	`$profile`		     |   Your personal profile that runs at launch      | 
 


   
    