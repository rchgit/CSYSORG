.model large

;lengt is number of double bytes. for 64bit, lengt=4
hextoasc macro memin,memout,lengt
	local here1
	mov cx,lengt
	mov si,04
	
	mov ax,lengt	;to set end character
	mul si
	add ax,memout
	mov di,ax
	mov ax,24h
	mov [di],ax
	
here1:
	mov bx,cx			;set bx,dx to offset values
	sub bx,1
	add bx,bx
	mov ax,cx
	sub ax,1
	mov si,04
	mul si
	mov dx,ax
	
	mov di,memout
	mov si,memin
	mov al,[si+bx+1]	;lower byte 
	mov ah,al
	shr ah,4
	xchg ah,al
	and ax,0f0fh
	add ax,3030h
	add di,dx
	mov [di],ax
	
	mov di,memout
	mov si,memin
	mov ax,0		;upper byte
	mov al,[si+bx]
	mov ah,al
	shr ah,4
	xchg ah,al
	and ax,0f0fh
	add ax,3030h
	add di,dx
	mov [di+2],ax
	
	loop here1
	endm

asccheck macro mem
	local retu, jm1, exi
	mov si,mem
retu:
	mov al,[si]
	cmp al,24h
	je exi
	cmp al,3ah
	jb jm1
	sub al,9
	add al,10h
	mov [si],al
jm1:
	inc si
	jmp retu
exi:
	endm
	
.stack 64
.data

	msg2 db ' + $'
	msg3 db ' - $'
	msg4 db '/2 = $'
	
.code
main proc far
	;P + Q - R/2 = A
	;A=1000, P=2000...
	
	mov ax,@data
	mov ds,ax
	
	hextoasc 2000h,5100h,4 ;P
	asccheck 5100h
	hextoasc 3000h,5200h,4 ;Q
	asccheck 5200h
	hextoasc 4000h,5300h,4 ;R
	asccheck 5300h
	
	;r/2
	mov bx,2
	mov ax,[4006h]
	div bx
	
	mov ah,9
	mov dx,5100h
	int 21h
	lea dx,msg2
	int 21h
	mov dx,5200h
	int 21h
	lea dx,msg3
	int 21h
	mov dx,5300h
	int 21h
	lea dx,msg4
	int 21h
	
	mov ah,4ch
	int 21h
	
main endp
end main