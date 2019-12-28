#![no_std]
#![no_main]
#![feature(lang_items)]

mod io;

use core::fmt::Write;
use crate::io::console;

#[panic_handler]
fn panic(info: &core::panic::PanicInfo) -> ! {
    let mut log = console::Log::new();
    writeln!(log, "{}", info).ok();
    loop {}
}

#[no_mangle] // ensure that this symbol is called `main` in the output
pub extern "C" fn boot() {
    let mut log = console::Log::new();
    writeln!(log, "Rust for mu kernels! :)").unwrap();
    loop { }
}

#[lang = "eh_personality"] extern fn eh_personality() {}