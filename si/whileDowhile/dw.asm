;this program uses a DO WHILE loop to add 1+2+3+4+5... until sum is greater than or equal to 200

section .data
	sum	dw	0
	
section .text
	global _start
_start:
	mov	rax, 0
	mov 	cx, 0

;this label is the only thing that changes from while to do while loop
dowhile_loop:
	inc	cx
	add	word[sum], cx
	cmp	word[sum], 200
	jle	dowhile_loop
	
end:
	mov rax, 60
	mov rdi, 0
	syscall
