// kernel.c — freestanding C (no libc)
#include <stdint.h>
#define VGA_TEXT ((volatile uint16_t*)0xB8000)

static void puts_at(int row, int col, const char* s) {
    volatile uint16_t* v = VGA_TEXT + (row * 80 + col);
    while (*s) {
        uint8_t ch = (uint8_t)*s++;
        uint8_t attr = 0x07; // light grey on black
        *v++ = (uint16_t)ch | ((uint16_t)attr << 8);
    }
}

static int strlen(const char* s) {
    int len = 0;
    while (*s++) len++;
    return len;
}

void kmain(void) {
    // Clear screen     
    for (int i = 0; i < 80*25; i++) {
        VGA_TEXT[i] = (uint16_t)' ' | (uint16_t)(0x07 << 8);
    } 
    puts_at(11, 33, "Hello, world!");
    for (;;){ __asm__ __volatile__("hlt"); }
}
