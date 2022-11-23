FROM alpine:3.16

#MAJ du gestionnaire de fichiers et installation de nginx
RUN	apk update && apk upgrade && apk add --no-cache nginx

#On modifie la config par defaut située dans /etc/nginx/http.d/default.conf en y plaçant un simple code indiquant un emplacement différent au lieu de celui standard (/var/www) RUN echo "server {" > /etc/nginx/http.d/default.conf && \
RUN echo "server {" > /etc/nginx/http.d/default.conf && \
    echo "root    /var/www;" >> /etc/nginx/http.d/default.conf && \
    echo "location / {" >> /etc/nginx/http.d/default.conf && \
    echo "    try_files \$uri /index.html;" >> /etc/nginx/http.d/default.conf && \
    echo "}}" >> /etc/nginx/http.d/default.conf

#On copie le contenu du site dans notre dossier /var/www/
COPY requirements/bonus/website/conf/* /var/www/

#Ouverture du port 80 (deja ouvert dans le systeme)
EXPOSE 80

#Execution de la config installee
CMD ["nginx", "-g", "daemon off;"]
