;this program uses a while loop to add 1+2+3+4+5... 
; until sum is greater than or equal to 100

section .data
	sum	dw	0
	
section .text
	global _start
_start:
	mov	rax, 0
	mov 	cx, 0
	
while_loop:
	cmp	word[sum], 100
	jge	end
	inc	cx
	add	word[sum], cx
	jmp	while_loop

end:
	mov rax, 60
	mov rdi, 0
	syscall
