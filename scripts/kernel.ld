/* Kernel linker script for Aarch64 */
OUTPUT_ARCH(aarch64)
/* traditional start symbol */
ENTRY(_start)

SECTIONS {
    /* predefined address that QEMU jumps to on `virt` */
	. = 0x40000000;

	/* assembly code that gets executed first (located at address shown above */
	.boot . : { boot.o(.text) }
	.text : { *(.text) }
	.data : { *(.data) }
	.bss : { *(.bss COMMON) }
	. = ALIGN(8);
	/* 4k stack memory */
	. = . + 0x1000;
	stack_base = .;
}
