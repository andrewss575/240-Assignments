
section .data

	num	dw	300
	
section .text
	global _start
	
_start:

	mov ax, word[num]
	
	mov rax, 60
	mov rdi, 0
	syscall
