# BVOS — Barely Visible OS

A minimal 32-bit x86 operating system written in **Assembly** and **C**, designed as a learning project to explore bootloaders, protected mode, and kernel basics.  
It does almost nothing… and that’s the point.

---

## Features

- **Boots from BIOS** via a custom MBR boot sector  
- **Loads a tiny kernel** from disk into memory  
- **Switches to Protected Mode** and runs C code  
- Writes “Hello, world!” directly to VGA text memory  
- Fits in **just a few sectors**

---

## Build & Run

**Prerequisites**
- `nasm` (Netwide Assembler)
- `gcc` (with 32-bit support)
- `ld` (GNU linker)
- `qemu-system-i386` (or another emulator)

```bash
sudo apt-get install -y nasm gcc-multilib qemu-system-x86
```

**Build**
```bash
make
```

**Run**
```bash
make run
```

**Clean**
```bash
make clean
```

---

## Project Structure

```
boot.asm          # Bootloader - loads the kernel
kernel_entry.asm  # Switches to protected mode, jumps to C kernel
kernel.c          # Minimal C kernel
linker.ld         # Linker script for flat binary
Makefile          # Build rules
```

---

## How It Works

1. **Bootloader** (`boot.asm`)
   - Runs in 16-bit real mode
   - Uses BIOS interrupts to load the kernel from disk
   - Switches to 32-bit protected mode

2. **Kernel Entry** (`kernel_entry.asm`)
   - Sets up the stack
   - Calls the C kernel function

3. **C Kernel** (`kernel.c`)
   - Writes text to VGA memory
   - Halts the CPU in an infinite loop

---

## Disclaimer

This project is for **learning purposes only**.  
It is **not** a complete operating system — it’s just enough code to demonstrate the boot process and run simple C code on bare metal.

---

## License

MIT License — see [LICENSE](LICENSE) for details.

## Blog

[https://www.rebelyaml.com/posts/bvos-barely-visible-os/](https://www.rebelyaml.com/posts/bvos-barely-visible-os/)
