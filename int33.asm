TITLE	MOUSE(EXE) PROGRAMMING
PAGE 60,132

;DISPLAY STRING MACRO---------------------------------------
DISPLAYS MACRO STRING
	MOV AH,09H
	MOV DX,OFFSET STRING
	INT 21H
	ENDM
;-----------------------------------------------------------

;CURSOR MACRO ROW,COL---------------------------------------
CURSOR MACRO ROW,COL
	MOV AH,02H
	MOV BH,00H
	MOV DH,ROW
	MOV DL,COL
	INT 10H
	ENDM
;-----------------------------------------------------------

.MODEL SMALL
.STACK 64
.DATA
	MESSAGE1	DB	'PRESS ANY KEY TO GET OUT','$'
	MESSAGE2	DB	'THE MOUSE CURSOR IS LOCATED AT: ','$'
	POSHO		DB	?,?,' AND ','$'
	POSVE		DB	?,?,'$'	
	OLDVID		DB	?
	NEWVID		DB	0EH

.CODE
MAIN PROC FAR
	MOV AX,@DATA
	MOV DS,AX

	MOV AH,0FH	;CURRENT VIDEO MODE
	INT 10H

	MOV OLDVID,AL	;SAVE IT

	MOV AX,0600H	;CLEAR SCREEN
	MOV BH,07H
	MOV CX,0000H
	MOV DX,184FH
	INT 10H

	MOV AH,00H	;SET NEW VIDEO MODE
	MOV AL,NEWVID
	INT 10H

	MOV AX,0	;INITIALIZE MOUSE
	INT 33H

	MOV AX,01H	;SHOW MOUSE CURSOR
	INT 33H

	CURSOR 20,20
	DISPLAYS MESSAGE1

AGAIN:	MOV AX,03H	;GET MOUSE LOCATION
	INT 33H

	MOV AX,CX	;GET HOR PIXEL LOCATION
	CALL CONVERT	;CONVERT TO DISPLAYABLE DATA
	MOV POSHO,AL
	MOV POSHO+1,AH

	MOV AX,DX	;GET VER PIXEL  LOCATION
	CALL CONVERT
	MOV POSVE,AL
	MOV POSVE+1,AH

	CURSOR 2,20
	DISPLAYS MESSAGE2
	DISPLAYS POSHO
	DISPLAYS POSVE

	MOV AH,01H	;CHECK FOR KEYPRESS
	INT 16H
	JZ AGAIN	;IF NO KEYPRESS KEEP MONITOR MOUSE POSITION
	
	MOV AH,02H	;HIDE MOUSE
	INT 33H

	MOV AH,0	;RESTORE ORIGINAL VIDEO
	MOV AL,OLDVID	
	INT 10H

	MOV AH,4CH
	INT 21H
MAIN ENDP

CONVERT PROC NEAR
	SHR AX,1	;DIVIDE
	SHR AX,1	;BY 8
	SHR AX,1	;TO GET SCREEN POSITION BY CHARACTER
	MOV BL,10H
	SUB AH,AH
	DIV BL		;DIVIDE BY 10 TO CONVERT FROM HEX TO DEC
	OR AX,3030H	;MAKE IT ASCII
	RET
CONVERT ENDP
	END MAIN