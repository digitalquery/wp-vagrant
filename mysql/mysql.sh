#!/usr/bin/env bash

cp /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf.default

# Allow access from host machine (digitalquery#21)
sed -i 's/bind-address[[:space:]]\+= 127\.0\.0\.1/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

# https://stackoverflow.com/a/22933056/2603230
echo "[client]
user = root
password = $mysql_root_password
host = localhost
" > ~/.mysql_root.cnf
