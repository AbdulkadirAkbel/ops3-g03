## Commands lab 6.2.3.8

### Part 1: Build the Network and Verify Connectivity

**R1**

```
Router>en
Router#conf t
Enter configuration commands, one per line.  End with CNTL/Z.
Router(config)#hostname R1
Router(config)#int g0/0
Router(config-if)#ip address 192.168.1.1 255.255.255.0
Router(config-if)#no shut

Router(config-if)#
%LINK-5-CHANGED: Interface GigabitEthernet0/0, changed state to up

Router(config-if)#int s0/0/0
Router(config-if)#ip add 10.1.1.1 255.255.255.252
Router(config-if)#clock rate 128000
This command applies only to DCE interfaces
Router(config-if)#no shut

%LINK-5-CHANGED: Interface Serial0/0/0, changed state to down
Router(config-if)#int s0/0/1
Router(config-if)#ip add 10.3.3.1 255.255.255.252
Router(config-if)#no shut

%LINK-5-CHANGED: Interface Serial0/0/1, changed state to down

```
**R2**

```
Router>en
Router#conf t
Enter configuration commands, one per line.  End with CNTL/Z.
Router(config)#hostname R2
R2(config)#int g0/0
R2(config-if)#ip add
R2(config-if)#ip address 192.168.2.1 255.255.255.0
R2(config-if)#no shut

R2(config-if)#
%LINK-5-CHANGED: Interface GigabitEthernet0/0, changed state to up

R2(config-if)#int s0/0/0
R2(config-if)#ip add
R2(config-if)#ip address 10.1.1.2 255.255.255.252
R2(config-if)#no shut

R2(config-if)#
%LINK-5-CHANGED: Interface Serial0/0/0, changed state to up
	
R2(config-if)#int s0/0/1
R2(config-if)#ip add
R2(config-if)#ip address 10.2.2.2 255.255.255.252
R2(config-if)#clock rate 128000
R2(config-if)#no shut

%LINK-5-CHANGED: Interface Serial0/0/1, changed state to down
```

**R3**

```
Router>en
Router#conf t
Enter configuration commands, one per line.  End with CNTL/Z.
Router(config)#hostname R3
R3(config)#int g0/0
R3(config-if)#ip address 192.168.3.1 255.255.255.0
R3(config-if)#no shut

R3(config-if)#
%LINK-5-CHANGED: Interface GigabitEthernet0/0, changed state to up

R3(config-if)#int S0/0/0
R3(config-if)#ip address 10.3.3.2 255.255.255.252
R3(config-if)#clock rate 128000
R3(config-if)#no shut

R3(config-if)#
%LINK-5-CHANGED: Interface Serial0/0/0, changed state to up

R3(config-if)#int 
%LINEPROTO-5-UPDOWN: Line protocol on Interface Serial0/0/0, changed state
	
R3(config-if)#int s0/0/1
R3(config-if)#ip address 10.2.2.1 255.255.255.252
R3(config-if)#no shut

R3(config-if)#
%LINK-5-CHANGED: Interface Serial0/0/1, changed state to up

%LINEPROTO-5-UPDOWN: Line protocol on Interface Serial0/0/1, changed state to up
```
    
### Part 2: Configure EIGRP Routing
    
