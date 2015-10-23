$domainname = "Project3.be"
# Reverse lookup zone creëren
Add-DnsServerPrimaryZone –Name 101.168.192.in-addr.arpa –ReplicationScope Forest

# Primaire zone creëren
Add-DnsServerPrimaryZone –Name $domainname –ZoneFile $domainname.dns