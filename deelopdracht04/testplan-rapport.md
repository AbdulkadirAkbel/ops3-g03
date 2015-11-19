## Testplan en -rapport taak 4: Cisco

* Verantwoordelijke uitvoering: `Nicolai`
* Verantwoordelijke testen: `Andy`

### Testplan

Auteur(s) testplan: Abdülkadir, Andy, Anthony, Nicolai

**Labo 2.3.2.3**

1. Pingen van PCA naar PC1 lukt.
2. Pingen van PC1 naar PCA lukt.
3. VLAN configuratie nagaan op de 3 switches (`show vlan brief`)
4. Trunk interfaces configuratie nagaan op de 3 switches (`show interfaces trunk`)
5. De algemene configuratie nagaan op de 3 switches (`show running-config`)

**Labo 6.2.3.8**

1. Pingen van R1 naar R2 lukt.
2. Pingen van R1 naar R3 lukt.
3. Pingen van R2 naar R1 lukt.
4. Pingen van R2 naar R3 lukt.
5. Pingen van R3 naar R1 lukt.
6. Pingen van R3 naar R2 lukt.
7. Bekijk de routeringsprotocol. Het moet "ospf 1" zijn en de netwerken moeten aanwezig zijn. (`show ip protocols`)
8. Bekijk de routeringstabel. De routes moeten aanwezig zijn. (`show ip route ospf`)

**Labo 6.2.3.9**

1. Pingen van R1 naar R2 lukt.
2. Pingen van R1 naar R3 lukt.
3. Pingen van R2 naar R1 lukt.
4. Pingen van R2 naar R3 lukt.
5. Pingen van R3 naar R1 lukt.
6. Pingen van R3 naar R2 lukt.
7. Bekijk de routeringsprotocol. Het moet "ospfv3 1" zijn. (`show ipv6 ospf`)
8. Bekijk de routeringstabel. De routes moeten aanwezig zijn. (`show ipv6 route ospf`)


### Testrapport

Uitvoerder(s) test: Abdülkadir, Andy, Anthony, Nicolai

**Labo 2.3.2.3**

1. Ok
2. OK
3. OK
4. OK
5. OK

**Labo 6.2.3.8**

1. OK
2. OK
3. OK
4. OK
5. OK
6. OK
7. OK
8. OK

**Labo 6.2.3.9**

1. OK
2. OK
3. OK
4. OK
5. OK
6. OK
7. OK
8. OK
