#!/usr/bin/env bash

#
# load settings file
#
. /vagrant/wp-vagrant/settings.sh

debconf-set-selections <<< "mysql-server-5.5 mysql-server/root_password password $mysql_root_password"
debconf-set-selections <<< "mysql-server-5.5 mysql-server/root_password_again password $mysql_root_password"

apt-get update
apt-get install -qy nginx php5 php5-fpm php5-gd php5-mysql php5-cgi php5-cli php5-curl php5-xdebug phpunit vim git-core mysql-server-5.5 mysql-client curl byobu


echo "**** add byobu config"
. /vagrant/wp-vagrant/configs/byobu.sh

echo "**** Moving nginx config files into place…"
. /vagrant/wp-vagrant/nginx/nginx.sh

echo "**** mysql config…"
mv /etc/mysql/my.cnf /etc/mysql/my.cnf.default
cp /vagrant/wp-vagrant/mysql/my.cnf /etc/mysql/my.cnf

echo "**** Moving php config files into place…"
mv /etc/php5/fpm/php.ini /etc/php5/fpm/php.ini.default
cp /vagrant/wp-vagrant/php/php.ini /etc/php5/fpm/php.ini
sudo cp /vagrant/wp-vagrant/php/20-xdebug.ini /etc/php5/fpm/conf.d/

echo "Starting services…"
service nginx restart
service php5-fpm restart
service mysql restart


# WP-CLI
. /vagrant/wp-vagrant/wp/wp-cli.sh

# Create database
. /vagrant/wp-vagrant/mysql/create_database.sh

# Install WP
. /vagrant/wp-vagrant/wp/install-wp.sh

# Import database
. /vagrant/wp-vagrant/mysql/import_database.sh
