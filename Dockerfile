FROM golang:1-alpine AS build

RUN apk update && apk add make git gcc musl-dev git

RUN go get github.com/percona/mongodb_exporter/...

WORKDIR /go/src/github.com/percona/mongodb_exporter

RUN git checkout v0.6.3

RUN make build

FROM alpine:latest
RUN apk add --no-cache ca-certificates && mkdir /app
COPY --from=build /go/src/github.com/percona/mongodb_exporter/mongodb_exporter /app/mongodb_exporter

ENTRYPOINT /app/mongodb_exporter