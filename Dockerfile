FROM alpine:latest
MAINTAINER Ernesto Perez <eperez@linux.ec>
# Taken from https://github.com/nabeken/docker-volume-container-rsync

RUN apk add --update-cache \
    rsync \
    tzdata \
 && rm -rf /var/cache/apk/*

EXPOSE 873
VOLUME /docker
ADD ./run.sh /run.sh

ENTRYPOINT ["/run.sh"]
