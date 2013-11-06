.MODEL SMALL
.STACK 100h
.DATA
.code
	main proc far
	mov ax, @data
	mov ds,ax
	MOV AH,06	; AH=06 scroll function
MOV AL,00	; AL=00 the entire page
MOV BH,07	; BH=07 for normal attribute
MOV CH,00	; CH=00 row value of start point
MOV CL,00	; CL=00 column value of start point
MOV DH,24	; DH=24 row value of end point
MOV DL,79	; DL=79 column value of end point
INT 10H	; invoke the interrupt
main endp
end main