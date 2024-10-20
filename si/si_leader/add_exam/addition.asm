; byte num1 = 24
; byte num2 = 240
; sum = 0
; sum = num1 + num2

section .data

	num1	db	24
	num2	db	240
	sum	dw	0
	
section .text
	global _start
	
_start:
	mov	al, byte[num1]
	add	al, byte[num2]
	adc	ah, 0
	
	mov	word[sum], ax
	
	mov	rax, 60
	mov	rdi, 0
	syscall
