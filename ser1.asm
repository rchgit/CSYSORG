; Sample serial transmission program
; R. Canlas (c) 2013

send macro port, char
; text needs a termination character (null byte)
mov dx, port
mov ah, 1 ; send function
mov al, char
int 14h
endm

.model small
.stack 100h

.data
samptext db 'This is a test transmission!',0DH,0AH,0

.code
main proc far

; data seg init
mov ax, @data
mov ds, ax
mov es,ax

; com port init
mov     ah, 00h           ;Initialize opcode
mov     al, 11100011b   ;Parameter data.
mov     dx, 0           ;COM1: port.
int     14h

lea di, samptext
sendloop1:
mov al, [di]
cmp al,0
je endsend1
send 0, al
inc di
jmp sendloop1
endsend1:

exit:
mov ah,4ch
int 21h

main endp
end main

