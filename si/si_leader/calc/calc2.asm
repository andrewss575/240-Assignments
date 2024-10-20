; (8 * 10 + ((75 - 2000) / 25)) + 1

section	.data

answer		dw	0
remainder	dw	0

section .text
	global _start
	
_start:
	;(375 - 5000)
	mov	ax, 375
	sub	ax, 5000
	sbb	dx, 0
	

	
	;ax(-1925)/25
	mov	cx, 25
	idiv	cx
	
	mov	word[answer], ax
	;move answer so far temporarily to answer variable
	mov	word[answer], ax
	
	;8 * 10
	mov	al, 8
	mov	bl, 10
	mul	bl

	
	;answer(-77 signed) + al(80 unsigned) 
	;movsz	ax, al
	add	word[answer], ax
	

	

	mov rax, 60
	mov rdi, 0
	syscall
