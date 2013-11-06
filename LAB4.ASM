.model small
.stack
.data

message1 db 'Press F1 to change the character below$'
.code

main proc far
	mov ax, @data
	mov ds, ax
	mov es, ax

	mov ax, 0600h		
	xor cx, cx
	mov dx, 184fh
	mov bh, 7
	int 10h			; Int (1)

	mov ah, 2
	mov bh, 0
	mov dx, 0
	int 10h			; Int (2)

	mov ah, 13h 
	mov al, 01
	mov bh, 00
	mov bl, 71h
	lea bp, message1
	mov cx, 38		; (3)
	mov dx, 0115h
	int 10h			; Int (4)

	mov dx, 0526h
	mov ah, 2
	mov bh, 0
	int 10h			; Int (5)

	mov ah, 9
	mov al, 'a'
	mov bh, 0
	mov bl, 03
	mov cx, 0001
	int 10h			; Int (6)
notequal:

	mov ah, 10h
	int 16h			; Int (7)
	cmp ah, 3bh
	je equal2
	jmp notequal
equal2:
	mov dx, 0526h
	mov ah, 2
	mov bh, 0
	int 10h			; Int (8)

	mov ah, 9
	mov al, 'b'
	mov bh, 0
	mov bl, 03
	mov cx, 0001
	int 10h			; Int (9)
	mov ax, 4c00h		
	int 21h			; Int (10)
main endp
end main
