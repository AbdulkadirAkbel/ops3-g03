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

