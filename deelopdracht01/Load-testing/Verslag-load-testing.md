# Verslag: load testing van een eenvoudige LAMP-stack #

Gekozen framework voor load-testing: Apache JMeter.


**Test 1: weinig load (random pagina’s, of browsen van ene link naar de andere).**

Voor het testen van onze Wordpress aan de hand van weinig load hebben we handmatig gebrowsed naar bepaalde posts, comments, categories gedurende enkele minuten lang. Als resultaat zien we dat er een heel kleine hoeveelheid van verkeer ontstaat die we terug kunnen zien op onze monitoring grafiek van onze collectd server. 

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/browsen-load-memory.PNG)

Hier zien we de eerste grote piek die het gevolg is van van een aantal gebruikers van 1000 gebruikers die tegelijkertijd requests sturen. De 2e (veel kleinere) stijging die we zien is het gevolg van het handmatig browsen door de Wordpress pagina met een gebruiker. We zien dat dit nog steeds vrij hoog is vergeleken met de hoge piek. Een mogelijke oplossing hiervoor is de RAM te vergroten door het volgende in de vagrantfile te zetten:

    config.vm.provider :virtualbox do |v|
    v.memory = 1024 
    v.cpus = 2
    end

Hier hebben we nu dus een RAM van 1GB, maar we kunnen dit natuurlijk ook nog vergroten, afhankelijk van hoeveel RAM we hebben op onze host-machine.

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/browsen-load.PNG)

Ook hier zien we eerst terug een grotere piek die dezelfde reden heeft als bij de eerdere screenshot van het RAM geheugen. Ook daarna zien we opnieuw een heel kleine stijging in activiteit in onze interface die het gevolg is van het handmatig browsen door de Wordpress pagina.

**Test 2: veel load (in verschillende grootte-ordes, bv 10, 1.000, 100.000, … requests per seconde en parallelle gebruikers).**

Om veel load te simuleren zullen we gebruik maken van Apache JMeter.

**50 gebruikers**

Als eerst zullen we instellen om 50 gebruikers te simuleren.
Bij "Numbers of Threads (users):" zien we dus dat het aantal gebruikers is ingesteld op 50.

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/50-users.PNG)

Eens we dit test-plan hebben uitgevoerd voor 50 gebruikers te simuleren, zien we in de tabel dat al de HTTP requests succesvol uitgevoerd geweest zijn. Dit zien we door de groene vinkjes. Onze webpagina bleef dus beschikbaar bij deze aanvraag van 50 gebruikers.

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/50-users-alles-slaagt.PNG)

Bij het RAM geheugen zien we een kleine verandering die in het zwart omcirkeld is. Dit is dus geen grote verandering.

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/50-users-memory.PNG)

Ook in de grafiek zien we in het rood omcirkeld waar de 50 gebruikers werden gesimuleerd. Ook hier zien we dat dit weinig problemen veroorzaakt. De piek rechts ervan is een piek die 800 gebruikers voorstelde.

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/50-users-interface.PNG)

Er waren dus geen problemen om de requests van 50 gebruikers te verwerken.

**1000 gebruikers**

Vervolgens zullen we instellen om 1000 gebruikers te simuleren.
Bij "Numbers of Threads (users):" zien we dus dat het aantal gebruikers is ingesteld op 1000.

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/1000-users.PNG)

Eens we dit test-plan hebben uitgevoerd voor 1000 gebruikers te simuleren, zien we in de tabel dat al de HTTP requests succesvol uitgevoerd geweest zijn. Dit zien we door de groene vinkjes. Onze webpagina bleef dus beschikbaar bij deze grote aanvraag. 

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/1000-users-alles-slaagt.PNG)

Op het einde van deze grafiek zien we hier een piek die onze simulatie voorstelt van 1000 gebruikers. Ook hier zien we dat het misschien geen slecht idee is om ons RAM te verhogen.

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/1000-users-memory.PNG)

Hier zien we opnieuw de laatste piek die de simulatie van 1000 gebruikers voorstelt. 

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/1000-users-interface.PNG)

Kortom, onze webpagina heeft ook hier geen problemen gehad om zo'n groot aantal requests te verwerken.

**1500 gebruikers**

Vervolgens zullen we instellen om 1500 gebruikers te simuleren.
Bij "Numbers of Threads (users):" zien we dus dat het aantal gebruikers is ingesteld op 1500.

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/1500-users.PNG)

Eens we dit test-plan hebben uitgevoerd voor 1500 gebruikers te simuleren, zien we in de tabel dat al de HTTP requests succesvol uitgevoerd geweest zijn tot we rond 1100 requests kwamen. Dan zien we bij de status vele uitroeptekens staan die wijzen op errors. Op dit moment was onze Wordpress-pagina niet meer beschikbaar. Deze was dan gedurende een 5-tal minuten niet meer beschikbaar. Op het einde van het testplan kwamen er terug groene vinkjes, betekenende dat de Wordpress pagina terug beschikbaar was.

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/1500-users-down.PNG)

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/1500-users-end-terug-up.PNG)

Bij het RAM geheugen zien we dat er een tijdje een bepaalde piek wordt aangehouden. De piek die even bleef duren was het gevolg van het simuleren van requests van 1500 gebruikers. Op deze piek was de Wordpress pagina niet meer te raadplegen en was hij dus down.

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/1500-users-memory.PNG)

Bij onze interfaces zien we dat er een heel grote piek ontstaat bij het instellen van 1500 gebruikers.

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/1500-users-interface.PNG)

Uit deze grafieken kunnen we concluderen dat onze LAMP stack problemen ervaart vanaf een 1500-tal gebruikers.

**Test 3: sommige gebruikers geven af en toe commentaar op artikels.**

TODO



**Test 4: “Slashdot”- of “Hacker News”-effect (een specifiek blogartikel wordt vermeld op een populaire nieuws-site en ineens komen er enorm veel requests binnen voor die ene pagina, naast de “normale” load voor de rest van de site.).**

Voor die onderdeel zullen we werken met 2 verschillende Apache JMeters waarbij we bij de ene Apache JMeter het Path instellen op "/" (wijzende op de volledige Wordpress) en anderzijds op "/wordpress/index.php/2015/11/03/demo-post-27-2/" wat specifiek voor één post is. 

Voor de Wordpress pagina volledig te testen hebben we al reeds gezien hoe we dit moeten ingeven in de tester, voor die voor 1 post te doen zal dit als volgend gedaan worden:
![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/25-users-post-27.PNG)
![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/25-users-post-27-1.PNG)


**25 gebruikers op Demo Post 27, 25 gebruikers op de algemene wordpress pagina**

Als eerst stellen voor beide Apache JMeter's de gebruikers in op 25.
Bij "Numbers of Threads (users):" zien we dus dat het aantal gebruikers is ingesteld op 25.

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/25-users.PNG)

Eens we dit test-plan hebben uitgevoerd voor 2 x 25 gebruikers te simuleren, zien we in de tabel dat al de HTTP requests succesvol uitgevoerd geweest zijn. Dit zien we door de groene vinkjes. Onze webpagina bleef dus beschikbaar bij deze grote aanvraag. Voor beide Apache JMeters zagen we het volgende:

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/25-users-alles-slaagt.PNG)

Op het einde van deze grafiek van het memory zien we hier een kleine stijging die onze simulatie voorstelt van 2 x 25 gebruikers. Ook hier zien we dat het misschien geen slecht idee is om ons RAM te verhogen.

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/25-users-memory.PNG)

Hier zien we opnieuw bij de interface de laatste piek die de simulatie van 2 x 25 gebruikers voorstelt. 

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/25-users-interface.PNG)

Kortom, onze webpagina heeft ook hier geen problemen gehad dit aantal requests te verwerken.

**100 gebruikers op Demo Post 27, 100 gebruikers op de algemene wordpress pagina**

Als eerst stellen voor beide Apache JMeter's de gebruikers in op 100.
Bij "Numbers of Threads (users):" zien we dus dat het aantal gebruikers is ingesteld op 100.

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/100-gebruikers.PNG)

Eens we dit test-plan hebben uitgevoerd voor 2 x 100 gebruikers te simuleren, zien we in de tabel dat de HTTP requests al vrij snel begonnen falen. Dit zien we door het voorkomen van de uitroeptekens. Onze webpagina was dus down bij de aanvraag van 2 x 100 gebruikers. Na een korte tijd (~1 minuut) begonnen de requests terug te slagen en zagen we terug groene vinkjes. Onze Wordpress pagina was dus heel even down, maar was al heel snel terug beschikbaar. Voor de Apache JMeters zagen we het volgende waarbij we merken dat de post-27 later up was dan de algemene Wordpress pagina zelf:

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/100-gebruikers-faalt-terug-up-post.PNG)

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/100-gebruikerss-faalt-terug-up-wordpress.PNG)

Op het einde van deze grafiek van het memory zien we hier een sterke stijging die onze simulatie voorstelt van 2 x 100 gebruikers. We zien dat hier geen sprake is van een piek, maar het geheugen blijft namelijk heel erg hoog aanhouden. Dit houdt in dat onze Wordpress pagina niet meer beschikbaar is voor een heel korte periode bij de aanvraag van 2 x 100 gebruikers.

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/100-gebruikers-memory.PNG)

Hier zien we opnieuw bij de interface de laatste piek die de simulatie van 2 x 100 gebruikers voorstelt. 

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/100-gebruikers-interface.PNG)

Kortom, onze Wordpress-pagina had het gedurende een heel korte periode moeilijk om al deze requests tegelijk te kunnen verwerken waarbij hij dus heel even niet meer beschikbaar was. Maar na een heel korte tijd was deze pagina al weer terug beschikbaar.


**200 gebruikers op Demo Post 27, 200 gebruikers op de algemene wordpress pagina**

Als eerst stellen voor beide Apache JMeter's de gebruikers in op 200.
Bij "Numbers of Threads (users):" zien we dus dat het aantal gebruikers is ingesteld op 200.

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/200-users.PNG)

Eens we dit test-plan hebben uitgevoerd voor 2 x 200 gebruikers te simuleren, zien we in de tabel dat de HTTP requests al vrij snel begonnen falen. Dit zien we door het voorkomen van de uitroeptekens. Onze webpagina was dus down bij de aanvraag van 2 x 200 gebruikers. Voor de Apache JMeters zagen we het volgende:

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/200-users-faalt.PNG)

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/200-users-faalt1.PNG)

Op het einde van deze grafiek van het memory zien we hier een sterke stijging die onze simulatie voorstelt van 2 x 200 gebruikers. We zien dat hier geen sprake is van een piek, maar het geheugen blijft namelijk heel erg hoog aanhouden. Dit houdt in dat onze Wordpress pagina niet meer beschikbaar is bij de aanvraag van 2 x 200 gebruikers.

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/200-users-memory.PNG)

Hier zien we opnieuw bij de interface de laatste piek die de simulatie van 2 x 200 gebruikers voorstelt. We zien dat dit een heel grote piek is vergeleken met de piek ervoor die de test van 2 x 25 gebruikers voorstelt. 

![load testing](https://github.com/HoGentTIN/ops3-g03/blob/master/deelopdracht01/Load-testing/load-testing-printscreens/200-users-interface.PNG)

Kortom, onze webpagina was niet in staat om dit aantal requests te verwerken met als gevolg dat onze Wordpress-pagina niet meer beschikbaar was.
