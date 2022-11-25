#!/bin/sh

if [ ! -d /var/lib/mysql/wordpress ]
then

	echo "Starting temporary server..."
	mariadbd --user=root &

	sleep 3

	echo "Creating Wordpress database..."
	mysql --user=root <<- _EOF_
		CREATE DATABASE $DB_NAME;
		CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
		GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%';
		FLUSH PRIVILEGES;
	_EOF_
	echo "Wordpress database created!"

	echo "Securing the MYSQL installation..."
	mysql --user=root <<- _EOF_
		ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT';
		DELETE FROM mysql.user WHERE User='';
		DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
		DROP DATABASE IF EXISTS test;
		DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
		FLUSH PRIVILEGES;
	_EOF_
	echo "MYSQL installation secured!"

	echo "Stopping temporary server!"
	mysqladmin --user=root --password=$DB_ROOT shutdown

	sleep 3
fi

echo "Starting mariadb server..."
exec mariadbd --user=root
