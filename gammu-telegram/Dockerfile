FROM alpine:latest
RUN apk update && \
    apk add --no-cache gammu && \
    apk add --no-cache gammu-smsd

RUN mkdir -p /var/spool/gammu/inbox \
    && mkdir -p /var/spool/gammu/outbox \
    && mkdir -p /var/spool/gammu/sent \
    && mkdir -p /var/spool/gammu/error

COPY ./entrypoint.sh /entrypoint.sh
COPY ./send-telegram.sh /etc/send-telegram.sh
COPY ./gammu-smsdrc /etc/gammu-smsdrc
RUN chmod +x /entrypoint.sh
RUN chmod +x /etc/send-telegram.sh
ENTRYPOINT ["/entrypoint.sh"]