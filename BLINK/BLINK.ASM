.MODEL SMALL
.STACK 100h
.DATA
.code
	main proc far
	mov ax, @data
	mov ds,ax
MOV AH,09
MOV BH,00
MOV AL,41h ; select ASCII character
MOV CX,200H
MOV BL,0F0H
INT 10H
mov ah,4ch
int 21h
main endp
end main