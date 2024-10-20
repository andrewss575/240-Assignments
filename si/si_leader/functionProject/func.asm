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
	msg2	db	" = "
	ascii	db	"0", 10
	
section	.bss
	buffer		resb	4
	result		resb	1
	
section	.text
	global	_start
	
_start:
	;prompt and user input
	print	msg1, 					;using print macro to print msg1
	scan	buffer, 4					;using scan macro to take in user input(the expression)
	
	
	;taking the first and second ascii number and turning it to decimal
	and	byte[buffer], 0fh				
	and	byte[buffer + 2], 0fh				
	
	mov	dil, byte[buffer]				;moving first number into first argument for function
	mov	sil, byte[buffer + 1] 				;moving operation to second argument for function
	mov	dl, byte[buffer + 2]				;moving next number into third argument for function
	call	sign						;calling function with arguments above
	
	;converting first and second number back into ascii in order to print it again
	add	byte[buffer], 30h
	add	byte[buffer+2], 30h
	
	;runs when all number have been dealt with
	print	buffer, 3				      	;using print macro to print buffer which are still all in ascii
	print	msg2, 3  					;using print macro to print " = "
	
	mov	ah, byte[result]				;ah = result
	add	byte[ascii], ah					;ascii = ascii + ah = 30h + ah (converts result into ascii)
	print	ascii, 2					;using print macro to print the result
	
	;end system call
	mov	rax, 60
	mov	rdi, 0
	syscall
	
;*****************FIND THE OPERATION FUNCTION*******************************

global sign

sign:

;compares the current operation(sil) with all possible hex representations 
;of the operations, and jumps to its respected label when found
	cmp	sil, 0x2B
	je	add_sign
	cmp	sil, 0x2D
	je	sub_sign
	cmp	sil, 0x2A
	je	mul_sign
	cmp	sil, 0x2F
	je	div_sign
	
	jmp	end
	
	;addition
	add_sign:
		add	byte[result], dil
		add	byte[result], dl
		jmp	end
	
	;subtraction
	sub_sign:
		sub	dil, dl
		mov	byte[result], dil
		jmp	end
		
	;multiplication
	mul_sign:
		mov	al, dil
		mul	dl
		mov	byte[result], al
		jmp	end
		
	;division
	div_sign:
		mov	al, dil
		mov	bl, ah
		mov	ah, 0
		idiv	dl
		mov	byte[result], al
		jmp	end
	
	;done
	end:
		ret
