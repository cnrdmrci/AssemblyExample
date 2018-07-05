; multi-segment executable file template.

data segment
; add your data here!
pkey db "Karabuk/Universitesi/Bilgisayar/Muh./Bolumu$"

kelime db 40,?,40 DUP(0)
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

mov ah,0Ah
lea dx,kelime
int 21h

mov ah,02h
mov bh,00h
mov dl,00h
mov dh,02h
int 10h

mov bx,0
mov bl,[kelime+01h]
mov al,'$'
mov [kelime+bx+02h],al

mov bx,00h
dongu:
mov al,[kelime+bx]
cmp al,'a'
je esit
jmp atla

esit:
mov ah,'*'
mov [kelime+bx],ah
atla:
inc bx
mov dl,'$'
cmp dl,[kelime+bx]
jne dongu

lea dx,[kelime+02h]
mov ah,09h
int 21h



ends

end start ; set entry point and stop the assembler.


