section .data
	num1	db	24
	num2	db	240
	diff	dw	0
	
section .text
	global _start
_start:

	mov al, byte[num1]
	sub al, byte[num2]
	sbb ah, 0
	
	mov byte[sum + 0], al
	mov byte[sum + 1], ah
	
	mov rax, 60
	mov rdi, 0
	syscall
