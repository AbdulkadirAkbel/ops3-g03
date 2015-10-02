## Stappenplan 1

### Ansible installeren voor Mac OS
Om ansible te installeren moet je volgende commando's ingeven in een terninalvenster.

- sudo easy_install pip
- sudo pip install ansible
- sudo pip install ansible --upgrade

Nu moeten nog de ansible roles geïnstalleerd worden.

- Open een terminalvenster en navigeer naar de repomap.
- Voer nu het script sh scripts/role-deps.sh uit.
- De roles worden gedownload en toegevoegd.


### LAMP stack aanmaken
- Installeer de nieuwste versie van virtualbox en vagrant.
- download de repo voor de lamp stack. (https://github.com/bertvv/lampstack)
- Open een gitbash in de map van de repo.
- Voer het "vagrant up" commando uit.

### Collectd
- Download de repo voor de lampstack.
- verwijder alle rollen buiten bertvv.el7.
- Download de repo voor collectd en pak deze uit in de "roles" folder van ainsible.
- Pas het bestand "main.yml" in de vars folder aan, voeg "collectd_server: 192.168.56.78" toe aan "main.yml".
- Pas het bestand "all.yml" in de de group_vars folder aan, voeg "collectd_server: 192.168.56.78" toe aan "all.yml".
- Open git-bash in de collectd folder en voer in: "vagrant up --provision".






