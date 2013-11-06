.model small
.stack 100h

.data

.code

MAIN      	PROC  	FAR

MOV AL,03H
MOV AH,00H
INT 10H

MAIN      	ENDP
                END     MAIN