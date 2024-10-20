;this program creates a function that finds the average and sum of an array of quad-word numbers. This
;program is similar to avgfunc.asm but this time, we have registers that we want to save its value before changing
;during the functions process 

;stats(arr&, len, sum&, avg&)

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
	mov rdx, sum
	mov rcx, avg
	call stats
	
	pop rcx
	
	loop arrLoop
	
	mov rax, 60
	mov rdi, 0
	syscall
	
global stats

stats:
	push rax		;prologue - reserves the previous value of rax in the stack befor enessing with the register
	mov r10, 0
sumLoop:
	add rax, qword[rdi + r10 * 8]
	inc r10
	
	cmp r10, rsi
	jne sumLoop
	
	mov qword[rdx], rax
	
	mov rdx, 0
	div rsi
	mov qword[rcx], rax
	
	pop	rax	;epilogue - returns rax to its previous value by popping from stack before exiting functions
	ret
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
