export ASM=nasm
export TARGET_CC=i386-elf-gcc
export TARGET_LD=i386-elf-ld
export TARGET_GDB=i386-elf-gdb

export ASMFLAGS=
export TARGET_CFLAGS=-ffreestanding -O2 -g -Wno-stringop-overflow -pedantic -Wall
export TARGET_LDFLAGS=


export QEMU=qemu-system-i386
export TARGET_GDB=i386-elf-gdb