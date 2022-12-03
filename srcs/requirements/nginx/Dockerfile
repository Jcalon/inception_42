FROM alpine:3.16

#MAJ du gestionnaire de fichiers et installation de nginx et openssl pour avoir des cles
RUN apk update && apk upgrade && apk add --no-cache nginx

#Copy des cles pour avoir le https
# RUN mkdir /etc/nginx/ssl
# COPY requirements/nginx/tools/jcalon.42.fr.crt /etc/nginx/ssl/jcalon.42.fr.crt
# COPY requirements/nginx/tools/jcalon.42.fr.key /etc/nginx/ssl/jcalon.42.fr.key

#Config de nginx
RUN mkdir -p /run/nginx
COPY requirements/nginx/conf/nginx.conf /etc/nginx/conf.d/default.conf

#Ouverture du port de nginx
EXPOSE 443

#Execution de la config installee
CMD ["nginx", "-g", "daemon off;"]
