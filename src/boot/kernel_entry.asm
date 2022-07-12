[bits 32]
[extern main]       ; defined in kernel.c

call main   ; should be at address 0x1000

jmp $       ; jump indefinitely after main() returns