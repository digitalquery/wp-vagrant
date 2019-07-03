#!/usr/bin/env bash

# update wp-cli
if [  -f /usr/local/bin/wp ]; then
  echo "**** updating wp-cli"
  sudo wp cli update --allow-root --yes
else
  echo "**** installing wp-cli"
  cd ~/
  curl -Os https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
  sudo mv wp-cli.phar /usr/local/bin/wp
fi

wpcli_defaults_folder='/home/vagrant/.wp-cli'
if [ ! -d $wpcli_defaults_folder  ]; then
  echo "**** adding wp-cli defaults"
  mkdir $wpcli_defaults_folder
  cp /vagrant/wp-vagrant/wp/wp-cli.config.yml $wpcli_defaults_folder/config.yml
fi
