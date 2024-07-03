# include_dir

[![Continuous Integration](https://github.com/gnostr-org/include_dir/actions/workflows/main.yml/badge.svg)](https://github.com/Michael-F-Bryan/include_dir/actions/workflows/main.yml)
[![license](https://img.shields.io/github/license/gnostr-org/include_dir.svg)](LICENSE)
[![Crates.io](https://img.shields.io/crates/v/include_dir.svg)](https://crates.io/crates/include_dir)
[![Docs.rs](https://docs.rs/include_dir/badge.svg)](https://docs.rs/include_dir/)

An evolution of the `include_str!()` and `include_bytes!()` macros for embedding
an entire directory tree into your binary.

Rendered Documentation:

- [master](https://michael-f-bryan.github.io/include_dir)
- [Latest Release](https://docs.rs/include_dir/)

## Getting Started

The `include_dir!()` macro works very similarly to the normal `include_str!()`
and `include_bytes!()` macros. You pass the macro a file path and assign the
returned value to some `static` variable.

```rust
use include_dir::{include_dir, Dir};

static PROJECT_DIR: Dir = include_dir!("$CARGO_MANIFEST_DIR");

fn main() {
    let lib_rs = PROJECT_DIR.get_file("src/lib.rs").unwrap();
    let body = lib_rs.contents_utf8().unwrap();
    assert!(body.contains("globs"));
    #[allow(unused_variables)]
    let glob: &str = "**";
    #[cfg(feature = "glob")]
    for entry in PROJECT_DIR.find(&glob).unwrap() {

        let file = PROJECT_DIR.get_file(format!("{}", entry.path().display()));
        if file.is_none() {
        } else {
            let file_contents = file.expect("REASON").contents_utf8();
            let file_path = file.expect("REASON").path();
            if file_contents.is_none() {
            } else {
                print!("{:}\n",file_path.display());
                print!("{:}",file_contents.clone().unwrap());
            }
        }
    }
}
```

## Features

- Embed a directory tree into your binary at compile time
- Find a file in the embedded directory
- Search for files using a glob pattern (requires the `globs` feature)
- File metadata (requires the `metadata` feature)

To-Do list:

- Compression?
