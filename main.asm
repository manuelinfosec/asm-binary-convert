.ORIG x3000

	LEA 	R0, HELLO		;print greeting
	PUTS
BEGIN	AND	R1, R1, #0		;used as temp variable register
	AND	R2, R2, #0			;checks for x, holds masks
	AND	R3, R3, #0			;flag for negative decimal, holds masks address
	AND	R4, R4, #0			;checks for enter key
	AND	R5, R5, #0			;holds sum
	AND	R6, R6, #0			;counter for multiplying x10
	AND	R7, R7, #0			;reserved for TRAP commands

	LEA 	R0, MSG			;ask for decimal
	PUTS
	LD 	R2, ENDX
	LD	R3, HYPHEN
	LD	R4, ENT

INPUT	GETC
	OUT
	ADD	R6, R0, R2
	BRz	END					;exit if X
	ADD	R6, R0, R3			;set R3(flag) to 1 if decimal starts with a -
	BRz	NEG	
	LD	R6, TIMES	
TEN	ADD	R5, R1, R5			;add previous number 9 times to create x10	
	ADD	R6, R6, #-1			;loop 9 times
	BRp	TEN	
	ADD	R1, R0, R4	
	BRz	PRINT				;print if return key
	LD	R1, DIGIT	
	ADD	R0, R0, R1			;subtract 48 from char value to get digit
	ADD	R1, R5, #0			;store current sum for multiplying by 10
	ADD	R5, R0, R5			;add current int to sum
	BR	INPUT				;get next digit

PRINT	ADD	R1, R3, #-1	
	BRn	PRINTC				;skip if flag is 0
	NOT 	R5, R5			;invert if flag is 1
	ADD	R5, R5, #1			;add 1 for 2's complement	
PRINTC	LD	R1, COUNT	
	LD	R2, MASKS			;load masks
	LEA	R3, MASKS			;load address of masks
COMP	AND	R0, R2, R5		;compare masks to decimal
	BRz	PRINTZ
	BR	PRINTO

PRINTZ	LD	R0, ZERO		;print 0 if bit at location is 0
	OUT
	BR 	DEC

PRINTO	LD	R0, ONE			;print 1 if bit at location is 1
	OUT
	BR 	DEC

DEC	ADD	R3, R3, #1			;increment masks address
	ADD	R1, R1, #-1			;loop 16 times for 16 bit binary
	BRn	BEGIN				;back to beginning after 16 bits
	LDR	R2, R3, #0			;load new masks
	BR	COMP				;compare next bit

NEG	AND	R3, R3, #0		
	ADD	R3, R3, #1
	BR	INPUT

END	TRAP	x25

TIMES	.FILL		#9		;counter for multiplying by 10
DIGIT	.FILL		#-48	;converts ascii to digit value
HYPHEN	.FILL		#-45	;ascii value for "-"
ENDX	.FILL		#-88	;ascii value for "X"
ENT	.FILL		#-10		;ascii value for newline
COUNT	.FILL		#15		;counter for printing binary number
ZERO	.FILL		#48		;ascii value for "0"
ONE	.FILL		#49			;ascii value for "1"
MASKS	.FILL	x8000	 	;for comparing against the sum
	.FILL		x4000
	.FILL		x2000
	.FILL		x1000
	.FILL		x0800
	.FILL		x0400
	.FILL		x0200
	.FILL		x0100
	.FILL		x0080
	.FILL		x0040
	.FILL		x0020
	.FILL		x0010
	.FILL		x0008
	.FILL		x0004
	.FILL		x0002
	.FILL		x0001
HELLO 	.STRINGZ	"\nHello, welcome to a simple Decimal to Binary Converter"
MSG	.STRINGZ	"\nPlease enter a decimal or terminate with X:\n"

.END