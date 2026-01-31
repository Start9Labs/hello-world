HELLO_WORLD_SRC := $(shell find ./src) Cargo.toml Cargo.lock

.PHONY: all
all: target/aarch64-unknown-linux-musl/release/hello-world target/riscv64gc-unknown-linux-musl/release/hello-world

target/aarch64-unknown-linux-musl/release/hello-world: $(HELLO_WORLD_SRC)
	docker run --rm -it -v ~/.cargo/registry:/root/.cargo/registry -v "$(shell pwd)":/home/rust/src messense/rust-musl-cross:aarch64-musl cargo build --release

target/riscv64gc-unknown-linux-musl/release/hello-world: $(HELLO_WORLD_SRC)
	docker run --rm -it -v ~/.cargo/registry:/root/.cargo/registry -v "$(shell pwd)":/home/rust/src messense/rust-musl-cross:riscv64gc-musl cargo build --release
