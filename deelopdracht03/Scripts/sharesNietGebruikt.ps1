$ADUsers = Get-ADUser -server $ADServer -Filter * -Credential $GetAdminact -searchbase $searchbase -Properties * 
 
#modify display name of all users in AD (based on search criteria) to the format "LastName, FirstName Initials" 
 
ForEach ($ADUser in $ADUsers)  
{ 
 
 #The line below creates a folder for each user in the \\serrver\users$ share 
 #Ensure that you have configured the 'Users' base folder as outlined in the post 
 
#New-Item -ItemType Directory -Path "\\Project3\Users$\$($ADUser.sAMAccountname)" 
New-Item -ItemType Directory -Path "\\Project3\Users$\$($ADUser.DisplayName)" 
#add option to create with GivenName Surname but comment it out 
 
#Grant each user Full Control to the users home folder only 
 
#define domain name to use in the $UsersAm variable 
 
$Domain = 'Project3' 
 
#Define variables for the access rights 
 
#1Define variable for user to grant access (IdentityReference: the user name in Active Directory) 
#Usually in the format domainname\username or groupname 
 
$UsersAm = "$Domain\$($ADUser.sAMAccountname)" #presenting the sAMAccountname in this format  
#stops it displaying in Distinguished Name format  
 
#Define FileSystemAccessRights:identifies what type of access we are defining, whether it is Full Access, Read, Write, Modify 
 
$FileSystemAccessRights = [System.Security.AccessControl.FileSystemRights]"FullControl" 
 
#define InheritanceFlags:defines how the security propagates to child objects by default 
#Very important - so that users have ability to create or delete files or folders  
#in their folders 
 
$InheritanceFlags = [System.Security.AccessControl.InheritanceFlags]::"ContainerInherit", "ObjectInherit" 
 
#Define PropagationFlags: specifies which access rights are inherited from the parent folder (users folder). 
 
$PropagationFlags = [System.Security.AccessControl.PropagationFlags]::None 
 
#Define AccessControlType:defines if the rule created below will be an 'allow' or 'Deny' rule 
 
$AccessControl =[System.Security.AccessControl.AccessControlType]::Allow  
#define a new access rule to apply to users folfers 
 
$NewAccessrule = New-Object System.Security.AccessControl.FileSystemAccessRule ` 
    ($UsersAm, $FileSystemAccessRights, $InheritanceFlags, $PropagationFlags, $AccessControl)  
 
 
#set acl for each user folder#First, define the folder for each user 
 
#$userfolder = "\\Project3\Users$\$($ADUser.sAMAccountname)" 
$userfolder = "\\Project3\Users$\$($ADUser.DisplayName)" 
 
$currentACL = Get-ACL -path $userfolder 
#Add this access rule to the ACL 
$currentACL.SetAccessRule($NewAccessrule) 
#Write the changes to the user folder 
Set-ACL -path $userfolder -AclObject $currentACL 
 
#set variable for homeDirectory (personal folder) and homeDrive (drive letter) 
 
#$homeDirectory = "\\Project3\Users$\$($ADUser.sAMAccountname)" #This maps the folder for each user  
$homeDirectory = "\\Project3\Users$\$($ADUser.DisplayName)" #This maps the folder for each user  
 
#Set homeDrive for each user 
 
$homeDrive = "H" #This maps the homedirectory to drive letter H  
#Ensure that drive letter H is not in use for any of the users 
 
#Update the HomeDirectory and HomeDrive info for each user 
 
Set-ADUser -server $ADServer -Credential $GetAdminact -Identity $ADUser.sAMAccountname -Replace @{HomeDirectory=$homeDirectory} 
Set-ADUser -server $ADServer -Credential $GetAdminact -Identity $ADUser.sAMAccountname -Replace @{HomeDrive=$homeDrive} 
 
}