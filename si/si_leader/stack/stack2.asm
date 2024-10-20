;this program parses through an array (numbers) and pushes each element into the stack
;it then pops each element from the stack and stores it into a new array (reverse)
;this essentially reverses the order of the original numbers array


section .data
numbers	dw	121, 122, 123, 124, 125

section .bss
reverse	resw	5

section .text
global _start

_start:
	mov rcx, 5
	mov rsi, 0
	
pushLoop:
	mov rax, qword[numbers + rsi*2]
	push rax
	inc rsi
	
	dec rcx
	cmp rcx, 0
	jne pushLoop
	
	mov rcx, 5
	mov rsi, 0
	
popLoop:
	pop rax
	mov qword[reverse + rsi*2], rax
	
	inc rsi
	
	dec rcx
	cmp rcx, 0
	jne popLoop
	
end:
	mov rax, 60
	mov rdi, 0
	syscall
	
