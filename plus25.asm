.model small
.stack 100h
.data
.code

main proc far
mov ax, 5678h
mov ds:[2000],ax
mov ax, 1234h
mov ds:[2002],ax
mov ax, 2345h
mov ds:[3000],ax
mov ax, 4567h
mov ds:[3002],ax
mov ax, 1357h
mov ds:[4000], ax
mov ax, 2468h
mov ds:[4002], ax
mov ax, 1434h
mov ds:[5000], ax
mov ax, 8976h
mov ds:[5002], ax

mov ax, [3000h]
mov bx, [4000h]
mul bx
mov [6000h], ax
mov [6002h], dx
mov ax, [3002h]
mul bx
add [6002h], ax
adc [6004h], dx

mov ax, [3000h]
mov bx, [4002h]
mul bx
add [6002h], ax
adc [6004h], dx
mov ax, [3002h]
mul bx
add [6004h], ax
adc [6006h], dx

mov ax, [2000h]
add [6000h], ax
mov ax, [2002h]
adc [6002h], ax
adc [6004h], 0000h
mov ax, [5000h]
sub [6000h], ax
mov ax, [5002h]
sbb [6002h], ax
sbb [6004h], 0000h


mov ah, 4ch
int 21h
main endp
end main

CONV_BCD   PROC
AGAIN:     MOV     AX,[BX] 
           XCHG    AH,AL
           AND     AX,0F0FH        
           PUSH    CX              
           MOV     CL,4           
           SHL     AH,CL           
           OR      AL,AH         
           MOV     [DI],AL                 
           ADD     BX,2           
           INC     DI            
           POP     CX              
           LOOP    AGAIN
           RET
CONV_BCD   ENDP