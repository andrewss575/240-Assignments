;this code will convert a decimal number into decimal into ascii by 
; dividing and looping

section .data
	num	dw	1234
	ascii	db	'0000'
	
section .text
	global _start
_start:
	mov rcx, 3
	mov bx, 10
	mov ax, word[num]
divLoop:
	mov dx, 0
	div bx
	
	add byte[ascii + rcx], dl
	
	dec	rcx 
	cmp	rcx, 0 
	jge	divLoop
	
end:
	mov rax, 60
	mov rdi, 0
	syscall
	
	
