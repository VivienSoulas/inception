#!/bin/bash

set -e

if ! command -v docker; then
	echo "Installing docker and docker-compose"
	apt update -y
	apt install -y docker.io
	apt install -y docker-compose
fi

if ! grep -q "$WORDPRESS_URL" /etc/hosts; then
	echo "127.0.0.1	$WORDPRESS_URL" >> /etc/hosts
	echo "Added $WORDPRESS_URL to /etc/hosts"
fi