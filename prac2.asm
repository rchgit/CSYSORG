
exit macro
mov ah, 4ch
int 21h
endm
drawline macro row,cols,cole,color
	mov cx,cols	;start col
	mov dx,row	;row
	mov ah,0ch
	mov al, color
again:	int 10h
	inc cx
	cmp cx,cole	;check column if=470
	jb again	
endm

ONKEYPRESS MACRO
	mov ah,10h
	int 16h
	ENDM
.model small
.stack 100h
.code
main proc far
mov ah,00h	;set video mode
mov al,07h	;graphics 640x480
int 10h
;drawline 210,320,320,01h
;drawline 220,310,330,01h
;line 230,320,320,01h
mov ah, 4dh
int 10h
;mov al, 81h
;call circle1;
;mov al,85h
;call circle2
;mov al, 86h
;call circle3
jmp ending
circle1 proc
mov cx,320
mov dx,210
int 10h
mov cx,312
mov dx,215
int 10h
mov cx,328
mov dx,215
int 10h
mov cx,312
mov dx,225
int 10h
mov cx,328
mov dx,225
int 10h
mov cx,320
mov dx,230
int 10h
ret
circle1 endp
circle2 proc
mov cx,320
mov dx,230
int 10h
mov cx,312
mov dx,235
int 10h
mov cx,328
mov dx,235
int 10h
mov cx,312
mov dx,245
int 10h
mov cx,328
mov dx,245
int 10h
mov cx,320
mov dx,250
int 10h
ret
circle2 endp
circle3 proc
mov cx,320
mov dx,250
int 10h
mov cx,312
mov dx,255
int 10h
mov cx,328
mov dx,255
int 10h
mov cx,312
mov dx,265
int 10h
mov cx,328
mov dx,265
int 10h
mov cx,320
mov dx,270
int 10h
ret
circle3 endp
ending:
onkeypress
exit
main endp
end main