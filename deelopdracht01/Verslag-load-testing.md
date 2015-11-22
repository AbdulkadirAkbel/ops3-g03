# Verslag: load testing van een eenvoudige LAMP-stack #

Gekozen framework voor load-testing: Apache JMeter.


**Test 1: weinig load (random pagina’s, of browsen van ene link naar de andere).**

Voor het testen van onze Wordpress aan de hand van weinig load hebben we handmatig gebrowsed naar bepaalde posts, comments, categories gedurende enkele minuten lang. Als resultaat zien we dat er een heel kleine hoeveelheid van verkeer ontstaat die we terug kunnen zien op onze monitoring grafiek van onze collectd server. 

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/load-testing-printscreens/browsen-load-memory)

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/load-testing-printscreens/browsen-load)



**Test 2: veel load (in verschillende grootte-ordes, bv 10, 1.000, 100.000, … requests per seconde en parallelle gebruikers).**






**Test 3: sommige gebruikers geven af en toe commentaar op artikels.**





**Test 4: “Slashdot”- of “Hacker News”-effect (een specifiek blogartikel wordt vermeld op een populaire nieuws-site en ineens komen er enorm veel requests binnen voor die ene pagina, naast de “normale” load voor de rest van de site.).**


