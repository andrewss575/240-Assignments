section .data
	num1	db	200
	
section .text
	global _start
start:

	mov r15, 200
	mov rax, word[num1]
	
	mov rax, 60
	mov rdi, 0
	syscall
	
