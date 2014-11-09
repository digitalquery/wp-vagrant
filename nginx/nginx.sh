#!/usr/bin/env bash

# copy nginx config
cp /vagrant/wp-vagrant/nginx/nginx.conf /etc/nginx/

# remove default site
if [ -f /etc/nginx/sites-enabled/default ]; then
  rm /etc/nginx/sites-enabled/default
fi

# copy our site config and synlink it
cp /vagrant/wp-vagrant/nginx/default.conf /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enables/default.conf
