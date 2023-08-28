;Create a single-integer calculator that takes 6 operations(+, -, *, /, ^, %) and solves them from left-to-right(no PEMDAS)


;creating macros for our scan and print to terminal
%macro	print 	2
        mov     rax, 1					;SYS_write
        mov     rdi, 1					;standard output device
        mov     rsi, %1					;output string address
        mov     rdx, %2					;number of character
        syscall						;calling system services
%endmacro

%macro	scan 	2
        mov     rax, 0					;SYS_read
        mov     rdi, 0					;standard input device
        mov     rsi, %1					;input buffer address
        mov     rdx, %2					;number of character
        syscall						;calling system services
%endmacro

section	.data
	msg1	db	"Enter your expression: "
	
section	.bss
	buffer	resb	100
	num1	resb	1
	num2	resb	1
	num3	resb	1
	num4	resb	1
	num5	resb	1
	num6	resb	1
	num7	resb	1
	sym1	resb	1
	sym2	resb	1
	sym3	resb	1
	sym4	resb	1
	sym5	resb	1
	sym6	resb	1
	
section	.text
	global	_start
	
_start:
	print	msg1, 23
	scan	buffer, 14
	
	mov	al, byte[buffer + 0]
	mov	byte[num1], al
	mov	al, byte[buffer + 1]
	mov	byte[sym1], al
	mov	al, byte[buffer + 2]
	mov	byte[num2], al
	mov	al, byte[buffer + 3]
	mov	byte[sym2], al
	mov	al, byte[buffer + 4]
	mov	byte[num3], al
	mov	al, byte[buffer + 5]
	mov	byte[sym3], al
	mov	al, byte[buffer + 6]
	mov	byte[num4], al
	mov	al, byte[buffer + 7]
	mov	byte[sym4], al
	mov	al, byte[buffer + 8]
	mov	byte[num5], al
	mov	al, byte[buffer + 9]
	mov	byte[sym5], al
	mov	al, byte[buffer + 10]
	mov	byte[num6], al
	mov	al, byte[buffer + 11]
	mov	byte[sym6], al
	mov	al, byte[buffer + 12]
	mov	byte[num7], al
	
	mov	rdi, 
	mov	rax, 60
	mov	rdi, 0
	syscall
	
	
;****************ADDITION FUNCTION***********************************

global addition

addition:

	add	rdi, rsi
	mov	rax, rdi
			
	ret
	
;****************SUBTRACTION FUNCTION*****************************

global subtraction

subtraction:

	sub	rdi, rsi
	mov	rax, rdi
			
	ret
	
;***************MULTIPLICATION FUNCTION**************************

global multiplication

multiplication:
	mov	rax, rdi
	imul	rsi
			
	ret

;***************DIVISION FUNCTION********************************

global division

division:
	mov	rax, rdi
	div	esi
			
	ret
	
;***************MODULO FUNCTION*********************************

global modulo

modulo:
	mov	rdx, 0
	mov	rax, rdi
	mov	ebx, esi
	div	ebx
	mov	eax, edx
			
	ret
	
;***************ASCII TO DECIMAL FUNCTION***********************

global atoi

atoi:
	and	byte[rbx], 0fh			;convert ascii to number
	add	al, byte[rbx]			;al = number
			
	ret
	
;**************FIND THE OPERATION*******************************

global sign

sign:
	cmp	rdi, 0x2B
	je	add_sign
	cmp	rdi, 0x2D
	je	sub_sign
	cmp	rdi, 0x2A
	je	mul_sign
	cmp	rdi, 0x2F
	je	div_sign
	cmp	rdi, 0x25
	
	add_sign:
		add	rsi, rdx
		mov	rax, rsi
	sub_sign:
		sub	rsi, rdx
		mov	rax, rsi
	mul_sign:
		mov	rax, rsi
		mul	rdx
	div_sign:
		mov	rax, rsi
		mov	rcx, rdx
		mov	rdx, 0
		div	rcx
	mod_sign:
		mov	rax, rsi
		mov	rcx, rdx
		mov	rdx, 0
		div	rcx
		mov	rdx, rax
	
