##Commands lab 7.4.3.5

###Part 1: Build the Network and Verify Connectivity

**R1**

```
Router> en
Router# conf t
Enter configuration commands, one per line.  End with CNTL/Z.
R1(config)# no ip domain-lookup
R1(config)# hostname R1
R1(config)# enable secret class
R1(config)# line con 0
R1(config-line)# logging synchronous
R1(config-line)# password cisco
R1(config-line)# login
R1(config-line)# exit
R1(config)# line vty 0 4
R1(config-line)# password cisco
R1(config-line)# login
R1(config-line)# exit
R1(config)# banner motd #
Enter TEXT message.  End with the character '#'.
Unauthorized access is strictly prohibited and prosecuted to the full extent of the law. #
R1(config) exit
R1# copy running-config startup-config

R1# conf t
R1(config)# int g0/0
R1(config-if)# ipv6 address 2001:D88:ACAD:A::1/64
R1(config-if)# ipv6 address fe80::1 link-local
R1(config-if)# no shut
R1(config-if)# int s0/0/0
R1(config-if)# ipv6 address 2001:D88:ACAD:12::1/64
R1(config-if)# ipv6 address fe80::1 link-local
R1(config-if)# clock rate 128000
This command applies only to DCE interfaces
R1(config-if)# no shut
R1(config-if)# int s0/0/1
R1(config-if)# ipv6 address 2001:D88:ACAD:13::1/64
R1(config-if)# ipv6 address fe80::1 link-local
R1(config-if)# no shut

```
**R2**

```
Router> en
Router# conf t
Enter configuration commands, one per line.  End with CNTL/Z.
Router(config)# hostname R2
Enter configuration commands, one per line.  End with CNTL/Z.
R2(config)# no ip domain-lookup
R2(config)# hostname R2
R2(config)# enable secret class
R2(config)# line con 0
R2(config-line)# logging synchronous
R2(config-line)# password cisco
R2(config-line)# login
R2(config-line)# exit
R2(config)# line vty 0 4
R2(config-line)# password cisco
R2(config-line)# login
R2(config-line)# exit
R2(config)# banner motd #
Enter TEXT message.  End with the character '#'.
Unauthorized access is strictly prohibited and prosecuted to the full extent of the law. #
R2(config) exit
R2# copy running-config startup-config

R2# conf t
R2(config)# int g0/0
R2(config-if)# ipv6 address 2001:D88:ACAD:B::1/64
R2(config-if)# ipv6 address fe80::2 link-local
R2(config-if)# no shut
R2(config-if)# int s0/0/0
R2(config-if)# ipv6 address 2001:D88:ACAD:12::2/64
R2(config-if)# ipv6 address fe80::2 link-local
R2(config-if)# no shut
R2(config-if)# int s0/0/1
R2(config-if)# ipv6 address 2001:D88:ACAD:23::2/64
R2(config-if)# ipv6 address fe80::2 link-local
R2(config-if)# clock rate 128000
R2(config-if)# no shut
```

**R3**

```
Router> en
Router# conf t
Enter configuration commands, one per line.  End with CNTL/Z.
R3(config)# no ip domain-lookup
R3(config)# hostname R3
R3(config)# enable secret class
R3(config)# line con 0
R3(config-line)# logging synchronous
R3(config-line)# password cisco
R3(config-line)# login
R3(config-line)# exit
R3(config)# line vty 0 4
R3(config-line)# password cisco
R3(config-line)# login
R3(config-line)# exit
R3(config)# banner motd #
Enter TEXT message.  End with the character '#'.
Unauthorized access is strictly prohibited and prosecuted to the full extent of the law. #
R3(config) exit
R3# copy running-config startup-config

R3# conf t
R3(config)# int g0/0
R3(config-if)# ipv6 address 2001:D88:ACAD:C::1/64
R3(config-if)# ipv6 address fe80::3 link-local
R3(config-if)# no shut
R3(config-if)# int s0/0/0
R3(config-if)# ipv6 address 2001:D88:ACAD:13::3/64
R3(config-if)# ipv6 address fe80::3 link-local
R3(config-if)# clock rate 128000
R3(config-if)# no shut
R3(config-if)# int s0/0/1
R3(config-if)# ipv6 address 2001:D88:ACAD:23::3/64
R3(config-if)# ipv6 address fe80::3 link-local
R3(config-if)# no shut
```
    
###Part 2: Configure EIGRP Routing

**R1**

```R1(config)# ipv6 unicast-routing
R1(config)# ipv6 router eigrp 1
R1(config-rtr)# router-id 1.1.1.1
R1(config-rtr)# no shutdown

R1(config-rtr)# exit
R1(config)# interface g0/0
R1(config-if)# ipv6 eigrp 1
R1(config-if)# interface s0/0/0
R1(config-if)# ipv6 eigrp 1
R1(config-if)# interface s0/0/1
R1(config-if)# ipv6 eigrp 1
```

**R2**

```
R2(config)# ipv6 unicast-routing
R2(config)# ipv6 router eigrp 1
R2(config-rtr)# router-id 2.2.2.2
R2(config-rtr)# no shutdown

R2(config-rtr)# exit
R2(config)# interface g0/0
R2(config-if)# ipv6 eigrp 1
R2(config-if)# interface s0/0/0
R2(config-if)# ipv6 eigrp 1
R2(config-if)# interface s0/0/1
R2(config-if)# ipv6 eigrp 1
```

**R3**

```
R3(config)# ipv6 unicast-routing
R3(config)# ipv6 router eigrp 1
R3(config-rtr)# router-id 3.3.3.3
R3(config-rtr)# no shutdown

R3(config-rtr)# exit
R3(config)# int g0/0
R3(config-if)# ipv6 eigrp 1
R3(config-if)# int s0/0/0
R3(config-if)# ipv6 eigrp 1
R3(config-if)# int s0/0/1
R3(config-if)# ipv6 eigrp 1
```

###Part 3: Verify EIGRP Routing

**R1**

```
R1# show ipv6 eigrp neighbors
R1# show ipv6 route eigrp
show ipv6 eigrp topology
R1# show ipv6 protocols
```

###Part 4: Configure Passive Interfaces

**R1**

```
R1(config)# ipv6 router eigrp 1 
R1(config-rtr)# passive-interface g0/0
R1(config-rtr)# exit
R1(config)# exit
R1# show ipv6 protocols
```

**R2**

```
R2(config)# ipv6 router eigrp 1 R2(config-rtr)# passive-interface g0/0
```

**R3**

```
R3(config)# ipv6 router eigrp 1 
R3(config-rtr)# passive-interface default
```