#!/usr/bin/env bash


# set install_wordpress to true to download and install latest version of WP
install_wordpress=false


#mysql root password
mysql_root_password='root'


# set to true to import the database as part of the provisioning process
deploy_database=true

# name of database: eg wordpress
wp_db_name=''

# database user name
wp_db_user=''

# database password
wp_db_password=''

# database dump file that should be imported automatically: eg wordpress_dump.sql
wp_db_dump_file=''

# specify path (inside the Vagrant VM) to WordPress to allow wp-cli to do search and replace
# this will normall be /vagrant unless you've made other config changes
wordpress_path='/vagrant'

# specify the domain that the imported dump file uses.
# This allows us to search and replace the domain with nginx.local
# eg: mysite.com
import_site_domain=''
