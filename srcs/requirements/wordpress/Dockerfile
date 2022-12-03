FROM alpine:3.16

#Installation de php sur lequel va tourner WP, -fpm pour interagir avec nginx, -fpm pour mariaDB et tout le reste requis par la doc WP
#wget pour download WP
#adminer et redis pour le bonus
RUN	apk update && apk upgrade && apk add --no-cache \
		wget				\
        tar                 \
		mariadb-client		\
		redis				\
		php8				\
		php8-fpm			\
		php8-cli			\
		php8-curl			\
		php8-gd				\
		php8-iconv			\
		php8-intl			\
		php8-json			\
		php8-mysqli			\
		php8-phar			\
		php8-zlib					
		

#Modif de la configuration php afin que notre fastcgi ecoute le port 9000
RUN	adduser -S nginx &&	addgroup -S nginx
COPY requirements/wordpress/conf/php-fpm.conf /etc/php8/php-fpm.conf
COPY requirements/wordpress/conf/www.conf /etc/php8/php-fpm.d/www.conf

#Download de WP Client
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN cp wp-cli.phar /usr/bin/wp

WORKDIR /var/www/html/wordpress

COPY requirements/wordpress/tools/config_wp.sh /tmp/config_wp.sh

RUN chmod +x /tmp/config_wp.sh

CMD [ "/tmp/config_wp.sh" ]