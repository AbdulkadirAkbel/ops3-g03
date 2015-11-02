
# Installeer DHCP en management tools
Install-WindowsFeature DHCP -IncludeManagementTools

# DHCP scope aanmaken
Add-DhcpServerv4Scope -Name "Werkstations" -StartRange 192.168.101.30 -EndRange 192.168.101.200 -SubnetMask 255.255.255.0

# DHCP opties
Set-DhcpServerv4OptionValue -DnsDomain Project3.be -DnsServer 192.168.101.11

# DHCP activeren
Add-DhcpServerInDC -DnsName PROJECTEN3.Project3.be

# DHCP exclusions toevoegen
Add-DhcpServerv4ExclusionRange –ScopeId 192.168.101.0 –StartRange 192.168.101.1 –EndRange 192.168.101.29
