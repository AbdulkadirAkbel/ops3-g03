# Windows Server 2012 Automation with PowerShell Cookbook
## Abdülkadir Akbel

## Understanding PowerShell Scripting

**Security**:  To find the system's current execution policy, open PowerShell and execute

    Get-ExecutionPolicy

To change the system's execution policy, run

     Set-ExecutionPolicy <policy name> 

To reset the execution policy to the system default, set the policy to Undefined:

    Set-ExecutionPolicy Undefined

To change the execution policy for a specific session, go to Start | Run and enter
PowerShell.exe –ExecutionPolicy policyname.



- Restricted: No scripts are executed. This is the default setting.
- AllSigned: This policy allows scripts signed by a trusted publisher to run.
- RemoteSigned: This policy requires remote scripts to be signed by a trusted publisher.
- Unrestricted: This policy allows all scripts to run. It will still prompt for
confirmation for files downloaded from the internet.
- Bypass: This policy allows all scripts to run and will not prompt.
- Undefined: This policy resets the policy to the default.

**Functions**: the number of days until Christmas.

    Function Get-DaysTilChristmas
    {
    <#
    .Synopsis
    This function calculates the number of days until Christmas
    .Description
    This function calculates the number of days until Christmas
    .Example
    DaysTilChristmas
    .Notes
    Ed is really awesome
    .Link
    Http://blog.edgoad.com
    #>
    $Christmas=Get-Date("25 Dec " + (Get-Date).Year.ToString() + "
    7:00 AM")
    $Today = (Get-Date)
    $TimeTilChristmas = $Christmas - $Today
    Write-Host $TimeTilChristmas.Days "Days 'til Christmas"
    }

**Creating and using modules**

1. Create several functions that can be logically grouped together.

        Function Get-Hello
    	{    
    	Write-Host "Hello World!"
    	}
    	Function Get-Hello2
    	{
    	Param($name)
    	Write-Host "Hello $name"
    	}

2. Using the PowerShell ISE or a text editor, save the functions into a single file
name Hello.PSM1.
3. If the folder for the module doesn't exist yet, create the folder.

    	$modulePath = "$env:USERPROFILE\Documents\WindowsPowerShell\
    	Modules\Hello"
    	if(!(Test-Path $modulePath))
    	{
    	New-Item -Path $modulePath -ItemType Directory
    	}

4. Copy Hello.PSM1 to the new module folder.

    	$modulePath = "$env:USERPROFILE\Documents\WindowsPowerShell\
		Modules\Hello"
		Copy-Item -Path Hello.PSM1 -Destination $modulePath

5. In a PowerShell console, `execute Get-Module –ListAvailable` to list all
the available modules.
6. Run `Import-Module Hello` to import our new module.
7. Run `Get-Command –Module Hello` to list the functions included in the module.

**Passing variables to functions**

    Function Add-Numbers
    {
    Param(
    [int]$FirstNum = $(Throw "You must supply at least 1 number")
    , [int]$SecondNum = $FirstNum
    )
    Write-Host ($FirstNum + $SecondNum)
    }

[] = type op the var<br/>
$ = name of the var

    Add-Numbers 7 5
    Add-Numbers -FirstNum 7 -SecondNum 5

Assigning the output to a variable:

    $foo = Add-Numbers 7 5

Create a function to validate the input as a phone number:

    Function Test-PhoneNumber
    {
    param([ValidatePattern("\d{3}-\d{4}")] $phoneNumber)
    Write-Host "$phoneNumber is a valid number"
    }

another example

    Function Test-PhoneNumberReg
    {
    param($phoneNumber)
    $regString=[regex]"^\d{3}-\d{3}-\d{4}$|^\d{3}-\d{4}$"
    if($phoneNumber -match $regString){
    Write-Host "$phoneNumber is a valid number"
    } else {
    Write-Host "$phoneNumber is not a valid number"
    }
    }

**Piping data to functions**

    Function Square-Num
    {
    Param([float]
    [Parameter(ValueFromPipeline = $true)]
    $FirstNum )
    Write-Host ($FirstNum * $FirstNum)
    }

parameter: ValueFromPipeline

run as:

    5 | Square-Num

**Recording sessions with transcripts**

    Start-Transcript -Path C:\Gebruikers\Abdulkadir\Documenten
    Stop-Transcript

**Signing PowerShell scripts**

Signing scripts ensures the script is from a trusted source and ensures the script hasn't been altered since it was signed.

1. Create and test a PowerShell script.
2. Sign the script with Set-AuthenticodeSignature.

    	$cert = Get-ChildItem Cert:CurrentUser\My\ -CodeSigningCert
    	Set-AuthenticodeSignature C:\temp\ServerInfo.ps1 $cert

**Sending e-mail**

1. Open PowerShell and load the following function:

    	function Send-SMTPmail($to, $from, $subject, $smtpServer, $body)
    	{
    	$mailer = new-object Net.Mail.SMTPclient($smtpServer)
    	$msg = new-object Net.Mail.MailMessage($from, $to, $subject,
    	$body)
    	$msg.IsBodyHTML = $true
    	$mailer.send($msg)
    	}

2. To send the mail message, call the following function:

    	Send-SMTPmail -to "admin@contoso.com" -from "mailer@contoso.com" `
    	-subject "test email" -smtpserver "mail.contoso.com" -body
    	"testing"

3. To send e-mail using the included PowerShell Cmdlet.
4. Use the Send-MailMessage command as shown:

    	Send-MailMessage -To admin@contoso.com -Subject "test email" `
    	-Body "this is a test" -SmtpServer mail.contoso.com `
    	-From mailer@contoso.com

**Sorting and filtering**

Filtering:
    
    Get-Process | Where-Object {$_.Name -eq "chrome"}
    Get-Process | Where-Object Name -eq "chrome"
    Get-Process | Where-Object Name -like "*hrom*"
    Get-Process | Where-Object Name -ne "chrome"
    Get-Process | Where-Object Handles -gt 1000

Sorting:

    Get-Process | Sort-Object Handles
    Get-Process | Sort-Object Handles -Descending
    Get-Process | Sort-Object Handles, ID –Descending

Selecting:

    Select-String -Path C:\Windows\WindowsUpdate.log -Pattern
    "Installing updates"
    Get-Process | Select-Object Name -Unique

Grouping:

    Get-Process | Format-Table -GroupBy ProcessName

Formatting numbers:

    $jenny = 1206867.5309
    Write-Host "Original:`t`t`t" $jenny
    Write-Host "Whole Number:`t`t" ("{0:N0}" -f $jenny)
    Write-Host "3 decimal places:`t" ("{0:N3}" -f $jenny)
    Write-Host "Currency:`t`t`t" ("{0:C2}" -f $jenny)
    Write-Host "Percentage:`t`t`t" ("{0:P2}" -f $jenny)
    Write-Host "Scientific:`t`t`t" ("{0:E2}" -f $jenny)
    Write-Host "Fixed Point:`t`t" ("{0:F5}" -f $jenny)
    Write-Host "Decimal:`t`t`t" ("{0:D8}" -f [int]$jenny)
    Write-Host "HEX:`t`t`t`t" ("{0:X0}" -f [int]$jenny)

**Dealing with errors in PowerShell**: 2 numbers are correct, if you give a string in -> error message via catch

    Function Multiply-Numbers
    {
    Param($FirstNum, $SecNum)
    Try
    {
    Write-Host ($FirstNum * $SecNum)
    }
    Catch
    {
    Write-Host "Error in function, present two numbers to
    multiply"
    }
    }

**Performance**: how fast does a method perform?

    Measure-Command { commands }

## Managing Windows Network Services with PowerShell

**Configuring static networking**

1: Get interfaces:

	Get-NetIPInterface

2: Set IP:

	New-NetIPAddress -AddressFamily IPv4 -IPAddress 10.10.10.10 -PrefixLength 24 -InterfaceAlias Ethernet

3: Set DNS:

	Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddresses "10.10.10.10","10.10.10.11"

4: Set default route:

	New-NetRoute -DestinationPrefix "0.0.0.0/0" -NextHop "10.10.10.1" -InterfaceAlias Ethernet

   Result:<br>
   Use the following IP address:<br>
   - IP Address: 10.10.10.11<br>
   - Subnet mask: 255.255.255.0<br>
   - Default gateway: 10.10.10.1<br>
   Use the following DNS server addresses:<br>
   - Preferred DNS: 10.10.10.10<br>
   - Alternate DNS: 10.10.10.11<br>

**Installing domain controllers**

1. As an administrator, open a PowerShell.
2. Identify the Windows Features to install:

    	Get-WindowsFeature | Where-Object Name -like *domain*
    	Get-WindowsFeature | Where-Object Name -like *dns*

3. Install the necessary features:

		Install-WindowsFeature AD-Domain-Services, DNS –IncludeManagementTools

4. Configure the domain:

		$SMPass = ConvertTo-SecureString 'P@$$w0rd11' –AsPlainText -Force
		Install-ADDSForest -DomainName corp.contoso.com –
		SafeModeAdministratorPassword $SMPass –Confirm:$false

5. Joining a computer to domain:

		$secString = ConvertTo-SecureString 'P@$$w0rd11' -AsPlainText
		-Force
		$myCred = New-Object -TypeName PSCredential -ArgumentList "corp\
		administrator", $secString
		Add-Computer -DomainName "corp.contoso.com" -Credential $myCred –
		NewName "CORPDC2" –Restart

6. Once a computer has been joined to the domain, promoting the system to a DC
can be performed remotely using PowerShell:

    	Install-WindowsFeature –Name AD-Domain-Services, DNS
    	-IncludeManagementTools –ComputerName CORPDC2
    	Invoke-Command –ComputerName CORPDC2 –ScriptBlock {
    	$secPass = ConvertTo-SecureString 'P@$$w0rd11' -AsPlainText –Force
    	$myCred = New-Object -TypeName PSCredential -ArgumentList "corp\
    	administrator", $secPass
    	$SMPass = ConvertTo-SecureString 'P@$$w0rd11' –AsPlainText –Force
    	Install-ADDSDomainController -DomainName corp.contoso.com –
    	SafeModeAdministratorPassword $SMPass -Credential $myCred –
    	Confirm:$false
    	}

**Configuring zones in DNS**

1. Identify features to install:

		Get-WindowsFeature | Where-Object Name -like *dns*

2. Install DNS feature and tools (if not already installed):

		Install-WindowsFeature

3. Create a reverse lookup zone:

		Add-DnsServerPrimaryZone –Name 10.10.10.in-addr.arpa –
		ReplicationScope Forest
		Add-DnsServerPrimaryZone –Name 20.168.192.in-addr.arpa –
		ReplicationScope Forest

4. Create a primary zone and add static records:

    	Add-DnsServerPrimaryZone –Name contoso.com –ZoneFile contoso.com.
		dns
		Add-DnsServerResourceRecordA –ZoneName contoso.com –Name www –
		IPv4Address 192.168.20.54 –CreatePtr

5. Create a conditional forwarder:

		Add-DnsServerConditionalForwarderZone -Name fabrikam.com
		-MasterServers 192.168.99.1

6. Create a secondary zone:

		Add-DnsServerSecondaryZone -Name corp.adatum.com -ZoneFile corp.
		adatum.com.dns -MasterServers 192.168.1.1

Listing all zones

    Get-DnsServerZone

**Configuring DHCP scopes**

1. Install DHCP and management tools:

		Get-WindowsFeature | Where-Object Name -like *dhcp*
		Install-WindowsFeature DHCP -IncludeManagementTools

2. Create a DHCP scope

		Add-DhcpServerv4Scope -Name "Corpnet" -StartRange 10.10.10.100
		-EndRange 10.10.10.200 -SubnetMask 255.255.255.0


3. Set DHCP options

		Set-DhcpServerv4OptionValue -DnsDomain corp.contoso.com -DnsServer
		10.10.10.10 -Router 10.10.10.1


4. Activate DHCP

		Add-DhcpServerInDC -DnsName corpdc1.corp.contoso.com

Adding DHCP reservations:

    Add-dhcpserverv4reservation –scopeid 10.10.10.0 –ipaddress
    10.10.10.102 –name test2 –description "Test server" –clientid 12-
    34-56-78-90-12
    Get-dhcpserverv4reservation –scopeid 10.10.10.0

Adding DHCP exclusions:

    Add-DhcpServerv4ExclusionRange –ScopeId 10.10.10.0 –StartRange
	10.10.10.110 –EndRange 10.10.10.111
	Get-DhcpServerv4ExclusionRange

**Building out a PKI environment**

1. Install certificate server:

		Get-WindowsFeature | Where-Object Name -Like *cert*
		Install-WindowsFeature AD-Certificate -IncludeManagementTools
		-IncludeAllSubFeature

2. Configure the server as an enterprise CA:

		Install-AdcsCertificationAuthority -CACommonName corp.contoso.com
		-CAType EnterpriseRootCA -Confirm:$false

3. Install root certificate to trusted root certification authorities store:

		Certutil –pulse

4. Request machine certificate from CA:

	    Set-CertificateAutoEnrollmentPolicy -PolicyState Enabled -Context
	    Machine -EnableTemplateCheck

**Creating AD users**

1 user:

    New-ADUser -Name JSmith

multiple users:

    Function Create-Users{
    param($fileName, $emailDomain, $userPass, $numAccounts=10)
    if($fileName -eq $null ){
    [array]$users = $null
    for($i=0; $i -lt $numAccounts; $i++){
    $users += [PSCustomObject]@{
    FirstName = 'Random'
    LastName = 'User' + $i
    }
    }
    } else {
    $users = Import-Csv -Path $fileName
    }
    ForEach($user in $users)
    {
    $password = ''
    if($userPass)
    {
    $password = $userPass
    } else {
    $password = Get-RandomPass
    }
    Create-User -firstName $user.FirstName `
    -lastName $user.LastName -emailDomain $emailDomain `
    -password $password
    }
    }
    Function Create-User
    {
    param($firstName, $lastName, $emailDomain, $password)
    $accountName = '{0}.{1}' -f $firstName, $lastName
    $emailAddr = '{0}@{1}' -f $accountName, $emailDomain
    $securePass = ConvertTo-SecureString $password -AsPlainText
    -Force
    New-ADUser -Name $accountName -AccountPassword $securePass `
    -ChangePasswordAtLogon $true -EmailAddress $emailAddr `
    -Displayname "$FirstName $Lastname" -GivenName $Firstname `
    -Surname $LastName -Enabled $true
    Write-Host "$LastName,$FirstName,$AccountName,$emailAddr,$pass
    word"
    }
    function Get-RandomPass{
    $newPass = ''
    1..10 | ForEach-Object {
    $newPass += [char](Get-Random -Minimum 48 -Maximum 122)
    }
    return $newPass
    }

own script made in Projecten2 last year (creates also OU's en puts the users in the correct OU) (from a csv file):

	Import-Module ActiveDirectory
    
    $ADUsers = Import-Csv werknemers.csv
    
    if ([ADSI]::Exists("LDAP://OU=Technical,DC=Projecten2,DC=be") -eq $false) {
    	New-ADOrganizationalUnit -Name Technical -ProtectedFromAccidentalDeletion $false
    }
    
    if ([ADSI]::Exists("LDAP://OU=HR,DC=Projecten2,DC=be") -eq $false) {
    	New-ADOrganizationalUnit -Name HR -ProtectedFromAccidentalDeletion $false
    }
    
    if ([ADSI]::Exists("LDAP://OU=Sales,DC=Projecten2,DC=be") -eq $false) {
    	New-ADOrganizationalUnit -Name Sales -ProtectedFromAccidentalDeletion $false
    }
    
    
    foreach ($User in $ADUsers)
    {
    	$Name = $User.GivenName + " " + $User.Surname
    	$OU = $User.ParentOU
    	$Username = $User.GivenName.Substring(0,2) + $User.Surname.Substring(0,3) + $User.Number
    	$City = $User.City
    	$Title = $User.Title
    	$GivenName = $User.GivenName
    	$Surname = $User.Surname
    	$StreetAddress = $User.StreetAddress
    	$Postcode = $User.Postcode
    	$Country = $User.Country
    	$Telefoon = $User.Telefoon
    	$Gender = $User.Gender
    	$Birthday = $User.Birthday
    	$CountryFull = $User.CountryFull
    	
    if (Get-ADUser -F {SamAccountName -eq $Username})
    {
    	Write-Warning "A user with $Username already exists in your Active Directory."
    
    }
    else
    {
    	New-ADUser -SamAccountName $Username -Name $Name -Path $OU -City $City -Title $Title -GivenName $GivenName -Surname $Surname -StreetAddress $StreetAddress -PostalCode $Postcode -Country $Country -MobilePhone $Telefoon -AccountPassword (ConvertTo-SecureString "Projecten2" -AsPlainText -Force) -Description "Gender: $Gender, birthday: $Birthday, country: $CountryFull" -ScriptPath logon.vbs -PassThru | Enable-ADAccount
    }
    
    	Get-ADUser -Filter * -SearchBase "OU=HR,DC=Projecten2,DC=be" | Set-ADUser -CannotChangePassword:$false -PasswordNeverExpires:$false -ChangePasswordAtLogon:$True
    	Get-ADUser -Filter * -SearchBase "OU=Sales,DC=Projecten2,DC=be" | Set-ADUser -CannotChangePassword:$false -PasswordNeverExpires:$false -ChangePasswordAtLogon:$True
    	Get-ADUser -Filter * -SearchBase "OU=Technical,DC=Projecten2,DC=be" | Set-ADUser -CannotChangePassword:$false -PasswordNeverExpires:$false -ChangePasswordAtLogon:$True
    }

**Searching for and reporting on AD users**

To report on all users and their logon scripts execute the following code:

    Get-ADUser -Filter * -Properties SamAccountName, DisplayName, `
    ProfilePath, ScriptPath | `
    Select-Object SamAccountName, DisplayName, ProfilePath, ScriptPath

To find all disabled user accounts execute the following code:

    Get-ADUser –Filter 'Enabled -eq $false'

To find users who haven't logged in for 30 days execute the following code:

    $logonDate = (Get-Date).AddDays(-30)
    Get-ADUser -Filter 'LastLogonDate -lt $logonDate' | Select-Object
    DistinguishedName

To find accounts with multiple logon failures execute the following code:

    $primaryDC = Get-ADDomainController -Discover -Service PrimaryDC
    Get-ADUser -Filter 'badpwdcount -ge 5' -Server $primaryDC.Name `
    -Properties BadPwdCount | Select-Object DistinguishedName,
    BadPwdCount

**Finding expired computers in AD**

To find recently aged accounts execute the following code:

    $30Days = (Get-Date).AddDays(-30)
    Get-ADComputer -Properties lastLogonDate -Filter 'lastLogonDate
    -lt $30Days' | Format-Table Name, LastLogonDate

To find older accounts execute the following code:

    $60Days = (Get-Date).AddDays(-60)
    Get-ADComputer -Properties lastLogonDate -Filter 'lastLogonDate
    -lt $60Days' | Format-Table Name, LastLogonDate

## Managing Storage with PowerShell

**Editing the permissions on an Excel spreadsheet**

Read the permissions file and save them into a variable called $acl:

    $acl = Get-Acl M:\Sales\goals.xls

Create new FileSystemAccessRule for the new user with the
appropriate permissions:

    $ace = New-Object System.Security.AccessControl.
    FileSystemAccessRule "joe.smith","FullControl","Allow"

Append the permissions:

    $acl.SetAccessRule($ace)

Apply the permissions to the file:

    $acl | Set-Acl M:\Sales\goals.xls

**Cloning permissions for a new folder**

Open PowerShell and create the new folder

    New-Item M:\Marketing2 -ItemType Directory

Get the existing folder permissions

    $SrcAcl = Get-Acl M:\Marketing

Set the new permissions

    Set-Acl -Path M:\Marketing2 $SrcAcl

**Taking ownership and reassigning permissions**

Open PowerShell and take ownership of the folder:

    $folder = "M:\Groups\Projections"
    takeown /f $folder /a /r /d Y

Add permission for the manager:

    $acl = Get-Acl $folder
    $ace = New-Object System.Security.AccessControl.
    FileSystemAccessRule `
    "joe.smith","FullControl","Allow"
    $acl.SetAccessRule($ace)
    Set-Acl $folder $acl

Recursively overwrite permissions:

    Get-ChildItem $folder -Recurse -Force |`
    ForEach {
    Get-Acl $acl | Set-Acl -Path $_.FullName
    }

**Enabling and disabling inheritance**

Open PowerShell and gather the current permissions:

    $acl = Get-Acl M:\Groups\Imaging

Enable or disable inheritance:

    $acl.SetAccessRuleProtection($True, $False)
    #first option is to disable inheritance - true=disable
    #second option is to keep inherited permissions - false=discard

Commit the change:

    Set-Acl M:\Groups\Imaging $acl

**Configuring NTFS deduplication**

Install the deduplication feature on the server:
    
    Add-WindowsFeature FS-Data-Deduplication

Use DDPEval to report on the estimated savings:
    
    ddpeval.exe M:\

Configure the disk for deduplication:

    Enable-DedupVolume M:\

Set the deduplication age to 0 days to test deduplication process:

    Set-DedupVolume M: -MinimumFileAgeDays 0

Start the deduplication job:

    Start-DedupJob M: -type Optimization

**Disk quota**

Install the File System Resource Manager:

    Install-WindowsFeature FS-Resource-Manager -IncludeManagementTools

Get the current e-mail configuration, and configure e-mail alerting for the
soft/hard quotas:

    Get-FsrmSetting
    Set-FsrmSetting -SmtpServer mail.corp.contoso.com `
    -FromEmailAddress FSAdmin@corp.contoso.com

Create a template based on one of the built-in templates:

    $myQuota = Get-FsrmQuotaTemplate -Name "Monitor 500 MB Share"
    $myQuota | New-FsrmQuotaTemplate -Name HomeFolders
    Set-FsrmQuotaTemplate -Name HomeFolders -Threshold $myQuota.
    Threshold

Create auto-apply quota:


    New-FsrmAutoQuota -Path E:\Users -Template HomeFolders

Create quota:

    New-FsrmQuota -Path E:\Groups -Template HomeFolders

Generate a quota usage report:

    New-FsrmStorageReport -Name "Quota Report" -Namespace "E:\" `
    -ReportTypeQuotaUsage -Interactive -MailTo fsadmin@corp.contoso.
    com

## Managing Network Shares with PowerShell

View the current shares on your server:

    Get-SmbShare

Create the first basic file share:

    New-Item -Path E:\Share1 -ItemType Directory
    New-SmbShare -Name Share1 -Path E:\share1

Create a second share granting everyone read access:

    New-Item -Path E:\Share2 -ItemType Directory
    New-SmbShare -Name Share2 -Path E:\share2 -ReadAccess Everyone `
    -FullAccess Administrator -Description "Test share"

To confirm the shares and permissions from the prior steps, list the
share permissions:

    Get-SmbShare | Get-SmbShareAccess

Grant Full Control access to the first share for user Joe Smith:

    Grant-SmbShareAccess -Name Share1 -AccountName CORP\Joe.Smith `
    -AccessRight Full -Confirm:$false

Ff we need to block access for a user to a share, we can use the Block-
SmbShareAccess cmdlet.

    Block-SmbShareAccess -Name Share2 -AccountName CORP\joe.smith `
    -Confirm:$false

**Accessing CIFS shares from PowerShell**

Use Get-ChildItem to view the contents of a share:

    Get-ChildItem \\server1\share2

Map the share as persistent:

	    New-PSDrive -Name S -Root \\server1\share1 -Persist -PSProvider
	    FileSystem

**Creating an NFS export**

1. Install the NFS server service:
	    
	    Add-WindowsFeature FS-NFS-Service –IncludeManagementTools

2. Create a new NFS share:
	    
	    New-Item C:\shares\NFS1 -ItemType Directory
	    New-NfsShare -Name NFS1 -Path C:\shares\NFS1

3. Grant access to a remote computer:
	    
	    Grant-NfsSharePermission -Name NFS1 -ClientName Server1 `
	    -ClientType host -Permission readwrite -AllowRootAccess $true

**Mounting NFS exports**

1. Install the NFS client:
	    
	    Install-WindowsFeature NFS-Client

2. Mount the NFS share using the \\server\share naming scheme:
	    
	    New-PSDrive N -PSProvider FileSystem -Root \\corpdc1\NFS1

## Managing Windows Updates with PowerShell

**Installing Windows Server Update Services**

1. Install the UpdateServices feature:
	    
	    Install-WindowsFeature UpdateServices -IncludeManagementTools

2. Perform the initial configuration:

	    New-Item E:\MyContent -ItemType Directory
	    & 'C:\Program Files\Update Services\Tools\WsusUtil.exe'
	    postinstall contentdir=e:\Mycontent

3. Review the current synhronization settings:

	    $myWsus = Get-WsuscServer
	    $myWsus.GetSubscription()

4. If you are using a proxy server to access the internet, then configure for using a
proxy (optional) as follows:

	    $wuConfig = $myWsus.GetConfiguration()
	    $wuConfig.ProxyName = "proxy.corp.contoso.com"
	    $wuConfig.ProxyServerPort = 8080
	    $wuConfig.UseProxy = $true
	    $wuConfig.Save()

5. Perform the initial synchronization (only syncs categories):
	    
	    $mySubs = $myWsus.GetSubscription()
	    $mySubs.StartSynchronizationForCategoryOnly()

6. Get a report on the synchronization status as follows:

    	$mySubs.GetSynchronizationProgress()
    	$mySubs.GetSynchronizationStatus()
    	$mySubs.GetLastSynchronizationInfo()

**Configuring WSUS update synchronization**

Define the product categories to include, as follows:

    $myProducts = Get-WsusProduct | `
    Where-Object {$_.Product.Title -in ('Forefront Client Security', `
    'SQL Server 2008 R2', 'Office', 'Windows')}
    $myProducts | Set-WsusProduct

Define the update classifications to include, as follows:

    $myClass = Get-WsusClassification | `
    Where-Object { $_.Classification.Title -in ('Update Rollups', `
    'Security Updates', 'Critical Updates', 'Definition Updates', `
    'Service Packs', 'Updates')}
    $myClass | Set-WsusClassification

Initiate synchronization:

    $mySubs = $myWsus.GetSubscription()
    $mySubs.StartSynchronization()

Configure automatic synchronization:

    $mysubs = $myWsus.GetSubscription()
    $mysubs.SynchronizeAutomatically = $true
    $mysubs.NumberOfSynchronizationsPerDay = 1
    $mysubs.Save()

**Configuring the Windows update client**

1. On the update server, confirm the WSUS address and port:

    	Get-WsusServer | Format-List *

2. Create the group policy:

    	New-GPO -Name "WSUS Client"

3. Link the group policy to a site:

    	New-GPLink -Name "WSUS Client" -Target "DC=Corp,DC=Contoso,DC=Com"

4. Add registry key settings to the group policy to assign the WSUS server:
    
    	$wuServer = "http://update.corp.contoso.com:8530"
    	Set-GPRegistryValue -Name "WSUS Client" `
    	-Key "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" `
    	-ValueName "UseWUServer" -Type DWORD -Value 1
    	Set-GPRegistryValue -Name "WSUS Client" `
    	-Key "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" `
    	-ValueName "AUOptions" -Type DWORD -Value 2
    	Set-GPRegistryValue -Name "WSUS Client" `
    	-Key "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" `
    	-ValueName "WUServer" -Type String -Value $wuServer
    	Set-GPRegistryValue -Name "WSUS Client" `
    	-Key "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" `
    	-ValueName "WUStatusServer" -Type String -Value $wuServer

5. On the client, update the group policy to load the new settings (optional):

    	Gpupdate /force

6. Initiate a update scan on the client (optional):
    
    	Wuauclt /detectnow

**Installing updates**

1. Set up the necessary update client objects:
    
    	$searcher = New-Object -ComObject Microsoft.Update.Searcher
    	$updateCollection = New-Object -ComObject Microsoft.Update.
    	UpdateColl
    	$session = New-Object -ComObject Microsoft.Update.Session
    	$installer = New-Object -ComObject Microsoft.Update.Installer

2. Search for missing updates:

    	$searcher.online=$true
    	$searcher.ServerSelection=1
    	$results = $searcher.Search("IsInstalled=0")

3. Create a collection of applicable updates:
    
    	$updates=$results.Updates
    	ForEach($update in $updates){ $updateCollection.Add($update) }

4. Download the updates:

    	$downloader = $session.CreateUpdateDownloader()
    	$downloader.Updates = $updateCollection
    	$downloader.Download()

5. Install the updates:

    	$installer.Updates = $updateCollection
    	$installer.Install()

**Uninstalling updates**

1. List the installed updates to identify which update will be removed:

    	$searcher = New-Object -ComObject Microsoft.Update.Searcher
    	$searcher.Online = $true
    	$searcher.ServerSelection = 1
    	$results = $searcher.Search('IsInstalled=1')
    	$results.Updates | `
    	Select-Object @{Name="UpdateID"; `
    	Expression={$_.Identity.UpdateID}}, Title

2. Setup the necessary update client objects:

    	$updateCollection = New-Object -ComObject Microsoft.Update.
    	UpdateColl
    	$installer = New-Object -ComObject Microsoft.Update.Installer

3. Search for the appropriate update by UpdateID:

    	$searcher.online = $true
    	$searcher.ServerSelection = 1
    	$results = $searcher.Search("UpdateID='70cd87ec-854f-4cdd-8acac272b6fe45f5'")

4. Create a collection of applicable updates:

    	$updates = $results.Updates
    	ForEach($update in $updates){ $updateCollection.Add($update) }

5. Uninstall the updates:

    	$installer.Updates = $updateCollection
    	$installer.UnInstall()

## Managing Printers with PowerShell

1. Install the print server:

    	Add-WindowsFeature Print-Server –IncludeManagementTools

2. Create the printer port:

    	Add-PrinterPort -Name Accounting_HP -PrinterHostAddress
    	"10.0.0.200"
    
3. Add the print driver:

    	Add-PrinterDriver -Name "HP LaserJet 9000 PCL6 Class Driver"

4. Add the printer:

    	Add-Printer -Name "Accounting HP" -DriverName "HP LaserJet 9000
    	PCL6 Class Driver" -PortName Accounting_HP

5. Share the printer:

    	Set-Printer -Name "Accounting HP" -Shared $true -Published $true

6. Review the printers to confirm the process:

    	Get-Printer | Format-Table -AutoSize

## Changing printer drivers

Install the print driver:

    Add-PrinterDriver -name "HP LaserJet 9000 PS Class Driver"

List the installed printers to determine the name needed:

    Get-Printer

Change the driver:

    Get-Printer -Name "Accounting HP" | Set-Printer -DriverName "HP
    LaserJet 9000 PS Class Driver"

Confirm the printer is using the new driver:

    Get-Printer | Format-Table –AutoSize

## Troubleshooting Servers with PowerShell

**Testing if a server is responding**

Ping a single host.

    Test-Connection -ComputerName corpdc1

Ping multiple hosts.

    Workflow Ping-Host ([string[]] $targets)
    {
    	ForEach -Parallel ($target in $targets)
    	{
    		If (Test-Connection -ComputerName $target -Count 2 -Quiet)
    		{
    			"$target is alive"
    		} Else {
    			"$target is down"
    		}
    	}
    }
    Ping-Host 10.10.10.10, 10.10.10.11

## Inventorying Servers with PowerShell

**Inventorying hardware with PowerShell**

Gather disk information from the local system.

    $TargetSystem="."
    $myCim = New-CimSession -ComputerName $TargetSystem
    Get-Disk -CimSession $myCim

Logical disk

    Get-Disk -CimSession $myCim

Physical disk

    Get-PhysicalDisk -CimSession $myCim

Network adapters

    Get-NetAdapter -CimSession $myCim

System enclosure

    Get-WmiObject -ComputerName $TargetSystem `
    -Class Win32_SystemEnclosure

Computer system

    Get-WmiObject -ComputerName $TargetSystem `
    -Class Win32_ComputerSystemProduct

Processor

    Get-WmiObject -ComputerName $TargetSystem -Class Win32_Processor

Physical Memory

    Get-WmiObject -ComputerName $TargetSystem -Class Win32_
    PhysicalMemory

CD-Rom

    Get-WmiObject -ComputerName $TargetSystem -Class Win32_CDromDrive

Sound card

    Get-WmiObject -ComputerName $TargetSystem -Class Win32_SoundDevice

Video card

    Get-WmiObject -ComputerName $TargetSystem `
    -Class Win32_VideoController

BIOS

    Get-WmiObject -ComputerName $TargetSystem -Class Win32_BIOS

**Inventorying the installed software**

Get installed features.

    Get-WindowsFeature | Where-Object Install`State -EQ "Installed"

**Inventory system configuration**

Retrieve the network configuration

    $TargetSystem="."
    $myCim = New-CimSession -ComputerName $TargetSystem
    Get-NetIPAddress -CimSession $myCim
    Get-NetRoute -CimSession $myCim

Display the local users and groups.

    Get-WmiObject -ComputerName $TargetSystem `
    -Query "Select * from Win32_Group where Domain='$TargetSystem'"
    Get-WmiObject -ComputerName $TargetSystemt `
    -Query "Select * from Win32_UserAccount where
    Domain='$TargetSystem'"

List the services.
    
    Get-Service
    Get-WmiObject -Class Win32_Service | `
    Select-Object Name, Caption, StartMode, State

List the currently running processes.

    Get-Process

Show the system's shares and printers.

    Get-SmbShare
    Get-Printer
    
Display the startup information.

    Get-WmiObject -ComputerName $TargetSystem -Class Win32_
    StartupCommand

Show the system time zone.

    Get-WmiObject -ComputerName $TargetSystem -Class Win32_TimeZone

Display information about the registry.

    Get-WmiObject -ComputerName $TargetSystem -Class Win32_Registry

## Server Backup

**Configuring backup policies**

Install Windows Server Backup feature using the following command:

    Add-WindowsFeature Windows-Server-Backup -IncludeManagementTools

Create a backup policy:

    $myPol = New-WBPolicy

Add the backup sources.

    $myPol | Add-WBBareMetalRecovery
    $myPol | Add-WBSystemState
    $sourceVol = Get-WBVolume C:
    Add-WBVolume -Policy $myPol -Volume $sourceVol

Define the backup target.

    $targetVol = New-WBBackupTarget -Volume (Get-WBVolume E:)
    Add-WBBackupTarget -Policy $myPol -Target $targetVol

Define the schedule.

    Set-WBSchedule -Policy $myPol -Schedule ("12/17/2012 9:00:00 PM")

Save the policy.

    Set-WBPolicy -Policy $myPol

**Initiating backups manually**

Initiate the default backup policy.

    Get-WBPolicy | Start-WBBackup

Monitor the backup using Get-WBSummary command:

    Get-WBSummay

Perform a one-off backup of C:\InetPub using the following command:

    $myPol = New-WBPolicy
    $mySpec = New-WBFileSpec -FileSpec "C:\InetPub"
    Add-WBFileSpec -Policy $myPol -FileSpec $mySpec
    $targetVol = New-WBBackupTarget -Volume (Get-WBVolume E:)
    Add-WBBackupTarget -Policy $myPol -Target $targetVol
    Start-WBBackup -Policy $myPol

**Restoring files**

Identify the backup set.

    Get-WBBackupSet
    
    $myBackup = Get-WBBackupSet | `
    Where-Object VersionId -eq 03/03/2013-19:31

Perform a single file recovery.

    Start-WBFileRecovery -BackupSet $myBackup `
    -SourcePath c:\temp\perfcounter.csv

Recover a folder.

    Start-WBFileRecovery -BackupSet $myBackup `
    -SourcePath c:\inetpub\ -Recursive -TargetPath c:\

**Restoring Windows system state**

Identify the backup set.

    Get-WBBackupSet
    $myBackup = Get-WBBackupSet | `
    Where-Object VersionId -eq 03/03/2013-19:31

Initiate the system state restore.

    Start-WBSystemStateRecovery -BackupSet $myBackup

Select Y to reboot the system.

