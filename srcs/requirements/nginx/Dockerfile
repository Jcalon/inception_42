FROM alpine:3.16

#MAJ du gestionnaire de fichiers et installation de nginx
RUN apk update && apk upgrade && apk add --no-cache nginx

#Ouverture du port HTTPS
EXPOSE 443

#Execution de la config installee
ENTRYPOINT ["nginx", "-g", "daemon off;"]
