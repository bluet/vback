FROM alpine:3.15

RUN apk add --no-cache pigz pv

COPY vback /

ENTRYPOINT [ "/bin/sh", "/vback" ]
