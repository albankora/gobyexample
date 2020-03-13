FROM golang:1.14-alpine

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash git

WORKDIR /app

ENV GOOS="linux"
ENV GOARCH="amd64"
ENV GO111MODULE="on"
ENV CGO_ENABLED="0"

COPY entry-point.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]