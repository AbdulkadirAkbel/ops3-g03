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

**Labo 7.2.2.5**

1. Pingen van R1 naar R2 lukt.
2. Pingen van R1 naar R3 lukt.
3. Pingen van R2 naar R1 lukt.
4. Pingen van R2 naar R3 lukt.
5. Pingen van R3 naar R1 lukt.
6. Pingen van R3 naar R2 lukt.
7. Pingen van PC-A naar PC-B lukt.
8. Pingen van PC-A naar PC-C lukt.
9. Pingen van PC-B naar PC-A lukt.
10. Pingen van PC-B naar PC-C lukt.
11. Pingen van PC-C naar PC-A lukt.
12. Pingen van PC-C naar PC-B lukt.
13. Bekijk de eigrp neigbors (`show ip eigrp neighbors`)
14. Bekijk de routeringsprotocol. Het moet "eigrp 10" zijn. (`show ip protocols`)
15. Bekijk de routeringstabel. De routes moeten aanwezig zijn. (`show ip route eigrp`)
16. Bekijk de topologytabel. De juist topology moet aanwezig zijn. (`show ip eigrp topology`)

**Labo 7.4.3.5**

1. Pingen van R1 naar R2 lukt.
2. Pingen van R1 naar R3 lukt.
3. Pingen van R2 naar R1 lukt.
4. Pingen van R2 naar R3 lukt.
5. Pingen van R3 naar R1 lukt.
6. Pingen van R3 naar R2 lukt.
7. Pingen van PC-A naar PC-B lukt.
8. Pingen van PC-A naar PC-C lukt.
9. Pingen van PC-B naar PC-A lukt.
10. Pingen van PC-B naar PC-C lukt.
11. Pingen van PC-C naar PC-A lukt.
12. Pingen van PC-C naar PC-B lukt.
13. Bekijk de eigrp neigbors (`show ipv6 eigrp neighbors`)
14. Bekijk de routeringsprotocol. Het moet "eigrp 1" zijn. (`show ipv6 protocols`)
15. Bekijk de routeringstabel. De routes moeten aanwezig zijn. (`show ipv6 route eigrp`)
16. Bekijk de topologytabel. De juist topology moet aanwezig zijn. (`show ipv6 eigrp topology`)


**Fysiek labo 6.2.3.8**

1. Pingen van R1 naar R2 lukt.
2. Pingen van R1 naar R3 lukt.
3. Pingen van R2 naar R1 lukt.
4. Pingen van R2 naar R3 lukt.
5. Pingen van R3 naar R1 lukt.
6. Pingen van R3 naar R2 lukt.
7. Bekijk de routeringsprotocol. Het moet "ospf 1" zijn en de netwerken moeten aanwezig zijn. (`show ip protocols`)
8. Bekijk de routeringstabel. De routes moeten aanwezig zijn. (`show ip route ospf`)

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

**Labo 7.2.2.5**

1. OK
2. OK
3. OK
4. OK
5. OK
6. OK
7. OK
8. OK
9. OK
10. OK
11. OK
12. OK
13. OK
14. OK
15. OK
16. OK

**Labo 7.4.3.5**

1. OK
2. Pingen van R1 naar R3 lukt.
3. OK
4. Pingen van R2 naar R3 lukt.
5. Pingen van R3 naar R1 lukt.
6. Pingen van R3 naar R2 lukt.
7. OK
8. Pingen van PC-A naar PC-C lukt.
9. OK
10. Pingen van PC-B naar PC-C lukt.
11. Pingen van PC-C naar PC-A lukt.
12. Pingen van PC-C naar PC-B lukt.
13. OK
14. OK
15. OK
16. OK


**Fysiek labo 6.2.3.8**

1. OK
2. OK
3. OK
4. OK
5. OK
6. OK
7. OK
8. OK