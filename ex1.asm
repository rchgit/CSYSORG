   .MODEL SMALL
   .STACK 64
   ;--------------
   			.DATA
			message1 db 'First no: ','$' ;+10
   DATA1_ASC 	DB 		'0649147816',10,13,'$'
             		ORG 	001AH
			message2 db 'Second no:','$'  ; +11
   DATA2_ASC 	DB		'0072687188',10,13,'$'
             		ORG 0034h
   DATA3_BCD	DB		5 DUP (?)
             		ORG	003CH
   DATA4_BCD	DB		5 DUP (?)
             		ORG	0044H
   DATA5_ADD 	DB		5 DUP (?),'$'
   
   message3 db 'Sum:      ','$'
             		ORG	005eH
   DATA6_ASC 	DB		10 DUP (?),'$'
   ;--------------
           .CODE
MAIN       PROC    FAR
           MOV     AX,@DATA
           MOV     DS,AX
           MOV     BX,OFFSET DATA1_ASC    
           MOV     DI,OFFSET DATA3_BCD     
           MOV     CX,10                  
           CALL    CONV_BCD               
           MOV     BX,OFFSET DATA2_ASC     
           MOV     DI,OFFSET DATA4_BCD    
           MOV     CX,10                   
           CALL    CONV_BCD                
           CALL    BCD_ADD                
           MOV     SI,OFFSET DATA5_ADD    
           MOV     DI,OFFSET DATA6_ASC     
           MOV     CX,05                  
           CALL    CONV_ASC               
			
			mov ah,00
			mov al,12h
			int 10h
		
			lea dx,message1
			mov ah,09
			int 21h
			
		
			lea dx,data1_asc
			mov ah,09
			int 21h
			
			lea dx,message2
			mov ah,09
			int 21h
			
			
			
			lea dx,data2_asc
			mov ah,09
			int 21h
			
			lea dx,message3
			mov ah,09
			int 21h
			
		
			
		   lea dx ,data6_asc
	 	   mov ah,09
		   int 21h
		   
           MOV     AH,4CH
           INT     21H                     ;go back to DOS
MAIN       ENDP


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


BCD_ADD   PROC
          MOV    BX,OFFSET DATA3_BCD    
          MOV    DI,OFFSET DATA4_BCD     
          MOV    SI,OFFSET DATA5_ADD        
          MOV    CX,05
          CLC
BACK:     MOV    AL,[BX]+4       
          ADC    AL,[DI]+4       
          DAA                   
          MOV    [SI] +4,AL        
          DEC    BX              
          DEC    DI              
          DEC    SI          
          LOOP   BACK
          RET
BCD_ADD   ENDP

CONV_ASC  PROC
AGAIN2:   MOV     AL,[SI]         
          MOV     AH,AL         
          AND     AX,0F00FH      
          PUSH    CX             
          MOV     CL,04           
          SHR     AH,CL          
          OR      AX,3030H      
          XCHG    AH,AL           
          MOV     [DI],AX                 
          INC     SI              
          ADD     DI,2            
          POP     CX              
          LOOP    AGAIN2
          RET
CONV_ASC  ENDP        
          END     MAIN
