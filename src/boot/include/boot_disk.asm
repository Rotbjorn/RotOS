[bits 16]

;   Loads disk sector
;
;   dh = amount of sectors to read
;   dl = drive to read from
;   es:bx = where to mount read bytes
;
load_disk_sector:
    pusha

    push dx                     ; push 'dx' to compare to 'al' after disk read

    mov ah, 2                   ; INT 13H: read
    mov al, dh                  ; read 'dh' sectors
    mov ch, 0                   ; which cylinder to read from
    mov cl, 2                   ; start reading from sector 2 (offset: 0x0200)
    mov dh, 0                   ; which head to read from

    int 0x13

    pop dx
    cmp al, dh                  ; if al =/= dh, then we read the wrong amount of sectors

    popa
    ret


