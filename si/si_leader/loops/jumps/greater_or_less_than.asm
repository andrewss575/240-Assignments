;given a number, checks if its greater than 60, less than 50, or in between
section .data
	my_test		dd 	100
	greater		dd	0
	less		dd	0
	between		dd	0

section .text
	global _start
	
_start:
	mov eax, dword[my_test]
	cmp eax, 50
	jle less_than
	cmp eax, 60
	jge greater_than
	inc dword[between]
	jmp end
	
	greater_than:
		inc dword[greater]
		jmp end
	less_than:
		inc dword[less]
		
	end:
		mov rax, 60
		mov rdi, 0
		syscall
	
	
	
	

