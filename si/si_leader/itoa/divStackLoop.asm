;this program converts a decimal number into ascii using dividing, the stack, and looping

section .data
	num	dw	1234
section .bss
	ascii	resb	4
	
section .text
	global _start

_start:
	mov rcx, 4
	mov bx, 10
	mov ax, word[num]
	
pushLoop: 
	mov rdx, 0
	div bx
	add dl, '0'
	push rdx
	loop pushLoop
	
	mov rcx, 4
	mov rsi, 0
	
popLoop:
	pop rax
	mov byte[ascii + rsi], al
	inc rsi
	loop popLoop
	
end:
	mov rax, 60
	mov rdi, 0
	syscall
	
