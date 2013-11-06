.model small
.stack 100h
.code

main proc far
mov ax,@data
mov ah,0fh
int 10h
push ax
mov ah, 00h
mov al,12h
int 10h
call greenline
mov ah, 07h
int 21h
pop ax
mov ah, 00h
int 10h
main endp

greenline
pop 