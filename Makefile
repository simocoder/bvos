QEMU = qemu-system-i386

all: os-image.bin

boot.bin: boot.asm kernel.bin
	$(eval KSECTORS := $(shell bash -c 's=$$(stat -c%s kernel.bin); echo $$(( (s + 511) / 512 ))'))
	@echo "KERNEL_SECTORS=$(KSECTORS)"
	nasm -f bin -D KERNEL_SECTORS=$(KSECTORS) boot.asm -o boot.bin

kernel_entry.o: kernel_entry.asm
	nasm -f elf32 kernel_entry.asm -o kernel_entry.o

kernel.o: kernel.c
	gcc -m32 -ffreestanding -fno-pic -fno-pie -fno-builtin -nostdlib -nostartfiles -O2 -Wall -Wextra -c kernel.c -o kernel.o

kernel.elf: kernel_entry.o kernel.o linker.ld
	ld -m elf_i386 -T linker.ld -o kernel.elf kernel_entry.o kernel.o

kernel.bin: kernel.elf
	objcopy -O binary kernel.elf kernel.bin

os-image.bin: boot.bin kernel.bin
	cat boot.bin kernel.bin > os-image.bin

run: os-image.bin
	$(QEMU) -drive format=raw,file=os-image.bin -boot c -no-reboot -no-shutdown -monitor stdio

clean:
	rm -f *.o *.elf *.bin os-image.bin
