## Commands lab 6.2.3.9

### Part 1: Build the Network and Configure Basic Device Settings

**R1**

    en
    conf t

    no ip domain-lookup

    hostname R1

    enable secret class
    line con 0
	logging synchronous
    password cisco
    login
    exit
	line vty 0 4
	password cisco
	login
	exit
	
	banner motd #
	Unauthorized access is strictly prohibited and prosecuted to the full extent of the law. #

	service password-encryption

	int s0/0/0
	clock rate 128000
	ipv6 address 2001:db8:acad:12::1/64
	ipv6 address fe80::1 link-local
	no sh

	int lo0
	ipv6 address 2001:db8:acad::1/64

	int lo1
	ipv6 address 2001:db8:acad:1::1/64

	int lo2
	ipv6 address 2001:db8:acad:2::1/64

	int lo3
	ipv6 address 2001:db8:acad:3::1/64

	exit

	ipv6 unicast-routing

	exit

	copy running-config startup-config

**R2**
    

	en
    conf t

    no ip domain-lookup

    hostname R2

    enable secret class
    line con 0
	logging synchronous
    password cisco
    login
    exit
	line vty 0 4
	password cisco
	login
	exit
	
	banner motd #
	Unauthorized access is strictly prohibited and prosecuted to the full extent of the law. #

	service password-encryption

	int s0/0/0
	ipv6 address 2001:db8:acad:12::2/64
	ipv6 address fe80::2 link-local
	no sh

	int s0/0/1
	clock rate 128000
	ipv6 address 2001:db8:acad:23::2/64
	ipv6 address fe80::2 link-local
	no sh

	int lo8
	ipv6 address 2001:db8:acad:8::1/64

	exit

	ipv6 unicast-routing

	exit

	copy running-config startup-config

**R3**

	en
    conf t

    no ip domain-lookup

    hostname R3

    enable secret class
    line con 0
	logging synchronous
    password cisco
    login
    exit
	line vty 0 4
	password cisco
	login
	exit
	
	banner motd #
	Unauthorized access is strictly prohibited and prosecuted to the full extent of the law. #

	service password-encryption

	int s0/0/1
	ipv6 address 2001:db8:acad:23::3/64
	ipv6 address fe80::3 link-local
	no sh

	int lo4
	ipv6 address 2001:db8:acad:4::1/64

	int lo5
	ipv6 address 2001:db8:acad:5::1/64

	int lo6
	ipv6 address 2001:db8:acad:6::1/64

	int lo7
	ipv6 address 2001:db8:acad:7::1/64
	
	exit

	ipv6 unicast-routing

	exit

	copy running-config startup-config
    
## Part 2: Configure a Multiarea OSPFv3 Network
    

**R1**

    en
    conf t
    
    ipv6 router ospf 1
    router-id 1.1.1.1

	interface lo0
	ipv6 ospf 1 area 1
	ipv6 ospf network point-to-point

	interface lo1
	ipv6 ospf 1 area 1
	ipv6 ospf network point-to-point

	interface lo2
	ipv6 ospf 1 area 1
	ipv6 ospf network point-to-point

	interface lo3
	ipv6 ospf 1 area 1
	ipv6 ospf network point-to-point

	interface s0/0/0
	ipv6 ospf 1 area 0

**R2**

    en
    conf t
    
    ipv6 router ospf 1
    router-id 2.2.2.2
    
	interface lo8
	ipv6 ospf 1 area 0
	ipv6 ospf network point-to-point
	
	int s0/0/0
	ipv6 ospf 1 area 0

	int s0/0/1
	ipv6 ospf 1 area 0
    

**R3**

    en
    conf t
    
    ipv6 router ospf 1
    router-id 3.3.3.3
    
	interface lo4
	ipv6 ospf 1 area 2
	ipv6 ospf network point-to-point

	interface lo5
	ipv6 ospf 1 area 2
	ipv6 ospf network point-to-point

	interface lo6
	ipv6 ospf 1 area 2
	ipv6 ospf network point-to-point

	interface lo7
	ipv6 ospf 1 area 2
	ipv6 ospf network point-to-point

	interface s0/0/1
	ipv6 ospf 1 area 0

## Part 3: Configure Interarea Route Summarization

### Step 1: Summarize networks on R1
1. List the network addresses for the loopback interfaces and identify the hextet section where the addresses differ.<br/> 2001:DB8:ACAD:**0000**::1/64 <br/>
2001:DB8:ACAD:**0001***::1/64 <br/>
2001:DB8:ACAD:**0002**::1/64 <br/>
2001:DB8:ACAD:**0003**::1/64

2. Convert the differing section from hex to binary.<br/>
2001:DB8:ACAD: 0000 0000 0000 0000::1/64<br/>
2001:DB8:ACAD: 0000 0000 0000 0001::1/64<br/>
2001:DB8:ACAD: 0000 0000 0000 0010::1/64<br/>
2001:DB8:ACAD: 0000 0000 0000 0011::1/64

3. Count the number of leftmost matching bits to determine the prefix for the summary route. <br/>
**2001:DB8:ACAD: 0000 0000 0000 00**00::1/64 <br/>
**2001:DB8:ACAD: 0000 0000 0000 00**01::1/64 <br/>
**2001:DB8:ACAD: 0000 0000 0000 00**10::1/64 <br/>
**2001:DB8:ACAD: 0000 0000 0000 00**11::1/64

How many bits match? **62**

4. Copy the matching bits and then add zero bits to determine the summarized network address.<br/>
2001:DB8:ACAD: 0000 0000 0000 0000::00

5. Convert the binary section back to hex.<br/>
2001:DB8:ACAD::

6. Append the prefix of the summary route (result of Step 1c).<br/>
2001:DB8:ACAD::/62

### Step 2: Configure interarea route summarization on R1

**R1**

	en
	conf t

	ipv6 router ospf 1
	area 1 range 2001:DB8:ACAD::/62
	
### Step 3: Summarize networks and configure interarea route summarization on R3

1. List the network addresses for the loopback interfaces and identify the hextet section where the addresses differ.<br/> 2001:DB8:ACAD:**0004**::1/64 <br/>
2001:DB8:ACAD:**0005***::1/64 <br/>
2001:DB8:ACAD:**0006**::1/64 <br/>
2001:DB8:ACAD:**0007**::1/64

2. Convert the differing section from hex to binary.<br/>
2001:DB8:ACAD: 0000 0000 0000 0100::1/64<br/>
2001:DB8:ACAD: 0000 0000 0000 0101::1/64<br/>
2001:DB8:ACAD: 0000 0000 0000 0110::1/64<br/>
2001:DB8:ACAD: 0000 0000 0000 0111::1/64

3. Count the number of leftmost matching bits to determine the prefix for the summary route. <br/>
**2001:DB8:ACAD: 0000 0000 0000 01**00::1/64 <br/>
**2001:DB8:ACAD: 0000 0000 0000 01**01::1/64 <br/>
**2001:DB8:ACAD: 0000 0000 0000 01**10::1/64 <br/>
**2001:DB8:ACAD: 0000 0000 0000 01**11::1/64

How many bits match? **62**

4. Copy the matching bits and then add zero bits to determine the summarized network address.<br/>
2001:DB8:ACAD: 0000 0000 0000 0100::00

5. Convert the binary section back to hex.<br/>
2001:DB8:ACAD:0004::

6. Append the prefix of the summary route (result of Step 1c).<br/>
2001:DB8:ACAD:4::/62


**R3**

	en
	conf t

	ipv6 router ospf 1
	area 2 range 2001:DB8:ACAD:4::/62

## Reflection

1. Why would multiarea OSPFv3 be used?<br/>
Multiarea OSPFv3 can be used in large network domains to improve the efficiency of the routing process, decrease the size of routing tables, and decrease router CPU/memory processing requirements.

2. What is the benefit of configuring interarea route summarization?<br/>
Configuring interarea route summarization decreases the size of routing tables throughout the network domain and decreases the number of type 3 link state advertisements (LSAs) sent from area border routers to the backbone area. If one of the summarized networks is down, it does not necessarily cause the routers in other areas to return their SPF algorithm.