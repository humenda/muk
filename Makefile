SOURCES = $(wildcard src/*)
RS_TARGET = target/aarch64-elf/release/muk
IMG_TARGET = target/aarch64-elf/release/muk.img
CARGO_BUILD_RUSTFLAGS += -C panic=abort -ggdb

# Detect llvm binary (hack to work around old LLVM versions)
OBJCOPY = $(if $(shell which llvm-objcopy-8),llvm-objcopy-8,llvm-objcopy)

all: $(RS_TARGET)

$(RS_TARGET): $(SOURCES)
	$(if $(DEBUG),@echo CARGO_BUILD_RUSTFLAGS: $(CARGO_RUSTFLAGS))
	@PATH=`pwd`/scripts:$(PATH) cargo xbuild --release --target aarch64-elf

clean:
	rm -rf target

# Use `make qemu` to launch QEMU and `make qemu DEBUG=1` to launch it for GDB
# debugging.
qemu: $(IMG_TARGET)
	qemu-system-aarch64 -nographic -machine virt -cpu cortex-a53 \
		$(if $(DEBUG),-S -gdb tcp::2345) \
		-kernel $<

# Dump the ELF into an image so that QEMU creates a device tree
$(IMG_TARGET): $(RS_TARGET)
	$(OBJCOPY) --enable-deterministic-archives --output-target binary $< $@
