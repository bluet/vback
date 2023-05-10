FROM alpine:3.18

RUN apk add --no-cache pigz pv

COPY vback /

ENTRYPOINT [ "/bin/sh", "/vback" ]
