#!/usr/bin/env bash

# Start after boot
sudo update-rc.d nginx enable

# copy nginx config
cp /vagrant/wp-vagrant/nginx/nginx.conf /etc/nginx/

# remove default site
if [ -f /etc/nginx/sites-enabled/default ]; then
  rm /etc/nginx/sites-enabled/default
fi
if [ -f /etc/nginx/sites-enabled/default.conf ]; then
  rm /etc/nginx/sites-enabled/default.conf
fi


# copy our site config and symlink it
cp /vagrant/wp-vagrant/nginx/default.conf /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf

# rename vhost server name to hostname
echo "nginx vhost conf..."
sed -i "s/%%hostname%%/${hostname}/" /etc/nginx/sites-enabled/default.conf

# php version for fpm
sed -i "s/%%php_version%%/${php_version}/" /etc/nginx/sites-enabled/default.conf
