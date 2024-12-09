;this program creates a function that finds the average and sum of an array of quad-word numbers. This
;program is similar to avgfunc.asm but this time, we have registers that we want to save its value before changing
;during the functions process. AN example of this is needing to save rcx as a counter AFTER executing the function
;we push and pop mutiple times so MAKE SURE you keep track of the the pushes so that when you pop, you know what your popping

;stats(arr&, len, avg&, sum&)

section .data
	arr	dq	10, 20, 30, 40, 50, 60
	len	dq	6

section .bss	
	avg	resq	1
	sum	resq	1
	
section .text
	global _start
_start:
	;we want rax to remain 5 after function runs even though rax is being changed within the function
	;we use a epilogue and prologue to reserve the value 5 for rax
	mov rax, 5
	
	;counter
	mov rcx, 3
arrLoop:	

	push rcx		;we push rcx becasue we use it as a counter but its changing to an 
				;argument so we need to save its original value into the stack and 
				; then pop it back to rcx after function is funished running

	;the 4 arguments go in rdi, rsi, rdx, and rcx respectively
	mov rdi, arr
	mov rsi, qword[len]
	mov rdx, avg
	mov rcx, sum
	call stats
	
	pop rcx
	
	loop arrLoop
	
	mov rax, 60
	mov rdi, 0
	syscall
	
;**********FUNCTION******************
global stats

stats:
	push rax		;prologue - reserves the previous value of rax in the stack befor enessing with the register
	mov r10, 0
sumLoop:
	add rax, qword[rdi + r10 * 8]
	inc r10
	
	cmp r10, rsi
	jne sumLoop
	
	mov qword[rcx], rax
	
	push rdx			;pushing rdx because it was orginally the address for avg variable,
				;so before we use it for division, i have to save its orignail value for later
	mov rdx, 0
	div rsi
	
	pop rdx			;after division, we no longer need rdx as remainder, so restore rdx to the address of avg variable
	
	mov qword[rdx], rax
	
	pop	rax	;epilogue - returns rax to its previous value by popping from stack before exiting functions
	ret
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
