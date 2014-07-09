# Vagrant Box with Ubuntu 14.04, Nginx, MySQL and PHP-FPM,

A Vagrant setup to create an Ubuntu 14.04 (Trusty) virtual machine with Nginx, MySQL and PHP for WordPress development.

Intended to be as simple as possible - just drop into existing WP folder, modify settings.sh, add a database dump, and within minutes, you should be able to browse to nginx.local and see your site.

* Loads specified database dump as part of provisioning
* Renames all domain references using [WP-CLI](wp-cli.org)
* Dumps the database to the shared folder on `vagrant destroy` — (this needs the [vagrant triggers plugin](https://github.com/emyl/vagrant-triggers) to be installed from [(https://github.com/emyl/vagrant-triggers)](https://github.com/emyl/vagrant-triggers))
* Remote debugging using XDebug


## Contents

* Ubuntu 14.04 LTS (Trusty Tahir)
* Nginx, listening on port 80 and on 443 using a dummy, self-signed certificate
* MySQL, listening for remote connections so you can access it from your host machine, for example using [SequelPro](http://www.sequelpro.com/)
* PHP-FPM
* PHP 5.5, with OpCache and XDebug
* [Byobu](http://byobu.co/)
* [WP-CLI](wp-cli.org)


## Instructions

Clone this repository:

`git clone git@bitbucket.org:digitalquery/vagrant-nginx.git`

#### OR

Download a zip of the files here [https://bitbucket.org/digitalquery/vagrant-nginx/get/master.tar.gz](https://bitbucket.org/digitalquery/vagrant-nginx/get/master.tar.gz)

Navigate into the newly-created directory:

`cd vagrant_precise32_nginx_mysql_php-fpm`

Now fire up the Vagrant box:

`vagrant up`

It should come up at the IP address `192.168.50.2`, so if you put [that address](http://192.168.50.2) into your browser you should see a 'Vagrant is up!' message to show it's working.


## About the Setup

It's not too complicated a setup. There's a file called `Vagrantfile` in there, which is what Vagrant will take its initial instructions from when you fire up the virtual machine. This file declares a couple of key things: firstly that we want to use the `precise32` box to start with, which is that default Ubuntu installation. Then for neatness, we want to use a static IP address for the virtual machine: 192.168.50.2. This will mean we'll always know what IP address to navigate to access our website, and that if we're feeling like it we can also declare a neat testing domain by adding something like `192.168.50.2	default.l` onto the end of our `/etc/hosts` file on the host machine, which would let us view the site in the browser by navigating to http://default.l.

Another key thing the Vagrantfile says is that we want to run the script `bootstrap.sh` when the machine gets provisioned. It's into that script that we put all of our shell commands for `apt-get install`ing software and moving configuration files into place.

If you check out that `bootstrap.sh` file it tells the rest of the story. It:

* Declares a root password of `100rows` for our database's root user.
* Installs a boatload of packages: Nginx, MySQL and also some other things like Tmux for convenience when interacting with the machine later.
* Moves various Nginx config files into place: things relating to PHP configuration, a dummy SSL certificate, as well as a config file that sets up a site called `default`.
* Moves some MySQL configuration files into place, and runs a file config/database.sql, which contains a couple of extra commands to grant privileges to the root user and create an empty database called `default`.
* Moves some PHP configuration files into place, which includes a liberal php.ini file that should allow fairly large files to be uploaded without any problems, and a liberal amount of memory to be available without errors being thrown.


## Using a Different IP

If you'd rather use a different IP address, you can specify your own in a `Vagrantfile` elsewhere. Check out the [Load Order and Merging](http://docs.vagrantup.com/v2/vagrantfile/) section in the Vagrant doc for more info.

Specifying an IP address for the box to run on is useful as you can access the site on a nice, neat testing URL. I use `paulherron.l` for my own site, for example, which makes it really easy to [switch between my test site and live site](https://github.com/paulherron/domain_switcher). To do this I just declare the following in my `/etc/hosts` file:

	192.168.50.2	paulherron.l
	192.168.50.2	www.paulherron.l


## Packaging the Box

You could consider packaging the box and using it in your own projects.

With the box running, you can do:

	vagrant package --output precise32_nginx_mysql_php-fpm.box
	vagrant box add precise32_nginx_mysql_php-fpm precise32_nginx_mysql_php-fpm.box

This should create a .box file that's about 500MB, and register it with your own Vagrant installation.

Using the box in a different project is then as simple as adding this to that project's `Vagrantfile`:

	# A custom base box is used.
	# It has nginx, php-fpm and MySQL pre-installed.
	config.vm.box = "precise32_nginx_mysql_php-fpm"

	# You could optionally put the box on your own CDN so your collaborators can download it too.
	config.vm.box_url = "http://yourcdn.example.com/boxes/precise32_nginx_mysql_php-fpm.box"
