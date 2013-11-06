.model small
.stack 100H
.data
	num db 15h, 25h, 32h, 45h, 03h
	pos dw ?
.code
	main proc far
	mov ax, @data
	mov ds, ax
	
	mov ah,0fh
	int 10h
	push ax
	
	mov ah,00h
	mov al,12h
	int 10h
	call greenline
	call greenline2
	mov ah,07h
	int 21h
	
	pop ax
	mov ah,00h
	int 10h
	
	; exit
	mov ax, 4c00h
	int 21h
main endp
greenline proc near
loop1:
	mov cx,0 ;column/x
	mov dx,100 ;row/y
	mov ax,0c02h

lab: 	int 10h
	inc cx
	;inc dx
	cmp cx,640
	jb lab
	;cmp dx,200
	;jb lab
	ret
greenline endp

greenline2 proc near
	mov cx,100 ;column/x
	mov dx,0 ;row/y
	mov ax,0c02h
lab2: 	int 10h
	inc dx
	;inc dx
	cmp dx,480
	jb lab2
	ret
greenline2 endp

;int10func0c proc near
	;mov ah,0ch
	;mov al,02h
	;mov bh,00h
	;mov cx,320
	;mov dx,240
	;int 10h
	;ret

end main
