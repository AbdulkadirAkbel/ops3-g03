<#
.Synopsis
Creates the TreyResearch.net users
.Description
Create-TreyUsers reads a CSV file to create an array of users. The users are then added
to the users container in Active Directory. Additionally, Create-TreyUsers adds the
user Charlie to the same AD DS Groups as the Administrator account.
.Example
Create-TreyUsers
Creates AD Accounts for the users in the default "TreyUsers.csv" source file
.Example
Create-TreyUsers -Path "C:\temp\NewUsers.txt"
Creates AD accounts for the users listed in the file C:\temp\NewUsers.txt"
.Parameter Path
The path to the input CSV file. The default value is ".\TreyUsers.csv".
.Inputs
[string]
.Notes
    Author: Charlie Russel
 Copyright: 2015 by Charlie Russel
          : Permission to use is granted but attribution is appreciated
   Initial: 3/26/2015 (cpr)
   ModHist:
          :
#>
[CmdletBinding()]
Param(
     [Parameter(Mandatory=$False,Position=0)]
     [string]
     $Path = ".\TreyUsers.csv"
     )

$TreyUsers = @()
If (Test-Path $Path ) {
   $TreyUsers = Import-CSV $Path
} else {
   Throw  "This script requires a CSV file with user names and properties."
}

ForEach ($user in $TreyUsers ) {
   New-AdUser -DisplayName $User.DisplayName `
              -GivenName $user.GivenName `
              -Name $User.Name `
              -SurName $User.SurName `
              -SAMAccountName $User.SAMAccountName `
              -Enabled $True `
              -PasswordNeverExpires $true `
              -UserPrincipalName $user.SAMAccountName `
              -AccountPassword (ConvertTo-SecureString -AsPlainText -Force -String
"P@ssw0rd!" )
   If ($User.SAMAccountName -eq "Charlie" ) {
      $cprpwd = Read-Host -Prompt 'Enter Password for account: Charlie' -AsSecureString
      Set-ADAccountPassword -Identity Charlie -NewPassword $cprpwd -Reset
      $SuperUserGroups = @()
      $SuperUserGroups = (Get-ADUser -Identity "Administrator" -Properties * ).MemberOf

      ForEach ($Group in $SuperUserGroups ) {
         Add-ADGroupMember -Identity $Group -Members "Charlie"
      }
      Write-Host "The user $user.SAMAccountName has been added to the following AD
Groups: "
      (Get-ADUser -Identity $user.SAMAccountName -Properties * ).MemberOf
   }
}