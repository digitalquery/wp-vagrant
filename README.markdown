# Vagrant Box with Ubuntu 14.04, Nginx, MySQL and PHP-FPM

A Vagrant setup to create an Ubuntu 14.04 (Trusty) virtual machine with Nginx, MySQL and PHP for WordPress development.

Intended to be as simple as possible:


#### Summary

* Quickly create a fresh WP instance served up via the Vagrant server.
* Optionally specify which version of WP to install
* Can be dropped into an existing WP directory to provide a LEMP testing and development server with minimal config changes
* Can load database dump as part of provisioning
* Renames all domain references using WP-CLI
* Dumps the database to the shared folder on `vagrant destroy` — (this needs the [vagrant triggers plugin](https://github.com/emyl/vagrant-triggers) to be installed from [(https://github.com/emyl/vagrant-triggers)](https://github.com/emyl/vagrant-triggers))
* Remote debugging using XDebug

## Acknowledgements

This Vagrant box and provisioning is based on [this box from Paul Herron](https://github.com/paulherron/vagrant_precise32_nginx_mysql_php-fpm) and the [accompanying blog post](http://paulherron.com/blog/making_your_own_vagrant_wordpress_box/).

## What's included in the VM?

* Ubuntu 14.04 LTS (Trusty Tahir)
* Nginx, listening on port 80
* MySQL, listening for remote connections
* PHP 5.5, with OpCache and XDebug
* PHP-FPM
* PHP-Unit
* [Byobu](http://byobu.co/)
* [WP-CLI](wp-cli.org)
* Dump database automatically on `vagrant destroy`


## Instructions

These instructions are OS X specific, but the overall solution should work on any platform that Vagrant and VirtualBox support.

### Before you start

* Install [Homebrew (http://brew.sh/)](http://brew.sh/)
* If you want to install VirtualBox and Vagrant with Homebrew then install brew-cask:
	* `brew tap caskroom/cask`
	* `brew install brew-cask`

* Install VirtualBox
	* Either download from the [VirtualBox site (https://www.virtualbox.org/wiki/Downloads)](https://www.virtualbox.org/wiki/Downloads)
	* Or, install via homebrew `brew cask install virtualbox`

* Install Vagrant
	* Either download from the [Vagrant site (https://www.vagrantup.com/downloads.html)](https://www.vagrantup.com/downloads.html)
	* Or, install via homebrew `brew cask install vagrant`

* Install Vagrant triggers `vagrant plugin install vagrant-triggers`
* Install vagrant-hostupdater `vagrant plugin install vagrant-hostsupdater`



### Fresh WP install

Use these instructions if you want to create a new WP site with the default empty database.

1. Create directory for the site:
	* `mkdir testsite`
1. `cd` to this created directory
1.  Clone the wp-vagrant folder here
	* `git clone git@github.com:digitalquery/wp-vagrant.git`
1. Copy the VagrantFile into the site root directory
	* `cp wp-vagrant/Vagrantfile .`
1. Fire up Vagrant to create the VM and then run the provisioning scripts
	* `vagrant up`
	* This may take a little while as the provisioning scripts download and install everything
1. Browse to `http://nginx.local` - you should see the default twentyfourteen theme


### Existing WP install

Use these intructions if you have an existing WP install

1. Go to the folder
1. Clone the wp-vagrant repo
	* `git clone git@github.com:digitalquery/wp-vagrant.git`
	* This creates a subfolder called `wp-vagrant`
1. Copy the VagrantFile into the site root directory
	* `cp wp-vagrant/Vagrantfile .`
1. If you want to import a database during the provisioning, then put a SQL dump file into the `wp-vagrant` folder. **This file must have a .sql extension**
1. Using your editor of choice, edit `wp-vagrant/settings.sh`
	* `install_wordpress=false `
		* the default for this is true, so change to false
	* `wp_db_name=<db_name>`
		* should be the same database name as in wp-config.php
	* `wp_db_user` and `wp_db_password`
		* If the wp-config file uses something different than root and the `mysql_root_password` then change these
		* Otherwise leave blank
	* Leave the WP admin section variables empty
	* `import_database=true`
		* set to true if you want to import a database ( and have a SQL dump file in the wp-vagrant folder)
	* `import_site_domain=''`
		* Put the domain that you were using, this should be the same domain as the database dump.
		* We will search for this domain in the database and change it to `nginx.local`
1. `vagrant up`
1. Browse to `http://nginx.local` - and you should see your site up and running


### Settings.sh

The full list.

##### Basic Settings

* `install_wordpress=true`
* `wp_version=""`
* `wp_path='/vagrant'`
* `mysql_root_password='root'`

##### WP database credentials
* `wp_db_name='vagrant_test'`
* `wp_db_user=''`
* `wp_db_password=''`

##### WP admin and site setup details
* `wp_admin_user='admin'`
* `wp_admin_password='123'`
* `wp_admin_email='root@example.com'`
* `wp_site_title='Vagrant'`

##### Database import
* `import_database=false`
* `import_site_domain=''`
