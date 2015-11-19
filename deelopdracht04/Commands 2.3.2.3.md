#Labo 2.3.2.3 Configuring Rapid PVST+, PortFast, and BPDU Guard stappen#
##Switch 1##

    en
    conf t
    hostname S1
    int range fa0/1-24, g1/1
    shut

##Switch 2##

    en 
    conf t
    hostname S2
    int range fa0/1-24, g1/1-2
    shut

##Switch 3##

    en
    conf t
    hostname S3
    int range fa0/1-24, g1/1-2
    shut



##Switch 1##

    vlan 10
    name User
    vlan 99
    name Management
    exit
    int fa0/6
    switchport mode access
    switchport access vlan 10
    int range fa0/1, fa0/3
    switchport mode trunk
    switchport trunk native vlan 99
    exit


##Switch 2##

    vlan 10
    name User
    vlan 99
    name Management
    exit
    int range fa0/1, fa0/3
    switchport mode trunk
    switchport trunk native vlan 99


##Switch 3##

    vlan 10
    name User
    vlan 99
    name Management
    exit
    int fa0/18
    switchport mode access
    switchport access vlan 10
    int range fa0/1, fa0/3
    switchport mode trunk
    switchport trunk native vlan 99


##Switch 1##

    int range fa0/1, fa0/3
    no shut
    int fa0/6
    no shut


##Switch 2##

    int range fa0/1, fa03
    no shut


##Switch 3##

    int range fa0/1, fa0/3
    no shut
    int fa0/18
    no shut
    

##Switch 1##

    conf t
    int vlan 99
    ip address 192.168.1.11 255.255.255.0
    no shut


##Switch 2##

    int vlan 99
    ip address 192.168.1.12 255.255.255.0
    no shut


##Switch 3##

    int vlan 99
    ip address 192.168.1.13 255.255.255.0
    no shut


##Testen in switch 1##

    show vlan brief
    show interfaces trunk
    show running-config

##Switch 1##

    show spanning-tree

##Switch 2##

    show spanning-tree

S2 is root bridge

    en 
    conf t
    spanning-tree vlan 1 root primary
    spanning-tree vlan 10 root primary
    spanning-tree vlan 99 root primary


##Switch 1##

    en
    conf t
    spanning-tree vlan 1 root secondary
    spanning-tree vlan 10 root secondary
    spanning-tree vlan 99 root secondary
    exit
    show spanning-tree

##Switch 3##

    en 
    show spanning-tree

##Switch 1##

    en 
    conf t
    spanning-tree mode rapid-pvst

##Switch 2##

    spanning-tree mode rapid-pvst

##Switch 3##
    
    spanning-tree mode rapid-pvst

##Switch 1##

    conf t
    int fa0/6
    spanning-tree portfast
    spanning-tree bpduguard enable

##Switch 3##

    conf t
    spanning-tree portfast 
    spanning-tree bpduguard enable
    exit

#Labo 2.3.2.3 Configuring Rapid PVST+, PortFast, and BPDU Guard vragen#

What is the default setting for spanning-tree mode on Cisco switches? **Spanning tree pvst+**

Verify connectivity between PC-A and PC-C. Was your ping successful? **Yes**

Which command allows a user to determine the spanning-tree status of a Cisco Catalyst switch for all VLANs? Write the command in the space provided. **show spanning-tree**

What is the bridge priority of switch S1 for VLAN 1? **28673**<br>
What is the bridge priority of switch S2 for VLAN 1? **24577** <br>
What is the bridge priority of switch S3 for VLAN 1? **32769**

Which switch is the root bridge? **Switch 2**

Why was this switch elected as the root bridge? **Omdat S2 het laagste MAC adres heeft**

a. Configure switch S2 to be the primary root bridge for all existing VLANs. Write the command in the space provided. **spanning-tree vlan # root primary**

b. Configure switch S1 to be the secondary root bridge for all existing VLANs. Write the command in the space provided. **spanning-tree vlan # root secondary**

Use the show spanning-tree command to answer the following questions:
What is the bridge priority of S1 for VLAN 1? **28673**<br>
What is the bridge priority of S2 for VLAN 1? **24577** <br>
Which interface in the network is in a blocking state? **Fa0/3 op switch 3**

Through which port states do each VLAN on F0/3 proceed during network convergence? **Listening, learning, forwarding**

Configure S1 for Rapid PVST+. Write the command in the space provided. **spanning-tree mode rapid-pvst**

a. Configure interface F0/6 on S1 with PortFast. Write the command in the space provided. <br>**int fa0/6<br>**
**spanning-tree portfast**

b. Configure interface F0/6 on S1 with BPDU guard. Write the command in the space provided. <br>
**spanning-tree bpduguard enable**

c. Globally configure all non-trunking ports on switch S3 with PortFast. Write the command in the space provided.<br>
**spanning-tree portfast default**

d. Globally configure all non-trunking PortFast ports on switch S3 with BPDU guard. Write the command in the space provided.
**spanning-tree portfase bpduguard default**


1. What is the main benefit of using Rapid PVST+? **De tijd**
2. How does configuring a port with PortFast allow for faster convergence? **Het is sneller omdat een spanning tree niet alle poorten moet gaan berekenen**
3. What protection does BPDU guard provide? **de poort dat deze feature gebruikt, maakt een netwerk veiliger omdat end devices geen bpdu moeten verzenden.**