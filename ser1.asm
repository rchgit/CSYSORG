.model small
.stack 100h

.data
text db 'This is a test transmission!'

.code
main proc far

; data seg init
mov ax, @data
mov ds, ax
mov es,ax

; com port init
mov     ah, 0           ;Initialize opcode
mov     al, 11100011b   ;Parameter data.
mov     dx, 0           ;COM1: port.
int     14h

; transmit
mov dx, 0 ; COM1
mov al, 'a' ; char to transmit
mov ah, 1 ; transmit function
int 14h

;exit
mov ah,4ch
int 21h

main endp
end main