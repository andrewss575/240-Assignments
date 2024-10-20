;this program creates a function that finds the average and sum of an array of quad-word numbers
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
	mov rdi, arr
	mov rsi, qword[len]
	mov rdx, sum
	mov rcx, avg
	call stats
	
	mov rax, 60
	mov rdi, 0
	syscall
	
global stats

stats:

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
	
	ret
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
