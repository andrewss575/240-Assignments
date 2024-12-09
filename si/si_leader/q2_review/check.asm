section .text
global _start

_start:
	mov ax, 100
	cwd
	mov cx, 3
	idiv cx
	
	mov rax, 60
	mov rdi, 0
	syscall
