# Vagrant Box with Ubuntu 14.04, Nginx, MySQL and PHP-FPM

A Vagrant setup to create an Ubuntu 14.04 (Trusty) virtual machine with Nginx, MySQL and PHP for WordPress development.

Intended to be as simple as possible - just drop into existing WP folder, modify settings.sh, add a database dump, and within minutes, you should be able to browse to nginx.local and see your site.

* Loads specified database dump as part of provisioning
* Renames all domain references using [WP-CLI](wp-cli.org)
* Dumps the database to the shared folder on `vagrant destroy` — (this needs the [vagrant triggers plugin](https://github.com/emyl/vagrant-triggers) to be installed from [(https://github.com/emyl/vagrant-triggers)](https://github.com/emyl/vagrant-triggers))
* Remote debugging using XDebug

## Acknowledgements

This Vagrant box and provisioning is based on [this basebox from Paul Herron](https://github.com/paulherron/vagrant_precise32_nginx_mysql_php-fpm) and the [accompanying blog post](http://paulherron.com/blog/making_your_own_vagrant_wordpress_box/).

## What's included in the VM?

* Ubuntu 14.04 LTS (Trusty Tahir)
* Nginx, listening on port 80 and on 443 using a dummy, self-signed certificate
* MySQL, listening for remote connections so you can access it from your host machine, for example using [SequelPro](http://www.sequelpro.com/)
* PHP-FPM
* PHP 5.5, with OpCache and XDebug
* [Byobu](http://byobu.co/)
* [WP-CLI](wp-cli.org)
* Dump database automatically on `vagrant destroy`


## Instructions

These instructions are OS X specific, but the overall solution should work on any platform that Vagrant and VirtualBox support.

* Install VirtualBox
* Install Vagrant
* Install Vagrant triggers (vagrant plugin install vagrant-triggers)
* Install vagrant-hostupdater (vagrant plugin install vagrant-hostsupdater)
* Clone this repository:  `git clone git@bitbucket.org:digitalquery/vagrant-nginx.git`
	* Or download an archive of the files here:   [https://bitbucket.org/digitalquery/vagrant-nginx/get/master.tar.gz](https://bitbucket.org/digitalquery/vagrant-nginx/get/master.tar.gz), and then `tar zxvf master.tar.gz`
	* The rest of these instructions assume you have a folder `/Downloads/vagrant-wp/` that contains the unzipped / cloned files, and the WP folder in question is `~/Sites/wptest/`
* Copy the Vagrantfile from the zip file or the clone folder to the root folder of the site you want to test - for a normal WP install, this is the main WP folder (ie where your wp-config.php is): `cp /Downloads/vagrant-wp/Vagrantfile ~/Sites/wptest`
* copy the provisioning folder and subfolders: `cp -r /Downloads/vagrant-wp/Vagrantfile/provisioning ~/Sites/wptest`
* if you want a database dump to be loaded into MySQL, then put a database dump into the provisioning folder
* edit `~/Sites/provisioning/settings.sh`:
	* mysql_root_password='root'# your mysql root password
	* deploy_database=true # if deploy_database is true, then we'll try to import the database dump into the vagrant mysql
	* wp_db_name = "" # the database name (should be the same as in wp-config.php)
	* wp_db_user='' # database user (should be the same as in wp-config.php)
	* wp_db_password ='' # db password (should be the same as in wp-config.php)
	* wp_db_dump_file='' # the name of the dump file, relative to the provisioning folder. So, if your db dump file is provisioning/wp_db.sql, wp_db_dump_file='wp_db.sql'
	* import_site_domain='' # the domain you've been using for local development. The provisioning process will use wp-cli to safely replace this with `nginx.local`
	* wordpress_path='' # normally /vagrant. If you've installed WP into a subdirectory, then put the path here, eg '/vagrant/blog'
* And now you can run `vagrant up`. The provisioning scripts should start working and between 2 - 10 minutes later, you should be able to browse to nginx.local and see your site running.



## About the Setup

It's not too complicated a setup. There's a file called `Vagrantfile` in there, which is what Vagrant will take its initial instructions from when you fire up the virtual machine. This file declares a couple of key things: firstly that we want to use the `precise32` box to start with, which is that default Ubuntu installation. Then for neatness, we want to use a static IP address for the virtual machine: 192.168.50.2. This will mean we'll always know what IP address to navigate to access our website, and that if we're feeling like it we can also declare a neat testing domain by adding something like `192.168.50.2	default.l` onto the end of our `/etc/hosts` file on the host machine, which would let us view the site in the browser by navigating to http://default.l.

Another key thing the Vagrantfile says is that we want to run the script `bootstrap.sh` when the machine gets provisioned. It's into that script that we put all of our shell commands for `apt-get install`ing software and moving configuration files into place.

If you check out that `bootstrap.sh` file it tells the rest of the story. It:

* Declares a root password of `100rows` for our database's root user.
* Installs a boatload of packages: Nginx, MySQL and also some other things like Tmux for convenience when interacting with the machine later.
* Moves various Nginx config files into place: things relating to PHP configuration, a dummy SSL certificate, as well as a config file that sets up a site called `default`.
* Moves some MySQL configuration files into place, and runs a file config/database.sql, which contains a couple of extra commands to grant privileges to the root user and create an empty database called `default`.
* Moves some PHP configuration files into place, which includes a liberal php.ini file that should allow fairly large files to be uploaded without any problems, and a liberal amount of memory to be available without errors being thrown.


x
