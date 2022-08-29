FROM arm64v8/alpine:latest

RUN apk update
RUN apk add tini

ADD ./target/aarch64-unknown-linux-musl/release/hello-world /usr/local/bin/hello-world

EXPOSE 8080

ENTRYPOINT tini hello-world
