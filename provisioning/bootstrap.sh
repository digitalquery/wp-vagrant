#!/usr/bin/env bash

#
# load settings file
#
source /vagrant/wp-vagrant-settings.sh

debconf-set-selections <<< "mysql-server-5.5 mysql-server/root_password password $mysql_root_password"
debconf-set-selections <<< "mysql-server-5.5 mysql-server/root_password_again password $mysql_root_password"

apt-get update
apt-get install -qy nginx php5 php5-fpm php5-gd php5-mysql php5-cgi php5-cli php5-curl php5-xdebug vim git-core mysql-server-5.5 mysql-client curl byobu


echo "**** add byobu config"
source /vagrant/provisioning/configs/byobu.sh

echo "**** Moving nginx config files into place…"
source /vagrant/provisioning/nginx/nginx.sh

echo "**** mysql config…"
mv /etc/mysql/my.cnf /etc/mysql/my.cnf.default
cp /vagrant/provisioning/mysql/my.cnf /etc/mysql/my.cnf

echo "**** Moving php config files into place…"
mv /etc/php5/fpm/php.ini /etc/php5/fpm/php.ini.default
cp /vagrant/provisioning/php/php.ini /etc/php5/fpm/php.ini
sudo cp /vagrant/provisioning/php/20-xdebug.ini /etc/php5/fpm/conf.d/

echo "Starting services…"
service nginx restart
service php5-fpm restart
service mysql restart


# WP-CLI
source /vagrant/provisioning/wp/wp-cli.sh

# Install WP
source /vagrant/provisioning/wp/install-wp.sh

source /vagrant/provisioning/mysql/database.sh
