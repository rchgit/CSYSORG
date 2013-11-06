.model small
.stack 100h

.data

.code
 MAIN      	PROC  	FAR
             	MOV  	AX,@DATA
             	MOV  	DS,AX

				MOV AX,0600		; AH=06 scroll function
				MOV BH,00		; BH=00 page 0 (currently viewed page)
				MOV CX,0000h	; row,col top left 
				MOV DX,184Fh	; DH=15 column position
				INT 10H		; invoke the interrupt

				; setting the cursor to the center of the screen

				MOV AH,02		; set the cursor position
				MOV BH,00		; BH=00 page 0 (currently viewed page)
				MOV DL,39h		; center col 
				MOV DH,12h		; center row
				INT 10H		; invoke the interrupt
				
				
	MAIN      	ENDP
                END     MAIN
