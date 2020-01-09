.section .bss
.global first_stack
first_stack:
    .word 0x0

.section .text
.global _start
_start:
    ldr x30, =stack_base // load stack pointer position from linker script
    adr x29, first_stack
    str x30, [x29]
    mov sp, x30 // move stack pointer into sp
    bl boot // branch into first Rust function (c ABI)


