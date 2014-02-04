.model small
.stack 64
.code
main proc far
	mov ax,@data
	mov ds,ax

	call scroll		;scroll up

	mov ax,4c00h
	int 21h
main endp

scroll proc near
	mov ax,0809h	;request scroll down 9 lines
	mov bh,00h	;page number
	;mov cx,0a00h	;row=10 col=00
	;mov dx,184fh	;full screen 24:79
	int 10h
	ret
scroll endp

;need to code a loop to read succesive characters

end main


