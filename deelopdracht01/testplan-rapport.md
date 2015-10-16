## Testplan en -rapport taak 1: lamp-stack

* Verantwoordelijke uitvoering: Andy
* Verantwoordelijke testen: Anthony

### Testplan

Auteur(s) testplan: Andy

- Pingen van lamp naar collectd en omgekeerd lukt.
- We kunnen via de host de Wordpress-pagina bereiken van de LAMP stack.
- We kunnen via de host de PhpMyAdmin pagina bereiken van de LAMP stack.
- Nagaan of de collectd aan het draaien is.
- Monitoring server kan metrieken capteren van lamp.
- Metrieken worden gevisualiseerd op dashboard.
- Framework voor load testing kan load creëren op lamp. Monitoring server capteert hier ook metrieken van.


### Testrapport

Uitvoerder(s) test: Anthony

- Bij commando op de lamp stack: 'ip a' zien we dat het ip address van de lamp 192.168.56.77 is.
- Bij commando op de collectd server: 'ip a' zien we dat het ip address van de collectd server 192.168.56.78 is.
- Na de 'vagrant up' van de collectd server en de 'vagrant ssh collectd' voeren we het volgende commando uit voor te pingen naar de LAMP stack: ping 192.168.56.77. De ping wordt succesvol uitgevoerd.
- Na de 'vagrant up' van de LAMP stack en de 'vagrant ssh lamp' voeren we het volgende commando uit voor te pingen naar de collectd server: ping 192.168.56.78. De ping wordt succesvol uitgevoerd.
- Wanneer we op de host surfen naar http://192.168.56.77/wordpress/ wanneer onze lampstack draait, komen we succesvol terecht op de Wordpress pagina van de lampstack.
- Wanneer we op de host surfen naar http://192.168.56.77/phpmyadmin/ wanneer onze lampstack draait, komen we succesvol terecht op de PhpMyAdmin pagina van de lampstack. Ook wanneer we surfen naar http://192.168.56.77, komen we terecht op de infopagina van php die geconfigureerd staat in de www/index.php
- Wanneer we ingelogd zijn op de collectd en we het volgende commando uitvoeren: 'service collectd status' zien we dat de collectd aan het draaien is (weergave: "active (running)")
