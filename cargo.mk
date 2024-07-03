##
##===============================================================================
##make cargo-*
cargo-help:### 	cargo-help
	@awk 'BEGIN {FS = ":.*?###"} /^[a-zA-Z_-]+:.*?###/ {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
cargo-release-all:### 	cargo-release-all
## 	cargo-release-all 	recursively cargo build --release
	for t in */Cargo.toml;  do echo $$t; cargo b -r -vv --manifest-path $$t; done
	for t in ffi/*/Cargo.toml;  do echo $$t; cargo b -r -vv --manifest-path $$t; done
cargo-clean-all:### 	cargo-clean-all - clean release artifacts
## 	cargo-clean-all 	recursively cargo clean --release
	for t in */Cargo.toml;  do echo $$t; cargo clean --release -vv --manifest-path $$t; done
cargo-install-all:### 	cargo-install-all
## 	cargo-install-all 	recursively cargo install -vv $(SUBMODULES)
## 	*** cargo install -vv --force is NOT used.
## 	*** cargo install -vv --force --path <path>
## 	*** to overwrite deploy cargo.io crates.
	for t in $(SUBMODULES); do echo $$t; cargo install -vv gnostr-$$t || echo "gnostr-$$t not found"; done

cargo-b:cargo-build### 	cargo b
cargo-build:### 	cargo build
## 	cargo-build q=true
	@. $(HOME)/.cargo/env
	@RUST_BACKTRACE=all cargo b $(QUIET) --features glob --features metadata
cargo-i:cargo-install
cargo-install:### 	cargo install --path jj
	@. $(HOME)/.cargo/env
	@cargo install --bin include_dir_example --path include_dir --features metadata --features glob
	@cargo install --bin include_dir-example --path include_dir --features metadata --features glob
cargo-br:cargo-build-release### 	cargo-br
## 	cargo-br q=true
	cargo b -r --features glob --features metadata
cargo-build-release:### 	cargo-build-release
## 	cargo-build-release q=true
	@. $(HOME)/.cargo/env && cargo b --release $(QUIET) --features glob --features metadata
cargo-c:cargo-check
cargo-check:### 	cargo-check
	@. $(HOME)/.cargo/env && cargo c --features glob --features metadata
cargo-bench:### 	cargo-bench
	@. $(HOME)/.cargo/env && cargo bench --features glob --features metadata
cargo-t:cargo-test
cargo-test:### 	cargo-test
	@. $(HOME)/.cargo/env && cargo test --verbose
	@. $(HOME)/.cargo/env && cargo test --verbose --features glob
	@. $(HOME)/.cargo/env && cargo test --verbose --features glob --features metadata
cargo-t-wp:cargo-test-workspace
cargo-test-workspace:### 	cargo-test-workspace
	@. $(HOME)/.cargo/env && cargo test --workspace --verbose --features glob --features metadata
cargo-report:### 	cargo-report
	@. $(HOME)/.cargo/env && cargo report future-incompatibilities --id 1

# vim: set noexpandtab:
# vim: set setfiletype make
