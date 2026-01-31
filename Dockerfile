FROM --platform=$BUILDPLATFORM alpine:latest AS setup
ARG TARGETARCH
COPY target/x86_64-unknown-linux-musl/release/hello-world /tmp/bin-amd64
COPY target/aarch64-unknown-linux-musl/release/hello-world /tmp/bin-arm64
COPY target/riscv64gc-unknown-linux-musl/release/hello-world /tmp/bin-riscv64
RUN cp /tmp/bin-${TARGETARCH} /tmp/hello-world

FROM alpine:latest
RUN apk add --no-cache tini
COPY --from=setup /tmp/hello-world /usr/local/bin/hello-world
EXPOSE 8080
ENTRYPOINT ["tini", "--", "hello-world"]
