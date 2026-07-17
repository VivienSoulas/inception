#!/bin/bash

set -e

echo "Starting Nginx script..."

mkdir -p /etc/nginx/ssl

if [ ! -f /etc/nginx/ssl/server.crt ]; then

	echo "Generate SSL certificate..."

    openssl req -x509 -nodes \
        -days 365 \
        -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/server.key \
        -out /etc/nginx/ssl/server.crt \
        -subj "/CN=${DOMAIN_NAME}"

		chmod 644 "/etc/nginx/ssl/server.crt"
		chmod 600 "/etc/nginx/ssl/server.key"
fi

# changes $DOMAIN_NAME into the .env variable inside the .conf file
sed -i "s|\$DOMAIN_NAME|$DOMAIN_NAME|g" /etc/nginx/nginx.conf

echo "Starting nginx with domain ${DOMAIN_NAME}"

exec nginx -g "daemon off;"