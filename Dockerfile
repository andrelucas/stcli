FROM alpine:latest
COPY storageos /
ENTRYPOINT ["/storageos"]
