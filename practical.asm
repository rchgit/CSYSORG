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
quit
main endp
end main