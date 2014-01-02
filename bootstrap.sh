#!/usr/bin/env bash

apt-get update

debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password 100rows'
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password 100rows'
apt-get install -qy nginx php5 php5-fpm php5-gd php5-mysql php5-cgi php5-cli php5-curl ffmpeg vim git-core mysql-server-5.5 mysql-client curl php5-xdebug

echo "Moving nginx config files into place…"
rm /etc/nginx/sites-enabled/default
cp /vagrant/nginx/default.conf /etc/nginx/sites-enabled/
cp /vagrant/nginx/generic.conf /etc/nginx/
cp /vagrant/nginx/php.conf /etc/nginx/
cp /vagrant/nginx/fastcgi_params.conf /etc/nginx/
cp /vagrant/nginx/dummy.* /etc/nginx/

echo "Moving mysql config files into place…"
mv /etc/mysql/my.cnf /etc/mysql/my.cnf.default
cp /vagrant/mysql/my.cnf /etc/mysql/my.cnf
mysql -u root -p100rows < /vagrant/mysql/database.sql

echo "Moving php config files into place…"
mv /etc/php5/fpm/php.ini /etc/php5/fpm/php.ini.default
cp /vagrant/php/php.ini /etc/php5/fpm/php.ini
rm /etc/php5/fpm/conf.d/xdebug.ini
cp /vagrant/php/xdebug.ini /etc/php5/fpm/conf.d/

echo "Starting services…"
service nginx restart
service php5-fpm restart
service mysql restart
