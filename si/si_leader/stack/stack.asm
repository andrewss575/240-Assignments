section .data
numbers	dw	121, 122, 123, 124, 125

section .bss
reverse	resw	5

section .text
global _start

_start:
	mov rsi, 0
	mov rcx, 5
	
pushLoop:
	mov rax, 0
	mov ax, word[numbers + rsi]
	add rsi, 2
	push rax
	
	dec rcx
	cmp rcx, 0
	jne pushLoop
	;loop pushLoop
	
	
	mov rsi, 0
	mov rcx, 5
popLoop:
	pop rax
	mov qword[reverse + rsi], rax
	add rsi, 2
	
	dec rcx
	cmp rcx, 0
	jne popLoop
	;loop popLoop
	
end:
	mov rax, 60
	mov rdi, 0
	syscall
	
	

