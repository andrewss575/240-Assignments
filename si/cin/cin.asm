;this program will take user input for username and then print it out

section .data
	prompt	db	"Please Enter Your Username: "
	hello	db	"Hello, "
	newline	db	"!", 10
	
section .bss
	username  resb	1
	
section .text
	global _start

_start:
	;cout << prompt
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, prompt
	mov	rdx, 28
	syscall
	
	;cin >> username
	mov	rax, 0
	mov	rdi, 0
	mov	rsi, username
	mov	rdx, 7
	syscall
	
	;cout << hello
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, hello
	mov	rdx, 7
	syscall
	
	;cout << username
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, username
	mov	rdx, 6
	syscall
	
	;cout << newline
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, newline
	mov	rdx, 2
	syscall
	
	mov	rax, 60
	mov	rdi, 0
	syscall
