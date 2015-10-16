## Testplan en -rapport taak 1: lamp-stack

* Verantwoordelijke uitvoering: Andy
* Verantwoordelijke testen: Anthony

### Testplan

Auteur(s) testplan: Andy

- Pingen van lamp naar collectd en omgekeerd lukt.
- We kunnen via de host de Wordpress-pagina bereiken van de LAMP stack
- Monitoring server kan metrieken capteren van lamp.
- Metrieken worden gevisualiseerd op dashboard.
- Framework voor load testing kan load creëren op lamp. Monitoring server capteert hier ook metrieken van.


### Testrapport

Uitvoerder(s) test: Anthony

- Na de 'vagrant up' van de collectd server en de 'vagrant ssh collectd' voeren we het volgende commando uit voor te pingen naar de LAMP stack: ping 192.168.56.77. De ping wordt succesvol uitgevoerd.
- Na de 'vagrant up' van de LAMP stack en de 'vagrant ssh lamp' voeren we het volgende commando uit voor te pingen naar de collectd server: ping 192.168.56.78. De ping wordt succesvol uitgevoerd.

