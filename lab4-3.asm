.model small
.stack 100h

.data

.code

MAIN      	PROC  	FAR
MOV AX,0600H
MOV BH,00
MOV CX,0000H
MOV DX, 0FFFH
INT 10H


MAIN      	ENDP
                END     MAIN