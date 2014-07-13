#!/usr/bin/env bash

if [ -f /etc/nginx/sites-enabled/default ]; then
  rm /etc/nginx/sites-enabled/default
fi
cp /vagrant/provisioning/nginx/default.conf /etc/nginx/sites-enabled/
# cp /vagrant/provisioning/nginx/fastcgi_params.conf /etc/nginx/
cp /vagrant/provisioning/nginx/dummy.* /etc/nginx/