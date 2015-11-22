# Verslag: load testing van een eenvoudige LAMP-stack #

Gekozen framework voor load-testing: Apache JMeter.


**Test 1: weinig load (random pagina’s, of browsen van ene link naar de andere).**

Voor het testen van onze Wordpress aan de hand van weinig load hebben we handmatig gebrowsed naar bepaalde posts, comments, categories gedurende enkele minuten lang. Als resultaat zien we dat er een heel kleine hoeveelheid van verkeer ontstaat die we terug kunnen zien op onze monitoring grafiek van onze collectd server. 

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/load-testing-printscreens/browsen-load-memory.PNG)

Hier zien we de eerste grote piek die het gevolg is van van een aantal gebruikers van 1000 gebruikers die tegelijkertijd requests sturen. De 2e (veel kleinere stijging) die we zien is het gevolg van het handmatig browsen door de Wordpress pagina met een gebruiker. We zien dat dit nog steeds vrij hoog is vergeleken met de hoge piek. Een mogelijke oplossing hiervoor is de RAM te vergroten door het volgende in de vagrantfile te zetten:

    config.vm.provider :virtualbox do |v|
    v.memory = 1024 
    v.cpus = 2
    end

Hier hebben we nu dus een RAM van 1GB, maar we kunnen dit natuurlijk ook nog vergroten, afhankelijk van hoeveel RAM we hebben op onze host-machine.

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/load-testing-printscreens/browsen-load.PNG)

Ook hier zien we eerst terug een grotere piek die dezelfde reden heeft als bij de eerdere screenshot van het RAM geheugen. Ook daarna zien we opnieuw een heel kleine stijging in activiteit in onze interface die het gevolg is van het handmatig browsen door de Wordpress pagina.

**Test 2: veel load (in verschillende grootte-ordes, bv 10, 1.000, 100.000, … requests per seconde en parallelle gebruikers).**

**50 gebruikers**

TODO

**1000 gebruikers**

Om veel load te simuleren zullen we gebruik maken van Apache JMeter.

Vervolgens zullen we instellen om 1000 gebruikers te simuleren.
Bij "Numbers of Threads (users):" zien we dus dat het aantal gebruikers is ingesteld op 1000.

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/load-testing-printscreens/1000-users.PNG)

Eens we dit test-plan hebben uitgevoerd voor 1000 gebruikers te simuleren, zien we in de tabel dat al de HTTP requests succesvol uitgevoerd gewees zijn. Dit zien we door de groene vinkjes. Onze webpagina bleef dus beschikbaar bij deze grote aanvraag. 

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/load-testing-printscreens/1000-users-alles-slaagt.PNG)

Op het einde van deze grafiek zien we hier een piek die onze simulatie voorstelt van 1000 gebruikers. Ook hier zien we dat het misschien geen slecht idee is om ons RAM te verhogen.

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/load-testing-printscreens/1000-users-memory.PNG)

Hier zien we opnieuw de laatste piek die de simulatie van 1000 gebruikers voorstelt. 

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/load-testing-printscreens/1000-users-interface.PNG)

Kortom, onze webpagina heeft geen problemen gehad om zo'n groot aantal requests te verwerken.

**1500 gebruikers**

TODO

**Test 3: sommige gebruikers geven af en toe commentaar op artikels.**





**Test 4: “Slashdot”- of “Hacker News”-effect (een specifiek blogartikel wordt vermeld op een populaire nieuws-site en ineens komen er enorm veel requests binnen voor die ene pagina, naast de “normale” load voor de rest van de site.).**


