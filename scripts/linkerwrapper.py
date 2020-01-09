#!/usr/bin/env python3
# Helper wrapper script
# Rust's support for Lld is somewhat bizar. On Debian Buster, the -flavor
# argument is unknown and passing a custom linker script seems also impossible.
import os
import subprocess
import sys

ARCH = 'aarch64-elf'

def filter_linker_flavour(args):
    """Remove `-flavor gnu`."""
    new_args = []
    ignore = False
    for arg in args:
        if ignore:
            ignore = False # ignore this argument
        else:
            if arg == '-flavor':
                ignore = True
            else:
                new_args.append(arg)
    return new_args

def main():
    args = filter_linker_flavour(sys.argv[1:])
    target_path = os.path.join('target', ARCH, 'release')
    cmd = 'ld.lld -Tscripts/kernel.ld -nostdlib --start-group '
    cmd += ' '.join(args)
    cmd += ' --end-group'
    if 'DEBUG' in os.environ:
        with open(os.path.join(target_path, 'linker-command.sh'), 'w') as f:
                f.write(cmd + '\n')
    proc = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE,
            stderr=subprocess.PIPE)
    out = '\n'.join([x.decode(sys.getdefaultencoding()) for x in proc.communicate() if x]).strip()
    ret = proc.wait()
    if ret != 0 or out:
        print('ret: {ret}, out: {out}')
        sys.stderr.write(out + '\n')
        sys.exit((ret if ret != 0 else 1))

main()
