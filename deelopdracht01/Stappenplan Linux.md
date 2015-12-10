## Stappenplan Linux: Eenvoudige LAMP stack

###Mappen structuur en files
- Download Vagrant.
- Download Git.
- Download Virtualbox VM.
- Maak een map aan met de naam Eenvoudige LAMP stack.
- Maak in de map Eenvoudige LAMP stack een map aan met de naam ansible.
- Maak in de map Eenvoudige LAMP stack een map aan met de naam scripts.
- Plaats de bijgevoegde scripts in de map scripts.
- Maak in de map Eenvoudige LAMP stack een map aan met de naam www.
- Plaats de bijgevoegde file index.php in de map www.
- Plaats de bijgevoegde vagrant_hosts file in de map Eenvoudige LAMP stack.
- Plaats de bijgevoegde vagrant file in de map Eenvoudige LAMP stack.

##LAMP stack met php en databank met collectd als monitoring server
- Maak in de map ansible volgende mappen aan:
	- files
	- filter_plugins
	- group_vars
	- host_vars
	- roles
- Plaats de bijgevoegde files collectd-collectd, collectd-dns, collectd-lampstack en init.sql in de map files.
- Plaats de bijgevoegde files ipaddress en ipaddress.pcy in de map filter_plugins.
- Plaats de bijgevoegde file all in de map group_vars.
- Plaats de bijgevoegde files collectd, dns en lampstack in de map host_vars.
- Plaats al de bijgevoegde rollen in de map roles.
- Plaats de bijgevoegde files dependencies en site in de map ansible.
- Open Git Bash in de map Eenvoudige LAMP stack en voer het volgende commando uit: `vagrant up`


##Stappenplan Linux: Multi-tier webserver

###Mappen structuur en files
- Download Vagrant.
- Download Git.
- Download Virtualbox VM.
- Maak een map aan met de naam Multi-tier webserver.
- Maak in de map Multi-tier webserver een map aan met de naam ansible.
- Maak in de map Multi-tier webserver een map aan met de naam scripts.
- Plaats de bijgevoegde scripts in de map scripts.
- Maak in de map Multi-tier webserver een map aan met de naam www.
- Plaats de bijgevoegde file index.php in de map www.
- Plaats de bijgevoegde vagrant_hosts file in de map Multi-tier webserver.
- Plaats de bijgevoegde vagrant file in de map Multi-tier webserver.

##Multi-tier webserver met Nginx
- Maak in de map ansible volgende mappen aan:
	- files
	- filter_plugins
	- group_vars
	- host_vars
	- roles
- Plaats de bijgevoegde files collectd-collectd, collectd-dns, collectd-database, collectd-webserver en init.sql in de map files.
- Plaats de bijgevoegde files ipaddress en ipaddress.pcy in de map filter_plugins.
- Plaats de bijgevoegde file all in de map group_vars.
- Plaats de bijgevoegde file dns in de map host_vars.
- Plaats al de bijgevoegde rollen in de map roles.
- Plaats de bijgevoegde files dependencies en site in de map ansible.
- Open Git Bash in de map Multi-tier webserver en voer het volgende commando uit: `vagrant up`