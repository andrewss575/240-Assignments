;this program takes a decimal number (1987) and converts it into ascii and stores it into 'ascii' variable to demonstrate decimal
;to ascii conversion

section .data
	number	dw	1987 			;number = 0x07C3
	ascii	db	"0000", 0x0A		;ascii = 0x30, 0, x30, 0x30, 0x30, 0x0A 	(0x0A is hex for newline)


section .text
	global _start
_start:
	mov	rcx, 3 			;rcx = 3 = 0x0000 0000 0000 0003
					;rcx will be continously decremented in order to be an offset for 'ascii' array
	;we will be dividing 'number' to convert decimal to ascii, so we store 'number'(1987) as ax to be used as a dividend
	mov	ax, word[number]	;ax = 1987 = 0x07C3
	;bx will be used as a divisior. We store bx as 10 because we can convert 1987 to ascii by continually dividing by 10
	mov	bx, 10 			;bx = 10 = 0x000A	
	
;where our loop starts. IN my comments '->' is used to descibe the next iteration
next:
	mov	dx, 0 			;have to clear dx register before dividing because dx is the remainder 
	div	bx 			;(first iter) ax/bx = 1987/10 = ax = 198, dx = 7 -> 198/10 = ax = 19, dx = 8
					;-> 19/10 = ax = 1, dx = 9 -> 1/10 = ax = 0, dx = 1

	;get the remainder of each iteration and store it in the corresponding ascii digit. we use dl instead of dx
	;because ascii is an array of bytes not an array of words. This still workds bc, in this case, dx and dl are the same value
	;dx just holds more space
	add	byte[ascii+rcx], dl	;ascii = '0007' -> ascii = '0087' -> ascii = '0987' -> ascii = '1987'


	dec	rcx 			;(1st iter)rcx = rcx - 1 = 2 -> rcx = 1 -> rcx = 0 -> rcx = -1
	cmp	rcx, 0 			;compare rcx with 0
	jge	next 			;(is rcx >= 0): (1st iter) rcx = 2, jump to 'next' -> rcx = 1, jump to 'next'
					;-> rcx = 0, jump to 'next' -> rcx = -1, not greater than or equal 0, DO NOT JUMP
					
	;At this point is where the professor would want us to show the values of all registers/variables. The 'number' variable was only
	;used to copy its value to ax, so 'number' was never actually changed and stays at 0x07C3. The ascii variable started as 0x30, 0x30
	;0x30, 0x30, 0x0A, which is '0000/n', but as we iterated, we added to 'ascii' to get '1987/n' or ascii + 0 = 0x31, 
	;ascii + 1 = 0x39, ascii + 2 = 0x38, ascii + 3 = 0x37, ascii + 4 = 0x0A
	
	;the last time this code did something that involved ax and dx is dividing, and the last thing we divided was 1/10,
	;where the quotient gets stored in ax and the remainder in dx. When dividing 1/10, ax is 0 or 0x0000, and dx is 1 or 0x0001. In the 
	;code, bx was set to 10, and never changed so bx ends with 10 or 0x000A. We used rcx as a counter to check if it's greater than
	;or equal to 0. THe first time that was not true was when rcx is -1 so rcx ends with -1 or 0xffff ffff ffff ffff. Negative 
	;numbers in signed notation has leading bits of 1111 or 0xff. so since rcx is negative and 64 bits, it's represented as 
	;0xffff ffff ffff ffff
	
done:
	mov	rax, 60
	mov	rdi, 0
	syscall

