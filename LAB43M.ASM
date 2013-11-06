.model small
.stack
.data
kikay db 02
line1	db	"        &","$"
line2	db	"       &&&","$"
line3	db	"      &&&&&","$"
line4	db	"     &&&&&&&","$"
line5	db	"&&&&&&&&&&&&&&&&&","$"
line6	db	" &&&&&&&&&&&&&&&","$"
line7	db	"  &&&&&&&&&&&&&","$"
line8	db	"   &&&&&&&&&&&","$"
line9	db	"  &&&&&&&&&&&&&","$"
line10	db	" &&&&&&&&&&&&&&&","$"
line11	db	"&&&&&&&&&&&&&&&&&","$"
line12	db	"     &&&&&&&","$"
line13	db	"      &&&&&","$"
line14	db	"       &&&","$"
line15	db	"        &","$"

message1 db 'THE STAR$'
msgstart db 'Enter desired character$'
.code
main proc far
	mov ax, @data
	mov ds, ax
	mov es, ax

mov ah,00h		;set video mode
mov al,02h
int 10h

; prompt for desired character
mov ah,13h		;Request display string
mov al,01
mov bh,0
mov bl,kikay		;screen attribute
lea bp,msgstart	;address of string in ES:BP
mov ah,10h
int 16h

; clear screen
MOV AL,03H
MOV AH,00H
INT 10H

mov ah,13h		;Request display string
mov al,01
mov bh,0
mov bl,kikay		;screen attribute
lea bp,message1	;address of string in ES:BP
mov cx,8		;length of string
mov dx,020eh		;dh=screen row, dl=screen column
int 10h			;call interrupt service

start: ; begin star printing sequence
mov ah,13h
mov al,01
mov bh,0
mov bl,kikay
lea bp,line1		;line1
mov cx,9
mov dx,050ah
int 10h

lea bp,line2		;line2
mov cx,10
mov dx,060ah
int 10h

lea bp,line3		;line3
mov cx,11
mov dx,070ah
int 10h

lea bp,line4		;line4
mov cx,12
mov dx,080ah
int 10h

lea bp,line5		;line5
mov cx,17
mov dx,090ah
int 10h

lea bp,line6		;line6
mov cx,16
mov dx,0a0ah
int 10h

lea bp,line7		;line7
mov cx,15
mov dx,0b0ah
int 10h

lea bp,line8		;line8
mov cx,14
mov dx,0c0ah
int 10h

lea bp,line9		;line9
mov cx,15
mov dx,0d0ah
int 10h

lea bp,line10		;line10
mov cx,16
mov dx,0e0ah
int 10h

lea bp,line11		;line11
mov cx,17
mov dx,0f0ah
int 10h

lea bp,line12		;line12
mov cx,12
mov dx,100ah
int 10h

lea bp,line13		;line13
mov cx,11
mov dx,110ah
int 10h

lea bp,line14		;line14
mov cx,10
mov dx,120ah
int 10h

lea bp,line15		;line15
mov cx,9
mov dx,130ah
int 10h

mov ah,10h
int 16h
; switch statement
cmp al,0dh ; check if "Enter" key is pressed
je change
cmp al,1bh ; check if "Esc" key is pressed
je quit
mov bl,03h ; else
mov kikay,bl ; print again
jmp start 
change:
mov bl,8eh ; blinking
mov kikay, bl
jmp start
quit:
mov ah,4ch
int 21h
main endp
end main 

scrollup:
mov ah, 06h
mov al,01h
mov bh, kikay
mov ch,00h
mov cl,00h
mov dh,ewan
mov dl,ewankorin
int 10h

scrolldown:
mov ah, 07h
mov al,01h
mov bh, kikay
mov ch,00h
mov cl,00h
mov dh,ewan
mov dl,ewankorin
int 10h
