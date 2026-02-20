FROM golang:latest AS builder

RUN go install github.com/cpcloud/micasa/cmd/micasa@latest

FROM registry.fedoraproject.org/fedora-minimal:latest

RUN groupadd -r micasa -g 1001 && useradd -u 1001 -r -g micasa -s /bin/false -d /home/micasa micasa
WORKDIR /home/micasa
RUN mkdir -p /home/micasa/.local/share/micasa && \
    chown -R micasa:micasa /home/micasa && \
    chmod -R ug+rw /home/micasa

RUN microdnf install -y ttyd sqlite && \
    microdnf clean all

COPY --from=builder /go/bin/micasa /usr/local/bin/micasa

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 7681
USER micasa

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["ttyd", "--writable", "--port", "7681", "micasa"]
