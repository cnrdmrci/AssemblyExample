; multi-segment executable file template.

data segment
; add your data here!
pkey db "press any key...$"
dizi db 5,8,9,1,4,3,2,7,5,4
enb db "En buyuk sayi : $"
enk db "En kucuk sayi : $"
ort db "Ortalama : $"
kucbuy db "Kucukten buyuge : $"
tersten db "Tersten : $"
orjinal db "Orjinal dizi : $"


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
call orjiy

mov ah,02h
mov bh,00h
mov dh,01h
mov dl,00h
int 10h

call enbuyuk

mov ah,02h
mov bh,00h
mov dh,02h
mov dl,00h
int 10h

call enkucuk

mov ah,02h
mov bh,00h
mov dh,03h
mov dl,00h
int 10h

call ortalama

mov ah,02h
mov bh,00h
mov dh,04h
mov dl,00h
int 10h

call kubu

mov ah,02h
mov bh,00h
mov dh,05h
mov dl,00h
int 10h

call tekcift

mov ah,02h
mov bh,00h
mov dh,06h
mov dl,00h
int 10h

call ters

mov ah,4Ch
int 21h

orjiy proc
mov ah,09h
lea dx,orjinal
int 21h

mov cx,10
mov bx,00
yazdir3:
mov ah,02h
mov dl,[dizi+bx]
add dl,30h
int 21h
inc bx

cmp cx,01h
je atla124
mov ah,02h
mov dl,','
int 21h
atla124:
loop yazdir3


ret
endp

ters proc

mov ah,09h
lea dx,tersten
int 21h

mov cx,10
mov bx,00
stat:
mov dx,00
mov dl,[dizi+bx]
push dx
inc bx
loop stat


mov cx,10
mov bx,00
terse:
mov dx,00
pop dx
mov [dizi+bx],dl
inc bx
loop terse

mov cx,10
mov bx,00
yazdir2:
mov ah,02h
mov dl,[dizi+bx]
add dl,30h
int 21h
inc bx

cmp cx,01h
je atla123
mov ah,02h
mov dl,','
int 21h
atla123:
loop yazdir2


ret
endp



tekcift proc


mov cx,10
mov bx,00
mov ax,00
bul:
mov dl,[dizi+bx]
jmp tcbul
bit:
inc bx

loop bul
jmp bitt

tcbul:

cmp dl,02h
je cft
cmp dl,01h
je tk
cmp dl,00h
je cft

sub dl,02h
jmp tcbul


cft:
add al,1
jmp bit

tk:
add ah,1
jmp bit

bitt:
mov cl,al
mov ch,ah

mov ah,02h
mov dl,'T'
int 21h

mov ah,02h
mov dl,':'
int 21h

mov ah,02h
mov dl,ch
add dl,30h
int 21h

mov ah,02h
mov dl,' '
int 21h

mov ah,02h
mov dl,'C'
int 21h

mov ah,02h
mov dl,':'
int 21h

mov ah,02h
mov dl,cl
add dl,30h
int 21h

ret
endp



kubu proc
mov ah,09h
lea dx,kucbuy
int 21h

mov cx,9
don1:
push cx
mov cx,9
mov bx,0
don2:
mov al,[dizi+bx]
mov dl,[dizi+bx+01h]
cmp al,dl
jb atla3
mov [dizi+bx],dl
mov [dizi+bx+01h],al
atla3:
inc bx
loop don2
pop cx
loop don1

mov bx,00h
mov cx,10
yazdir:

mov ah,02h
mov dl,[dizi+bx]
add dl,30h
int 21h
inc bx

cmp cx,01h
je gec
mov ah,02h
mov dl,','
int 21h
gec:
loop yazdir




ret
endp



ortalama proc
mov ah,09h
lea dx,ort
int 21h

mov cx,10
mov bx,0
mov ax,0
dongu3:
add al,[dizi+bx]
inc bx
loop dongu3
mov cl,10
div cl

mov ah,02h
mov dl,al
add dl,30h
int 21h


ret
endp


enkucuk proc
mov ah,09h
lea dx,enb
int 21h

mov cx,09
mov bx,00h
mov al,[dizi+bx]
dongu2:
inc bx
cmp al,[dizi+bx]
jb atla2
mov al,[dizi+bx]

atla2:
loop dongu2

mov ah,02h
mov dl,al
add dl,30h
int 21h

ret
endp

enbuyuk proc
mov ah,09h
lea dx,enb
int 21h

mov cx,09
mov bx,00h
mov al,[dizi+bx]
dongu:
inc bx
cmp al,[dizi+bx]
ja atla
mov al,[dizi+bx]

atla:
loop dongu

mov ah,02h
mov dl,al
add dl,30h
int 21h

ret
endp



ends

end start ; set entry point and stop the assembler.

