#![no_std]
#![no_main]
#![feature(lang_items)]

mod io;
mod thread;
mod types;

use core::fmt::Write;
use crate::io::console;

// some Rust language items to make it happy
#[lang = "eh_personality"] extern fn eh_personality() {}

#[panic_handler]
fn panic(info: &core::panic::PanicInfo) -> ! {
    let mut log = console::Log::new();
    writeln!(log, "{}", info).ok();
    loop {}
}

#[repr(C)]
struct KernelHeapLayout {
    start: usize,
    end: usize
}

extern "C" {
    static first_stack: usize;
}
// C function that the assembly file jumps to
#[no_mangle] // ensure that this symbol is called `main` in the output
pub extern "C" fn boot() {
    let mut log = console::Log::new();
    writeln!(log, "Rust for mu kernels! :)").unwrap();
    unsafe {
        writeln!(log, "Stack address: {:x}", first_stack).unwrap();
    }
    loop { }
}
