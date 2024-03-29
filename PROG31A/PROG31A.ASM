;This program calculates the total sum of 5 bytes of data.  Each byte represents the daily wages 
; of a worker.  This person does not make more than $255 (FFH) a day

    TITLE     	PROG3-1A  (EXE)   ADDING 5 BYTES
    PAGE 	60,132
   .MODEL SMALL
   .STACK 64
   ;--------------
   		.DATA  
   COUNT	EQU  	05
   DATA      	DB  		125,235,197,91,48
             	ORG   	0008H
   SUM       	DW    	?
   ;--------------
   		.CODE
   MAIN      	PROC 	FAR
             	MOV  	AX,@DATA
             	MOV  	DS,AX
             	MOV  	CX,COUNT	;CX is the loop counter
             	MOV  	SI,OFFSET DATA	;SI is the data pointer  
             	MOV  	AX,00   		;AX will hold the sum
   BACK:     	ADD  	AL,[SI]		;add the next byte to AL      
             	JNC  	OVER		;If no carry, continue   
             	INC  	AH		;else accumulate carry in AH      
   OVER:     	INC  	SI		;increment data pointer
             	DEC  	CX		;decrement loop counter
             	JNZ  	BACK		;if not finished, go add next byte
             	MOV  	SUM,AX		;store sum      
             	MOV  	AH,4CH
             	INT  	21H		;go back to DOS
   MAIN      	ENDP
             	END  	MAIN


