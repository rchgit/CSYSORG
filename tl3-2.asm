.model small
.DATA

IN DB 25H, 12H, 15H, 1FH, 2BH
SUM DB 00H

.CODE

MAIN MOV AX, @DATA
	MOV DS,X
	MOV CX,05
	MOV BX,OFFSET IN
	MOV AL,0
AGAIN ADD AL,[BX]
	INC BX
	DEC CX
	JNZ AGAIN
	MOV SUM,AL
	END MAIN
	