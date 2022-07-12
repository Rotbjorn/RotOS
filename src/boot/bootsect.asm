[org 0x7C00]
[bits 16]

start:
    mov bp, 0x9000      ; set stack to 0x9000
    mov sp, bp


    call bios_setup_video_mode

    mov si, bootmsg_STACK
    call print_nl

    call bios_get_information
    call bios_setup_segments

    mov si, bootmsg_SEGMENT
    call print_nl

    call boot_load_kernel

    call switch_to_pm

    jmp $


boot_load_kernel:
    mov si, MSG_LOAD_KERNEL
    call print_nl

    mov bx, 0x1000
    mov dl, [BOOT_DISK]
    mov dh, 4                   ; 4*512 = 2048 bytes kernel
    call load_disk_sector
    ret


bios_setup_segments:
    xor ax, ax          ; ax = 0
    mov es, ax          ; es = ax = 0
    mov ds, ax          ; ds = ax = 0
    ret



switch_to_pm:
    cli                         ; disable interrupts
    lgdt [gdt_descriptor]       ; load gdt descriptor
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax
    jmp CODE_SEG:init_pm



%include "include/boot_disk.asm"
%include "include/boot_util.asm"
%include "include/boot_messages.asm"
%include "include/boot_gdt.asm"

[bits 32]
init_pm:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000            ; sets new stack to 0x90000
    mov esp, ebp
    
    jmp begin_pm

begin_pm:
    call 0x1000
    jmp $



BOOT_DISK: db 0
MSG_LOAD_KERNEL: db "[BOOT] Loading kernel...",0


times 510-($-$$) db 0
dw 0xAA55
; sector 1 ends here

