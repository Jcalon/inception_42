FROM alpine:3.16

#On envoie les donnees via ARG et pas ENV pour pas qu'elles soient utilisees apres le demarrage
ARG DB_NAME \
    DB_USER \
    DB_PASS \
	DB_ROOT

#Installation de MariaDB
RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client

#Exec d'un script pour creer la DB grace aux ARG
COPY conf/create_db.sh /tmp/create_db.sh
RUN chmod +x /tmp/create_db.sh

#On passe a mysql cree au dessus et sous cet user on demarre la base de donnee
CMD ["/tmp/create_db.sh"]
