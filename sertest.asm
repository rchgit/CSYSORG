.model small
.stack 100h

.code
main proc far

mov ax, 0400h
mov [0000],ax ; COM1
mov 