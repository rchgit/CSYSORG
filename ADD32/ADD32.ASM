.model small
.stack 100h

.data
dexter dd 12345678h
castle dd 11111112h
barney dd ?

; dd = define doubleword
; dw = define word
; db = define byte


.code

start:
	mov ax, @data
	mov ds,ax
	
	;word ptr dexter ; pointer to least significant 16 bits
	; ADDING LOGIC 
	mov ax, word ptr dexter 
	mov bx, word ptr dexter+2 ; pointer to the most significant 16 bits (pointer arithmetic)
	mov cx, word ptr castle
	mov dx, word ptr castle+2
	
	add ax,cx ; LS bytes
	adc bx,dx ; MS bytes + carry
	
	mov word ptr barney, ax  ; mov barney, ax - WRONG!
	mov word ptr barney+2, bx
	
	; PRINTING LOGIC
	; 02h - displays a character
	; loop
	; find out the right character to be printed
	; perform hex-to-ascii conversion
	; 2 words - works on one word at a time
	
	; nested loop
	
	mov dh, 02 ; any other register except ax & bx
	outerloop: mov ch, 04
		
	innerloop:	mov cl, 04
		rol bx, cl ; roll bx value by 4 characters: MSB becomes LSB; 2345 becomes 3452
		mov dl, bl
		and dl, 0fh ; selecting the LSB
		cmp dl, 09 ; determine whether the value is less than/equal to, or greater than 9
		jbe ifless ; jump if below or equal
		; if it doesn't jump do below...
		add dl, 07h	
	ifless: add dl, 30h
		mov ah, 02h
		int 21h
		
		dec ch ; decrement ch
	jnz innerloop
	mov bx, word ptr barney ; why? bx has MSBits. so get the LSBits
	dec dh
	jnz outerloop
	
	; These two lines return control to OS
	mov ah, 0
	int 16h
	ret
	;mov ah,4ch
	;int 21h
	
end start
