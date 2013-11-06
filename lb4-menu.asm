.model small
.stack 100h

.data
menutext db 'MENU'
choice1 db '1 - HORIZONTAL STRIPES'
choice2 db '2 - VERTICAL STRIPES'
choiceq db 'Q - QUIT'
entertext db 'ENTER CHOICE: '

.code

main proc far
mov ax, @data
mov ds, ax
mov es, ax


; set video mode
;mov ah, 00h
;mov al, 0eh
;int 10h

;clear screen


; cursor loc set to 0,0
;MOV AH,02		; SET CURSOR  OPTION
;MOV BH,00		; PAGE 0
;MOV DL,00H		; COLUMN POSITION
;MOV DH,00H	; ROW POSITION
;INT 10H

MOV AH,06	; AH=06 scroll function
MOV AL,00	; AL=00 the entire page
MOV BH,07	; BH=07 for normal attribute
MOV CH,00	; CH=00 row value of start point
MOV CL,00	; CL=00 column value of start point
MOV DH,24	; DH=24 row value of end point
MOV DL,79	; DL=79 column value of end point
INT 10H	; invoke the interrupt


; recolor to yellow on blue
mov ah, 09h
mov bh, 00h
mov al, ' '
mov bl, 1eh ; yellow on blue
mov cx, 800h
int 10h

; clear screen
;MOV AH, 06H
;MOV AL, 00H
;MOV BH, 00H
;MOV CH, 00H
;MOV CL, 00H
;MOV DH, 00
;MOV DL, 200
;INT 10H



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

;MOV AH,02		; SET CURSOR  OPTION
;MOV BH,00		; PAGE 0
;MOV DL,2AH		; COLUMN POSITION
;MOV DH,08H	; ROW POSITION
;INT 10H
MOV AH,02		; set the cursor position
MOV BH,00		; BH=00 page 0 (currently viewed page)
MOV DL,39h		; center col 
MOV DH,12h		; center row
INT 10H		; invoke the interrupt

empty:
mov ah, 10h
int 16h
cmp ah, 00h
je empty

quit:
;mov ah,4ch
;int 21h
main endp
end main


