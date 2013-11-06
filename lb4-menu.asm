.model small
.stack 100h

.data
menutext db 'MENU'
choice1 db '1 - HORIZONTAL STRIPES'
choice2 db '2 - VERTICAL STRIPES'
choiceq db 'Q - QUIT'
entertext db 'ENTER CHOICE: '
press db 'Press any key to continue'

.code

main proc far
mov ax, @data
mov ds, ax
mov es, ax

;cursor loc set to 0,0
MOV AH,02		; SET CURSOR  OPTION
MOV BH,00		; PAGE 0
MOV DL,00H		; COLUMN POSITION
MOV DH,00H	; ROW POSITION
INT 10H

clear_screen:
MOV AH,06	; AH=06 scroll function
MOV AL,00	; AL=00 the entire page
MOV BH,07	; BH=07 for normal attribute
MOV CH,00	; CH=00 row value of start point
MOV CL,00	; CL=00 column value of start point
MOV DH,24	; DH=24 row value of end point
MOV DL,79	; DL=79 column value of end point
INT 10H	; invoke the interrupt

print proc
mov ah, 13h
mov al, 01
mov bh,0
mov bl, 1eh
lea bp, dx

empty:
; recolor to yellow on blue
mov ah, 09h
mov bh, 00h
mov al, ' '
mov bl, 1eh ; yellow on blue
mov cx, 800h
int 10h

; write menu options
mov ah, 13h
mov al, 01
mov bh,0
mov bl, 1eh ; yellow on blue print
lea bp, menutext
mov cx, 4
mov dx,0225h		;dh=screen row, dl=screen column
int 10h	

mov ah, 13h
mov al, 01
mov bh,0
mov bl, 1eh ; yelllow on blue print
lea bp, choice1
mov cx, 22
mov dx,031ch		;dh=screen row, dl=screen column
int 10h	

mov ah, 13h
mov al, 01
mov bh,0
mov bl, 1eh ; yelllow on blue print
lea bp, choice2
mov cx, 20
mov dx,041ch		;dh=screen row, dl=screen column
int 10h	

mov ah, 13h
mov al, 01
mov bh,0
mov bl, 1eh ; yelllow on blue print
lea bp, choiceq
mov cx, 8
mov dx,061ch		;dh=screen row, dl=screen column
int 10h

mov ah, 13h
mov al, 01
mov bh,0
mov bl, 1eh ; yelllow on blue print
lea bp, choiceq
mov cx, 8
mov dx,061ch		;dh=screen row, dl=screen column
int 10h

mov ah, 13h
mov al, 01
mov bh,0
mov bl, 1eh ; yelllow on blue print
lea bp, entertext
mov cx, 14 ; sttring length	
mov dx,081ch		;dh=screen row, dl=screen column
int 10h

MOV AH,02		; set the cursor position
MOV BH,00		; BH=00 page 0 (currently viewed page)
MOV DL,2ah		; col 
MOV DH,08h		; row
INT 10H		; invoke the interrupt

mov ah, 10h
int 16h
;cmp ah, 00h
;jne switch

switch:
cmp al, 31h ; if 1
je one
cmp al, 32h ; if 2
je two
cmp al, 71h ; if q
je quit
cmp al, 51h ; if Q
je quit
jne far ptr empty ; else

one:
MOV AH,02		; SET CURSOR  OPTION
MOV BH,00		; PAGE 0
MOV DL,00H		; COLUMN POSITION
MOV DH,00H	; ROW POSITION
INT 10H

mov ah, 09h
mov bh, 00h
mov al, ' '
mov bl, 07h ; white on black
mov cx, 1E0h
int 10h

MOV AH,02		; SET CURSOR  OPTION
MOV BH,00		; PAGE 0
MOV DL,00H		; COLUMN POSITION
MOV DH,06H	; ROW POSITION
INT 10H

mov ah, 09h
mov bh, 00h
mov al, ' '
mov bl, 57h ; white on magenta
mov cx, 1E0h
int 10h

MOV AH,02		; SET CURSOR  OPTION
MOV BH,00		; PAGE 0
MOV DL,00H		; COLUMN POSITION
MOV DH,0CH	; ROW POSITION
INT 10H

mov ah, 09h
mov bh, 00h
mov al, ' '
mov bl, 67h ; white on yellow
mov cx, 1E0h
int 10h

MOV AH,02		; SET CURSOR  OPTION
MOV BH,00		; PAGE 0
MOV DL,1AH		; COLUMN POSITION
MOV DH,15H	; ROW POSITION
INT 10H

;mov ah, 09h
;mov bh, 00h
;mov al, ' '
;mov bl, 00h ; yellow on blue
;mov cx, 210h
;int 10h

mov ah, 13h
mov al, 01
mov bh,0
mov bl, 1eh ; yelllow on blue print
lea bp, press
mov cx, 25
mov dx,151Ah		;dh=screen row, dl=screen column
int 10h	

mov ah, 10h
int 16h
jmp empty

two:
nop
jmp empty

quit:
mov ah,4ch
int 21h
main endp
end main


