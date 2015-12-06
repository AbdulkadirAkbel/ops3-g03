#IP address setter
<#
.Synopsis
Sets the Ipv4 for a machine.
.Description
This script sets the Ipv4 address for a machine in a quick dirty way. Also de default gateway will be set. 
.Example
Set-myIP -IP4 192.168.10.202 -PrefixLength 24 -DeafaultGateway 192.168.10.1 -Dns 192.168.10.2

.Notes
    Author: Andy Nelis
   Initial: 13/11/2015 
#>

Param ($IP4, $PrefixLength, $DefaultGateway, $Dns)

$IPv4 = $IP4
$Gateway4 = $DefaultGateway

$Nic = Get-NetAdapter -name Ethernet
$Nic | Set-NetIPInterface -DHCP Disabled
$Nic | New-NetIPAddress -AddressFamily IPv4 `
                        -IPAddress $IPv4 `
                        -PrefixLength $PrefixLength `
                        -type Unicast `
                        -DefaultGateway $DefaultGateway
Set-DnsClientServerAddress -InterfaceAlias $Nic.Name `
                           -ServerAddresses $Dns

ipconfig /all