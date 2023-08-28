;This code will add the elements of an array into sum 
;and finds the average of the values in the array
section .data

	average_q	dd	0
	average_r	dd	0
	sum		dd	0
	list		dd	2,3,5,7,9,11

section .text
	global _start

_start:
	mov 	rbx, list	;saving the address of the first element of the list
	mov 	rsi, 0		;will be used as a counter to see how many iterations the loop went through
	mov 	rcx, 6		;counts down every time loop iterates. its actually the first thing loop does (rcx-1)
	mov 	eax, 0
	
	
lp:

;dword[rbx + rsi*4] accesses the next element in the list. rbx is current element in the list. Because the array consist 
;of double word elements, add 4(representing number of bytes which is 32-bits) to access the next element. rsi*4 is a trick 
;we can use to iterate to the next element during each iteration. Thats why we increment rsi after every iteration.
;the line as a whole adds each element in the array after every iteration that eventially gets the sum of all elements
	add 	eax, dword[rbx + rsi*4]					
	inc 	rsi
	loop 	lp				
		
	mov	dword[sum], eax		;sum = eax = 37
	idiv	rsi			;eax/rsi -> eax = 6, edx = 2
					
	mov	dword[average_q], eax	;average quotient
	mov	dword[average_r], edx	;average remainder
	
	
	
        mov     rax, 60                                         ;terminate excuting process
        mov     rdi, 0                                          ;exit status
        syscall      
