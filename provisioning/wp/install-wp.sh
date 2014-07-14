#!/usr/bin/env bash


if $install_wordpress ; then

  echo "**** installing WP"

	cd $wordpress_path;

	wp core download --allow-root --path=$wordpress_path

	wp core config --allow-root --path=$wordpress_path --dbname=vagrant_test --dbuser=root --dbpass=root --extra-php <<PHP
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', true );
PHP

	wp core install --allow-root \
                  --path=$wordpress_path \
								  --url=nginx.local \
									--admin_user=$wp_admin_user \
									--admin_password=$wp_admin_password \
									--admin_email=$wp_admin_email \
									--title=$wp_site_title


fi
