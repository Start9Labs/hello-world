HELLO_WORLD_SRC := $(shell find ./src) Cargo.toml Cargo.lock

hello-world/target/aarch64-unknown-linux-musl/release/hello-world: $(HELLO_WORLD_SRC)
	docker run --rm -it -v ~/.cargo/registry:/root/.cargo/registry -v "$(shell pwd)":/home/rust/src messense/rust-musl-cross:aarch64-musl cargo build --release