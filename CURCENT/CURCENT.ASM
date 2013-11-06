.MODEL SMALL
.STACK 64
.DATA
.code
	main proc far
	mov ax, @data
	mov ds,ax
	
; clearing

MOV AX,06h		; AH=06 scroll function
MOV BH,00h		; BH=00 page 0 (currently viewed page)
MOV CX,0000h	; row,col top left 
MOV DX,184Fh	; DH=15 column position
INT 10H		; invoke the interrupt

; setting the cursor to the center of the screen

MOV AH,02h		; set the cursor position
MOV BH,00h		; BH=00 page 0 (currently viewed page)
MOV DL,39h		; center col 
MOV DH,12h		; center row
INT 10H		; invoke the interrupt
mov ax, 4c00h
int 21h

main endp
end main
