.MODEL SMALL
.STACK 100h
.DATA
.code
	main proc far
	mov ax, @data
	mov ds,ax
	
MOV AH,02	; AH=02 set the cursor position
MOV BH,00	; BH=00 page 0 (currently viewed page)
MOV DL,25	; DL=25 row position 
MOV DH,15	; DH=15 column position
INT 10H	; invoke the interrupt
main endp
end main
