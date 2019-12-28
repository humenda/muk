Muk -- A Rust Microkernel
==========================

This repository contains a toy microkernel that contains a minimalist kernel and
can be used as a starting point to explore the aarch64 architecture. 
Please see also the
[licencing information](LICENCE.md).

Building
--------

You need a rust install, see <https://rust-lang.org>. When installed, enable
Rust nightly and add `std` sources:

    rustup toolchain install nightly
    rustup default nightly
    rustup component add rust-src

For building and executing, you also need lld, llvm, clang and GNU Make. If you
are on Debian or a derivative such as Ubuntu/Mint, execute:

    sudo apt install llvm lld clang build-essential qemu-system-arm

Then install `Xargo` which will build the core crate for aarch64 for us:

     cargo install xargo

Development
-----------

It seems as if a few features for customising Cargo were missing and therefore
development should happen using `make clean`, `make` and `make qemu`. When using
`make qemu DEBUG=1`, QEMU is spawned with an open socket for GDB. Use
[scripts/kernel.gdb](scripts/kernel.gdb) to attach to it.

