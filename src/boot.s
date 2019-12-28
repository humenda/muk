.global _start
_start:
    ldr x30, =stack_base // load stack pointer position from linker script to x30
    mov sp, x30 // move stack pointer into sp
    b boot // branch into first Rust function (c ABI)
