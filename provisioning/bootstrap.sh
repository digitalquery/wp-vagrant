#!/usr/bin/env bash

apt-get update
apt-get -y upgrade

source /vagrant/provisioning/settings.sh

debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password root'
apt-get install -qy nginx php5 php5-fpm php5-gd php5-mysql php5-cgi php5-cli php5-curl php5-xdebug vim git-core mysql-server-5.5 mysql-client curl byobu

echo "General config stuff"
mkdir /home/vagrant/.byobu
cp /vagrant/provisioning/configs/.byobu/keybindings.tmux /home/vagrant/.byobu/
cp /vagrant/provisioning/configs/.byobu/status /home/vagrant/.byobu/
sudo chown -R vagrant:vagrant /home/vagrant/.byobu/

echo "Moving nginx config files into place…"
rm /etc/nginx/sites-enabled/default
cp /vagrant/provisioning/nginx/default.conf /etc/nginx/sites-enabled/
# cp /vagrant/provisioning/nginx/fastcgi_params.conf /etc/nginx/
cp /vagrant/provisioning/nginx/dummy.* /etc/nginx/

echo " mysql config…"
mv /etc/mysql/my.cnf /etc/mysql/my.cnf.default
cp /vagrant/provisioning/mysql/my.cnf /etc/mysql/my.cnf

echo "Moving php config files into place…"
mv /etc/php5/fpm/php.ini /etc/php5/fpm/php.ini.default
cp /vagrant/provisioning/php/php.ini /etc/php5/fpm/php.ini

echo "Starting services…"
service nginx restart
service php5-fpm restart
service mysql restart

echo "installing wp-cli"
curl  https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /tmp/wp-cli.phar
chmod +x /tmp/wp-cli.phar
sudo mv /tmp/wp-cli.phar /usr/local/bin/wp

echo "*** loading database"
source /vagrant/provisioning/mysql/database.sh
