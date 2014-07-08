#!/usr/bin/env bash

if [ $deploy_database = true ]; then

  echo "*** deploying database dump"
  mysql -u root -proot -e "CREATE DATABASE IF NOT EXISTS $db_name;"
  mysql -u root -proot $db_name < /vagrant/provisioning/$db_dump_file

  echo "*** wp-cli search and replace"
  wp --path=$wordpress_path --allow-root search-replace $import_site_domain nginx.local

fi
