CLRSCR 	MACRO	
		MOV AX,0600H
		MOV BH,07H
		MOV CX,00		;FROM ROW=00H COL=00H
		MOV DX,184FH	;TO ROW=18H COL=4FH
		INT 10H
		ENDM
PRINT MACRO STRING, COORD, COLOR, LEN
	MOV AX,1301H	
	MOV BL, COLOR
	LEA BP, STRING
	mov cx,LEN
	mov dx,COORD
	INT 10H
	ENDM
DISPMOUSE MACRO
	MOV AX, 1H
	INT 33H
	ENDM
ONMOUSE_RELEASE MACRO
	MOV AX, 6H
	MOV BX, 0
	INT 33H
	ENDM
ONKEYPRESS MACRO
	mov ah,10h
	int 16h
	ENDM
SETTEXTCURPOS MACRO ROW,COL
	mov ax,0002h
	MOV DH, ROW
	MOV DL, COL
	int 10h
	ENDM
.model small
.stack
.data
mess1	db	"MENU"
mess2	db	"1 - HORIZONTAL STRIPES"
mess3	db	"2 - VERTICAL STRIPES"
mess4	db	"Q - QUIT"
mess5	db	"ENTER CHOICE: "
mess6  db    "Press any key to continue"
tempvar1 db ?
tempvar2 db ?
.code
main proc far
mov ax,@data
mov ds,ax
mov es,ax
;set video mode
mov ah, 00h
mov al, 12h
int 10h

init:
MOV AX,0003H				
INT 10H
MOV AX,0920H		
MOV BX, 0010H		 		 
MOV CX,2000		 		 
INT 10H
jmp init_mouse
st1 proc
MOV AX,0003H				
INT 10H
MOV AX,0920H		
MOV BX, 0010H		 		 
MOV CX,2000		 		 
INT 10H

print mess1, 0627h, 001EH, 4
print mess2, 081dh,001eh,22
print mess3, 091Dh,001eh,20
print mess4, 0B25h, 001EH, 8
print mess5, 0D23h, 001EH, 12
init_mouse:
MOV AX,0000H	;INITIALIZE MOUSE
INT 33H
MOV AX,01H	;SHOW MOUSE CURSOR
INT 33H
st1 endp
jmp start

callc1: 
call c1
jmp init

callc2: 
call c2
jmp init

bye: call quit
;DISPMOUSE	
start:
;call keypress
call mouse_release

;keypress proc
;ONKEYPRESS
;cmp al,31h
;je callc1
;cmp al, 32h
;je callc2
;cmp al, 71h
;je bye
;ret
;keypress endp

mouse_release proc
mouse_begin:
call st1
ONMOUSE_RELEASE
; start of decision loop
;mov tempvar1, dl
;mov tempvar2, dh
and ax, 1h
cmp ax, 1h
jne start
cmp cx, 0
;mov ax, cx
;mov bl, 08h
;div bl
;cmp al, 08h
jne choice2
;mov ax, dx
;div bl
cmp dx, 0
jne choice2
call c1
jmp mouse_begin
choice2:
mov ax, cx
mov bl, 09h
div bl
cmp al, 08h
jne choiceq
mov ax, dx
div bl
cmp al, 1dh
je c2
jne choiceq

choiceq:
;mov ax, cx
;mov bl, h
;div bl
;cmp al, 08h
cmp cx, 0Bh
jne start
mov ax, dx
div bl
cmp al, 25h
call quit
jne start
ret
; end of decision loop
mouse_release endp

c1 proc
	mov ah, 0fh
	int 10h
	mov ah, 00h
	mov al, 12h
	int 10h
	mov cx, 0
	mov dx, 120
	mov ax, 0c05h
	
	lab:	int 10h
	inc cx
	cmp cx, 640
	jb lab 
	mov cx, 0
	inc dx
	cmp dx, 240
	jb lab
	mov ax, 0c0Eh
	mov cx, 0
	cmp dx, 360
	jb lab
	mov ax, 0c01h
	mov cx, 0
	cmp dx, 480
	jb lab
	print mess6, 151Ah, 001EH, 25
	MOV AX,01H	;SHOW MOUSE CURSOR
	INT 33H
	ONMOUSE_RELEASE
	ret
c1 endp

c2 proc
	mov ah, 0fh
	int 10h
	mov ax, 0012h
	int 10h
	mov cx, 160
	mov dx, 0
	mov ax, 0c05h
	lab1:	int 10h
	inc dx
	cmp dx, 480
	jb lab1
	mov dx, 0
	inc cx
	cmp cx, 320
	jb lab1
	mov ax, 0c0Eh
	mov dx, 0
	cmp cx, 480
	jb lab1
	mov ax, 0c01h
	mov dx, 0
	cmp cx, 640
	jb lab1
	print mess6, 151Ah, 001EH, 25
	ONKEYPRESS
	call st1
	ret
c2 endp


quit proc
CLRSCR
mov ah, 4ch
int 21h
quit endp

main endp
end main

