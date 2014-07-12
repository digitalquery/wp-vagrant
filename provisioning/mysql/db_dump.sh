#!/usr/bin/env bash


# read settings file
source /vagrant/wp-vagrant-settings.sh


if $wp_db_name ; then

  now=`date +"%Y_%m_%d-%H-%M-%S"`


  echo "**** dumping database before destroy"
  echo "**** dump file: /vagrant/provision/db_dumps/$wp_db_name_$now.sql"


  if [ ! -d /vagrant/provisioning/db_dumps ]; then
    mkdir /vagrant/provisioning/db_dumps
  fi

  if [ -d /var/lib/mysql/$wp_db_name ]; then
    mysqldump -u root --password=$mysql_root_password $wp_db_name > /vagrant/provisioning/db_dumps/$wp_db_name_$now.sql 2> /vagrant/provisioning/db_dump/error.locg
  fi

  if [ ! "$?" -eq 0 ]; then
    echo "***** DATABASE DUMP FAILED - YOU MAY WISH TO ABORT VAGRANT DESTROY."
    echo "***** Check provisioning/db_dumps/error.log for more info"
  fi


fi
