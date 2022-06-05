; each segment descriptor is 8 bytes long

gdt_start:
    gdt_null_segment:            ; GDT requires one null descriptor (all zeroes) as the first segment descriptor
        dd 0x0
        dd 0x0

    gdt_code_segment:           ; base = 0, limit = 0xFFFFF
        dw 0xFFFF               ; limit
        dw 0x0                  ; base
        db 0x0                  ; base
        db 0b10011010           ; flags, describes it as code segment
        db 0b11001111
        db 0x0

    gdt_data_segment:
        dw 0xFFFF               ; limit
        dw 0x0                  ; base
        db 0x0                  ; base
        db 0b10010010           ; flags, describes it as code segment
        db 0b11001111
        db 0x0                  ; base

gdt_end:


gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start


CODE_SEG equ gdt_code_segment - gdt_start
DATA_SEG equ gdt_data_segment - gdt_start
