;this code demonstartes how to traverse through an array and find the sum of all elements

; This sections shows the values of all variables BEFORE the code executes. Sum is a double word so that's 32-bits which can be represented
; as 0x0000 0000 since sum is 0. (8 hex digits is 32-bits). The num variable is slightly different, as it is actually an array of
; numbers. num is declared as a byte but that does NOT mean that the whole array is represented as a byte. What it actually means is that
; num reserves an array of 5 SEPERATE bytes, since there are 5 elements in num. Each number in that array is byte sized, so how it looks
; like in hex is: num + 0 = 119 =  0x77, num + 1 = 55 = 0x37, num + 2 = 223 = 0xDF, num + 3 = 96 = 0x60, num + 4 = 81 = 0x51. Also note 
; that num is the pointer to the FIRST element of the array, so if you want to travser the array, you would need to add to the num variable
; by using an offset
section .data
num	db	119, 55, 223, 96, 81
sum	dd	0

; NOTE: for my comments '->' will be used to identify the next iteration because there are loops in this problem
section .text
	global	_start
_start:
	mov	al, 0		;al = 0 = 0x00 used to clear al register
	mov	rsi, 0		;rsi = 0 = 0x0000 0000 0000 0000 (rsi is 64-bits so 16 hex digits)
	;rsi will be used as an offset to traverse thorugh the array, everytime you add to an array, you get a new value
	
next:
	;we are adding the offset to num because thats how we traverse the array. if rsi is 2, then [num + rsi] will get 223. This is
	;because num is an array of bytes, if it were an array of words for example, you would have to add 4 to get 223
	add	al, byte[num+rsi]	;(1st iter) ah:al = ah:al + [num + 0] = 0 + 119 = 119 = 0x00:0x77
					;-> (2nd iter) ah:al = ah:al + [num + 1] = 119 + 55 = 174 = 0x00:0xAE
					;-> (3rd iter) ah:al = ah:al + [num + 2] = 174 + 223 = 397 = 0x00:0x18D
					;-> (4th iter) ah:al = ah:al + [num + 3] = 397 + 96 = 493 = 0x01:0xED
					;-> (5th iter) ah:al = ah:al + [num + 4] = 493 + 81 = 574 = 0x02:0x3E
	;when adding, there can become a case where the sum of both numbers is greater than what al can hold. This instruction below allows 
	;the remaining bits be stored in ah. That is the reason why the comments above store the leading bits into ah, for example the sum 
	;is 574 or 0x23E in hex so al holds 0x3E and ah hold 0x02
	adc	ah, 0			
	
	inc	rsi			;(1st iter)rsi = rsi + 1 = 0 + 1 = 1 -> rsi =2 -> rsi =3 -> rsi = 4 -> rsi = 5
	cmp	rsi, 5			;compare rsi with 5
	jne	next			;(if(rsi != 5) goto next): (1st iter) rsi = 1, jump to 'next' -> rsi = 2, jump to 'next'
					;-> rsi = 3, jump to 'next', rsi = 4, jump to 'next', rsi = 5, dont jump, go to line 39
	;since the sum of all numbers of array is split into ah:al register, individually add them into sum variable
	mov	byte[sum+0], al		;sum+0 = al = 0x3E, sum(in double-word hex) = 0x0000 003E 
	mov	byte[sum+1], ah		;sum+1 = ah = 0x02, sum(in double-word hex) = 0x0000 023E 
	
	;At this point is where you record all variables/registers. Let's start with num array. Throughout the code, we did NOT
	;change the values of the array, we just accessed them and stored their sum in 'sum' variable. So num remains: 
	; num + 0 = 119 =  0x77, num + 1 = 55 = 0x37, num + 2 = 223 = 0xDF, num + 3 = 96 = 0x60, num + 4 = 81 = 0x51
	;in line 40 and 41, we input the sum into 'sum' variable. The sum, which is 0x23E can fit into sum variable as 
	;0x0000 0023E since 'sum' is a double-word, which is 8 hex digits
	
	;now to the registers. Lets look at rsi first. rsi is a 64 bit register so it sould be represented in 16 hex digits
	;rsi started at 0 but kept incrementing until it reached 5, so rsi is 5 or 0x0000 0000 0000 0005 in hex. 
	; For ah and al registers, they are unique because they are both part of ax, so ah:al is another way of saying ax. 
	; Since ah:al is 0x02:0x3E, ax = 0x023E
	
	;exiting program
	mov rax, 60
	mov rdi, 0
	syscall
