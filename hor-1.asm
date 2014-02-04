title hor (exe) draw horizontal line
.model small
.stack 100
.code
main proc far
	mov ax,@data
	mov ds,ax

	mov ah,0fh	;get current video mode
	int 10h
	push ax		;save current video mode

	mov ah,00h	;set video mode
	mov al,12h	;graphics 640x480
	int 10h

	

	call greenline	

	mov ah,07h	;wait for key press
	int 21h

	pop ax		;retrieve original video
	mov ah,00h
	int 10h

	mov ax,4c00h
	int 21h
main endp

greenline proc near
	mov cx,170	;start col
	mov dx,240	;row
	mov ax,0c02h
lab:	int 10h
	inc cx
	cmp cx,470	;check column if=470
	jb lab
	ret
greenline endp

end main


