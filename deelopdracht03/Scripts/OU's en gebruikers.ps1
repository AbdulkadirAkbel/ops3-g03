Import-Module ActiveDirectory

$ADUsers = Import-Csv werknemers.csv

if ([ADSI]::Exists("LDAP://OU=Technical,DC=Project3,DC=be") -eq $false) {
    New-ADOrganizationalUnit -Name Technical -ProtectedFromAccidentalDeletion $false
}

if ([ADSI]::Exists("LDAP://OU=HR,DC=Project3,DC=be") -eq $false) {
    New-ADOrganizationalUnit -Name HR -ProtectedFromAccidentalDeletion $false
}

if ([ADSI]::Exists("LDAP://OU=Sales,DC=Project3,DC=be") -eq $false) {
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
    New-ADUser -SamAccountName $Username -Name $Name -Path $OU -City $City -Title $Title -GivenName $GivenName -Surname $Surname -StreetAddress $StreetAddress -PostalCode $Postcode -Country $Country -MobilePhone $Telefoon -AccountPassword (ConvertTo-SecureString "Project3" -AsPlainText -Force) -Description "Gender: $Gender, birthday: $Birthday, country: $CountryFull" -PassThru | Enable-ADAccount
}

    Get-ADUser -Filter * -SearchBase "OU=HR,DC=Project3,DC=be" | Set-ADUser -CannotChangePassword:$false -PasswordNeverExpires:$false -ChangePasswordAtLogon:$True
    Get-ADUser -Filter * -SearchBase "OU=Sales,DC=Project3,DC=be" | Set-ADUser -CannotChangePassword:$false -PasswordNeverExpires:$false -ChangePasswordAtLogon:$True
    Get-ADUser -Filter * -SearchBase "OU=Technical,DC=Project3,DC=be" | Set-ADUser -CannotChangePassword:$false -PasswordNeverExpires:$false -ChangePasswordAtLogon:$True
}
