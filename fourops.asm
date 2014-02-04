title mas on 48-bit numbers
.model small
.stack 100h
.data
ans dw ?,?,?,?,?,?
.code
main proc far

; ADD
MOV AX,[BX]
ADD [SI],AX
MOV AX,[BX+2]
ADC [SI+2],AX
MOV AX,[BX+4]
ADC [SI+4],AX
MOV AL,00
ADC AL,AL
MOV [SI+6],AL

; SUBTRACT
MOV AX,[BX]
SUB [DI],AX
MOV AX,[BX+2]
SBB [DI+2],AX
MOV AX,[BX+4]
SBB [DI+4],AX
MOV AL,00
SBB AL,AL
MOV [DI+6],AL

; MULTIPLY
MOV AX,[BX]
MOV CX, [BP]
MUL CX
mov ans[0], ax
mov ans[1], dx
mov ax,[bx+2]
mul cx
add ans[1],ax
adc ans[2],dx
mov ax, [bx+4]
mul cx
add ans[2], ax
adc ans[3], dx

mov cx, [bp+2]
mov ax, [bx]
mul cx
add ans[1],ax
add ans[2],dx
mov ax, [bx+2]
mul cx
add ans[2],ax
add ans[3],dx
mov ax,[bx+4]
mul cx
add ans[3],ax
mov ans[4],dx

mov cx, [bp+4]
mov ax, [bx]
mul cx
add ans[2],ax
add ans[3],dx
mov ax,[bx+2]
mul cx
add ans[3],ax
add ans[4],dx
mov ax,[bx+4]
mul cx
add ans[4],ax
adc ans[5], dx

main endp
end main