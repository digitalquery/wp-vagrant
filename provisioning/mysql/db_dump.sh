#!/usr/bin/env bash
echo "*** dumping database"
cd /vagrant
. /vagrant/provisioning/settings.sh

now=`date +"%Y_%m_%d-%H-%M-%S"`


if [ ! -d /vagrant/provisioning/db_dumps ]; then
  mkdir /vagrant/provisioning/db_dumps
fi


mysqldump -u root -proot $db_name > /vagrant/provisioning/db_dumps/$db_name_$now.sql
