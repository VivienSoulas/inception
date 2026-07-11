#!/bin/bash

# if anything fails, stop the script
set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo "Initializing database"

	mariadb-install-db \
	--user=mysql \
	--datadir=/var/lib/mysql
fi

# Fix permissions before MariaDB starts
mkdir -p /var/run/mysqld

chown mysql:mysql /var/run/mysqld
chown -R mysql:mysql /var/lib/mysql

# first start of MariaDB
if [ ! -f "/var/lib/mysql/.initialized" ]; then

# starts mariadb in the background (with the &)
	mysqld_safe --datadir=/var/lib/mysql &

	until mysqladmin ping --silent --socket=/var/run/mysqld/mysqld.sock; do
		sleep 1
	done

	mysql -uroot << EOF
ALTER USER 'root'@'localhost'
IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%'
IDENTIFIED BY '${MYSQL_PASSWORD}';

GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';

FLUSH PRIVILEGES;

EOF

	MYSQL_PWD=${MYSQL_ROOT_PASSWORD} mysqladmin -uroot shutdown
	
# created .initialized for next run
	touch /var/lib/mysql/.initialized

fi

# start MariaDB
exec mysqld --user=mysql --datadir=/var/lib/mysql