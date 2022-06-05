[bits 16]


print_nl:
    mov ah, 0x0E    ; ah = 0x0E, teletype mode for INT 10h
    mov bl, 0x0D
.loop:
    lodsb           ; loads ds:si into al, si++
    or al, al       ; if or al, al and al = 0, zero flag is set
    jz .end         ; skip to end if zero flag is set
    int 0x10        ; write character
    jmp .loop
 .end:
    mov al, 13
    int 0x10
    mov al, 10
    int 0x10
    ret


bios_get_information:
    mov [BOOT_DISK], dl 
    ret

bios_setup_video_mode:
    mov ah, 0
    mov al, 0x03
    int 0x10
    ret
