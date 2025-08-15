/* linker.ld — link flat 32‑bit binary to load at 0x00010000 */
ENTRY(_start)
SECTIONS {
  . = 0x00010000;

  .text : {
    *(.text*)
  }
  .rodata : {
    *(.rodata*)
  }
  .data : {
    *(.data*)
  }
  .bss : {
    *(COMMON)
    *(.bss*)
  }
}
