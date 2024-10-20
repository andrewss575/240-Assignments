section .data
	msg1	db	"This is Message 1", 10
	msg2	db	"This is Message 2", 10
	msg3	db	"This is Message 3", 10
	msg4	db	"This is Message 4", 10
	
section .text
	global _start
_start:
	mov rax, 1
	mov rdi, 1
	mov rsi, msg1
	mov rdx, 18
	syscall
	
	mov rax, 1
	mov rdi, 1
	mov rsi, msg2
	mov rdx, 18
	syscall
	
	mov rax, 1
	mov rdi, 1
	mov rsi, msg3
	mov rdx, 18
	syscall
	
	mov rax, 1
	mov rdi, 1
	mov rsi, msg4
	mov rdx, 18
	syscall
	
	mov rax, 60
	mov rdi, 0
	syscall
