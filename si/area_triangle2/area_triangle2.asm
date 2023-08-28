section .data
	
	product	dd	0		;product = 0000 0000h
	base	dw	10000		;base = 2710h
	height	dw	200		;height = 00CBHh
	area	dd	0		;area = 0000 0000h
	two	db	2		;two = 0002h

section .text
	global _start
	
_start:
	mov	ax, word[base]		;ax = base = 2710h = 10000
	mul	word[height]		;dx:ax = 001Eh:8480h
	mov	word[product], ax	;product = 8480h = 33920
	mov 	word[product + 2], dx	;product = 001E 8480h = 2000000
	mov	eax, dword[product]	;eax = product = 001E 8480h = 2000000
	mov	dx, 0			;dx = 0
	div	word[two]		;eax = 1000000
	mov	dword[area], eax
	
	mov	rax, 60
	mov	rdi, 0
	syscall
	
