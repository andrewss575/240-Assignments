; 412 * 400 + (60 - 20,000) / 25

section	.data

step1		dd	0
step2		dd	0
step3		dd	0

answer		dw	0
remainder	dw	0

section .text
	global _start
	
_start:
	;(60 - 20,000)
	mov	ax, 60
	sub	ax, 20000
	sbb	dx, 0
	mov	word[step1], ax
	mov	word[step1+2], dx
	
	;412 * 400
	mov	ax, 412
	mov	di, 400
	mul	di
	mov	word[step2], ax
	mov	word[step2+2], dx
	
	;164,800 + -19,940
	mov	eax, dword[step2]
	add	eax, dword[step1]
	mov	dword[step3], eax
	
	
	
	;144860/25
	mov	rdx, 0
	mov	eax, dword[step3]
	mov	rdi, 25
	div	rdi
	
	mov	word[answer], ax
	mov	word[remainder], dx
	

	mov rax, 60
	mov rdi, 1
	syscall
