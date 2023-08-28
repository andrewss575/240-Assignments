; register char cl = 1;
; unsigned short sum = 0;
; do {
;	sum = sum + (cx * cx);
;	cx++;
; } while(cx <= 10);

section .data
sum	dw	0
	
section .text
	global _start
	
_start:
	mov	cl, 1			; cl = 0001h only runs once
doloop
	mov	al, cl			;al = cl
	mul 	cl			;al = cl * al = cl * cl
	
	;mov from ax bc sum is a word and we need to use a word size register
	;has same size as al
	add	word[sum], ax		;sum = sum + ax = sum + (cl * cl)
	inc	cl			;cl++
	
	cmp	cl, 10			;compare cl with 0
	jbe	doloop			;jump to doloop if cl is less than or equal to 10
	
exit:
	mov rax, 60
	mov rdi, 0
	syscall
