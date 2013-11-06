.model small
.stack 100h

.data

.code

start:
MOV 	AL,45H	; AL = 45 BCD
MOV 	BL,67H	; BL = 67 BCD
ADD 	AL,BL	; AL = AL + BL = ACH	
DAA			; AL = 12H
MOV 	AH,00H	; AH = 00H 
ADC	AH,AH	; AX = 0112H . Adding AH to itself will result in the carry being the only number added
MOV 	DX,AX	; DX = 0112H
mov ah,4ch
int 21h
end start 