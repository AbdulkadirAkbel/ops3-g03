##Commands lab 7.2.2.5

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
R1(config)# exit
R1# copy running-config startup-config

R1(config)# int g0/0
R1(config-if)# ip address 192.168.1.1 255.255.255.0
R1(config-if)# no shut
R1(config-if)#
%LINK-5-CHANGED: Interface GigabitEthernet0/0, changed state to up
R1(config-if)# int s0/0/0
R1(config-if)# ip add 10.1.1.1 255.255.255.252
R1(config-if)# clock rate 128000
This command applies only to DCE interfaces
Router(config-if)# no shut
%LINK-5-CHANGED: Interface Serial0/0/0, changed state to down
R1(config-if)# int s0/0/1
R1(config-if)# ip add 10.3.3.1 255.255.255.252
R1(config-if)# no shut
%LINK-5-CHANGED: Interface Serial0/0/1, changed state to down

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
R2(config)#line vty 0 4
R2(config-line)# password cisco
R2(config-line)# login
R2(config-line)# exit
R2(config)# banner motd #
Enter TEXT message.  End with the character '#'.
Unauthorized access is strictly prohibited and prosecuted to the full extent of the law. #
R2(config)# exit
R2# copy running-config startup-config

R2(config)# int g0/0
R2(config-if)# ip add
R2(config-if)# ip address 192.168.2.1 255.255.255.0
R2(config-if)# no shut
R2(config-if)#
%LINK-5-CHANGED: Interface GigabitEthernet0/0, changed state to up
R2(config-if)# int s0/0/0
R2(config-if)# ip add
R2(config-if)# ip address 10.1.1.2 255.255.255.252
R2(config-if)# no shut
R2(config-if)#
%LINK-5-CHANGED: Interface Serial0/0/0, changed state to up
R2(config-if)# int s0/0/1
R2(config-if)# ip add
R2(config-if)# ip address 10.2.2.2 255.255.255.252
R2(config-if)# clock rate 128000
R2(config-if)# no shut
%LINK-5-CHANGED: Interface Serial0/0/1, changed state to down
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
R3(config)# exit
R3# copy running-config startup-config

R3(config)# int g0/0
R3(config-if)# ip address 192.168.3.1 255.255.255.0
R3(config-if)# no shut
R3(config-if)#
%LINK-5-CHANGED: Interface GigabitEthernet0/0, changed state to up
R3(config-if)# int S0/0/0
R3(config-if)# ip address 10.3.3.2 255.255.255.252
R3(config-if)# clock rate 128000
R3(config-if)# no shut
R3(config-if)#
%LINK-5-CHANGED: Interface Serial0/0/0, changed state to up
%LINEPROTO-5-UPDOWN: Line protocol on Interface Serial0/0/0, changed state
R3(config-if)# int s0/0/1
R3(config-if)# ip address 10.2.2.1 255.255.255.252
R3(config-if)# no shut
R3(config-if)#
%LINK-5-CHANGED: Interface Serial0/0/1, changed state to up
%LINEPROTO-5-UPDOWN: Line protocol on Interface Serial0/0/1, changed state to up
```
    
###Part 2: Configure EIGRP Routing

**R1**

```R1(config)# router eigrp 10
R1(config-router)# network 10.1.1.0 0.0.0.3 
R1(config-router)# network 192.168.1.0 0.0.0.255 
R1(config-router)# network 10.3.3.0 0.0.0.3
```

**R2**

```
R1(config)#router eigrp 10
R1(config-router)#network 192.168.2.1 0.0.0.255
R1(config-router)#network 10.1.1.2 0.0.0.3
R1(config-router)#
%DUAL-5-NBRCHANGE: IP-EIGRP 10: Neighbor 10.1.1.1 (Serial0/0/0) is up: new adjacency

R1(config-router)#network 10.2.2.2 0.0.0.3
```

**R3**

```
R1(config)#router eigrp 10
R1(config-router)#network 192.168.3.1 0.0.0.255
R1(config-router)#network 10.3.3.2 0.0.0.3
R1(config-router)#
%DUAL-5-NBRCHANGE: IP-EIGRP 10: Neighbor 10.3.3.1 (Serial0/0/0) is up: new adjacency

R1(config-router)#network 10.2.2.1 0.0.0.3
R1(config-router)#
%DUAL-5-NBRCHANGE: IP-EIGRP 10: Neighbor 10.2.2.2 (Serial0/0/1) is up: new adjacency
```

###Part 3: Verify EIGRP Routing

**R1**

```R1# show ip eigrp neighbors
R1# show ip route eigrp
R1# show ip eigrp topology
R1# show ip protocols
```

###Part 4: Configure Bandwidth and Passive Interfaces

**R1**

```
R1# show interface s0/0/0

R1(config)# interface s0/0/0 
R1(config-if)# bandwidth 2000 
R1(config-if)# interface s0/0/1 
R1(config-if)# bandwidth 64

R1# show interface s0/0/0

R1(config)# router eigrp 10 
R1(config-router)# passive-interface g0/0

R1# show ip protocols
```

**R2**

```
R2(config)# interface s0/0/0 
R2(config-if)# bandwidth 2000 
R2(config-if)# interface s0/0/1 
R2(config-if)# bandwidth 2000

R2(config)# router eigrp 10 
R2(config-router)# passive-interface g0/0
```

**R3**

```
R3(config)# interface s0/0/0 
R3(config-if)# bandwidth 64 
R3(config-if)# interface s0/0/1 
R3(config-if)# bandwidth 2000

R3(config)# router eigrp 10 
R3(config-router)# passive-interface g0/0
```