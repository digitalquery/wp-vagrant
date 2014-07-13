#!/usr/bin/env bash

set -x

if $install_wordpress ; then
  echo "**** installing WP"

	cd $wordpress_path;

	wp core download --allow-root


	wp core config --allow-root --dbname=vagrant_test --dbuser=root --dbpass=root --extra-php <<PHP
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', true );
PHP


#	wp core install --allow-root \
#								  --url=nginx.local \
#									--admin_user=$wp_admin_user \
#									--admin_password=$wp_admin_password \
#									--admin_email=$wp_admin_email \
#									--title=$wp_site_title


fi


set +x