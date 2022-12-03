FROM alpine:3.16

#MAJ du gestionnaire de fichiers et installation de nginx et openssl pour avoir des cles
RUN apk update && apk upgrade && apk add --no-cache nginx openssl

#Creation des cles pour avoir le https
RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
        -out /etc/nginx/ssl/jcalon.pem \
        -keyout /etc/nginx/ssl/jcalon.key \
		-subj "/C=IT/ST=Bordeaux/L=Bordeaux/O=42 School/OU=jcalon/CN=jcalon/"

#Config de nginx
RUN mkdir -p /run/nginx
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

#Execution de la config installee
CMD ["nginx", "-g", "daemon off;"]
