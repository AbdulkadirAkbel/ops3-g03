<#
.Name
Set-IP
.Synopsis
Sets the Ipv4 for a machine.
.Description
This script sets the Ipv4, subnetmask, default gateway and the dns for a machine. Afterwards there will ipconfig /all will be displayed. 
The subnetmask is set with prefixlength. The value of prefixlength is the number of bits that are used to form the network part of the ip address. This is also the same as the CIDR notation of the subnetmask.
.Example
Set-myIP -IP4 192.168.10.202 -PrefixLength 24 -DeafaultGateway 192.168.10.1 -Dns 192.168.10.2

This will set the following
IP		: 192.168.10.202
Prefixlength	: 24
DefaultGateway	: 192.168.10.1
Dns		: 192.168.10.2

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