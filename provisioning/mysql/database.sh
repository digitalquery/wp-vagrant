#!/usr/bin/env bash


echo "*** deploying database dump"
mysql -u root -proot -e "CREATE DATABASE IF NOT EXISTS $db_name;"
mysql -u root -proot $db_name < /vagrant/provisioning/$db_dump_file

if [ ! -z "$db_user" ]; then
  mysql -u root -proot -e "GRANT ALL ON $dbname.* TO '$dbuser'@'localhost' IDENTIFIED BY $db_password"
fi

echo "*** wp-cli search and replace"
wp --path=$wordpress_path --allow-root search-replace $import_site_domain nginx.local
