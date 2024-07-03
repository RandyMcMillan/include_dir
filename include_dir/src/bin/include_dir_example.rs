use include_dir::{include_dir, Dir};

static PROJECT_DIR: Dir = include_dir!("$CARGO_MANIFEST_DIR");

fn main() {
    let lib_rs = PROJECT_DIR.get_file("src/lib.rs").unwrap();
    let body = lib_rs.contents_utf8().unwrap();
    assert!(body.contains("globs"));
    //#[cfg(feature = "metadata")]
    #[allow(unused_variables)]
    //let glob: &str = "**/*.rs";
    let glob: &str = "**";
    #[cfg(feature = "glob")]
    for entry in PROJECT_DIR.find(&glob).unwrap() {
        println!("Found {}", entry.path().display());
        let lib_rs = PROJECT_DIR.get_file(format!("{}",entry.path().display()));
        print!("{:?}\n",Some(lib_rs).unwrap());
        //let body = Some(lib_rs.expect("REASON").contents_utf8());
        //let body = lib_rs.contents_utf8().unwrap();
        //let body = lib_rs.expect("REASON").contents_utf8().unwrap();
        //print!("{:?}",Some(body).unwrap());
        //let entry_body: &str = PROJECT_DIR.get_file(entry.path().display().unwrap());
        //let body = entry.contents_utf8().unwrap();
    }
}
