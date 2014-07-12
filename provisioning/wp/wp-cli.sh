#!/usr/bin/env bash


if [ ! -f /usr/local/bin/wp ]; then
  echo "**** installing wp-cli"
  curl  https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /tmp/wp-cli.phar
  chmod +x /tmp/wp-cli.phar
  sudo mv /tmp/wp-cli.phar /usr/local/bin/wp
fi
