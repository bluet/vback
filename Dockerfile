FROM alpine

RUN apk add --no-cache pigz pv

COPY vback /

ENTRYPOINT [ "/bin/sh", "/vback" ]
