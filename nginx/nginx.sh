#!/usr/bin/env bash

if [ -f /etc/nginx/sites-enabled/default ]; then
  rm /etc/nginx/sites-enabled/default
fi
cp /vagrant/wp-vagrant/nginx/default.conf /etc/nginx/sites-enabled/
# cp /vagrant/wp-vagrant/nginx/fastcgi_params.conf /etc/nginx/
cp /vagrant/wp-vagrant/nginx/dummy.* /etc/nginx/