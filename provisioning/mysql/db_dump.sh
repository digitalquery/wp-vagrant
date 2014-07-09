#!/usr/bin/env bash

echo "*** dumping database"

cd /vagrant
. /vagrant/provisioning/settings.sh

now=`date +"%Y_%m_%d-%H-%M-%S"`

if [ ! -d /vagrant/provisioning/db_dumps ]; then
  mkdir /vagrant/provisioning/db_dumps
fi

mysqldump -u root --password=$mysql_root_password $wp_db_name > /vagrant/provisioning/db_dumps/$wp_db_name_$now.sql
