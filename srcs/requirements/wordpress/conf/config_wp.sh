#!/bin/sh

while ! mysql --user=$DB_USER --password=$DB_PASS -h mariadb --execute "SHOW DATABASES;" > /dev/null
do
	sleep 5
done

if [ ! -f /var/www/wp-config.php ]
then
	echo "Generating configuration file for Wordpress..."
	wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=mariadb
	echo "Wordpress configuration file generated!"

	echo "Installing Wordpress..."
	wp core install --url=localhost --title="Inception" --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email
	echo "Wordpress is installed!"

	echo "Creating second user.."
	wp user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASS --role=author
	echo "Second user created!"

	echo "Installing Wordpress theme..."
	wp theme install twentytwentyone --activate
	echo "Wordpress theme installed!"
fi

echo "Starting PHP-FPM..."
exec php-fpm8 -F
