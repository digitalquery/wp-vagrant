#!/usr/bin/env bash


if [ ! -f /usr/local/bin/wp ]; then
  echo "**** installing wp-cli"
  curl  https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli-nightly.phar -o /tmp/wp-cli.phar
  chmod +x /tmp/wp-cli.phar
  sudo mv /tmp/wp-cli.phar /usr/local/bin/wp

  # default wp-cli config
  cp /vagrant/wp-vagrant/wp/wp-cli.config.yml ~/.wp-cli/config.yml

fi
