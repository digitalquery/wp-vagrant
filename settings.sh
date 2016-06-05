#!/usr/bin/env bash


###############################################################################
# Basic settings
#

# this is hostname for the vagrant box
# make sure to change it in the Vagrantfile as well
hostname='wpvagrant.dev'

# PHP version to install
# valid values:
# 5.5
# 5.6
# 7.0
php_version='7.0'


# set install_wordpress to true to download and install latest version of WP
install_wordpress=false

# WordPress version to install (if install_wordpress=true)
# if blank, then current stable version will be installed
# wp_version="3.5.2"
# wp_version="4.0-beta1"
wp_version=""

# specify path (inside the Vagrant VM) to WordPress to allow wp-cli to do search and replace
# this will normall be /vagrant unless you've made other config changes
wp_path='/vagrant'

#mysql root password
mysql_root_password='root'


###############################################################################
# WP database
# this will create a db with these details
#


# name of database: eg wordpress
wp_db_name='wp_vagrant'

# database user name, leave empty for root
wp_db_user=''

# database password
wp_db_password=''

###############################################################################
# WP admin / install
# if this is a new db install, then use these details for the
# initial WP admin user
# ignored if install_wordpress is false
#

wp_admin_user='admin'

wp_admin_password='123'

wp_admin_email='root@example.com'

wp_site_title='WP Vagrant'



###############################################################################
# Importing database
#

# set to true to import the database as part of the provisioning process
import_database=false

# specify the domain that the imported dump file uses.
# This allows us to search and replace the domain with dq-framework.dev
# eg: mysite.com
import_site_domain=''
