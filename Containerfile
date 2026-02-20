FROM golang:latest AS builder

RUN go install github.com/cpcloud/micasa/cmd/micasa@latest

FROM registry.fedoraproject.org/fedora-minimal:latest

RUN microdnf install -y ttyd && \
    microdnf clean all

COPY --from=builder /go/bin/micasa /usr/local/bin/micasa

VOLUME ["/data"]
ENV MICASA_DB=/data/micasa.db

EXPOSE 7681

CMD ["ttyd", "--writable", "--port", "7681", "micasa"]
