section .data
	two	db	2
	odd	db	0
	even	db	0
	num	db	25
	
section .text
	global _start
	
_start:
	mov al, byte[num]
	;mov cl, 2
	div byte[two]
	cmp ah, 0
	je is_even

	inc byte[odd]
	jmp end
	
is_even:
	inc byte[even]
	
end:
	mov rax, 60
	mov rdi, 0
	syscall

