## Commands lab 6.2.3.8

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

	int lo0
	ip address 209.165.200.225 255.255.255.252

	int lo1
	ip address 192.168.1.1 255.255.255.0

	int lo2
	ip address 192.168.2.1 255.255.255.0

	int s0/0/0
	clock rate 128000
	bandwidth 128
	ip address 192.168.12.1 255.255.255.252
	no sh

	end

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

	int lo6
	ip address 192.168.6.1 255.255.255.0

	int s0/0/0
	bandwidth 128
	ip address 192.168.12.2 255.255.255.252
	no sh

	int s0/0/1
	bandwidth 128
	clock rate 128000
	ip address 192.168.23.1 255.255.255.252
	no sh

	end

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

	int lo4
	ip address 192.168.4.1 255.255.255.0

	int lo5
	ip address 192.168.5.1 255.255.255.0

	int s0/0/1
	bandwidth 128
	ip address 192.168.23.2 255.255.255.252
	no sh
	
	end

	copy running-config startup-config
    
## Part 2: Configure a Multiarea OSPFv2 Network
    
Backbone routers: R1 and R2 (area 0 = backbone area)

ASBR: R1 (connects to the internet)

ABR: R1 and R1 (because they are placed between 2 areas)

Internal router: R3

**R1**

    en
    conf t
    
    router ospf 1
    router-id 1.1.1.1

    network 192.168.1.0 0.0.0.255 area 1
    network 192.168.2.0 0.0.0.255 area 1
    network 192.168.12.0 0.0.0.3 area 0
    
    passive-interface lo1
    passive-interface lo2
    
    exit
    
    ip route 0.0.0.0 0.0.0.0 lo0
    
    router ospf 1
    default-information originate

**R2**

    en
    conf t
    
    router ospf 1
    router-id 2.2.2.2
    
    network 192.168.6.0 0.0.0.255 area 3
    network 192.168.12.0 0.0.0.3 area 0
    network 192.168.23.0 0.0.0.3 area 3
    
    passive-interface lo6

**R3**

    en
    conf t
    
    router ospf 1
    router-id 3.3.3.3
    
    network 192.168.4.0 0.0.0.255 area 3
    network 192.168.5.0 0.0.0.255 area 3
    network 192.168.23.0 0.0.0.3 area 3
    
    passive-interface lo4
    passive-interface lo5

Router types:

R1: ASBR and ABR

R2: ABR

R3: Internal Router	

**R1**

    en
    conf t
    
    int s0/0/0
    ip ospf message-digest-key 1 md5 Cisco123
    ip ospf authentication message-digest

**R2**

    en
    conf t
    
    int s0/0/0
    ip ospf message-digest-key 1 md5 Cisco123
    ip ospf authentication message-digest
    
    int s0/0/1
    ip ospf message-digest-key 1 md5 Cisco123
    ip ospf authentication message-digest

**R3**

    en
    conf t
    
    int s0/0/1
    ip ospf message-digest-key 1 md5 Cisco123
    ip ospf authentication message-digest

Why is it a good idea to verify that OSPF is functioning correctly before configuring OSPF authentication?

Troubleshooting OSPF problems is much easier if OSPF adjacencies have been established and verified before implementing authentication. You then know that your authentication implementation is flawed, as adjacencies do not re-establish.

## Part 3: Configure Interarea Summary Routes

**Summary routes area 1:**

192.168.000000|01.00000000 192.168.1.0/24

192.168.000000|10.00000000 192.168.2.0/24

---
192.168.000000|00.00000000 192.168.0.0/22


**R1**

	en
	conf t
    router ospf 1
    area 1 range 192.168.0.0 255.255.252.0

**Summary routes area 3:**

192.168.000001|00.00000000 192.168.4.0/24

192.168.000001|01.00000000 192.168.5.0/24

192.168.000001|10.00000000 192.168.6.0/24

---
192.168.000001|00.00000000 192.168.4.0/22

**R2**

	en
	conf t
    router ospf 1
    area 3 range 192.168.4.0 255.255.252.0

## Reflection

What are three advantages for designing a network with multiarea OSPF?

1. Smaller routing tables
2. Reduced link-state update overhead
3. Reduced frequency of SPF calculations
