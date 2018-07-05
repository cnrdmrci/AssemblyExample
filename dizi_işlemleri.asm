; multi-segment executable file template.

data segment
; add your data here!
pkey db "press any key...$"

dizi db 9,5,3,2,8,6

buyukdeger db "buyuk deger : $"
kucukdeger db "kucuk deger : $"
toplamdeger db "toplam deger : $"
ortalamadeger db "ortalama deger : $"
kucukten db "kucukten buyuge siralanmis hali : $"
sonuc db ?
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


call kucukbul

mov ah,02h
mov bh,00h
mov dl,00h ;sutun numarasi
mov dh,01h ;satir numarasi
int 10h

call buyukbul

mov ah,02h
mov bh,00h
mov dl,00h ;sutun numarasi
mov dh,02h ;satir numarasi
int 10h

call toplamhesap

mov ah,02h
mov bh,00h
mov dl,00h ;sutun numarasi
mov dh,03h ;satir numarasi
int 10h

call ortalama

mov ah,02h
mov bh,00h
mov dl,00h ;sutun numarasi
mov dh,04h ;satir numarasi
int 10h

call kucuktenbuyuge


mov ah,4Ch     ;cikis(exit)
int 21h

;kucukten buyuge
kucuktenbuyuge proc
lea dx,kucukten
mov ah,09h
int 21h

mov cx,5h
bak1:
push cx
mov cx,5h
mov bx,0000h
bak2:
mov dl,[dizi+bx]
mov al,[dizi+bx+01h]

cmp dl,al
jb degil
mov [dizi+bx],al
mov [dizi+bx+01h],dl
degil:

inc bx
loop bak2
pop cx
loop bak1

mov cx,6h
mov bx,0h
yazdir:
mov dl,[dizi+bx]
add dl,30h
mov ah,02
int 21h
inc bx
loop yazdir


ret
endp

;sayilarin ortalamasi
ortalama proc
lea dx,ortalamadeger
mov ah,09h
int 21h

mov cx,6h
mov bx,0h
mov ax,0h
dongu4:
add al,[dizi+bx]
inc bx
loop dongu4

mov dl,6h
div dl

mov dl,al
add dl,30h
mov ah,02h
int 21h

ret
endp


;toplam hesaplama
toplamhesap proc
lea dx,toplamdeger
mov ah,09h
int 21h

mov cx,6h
mov bx,0h
mov ax,0h
dongu3:
mov al,[dizi+bx]
add ah,al
inc bx
loop dongu3

mov bl,ah
mov ax,0h
mov al,bl
mov dl,10
div dl
mov cl,ah
mov dl,al

add dl,30h
mov ah,02h
int 21h

mov dl,cl
add dl,30h
mov ah,02h
int 21h

ret
endp



;buyuk proseduru
buyukbul proc
mov al,[dizi]
mov bx,0
mov cx,5
dongu:
inc bx
mov ah,[dizi+bx]
cmp al,ah
jb buyuk
jmp atla
buyuk:
mov al,ah
atla:
loop dongu
mov cl,al

lea dx,buyukdeger
mov ah,09h
int 21h

add cl,30h
lea dl,cl
mov ah,02h
int 21h

ret
endp

;kucuk proseduru
kucukbul proc
mov al,[dizi]
mov bx,0
mov cx,5
dongu2:
inc bx
mov ah,[dizi+bx]
cmp al,ah
ja kucuk
jmp atla2
kucuk:
mov al,ah
atla2:
loop dongu2
mov cl,al

lea dx,kucukdeger
mov ah,09h
int 21h

add cl,30h
lea dl,cl
mov ah,02h
int 21h

ret
endp

ends

end start ; set entry point and stop the assembler.


