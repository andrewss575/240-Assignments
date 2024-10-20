;this program converts a decimal number into ascii without looping

section .data
	num	dw	1234
	ascii	db	'0000'
	
section .text
	global _start
_start:
	mov ax, word[num]
	mov bx, 1000
	mov rdx, 0
	div bx
	add byte[ascii], al
	
	mov ax, dx
	mov bx, 100
	mov rdx, 0
	div bx
	add byte[ascii+1], al
	
	mov ax, dx
	mov bx, 10
	mov rdx, 0
	div bx
	add byte[ascii+2], al
	
	mov ax, dx
	mov bx, 1
	mov rdx, 0
	div bx
	add byte[ascii+3], al
	
	
end:
	mov rax, 60
	mov rdi, 0
	syscall
