use include_dir::{include_dir, Dir};

static PROJECT_DIR: Dir = include_dir!("$CARGO_MANIFEST_DIR");

fn main() {
    let lib_rs = PROJECT_DIR.get_file("src/lib.rs").unwrap();
    let body = lib_rs.contents_utf8().unwrap();
    assert!(body.contains("globs"));
    //#[cfg(feature = "metadata")]
    let glob: &str = "**/*.rs";
    #[cfg(feature = "glob")]
    for entry in PROJECT_DIR.find(&glob).unwrap() {
        println!("Found {}", entry.path().display());
    }
}
