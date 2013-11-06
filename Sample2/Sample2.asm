.model small
.stack 100h
.data
	hello db 10,13,10,13,'    - - - - - - -This is Sample 2- - - - - - -',10,13,36
.code
start:	push dx
	mov ax,0
	push ax
	mov ax,@data
	mov ds,ax

	mov ah,09h
	mov dx,offset hello
	int 21h

	mov ah,4ch
	int 21h
end start
