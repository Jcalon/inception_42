#!/bin/sh

while ! mariadb -hmariadb -u$DB_USER -p$DB_PASS $DB_NAME &>/dev/null; do
    sleep 3
done

if [ ! -f "/var/www/html/index.html" ]; then

    # BONUS site statique en html
    mv /tmp/index.html /var/www/html/index.html

    # BONUS Adminer
    wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql-en.php -O /var/www/html/adminer.php &> /dev/null
    wget https://raw.githubusercontent.com/Niyko/Hydra-Dark-Theme-for-Adminer/master/adminer.css -O /var/www/html/adminer.css &> /dev/null

	# Installation de wordpress via WP-CLI
    wp core download --allow-root
    wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=mariadb --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
    wp core install --url=$DOMAIN_NAME/wordpress --title="Inception" --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
    wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASS --allow-root
    wp theme install inspiro --activate --allow-root

    # BONUS Reglages liés a redis pour les bonus
    sed -i "40i define( 'WP_REDIS_HOST', 'redis' );"      wp-config.php
    sed -i "41i define( 'WP_REDIS_PORT', 6379 );"               wp-config.php
    sed -i "42i define( 'WP_REDIS_TIMEOUT', 1 );"               wp-config.php
    sed -i "43i define( 'WP_REDIS_READ_TIMEOUT', 1 );"          wp-config.php
    sed -i "44i define( 'WP_REDIS_DATABASE', 0 );\n"            wp-config.php

    wp plugin install redis-cache --activate --allow-root
    wp plugin update --all --allow-root

fi

wp redis enable --allow-root

echo "Wordpress started on :9000"
/usr/sbin/php-fpm8 -F -R