#!bin/sh

#Configuration de WP et connection au conteneur de la DB

if [ ! -f "/var/www/wp-config.php" ]; then
cat << EOF > /var/www/wp-config.php
<?php
define( 'DB_NAME', '${DB_NAME}' );
define( 'DB_USER', '${DB_USER}' );
define( 'DB_PASSWORD', '${DB_PASS}' );
define( 'DB_HOST', 'mariadb' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
define('FS_METHOD','direct');
\$table_prefix = 'wp_';
define( 'WP_DEBUG', false );

#Reglages liés a redis pour les bonus
if ( ! defined( 'ABSPATH' ) ) {
define( 'ABSPATH', __DIR__ . '/' );}
define( 'WP_REDIS_HOST', 'redis' );
define( 'WP_REDIS_PORT', 6379 );
define( 'WP_REDIS_TIMEOUT', 1 );
define( 'WP_REDIS_READ_TIMEOUT', 1 );
define( 'WP_REDIS_DATABASE', 0 );
require_once ABSPATH . 'wp-settings.php';
EOF

        echo "Installing Wordpress..."
        wp core install --url=jcalon.42.fr --title="Inception" --admin_user=$WP_ADMIN \
                --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email
        echo "Wordpress is installed!"

        echo "Creating second user.."
        wp user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASS --role=author
        echo "Second user created!"

        echo "Installing Wordpress theme..."
        wp theme install twentytwentyone --activate
        echo "Wordpress theme installed!"

fi
