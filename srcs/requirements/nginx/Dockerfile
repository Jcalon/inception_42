FROM alpine:3.16

#MAJ du gestionnaire de fichiers et installation de nginx
RUN apk update && apk upgrade && apk add --no-cache nginx

#Config de nginx
RUN mkdir -p /run/nginx
COPY requirements/nginx/conf/nginx.conf /etc/nginx/conf.d/default.conf

#Ouverture du port de nginx
EXPOSE 443

#Execution de la config installee
CMD ["nginx", "-g", "daemon off;"]
