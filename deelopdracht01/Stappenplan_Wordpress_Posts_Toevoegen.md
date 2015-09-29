# Stappenplan aanmaken van een 100-tal posts op Wordpress #

1) Log in op de LAMP stack in VirtualBox.<br>

2) Installer zip en unzip.<br>

	`Sudo yum install zip unzip`
3) Navigeer naar /usr/share/wordpress/wp-content/plugins<br>

    `cd /usr/share/wordpress/wp-content/plugins` 
4) Download de plugin "Yonox Add Posts". <br>

	`sudo wget https://downloads.wordpress.org/plugin/yonox-add-multiple-posts.1.3.zip` 

5) Unzip de zip-file. <br>

    `sudo unzip yonox-add-multiple-posts.1.3.zip` 
6) Verwijder de zip-file. <br>

	`sudo rm yonox-add-multiple-posts.1.3.zip`

7) Surf op de host naar http://192.168.56.77/wordpress/ en log in als admin. <br>

8) Druk links op Plugins en activeer "Yonox Add Multiple Posts". <br>

9) Druk links onderaan op "Yonox Add Posts". <br>

10) Typ 1 keer "Lorem Ipsum", kopieer dit en plak dit 10 keer. Kopieer dan de 10 keer "Lorem Ipsum" en blijf plakken naargelang hoeveel posts je wilt. Indien je wilt kan je een een categorie toevoegen in deze plugin, maar deze moet op voorhand aangemaakt worden in Wordpress. Uiteindelijk druk je gewoon nog op "Create Multiple Posts" en je posts worden aangemaakt.

