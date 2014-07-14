#!/usr/bin/env bash


if $install_wordpress ; then

  echo "**** installing WP $wp_version"

	cd $wp_path;

  # if wp_version is specified, then add this
  download_string=""
  if [ ! -z $wp_version ]; then
    download_string=" --version="$wp_version
  fi

  # download core files
	wp core download --allow-root --path=$wp_path $download_string

  # create wp-config.php
	wp core config --allow-root --path=$wp_path --dbname=vagrant_test --dbuser=root --dbpass=root --extra-php <<PHP
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', true );
PHP

  # install database
	wp core install --allow-root \
                  --path=$wp_path \
								  --url=nginx.local \
									--admin_user=$wp_admin_user \
									--admin_password=$wp_admin_password \
									--admin_email=$wp_admin_email \
									--title=$wp_site_title


fi
