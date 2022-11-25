FROM alpine:3.16

#On envoie les donnees via ARG et pas ENV pour pas qu'elles soient utilisees apres le demarrage et on precise la version de PHP
ARG DB_NAME \
    DB_USER \
    DB_PASS \
    WP_ADMIN \
    WP_ADMIN_EMAIL \
    WP_ADMIN_PASS \
    WP_USER \
    WP_USER_EMAIL \
    WP_USER_PASS \
    PHP_VERSION=8

#Installation de php sur lequel va tourner WP, -fpm pour interagir avec nginx, -fpm pour mariaDB et tout le reste requis par la doc WP
#wget et unzip pour download WP
#redis pour le bonus
#Modif de la configuration php afin que notre fastcgi ecoute le port 9000
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
                                                    mysql-client \
                                                    curl && \
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" /etc/php8/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" /etc/php8/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" /etc/php8/php-fpm.d/www.conf

#Chemin où on va unzip WP
WORKDIR /var/www

#Download et unzip de WP Client
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN wp core download --path=/var/www/

#Exec d'un script de configuration de WP
#chmod pour que notre CMS puisse download des plugins, themes, etc
COPY requirements/wordpress/conf/config_wp.sh .
#RUN sh config_wp.sh && rm config_wp.sh && chmod -R 0777 wp-content
RUN chmod +x config_wp.sh
#On exec notre php-fpm
CMD ["./config_wp.sh"]
