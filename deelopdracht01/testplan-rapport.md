## Testplan en -rapport taak 1: lamp-stack met load testing

* Verantwoordelijke uitvoering: Andy
* Verantwoordelijke testen: Anthony

### Testplan

Auteur(s) testplan: Andy

- Pingen van lamp naar collectd en omgekeerd lukt.
- We kunnen via de host de Wordpress-pagina bereiken van de LAMP stack.
- We kunnen via de host de PhpMyAdmin pagina bereiken van de LAMP stack.
- Nagaan of de collectd aan het draaien is.
- Monitoring server schrijft de monitoring resultaten naar de rrd bestanden.
- Metrieken worden gevisualiseerd aan de hand van de collectd-web
- Bij het testen aan de hand van Apache JMeter zien we pieken in de metrieken van de LAMP


### Testrapport

Uitvoerder(s) test: Anthony

- Bij commando op de lamp stack: 'ip a' zien we dat het ip address van de lamp 192.168.56.77 is.
- Bij commando op de collectd server: 'ip a' zien we dat het ip address van de collectd server 192.168.56.78 is.
- Na de 'vagrant up' van de collectd server en de 'vagrant ssh collectd' voeren we het volgende commando uit voor te pingen naar de LAMP stack: ping 192.168.56.77. De ping wordt succesvol uitgevoerd.
- Na de 'vagrant up' van de LAMP stack en de 'vagrant ssh lamp' voeren we het volgende commando uit voor te pingen naar de collectd server: ping 192.168.56.78. De ping wordt succesvol uitgevoerd.
- Wanneer we op de host surfen naar http://192.168.56.77/wordpress/ wanneer onze lampstack draait, komen we succesvol terecht op de Wordpress pagina van de lampstack.
- Wanneer we op de host surfen naar http://192.168.56.77/phpmyadmin/ wanneer onze lampstack draait, komen we succesvol terecht op de PhpMyAdmin pagina van de lampstack. Ook wanneer we surfen naar http://192.168.56.77, komen we terecht op de infopagina van php die geconfigureerd staat in de www/index.php
- Wanneer we ingelogd zijn op de collectd en we het volgende commando uitvoeren: 'service collectd status' zien we dat de collectd aan het draaien is (weergave: "active (running)").
- Wanneer we naar de directory /var/lib/collectd/rrd (cd /var/lib/collectd/rrd/collectd) gaan zien we verschillende folders met een benaming die aangeeft wat voor montitoring informatie die zal bevatten. Collectd verzamelt dus succesvol de monitoring informatie over de LAMP stack in deze rrd files. 
- Wanneer we browsen naar het IP van de collectd server: 192.168.56.78/collectd/, komen we terecht op de collectd-web waarbij we een overzicht krijgen van de status van de cpu, interface, load en memory van de servers (lampstack en collectd) aan de hand van statistieken die automatisch gegenereerd worden aan de hand van de rrd files.
- Wanneer we een test uitvoeren op de Apache JMeter applicatie met een aantal gebruikers van bijvoorbeeld 500, zien we dat er pieken ontstaan als gevolg van het versturen van HTTP-requests.
