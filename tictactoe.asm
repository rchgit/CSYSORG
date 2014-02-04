; ----------------------------------------------------------------------------
; 5_hello.asm
; nasm -f bin -o hello.com 5_hello.asm
; a simple console game of tic-tac-toe. turn-based, multi-player game, no AI
;
; ----------------------------------------------------------------------------
 
.code
 
   ; ========================================================================
   ; Main Program
   ; ========================================================================
 
   org 100h
   mov cl,[perform_intro]
   ;cmp cl,1
   ;and cl,cl
   or cl,cl
   ;xor cl,cl
   ;inc cl
   jz end_if1
      mov dx,my_message
      mov ah,9            ; Write string to STDOUT, DS:DX=pointer to '$' terminated string
      int 21h
 
      mov dx,separator
      mov ah,9            ; Write string to STDOUT, DS:DX=pointer to '$' terminated string
      int 21h
   end_if1:
  
   mov cx,9
   mov dl,'x'
   for_loop:
      push cx
;     mov cx,my_message_len_equ
;     mov cx,[my_message_len_dw]
 
      push dx
      mov dx,prompt
      call print_string_0
      call input_user_move
      pop dx
      
      call update_board
      call print_board
 
      cmp dl,'x'
      je  mov_o
         mov dl,'x'
         jmp end_mov
      mov_o:
         mov dl,'o'
      end_mov:
      push dx
      
   check_for_win:
      mov si,row1
      mov cx,3
      check_for_win_row_loop:
         push cx       ; save loop counter
         xor cx,cx     ; clear cx
         mov cl,[si]   ; move contents of addess pointer into cl
         mov ax,cx     ; add new contents to accumlator ax
         mov cl,[si+2] ; move contents of 2nd cell into cl
         add ax,cx     ; add to accumulator
         mov cl,[si+4] ; move contents of 3rd cell into cl
         add ax,cx     ; add to accumulator
         cmp ax,3*'o'  ; check if 3 'o' were in the three rows
         jz win_found
         cmp ax,3*'x'  ; check if 3 'x' were in the three rows
         jz win_found
         add si,8      ; move to next row (there 8bytes per row)
         pop cx        ; get loop counter
         dec cx        ; decrement loop counter. stay in loop if not zero
      jnz check_for_win_row_loop ; stay in loop until cx is zero
 
      mov si,row1
      mov cx,3
      check_for_win_col_loop:
         push cx       ; save loop counter
         xor cx,cx     ; clear cx
         mov cl,[si]   ; move contents of addess pointer into cl
         mov ax,cx     ; add new contents to accumlator ax
         mov cl,[si+8] ; move contents from 2nd row into cl
         add ax,cx     ; add to accumulator
         mov cl,[si+2*8] ; move contents from 3rd row into cl
         add ax,cx     ; add to accumulator
         cmp ax,3*'o'  ; check if 3 'o' were in the three rows
         jz win_found
         cmp ax,3*'x'  ; check if 3 'x' were in the three rows
         jz win_found
         add si,2      ; move to next column (skip the vertical bar)
         pop cx        ; get loop counter
         dec cx        ; decrement loop counter. stay in loop if not zero
      jnz check_for_win_col_loop ; stay in loop until cx is zero      
      
      mov si,row1
         xor cx,cx     ; clear cx
         mov cl,[si]   ; move contents of addess pointer into cl
         mov ax,cx     ; add new contents to accumlator ax
         mov cl,[si+8+2] ; move contents from 2nd row into cl
         add ax,cx     ; add to accumulator
         mov cl,[si+2*8+4] ; move contents from 3rd row into cl
         add ax,cx     ; add to accumulator
         cmp ax,3*'o'  ; check if 3 'o' were in the three rows
         jz win_found
         cmp ax,3*'x'  ; check if 3 'x' were in the three rows
         jz win_found
 
      mov si,row1
         xor cx,cx     ; clear cx
         mov cl,[si+4]   ; move contents of addess pointer into cl
         mov ax,cx     ; add new contents to accumlator ax
         mov cl,[si+8+2] ; move contents from 2nd row into cl
         add ax,cx     ; add to accumulator
         mov cl,[si+2*8] ; move contents from 3rd row into cl
         add ax,cx     ; add to accumulator
         cmp ax,3*'o'  ; check if 3 'o' were in the three rows
         jz win_found
         cmp ax,3*'x'  ; check if 3 'x' were in the three rows
         jz win_found
 
      pop dx
      ;mov dx,my_message
      ;call print_string_0
      ;print_string
      ;mov ah,40h
      ;mov bx,01h           ; stdout
      ;int 21h
      pop cx
      dec cx
   jnz for_loop
   win_found:
   cmp ax,3*'o'
   jz o_wins
      mov dx,x_is_the_winner
      call print_string_0
      jmp end_print_winner
   o_wins:
      mov dx,o_is_the_winner
      call print_string_0
   end_print_winner:
   mov al,0            ; return code (0 = no error)
   mov ah,4Ch          ; "EXIT" - TERMINATE WITH RETURN CODE, AL = return code
   int 21h
  
   ; ========================================================================
   ; Functions and subroutines
   ; ========================================================================
 
   print_string:
      mov ah,40h
      mov bx,01h           ; stdout
      int 21h
   ret
  
   print_string_0:
      mov si,dx            ; load the start of string into si
      print_string_0_loop:
         mov cl,[si]       ; load the character byte into ch
         inc si            ; advance dx pointer to the next character
         and cl,cl         ; check to see if the char is zero
      jnz print_string_0_loop
      dec si               ; si is pointing to the byte after null. decrement it back to null char.
      sub si,dx            ; subract first char address from last char address to get string length
      mov cx,si            ; int 21h ah=40h expects CX to contain the string length
      
      mov ah,40h
      mov bx,01h           ; stdout
      int 21h
   ret ; print_string_0
  
   input_user_move:
      ; read first char (row_id) from stdin without echo. The result is stored in AL
      mov ah,07h
      int 21h
      sub al,30h ; convert ASCII to integer by subtracting '0'
      mov [user_move],al
      
      ; read another char (column_id) from stdin without echo. The result is stored in AL
      mov ah,07h
      int 21h
      sub al,30h ; convert ASCII to integer by subtracting '0'
      mov [user_move+1],al
   ret ;input_user_move
 
   ; 'x' or 'o' passed in with DL register
   ; ax, cx and si are corrupted
   update_board:
      xor  ax,ax
      mov  al,[user_move+1]
      shl  ax,1 ;multiple by 2 to handle the vertical bar separators
      xor  cx,cx
      mov  cl,[user_move]
      shl  cx,3  ; multiply by 8 to get the row(each row is conviently 8 bytes)
      add  ax,cx
      add  ax,row1
      mov  si,ax
      mov  [si],dl
   ret ;update_board
  
   print_board:
      push dx
      mov dx,row1
      call print_string_0
      mov dx,sep
      call print_string_0
      
      mov dx,row2
      call print_string_0
      mov dx,sep
      call print_string_0
      
      mov dx,row3
      call print_string_0
      pop dx
   ret; print_board
 
 
.data
 
   ; ========================================================================
   ; Constants, Variables and Data Structures
   ; ========================================================================
 
   perform_intro dw 0
   my_message db 'He\$$lloh ',41h,7,'$',10,0
   my_message_len_equ equ $-my_message
   my_message_len_dw dw my_message_len_equ
 
   separator db 10,10,"------------------------",10,10,'$'
  
   o_is_the_winner db 'Way to go O!',10,0
   x_is_the_winner db 'X Rules!',10,0
   prompt db 'Your move (00=top left, 02=top right, 11=middle, 22=lower right...)',10,0
   user_move db 0,0
   row1 db ' | |  ',10,0
   row2 db ' | |  ',10,0
   row3 db ' | |  ',10,0
   sep  db '----- ',10,0