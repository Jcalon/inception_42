FROM alpine:3.16

#Installation de MariaDB
RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client

#Exec d'un script pour creer la DB grace aux ARG
COPY requirements/mariadb/conf/create_db.sh /tmp/create_db.sh
RUN chmod +x /tmp/create_db.sh

#Ouverture du port de mariadb
EXPOSE 3306

#On passe a mysql cree au dessus et sous cet user on demarre la base de donnee
CMD ["/tmp/create_db.sh"]
