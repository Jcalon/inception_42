FROM alpine:3.16

#installation de vstpd
RUN apk update && apk upgrade && apk add --no-cache vsftpd

COPY conf/vsftpd.conf /tmp/vsftpd.conf

COPY tools/config_ftp.sh /tmp/config_ftp.sh

RUN chmod +x /tmp/config_ftp.sh

ENTRYPOINT ["sh", "/tmp/config_ftp.sh"]
