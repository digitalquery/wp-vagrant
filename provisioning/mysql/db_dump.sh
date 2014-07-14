#!/usr/bin/env bash


# read settings file
. /vagrant/wp-vagrant-settings.sh


echo "*****db name is $wp_db_name"


if [ ! -z $wp_db_name ]; then

  now=`date +"%Y_%m_%d-%H-%M-%S"`

  db_dump_file=$wp_db_name"_"$now".sql"

  echo "**** dumping database before destroy"
  echo "**** dump file: /vagrant/provision/db_dumps/$db_dump_file"


  if [ ! -d /vagrant/provisioning/db_dumps ]; then
    mkdir /vagrant/provisioning/db_dumps
  fi

  mysqldump -u root --password=$mysql_root_password $wp_db_name > /vagrant/provisioning/db_dumps/$db_dump_file

  if [ ! "$?" -eq 0 ]; then
    echo "***** DATABASE DUMP FAILED - YOU MAY WISH TO ABORT VAGRANT DESTROY."
    echo "***** Check provisioning/db_dumps/error.log for more info"
  fi


fi
