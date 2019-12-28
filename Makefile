SOURCES = $(wildcard src/*)
TARGET = target/aarch64-elf/release/muk
CARGO_BUILD_RUSTFLAGS += -C panic=abort -ggdb

all: $(TARGET)

$(TARGET): $(SOURCES)
	$(if $(DEBUG),@echo CARGO_BUILD_RUSTFLAGS: $(CARGO_RUSTFLAGS))
	@PATH=`pwd`/scripts:$(PATH) xargo build --release --target aarch64-elf

clean:
	rm -rf target

# Use `make qemu` to launch QEMU and `make qemu DEBUG=1` to launch it for GDB
# debugging.
qemu: $(TARGET)
	qemu-system-aarch64 -nographic -machine virt -cpu cortex-a53 \
		$(if $(DEBUG),-S -gdb tcp::2345) \
		-kernel $<
