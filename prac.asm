PRINT MACRO STRING, COORD, COLOR, LEN
	MOV AX,1301H	
	MOV BL, COLOR
	LEA BP, STRING
	mov cx,LEN
	mov dx,COORD
	INT 10H
	ENDM
QUIT MACRO
mov ah, 4ch
int 21h
ENDM
ONKEYPRESS MACRO
	mov ah,10h
	int 16h
	ENDM
FILL MACRO ROWS,COLS,ROWE,COLE,COLOR
	LOCAL START,AGAIN
	MOV DX,ROWS
START:	MOV CX,COLS
AGAIN:	MOV AH,0CH
	MOV AL,COLOR
	INT 10H
	INC CX
	CMP CX,COLE
	JNE AGAIN
	INC DX
	CMP DX,ROWE
	JNE START
	ENDM
;BLINK MACRO
;mov ax, 1003h
;int 10h
;endm

circle macro
mov ah, 4dh
int 10h
circle endm

.model small
.stack 100h
.data
dlsu db 'De La Salle University'
.code
main proc far
mov ax, @data
mov ds, ax
mov es, ax
print dlsu,0000h,7eh, 22
;blink
;circle
onkeypress
;draw_circle:
;mov di, 20
;fill 
quit
main endp
end main
