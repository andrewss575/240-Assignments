section .data
	text db "My name is Jake Barton, I enjoy gaming and mecha.", 10

section .text
global _start

_start:
	mov rax, 1
	mov rdi, 1
	mov rsi, text
	mov rdx, 49
	syscall

	mov rax, 60
	mov rdi, 0
	syscall
