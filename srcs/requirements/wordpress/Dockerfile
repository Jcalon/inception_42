FROM alpine:3.16

#Installation de php sur lequel va tourner WP, -fpm pour interagir avec nginx, -fpm pour mariaDB et tout le reste requis par la doc WP
#wget pour download WP
RUN	apk update && apk upgrade && apk add --no-cache \
		wget				\
        tar                 \
		mariadb-client		\
		php8				\
		php8-fpm			\
		php8-cli			\
		php8-curl			\
		php8-dom			\
		php8-exif			\
		php8-fileinfo		\
		php8-gd				\
		php8-iconv			\
		php8-intl			\
		php8-json			\
		php8-mbstring		\
		php8-mysqli			\
		php8-openssl		\
		php8-phar			\
		php8-xml 			\
		php8-zip			\
		php8-zlib					
		

#Modif de la configuration php afin que notre fastcgi ecoute le port 9000
COPY requirements/wordpress/conf/php-fpm.conf /etc/php8/php-fpm.conf
COPY requirements/wordpress/conf/www.conf /etc/php8/php-fpm.d/www.conf

#Download de WP Client
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN cp wp-cli.phar /usr/bin/wp

WORKDIR /var/www/wordpress

COPY requirements/wordpress/tools/config_wp.sh /tmp/config_wp.sh

RUN chmod +x /tmp/config_wp.sh

#Ouverture du port de wordpress
EXPOSE 9000

CMD [ "/tmp/config_wp.sh" ]