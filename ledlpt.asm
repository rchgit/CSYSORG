.model small
.stack 100h
.data
msg db 13,10,'Press r for right movement',13,10,'Press l for left movement',13,10, 'Press 0 to Off',13,10, 'Press Esc to exit','$'
.code
main proc
mov ax,@data
mov ds,ax
mov ah,09h
lea dx,msg
int 21h
set: mov al, 0ffh
mov dx, 378h
out dx,al
call delay
call delay
call delay
mov al,00h
out dx,al
call delay
call delay
call delay
mov al,10000000b
lop1:
push ax
push dx
mov ah,06h
mov dl,0ffh
int 21h
cmp al,27
je exit
cmp al,'0'
je off
cmp al,'r'
je loop2
pop dx
pop ax
ror al,1
ror al,1
out dx,al
call delay
call delay
jmp lop1
loop2:
mov dx,378h
mov al,01h
strt: out dx,al
call delay
call delay
rol al,1
rol al,1
push ax
push dx
mov ah,06h
mov dl,0ffh
int 21h
cmp al,27
je exit
cmp al,'0'
je off
cmp al,'l'
je set
pop dx
pop ax
jmp strt
off: mov al, 0h
mov dx, 378h
out dx, al
exit: mov ax, 4c00h
int 21h
main endp
delay proc
push ax
push dx
mov bx,00h
mov ah,2ch ;To Get System Time
int 21h
mov bh,dl ;Copy seconds into bh reg
getsec: mov ah,2ch
int 21h
cmp bh,dl
jne back ;Jump to back when get 1 sec.
jmp getsec
back: pop dx
pop ax
ret
delay endp
end main