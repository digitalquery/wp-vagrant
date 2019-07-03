#!/usr/bin/env bash

#
# load settings file
#
. /vagrant/wp-vagrant/settings.sh

# https://serversforhackers.com/c/installing-mysql-with-debconf
debconf-set-selections <<< "mysql-server mysql-server/root_password password $mysql_root_password"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $mysql_root_password"


add-apt-repository -y ppa:ondrej/php
add-apt-repository -y ppa:ondrej/nginx-mainline
apt-get update
apt-get upgrade

apt-get install -y nginx php${php_version} php${php_version}-fpm php${php_version}-gd php${php_version}-mysql php${php_version}-cgi php${php_version}-cli php${php_version}-curl php${php_version}-mbstring ffmpeg vim git-core mysql-server mysql-client curl tmux

echo "**** add byobu config"
. /vagrant/wp-vagrant/configs/byobu.sh

echo "**** Moving nginx config files into place…"
. /vagrant/wp-vagrant/nginx/nginx.sh

echo "**** mysql config…"
. /vagrant/wp-vagrant/mysql/mysql.sh

echo "**** Set PHP to ${php_version} and copy config files"
. /vagrant/wp-vagrant/php/php.sh


echo "Starting services…"
service nginx restart
service php${php_version}-fpm restart
service mysql restart


# WP-CLI
. /vagrant/wp-vagrant/wp/wp-cli.sh

# Create database
. /vagrant/wp-vagrant/mysql/create_database.sh

# Install WP
. /vagrant/wp-vagrant/wp/install-wp.sh

# Import database
. /vagrant/wp-vagrant/mysql/import_database.sh
