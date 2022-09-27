[org 0x7c00] 

GDT_Start:
null_descriptor:
dd 0
dd 0
code_descriptor:
dw 0xffff
dw 0
dw 0
db 10011010

db 11001111

db 0

data_descriptor:
dw 0xffff
dw 0
dw 0
db 10010010

db 11001111

db 0
GDT_end:

GDT_Descriptor:
dw GDT_end - GDT_Start - 1
dd GDT_Start

CODE_SEG equ code_descriptor - GDT_Start
DATA_SEG equ data_descriptor - GDT_Start

cli
lgdt [GDT_Descriptor]
mov eax, cr0
or eax, 1
mov cr0, eax

jmp CODE_SEG:stpm
[bits 32]
stpm:

mov al, 'q'
mov ah, 0x0f
mov [0xb8000], ax

times 510-($-$$) db 0              
db 0x55, 0xaa