#get-ADOrganizationalUnit


New-Item -Path "C:\HR" -ItemType Directory
New-Item -Path "C:\Technical" -ItemType Directory
New-Item -Path "C:\Sales" -ItemType Directory
New-Item -Path "C:\Algemeen" -ItemType Directory


New-SmbShare -Name "HR" -Path "C:\HR"
Grant-SmbShareAccess -Name "HR" -AccountName StHer1 `
-AccessRight Full -Confirm:$false
Grant-SmbShareAccess -Name "HR" -AccountName SvAer10 `
-AccessRight Full -Confirm:$false

Block-SmbShareAccess -Name "HR" -AccountName EvTil13 `
-Confirm:$false
Block-SmbShareAccess -Name "HR" -AccountName BePlu16 `
-Confirm:$false
Block-SmbShareAccess -Name "HR" -AccountName StVan17 `
-Confirm:$false
Block-SmbShareAccess -Name "HR" -AccountName WoMey19 `
-Confirm:$false
Block-SmbShareAccess -Name "HR" -AccountName "LeDe 18" `
-Confirm:$false
Block-SmbShareAccess -Name "HR" -AccountName AnCop15 `
-Confirm:$false
Block-SmbShareAccess -Name "HR" -AccountName KrVan14 `
-Confirm:$false
Block-SmbShareAccess -Name "HR" -AccountName "AlDe 9" `
-Confirm:$false
Block-SmbShareAccess -Name "HR" -AccountName StVer8 `
-Confirm:$false
Block-SmbShareAccess -Name "HR" -AccountName StWat7 `
-Confirm:$false
Block-SmbShareAccess -Name "HR" -AccountName WiVan6 `
-Confirm:$false
Block-SmbShareAccess -Name "HR" -AccountName AnNel4 `
-Confirm:$false
Block-SmbShareAccess -Name "HR" -AccountName NiSeg5 `
-Confirm:$false
Block-SmbShareAccess -Name "HR" -AccountName NiSal3 `
-Confirm:$false
Block-SmbShareAccess -Name "HR" -AccountName AbAkb2 `
-Confirm:$false
Block-SmbShareAccess -Name "HR" -AccountName EvTil13 `
-Confirm:$false
Block-SmbShareAccess -Name "HR" -AccountName BePlu16 `
-Confirm:$false
Block-SmbShareAccess -Name "HR" -AccountName StVan17 `
-Confirm:$false


New-SmbShare -Name "Technical" -Path "C:\Technical"
Grant-SmbShareAccess -Name "Technical" -AccountName AbAkb2 `
-AccessRight Full -Confirm:$false
Grant-SmbShareAccess -Name "Technical" -AccountName NiSal3 `
-AccessRight Full -Confirm:$false
Grant-SmbShareAccess -Name "Technical" -AccountName AnNel4 `
-AccessRight Full -Confirm:$false
Grant-SmbShareAccess -Name "Technical" -AccountName NiSeg5 `
-AccessRight Full -Confirm:$false
Grant-SmbShareAccess -Name "Technical" -AccountName WiVan6 `
-AccessRight Full -Confirm:$false
Grant-SmbShareAccess -Name "Technical" -AccountName StWat7 `
-AccessRight Full -Confirm:$false
Grant-SmbShareAccess -Name "Technical" -AccountName StVer8 `
-AccessRight Full -Confirm:$false
Grant-SmbShareAccess -Name "Technical" -AccountName "AlDe 9" `
-AccessRight Full -Confirm:$false
Grant-SmbShareAccess -Name "Technical" -AccountName KrVan14 `
-AccessRight Full -Confirm:$false
Grant-SmbShareAccess -Name "Technical" -AccountName AnCop15 `
-AccessRight Full -Confirm:$false
Grant-SmbShareAccess -Name "Technical" -AccountName "LeDe 18" `
-AccessRight Full -Confirm:$false
Grant-SmbShareAccess -Name "Technical" -AccountName WoMey19 `
-AccessRight Full -Confirm:$false

Block-SmbShareAccess -Name "Technical" -AccountName EvTil13 `
-Confirm:$false
Block-SmbShareAccess -Name "Technical" -AccountName BePlu16 `
-Confirm:$false
Block-SmbShareAccess -Name "Technical" -AccountName StVan17 `
-Confirm:$false
Block-SmbShareAccess -Name "Technical" -AccountName SvAer10 `
-Confirm:$false
Block-SmbShareAccess -Name "Technical" -AccountName StHer1 `
-Confirm:$false


New-SmbShare -Name "Sales" -Path "C:\Sales"
Grant-SmbShareAccess -Name "Sales" -AccountName EvTil13 `
-AccessRight Full -Confirm:$false
Grant-SmbShareAccess -Name "Sales" -AccountName BePlu16 `
-AccessRight Full -Confirm:$false
Grant-SmbShareAccess -Name "Sales" -AccountName StVan17 `
-AccessRight Full -Confirm:$false

Block-SmbShareAccess -Name "Sales" -AccountName WoMey19 `
-Confirm:$false
Block-SmbShareAccess -Name "Sales" -AccountName "LeDe 18" `
-Confirm:$false
Block-SmbShareAccess -Name "Sales" -AccountName AnCop15 `
-Confirm:$false
Block-SmbShareAccess -Name "Sales" -AccountName KrVan14 `
-Confirm:$false
Block-SmbShareAccess -Name "Sales" -AccountName "AlDe 9" `
-Confirm:$false
Block-SmbShareAccess -Name "Sales" -AccountName StVer8 `
-Confirm:$false
Block-SmbShareAccess -Name "Sales" -AccountName StWat7 `
-Confirm:$false
Block-SmbShareAccess -Name "Sales" -AccountName WiVan6 `
-Confirm:$false
Block-SmbShareAccess -Name "Sales" -AccountName AnNel4 `
-Confirm:$false
Block-SmbShareAccess -Name "Sales" -AccountName NiSeg5 `
-Confirm:$false
Block-SmbShareAccess -Name "Sales" -AccountName NiSal3 `
-Confirm:$false
Block-SmbShareAccess -Name "Sales" -AccountName AbAkb2 `
-Confirm:$false
Block-SmbShareAccess -Name "Sales" -AccountName StHer1 `
-Confirm:$false
Block-SmbShareAccess -Name "Sales" -AccountName SvAer10 `
-Confirm:$false



New-SmbShare -Name "Algemeen" -Path "C:\Algemeen" -FullAccess Everyone


Get-SmbShare | Get-SmbShareAccess



#Block-SmbShareAccess -Name "HR" -AccountName Everyone `
#-Confirm:$false

#Block-SmbShareAccess -Name "Technical" -AccountName Everyone `
#-Confirm:$false

#Block-SmbShareAccess -Name "Sales" -AccountName Everyone `
#-Confirm:$false


# Voor het verwijderen van een share: 
# Get-SmbShare -Name "fso" | Remove-SmbShare -Confirm:$false
