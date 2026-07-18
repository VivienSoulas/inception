#!/bin/bash

set -e

if ! command -v docker >/dev/null 2>&1; then
	echo "Installing docker and docker-compose"
	apt update -y
	apt install -y docker.io
	apt install -y docker-compose
fi

if ! grep -qF "$DOMAIN_NAME" /etc/hosts; then
	echo "127.0.0.1	$DOMAIN_NAME" >> /etc/hosts
	echo "Added $DOMAIN_NAME to /etc/hosts"
fi