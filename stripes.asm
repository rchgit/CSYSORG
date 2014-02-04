.model small
.stack
.data
mess1	db	"MENU"
mess2	db	"1 - HORIZONTAL STRIPES"
mess3	db	"2 - VERTICAL STRIPES"
mess4	db	"Q - QUIT"
mess5	db	"ENTER CHOICE: "
mess6  db    "Press any key to continue"
.code
main proc far
mov ax,@data
mov ds,ax
mov es,ax

mov ax,0002h
int 10h

MOV AX,0003H				
INT 10H
MOV AX,0920H		
MOV BX, 0010H		 		 
MOV CX,2000		 		 
INT 10H

st1:
MOV AX,0003H				
INT 10H
MOV AX,0920H		
MOV BX, 0010H		 		 
MOV CX,2000		 		 
INT 10H

mov ax,1300h
mov bx,001EH
lea bp,mess1
mov cx,4
mov dx,0627h
int 10h

mov ax,1301h
mov bx,001EH
lea bp,mess2
mov cx,22
mov dx,081Dh
int 10h

mov ax,1301h
mov bx,001EH
lea bp,mess3
mov cx,20
mov dx,091Dh
int 10h

mov ax,1301h
mov bx,001EH
lea bp,mess4
mov cx,8
mov dx,0B25h
int 10h

mov ax,1301h
mov bx,001EH
lea bp,mess5
mov cx,12
mov dx,0D23h
int 10h
jmp start

start:
mov ah,10h
int 16h
cmp al,31h
je c1
cmp al, 32h
je c2
cmp al, 71h
je quit
jb st1
	
quit:
	mov ax, 0600h
	mov bh, 00h
	mov cx, 0000h
	mov dx, 184fh
	int 10h
	mov ah, 4ch
	int 21h
	
c1:

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
	
	mov ah, 13h
mov al, 01
mov bh,0
mov bl, 1eh ; yelllow on blue print
lea bp, mess6
mov cx, 25
mov dx,151Ah		;dh=screen row, dl=screen column
int 10h
	mov ah,10h
	int 16h
	jmp st1 	
	
	


c2:
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
	
	mov ah, 13h
mov al, 01
mov bh,0
mov bl, 1eh ; yelllow on blue print
lea bp, mess6
mov cx, 25
mov dx,151Ah		;dh=screen row, dl=screen column
int 10h
	
	mov ah,10h
	int 16h
	jmp st1 	

main endp
end main
