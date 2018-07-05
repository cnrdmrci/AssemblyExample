; multi-segment executable file template.

data segment
; add your data here!
pkey db "press any key...$"
kelime db "selam"
kelime2 db 6,?,6 dup(0)
yanlis db "sifre yanlis$"
dogru db "sifre dogru$"
ends

stack segment
dw   128  dup(0)
ends

code segment
start:
; set segment registers:
mov ax, data
mov ds, ax
mov es, ax

; add your code here

lea dx,kelime2
mov ah,0Ah
int 21h

mov ah,02h
mov bh,00h
mov dl,00h
mov dh,02h
int 10h


lea si,[kelime]
lea di,[kelime2+02h]

mov cx,5

cld

repe cmpsb

jnz hata

cmp cx,00h
jnz hata

lea dx,dogru
mov ah,09h
int 21h

jmp bitir

hata:
lea dx,yanlis
mov ah,09h
int 21h

bitir:


ends

end start ; set entry point and stop the assembler.


