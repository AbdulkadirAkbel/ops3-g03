# Stappenplan aanmaken van een 100-tal posts op Wordpress #

1) Log in op de LAMP stack in VirtualBox.<br>

2) Installer zip en unzip.<br>

	`Sudo yum install zip unzip`
3) Navigeer naar /usr/share/wordpress/wp-content/plugins<br>

    `cd /usr/share/wordpress/wp-content/plugins` 
4) Download de plugin "Demo Data Creator". <br>

	`sudo wget https://downloads.wordpress.org/plugin/demo-data-creator.zip` 

5) Unzip de zip-file. <br>

    `sudo unzip demo-data-creator.zip` 
6) Verwijder de zip-file. <br>

	`sudo rm demo-data-creator.zip`

7) Surf op de host naar http://192.168.56.77/wordpress/ en log in als admin. <br>

8) Druk links op Plugins en activeer "Demo Data Creator". <br>

9) Druk links op Tools en ga naar "Demo Data Creator". <br>

10) Kies bij het onderdeel 'Posts' bepaal je hoeveel posts je wilt opmaken en hoeveel paragrafen er moeten zijn. Bij het onderdeel 'Comments' kan je ook at random reacties laten genereren op de aangemaakte posts.

# Stappenplan om de posts en inlog gegevens op te slaan in de lampstack gegevens na een vagrant destroy #

1) Vul de Wordpress met posts (zie vorig onderdeel)

2) Log in op de PHPMyAdmin pagina van de lampstack als "admin","admin". Exporteer alle gegevens van de Wordpress pagina naar init.sql.

3) Ga naar de ansible folder en maak daar een nieuwe folder "files" aan waarin je het bestand "init.sql" zet.

4) Pas tenslotten de lampstack.yml in de host_vars nog aan door volgende 3 lijntjes toe te voegen:<br>
mariadb_init_scripts:<br>
  \- database: wordpress<br>
    script: files/init.sql<br>

5) Test of het werkt door na je wordpress gevuld te hebben met posts "vagrant destroy -f" toe te passen. Voer dan stap 3 en stap 4 uit. Doe terug vagrant up, en je zal zien dat na het bezoeken van de wordpress pagina de posts en de inlog-gegevens worden bijgehouden. Zolang je nu geen vagrant destroy meer doet kan je terug deze 3 lijntjes in commentaar zetten.
