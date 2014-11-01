#!/usr/bin/env bash

cp /vagrant/wp-vagrant/nginx/nginx.conf /etc/nginx/

if [ -f /etc/nginx/sites-enabled/default ]; then
  rm /etc/nginx/sites-enabled/default
fi
cp /vagrant/wp-vagrant/nginx/default.conf /etc/nginx/sites-enabled/
