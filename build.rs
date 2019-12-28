use cc;
use std::env;

fn main() {
    env::set_var("CC", "clang");
    println!("cargo:rustc-link-lib=boot");
    cc::Build::new()
        .file("src/boot.s")
        .flag("-Qunused-arguments")
        .compile("boot");
}
