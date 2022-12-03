#!/bin/sh

# On attend le lancement de mysql
while ! mariadb -h$DB_HOST -u$DB_USER -p$DB_PASS $DB_NAME &>/dev/null; do
    sleep 5
done

if [ ! -f "wp-config.php" ]; then

	# Installation de wordpress via WP-CLI
    wp core download --allow-root
    wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=$DB_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
    wp core install --url=$DOMAIN_NAME/wordpress --title=$WP_NAME --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
    wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASS --allow-root
    wp theme install inspiro --activate --allow-root

fi

echo "Wordpress started on :9000"
/usr/sbin/php-fpm8 -F -R