FROM alpine:latest
RUN apk update && \
    apk add --no-cache gammu && \
    apk add --no-cache gammu-smsd
COPY ./entrypoint.sh /
COPY ./send-telegram.sh /etc/
COPY ./gammurc /etc/
RUN chmod +x /entrypoint.sh
RUN chmod +x /etc/send-telegram.sh
ENTRYPOINT ["/entrypoint.sh"]