FROM alpine:3.16

ARG PHP_VERSION=8

#Installation de php sur lequel va tourner WP, -fpm pour interagir avec nginx, -fpm pour mariaDB et tout le reste requis par la doc WP
#wget pour download WP
#adminer et redis pour le bonus
RUN apk update && apk upgrade && apk add --no-cache php${PHP_VERSION} \
                                                    php${PHP_VERSION}-fpm \
                                                    php${PHP_VERSION}-mysqli \
                                                    php${PHP_VERSION}-json \
                                                    php${PHP_VERSION}-curl \
                                                    php${PHP_VERSION}-opcache \
                                                    php${PHP_VERSION}-phar \
                                                    php${PHP_VERSION}-dom \
                                                    php${PHP_VERSION}-exif \
                                                    php${PHP_VERSION}-fileinfo \
                                                    php${PHP_VERSION}-mbstring \
                                                    php${PHP_VERSION}-openssl \
                                                    php${PHP_VERSION}-xml \
                                                    php${PHP_VERSION}-zip \
                                                    php${PHP_VERSION}-redis \
													#Package necessaire pour adminer
                                                    php${PHP_VERSION}-common \
                                                    php${PHP_VERSION}-session \
                                                    php${PHP_VERSION}-iconv \
                                                    php${PHP_VERSION}-gd \
                                                    php${PHP_VERSION}-curl \
                                                    php${PHP_VERSION}-xml \
                                                    php${PHP_VERSION}-mysqli \
                                                    php${PHP_VERSION}-imap \
                                                    php${PHP_VERSION}-cgi \
                                                    php${PHP_VERSION}-pdo \
                                                    php${PHP_VERSION}-pdo_mysql \
                                                    php${PHP_VERSION}-soap \
                                                    php${PHP_VERSION}-posix \
                                                    php${PHP_VERSION}-gettext \
                                                    php${PHP_VERSION}-ldap \
                                                    php${PHP_VERSION}-ctype \
                                                    php${PHP_VERSION}-dom \
                                                    php${PHP_VERSION}-simplexml \
                                                    mariadb-client \
													redis \
													tar \
                                                    wget

#Modif de la configuration php afin que notre fastcgi ecoute le port 9000
RUN	adduser -S nginx &&	addgroup -S nginx
COPY requirements/wordpress/conf/php-fpm.conf /etc/php8/php-fpm.conf
COPY requirements/wordpress/conf/www.conf /etc/php8/php-fpm.d/www.conf

# On deplace le site statique
COPY requirements/wordpress/conf/index.html /tmp/index.html

#Download de WP Client
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN cp wp-cli.phar /usr/bin/wp

WORKDIR /var/www/html/wordpress

#Exec d'un script de configuration de WP
COPY requirements/wordpress/tools/config_wp.sh /tmp/config_wp.sh

ENTRYPOINT [ "sh", "/tmp/config_wp.sh" ]
