#!/usr/bin/env bash


echo "*** deploying database dump"
mysql -u root -p$mysql_root_password -e "CREATE DATABASE IF NOT EXISTS $wp_db_name;"
mysql -u root -p$mysql_root_password $wp_db_name < /vagrant/provisioning/$wp_db_dump_file

if [ ! -z "$wp_db_user" ]; then
  mysql -u root -p$mysql_root_password -e "GRANT ALL ON $wp_db_name.* TO '$wp_db_user'@'localhost' IDENTIFIED BY '$wp_db_password'"
fi

echo "*** wp-cli search and replace"
wp --path=$wordpress_path --allow-root search-replace $import_site_domain nginx.local
