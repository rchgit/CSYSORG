;This program transfers 6 bytes of data from memory locations with offset of 0010H to 
;	memory locations with offset of 0028H.

TITLE     	PROG2-3  (EXE)   PURPOSE: TRANSFERS 6 BYTES OF DATA
PAGE 	60,132
		.MODEL SMALL
		.STACK 64
		.DATA
             	ORG	10H
DATA_IN     	DB		25H,4FH,85H,1FH,2BH,0C4H
             	ORG	28H
COPY      	DB		6 DUP(?)
;--------------
                .CODE
MAIN      	PROC  	FAR
             	MOV  	AX,@DATA
             	MOV  	DS,AX
                MOV     SI,OFFSET DATA_IN  ;SI points to data to be copied
                MOV     DI,OFFSET COPY     ;DI points to copy of data
                MOV     CX,06H             ;loop counter = 6   
MOV_LOOP:       MOV     AL,[SI]            ;move the next byte from DATA area to AL
                MOV     [DI],AL            ;move the next byte to COPY area
                INC     SI                 ;increment DATA pointer
                INC     DI                 ;increment COPY pointer
                DEC     CX                 ;decrement LOOP counter
                JNZ     MOV_LOOP           ;jump if loop counter not zero
                MOV     AH,4CH             ;set up to return
                INT     21H                ;return to DOS
MAIN      	ENDP
             	END  	MAIN