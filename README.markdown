# Vagrant Box with Ubuntu 12.04, Nginx, MySQL and PHP-FPM

A Vagrant setup to create an Ubuntu 12.04 (Precise 32 bit) virtual machine with Nginx, MySQL and PHP.

Ideal for use as a base box in other projects, so you don't have to wait for the LNMP stack to install when you first do `vagrant up`.


## Contents

* Ubuntu 12.04 LTS (Precise Pangolin, 32 bit)
* Nginx, listening on port 80 and on 443 using a dummy, self-signed certificate
* MySQL, listening for remote connections so you can access it from your host machine, for example using [SequelPro](http://www.sequelpro.com/)
* PHP-FPM


## Instructions

Clone this repository:

`git clone git@github.com:paulherron/vagrant_precise32_nginx_mysql_php-fpm.git`

Navigate into the newly-created directory:

`cd vagrant_precise32_nginx_mysql_php-fpm`

Now fire up the Vagrant box:

`vagrant up`


## Packaging the Box

You could consider packaging the box and using it in your own projects.

With the box running, you can do:

`vagrant package --output precise32_nginx_mysql_php-fpm.box`
`vagrant box add precise32_nginx_mysql_php-fpm precise32_nginx_mysql_php-fpm.box`

This should create a .box file that's about 500MB, and register it with your own Vagrant installation.

Using the box in a different project is then as simple as adding this to that project's `Vagrantfile`:

	# A custom base box is used.
	# It has nginx, php-fpm and MySQL pre-installed.
	config.vm.box = "precise32_nginx_mysql_php-fpm"

	# You could optionally put the box on your own CDN so your collaborators can download it too.
	config.vm.box_url = "http://yourcdn.example.com/boxes/precise32_nginx_mysql_php-fpm.box"
