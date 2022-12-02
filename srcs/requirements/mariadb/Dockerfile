FROM alpine:3.13

#Installation de MariaDB
RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client

#Exec d'un script pour creer la DB grace aux ARG
COPY conf/create_db.sh /tmp/create_db.sh
RUN chmod +x /tmp/create_db.sh

#On passe a mysql cree au dessus et sous cet user on demarre la base de donnee
ENTRYPOINT ["sh", "/tmp/create_db.sh"]
