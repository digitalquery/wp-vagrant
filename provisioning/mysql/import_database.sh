#!/usr/bin/env bash


# if $wp_db_name is specified, then create the database and user (if neccesary)
# if import_database is specified then import database and use wp-cli to rename domain

if [ ! -z $wp_db_name ] ; then

  if $import_database ; then
    echo "**** importing database dump"
    mysql -u root -p$mysql_root_password $wp_db_name < /vagrant/provisioning/$wp_db_dump_file

    echo "*** wp-cli search and replace"
    wp --path=$wp_path --allow-root search-replace $import_site_domain nginx.local
  fi

else
	echo "**** No database name specified - skipping db import"
fi
