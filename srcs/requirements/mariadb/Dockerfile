FROM alpine:3.16

#On envoie les donnees via ARG et pas ENV pour pas qu'elles soient utilisees apres le demarrage
ARG DB_NAME \
    DB_USER \
    DB_PASS

#Installation de MariaDB
RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client

#Modif de la configuration MySQL
#tee envoie echo au fichier et sed remplace les lignes
RUN mkdir /var/run/mysqld; \
    chmod 777 /var/run/mysqld; \
    { echo '[mysqld]'; \
      echo 'skip-host-cache'; \
      echo 'skip-name-resolve'; \
      echo 'bind-address=0.0.0.0'; \
    } | tee  /etc/my.cnf.d/docker.cnf; \
    sed -i "s|skip-networking|skip-networking=0|g" /etc/my.cnf.d/mariadb-server.cnf

#Creation de la base de donnee a partir de la config precedente (on precise ou la DB va etre stockee)
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

#Ouverture du port MySQL donc MariaDB par defaut
EXPOSE 3306

#Exec d'un script pour creer la DB grace aux ARG
COPY requirements/mariadb/conf/create_db.sh .
RUN sh create_db.sh && rm create_db.sh

#On passe a mysql cree au dessus et sous cet user on demarre la base de donnee
USER mysql
CMD ["/usr/bin/mysqld", "--skip-log-error"]
