; In this revised version, i changed step1 into a word because -19,940 could fit in a word, so I had to use widening convserions for step3
; After step3, instead of putting all of step3 into a double word sized register, i split them up into 2 word-sized registers, (ax and dx) so that
;  that i could divide by a word sized register/variable. It is more memory efficient
; 412 * 400 + (60 - 20,000) / 25

section	.data

step1		dw	0
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
	mov	word[step1], ax
	;-19940 could still fit a word sized register
	
	;412 * 400
	mov	ax, 412
	mov	di, 400
	mul	di
	mov	word[step2], ax
	mov	word[step2+2], dx
	
	;164,800 + -19,940
	;coverting ax to eax so we can add with a 32 bit number(step2)
	mov	ax, word[step1]
	movsx	eax, ax
	
	add	eax, dword[step2]
	mov	dword[step3], eax
	
	
	
	;144860/25
	mov	rdx, 0
	mov	ax, word[step3]
	mov	dx, word[step3 + 2]
	
	mov	di, 25
	div	di
	
	mov	word[answer], ax
	mov	word[remainder], dx
	

	mov rax, 60
	mov rdi, 0
	syscall
