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
	buffer		resb	14
	result		resb	1
	
section	.text
	global	_start
	
_start:
	;prompt and user input
	print	msg1, 23					;using print macro to print msg1
	scan	buffer, 14					;using scan macro to take in user input(the expression)
	
	
	;taking the first number and adding it to result (acts as like a base case)
	and	byte[buffer], 0fh				;converting first number into decimal
	mov	ah, byte[buffer]				;ah = first number
	add	byte[result], ah				;result = result + ah
	
	;converting first number back into ascii in order to print it again
	add	byte[buffer], 30h
	
	;counter (we already added the first number to result, so we start with 1 instead of 0)
	mov	r10, 1	
next:
	mov	dil, byte[buffer + r10] 			;moving operation to first argument for function
	inc	r10						;r10++
	and	byte[buffer + r10], 0fh				;converting next ascii into number
	mov	sil, byte[buffer + r10] 			;moving next number into 2nd argument for function
	
	add	byte[buffer + r10], 30h				;num + 30h -> converts number back into ascii
	
	call	sign						;calling function with arguments above
	inc	r10						;r10++ -> to access next operation
	cmp	r10, 13						;compare r10 and 13(number of characters from user input)
	jne	next						; if r10 != 13, jump to next:
	
	;runs when all number have been dealt with
	print	buffer, 13				      	;using print macro to print buffer which are still all in ascii
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

;compares the current operation(dil) with all possible hex representations 
;of the operations, and jumps to its respected label when found
	cmp	dil, 0x2B
	je	add_sign
	cmp	dil, 0x2D
	je	sub_sign
	cmp	dil, 0x2A
	je	mul_sign
	cmp	dil, 0x2F
	je	div_sign
	cmp	dil, 0x25
	je	mod_sign
	mov	dl, 1					;dl = 1 -> intializing counter for power_sign
	mov	cl, byte[result]			;cl = result; initializing cl for power_sign
	cmp	dil, 0x5E
	je	power_sign
	
	jmp	end
	
	;addition
	add_sign:
		add	byte[result], sil
		jmp	end
	
	;subtraction
	sub_sign:
		sub	byte[result], sil
		jmp	end
		
	;multiplication
	mul_sign:
		mov	al, byte[result]
		mul	sil
		mov	byte[result], al
		jmp	end
		
	;division
	div_sign:
		mov	al, byte[result]
		mov	ah, 0
		idiv	sil
		mov	byte[result], al
		jmp	end
	
	;modulous
	mod_sign:
		mov	al, byte[result]
		mov	ah, 0
		idiv	sil
		mov	byte[result], ah
		jmp	end
		
	;to the power
	power_sign:
		mov	al, byte[result]
		cmp	dl, sil
		jl	power
		jmp	end
		power:
			inc	dl
			mul	cl
			mov	byte[result], al
			jmp	power_sign
	;done
	end:
		ret
	
