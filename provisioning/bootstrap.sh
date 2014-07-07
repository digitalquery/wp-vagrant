#!/usr/bin/env bash

apt-get update

debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password root'
apt-get install -qy nginx php5 php5-fpm php5-gd php5-mysql php5-cgi php5-cli php5-curl vim git-core mysql-server-5.5 mysql-client curl byobu

apt-get -y upgrade

echo "Moving nginx config files into place…"
rm /etc/nginx/sites-enabled/default
cp /vagrant/provisioning/nginx/default.conf /etc/nginx/sites-enabled/
# cp /vagrant/provisioning/nginx/fastcgi_params.conf /etc/nginx/
cp /vagrant/provisioning/nginx/dummy.* /etc/nginx/

echo "Moving mysql config files into place…"
mv /etc/mysql/my.cnf /etc/mysql/my.cnf.default
cp /vagrant/provisioning/mysql/my.cnf /etc/mysql/my.cnf
mysql -u root -proot < /vagrant/provisioning/mysql/database.sql

echo "Moving php config files into place…"
mv /etc/php5/fpm/php.ini /etc/php5/fpm/php.ini.default
cp /vagrant/provisioning/php/php.ini /etc/php5/fpm/php.ini

echo "Starting services…"
service nginx restart
service php5-fpm restart
service mysql restart
