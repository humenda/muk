use core::fmt::{Error, Write};
use core::ptr;

// Todo: make this a singleton and concurrency-aware
pub struct Log {
    uart: *mut usize
}

impl Log {
    pub const fn new() -> Self {
        Self {
            uart: 0x09000000 as *mut usize
        }
    }
}

impl Write for Log {
    // ToDo: only ASCII support
    fn write_str(&mut self, s: &str) -> Result<(), Error> {
        for character in s.chars() {
            // QEMU UART expects characters cast as int
            unsafe {
                ptr::write_volatile(self.uart, character as _);
            }
        }
        Ok(())
    }
}
