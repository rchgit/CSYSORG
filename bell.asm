.model small
.stack 100h

.code
main proc far
mov ah, 02h
mov dl, 07h
int 21h
main endp
end main