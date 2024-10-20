%macro printMsg 2
	mov rax, 1
	mov rdi, 1
	mov rsi, %1
	mov rdx, %2
	syscall
%endmacro

section .data
	msg1	db	"This is Message 1", 10
	msg2	db	"This is Message 2", 10
	msg3	db	"This is Message 3", 10
	msg4	db	"This is Message 4", 10
	
section .text
	global _start
_start:
	
	printMsg msg1, 18
	printMsg msg2, 18
	printMsg msg3, 18
	printMsg msg4, 18
	
	mov rax, 60
	mov rdi, 0
	syscall
