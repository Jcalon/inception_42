FROM alpine:3.16

#On envoie les donnees via ARG et pas ENV pour pas qu'elles soient utilisees apres le demarrage
ARG DB_NAME \
    DB_USER \
    DB_PASS \
    DB_ROOT

#Installation de MariaDB
RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client

#Ouverture du port MySQL donc MariaDB par defaut
EXPOSE 3306

#Exec d'un script pour creer la DB grace aux ARG
COPY requirements/mariadb/conf/create_db.sh .
RUN chmod +x create_db.sh

#On passe a mysql cree au dessus et sous cet user on demarre la base de donnee
CMD ["./create_db.sh"]
