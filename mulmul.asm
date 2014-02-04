.MODEL SMALL
.STACK 64
.DATA

        MULT1 DW 0001H
              DW 0001H
        MULT2 DW 0001H
              DW 0001H
			  
		ADD1   DW 0001H
		       DW 0001H
			   
			   SUB1 DW 0001H
			   DW 0001H
			
        ANS   DW 0,0,0,0
		
		ANSASCII DW ?
		ANS2  DW 0,0,0,0
		ANS3   DW 0,0,0,0,'$'
		
		
.CODE
		
		MAIN PROC FAR
        MOV AX,@DATA
        MOV DS,AX
			
        MOV AX,MULT1
        MUL MULT2
        MOV ANS,AX
        MOV ANS+2,DX

        MOV AX,MULT1+2
        MUL MULT2
        ADD ANS+2,AX
        ADC ANS+4,DX
        ADC ANS+6,0

        MOV AX,MULT1
        MUL MULT2+2
        ADD ANS+2,AX
        ADC ANS+4,DX
        ADC ANS+6,0

        MOV AX,MULT1+2
        MUL MULT2+2
        ADD ANS+4,AX
        ADC ANS+6,DX
		
		MOV AX,ANS+4
		ADD  AX,ADD1
		MOV  ANS+4,AX
		
		MOV AX,ANS+2
		ADC AX,ADD1+2
		MOV ANS+2,AX
		
		MOV AX,ANS+4
		SUB AX,SUB1
		MOV ANS+4,AX
		
		MOV AX,ANS+2
		SBB AX,SUB1+2
		MOV ANS+2,AX
		
      
	 MOV     SI,OFFSET ANS  
      MOV     DI,OFFSET ANSASCII    
      MOV     CX,05  
	  CALL CONV_ASC
	  
	
	  mov ax,0012h
	  int 10h
	 
	  
	 
	
	  
	  LEA DX,ANSASCII
	  MOV AH,09
	  INT 21H
		 
        MOV AX,4C00H
        INT 21H
		
		MAIN ENDP
		
		
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
		  ;FK THIS SHIT