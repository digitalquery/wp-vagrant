#!/usr/bin/env bash


if [ ! -f /usr/local/bin/wp ]; then
  echo "**** installing wp-cli"
  curl  https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli-nightly.phar -o /tmp/wp-cli.phar
  chmod +x /tmp/wp-cli.phar
  sudo mv /tmp/wp-cli.phar /usr/local/bin/wp
fi

wpcli_defaults_folder='/home/vagrant/.wp-cli'
if [ ! -d $wpcli_defaults_folder  ]; then
  echo "**** adding wp-cli defaults"
  mkdir $wpcli_defaults_folder
  cp /vagrant/wp-vagrant/wp/wp-cli.config.yml $wpcli_defaults_folder/config.yml
fi
