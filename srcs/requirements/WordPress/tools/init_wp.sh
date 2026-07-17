#!/bin/bash

set -e

echo "Starting WordPress script..."

# Wait for MariaDB
while ! mysqladmin ping \
    -h"mariadb" \
    -u"$MYSQL_USER" \
    -p"$MYSQL_PASSWORD" \
    --silent
do
	echo "Waiting for MariaDB ..."
    sleep 2
done

# Check initialization
if [ ! -f /var/www/html/wp-config.php ]
then

	echo "Starting initialization..."

    if [ ! -f /var/www/html/wp-load.php ]
    then
        wp core download \
            --path=/var/www/html \
            --allow-root
    fi

	# create wp_config.php
	wp config create \
		--path=/var/www/html \
		--dbname="$MYSQL_DATABASE" \
		--dbuser="$MYSQL_USER" \
		--dbpass="$MYSQL_PASSWORD" \
		--dbhost="mariadb" \
		--allow-root

    # install wordpress
	wp core install \
		--path=/var/www/html \
		--url="$DOMAIN_NAME" \
		--title="My amazing Website" \
		--admin_user="$WP_ADMIN" \
		--admin_password="$WP_ADMIN_PASSWORD" \
		--admin_email="$WP_ADMIN_EMAIL" \
		--allow-root

	# create user
	wp user create \
		"${WP_USER}" \
		"${WP_USER_EMAIL}" \
		--user_pass="${WP_USER_PASSWORD}" \
		--role=author \
		--path=/var/www/html \
		--allow-root

	chown -R www-data:www-data /var/www/html
	echo "Initialisation finished..."
fi

echo "Starting WordPress..."

# Start main process
exec php-fpm8.2 -F