#!/usr/bin/env bash

# name of database: eg wordpress
db_name=''

# database user name
db_user=''

# database password
db_password=''

# set to true to import the database as part of the provisioning process
deploy_database=true

# database dump file that should be imported automatically: eg wordpress_dump.sql
db_dump_file=''

# specify the domain that the imported dump file uses.
# This allows us to search and replace the domain with nginx.local
# eg: mysite.com
import_site_domain=''

# specify path (inside the Vagrant VM) to WordPress to allow wp-cli to do search and replace
# eg /vagrant
wordpress_path=''
