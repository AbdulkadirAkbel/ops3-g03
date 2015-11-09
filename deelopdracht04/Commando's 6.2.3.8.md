## Commands lab 6.2.3.8

### Part 2: Build the Network and Configure Basic Device Settings

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
    

	




