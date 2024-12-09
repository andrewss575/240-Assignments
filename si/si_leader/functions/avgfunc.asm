;this program creates a function that finds the average and sum of an array of quad-word numbers
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
	mov rdi, arr
	mov rsi, qword[len]
	mov rdx, avg
	mov rcx, sum
	call stats
	
	mov rax, 60
	mov rdi, 0
	syscall
	
;**********FUNCTION******************
global stats

stats:

	mov r10, 0
sumLoop:
	add rax, qword[rdi + r10 * 8]
	inc r10
	
	cmp r10, rsi
	jne sumLoop
	
	mov qword[rcx], rax
	
	push rdx		;pushing rdx because it was orginally the address for avg variable,
				;so before we use it for division, i have to save its original value for later
	mov rdx, 0
	div rsi
	
	pop rdx			;after division, we no longer need rdx as remainder, so restore rdx to the address of avg variable
	
	mov qword[rdx], rax	
		
	ret
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
