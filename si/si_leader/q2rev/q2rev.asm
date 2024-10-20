section .bss
	var	resb	3
	
section .text
	global _start

_start:
	;1 
	mov byte[var], 10
	mov byte[var+1], 11
	mov byte[var+2], 12
	
	;2
	mov rbx, var
	mov byte[rbx], 10
	mov byte[rbx+1], 11
	mov byte[rbx+2], 12
	
	;3
	mov rbx, var
	mov rcx, 0
	mov dl, 10
	
	arrLoop:
		mov byte[rbx + rcx], dl
		
		inc rdx
		
		inc rcx
		cmp rcx, 3
		jne arrLoop
	
	
	
mov rax, 60
mov rdi, 0
syscall
