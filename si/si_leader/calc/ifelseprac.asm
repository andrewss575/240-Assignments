;int num = 125;
;if(num % 2 == 0) {
;cout >>””<< yes>> endl;
;}
;else{
;cout >> “” >> no >> endl
;}

section .data
num    db 125
is_even db 0
is_odd db 0
text_odd db "125 is odd", 10

section .text
	global _start

_start:

	mov al, 125
	mov cl, 2
	div cl
	cmp dh, 0
	je even_num
	inc byte[is_odd]



even_num:
	inc byte[is_even] 
	mov rax, 1
	mov rdi, 1
	mov rsi, text_odd
	mov rdx, 11
	syscall

mov rax, 60
mov rdi, 0
syscall

 
