; int product = 1;
;
; for(int i = 10; i <= 1; i--){
;	product = product * i;
;
; }
; 
section .data

product		dd	10

section .text

global _start

_start:

	mov ecx, dword[product]
	mov eax, 1
forloop:
	mul ecx
	
	dec ecx
	cmp ecx, 0
	jne forloop
	
	;loop forloop
	
	mov dword[product], eax
	
	mov rax, 60
	mov rdi, 0
	syscall
	
	

