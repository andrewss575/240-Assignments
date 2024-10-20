;this program will take user input for username and then print it out

section .data
	prompt	db	"Please Enter Your Username: "
	hello	db	"Hello, "
	newline	db	"!", 10
	old_age	db	"00"
	age_prompt	db	"How old are you? (2 digit number): "
	age_response	db	"Wow, in 10 years, you will be "
	
section .bss
	username  resb	7
	age	resb	3
	
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
	
	;cout << age_prompt
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, age_prompt
	mov	rdx, 35
	syscall
	
	;cin << age
	mov	rax, 0
	mov	rdi, 0
	mov	rsi, age
	mov	rdx, 3
	syscall
	
	;converting first digit of cin into a decimal and adding it to '0'(first digit of old_age variable)
	mov al, byte[age]
	and	al, 0fh	
	inc	al
	add byte[old_age], al
	
	mov al, byte[age + 1]
	and	al, 0fh	
	add byte[old_age + 1], al
	
	
	;cout << age_response
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, age_response
	mov	rdx, 30
	syscall
	
	;cout << old_age
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, old_age
	mov	rdx, 2
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
