
section .data

	text db "My name is Andrew, my major is computer science. I’m interested in playing game.", 10

section .text
	global _start
_start:
	mov rax, 1
	mov rdi, 1
	mov rsi, text
	mov rdx, 83
	
	syscall
	mov rax, 60
	mov rdi, 0
	syscall
