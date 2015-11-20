# Load testing van de LAMP aan de hand van Apache JMeter #

1. Zorg ervoor dat de lampstack en de collectd server up zijn (`vagrant up`).
2. Browse naar http://192.168.56.78/collectd/ waarbij we van de lampstack de *interface* en *memory* zullen bekijken per uur.
3. Open de volgende executable jar-file: apache-jmeter-2.13 /bin/ApacheJMeter
4. Vervolgens stellen we een basis test plan op in onze Apache JMeter waarbij we kunnen instellen hoeveel gebruikers gesimuleerd zullen worden. Deze gebruikers zullen HTTP requests sturen.
5. Rechterklik op Test Plan > Add Threads (Users) > Thread Group. Bij Numbers of Threads (users) kunnen we instellen hoeveel gebruikers we willen simuleren. Bij Ramp-Up period (in seconds) stellen we basis 10 in en bij Loop Count stellen we 1 in.
6. Rechterklik op Thread Group > Add Config Element > HTTP Requst Defaults. Bij de Server Name or IP stellen we het IP in van de lampstack (192.168.56.77). Bij het pad stellen met "/" in. 
7. Rechterklik op Thread Group > Add Config Element > HTTP Cookie Manager. 
8. Rechterklik op Thread Group > Add Sampler > HTTP Request. Bij de Server Name or IP stellen we het IP in van de lampstack (192.168.56.77). Bij het pad stellen met "/" in. 
9. Rechterklik op Thread Group > Add Listener > View Results in Table. Hierin zullen we onze verstuurde requests terug zien eens we het uitvoeren. 
10. Vervolgens kunnen we ons test plan uitvoeren door op het groene execute symbool te drukken. 
11. Dan kijken we in onze collectd server naar de grafieken om zo eventuele pieken te kunnen ontdekken.