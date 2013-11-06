.model small
.stack 100h
readnum macro num  
     mov ah,01h  
     int 21h  
     sub al,'0'  
     mov bh,0ah  
     mul bh  
     mov num,al  
     mov ah,01h  
     int 21h  
     sub al,'0'  
     add num,al  
     endm  
 printstring macro msg  
     mov ah,09h  
     mov dx,offset msg  
     int 21h  
     endm  
 data segment  
     cr equ 0dh  
     lf equ 0ah  
     msg1 db 'enter the number',cr,lf,'$'  
     msg2 db 'the factorial is','$'  
     num db ?  
     result db 20 dup('$')  
     data ends  
 code segment  
     assume cs:code,ds:data  
 start:  
        mov ax,data  
        mov ds,ax  
        printstring msg1  
        readnum num  
        mov ax,01h  
        mov ch,00h  
        mov cl,num  
        cmp cx,00  
        je skip  
 rpt1:  
       mov dx,00  
       mul cx  
       loop rpt1  
 skip:  
       mov si,offset result  
       mov bl,[si]  
       call hex2asc  
       printstring msg2  
       printstring result  
       mov ah,4ch  
       mov al,00h  
       int 21h  
       hex2asc proc near  
       push ax  
       push bx  
       push cx  
       push dx  
       push si  
       mov cx,00h  
       mov bx,0ah  
 rpt2:  
       mov dx,00  
       div bx  
       add dl,'0'  
       push dx  
       inc cx  
       cmp ax,0ah  
       jge rpt2  
       add al,'0'  
       mov [si],al  
 rpt3:pop ax  
       inc si  
       mov [si],al  
       loop rpt3  
       inc si  
       mov al,'$'  
       mov [si],al  
       pop si  
       pop dx  
       pop cx  
       pop bx  
       pop ax  
       ret  
       hex2asc endp  
       code ends  
 end start 