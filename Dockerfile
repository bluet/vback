FROM alpine:3.17

RUN apk add --no-cache pigz pv

COPY vback /

ENTRYPOINT [ "/bin/sh", "/vback" ]
