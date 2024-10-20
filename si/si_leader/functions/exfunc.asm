section .data
	num	dq	0
	
section .text
	global _start
	
_start:
	mov rax, 20
	
	
	mov rdi, 5
	mov rsi, 2
	mov rdx, num
	call myFunction
	pop rdx
	
	mov rax, 60
	mov rdi, 0
	syscall
	
;**********FUNCTION******************

global myFunction

myFunction:
	push rax	;prologue
	push rdx
	
	mov rax, 100
	mul rsi
	
	add rax, rdi	
	pop rdx
	mov qword[rdx], rax
	
	pop rax		;epilogue
	ret
