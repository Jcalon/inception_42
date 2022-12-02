FROM alpine:3.16

#Installation de php sur lequel va tourner WP, -fpm pour interagir avec nginx, -fpm pour mariaDB et tout le reste requis par la doc WP
#wget pour download WP
#adminer et redis pour le bonus
RUN apk update && apk upgrade && apk add --no-cache \
		wget				\
        tar                 \
		mariadb-client		\
		redis				\
		php8				\
		php8-fpm			\
		php8-bcmath			\
		php8-bz2 			\
		php8-calendar		\
		php8-ctype			\
		php8-curl			\
		php8-dom			\
		php8-exif			\
		php8-fileinfo		\
		php8-gd				\
		php8-gmagick		\
		php8-gmp			\
		php8-iconv			\
		php8-imap			\
		php8-intl			\
		php8-json			\
		php8-mbstring		\
		php8-mcrypt			\
		php8-memcache		\
		php8-mysqli			\
		php8-mysqlnd		\
		php8-openssl		\
		php8-pcntl			\
		php8-pdo			\
		php8-pdo_mysql		\
		php8-pdo_pgsql		\
		php8-pdo_sqlite 	\
		php8-pgsql			\
		php8-phar			\
		php8-posix			\
		php8-session		\
		php8-shmop			\
		php8-simplexml		\
		php8-soap			\
		php8-sockets		\
		php8-sodium			\
		php8-sqlite3		\
		php8-sysvsem		\
		php8-sysvshm		\
		php8-tokenizer		\
		php8-xml			\
		php8-xmlreader		\
		php8-xmlwriter		\
		php8-xsl			\
		php8-zip			\
		php8-zlib

#Modif de la configuration php afin que notre fastcgi ecoute le port 9000
RUN	adduser -S nginx &&	addgroup -S nginx
COPY conf/php-fpm.conf /etc/php8/php-fpm.conf
COPY conf/www.conf /etc/php8/php-fpm.d/www.conf

# On deplace le site statique
COPY conf/index.html /tmp/index.html

#Download de WP Client
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN cp wp-cli.phar /usr/bin/wp

WORKDIR /var/www/html/wordpress

#Exec d'un script de configuration de WP
COPY tools/config_wp.sh /tmp/config_wp.sh

ENTRYPOINT [ "sh", "/tmp/config_wp.sh" ]
