use include_dir::{include_dir, Dir};

static PROJECT_DIR: Dir = include_dir!("$CARGO_MANIFEST_DIR");

fn main() {
    let lib_rs = PROJECT_DIR
        .get_file("src/bin/include_dir-example.rs")
        .unwrap();
    let body = lib_rs.contents_utf8().unwrap();
    assert!(body.contains("globs"));
    #[allow(unused_variables)]
    let glob: &str = "*dir-example*";
    #[cfg(feature = "glob")]
    for entry in PROJECT_DIR.find(&glob).unwrap() {
        let file = PROJECT_DIR.get_file(format!("{}", entry.path().display()));
        if file.is_none() {
        } else {
            let file_contents = file.expect("REASON").contents_utf8();
            let file_path = file.expect("REASON").path();
            if file_contents.is_none() {
            } else {
                print!("{:}\n", file_path.display());
                print!("{:}", file_contents.clone().unwrap());
            }
        }
    }
}
