## Commands lab 6.2.3.9

### Part 1: Build the Network and Configure Basic Device Settings

**R1**

    enable
	conf t
	hostname R1
	enable secret class
	ipv6 unicast-routing
	no ip domain lookup
	interface Loopback0
	ip address 209.165.200.225 255.255.255.252
	interface Loopback1
	ip address 192.168.1.1 255.255.255.0
	ipv6 address 2001:DB80:ACAD:1::1/64
	ipv6 ospf network point-to-point
	interface Loopback2
	ip address 192.168.2.1 255.255.255.0
	ipv6 address 2001:DB8:ACAD:2::1/64
	ipv6 ospf 1 area 1
	ipv6 ospf network point-to-point
	interface Serial0/0/0
	ip address 192.168.21.1 255.255.255.252
	ipv6 address FE80::1 link-local
	ipv6 address 2001:DB8:ACAD:12::1/64
	ipv6 ospf 1 area 0
	clock rate 128000
	shutdown
	router ospf 1
	router-id 1.1.1.1
	passive-interface Loopback1
	passive-interface Loopback2
	network 192.168.2.0 0.0.0.255 area 1
	network 192.168.12.0 0.0.0.3 area 0
	default-information originate
	ipv6 router ospf 1
	area 1 range 2001:DB8:ACAD::/61
	ip route 0.0.0.0 0.0.0.0 Loopback0
	banner motd @
	Unauthorized Access is Prohibited! @
	line con 0
	password cisco
	logging synchronous
	login
	line vty 0 4
	password cisco
	logging synchronous
	login
	transport input all
	end
	cp running start 

**R2**
    
	enable
	conf t
	hostname R2
	ipv6 unicast-routing
	no ip domain lookup
	enable secret class
	interface Loopback6
	ip address 192.168.6.1 255.255.255.0
	ipv6 address 2001:DB8:CAD:6::1/64
	interface Serial0/0/0
	ip address 192.168.12.2 255.255.255.252
	ipv6 address FE80::2 link-local
	ipv6 address 2001:DB8:ACAD:12::2/64
	ipv6 ospf 1 area 0
	no shutdown
	interface Serial0/0/1
	ip address 192.168.23.2 255.255.255.252
	ipv6 address FE80::2 link-local
	ipv6 address 2001:DB8:ACAD:23::2/64
	ipv6 ospf 1 area 3
	clock rate 128000
	no shutdown
	router ospf 1
	router-id 2.2.2.2
	passive-interface Loopback6
	network 192.168.6.0 0.0.0.255 area 3
	network 192.168.12.0 0.0.0.3 area 0
	network 192.168.23.0 0.0.0.3 area 3
	ipv6 router ospf 1
	router-id 2.2.2.2
	banner motd @
	Unauthorized Access is Prohibited! @
	line con 0
	password cisco
	logging synchronous
	login
	line vty 0 4
	password cisco
	logging synchronous
	login
	transport input all
	end
	cp running start

**R3**

	enable
	conf t
	hostname R3
	no ip domain lookup
	ipv6 unicast-routing
	enable secret class
	interface Loopback4
	ip address 192.168.4.1 255.255.255.0
	ipv6 address 2001:DB8:ACAD:4::1/64
	ipv6 ospf 1 area 3
	interface Loopback5
	ip address 192.168.5.1 255.255.255.0
	ipv6 address 2001:DB8:ACAD:5::1/64
	ipv6 ospf 1 area 3
	interface Serial0/0/1
	ip address 192.168.23.1 255.255.255.252
	ipv6 address FE80::3 link-local
	ipv6 address 2001:DB8:ACAD:23::1/64
	ipv6 ospf 1 area 3
	no shutdown
	router ospf 1
	router-id 3.3.3.3
	passive-interface Loopback4
	passive-interface Loopback5
	network 192.168.4.0 0.0.0.255 area 3
	network 192.168.5.0 0.0.0.255 area 3
	ipv6 router ospf 1
	router-id 3.3.3.3
	banner motd @
	Unauthorized Access is Prohibited! @
	line con 0
	password cisco
	logging synchronous
	login
	line vty 0 4
	password cisco
	logging synchronous
	login
	transport input all
	end
	cp running start

## Part 2: Troubleshoot Layer 3 Connectivity
    
###Step 1: Verify the interfaces listed in the Addressing Table are active and configured with correct IP address information

**R1**

    en
    conf t
    show ip interface brief
	interface Loopback1
	ipv6 address 2001:DB8:ACAD:1::1/64
	interface Serial0/0/0
	no shutdown

**R2**

    en
    conf t
    show ip interface brief
	interface Loopback6
	ipv6 address 2001:DB8:ACAD:6::1/64
    

**R3**

    en
    conf t
    show ip interface brief

## Part 3: Troubleshoot OSPFv2

### Step 1: Test IPv4 end-to-end connectivity
From each router, ping all interfaces on the other routers. Record your results below as IPv4 OSPFv2 connectivity problems do exist.

No problems.

### Step 2: Verify that all interfaces are assigned to the proper OSPFv2 areas on R1.

**R1**

	en
	conf t
	show ip protocols
	show ip ospf interface brief
	router ospf 1
	network 192.168.1.0 0.0.0.255 area 1

	
### Step 3: Verify that all interfaces are assigned to the proper OSPFv2 areas on R2

**R2**

	en
	conf t
	show ip protocols
	show ip ospf interface brief

###Step 4: Verify that all interfaces are assigned to the proper OSPFv2 areas on R3

**R3**

	en
	conf t
	show ip protocols
	show ip ospf interface brief
	router ospf 1
	network 192.168.23.0 0.0.0.3 area 3

###Step 5: Verify OSPFv2 neighbor information.

**R1-R2-R3**
	
	show ip ospf neighbor

###Step 6: Verify OSPFv2 routing information

**R1-R2-R3**

	show ip route ospf

###Step 7: Verify IPv4 end-to-end connectivity.

Correct

##Part 4: Troubleshoot OSPFv3

###Step 1: Test IPv6 end-to-end connectivity

Some routers can't be reached

###Step 2: Verify that IPv6 unicast routing has been enabled on all routers.

**R1-R2-R3**

	show run | section ipv6 unicast
	
###Step 3: Verify that all interfaces are assigned to the proper OSPFv3 areas on R1.

**R1**

	en
	conf t
	show ipv6 protocols
	interface Loopback1
	ipv6 ospf 1 area 1
	ipv6 router ospf 1
	router-id 1.1.1.1
	show ipv6 route ospf

###Step 4: Verify that all interfaces are assigned to the proper OSPFv3 areas on R2.

**R2**

	en
	conf t
	show ipv6 protocols
	interface Loopback6
	ipv6 ospf 1 area 3
	show ipv6 route ospf

###Step 5: Verify that all interfaces are assigned to the proper OSPFv3 areas on R3.

**R3**

	en
	conf t
	show ipv6 protocols
	interface Loopback4
	ipv6 ospf network point-to-point
	interface Loopback5
	ipv6 ospf network point-to-point
	show ipv6 route ospf

###Step 6: Verify that all routers have correct neighbor adjacency information

**R1-R2-R3**

	show ipv6 ospf neighbor

###Step 7: Verify OSPFv3 routing information.

**R1-R2-R3**

	show ipv6 route ospf

###Step 8: Verify IPv6 end-to-end connectivity

Correct		

## Reflection

Why not just use the show running-config command to resolve all issues?

This command does not give you enough information to solve all the resolving issues. 