FROM alpine:3.13

#MAJ du gestionnaire de fichiers et installation de nginx
RUN apk update && apk upgrade && apk add --no-cache nginx

#Config de nginx
RUN mkdir -p /run/nginx
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

#Execution de la config installee
ENTRYPOINT ["nginx", "-g", "daemon off;"]
