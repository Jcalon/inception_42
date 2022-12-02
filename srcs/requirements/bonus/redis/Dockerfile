FROM alpine:3.13

RUN	apk update && apk upgrade && apk add --no-cache \
        redis

COPY conf/config_redis.sh /tmp/config_redis.sh

RUN chmod +x /tmp/config_redis.sh

ENTRYPOINT ["sh", "/tmp/config_redis.sh"]
