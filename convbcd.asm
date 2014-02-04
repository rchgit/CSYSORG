.model small
.stack 100h

.code
main proc far
mov ah, 00h
MOV AL,17H
AAM
;MOV CL,04H
;ROL AH,CL
;ADD AH,AL
add ax, 3030h
mov dx, ax
mov ah, 09h
int 21h
mov ah, 4ch
int 21h
main endp
end main

